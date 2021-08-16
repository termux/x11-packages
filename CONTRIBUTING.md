# Contributing

Termux is an open source application and it is built on users' contributions.
However, most of work is done by Termux maintainers on their spare time and
therefore only priority tasks are being completed.

Developer's wiki is available at https://github.com/termux/termux-packages/wiki.

## How you can contribute to Termux project

- **Reporting issues**

  If you have found issue, let the community know about it.

  Please be prepared that issue may not be resolved immediately. We will ignore
  statements like "solve it quickly", "urgently need solution" and so on. Be
  patient.

  You may report only issues happening within our official packages. Do not
  submit issues happening in third-party software - we will ignore them.

  Bugs reports for legacy Termux installations (Android 5.x / 6.x) are not
  accepted. We already dropped support for these Android OS versions.

- **Examining existing packages for potential issues**

  There could be undiscovered bugs in packages. For example: unspecified
  dependencies, unprefixed hardcoded FHS paths, crashes, etc.

  If you can't submit a pull request with patches fixing the problem, you can
  open new [issue](https://github.com/termux/x11-packages/issues/new/choose).

- **Fixing known bugs**

  Take a look at https://github.com/termux/termux-packages/issues. There many
  issue tickets having tag `bug report` or `help wanted`. They all are waiting
  to be resolved.

- **Submitting new packages**

  There are lots of unresolved [package requests](https://github.com/termux/x11-packages/issues?q=is%3Aissue+is%3Aopen+label%3A%22package+request%22).
  Pay attention to tickets having tag `help wanted`.

- **Keeping existing packages up-to-date**

  Packages do not update themselves on their own. Someone needs to update build
  script and patches. Usually they are handled by maintainers but things are
  often outdated.

  See [Updating packages](#updating-packages) for details.

- **Hosting a package repository mirror**

  Termux generates lots of traffic. Mirrors help to reduce load on primary
  server, provide better download speeds and eliminate single point of failure.

- **Donate**

  See https://github.com/termux/termux-packages/wiki/Donate for details.

## Requesting new package

If you are looking for specific package and didn't find it included in our
repositories, you can request it.

Open a new [issue](https://github.com/termux/x11-packages/issues/new/choose)
filling the `package request` template. You will need to provide at least
package description and its home page and URL to source repository. Remember
that your request will not be processed immediately.

Requested package must comply with our [packaging policy](#packaging-policy).

## Packaging policy

There are already more than 1000 packages added to Termux repositories. All
of them needs to be maintained, kept up-to-date. Unlike the major distributions,
our developers team is small and we also limited on server disk space.

In order to provide service at reasonable quality, requested packages should
met these conditions:

- **Packages must be active, well-known projects**

  Software available in major Linux distributions has more chances to be
  included into Termux repositories. We will not accept outdated, dead projects
  as well as projects which do not have active community.

- **Packages must be licensed under widely recognized open source license**

  Software should be licensed under Apache, BSD, GNU GPL, MIT or other well
  known open source license. Software which is open source but is distributed
  under non-free conditions is processed on individual basis.

  Software which is either closed-source, contain binary-only components or
  is distributed under End User License Agreement is not accepted.

- **Not installable through cpan, gem, npm, or pip**

  These packages should be installable through `cpan`, `gem`, `npm`, `pip` and
  so on.

  Packaging modules for Perl, Ruby, Node.js, Python is problematic, especially
  when it comes to cross-compiling native extensions.

- **Not taking too much disk space**

  The size of resulting package should be less than 100 MiB.

  Since software is being compiled for 4 CPU architectures (aarch64, arm,
  i686, x86_64), effective disk usage is 4 times bigger than size of single
  .deb file. We are limited on disk space and prefer many small packages
  over one big.

  Exceptions are made on individual basis and only for packages providing
  important functionality.

- **Not serving duplicated functionality**

  Please avoid submitting packages which duplicate functionality of already
  present ones.

  The more useless packages in repositories, the less overall packaging and
  service quality - *remembering that our resources are limited?*

- **Not serving hacking, phishing, spamming, spying, ddos functionality**

  We do not accept packages which serve solely destructive or privacy violation
  purposes, including but not limited to pentesting, phishing, bruteforce,
  sms/call bombing, DDoS attaks, OSINT.

## Submitting pull requests

Contributors take the all responsibility for their submissions. Maintainers may
provide some help with fixing your pull request or give some recommendations,
but that DOES NOT mean they will do all work instead of you.

**Minimal requirements:**
- Experience with Linux distribution like Debian (preferred), Arch, Fedora, etc.
- Experience with compiling software from source.
- Good shell scripting skills.
- You have read https://github.com/termux/termux-packages/wiki.

If you never used Linux distribution or Termux was your first experience with
Linux environment, we strongly recommending to NOT send pull requests since
we will reject low quality work.

Do not forget about [packaging policy](#packaging-policy) when submitting a
new package, as your pull request will be closed without merge.

Do not send disruptive changes, like without reason reverting commits or
deleting files, creating spam content, etc. Authors of such pull requests may
be blocked from contributing to [Termux](https://github.com/termux) project.

***

# Working with packages

All software available in Termux repositories aims to be compatible with Android
OS and is built by Android NDK. This often introduces compatibility issues as
Android (specifically Termux) is not a standard platform. Do not expect there
are exist package recipes available out-of-box.

## Basics

Each package is a defined through the `build.sh` script placed into directory
`./packages/<name>/` where `<name>` is the actual name of package in lower case.
File `build.sh` is a shell (Bash) script that defines some properties like
dependencies, description, home page through environment variables. Sometimes
it also used to override default packaging steps defined in our build system.

Here is example of `build.sh`:

```.sh
TERMUX_PKG_HOMEPAGE=https://example.com
TERMUX_PKG_DESCRIPTION="Termux package"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@github"
TERMUX_PKG_VERSION=1.0
TERMUX_PKG_SRCURL=https://example.com/sources-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=0000000000000000000000000000000000000000000000000000000000000000
TERMUX_PKG_DEPENDS="libiconv, ncurses"
```

It can contain some additional variables:
- `TERMUX_PKG_BUILD_IN_SRC=true`

  Use this variable if package supports in-tree builds only, for example if
  package uses raw Makefile instead of build system like CMake.

- `TERMUX_PKG_PLATFORM_INDEPENDENT=true`

  This variable specifies that package is platform-independent and can run
  on any device regardless of CPU architecture.

`TERMUX_PKG_LICENSE` should specify the license using SPDX license identifier
or can contain values "custom" or "non-free". Multiple licenses should be
separated by commas.

`TERMUX_PKG_SRCURL` should contain URL only for the official source bundle.
Use of forks is allowed only under a good reason.

More about `build.sh` variables you can read on [developer's wiki](https://github.com/termux/termux-packages/wiki/Creating-new-package#table-of-available-package-control-fields).

## Updating packages

[![asciicast](https://asciinema.org/a/gVwMqf1bGbqrXmuILvxozy3IG.svg)](https://asciinema.org/a/gVwMqf1bGbqrXmuILvxozy3IG?autoplay=1&speed=2.0)

You can check which packages are out-of-date by visiting Termux page on
[Repology](https://repology.org/projects/?inrepo=termux&outdated=1).

Most of packages can be updated by just modifying variables `TERMUX_PKG_VERSION`
and `TERMUX_PKG_SHA256`, which represent the package version and checksum for
source code archive respectively.

### Dealing with patch errors

Major changes introduced to packages often make current patches incompatible
with newer package version. Unfortunately, there no universal guide about
fixing patch issues as workaround is always based on changes introduced to
the new source code version.

Here are few things you may to try:

1. If patch fixing particular known upstream issue, check the project's VCS
   for commits fixing the issue. There is a chance that patch is no longer
   needed.

2. Inspecting the failed patch file and manually applying changes to source
   code. Do so only if you understand the source code and changes introduced
   by patch.

   Regenerate patch file, e.g. with:
   ```
   diff -uNr package-1.0 package-1.0.mod > previously-failed-patch-file.patch
   ```

Always check the CI (Github Actions) status for your pull request. If it fails,
then either fix or close it. Maintainers can fix it on their own, if issues are
minor. But they won't rewrite whole your submission.

## Rebuilding package with no version change

Changes to patch files and build configuration options will imply package
rebuild. In order to make package recognized as update, a build number should
be set. This is done through defining variable `TERMUX_PKG_REVISION` or
incrementing its value if already set.

`TERMUX_PKG_REVISION` should be set exactly below `TERMUX_PKG_VERSION`:

```.sh
TERMUX_PKG_VERSION=1.0
TERMUX_PKG_REVISION=4
```

If package version has been updated, `TERMUX_PKG_REVISION` should be removed.

## Downgrading the package or changing versioning scheme

If package needs to be downgraded or for versioning scheme needs to be changed,
you need to set or increment package epoch. This is needed to tell package
manager force recognize new version as package update.

Epoch should be specified in same variable as version (`TERMUX_PKG_VERSION`),
but its value will take different format (`{EPOCH}:{VERSION}`):

```.sh
TERMUX_PKG_VERSION=1:5.0.0
```

Note that if you are not @termux collaborator, pull request must contain a
*description* why you are submitting a package downgrade. All pull requests
which submit package downgrading without any serious reason will be rejected.

## Common build issues

```
No files in package. Maybe you need to run autoreconf -fi before configuring?
```

Means that build system cannot find the Makefile. Depending on project, there
are some tips for trying:
- Set `TERMUX_PKG_BUILD_IN_SRC=true` - applicable to Makefile-only projects.
- Run `./autogen.sh` or `autoreconf -fi` in `termux_step_pre_configure`. This
  is applicable to projects that use Autotools.

```
No LICENSE file was installed for ...
```

This error happens when build system cannot find license file and it should be
specified manually through `TERMUX_PKG_LICENSE_FILE`.

