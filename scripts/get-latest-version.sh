#!/bin/bash
##
##  Script for querying latest version of package.
##
##  Leonid Plyushch <leonid.plyushch@gmail.com> (C) 2019
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##

if [ -z "${1}" ]; then
    echo "Usage: check-pkg-version.sh [package 1] [package 2] ..."
    echo
    echo "This script retrieves current package version"
    echo "from https://www.archlinux.org."
    exit 1
fi

is_update_needed() {
    if [ "${1}" = "${2}" ]; then
        return 1
    fi

    local IFS=.
    local i ver1=($1) ver2=($2)

    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
        ver1[i]=0
    done

    for ((i=0; i<${#ver1[@]}; i++)); do
        if [ -z "${ver2[i]}" ]; then
            ver2[i]=0
        fi

        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi

        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 0
        fi
    done

    return 1
}

check_package() {
    local CURRENT_VERSION LATEST_VERSION PACKAGES_DIR
    PACKAGES_DIR=$(realpath "$(dirname "${0}")/../packages")

    for repo in extra community core; do
        for arch in x86_64 any; do
            LATEST_VERSION=$(curl -s "https://www.archlinux.org/packages/${repo}/${arch}/${1}/" | grep 'itemprop="version"' | cut -d'"' -f4 | cut -d- -f1 | cut -d+ -f1)
            if [ -n "${LATEST_VERSION}" ]; then
                if [ -f "${PACKAGES_DIR}/${1}/build.sh" ]; then
                    CURRENT_VERSION=$(grep 'TERMUX_PKG_VERSION=' "${PACKAGES_DIR}/${1}/build.sh" | cut -d= -f2)
                fi

                echo "Package: ${1}"

                if [ -n "${CURRENT_VERSION}" ]; then
                    if is_update_needed "${CURRENT_VERSION}" "${LATEST_VERSION}"; then
                        echo "Version: ${CURRENT_VERSION} (can be updated to ${LATEST_VERSION})"
                    else
                        echo "Version: ${CURRENT_VERSION} (latest)"
                    fi
                else
                    echo "Latest version: ${LATEST_VERSION}"
                fi

                return 0
            fi
        done
    done

    echo "[!] Cannot fetch latest version for '${1}'. Possible that"
    echo "    package is not exist in database."
    return 1
}

while true; do
    if [ ${#} -lt 1 ]; then
        break
    fi

    check_package $(basename "${1}")

    if [ ${#} -gt 1 ]; then
        echo
    fi

    shift 1
done

exit 0
