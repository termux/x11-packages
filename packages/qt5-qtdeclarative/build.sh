TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="The Qt Declarative module provides classes for using GUIs created using QML"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=5.12.11
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.12/${TERMUX_PKG_VERSION}/submodules/qtdeclarative-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=1267e029abc8424424c419bc1681db069ec76e51270cc220994e0f442c9f78d3
TERMUX_PKG_DEPENDS="qt5-qtbase"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_NO_STATICSPLIT=true

# Ignore bootstrap changes because of the hijacking
TERMUX_PKG_RM_AFTER_INSTALL="
opt/qt/cross/lib/libQt5Bootstrap.*
"

# Replacing the old qt5-base packages
TERMUX_PKG_REPLACES="qt5-declarative"

termux_step_pre_configure () {
    #######################################################
    ##
    ##  Hijack the bootstrap library for cross building
    ##
    #######################################################
    for i in a prl; do
        cp -p "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}" \
            "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak"
        ln -s -f "${TERMUX_PREFIX}/lib/libQt5Bootstrap.${i}" \
            "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
    done
    unset i
}

termux_step_configure () {
    "${TERMUX_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${TERMUX_PREFIX}/lib/qt/mkspecs/termux-cross"
}

termux_step_post_make_install () {
    #######################################################
    ##
    ##  Compiling necessary binaries for target.
    ##
    #######################################################

    ## Qt Declarative utilities.
    for i in qmlcachegen qmlimportscanner qmllint qmlmin; do
        cd "${TERMUX_PKG_SRCDIR}/tools/${i}" && {
            "${TERMUX_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${TERMUX_PREFIX}/lib/qt/mkspecs/termux-cross"

            make -j "${TERMUX_MAKE_PROCESSES}"
            install -Dm700 "../../bin/${i}" "${TERMUX_PREFIX}/bin/${i}"
        }
    done

    # Install the QmlDevTools for target (needed by some packages such as qttools)
    install -Dm644 ${TERMUX_PKG_SRCDIR}/lib/libQt5QmlDevTools.a "${TERMUX_PREFIX}/lib/libQt5QmlDevTools.a"
    install -Dm644 ${TERMUX_PKG_SRCDIR}/lib/libQt5QmlDevTools.prl "${TERMUX_PREFIX}/lib/libQt5QmlDevTools.prl"
    sed -i 's|/opt/qt/cross/|/|g' "${TERMUX_PREFIX}/lib/libQt5QmlDevTools.prl"

    #######################################################
    ##
    ##  Restore the bootstrap library
    ##
    #######################################################
    for i in a prl; do
        rm -f "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
        cp -p "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak" \
            "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
        rm -f "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak"
    done
    unset i

    #######################################################
    ##
    ##  Compiling necessary binaries for the host
    ##
    #######################################################

    ## libQt5QmlDevTools.a (qt5-declarative)
    cd "${TERMUX_PKG_SRCDIR}/src/qmldevtools" && {
        make clean

        "${TERMUX_PREFIX}/opt/qt/cross/bin/qmake" \
            -spec "${TERMUX_PREFIX}/lib/qt/mkspecs/termux-host"

        make -j "${TERMUX_MAKE_PROCESSES}"
        install -Dm644 ../../lib/libQt5QmlDevTools.a "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.a"
        install -Dm644 ../../lib/libQt5QmlDevTools.prl "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.prl"
    }

    ## Qt Declarative utilities.
    for i in qmlcachegen qmlimportscanner qmllint qmlmin; do
        cd "${TERMUX_PKG_SRCDIR}/tools/${i}" && {
            make clean

            "${TERMUX_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${TERMUX_PREFIX}/lib/qt/mkspecs/termux-host"

            make -j "${TERMUX_MAKE_PROCESSES}"
            install -Dm700 "../../bin/${i}" "${TERMUX_PREFIX}/opt/qt/cross/bin/${i}"
        }
    done

    #######################################################
    ##
    ##  Fixes & cleanup.
    ##
    #######################################################

    # Limit the scope, otherwise it'll touch qtbase files
    for pref in Qml Quick Packet; do
        ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
        find "${TERMUX_PREFIX}/lib" -type f -name "libQt5${pref}*.prl" \
            -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
    done
    unset pref
    sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "${TERMUX_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.prl"

    ## Remove *.la files.
    find "${TERMUX_PREFIX}/lib" -iname \*.la -delete
    find "${TERMUX_PREFIX}/opt/qt/cross/lib" -iname \*.la -delete
}

termux_step_create_debscripts() {
    # Some clean-up is happening via `postinst`
    # Because we're using this package in both host (Ubuntu glibc) and device (Termux)
    cp -f "${TERMUX_PKG_BUILDER_DIR}/postinst" ./
}
