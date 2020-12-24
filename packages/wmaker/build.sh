TERMUX_PKG_HOMEPAGE=https://www.windowmaker.org/
TERMUX_PKG_DESCRIPTION="An X11 window manager that reproduces the look and feel of the NeXTSTEP user interface"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=0.95.9
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/window-maker/wmaker/releases/download/wmaker-${TERMUX_PKG_VERSION}/WindowMaker-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=f22358ff60301670e1e2b502faad0f2da7ff8976632d538f95fe4638e9c6b714
TERMUX_PKG_DEPENDS="libandroid-shmem, libxmu, libxft, pango, libtiff, giflib, libxpm, libexif, libwebp, imagemagick"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-pango
--x-includes=${TERMUX_PREFIX}/include
--x-libraries=${TERMUX_PREFIX}/lib"

termux_step_pre_configure() {
	export LIBS="-Wl,--no-as-needed -landroid-shmem"
}
