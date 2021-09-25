TERMUX_PKG_HOMEPAGE="https://github.com/lanoxx/tilda"
TERMUX_PKG_DESCRIPTION="A Gtk based drop down terminal for Linux and Unix"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@ELWAER-M"
TERMUX_PKG_VERSION="1.5.0"
TERMUX_PKG_SRCURL="https://github.com/lanoxx/tilda/archive/refs/tags/tilda-${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="f664c17daca2a2900f49de9eb65746ced03c867b02144149ef21260cbcd61039"
TERMUX_PKG_DEPENDS="glib, gtk3, libvte, libconfuse, libx11"

termux_step_pre_configure() {
	./autogen.sh --prefix=$TERMUX_PREFIX
}
