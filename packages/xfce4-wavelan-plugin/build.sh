# error after last change in ndk-sysroot

# /home/builder/.termux-build/_cache/android-r23b-api-24-v3/bin/../sysroot/usr/include/unistd.h:268:5:
# note: previous declaration is here
# int close(int __fd);
#     ^
# 1 error generated.

TERMUX_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-wavelan-plugin/start
TERMUX_PKG_DESCRIPTION="wavelan status plugin for the Xfce4 panel"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Yisus7u7 <jesuspixel5@gmail.com>"
TERMUX_PKG_VERSION=0.6.2
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-wavelan-plugin/0.6/xfce4-wavelan-plugin-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=ea7aa36650c596b1a29567d100776c68ed732aaf0f48c92245c4466058b5481d
TERMUX_PKG_DEPENDS="gtk3, atk, libcairo, pango, gdk-pixbuf, glib, libxfce4util, libxfce4ui, xfce4-panel, harfbuzz"
TERMUX_PKG_BUILD_IN_SRC=true
