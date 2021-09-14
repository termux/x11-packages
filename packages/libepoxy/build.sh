TERMUX_PKG_HOMEPAGE=https://github.com/anholt/libepoxy
TERMUX_PKG_DESCRIPTION="Library handling OpenGL function pointer management"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.5.9
TERMUX_PKG_SRCURL=https://github.com/anholt/libepoxy/releases/download/${TERMUX_PKG_VERSION}/libepoxy-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d168a19a6edfdd9977fef1308ccf516079856a4275cf876de688fb7927e365e4
TERMUX_PKG_DEPENDS="mesa"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dglx=yes
-Degl=yes
-Dx11=true
-Dtests=false
"
