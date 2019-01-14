#!/bin/bash
##
##  Small utility for retrieving SHA-256 for specific package.
##

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
REPO_DIR=$(dirname "$SCRIPT_DIR")

cd "$REPO_DIR" || {
    echo "[!] Can't cd to $REPO_DIR."
    exit 1
}

if [ "$#" = 0 ]; then
    echo "Usage: get-sha256.sh [package name]"
    exit 1
fi

BUILD_SCRIPT_PATH="$REPO_DIR/packages/$1/build.sh"

if [ ! -f "$BUILD_SCRIPT_PATH" ]; then
    echo "[!] Can't find build.sh for '$1'."
    exit 1
fi

. "$BUILD_SCRIPT_PATH"

if [ -z "$TERMUX_PKG_SRCURL" ]; then
    echo "[!] No source URLs defined for '$1'."
    exit 1
fi

SOURCE_URLS=(${TERMUX_PKG_SRCURL[@]})
for i in $(seq 0 $(( ${#SOURCE_URLS[@]}-1 ))); do
    SHA256=$(curl --silent --location "${SOURCE_URLS[i]}" | sha256sum - | awk '{ print $1 }')
    echo "$SHA256"
done
