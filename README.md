# Azkaban

:warning: WIP - this won't work with upstream Alcatraz right now.

A CLI to [Alcatraz][1], the Xcode package manager.

## Usage

Install a plugin listed on [Alcatraz Packages][2]:

```bash
$ azkaban install FixCode
```

Uninstall a plugin:

```bash
$ azkaban uninstall BBUFullIssueNavigator
```

List installed plugins:

```bash
$ azkaban list
BBUDebuggerTuckAway
ClangFormat
GitDiff
KSImageNamed
OMColorSense
```

You can also install a plugin via its repository URL for testing:

```bash
$ azkaban install https://github.com/johnno1962/Refactorator
```

[1]: http://alcatraz.io
[2]: https://github.com/alcatraz/alcatraz-packages
