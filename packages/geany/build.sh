TERMUX_PKG_HOMEPAGE=https://www.geany.org/
TERMUX_PKG_DESCRIPTION="Fast and lightweight IDE"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com>"
TERMUX_PKG_VERSION=1.36.0
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://download.geany.org/geany-${TERMUX_PKG_VERSION/.0}.tar.bz2
TERMUX_PKG_SHA256=9184dd3dd40b7b84fca70083284bb9dbf2ee8022bf2be066bdc36592d909d53e
TERMUX_PKG_DEPENDS="atk, fontconfig, freetype, fribidi, gdk-pixbuf, glib, gtk3, harfbuzz, libandroid-glob, libandroid-shmem, libbz2, libc++, libcairo, libffi, libgraphite, liblzma, libpixman, libpng, libuuid, libx11, libxau, libxcb, libxdmcp, libxext, libxml2, libxrender, pango, pcre, zlib"
TERMUX_PKG_RECOMMENDS="clang, make"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk3"

TERMUX_PKG_RM_AFTER_INSTALL="
share/icons/hicolor/icon-theme.cache
share/icons/Tango/icon-theme.cache
"

termux_step_pre_configure() {
	export LIBS="-landroid-glob"
}
