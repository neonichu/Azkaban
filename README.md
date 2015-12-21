# Azkaban

![Sirius Black, the prisoner of Azkaban](yolo.jpg)

A CLI to [Alcatraz][1], the Xcode package manager.

## Usage

Install a plugin listed on [Alcatraz Packages][2]:

```bash
$ azkaban install FixCode
[...]
Installed FixCode
```

Uninstall a plugin:

```bash
$ azkaban uninstall BBUFullIssueNavigator
Uninstalled BBUFullIssueNavigator
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
Installed Refactorator
```

## Installation

You can install Azkaban via [Homebrew][3]:

```bash
$ brew tap neonichu/formulae
$ brew install azkaban
```

You will need to have [Swift 2.2][4] installed already for the installation to work.

## Thanks

Thanks [Orta][5] for the awesome name suggestion and of course, thanks to [Supermarin][6],
[Delisa][7] and [Jurre][8] for making [Alcatraz][1].

## Help needed

Follow [@NeoNacho](https://twitter.com/NeoNacho) to help me beat [@orta](https://twitter.com/orta) in followers count.

## Caveats

:warning: This won't work with upstream Alcatraz right now if you are building from source. Just
use the installation instructions.

[1]: http://alcatraz.io
[2]: https://github.com/alcatraz/alcatraz-packages
[3]: http://brew.sh
[4]: https://swift.org
[5]: https://github.com/orta
[6]: https://github.com/supermarin
[7]: https://github.com/kattrali
[8]: https://github.com/jurre
