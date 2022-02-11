TERMUX_PKG_HOMEPAGE=https://github.com/yshui/picom
TERMUX_PKG_DESCRIPTION="A lightweight compositor for X11"
TERMUX_PKG_LICENSE="MIT,MPL-2.0"
TERMUX_PKG_MAINTAINER="Rafael Kitover <rkitover@gmail.com>"
TERMUX_PKG_VERSION=9
TERMUX_PKG_SRCURL=https://github.com/yshui/picom/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=4fa373657a01079324456826ff68e5c319e9a8421e90c68949d4af2ce036f720
TERMUX_PKG_DEPENDS="libx11, libxcb, xcb-util, xcb-util-image, xcb-util-renderutil, libxext, xorgproto, libpixman, dbus, libconfig, mesa, pcre, libev, uthash"

termux_step_pre_configure() {
    sed -i "s/^\(host_system *= *\).*/\1'linux'/" src/meson.build
}
