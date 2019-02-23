#!/bin/sh
set -e -u

REPOROOT=$(dirname "$(realpath "$0")")
LOCKFILE="/tmp/.termux-x11-builder.lck"

IMAGE_NAME="xeffyr/termux-extra-packages-builder"
: ${CONTAINER_NAME:=termux-x11-packages-builder}

cd "$REPOROOT"

if [ ! -e "$LOCKFILE" ]; then
	touch "$LOCKFILE"
fi

if [ ! -e "$REPOROOT/termux-packages/build-package.sh" ]; then
	echo "[*] Setting up repository submodules..."
	git submodule update --init
else
	(flock -n 3 || exit 0
		(cd "$REPOROOT"/termux-packages && git clean -fdxq && git checkout -- .)
		(cd "$REPOROOT"/unstable-packages && git clean -fdxq && git checkout -- .)

		echo "[*] Copying packages from './packages' to build environment..."
		for pkg in "$REPOROOT"/packages/*; do
			if [ ! -d "$REPOROOT/termux-packages/packages/$(basename "$pkg")" ]; then
				cp -a "$pkg" "$REPOROOT"/termux-packages/packages/
			else
				echo "[!] Package '$(basename "$pkg")' already exists in build environment. Skipping."
			fi
		done

		echo "[*] Copying packages from './unstable-packages/packages' to build environment..."
		for pkg in "$REPOROOT"/unstable-packages/packages/*; do
			if [ ! -d "$REPOROOT/termux-packages/packages/$(basename "$pkg")" ]; then
				cp -a "$pkg" "$REPOROOT"/termux-packages/packages/
			else
				echo "[!] Package '$(basename "$pkg")' already exists in build environment. Skipping."
			fi
		done
	) 3< "$LOCKFILE"
fi

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
			docker exec --tty "$CONTAINER_NAME" chown -R $(id -u) "/home/builder"
			docker exec --tty "$CONTAINER_NAME" chown -R $(id -u) /data
			docker exec --tty "$CONTAINER_NAME" usermod -u $(id -u) builder
			docker exec --tty "$CONTAINER_NAME" groupmod -g $(id -g) builder
		fi
	fi

	if [ $# -ge 1 ]; then
		docker exec --interactive --tty "$CONTAINER_NAME" "$@"
	else
		docker exec --interactive --tty "$CONTAINER_NAME" bash
	fi
) 3< "$LOCKFILE"
