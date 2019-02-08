#!/bin/sh
set -e -u

HOME=/home/builder
USER=builder
REPOROOT=$(dirname "$(realpath "$0")")

IMAGE_NAME="xeffyr/termux-extra-packages-builder"
: ${CONTAINER_NAME:=termux-x11-packages-builder}

cd "$REPOROOT"

echo "[*] Setting up repository submodules..."
git submodule deinit --all --force
git submodule update --init --recursive

echo "[*] Copying packages to the build environment..."
cp -a ./packages/* ./termux-packages/packages/

echo "[*] Running container '$CONTAINER_NAME' from image '$IMAGE_NAME'..."
docker start "$CONTAINER_NAME" > /dev/null 2> /dev/null || {
    echo "Creating new container..."
    docker run \
        --detach \
        --env HOME="$HOME" \
        --name "$CONTAINER_NAME" \
        --volume "$REPOROOT/termux-packages:$HOME/packages" \
        --tty \
        "$IMAGE_NAME"
    if [ $(id -u) -ne 1000 ] && [ $(id -u) -ne 0 ]; then
        echo "Changed builder uid/gid... (this may take a while)"
        docker exec --tty "$CONTAINER_NAME" chown -R $(id -u) "$HOME"
        docker exec --tty "$CONTAINER_NAME" chown -R $(id -u) /data
        docker exec --tty "$CONTAINER_NAME" usermod -u $(id -u) builder
        docker exec --tty "$CONTAINER_NAME" groupmod -g $(id -g) builder
    fi
}

if [ $# -ge 1 ]; then
    docker exec --interactive --tty --user "$USER" "$CONTAINER_NAME" "$@"
else
    docker exec --interactive --tty --user "$USER" "$CONTAINER_NAME" bash
fi
