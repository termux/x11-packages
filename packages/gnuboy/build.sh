TERMUX_PKG_HOMEPAGE=https://github.com/AlexOberhofer/SDL2-GNUBoy.git
TERMUX_PKG_DESCRIPTION="Emulator Gameboy and Gameboy Color Emulator"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@Toxic"
TERMUX_PKG_VERSION=1.2.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/AlexOberhofer/SDL2-GNUBoy/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=cf854aadc4d57e35b1ffce1f032f8b94dfb15c45a720457601a4c422e28f0020
TERMUX_PKG_DEPENDS="sdl2"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
        make linux -j $TERMUX_MAKE_PROCESSES -f Makefile.linux
}

termux_step_make_install() {
        install -Dm700 -t $TERMUX_PREFIX/bin ./sdl2gnuboy
}
