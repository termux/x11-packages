# Termux X11 Packages

[![pipeline status](https://gitlab.com/xeffyr/x11-packages/badges/master/pipeline.svg)](https://gitlab.com/xeffyr/x11-packages/commits/master)

Here are located build scripts and patches for X11 packages for Termux.

Programs that use X11 Windowing System cannot be used standalone. You have to
run an X server either on device or remote endpoint - decide where you want to
send video output. Recommended way is to do output via VNC (you may need to
install a [VNC Viewer] application) or via [XServer XSDL] (though, it is a bit
outdated). Other kinds of X server implementations for Android may work but
note that they are *completely unsupported*.

You may need to set a `DISPLAY` environment variable when launching X11-enabled
program from the Termux console. Typically, you will need to do `export DISPLAY=:1`
when using VNC and `export DISPLAY=127.0.0.1:0` when using [XServer XSDL].

Better explanation about setting up graphical environment is on the [Termux Wiki].

## How to enable this repository

To enable this package repository run:
```
pkg install x11-repo
```

## Building packages

You can build all packages manually by using provided docker image. The only
requirements are Linux-based host and Docker.

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

[Termux Wiki]: <https://wiki.termux.com/wiki/Graphical_Environment>
[VNC Viewer]: <https://play.google.com/store/apps/details?id=com.realvnc.viewer.android>
[XServer XSDL]: <https://play.google.com/store/apps/details?id=x.org.server>
