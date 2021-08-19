TERMUX_PKG_NAME=NXEngine
TERMUX_PKG_HOMEPAGE=https://nxengine.sourceforge.net
TERMUX_PKG_DESCRIPTION="Open-source rewrite engine of the Cave Story for Dingux and MotoMAGX"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@Yonle"
TERMUX_PKG_VERSION=1.0.0.4-Rev4
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_DEPENDS="sdl, sdl-ttf, pulseaudio"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_get_source() {
	git clone https://github.com/EXL/NXEngine $TERMUX_PKG_SRCDIR
}

termux_step_make() {
	export TERMUX_PREFIX
        make -ef Makefile.linux
}

termux_step_make_install() {
	curl -Lo $TMPDIR/nxengine.tar.gz https://github.com/EXL/NXEngine/releases/download/v1.0.0.4-Rev4/LIN32-NXEngine-1.0.0.4-Rev-4.tar.gz
	cd $TERMUX_PREFIX/share
	tar -xvzf $TMPDIR/nxengine.tar.gz
	rm $TMPDIR/nxengine.tar.gz

	# Replace the standard binary into source ones.
	mv $TERMUX_PKG_SRCDIR/nx $TERMUX_PREFIX/share/NXEngine/nx
}

termux_step_install_license() {
	cp $TERMUX_PKG_SRCDIR/LICENSE $TERMUX_PREFIX/share/doc/${TERMUX_PKG_NAME}
}

termux_step_create_debscripts() {
	cat > .postinst <<- EOM
	#!$TERMUX_PREFIX/bin/sh
	ln -sr $TERMUX_PREFIX/share/NXEngine/nx $TERMUX_PREFIX/bin/nx
	EOM
}
