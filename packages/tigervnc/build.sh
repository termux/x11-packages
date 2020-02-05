TERMUX_PKG_HOMEPAGE=https://tigervnc.org/
TERMUX_PKG_DESCRIPTION="Suite of VNC servers. Based on the VNC 4 branch of TightVNC."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com>"
TERMUX_PKG_VERSION=1.10.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/TigerVNC/tigervnc/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=19fcc80d7d35dd58115262e53cac87d8903180261d94c2a6b0c19224f50b58c4

TERMUX_PKG_DEPENDS="freetype, libandroid-shmem, libbz2, libc++, libdrm, libexpat, libgnutls, libjpeg-turbo, libpixman, libpng, libuuid, libx11, libxau, libxcb, libxdamage, libxdmcp, libxext, libxxf86vm, libxfixes, libxfont2, libxshmfence, mesa, openssl, perl, xkeyboard-config, xorg-xauth, xorg-xkbcomp"
TERMUX_PKG_BUILD_DEPENDS="xorgproto, xorg-font-util, xorg-util-macros, xtrans"
TERMUX_PKG_SUGGESTS="aterm, xorg-twm"

TERMUX_PKG_FOLDERNAME=tigervnc-${TERMUX_PKG_VERSION}
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_VIEWER=ON -DENABLE_NLS=OFF -DENABLE_PAM=OFF -DENABLE_GNUTLS=ON -DFLTK_MATH_LIBRARY=libm.a"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	mkdir -p ${TERMUX_PKG_BUILDDIR}/unix/xserver

	## TigerVNC requires sources of X server (either Xorg or Xvfb).
	cd ${TERMUX_PKG_BUILDDIR}/unix/xserver/ && {
		termux_download \
			https://xorg.freedesktop.org/releases/individual/xserver/xorg-server-1.20.0.tar.bz2 \
			xorg-server-src.tar.bz2 \
			9d967d185f05709274ee0c4f861a4672463986e550ca05725ce27974f550d3e6
		tar xf xorg-server-src.tar.bz2 --strip-components=1
		rm -f xorg-server-src.tar.bz2

		for p in "$TERMUX_SCRIPTDIR/packages/xorg-server-xvfb"/*.patch; do
			sed "s%\@TERMUX_PREFIX\@%${TERMUX_PREFIX}%g" "$p" | \
				sed "s%\@TERMUX_HOME\@%${TERMUX_ANDROID_HOME}%g" | \
					patch --silent -p1
		done
	}

	patch -p1 -i ${TERMUX_PKG_SRCDIR}/unix/xserver120.patch

	export ACLOCAL="aclocal -I ${TERMUX_PREFIX}/share/aclocal"
	autoreconf -fi

	CFLAGS="${CFLAGS/-Os/-Oz} -DFNDELAY=O_NDELAY -DINITARGS=void"
	CPPFLAGS="${CPPFLAGS} -I${TERMUX_PREFIX}/include/libdrm"
	LDFLAGS="${LDFLAGS} -llog"

	./configure \
		--host="${TERMUX_HOST_PLATFORM}" \
		--prefix="${TERMUX_PREFIX}" \
		--disable-static \
		--disable-nls \
		--enable-debug \
		`TERMUX_PREFIX=${TERMUX_PREFIX} bash ${TERMUX_SCRIPTDIR}/packages/xorg-server-xvfb/build.sh xorg_server_flags`

	LDFLAGS="${LDFLAGS} -landroid-shmem"

	# Fix for FLTK_MATH_LIBRARY.
	cp "$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/libm.a" "$TERMUX_PKG_SRCDIR"/
}

termux_step_post_make_install() {
	cd ${TERMUX_PKG_BUILDDIR}/unix/xserver
	make -j ${TERMUX_MAKE_PROCESSES}

	cd ${TERMUX_PKG_BUILDDIR}/unix/xserver/hw/vnc
	make install

	## use custom variant of vncserver script
	cp -f "${TERMUX_PKG_BUILDER_DIR}/vncserver" "${TERMUX_PREFIX}/bin/vncserver"
}
