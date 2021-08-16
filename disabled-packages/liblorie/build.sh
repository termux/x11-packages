TERMUX_PKG_HOMEPAGE=https://github.com/twaik/liblorie
TERMUX_PKG_DESCRIPTION="liblorie"
TERMUX_PKG_VERSION=0.0.1
TERMUX_PKG_SRCURL=https://github.com/twaik/liblorie/archive/af02c7b61c81bde383da5166269dd68549d07e99.tar.gz
TERMUX_PKG_SHA256=0d61fcfe4ff63796c86643b7e563b813524a5b08ffac64217703b4d8e3da5e34
TERMUX_PKG_DEPENDS="libandroid-shmem, libwayland, xorg-server"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dandroid_client=true -Dxorg_module=true"
