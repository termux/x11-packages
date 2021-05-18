TERMUX_PKG_HOMEPAGE=https://libmatekbd.mate-desktop.dev/
TERMUX_PKG_DESCRIPTION="libmatekbd is a fork of libgnomekbd"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_VERSION=1.25.0
TERMUX_PKG_SRCURL=https://github.com/mate-desktop/libmatekbd/releases/download/v$TERMUX_PKG_VERSION/libmatekbd-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=0e0580370f29d867a11291805b2d39a0cd1951f84cda3f91cb9611f246a8e305
TERMUX_PKG_DEPENDS="glib, gtk3, libxklavier, glib-bin"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="LIBXKLAVIER=${TERMUX_PREFIX}/lib/libxklavier.so"
