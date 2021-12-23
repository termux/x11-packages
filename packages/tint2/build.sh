TERMUX_PKG_HOMEPAGE=https://gitlab.com/o9000/tint2
TERMUX_PKG_DESCRIPTION="Lightweight panel, Highly customizable"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=17.0.2
TERMUX_PKG_SRCURL=https://gitlab.com/o9000/tint2/-/archive/${TERMUX_PKG_VERSION}/tint2-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=705a4505ab7a007e56d1c6dc2749ffb8eaabcc1d22f17ff2b2d29bdbeb0f28c5
TERMUX_PKG_DEPENDS="xorg-xrandr, libxinerama, libx11, xorgproto, libandroid-glob, libandroid-shmem, pango, libc++, libcairo, libcurl, libxcb, xcb-util-cursor, xcb-util-image, xcb-util-xrm, xcb-util-wm, pulseaudio, libxcomposite, libxdamage, gtk2, imlib2, libandroid-wordexp, librsvg, startup-notification, libcairo"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-shmem -landroid-wordexp"
}
