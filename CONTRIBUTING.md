# Contributing guide

You are free to contribute to the [Termux X11 packages](https://github.com/termux/x11-packages) project.

There are three ways to contribute:

1. [Submitting bug reports](#bug-reports).
2. [Submitting package requests](#package-requests).
3. [Submitting pull requests](#pull-requests).

This article will describe all recommendations and things that you should know to get started.

## Bug reports

If you found that something crashes, reports that some file does not exist or just not working, consider to submit
a bug report.

Good bug report should include:

- **Description**

  Which package errored, what kind of error you get. You may attach a screenshots, especially when error
  is related to graphical things.

- **Steps to reproduce**

  Which command you have executed to get an error. Will be better if you create a bash script that will help to reproduce
  the problem you got.

- **System information**

  Your CPU architecture and version of Android. Usually, you can get necessary information by executing command `termux-info`.

**Important**: before submitting a bug report, make sure that all your packages are up-to-date by running command `pkg upgrade`,
then try to reproduce error yourself again - if it still occur, feel free to submit bug report, otherwise don't waste developers
time because you have not upgraded the packages.

Don't forget to use the right template when opening issue. To open issue with a bug report template, use this URL: https://github.com/termux/x11-packages/issues/new?template=bug_report.md.

## Package requests

If you found that some package is missing, you may request it by opening appropriate issue.

Note that unlike traditional Linux distributions, Termux has some limitations which make impossible to port specific packages. To learn about Termux's limitations, read following article on Termux Wiki: https://wiki.termux.com/wiki/Differences_from_Linux.

Things that should *never* be requested here:

- Packages that cannot work without root.
- Packages that require kernel features that are not available for Android devices.
- Packages that are developed for *multi-user* environments.
- Packages that are *closed-source*.
- Packages that work only on specific architectures (e.g. x86 only).
- Packages that can't work without OpenGL.
- Packages that require Java.
- Large/complex desktop environments like KDE or GNOME.

\- all package requests that require a thing one of listed above will be closed immediately.

Each package request should include:

- **Package description**

  What this package doing. Why it should be available in Termux.

- **Package's location**

  An URL to the package's home page and sources. Please, use official links here.

**Important**: it's likely that package requests will not be processed immediately, especially if your package introduces a dependencies that are not available in repository.

A template for the package request issue can be found here: https://github.com/termux/x11-packages/issues/new?template=package-request.md.

## Pull requests

Instead of waiting when your bug report or package request will be processed, you are free to implement all necessary changes by yourself.

### Writing a build script

Example of build script (build.sh) for the package "feh" with comments:
```
## Maintainer field.
## Write your self here if you want to be a package maintainer otherwise
## left me (xeffyr).
## Since x11-packages is a separate repository, this field should not be empty !!!
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

## I hope you understand what is the following lines do.
TERMUX_PKG_HOMEPAGE=https://feh.finalrewind.org/
TERMUX_PKG_DESCRIPTION="Fast and light imlib2-based image viewer"
TERMUX_PKG_VERSION=3.0
TERMUX_PKG_SRCURL=https://feh.finalrewind.org/feh-${TERMUX_PKG_VERSION}.tar.bz2

## The sha-256 hash of the package source archive.
## This field should not be empty !!!
TERMUX_PKG_SHA256=b67b4e5c6e1fb45dd2a4567e395b413c7565246db6780a46fb1bcdf33d72dc01

## List of run-time dependencies.
TERMUX_PKG_DEPENDS="imlib2, libandroid-shmem, libcurl, libexif, libpng, libx11, libxinerama"

## List of dependencies required only at build-time.
TERMUX_PKG_BUILD_DEPENDS="libxt"

## Some packages do not support building in a separate directory.
TERMUX_PKG_BUILD_IN_SRC=true

## Sometimes you have to pass additional arguments to the command "make".
TERMUX_PKG_EXTRA_MAKE_ARGS="exif=1 help=1 verscmp=0"

## If you need to configure some variables, do this in termux_step_pre_configure().
termux_step_pre_configure() {
    CFLAGS+=" -I${TERMUX_PREFIX}/include"
}
```

This repository uses a bit different coding style requirements:

- Maintainer field should be always exist and be always on top.
- Use spaces for indentation.
- Do not mix field entries. See example above to determine an order of them.

Minor violations of these requirements *will not* affect probability of merging your pull request.

There are some other packages recommended to check or use as base for PR: [gtk2](./packages/gtk2), [liblua52](./packages/liblua52), [libx11](./packages/libx11), [mpv-x](./packages/mpv-x).

### Patching

Many packages should be patched in order to work in the Termux. Before submitting a pull request, take a look on https://wiki.termux.com/wiki/Differences_from_Linux.

You may often see hardcoded paths like:

* /bin/sh
* /etc
* /tmp
* /var

You should fix them by prepending `@TERMUX_PREFIX@`.

### Formatting patches

If you changed multiple files, do not create the single-file patch. We prefer per-file patches. When amount of patches is large, you can split them between groups.

### Quality control

Always test things that you want to be merged at least on *two different CPU architectures*, device may be either real or AVD. Epsecially this is required for new packages. If you can't test the package, do not submit a pull request as likely it will be closed.

Things that should not be submitted:

- Trash.
- Things that you do not want to host yourself.
- Unknown packages, often self-developed.
- Changes, that break existing stuff.
- Changes, that introduce usage of command `sudo` (or similar) in build scripts.
- Changes, that forces build script to do something outside of the build directory.

In addition, read the [package request](#package-request) guide to know that packages are unwanted.
