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

Each package requiest should include:

- **Package description**

  What this package doing. Why it should be available in Termux.

- **Package's location**

  An URL to the package's home page and sources. Please, use official links here.

**Important**: it's likely that package requests will not be processed immediately, especially if your package introduces a dependencies that are not available in repository.

A template for the package request issue can be found here: https://github.com/termux/x11-packages/issues/new?template=package-request.md.
