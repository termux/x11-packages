# Contributing guide

You are free to contribute to the [Termux X11 packages](https://github.com/termux/x11-packages) project.

There are three ways to contribute:

1. [Submitting bug reports](#bug-reports).
2. [Submitting package requests](#package-requests).
3. [Submitting pull requests](#pull-requests).

This article will describe all recommendations and things that you should know to get started.

## Bug reports

Porting packages to such non-standard platform like Termux may lead in various bugs in the [x11-related packages](https://github.com/termux/x11-packages). Typical signs that you encountered a bug are messages like "segmentation fault", freezes, attempts to access non-existent files, etc.

If you think that you found a bug, please submit a bug report which includes:

- **Description**

  Clear description of the problem you encountered. If error related to graphics, please attach a screenshot.

- **Steps to reproduce**

  What you did to encounter the problem. Ideally, attach the script which will execute all necessary commands. If program fails only on certain configuration, attach the configuration files.

- **System information**

  Your CPU architecture and version of Android. Usually, you can get necessary information by executing command `termux-info`.

Don't forget to use the right template when opening issue. To open issue with a bug report template, use this URL: https://github.com/termux/x11-packages/issues/new?template=bug_report.md.


**Important**: do not submit bug reports about third-party, self-compiled and outdated packages. These issues will be considered as "spam". Same goes for corrupted configuration files and questions like "help me, I don't know how to use package".

## Package requests

You are free to request specific package if you found it important but not available in repository.

Each package request should include:

- **Package description**

  A short and clear description of package, what it doing and why it should be packaged for Termux.

- **Package's location**

  An URL to the package's home page and sources. Use only *official* links - various unofficial modifications are generally *unwanted*, same goes for *unauthorized* mirrors.

There are restrictions on accepted packages. Particulary, *never* request following stuff here:

- Packages that cannot work without root.
- Packages that require kernel features that are not available for Android devices.
- Packages that are developed for *multi-user* environments.
- Packages that are *closed-source*.
- Packages that work only on specific architectures (e.g. x86 only).
- Packages that can't work without OpenGL.
- Packages that require Java.
- Packages that require additional python modules.
- Packages that require additional perl modules.
- Complex desktop environments like KDE or GNOME.

\- all package requests that require a thing one of listed above will be closed immediately.

A template for the package request issue can be found here: https://github.com/termux/x11-packages/issues/new?template=package_request.md.

**Important**: package requests may not be processed instantly. Developer's time is quite limited. If you want to make package available quickly - implement it yourself and submit a [pull request](#pull-requests).

## Pull requests

Instead of waiting when your bug report or package request will be processed, you are free to implement all necessary changes by yourself.

### Writing a build script

As example, it is recommended to check build scripts of some packages. For example: [gtk2](./packages/gtk2), [liblua52](./packages/liblua52), [libx11](./packages/libx11), [mpv-x](./packages/mpv-x).

There also some important things that worth to mention:

- **Maintainer field**

  Always set maintainer field. Either to yourself or me. Example:
  ```
  TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
  ```

- **License field**

  Another important field is a package license. Inspect package's source code and read files like "LICENSE" or "COPYING".
  
  Valid license names: AFL-2.1, AFL-3.0, AGPL-V3, Apache-1.0, Apache-1.1, Apache-2.0, APL-1.0, APSL-2.0, Artistic-License-2.0, Attribution, Bouncy-Castle, BSD, BSD 2-Clause, BSD 3-Clause, BSL-1.0, CA-TOSL-1.1, CC0-1.0, CDDL-1.0, Codehaus, CPAL-1.0, CPL-1.0, CPOL-1.02, CUAOFFICE-1.0, Day, Day-Addendum, ECL2, Eiffel-2.0, Entessa-1.0, EPL-1.0, EPL-2.0, EUDATAGRID, EUPL-1.1, EUPL-1.2, Fair, Facebook-Platform, Frameworx-1.0, Go, GPL-2.0, GPL-2.0+CE, GPL-3.0, Historical, HSQLDB, IBMPL-1.0, IJG, ImageMagick, IPAFont-1.0, ISC, IU-Extreme-1.1.1, JA-SIG, JSON, JTidy, LGPL-2.0, LGPL-2.1, LGPL-3.0, Libpng, LPPL-1.0, Lucent-1.02, MirOS, MIT, Motosoto-0.9.1, Mozilla-1.1, MPL-2.0, MS-PL, MS-RL, Multics, NASA-1.3, NAUMEN, NCSA, Nethack, Nokia-1.0a, NOSL-3.0, NTP, NUnit-2.6.3, NUnit-Test-Adapter-2.6.3, OCLC-2.0, Openfont-1.1, Opengroup, OpenSSL, OSL-3.0, PHP-3.0, PostgreSQL, Public Domain, Public Domain - SUN, PythonPL, PythonSoftFoundation, QTPL-1.0, Real-1.0, RicohPL, RPL-1.5, Scala, SimPL-2.0, Sleepycat, SUNPublic-1.0, Sybase-1.0, TMate, Unicode-DFS-2015, Unlicense, UoI-NCSA, UPL-1.0, VIM License, VovidaPL-1.0, W3C, WTFPL, wxWindows, Xnet, ZLIB, ZPL-2.0.
  
  Example of specifying license for GNU GPL v3 package:
  ```
  TERMUX_PKG_LICENSE="GPL-3.0"
  ```

### Patching

Many packages should be patched in order to work in the Termux. Before submitting a pull request, take a look on https://wiki.termux.com/wiki/Differences_from_Linux.

1. You may often see hardcoded paths like:

   * /bin
   * /etc
   * /tmp
   * /usr
   * /var

   You should fix them by prepending `@TERMUX_PREFIX@`.
   If program use path like /sbin, you will have to rewrite it as `@TERMUX_PREFIX@/bin` because Termux does not have sbin directory.

2. Make sure that program does not use system calls forbidden on Android 8 or newer. Examples of such calls are: link(), linkat() and some other. You will have to find replacements for them. Usage of uid/gid manipulating system calls like setuid(), setgid(), chown() is unwanted too - at least because these calls blocked by seccomp, also Termux is single-user non-root environment.

3. Programs that use shared memory should be forcely linked with libandroid-shmem. Android's official implementation of shared memory is Ashmem. System calls like shmget() or shmat() (XSI shared memory) are blocked by seccomp on Android 8 or newer.

4. Programs that use shm_open() or shm_unlink() (POSIX shared memory) should be linked with libposix-shm as Android does not provide implementation for these functions.

There are no other recommendations about porting programs to Termux so you will have to deal on your own.

### Quality control

Build your packages in *latest* docker image provided by [termux-packages](https://github.com/termux/termux-packages) environment so builds will be reproducible.

Always test things that you want to be merged at least on *two different CPU architectures*. The device can be either real or AVD (emulator) provided by Android SDK. Testing packages in other software like Anbox, Bluestacks or similar is strongly discouraged.

What is not accepted in pull requests:

- Breakage of existing stuff.
- Usage of sudo-enabled commands.
- Usage of commands that create or modify files outside the build directory.
- Introducing *custom* global variables outside functions in the build script.
- Implementation of unknown, dead, trash-like, poor-quality packages.
- Implementation of commercial and closed-source packages.

In addition, read the [package request](#package-requests) guide to know that packages are unwanted.

We have continuous integration enabled. It would be perfectly, if build for your pull request finishes successfully (timeouts are not counted as failure).
