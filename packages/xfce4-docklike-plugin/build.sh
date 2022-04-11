TERMUX_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-docklike-plugin/start
TERMUX_PKG_DESCRIPTION="A modern, minimalist taskbar for Xfce."
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
TERMUX_PKG_VERSION=0.4.0
TERMUX_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-docklike-plugin/0.4/xfce4-docklike-plugin-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=b4136a70897895f0599e8e7237223dde17221f099a2fc816917d5894bbd4f372
TERMUX_PKG_DEPENDS="gtk3, exo, libcairo, glib, libwnck, libxfce4ui, xfce4-panel"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure(){
    local _libgcc="$($CC -print-libgcc-file-name)"
    LIBS+=" -L$(dirname $_libgcc) -l:$(basename $_libgcc)"
}
