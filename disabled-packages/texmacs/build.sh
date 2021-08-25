## Requires functionality from spawn.h header which is
## available only on Android API 28. There no workarounds as
## it affects core functionality.

TERMUX_PKG_HOMEPAGE=http://www.texmacs.org/
TERMUX_PKG_DESCRIPTION="Free scientific text editor, inspired by TeX and GNU Emacs."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.99.8
TERMUX_PKG_SRCURL=http://www.texmacs.org/Download/ftp/tmftp/source/TeXmacs-${TERMUX_PKG_VERSION}-src.tar.gz
TERMUX_PKG_SHA256=7febdbccc6d1ac16d9375a136814259499fb38a49078de2857ab4f47d29a20c0
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_FORCE_CMAKE=true

## Note: guile18 stored in different repo and it requires Android API level 23+.
TERMUX_PKG_DEPENDS="freetype, guile18, libxext, perl, python2"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DGUILECONFIG_EXECUTABLE=$TERMUX_PREFIX/bin/guile-config1.8
-DTEXMACS_GUI=X11
"
