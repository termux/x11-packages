TERMUX_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/zenity
TERMUX_PKG_DESCRIPTION="a rewrite of gdialog, the GNOME port of dialog"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=3.32.0
TERMUX_PKG_SRCURL=https://github.com/GNOME/zenity/archive/refs/tags/ZENITY_${TERMUX_PKG_VERSION/./_}.tar.gz
TERMUX_PKG_SHA256=9329e6a2d114316a7b75202d9d942c2e5ee2351571375cc0eda8e868598c07c5
TERMUX_PKG_DEPENDS="glib, gtk3"
termux_step_pre_configure() {
	autoreconf -fi
}
