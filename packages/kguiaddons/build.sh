TERMUX_PKG_HOMEPAGE=https://www.kde.org/
TERMUX_PKG_DESCRIPTION="The KDE GUI Add-ons"
TERMUX_PKG_LICENSE="LGPL-2.1-or-later"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=5.68.0
TERMUX_PKG_SRCURL="http://download.kde.org/stable/frameworks/${TERMUX_PKG_VERSION%.*}/${TERMUX_PKG_NAME}-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=cdbf694e92b47358c2e2c31917bf5f01382042c2cb99b65faf3bc00a0eb52c64
TERMUX_PKG_DEPENDS="qt5-qtbase, qt5-qtx11extras"
TERMUX_PKG_BUILD_DEPENDS="cmake, extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_INSTALL_PREFIX=${TERMUX_PREFIX}"

termux_step_install_license() {
    install -Dm644 "${TERMUX_PKG_SRCDIR}/LICENSES/LGPL-2.0-or-later.txt" "${TERMUX_PREFIX}/share/doc/${TERMUX_PKG_NAME}/LICENSE"
}
