# Contributing guide

This is an issue tracker for the [x11-packages] project. It is expected that
there will be submitted [bug reports](#bug-reports), [~~package requests~~](#package-and-feature-requests)
or [pull requests](#pull-requests).

Personal support requests as well as general questions are discouraged here.

**Important note**: *unacceptible behaviour including toxic language, trolling,
spam is prohibited here.*

## Bug reports

If you are constantly observing "segmentation fault" or "Bad system call",
freezes, attempts to access non-existent files or similar behaviour, you
may [submit a bug report][bug-report-template].

1. Before opening a new issue, search for previous discussions about your topic.
There is a chance that your issue was reported already.

2. Make sure that your Termux installation is up-to-date. If not, please upgrade
all your packages to the latest version and try to reproduce problem again. If
software update solved your problem, do not open issue.

3. Make sure that you did not mistype or broke configuration files. Just
configuration typo is not worth of opening bug report.

4. Open new issue with [bug report template][bug-report-template]. Remove all
comments and put all necessary information according to the fields.

	You have to fill at least the following fields:

	- **Description**

		Clear description of the problem you encountered.

	- **Steps to reproduce**

		Exact steps to reproduce the problem.

	- **System information**

		Just post output of the `termux-info`.

Please note that you should not expect that your problem will be solved
immediately.

## Package and feature requests

Package and feature requests are no longer accepted for legacy branch.

## Pull requests

1. Before opening a pull request, make sure there no other pull requests similar
to yours.

2. Make sure that your changes do not break existing stuff and do not violate
our coding practices and formatting guidelines (see [termux-packages/docs]).

3. Make sure that your changes do not introduce code that perform undesirable
actions like using `su` or `sudo` commands or modifying files outside of the
build directories.

When you opened a pull request, repository maintainers should review it. In review
process you may be requested to apply additional changes. If you will not do this,
maintainers always can modify or close your pull request if necessary.

### For maintainers

Since we use CI/CD for automatic package building and publishing, it is acceptable
that simple (for example version upgrade or typo fix) pull request will be merged
by collaborators without reviewing by core maintainer. Though it is expected that
all changes are carefully reviewed to avoid having nasty things in our code.

Everything else must be reviewed by the core maintainer ([@xeffyr]).

[termux-packages]: <https://github.com/termux/termux-packages>
[termux-packages/docs]: <https://github.com/termux/termux-packages/tree/master/docs>
[x11-packages]: <https://github.com/termux/x11-packages>
[bug-report-template]: <https://github.com/termux/x11-packages/issues/new?template=BUG_REPORT.md>
[package-request-template]: <https://github.com/termux/x11-packages/issues/new?template=PACKAGE_REQUEST.md>
[@xeffyr]: <https://github.com/xeffyr>
