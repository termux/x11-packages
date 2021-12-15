TERMUX_PKG_HOMEPAGE=https://github.com/AnGelXoG/Termux-Terminal
TERMUX_PKG_DESCRIPTION="fast and customizable terminal"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@AnGelXoG"
TERMUX_PKG_VERSION=3.5
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/AnGelXoG/Termux-Terminal/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=f3518ea9fcd5767a8ef7a73bcb64014ba0bd2e57c072350d5356c918343f7f9c
TERMUX_PKG_DEPENDS="libvte, make, cmake"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make_install() {

       make install

}
