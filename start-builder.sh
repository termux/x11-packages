#!/bin/sh
set -e -u

SCRIPT_NAME=$(basename "$0")
REPOROOT=$(dirname "$(realpath "$0")")

IMAGE_NAME="xeffyr/termux-advanced-builder"

if [ "$SCRIPT_NAME" = "start-builder-legacy.sh" ]; then
	LOCK_FILE="/tmp/.termux-x11-builder-legacy.lck"
	CONTAINER_NAME="termux-x11-buildenv-legacy"
	BUILD_ENVIRONMENT="termux-packages-legacy"
else
	LOCK_FILE="/tmp/.termux-x11-builder.lck"
	CONTAINER_NAME="termux-x11-buildenv"
	BUILD_ENVIRONMENT="termux-packages"
fi

cd "$REPOROOT"

if [ ! -e "$LOCK_FILE" ]; then
	touch "$LOCK_FILE"
fi

(flock -n 3 || exit 0
	docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true

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
	if ! docker start "$CONTAINER_NAME" > /dev/null 2>&1; then
		echo "Creating new container..."
		docker run \
			--detach \
			--name "$CONTAINER_NAME" \
			--volume "${REPOROOT}/${BUILD_ENVIRONMENT}:/home/builder/packages" \
			--tty \
			"$IMAGE_NAME"

		if [ "$(id -u)" -ne 0 ] && [ "$(id -u)" -ne 1000 ]; then
			echo "Changed builder uid/gid... (this may take a while)"
			docker exec --tty "$CONTAINER_NAME" sudo chown -R $(id -u) "/home/builder"
			docker exec --tty "$CONTAINER_NAME" sudo chown -R $(id -u) /data
			docker exec --tty "$CONTAINER_NAME" sudo usermod -u $(id -u) builder
			docker exec --tty "$CONTAINER_NAME" sudo groupmod -g $(id -g) builder
		fi
	fi

	if [ $# -ge 1 ]; then
		docker exec --interactive --tty "$CONTAINER_NAME" "$@"
	else
		docker exec --interactive --tty "$CONTAINER_NAME" bash
	fi
) 3< "$LOCK_FILE"
