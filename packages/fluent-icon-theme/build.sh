TERMUX_PKG_HOMEPAGE=https://github.com/vinceliuice/Fluent-icon-theme
TERMUX_PKG_DESCRIPTION="Fluent icon theme for linux desktops"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@Yisus7u7 <jesuspixel5@gmail.com>"
TERMUX_PKG_VERSION=2021.10.07
_COMMIT=6399706c8c40686faac318f2a403fec23f70329c
TERMUX_PKG_SRCURL=https://github.com/vinceliuice/Fluent-icon-theme/archive/${_COMMIT}.zip
TERMUX_PKG_SHA256=f6cfd5047c1df143d9b24163c196b07b317d67caafb875d68b94c87239168513
TERMUX_PKG_DEPENDS="hicolor-icon-theme"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_make_install(){
	./install.sh -b -d ${TERMUX_PREFIX}/share/icons
}
