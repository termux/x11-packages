# Termux X11 Packages
Here are located build scripts and patches for X11 packages for Termux.

To use X11-enabled programs, you need to install [VNC Viewer](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android) or [XServer XSDL](https://play.google.com/store/apps/details?id=x.org.server). If launching program from terminal, make sure that environment variable 'DISPLAY' is set to correct value, e.g. `export DISPLAY=:1` when using TigerVNC or `export DISPLAY=127.0.0.1:0` when XServer XSDL.

## How to enable this repository
Currently, [termux-x11.ml](https://termux-x11.ml) is not added as default to sources.list, so if you want to use X11 packages, you need to do the following steps:

1. Add GPG key:
```
pkg install dirmngr
apt-key adv --keyserver pool.sks-keyservers.net --recv 45F2964132545795
```

2. Edit sources.list file to add the following lines:
```
# The X11 termux repository:
deb https://termux-x11.ml x11 main
```

3. Update package lists:
```
pkg update
```

## External links

* Termux home page: https://termux.com/
* Termux Wiki: https://wiki.termux.com/wiki/Main_Page
* Termux App: https://github.com/termux/termux-app
* Termux Packages: https://github.com/termux/termux-packages
