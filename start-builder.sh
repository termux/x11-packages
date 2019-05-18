#!/bin/sh
set -e -u

REPOROOT=$(dirname "$(realpath "$0")")
LOCKFILE="/tmp/.termux-x11_24-builder.lck"

IMAGE_NAME="xeffyr/termux-advanced-builder"
: ${CONTAINER_NAME:=termux-x11_24-packages-builder}

cd "$REPOROOT"

if [ ! -e "$LOCKFILE" ]; then
	touch "$LOCKFILE"
fi

(flock -n 3 || exit 0
	docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true

	echo "[*] Setting up repository submodules..."
	git submodule deinit --all --force
	git submodule update --init

	echo "[*] Copying packages from './packages' to build environment..."
	for pkg in $(find "$REPOROOT"/packages -mindepth 1 -maxdepth 1 -type d); do
		if [ ! -d "$REPOROOT/termux-packages/packages/$(basename "$pkg")" ]; then
			cp -a "$pkg" "$REPOROOT"/termux-packages/packages/
		else
			echo "[!] Package '$(basename "$pkg")' already exists in build environment. Skipping."
		fi
	done
) 3< "$LOCKFILE"

(flock -n 3 || true
	echo "[*] Running container '$CONTAINER_NAME' from image '$IMAGE_NAME'..."
	if ! docker start "$CONTAINER_NAME" > /dev/null 2>&1; then
		echo "Creating new container..."
		docker run \
			--detach \
			--name "$CONTAINER_NAME" \
			--volume "$REPOROOT/termux-packages:/home/builder/packages" \
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
) 3< "$LOCKFILE"
