#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
REPO_DIR=$(dirname "$SCRIPT_DIR")
DEBS_DIR="$REPO_DIR/deb-packages"
cd "$REPO_DIR" || {
    echo "[!] Failed to cd into '$REPO_DIR'."
    exit 1
}

## Verify that script is running under CI (GitLab).
if [ -z "${CI_COMMIT_BEFORE_SHA}" ]; then
    echo "[!] CI_COMMIT_BEFORE_SHA is not set !"
    exit 1
fi
if [ -z "${CI_COMMIT_SHA}" ]; then
    echo "[!] CI_COMMIT_SHA is not set !"
    exit 1
fi

## Check for updated files and determine if they are part of packages.
if [ "$CI_COMMIT_BEFORE_SHA" = "0000000000000000000000000000000000000000" ]; then
    UPDATED_FILES=$(git diff-tree --no-commit-id --name-only -r "${CI_COMMIT_SHA}" | grep -P "packages/")
else
    UPDATED_FILES=$(git diff-tree --no-commit-id --name-only -r "${CI_COMMIT_BEFORE_SHA}..${CI_COMMIT_SHA}" | grep -P "packages/")
fi
if [ -z "$UPDATED_FILES" ]; then
    echo "[*] No packages changed."
    echo "[*] Finishing with status 'OK'."
    exit 0
fi

## Determine package directories.
PACKAGE_DIRS=$(echo "$UPDATED_FILES" | grep -oP "packages/[a-z0-9+.-]+" | sort | uniq)
if [ -z "$PACKAGE_DIRS" ]; then
    echo "[!] Failed to determine updated packages."
    echo "    Perhaps, script failed ?"
    exit 1
fi

## Filter directories to include only ones that actually exist.
existing_dirs=""
for dir in $PACKAGE_DIRS; do
    if [ -d "$REPO_DIR/$dir" ]; then
        existing_dirs+=" $dir"
    fi
done
PACKAGE_DIRS="$existing_dirs"
unset dir existing_dirs

## Determine package names.
PACKAGE_NAMES=$(echo "$PACKAGE_DIRS" | sed 's/packages\///g')
if [ -z "$PACKAGE_NAMES" ]; then
    echo "[!] Failed to determine package names."
    echo "    Perhaps, script failed ?"
    exit 1
fi

"$REPO_DIR/scripts/bintray-add-package.py" --path "$DEBS_DIR" $PACKAGE_NAMES
