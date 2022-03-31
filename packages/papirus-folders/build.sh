TERMUX_PKG_HOMEPAGE=https://github.com/PapirusDevelopmentTeam/papirus-folders
TERMUX_PKG_DESCRIPTION="Papirus is a free and open source icon theme, based on Paper Icon Set"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@Yisus7u7 <dev.yisus@hotmail.com>"
TERMUX_PKG_VERSION=1.12.0
TERMUX_PKG_SRCURL=https://github.com/PapirusDevelopmentTeam/papirus-folders/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=e20df336d909ef320606caed49797418fba54867fc24d6596576cfa55995c337
TERMUX_PKG_DEPENDS="papirus-icon-theme"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_make_install(){
        make PREFIX=$TERMUX_PREFIX install
}
