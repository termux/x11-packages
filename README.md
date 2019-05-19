# Termux X11 Packages

[![Powered by JFrog Bintray](./.github/static/powered-by-bintray.png)](https://bintray.com)

There are located build scripts and patches for Termux X11 packages.

**Important:** only AArch64 package set is complete for Android 7 (api24) X11 repository. Users of other architectures (e.g. ARM) may see that a lot of packages not available.

Programs that use [X11 Windowing System] cannot be used standalone like normal
command line utilities. Termux does not provide native way for video output and
therefore you will need to do additional setup. Recommended way is to use either
`tigervnc` as [VNC] server and [VNC Viewer] for accessing video output. You can
also use [XServer XSDL], though it is a bit outdated - do not complain about
something that works via VNC but is not working via [XServer XSDL]. Other
variants of the X server implementations for Android may work but they are
*completely unsupported*. Video output to the remote X server (directly or via
SSH X forwarding) should work without additional setup required.

Current X11 setup is quite limited in functionality. There no hardware
acceleration. OpenGL support is very basic so GLX extension is not available.
Also, do not expect support for the wide range of GUI programs. Large desktop
environments like KDE and GNOME are *out of scope*.

Do not forget to set a `DISPLAY` environment variable when launching X11-enabled
programs from the Termux console. In most cases, you will need to do
`export DISPLAY=:1` when using VNC and `export DISPLAY=127.0.0.1:0` when using
[XServer XSDL].

More complete information about setting up graphical environment is on the
[Termux Wiki].

## How to enable this repository

To enable this package repository run:
```ShellSession
pkg install x11-repo
```

## Building packages

You can build all packages manually by using provided docker image. The only
requirements are Linux-based host with Docker installed.

1. Clone this repository:
	```ShellSession
	git clone https://github.com/termux/x11-packages
	```

2. Enter build environment (will download docker image if necessary):
	```ShellSession
	cd ./x11-packages
	./start-builder.sh
	```

3. Choose package you want to build and run:
	```ShellSession
	./build-package.sh -a ${arch} ${package name}
	```
	Replace `${arch}` with target CPU architecture and `${package name}` with
	package name you want to build.

## Contributing

If you wish to contribute, please take a look on our [contributing guide](./CONTRIBUTING.md).

[X11 Windowing System]: <https://en.wikipedia.org/wiki/X_Window_System>
[Termux Wiki]: <https://wiki.termux.com/wiki/Graphical_Environment>
[VNC Viewer]: <https://play.google.com/store/apps/details?id=com.realvnc.viewer.android>
[XServer XSDL]: <https://play.google.com/store/apps/details?id=x.org.server>
