TERMUX_PKG_HOMEPAGE=https://github.com/Yisus7u7/termux-pkg-manager-qt
TERMUX_PKG_DESCRIPTION="An interface for apt/pkg of termux written in C++ and Qt"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="Yisus7u7 <jesuspixel5@gmail.com>"
TERMUX_PKG_VERSION=0.1-alpha
TERMUX_PKG_SRCURL="https://github.com/Yisus7u7/termux-pkg-manager-qt/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=e4931457a98b73ac539fb39df922cc53928c23636809c38621ceffabbd5cab30
TERMUX_PKG_DEPENDS="qt5-qtbase, qt5-qtsvg"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure () {
    "${TERMUX_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${TERMUX_PREFIX}/lib/qt/mkspecs/termux-cross" \
        PREFIX="${TERMUX_PREFIX}"
}

termux_step_make_install () {
	cd ${TERMUX_PKG_SRCDIR}
        mkdir -p ${TERMUX_PREFIX}/share/applications
	install -Dm700 -t ${TERMUX_PREFIX}/bin ./termux-pkg-manager
	install -Dm700 -t ${TERMUX_PREFIX}/share/applications ./org.termux-pkg-manager-qt.desktop
}
