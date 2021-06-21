TERMUX_PKG_HOMEPAGE=https://lxqt.github.io
TERMUX_PKG_DESCRIPTION="Qt 5 implementation of freedesktop.org XDG specifications"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=3.7.1
TERMUX_PKG_REVISION=6
TERMUX_PKG_SRCURL="https://github.com/lxqt/libqtxdg/releases/download/${TERMUX_PKG_VERSION}/libqtxdg-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=477cbe76b3305071ff5f5bfa31dbcddcc51f3434b9ed75d91988219296d88a9b
TERMUX_PKG_DEPENDS="qt5-qtbase, qt5-qtsvg, glib"
TERMUX_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qttools-cross-tools"

