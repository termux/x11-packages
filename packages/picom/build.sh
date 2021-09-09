TERMUX_PKG_HOMEPAGE=https://github.com/yshui/picom
TERMUX_PKG_DESCRIPTION="A lightweight compositor for X11"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@Yisus7u7 <jesuspixel5@gmail.com>"
TERMUX_PKG_VERSION=8.2
TERMUX_PKG_SRCURL=https://github.com/yshui/picom/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9d0c2533985e9670ff175e717a42b5bf1a2a00ccde5cac1e1009f5d6ee7912ec
TERMUX_PKG_DEPENDS="libx11, libxcomposite, libxdamage, libxext, libxfixes, libxrender, xorgproto, xcb-proto, libconfig, libxdamage, libxcb, libxfixes, xcb-util-renderutil, libxrandr, libxcomposite, xcb-util-image, libxinerama, libpixman, dbus, pcre, libev"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS(){
	-Dopengl=false
	}
