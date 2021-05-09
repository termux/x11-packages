TERMUX_PKG_HOMEPAGE=https://www.kde.org/
TERMUX_PKG_DESCRIPTION="Syntax highlighting engine and library (KDE)"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=5.71.0
TERMUX_PKG_SRCURL="http://download.kde.org/stable/frameworks/${TERMUX_PKG_VERSION%.*}/syntax-highlighting-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=845ae0c7b8523c23c3ad704a6c551260a358d96b0094a5c2b062879e58173f84
TERMUX_PKG_DEPENDS="qt5-qtbase"
TERMUX_PKG_BUILD_DEPENDS="cmake, extra-cmake-modules, perl, qt5-qtbase-cross-tools, qt5-qttools-cross-tools, qt5-qtxmlpatterns"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DQt5_DIR=${TERMUX_PREFIX}/lib/cmake/Qt5
-DQt5Core_DIR=${TERMUX_PREFIX}/lib/cmake/Qt5Core
-DQt5LinguistTools_DIR=${TERMUX_PREFIX}/lib/cmake/Qt5LinguistTools
-DKF5_HOST_TOOLING=${TERMUX_PREFIX}/opt/qt/cross
-DKATEHIGHLIGHTINGINDEXER_EXECUTABLE=${TERMUX_PKG_SRCDIR}/host-indexer/katehighlightingindexer
"

termux_step_pre_configure() {
    cd "${TERMUX_PKG_SRCDIR}" && {
        tar xf "${TERMUX_PKG_BUILDER_DIR}/host-indexer.tar.xz"
    }
}
