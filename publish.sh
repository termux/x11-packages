#!/bin/sh
SCRIPT_NAME=$(basename "$0")
REPOROOT=$(dirname "$(realpath "$0")")

echo
echo "Warning: this script is fine-tuned for repository setup by @xeffyr. It may not work for you."
echo

exec "$REPOROOT/scripts/bin/publish-repo"
