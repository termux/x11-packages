TERMUX_PKG_HOMEPAGE=https://quodlibet.readthedocs.io
TERMUX_PKG_DESCRIPTION="An audio library tagger, manager and player"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@Yonle <yonle@protonmail.com>"
TERMUX_PKG_VERSION=4.4.0
TERMUX_PKG_SRCURL="https://github.com/quodlibet/quodlibet/archive/refs/tags/release-${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=fab96fd7b56f3c771be16105a3ea6c0d3a4087283ab993d113f8633f03fd0565
TERMUX_PKG_DEPENDS="gtk3, python, dbus, desktop-file-utils, gst-plugins-base, gst-plugins-good, gst-plugins-ugly"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	python setup.py build
}

termux_step_make_install() {
	python setup.py install --prefix=${TERMUX_PREFIX} --skip-build --optimize=1
}
