#!/bin/bash
set -e

if [ "$(id -u)" != "0" ]; then
    echo
    echo "Without root, this script won't be able to install needed software."
    echo
    exit 1
fi

## Log to stdout by default
[ -z "${SETUP_LOG_FILE}" ] && SETUP_LOG_FILE=/proc/self/fd/1

PACKAGES=""

## for adwaita-icon-theme
PACKAGES="${PACKAGES} gnome-common gtk-3-examples libgtk-3-bin"

## for libgtk2, libgtk3
PACKAGES="${PACKAGES} gtk-doc-tools libgdk-pixbuf2.0-dev"

## for python-based packages (e.g. python2-xlib)
PACKAGES="${PACKAGES} python-pip python3-pip"

## for 'xorg-fonts-75dpi', 'xorg-fonts-100dpi'
PACKAGES="${PACKAGES} xfonts-utils"

echo "[*] Updating system software..."
apt update --quiet >> "${SETUP_LOG_FILE}" 2>&1
apt upgrade --yes --quiet >> "${SETUP_LOG_FILE}" 2>&1

echo "[*] Installing additional software..."
apt install --yes --quiet ${PACKAGES} >> "${SETUP_LOG_FILE}" 2>&1
