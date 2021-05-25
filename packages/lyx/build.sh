TERMUX_PKG_HOMEPAGE=http://www.lyx.org
TERMUX_PKG_DESCRIPTION="WYSIWYM (What You See Is What You Mean) Document Processor"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=2.3.6.1
TERMUX_PKG_SRCURL="https://ftp.lip6.fr/pub/lyx/stable/2.3.x/lyx-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=c6bed2633419898e01a7cc350310d7d934bf591cab7259fc2581aa4c00eafa78
TERMUX_PKG_DEPENDS="qt5-qtbase, qt5-qtsvg, zlib, imagemagick, ghostscript, texlive-bin, hunspell"
TERMUX_PKG_BUILD_DEPENDS="autoconf, automake, bc, python, boost, qt5-qtbase-cross-tools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-build-type=rel
--enable-qt5
--without-included-boost
--without-aspell
--with-hunspell
"
TERMUX_PKG_RM_AFTER_INSTALL="share/lyx/examples"
