#!/bin/sh
##
##  Script for preparing & launching build environment.
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

set -e -u

SCRIPT_NAME=$(basename "$0")
REPOROOT=$(dirname "$(realpath "$0")")

IMAGE_NAME="termux/package-builder"

LOCK_FILE="/tmp/.termux-x11-builder.lck"
CONTAINER_NAME="termux-x11-buildenv-v1"
BUILD_ENVIRONMENT="termux-packages"

if [ -n "${TERMUX_DOCKER_USE_SUDO-}" ]; then
	SUDO="sudo"
else
	SUDO=""
fi

cd "$REPOROOT"

if [ ! -e "$LOCK_FILE" ]; then
	touch "$LOCK_FILE"
fi

if [ "${GITHUB_EVENT_PATH-x}" != "x" ]; then
	# On CI/CD tty may not be available.
	DOCKER_TTY=""
else
	DOCKER_TTY=" --tty"
fi

(flock -n 3 || exit 0
	$SUDO docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true

	echo "[*] Setting up repository submodules..."
	git submodule deinit --all --force
	git submodule update --init

	echo "[*] Copying packages from './packages' to build environment..."
	for pkg in $(find "$REPOROOT"/packages -mindepth 1 -maxdepth 1 -type d); do
		if [ ! -d "${REPOROOT}/${BUILD_ENVIRONMENT}/packages/$(basename "$pkg")" ]; then
			cp -a "$pkg" "${REPOROOT}/${BUILD_ENVIRONMENT}"/packages/
		else
			echo "[!] Package '$(basename "$pkg")' already exists in build environment. Skipping."
		fi
	done
) 3< "$LOCK_FILE"

(flock -n 3 || true
	echo "[*] Running container '$CONTAINER_NAME' from image '$IMAGE_NAME'..."
	if ! $SUDO docker start "$CONTAINER_NAME" > /dev/null 2>&1; then
		echo "Creating new container..."
		$SUDO docker run \
			--tty \
			--detach \
			--name "$CONTAINER_NAME" \
			--volume "${REPOROOT}/${BUILD_ENVIRONMENT}:/home/builder/termux-packages" \
			--volume "${REPOROOT}/output:/home/builder/termux-packages/output" \
			--workdir "/home/builder/termux-packages" \
			"$IMAGE_NAME"

		if [ "$(id -u)" -ne 0 ] && [ "$(id -u)" -ne 1000 ]; then
			echo "Changed builder uid/gid... (this may take a while)"
			$SUDO docker exec $DOCKER_TTY "$CONTAINER_NAME" sudo chown -R $(id -u) "/home/builder"
			$SUDO docker exec $DOCKER_TTY "$CONTAINER_NAME" sudo chown -R $(id -u) /data
			$SUDO docker exec $DOCKER_TTY "$CONTAINER_NAME" sudo usermod -u $(id -u) builder
			$SUDO docker exec $DOCKER_TTY "$CONTAINER_NAME" sudo groupmod -g $(id -g) builder
		fi
	fi

	if [ $# -ge 1 ]; then
		$SUDO docker exec --interactive $DOCKER_TTY "$CONTAINER_NAME" "$@"
	else
		$SUDO docker exec --interactive $DOCKER_TTY "$CONTAINER_NAME" bash
	fi
) 3< "$LOCK_FILE"
