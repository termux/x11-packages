TERMUX_PKG_HOMEPAGE=https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
TERMUX_PKG_DESCRIPTION="Papirus is a free and open source icon theme, based on Paper Icon Set"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=20220101
TERMUX_PKG_SRCURL=https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/refs/tags/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=98a2880a9f841c022c0db590456428a99ae93a4facc59da25f71e73e4d3f6479
TERMUX_PKG_DEPENDS="hicolor-icon-theme"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_NO_SHEBANG_FIX=true
TERMUX_PKG_RM_AFTER_INSTALL="
share/icons/ePapirus
share/icons/ePapirus-Dark
share/icons/Papirus-Light
"
