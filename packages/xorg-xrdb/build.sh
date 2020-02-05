TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X server resource database utility"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com>"
TERMUX_PKG_VERSION=1.2.0
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=https://www.x.org/archive/individual/app/xrdb-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=f23a65cfa1f7126040d68b6cf1e4567523edac10f8dc06f23d840d330c7c6946
TERMUX_PKG_DEPENDS="libx11, libxmu"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-cpp=$TERMUX_PREFIX/bin/cpp"
