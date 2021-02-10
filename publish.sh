#!/bin/sh
SCRIPT_NAME=$(basename "$0")
REPOROOT=$(dirname "$(realpath "$0")")

if [ "$(id -un | base64 | sha256sum -)" != "10f416799646d12ec6a4f2a7ab92840a225e0eab4745489b6d306f3330d44fac  -" ]; then
	echo
	echo "This script intended to be used by repository owner (@xeffyr). It may not work for you..."
	echo
fi

exec "$REPOROOT/scripts/bin/publish-repo"
