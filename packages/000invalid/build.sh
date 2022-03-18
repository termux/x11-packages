TERMUX_PKG_HOMEPAGE=http://termux.invalid/000invalid/
TERMUX_PKG_DESCRIPTION="An invalid package for testing"
TERMUX_PKG_LICENSE="Public Domain"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_BLACKLISTED_ARCHES="i686"

termux_step_make_install() {
	mkdir -p $TERMUX_PREFIX/share/000invalid
	touch $TERMUX_PREFIX/share/000invalid/.installed
}
