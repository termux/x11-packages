TERMUX_PKG_HOMEPAGE=https://www.xfce.org/
TERMUX_PKG_DESCRIPTION="GTK 2/3 theme engine for Xfce"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="Yisus7u7 <jesuspixel5@gmail.com>"
TERMUX_PKG_VERSION=3.2.0
TERMUX_PKG_SRCURL=http://deb.debian.org/debian/pool/main/g/gtk2-engines-xfce/gtk2-engines-xfce_${TERMUX_PKG_VERSION}.orig.tar.bz2
TERMUX_PKG_SHA256=875c9c3bda96faf050a2224649cc42129ffb662c4de33add8c0fd1fb860b47ed
TERMUX_PKG_DEPENDS="gtk2, gtk3, atk, libcairo, gdk-pixbuf, glib, pango"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk2  --enable-gtk3"
