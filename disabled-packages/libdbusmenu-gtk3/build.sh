TERMUX_PKG_HOMEPAGE=https://launchpad.net/libdbusmenu
TERMUX_PKG_DESCRIPTION="library for passing menus over DBus - GTK-3+ version"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=18.10
TERMUX_PKG_SRCURL=http://deb.debian.org/debian/pool/main/libd/libdbusmenu/libdbusmenu_${TERMUX_PKG_VERSION}.20180917~bzr492+repack1.orig.tar.xz
TERMUX_PKG_SHA256=41298b926573419f21864205317461750b833c596af6ab0bd206e13336f8cee3
TERMUX_PKG_DEPENDS="gtk3, glib, atk, libcairo, gdk-pixbuf, harfbuzz, pango, xsltproc, json-glib"
TERMUX_PKG_BUILD_DEPENDS="gtk-doc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-introspection=no --disable-vala"
# autoreconf fails by gtk-doc
# in a build on device this is fixed by 
# installing gtk-doc
termux_step_pre_configure(){
	autoreconf -fi
}
