TERMUX_PKG_HOMEPAGE=https://www.bunkus.org/videotools/mkvtoolnix/
TERMUX_PKG_DESCRIPTION="Set of tools to create, edit and inspect Matroska files"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=59.0.0
TERMUX_PKG_SRCURL=https://gitlab.com/mbunkus/mkvtoolnix/-/archive/release-$TERMUX_PKG_VERSION/mkvtoolnix-release-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=7ebbae5af3bbcaa310ffa9be4cb7f33dc8735d88ec46cf179d8f1ef2f5240dfd
TERMUX_PKG_DEPENDS="boost, cmark, file, libflac, libogg, libvorbis, pcre2, qt5-qtbase, qt5-qtmultimedia, zlib"
TERMUX_PKG_BUILD_DEPENDS="fmt, libebml, libmatroska, qt5-qtbase-cross-tools"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-boost-filesystem=boost_filesystem
--with-boost-system=boost_system
--with-boost-date-time=boost_date_time
"

termux_step_pre_configure() {
	export PATH=$PATH:$TERMUX_PREFIX/opt/qt/cross/bin
	./autogen.sh
}

termux_step_make() {
	rake
}

termux_step_make_install() {
	rake install
}
