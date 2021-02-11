TERMUX_PKG_HOMEPAGE=https://webkit.org/
TERMUX_PKG_DESCRIPTION="WebKit is the web browser engine"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.31.1
TERMUX_PKG_SRCURL=https://svn.webkit.org/repository/webkit/releases/WebKitGTK/webkit-{$TERMUX_PKG_VERSION}/
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DPORT=GTK -DCMAKE_BUILD_TYPE=RelWithDebInfo"
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_SHA256=637db269b21ede63413409f07c6390fcefbde46bfcfef33b4fcb19b5f6ca3430

termux_step_post_get_source() {
    cd webkit
} 
