# Termux X11 Packages

[![Packages last build status](https://github.com/termux/x11-packages/workflows/Packages/badge.svg)](https://github.com/termux/x11-packages/actions)

<img src=".github/static/powered-by-fosshost.png" alt="Powered by FossHost" width="128px"></img>

There are located build scripts and patches for Termux X11 packages.

If you wish to contribute, please take a look at X11 packages [contributing guide](./CONTRIBUTING.md) and developer's [wiki pages](https://github.com/termux/termux-packages/wiki).

***

## How to enable this repository

Repository is not enabled in Termux by default. First enable it to be able to install
its packages:
```
pkg install x11-repo
```

## Using X11 on Termux

Programs using the [X11 Windowing System] cannot be used standalone like normal
command-line utilities. Termux does not provide a native way for video output
and therefore you will need to install additional software.

The recommended setup is a [VNC] server (package `tigervnc`) running on
localhost and a [VNC Viewer] (by RealVNC Limited) Android application for
accessing the video output.

There possible to use other Xserver solutions like [XServer XSDL], but they are
not guaranteed to work properly with our packages.

More information about setting up a graphical environment is on the
[Termux Wiki].

**Only for Termux installations on Android 7.0 or higher.**

## Building packages

You can build all packages manually by using the provided docker image. The only
requirements are Linux-based host with Docker installed.

1. Clone this repository:
	```
	git clone https://github.com/termux/x11-packages
	```

2. Enter build environment (will download docker image if necessary):
	```
	cd ./x11-packages
	./start-builder.sh
	```

3. Choose package you want to build and run:
	```
	./build-package.sh -a ${arch} ${package name}
	```
	Replace `${arch}` with target CPU architecture and `${package name}` with
	package name you want to build.

[X11 Windowing System]: <https://en.wikipedia.org/wiki/X_Window_System>
[Termux Wiki]: <https://wiki.termux.com/wiki/Graphical_Environment>
[VNC]: <https://en.wikipedia.org/wiki/Virtual_Network_Computing>
[VNC Viewer]: <https://play.google.com/store/apps/details?id=com.realvnc.viewer.android>
[XServer XSDL]: <https://play.google.com/store/apps/details?id=x.org.server>
