TERMUX_PKG_HOMEPAGE="https://github.com/venam/2bwm"
TERMUX_PKG_DESCRIPTION="A fast floating WM written over the XCB library and derived from mcwm."
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="Yisus7u7 <yisus7u7v@gmail.com>"
TERMUX_PKG_VERSION=0.3
TERMUX_PKG_SRCURL="https://github.com/venam/2bwm/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="a4889ea4b01b1a3d4a508daa034b9d86676913cbbca1f977858df692a6e2af95"
TERMUX_PKG_DEPENDS="libx11, libxcb, libxkbcommon, xcb-util, xcb-util-cursor, xcb-util-keysyms, xcb-util-wm, xcb-util-xrm, xcb-util-renderutil, xcb-util-image, xorgproto"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make(){
	cd ${TERMUX_PKG_SRCDIR}
	make
}

termux_step_make_install(){
	install -Dm700 -t ${TERMUX_PREFIX}/bin ./2bwm
}
