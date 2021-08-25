TERMUX_PKG_HOMEPAGE=https://www.lysator.liu.se/~marcus/amiwm.html
TERMUX_PKG_DESCRIPTION="Amiga Workbench inspired WM for Xorg."
TERMUX_PKG_LICENSE="non-free"
TERMUX_PKG_LICENSE_FILE="LICENSE.md"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=20170804
TERMUX_PKG_SRCURL=https://github.com/redsPL/amiwm/archive/8e0948ca983ae15145b255c3f60ca2ba1b6ccea2.zip
TERMUX_PKG_SHA256=97d5685ccb3ffe7ff24e44e4a29f322b8c73415b6351b6e13c6fad933e5d44f9
TERMUX_PKG_DEPENDS="libice, libsm, libx11, libxext, libxmu"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	CC="$CC $LDFLAGS"
	TERMUX_MAKE_PROCESSES=1
}
