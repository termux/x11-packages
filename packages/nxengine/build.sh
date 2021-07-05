TERMUX_PKG_HOMEPAGE=https://nxengine.sourceforge.net
TERMUX_PKG_DESCRIPTION="Open-source rewrite engine of the Cave Story for Dingux and MotoMAGX. Author - Caitlin Shaw (rogueeve), httpd://nxengine.sourceforge.net"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@Yonle"
TERMUX_PKG_VERSION=1.0.0.4
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=https://github.com/EXL/NXEngine/archive/refs/tags/v1.0.0.4-Rev4.tar.gz
TERMUX_PKG_SHA256=d467c112e81d4c56337ebf6968bd8bd781bce9140f674e72009a5274d2c15784
TERMUX_PKG_BUILD_DEPENDS="sdl, sdl-ttf"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
        make -f Makefile.linux
}

termux_step_make_install() {
	install -Dm700 $TERMUX_DIR_BUILDER_DIR/nx $TERMUX_PREFIX/bin/nx
}
