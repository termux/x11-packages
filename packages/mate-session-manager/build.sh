TERMUX_PKG_HOMEPAGE=https://mate-session-manager.mate-desktop.dev/
TERMUX_PKG_DESCRIPTION="mate-session contains the MATE session manager, as well as a configuration program to choose applications starting on login."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.24.3
TERMUX_PKG_REVISION=6
TERMUX_PKG_SRCURL=https://github.com/mate-desktop/mate-session-manager/releases/download/v$TERMUX_PKG_VERSION/mate-session-manager-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=90a0aec5b59b6287b4d2c4d452b0b6410f9d12490ca1f890e81ba2801bdab0a2
TERMUX_PKG_DEPENDS="libsm, dbus-glib, gtk3, glib"
TERMUX_PKG_RM_AFTER_INSTALL="share/glib-2.0/schemas/gschemas.compiled"
