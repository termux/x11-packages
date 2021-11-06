TERMUX_PKG_HOMEPAGE=https://github.com/lite-xl/lite-xl
TERMUX_PKG_DESCRIPTION="A lightweight text editor written in Lua"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@leapofazzam123"
TERMUX_PKG_VERSION=2.0.3
TERMUX_PKG_SRCURL="https://github.com/lite-xl/lite-xl/archive/refs/tags/v$TERMUX_PKG_VERSION.tar.gz"
TERMUX_PKG_SHA256=6c8a4ea284f102f772e3aff583236e89d5b1171664526dd501000b681ae5c4e2
TERMUX_PKG_DEPENDS="ndk-sysroot, sdl2, freetype, liblua52"

termux_step_pre_configure() {
	# fix meson not detecting librt
	cp $TERMUX_PREFIX/lib/librt.so $TERMUX_PREFIX/lib/librt.so.bak
	echo 'INPUT(-lc)' > $TERMUX_PREFIX/lib/librt.so
}

termux_step_post_configure() {
	mv $TERMUX_PREFIX/lib/librt.so.bak $TERMUX_PREFIX/lib/librt.so
}
