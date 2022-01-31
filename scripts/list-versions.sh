#!/usr/bin/env bash
##
##  Script for listing versions of local packages.
##
##  Copyright 2019 Fredrik Fornwall <fredrik@fornwall.net>
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##    http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##

REPO_ROOT=$(realpath "$(dirname "$0")/../")

check_package() { # path
	local path=$1
	local pkg=$(basename $path)
	TERMUX_PKG_REVISION=0
	TERMUX_ARCH=aarch64
	. $path/build.sh
	if [ "$TERMUX_PKG_REVISION" != "0" ] || [ "$TERMUX_PKG_VERSION" != "${TERMUX_PKG_VERSION/-/}" ]; then
		TERMUX_PKG_VERSION+="-$TERMUX_PKG_REVISION"
	fi
	echo "$pkg=$TERMUX_PKG_VERSION"
}

for path in "$REPO_ROOT"/packages/*; do
(
	check_package $path
)
done
