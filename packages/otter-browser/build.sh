TERMUX_PKG_HOMEPAGE=https://otter-browser.org
TERMUX_PKG_DESCRIPTION="Web browser with aspects of Opera (12.x)"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=1.0.02
TERMUX_PKG_REVISION=7
TERMUX_PKG_SRCURL="https://github.com/OtterBrowser/otter-browser/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=d1e090a80fa736cd128f594184817078a08cac31614e85e7838ff1b64511d62d
TERMUX_PKG_DEPENDS="libicu, libsqlite, qt5-qtbase, qt5-qtsvg, qt5-qtxmlpatterns, qt5-qtwebkit, qt5-qtmultimedia, hunspell"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_QTWEBENGINE=OFF -DENABLE_QTWEBKIT=ON -DENABLE_CRASHREPORTS=OFF -DENABLE_SPELLCHECK=ON"

# qt5-qtwebkit is not available for i686
TERMUX_PKG_BLACKLISTED_ARCHES="i686"
