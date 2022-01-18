TERMUX_PKG_HOMEPAGE=https://docs.xfce.org/xfce/thunar/archive
TERMUX_PKG_DESCRIPTION="This plugin allows one to extract and create archive from inside the Thunar file manager."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Yisus7u7 <yisus7u7v@gmail.com>"
TERMUX_PKG_REVISION=4
TERMUX_PKG_VERSION=0.4.0
TERMUX_PKG_SRCURL=http://deb.debian.org/debian/pool/main/t/thunar-archive-plugin/thunar-archive-plugin_${TERMUX_PKG_VERSION}.orig.tar.bz2
TERMUX_PKG_SHA256=bf82fa86a388124eb3c4854249c30712b2922e61789607268ee14548549b3115
TERMUX_PKG_DEPENDS="gtk3, atk, libcairo, pango, exo, gdk-pixbuf, glib, harfbuzz, thunar, libxfce4util"
TERMUX_PKG_RECOMMENDS="file-roller"
TERMUX_PKG_BUILD_IN_SRC=true
