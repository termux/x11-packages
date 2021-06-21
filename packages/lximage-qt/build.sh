TERMUX_PKG_HOMEPAGE=https://lxqt.github.io
TERMUX_PKG_DESCRIPTION="LXQt Image Viewer"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=0.17.0
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL="https://github.com/lxqt/lximage-qt/releases/download/${TERMUX_PKG_VERSION}/lximage-qt-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=2e284f3f42506d5b6df6091982d24e1dc41c99c838037939844f70d703d1d03c
TERMUX_PKG_DEPENDS="qt5-qtbase, qt5-qtx11extras, qt5-qtsvg, libfm-qt, libexif, libxfixes"
TERMUX_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
