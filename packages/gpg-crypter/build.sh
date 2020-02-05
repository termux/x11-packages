TERMUX_PKG_HOMEPAGE=https://sourceforge.net/projects/gpg-crypter/
TERMUX_PKG_DESCRIPTION="A graphical front-end to GnuPG(GPG) using the GTK3 toolkit and libgpgme"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com>"
TERMUX_PKG_VERSION=0.4.1
TERMUX_PKG_REVISION=6
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/gpg-crypter/gpg-crypter-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=1f7e2b27bf4a27ecbb07bce9cd40d1c08477a3bd065ba7d1a75d1732e4bdc023
TERMUX_PKG_DEPENDS="atk, gdk-pixbuf, glib, gpgme, gtk3, libandroid-shmem, libassuan, libcairo, libgpg-error, pango, pinentry-gtk"
TERMUX_PKG_RM_AFTER_INSTALL="lib/locale"

termux_step_pre_configure() {
	export LIBS="-landroid-shmem"
}
