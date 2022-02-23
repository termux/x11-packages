TERMUX_PKG_HOMEPAGE=http://freeglut.sourceforge.net/
TERMUX_PKG_DESCRIPTION="Provides functionality for small OpenGL programs"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.2.2
TERMUX_PKG_REVISION=15
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/freeglut/freeglut-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=c5944a082df0bba96b5756dddb1f75d0cd72ce27b5395c6c1dde85c2ff297a50
TERMUX_PKG_DEPENDS="glu, libxi, libxrandr, mesa"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
