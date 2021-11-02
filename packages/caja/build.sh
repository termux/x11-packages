TERMUX_PKG_HOMEPAGE=https://caja.mate-desktop.dev/
TERMUX_PKG_DESCRIPTION="Caja, the file manager for the MATE desktop"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="Yisus7u7 <jesuspixel5@gmail.com>"
TERMUX_PKG_VERSION=1.24.0
TERMUX_PKG_SRCURL=http://deb.debian.org/debian/pool/main/c/caja/caja_$TERMUX_PKG_VERSION.orig.tar.xz
TERMUX_PKG_SHA256=7a176433f514127556bdbf31af694125a0a3dc7d4053888dd8da3e47c2d45652
TERMUX_PKG_DEPENDS="dconf, gtk3, desktop-file-utils, atk, libcairo, librsvg, libpng, glib, mate-common, libnotify, pango, libxml2, shared-mime-info, libexif"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-introspection=no"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_RM_AFTER_INSTALL="share/glib-2.0/schemas/gschemas.compiled"

termux_step_pre_configure(){
  ./autogen.sh
}

