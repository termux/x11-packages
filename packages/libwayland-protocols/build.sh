TERMUX_PKG_HOMEPAGE=https://wayland.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Wayland protocols library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.21
TERMUX_PKG_SRCURL=https://wayland.freedesktop.org/releases/wayland-protocols-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=b99945842d8be18817c26ee77dafa157883af89268e15f4a5a1a1ff3ffa4cde5
TERMUX_PKG_DEPENDS="libandroid-support"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-documentation"

termux_step_pre_configure() {
export wayland_scanner="/usr/bin/wayland-acanner"
}

termux_step_post_make_install() {
	mv ${TERMUX_PREFIX}/share/pkgconfig/wayland-protocols.pc ${TERMUX_PREFIX}/lib/pkgconfig/
}
