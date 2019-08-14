#!/bin/bash
##
##  Determine modified packages and build/upload them.
##

set -e

## Some packages should be excluded from auto builds.
EXCLUDED_PACKAGES=""

## Some packages are unsupported on Android 5/6.
ANDROID5_EXCLUDED_PACKAGES=""

###############################################################################
##
##  Determining changes.
##
###############################################################################

set +e

REPO_DIR=$(realpath "$(dirname "$(realpath "$0")")/../")
cd "$REPO_DIR" || {
	echo "[!] Failed to cd into '$REPO_DIR'."
	exit 1
}

DO_UPLOAD=false
if [ $# -ge 1 ]; then
	if [ "$1" = "--upload" ]; then
		DO_UPLOAD=true
	fi
fi

if [ "$LEGACY_ANDROID" = "true" ]; then
	BUILD_ENVIRONMENT="termux-packages-legacy"
	EXCLUDED_PACKAGES+=" $ANDROID5_EXCLUDED_PACKAGES"
	echo "[*] Target OS: Android 5 (API level 21)"
else
	BUILD_ENVIRONMENT="termux-packages"
	echo "[*] Target OS: Android 7 (API level 24)"
fi

# Some environment variables are important for correct functionality
# of this script.
if [ -z "$CIRRUS_CHANGE_IN_REPO" ]; then
	echo "[!] CIRRUS_CHANGE_IN_REPO is not set."
	exit 1
fi

if [ -n "$CIRRUS_PR" ] && [ -z "$CIRRUS_BASE_SHA" ]; then
	echo "[!] CIRRUS_BASE_SHA is not set."
	exit 1
fi

# Process tag '%ci:no-build' that may be added as line to commit message.
# Will force CI to exit with status 'passed' without performing build.
if grep -qiP '^\s*%ci:no-build\s*$' <(git log --format="%B" -n 1 "$CIRRUS_CHANGE_IN_REPO"); then
	echo "[!] Exiting with status 'passed' (tag '%ci:no-build' applied)."
	exit 0
fi

# Process tag '%ci:reset-backlog' that may be added as line to commit message.
# Will force CI to build changes only for the current commit.
if grep -qiP '^\s*%ci:reset-backlog\s*$' <(git log --format="%B" -n 1 "$CIRRUS_CHANGE_IN_REPO"); then
	echo "[!] Building only last pushed commit (tag '%ci:reset-backlog' applied)."
	unset CIRRUS_LAST_GREEN_CHANGE
	unset CIRRUS_BASE_SHA
fi

if [ -z "$CIRRUS_PR" ]; then
	# Changes determined from the last commit where CI finished with status
	# 'passed' (green) and the top commit.
	if [ -z "$CIRRUS_LAST_GREEN_CHANGE" ]; then
		GIT_CHANGES="$CIRRUS_CHANGE_IN_REPO"
	else
		GIT_CHANGES="${CIRRUS_LAST_GREEN_CHANGE}..${CIRRUS_CHANGE_IN_REPO}"
	fi
	echo "[*] Changes: $GIT_CHANGES"
else
	# Changes in pull request are determined from commits between the
	# top commit of base branch and latest commit of PR's branch.
	GIT_CHANGES="${CIRRUS_BASE_SHA}..${CIRRUS_CHANGE_IN_REPO}"
	echo "[*] Pull request: https://github.com/termux/termux-packages/pull/${CIRRUS_PR}"
fi

# Determine changes from commit range.
CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r "$GIT_CHANGES" 2>/dev/null)

# Modified packages.
PACKAGE_NAMES=$(sed -nE 's@^packages/([^/]*)/build.sh@\1@p' <<< "$CHANGED_FILES")
unset CHANGED_FILES

## Filter deleted packages.
for pkg in $PACKAGE_NAMES; do
	if [ ! -d "${REPO_DIR}/packages/${pkg}" ]; then
		PACKAGE_NAMES=$(sed -E "s/(^|\s\s*)${pkg}(\$|\s\s*)/ /g" <<< "$PACKAGE_NAMES")
	fi
done

