#!/usr/bin/env bash

set -e -u

REPO_DIR=$(realpath "$(dirname "$0")/../")
PACKAGES_DIR="$REPO_DIR/packages"

lint_package() {
	local package_script
	local package_name

	package_script=$1
	package_name=$(basename "$(dirname "$package_script")")

	echo "================================================================"
	echo
	echo "Package: $package_name"
	echo -n "Syntax: "

	local syntax_errors
	syntax_errors=$(bash -n "$package_script" 2>&1)

	if [ -n "$syntax_errors" ]; then
		echo "failed"
		echo
		echo "$syntax_errors"
		echo

		return 1
	else
		echo "OK"
	fi

	echo
}

for package_script in "$PACKAGES_DIR"/*/build.sh; do
	lint_package "$package_script" || exit 1
done
