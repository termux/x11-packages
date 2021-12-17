TERMUX_PKG_HOMEPAGE=https://pyfltk.sourceforge.io/
TERMUX_PKG_DESCRIPTION="A Python Wrapper for the FLTK library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@Yisus7u7 <jesuspixel5@gmail.com>"
TERMUX_PKG_VERSION=1.3.7
TERMUX_PKG_SRCURL="https://sourceforge.net/projects/pyfltk/files/pyfltk/pyFltk-1.3.7/pyFltk-${TERMUX_PKG_VERSION}_WithSwig.tar.gz"
TERMUX_PKG_SHA256=fc41cd7d40cc7ee14f620f18af8bc8c022667aada5e50ceb808b3cdf3850d93a
TERMUX_PKG_DEPENDS="python, fltk, gobject-introspection"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	python setup.py build
}

termux_step_make_install() {
	python setup.py install --root=$TERMUX_PREFIX
}
