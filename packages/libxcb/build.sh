TERMUX_PKG_HOMEPAGE=https://xcb.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 client-side library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com>"
TERMUX_PKG_VERSION=1.13.1
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=https://xcb.freedesktop.org/dist/libxcb-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=a89fb7af7a11f43d2ce84a844a4b38df688c092bf4b67683aef179cdf2a647c4
TERMUX_PKG_DEPENDS="libxau, libxdmcp, x11-repo (>= 1.3)"
TERMUX_PKG_BUILD_DEPENDS="xcb-proto, xorg-util-macros"
TERMUX_PKG_RECOMMENDS="xorg-xauth"
