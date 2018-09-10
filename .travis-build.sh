#!/bin/bash
set -o nounset

## Change this if you want to build packages to different architecture.
TARGET_ARCHITECTURE="aarch64"

##############################################################################

BUILD_LOG_FILE="termux-build.log"
SETUP_LOG_FILE="setup-build-environment.log"
BUILD_FINISHED_CONTROL_FILE="/tmp/.build-finished"
PACKAGES_ARCHIVE_FILE="termux-extra-packages_${TARGET_ARCHITECTURE}.tar"

## Print message every 5 minutes.
timed_message() {
    local MESSAGE_DELAY=300

    while true; do
        sleep "${MESSAGE_DELAY}" && {
            if [ -e "${BUILD_FINISHED_CONTROL_FILE}" ]; then
                break
            fi
            echo "[*] build in progress..."
        }
    done
}

if [ ! -e "./termux-packages/.initialized" ]; then
    echo -n "[*] Initializing git submodules (termux/termux-packages.git)... "
    if git submodule update --init --recursive > /dev/null 2>&1; then
        echo "ok"
    else
        echo "fail"
        exit 1
    fi

    echo -n "[*] Copying extra packages to build environment... "
    if cp -a ./packages/* ./packages-x11/* ./termux-packages/packages/ > /dev/null 2>&1; then
        echo "ok"
    else
        echo "fail"
        exit 1
    fi

	touch ./termux-packages/.initialized
fi

echo "[*] Preparing build environment..."
cd ./termux-packages || exit 1

if [ ! -e "./setup-build-environment.sh" ]; then
    if ! cp ../setup-build-environment.sh ./ > /dev/null 2>&1; then
        echo "[!] Failed to copy setup script to build environment."
        exit 1
    fi
    if ! ./scripts/run-docker.sh sudo env SETUP_LOG_FILE="${SETUP_LOG_FILE}" ./setup-build-environment.sh; then
        echo "[!] Setup script failed."
        exit 1
    fi
fi

echo
echo "PACKAGE BUILD STARTED: ${1}"
echo

## Travis requires that something should be printed
## at least once per 10 minutes otherwise build will
## be stopped.
timed_message &

## Travis has limit on log size so we should reduce output logs
## as much as possible and print log only when necessary.
if ./scripts/run-docker.sh ./build-package.sh -a "${TARGET_ARCHITECTURE}" "${1}" >> "${BUILD_LOG_FILE}" 2>&1; then
    touch "${BUILD_FINISHED_CONTROL_FILE}"
    echo
    echo "BUILD FINISHED SUCCESSFULLY"
    echo
else
    touch "${BUILD_FINISHED_CONTROL_FILE}"
    echo
    echo "BUILD FAILED"
    echo
    echo "Last 1000 lines of build log:"
    tail -n 1000 "${BUILD_LOG_FILE}"
    echo
    exit 1
fi

##
## The following two steps will create archive with
## package and all dependencies and upload it to the
## cloud so package can be installed on real device.
##
## Note, that log files are attached too.
##
echo -n "[*] Archiving built packages... "
if tar -cvf "${PACKAGES_ARCHIVE_FILE}" debs "${BUILD_LOG_FILE}" "${SETUP_LOG_FILE}" > /dev/null 2>&1; then
    echo "ok"
else
    echo "fail"
    echo "[!] Compiled binaries will not be available."
    echo
    echo "    However, since build was successfull, exiting"
    echo "    with status 0 (success)."
    echo
    exit 0
fi

echo -n "[*] Uploading archive... "
if RESULT_URL=$(curl --silent --upload-file "${PACKAGES_ARCHIVE_FILE}" https://transfer.sh/) > /dev/null 2>&1; then
    echo "ok"
    echo
    echo "Your packages were uploaded to: ${RESULT_URL}"
    echo
    exit 0
else
    echo "[!] Failed to upload packages."
    echo
    echo "    However, since build was successfull, exiting"
    echo "    with status 0 (success)."
    echo
    exit 0
fi