## Filter excluded packages.
for pkg in $EXCLUDED_PACKAGES; do
	PACKAGE_NAMES=$(sed -E "s/(^|\s\s*)${pkg}(\$|\s\s*)/ /g" <<< "$PACKAGE_NAMES")
done
unset pkg

set -e

###############################################################################
##
##  Building packages.
##
###############################################################################

if [ -n "$EXCLUDED_PACKAGES" ]; then
	echo "[*] Excluded packages:" $EXCLUDED_PACKAGES
fi

if [ -z "$PACKAGE_NAMES" ]; then
	echo "[*] No modified packages detected."
	exit 0
else
	echo "[*] Modified packages:" $PACKAGE_NAMES
fi

if ! $DO_UPLOAD; then
	echo "[*] Copying packages to build environment:"
	for pkg in "${REPO_DIR}"/packages/*; do
		if [ ! -e "${REPO_DIR}/${BUILD_ENVIRONMENT}/packages/$(basename "$pkg")" ]; then
			echo "    - $(basename "$pkg")"
			cp -a "$pkg" "${REPO_DIR}/${BUILD_ENVIRONMENT}"/packages/
		else
			echo "    - $(basename "$pkg"): package already exist, skipping"
		fi
	done

	cd "${REPO_DIR}/${BUILD_ENVIRONMENT}" || {
		echo "[!] Failed to cd into '${REPO_DIR}/${BUILD_ENVIRONMENT}'."
		exit 1
	}

	for pkg in $PACKAGE_NAMES; do
		echo
		./build-package.sh -a "$TERMUX_ARCH" -I "$pkg"
	done
fi

###############################################################################
##
##  Uploading.
##
###############################################################################

if [ "$CIRRUS_BRANCH" = "master" ]; then
	if ! $DO_UPLOAD; then
		if [ "$LEGACY_ANDROID" = "true" ]; then
			ARCHIVE_NAME="debs-legacy-${TERMUX_ARCH}-${CIRRUS_CHANGE_IN_REPO}.tar.gz"
		else
			ARCHIVE_NAME="debs-${TERMUX_ARCH}-${CIRRUS_CHANGE_IN_REPO}.tar.gz"
		fi

		if [ -d "${REPO_DIR}/${BUILD_ENVIRONMENT}/debs" ]; then
			echo "[*] Archiving packages into '${ARCHIVE_NAME}'."
			tar zcf "$ARCHIVE_NAME" debs

			echo "[*] Uploading '${ARCHIVE_NAME}' to cache:"
			echo
			curl --upload-file "$ARCHIVE_NAME" \
				"http://$CIRRUS_HTTP_CACHE_HOST/${ARCHIVE_NAME}"
			echo
		fi
	else
		for arch in aarch64 arm i686 x86_64; do
			if [ "$LEGACY_ANDROID" = "true" ]; then
				ARCHIVE_NAME="debs-legacy-${arch}-${CIRRUS_CHANGE_IN_REPO}.tar.gz"
			else
				ARCHIVE_NAME="debs-${arch}-${CIRRUS_CHANGE_IN_REPO}.tar.gz"
			fi

			echo "[*] Downloading '$ARCHIVE_NAME' from cache:"
			echo
			curl --output "/tmp/${ARCHIVE_NAME}" \
				"http://$CIRRUS_HTTP_CACHE_HOST/${ARCHIVE_NAME}"
			echo

			if [ -s "/tmp/${ARCHIVE_NAME}" ]; then
				echo "[*] Unpacking '/tmp/${ARCHIVE_NAME}':"
				echo
				tar xvf "/tmp/${ARCHIVE_NAME}"
				echo
			else
				echo "[!] Empty archive '/tmp/${ARCHIVE_NAME}'."
			fi
		done

		echo "[*] Uploading packages to Bintray:"
		echo
		if [ "$LEGACY_ANDROID" = "true" ]; then
			"${REPO_DIR}/scripts/package_uploader_legacy.sh" -p "${PWD}/debs" $PACKAGE_NAMES
		else
			"${REPO_DIR}/scripts/package_uploader.sh" -p "${PWD}/debs" $PACKAGE_NAMES
		fi
	fi
fi
