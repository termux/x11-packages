TERMUX_PKG_HOMEPAGE=https://webkit.org/
TERMUX_PKG_DESCRIPTION="WebKit is the web browser engine"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.31.1
TERMUX_PKG_SRCURL=https://svn.webkit.org/repository/webkit/releases/WebKitGTK/webkit-{$TERMUX_PKG_VERSION}/
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DPORT=GTK -DCMAKE_BUILD_TYPE=RelWithDebInfo"
