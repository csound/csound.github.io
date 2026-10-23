---
layout: download
title: Download Csound
permalink: /download.html
---

## Installation Notes (macOS & Windows Gatekeeper)

Because Csound is community-maintained free software ([LGPLv2.1+](https://github.com/csound/csound/blob/master/README.md)), some installers are not signed with commercial Apple or Microsoft developer certificates:

- **macOS**: If macOS Gatekeeper reports that the package is from an unidentified developer, Control-click (or right-click) the installer and select **Open**, or allow it under **System Settings → Privacy & Security**.
- **Windows**: If Windows SmartScreen displays a prompt, click **More info → Run anyway**.

## External Plugins & Additional Tools

- [Official Csound Plugins Repository](https://github.com/csound/plugins/releases) — External opcodes (Python, Faust, FluidSynth, Jack, etc.)
- [csound-plugins by Eduardo Moguillansky](https://github.com/csound-plugins/csound-plugins/releases) — Additional opcodes and the `risset` package manager
- [Csound for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=kunstmusik.csound) — Syntax highlighting, documentation lookup, and live evaluation inside VS Code
- [WinXound](https://mnt.conts.it/winxound/) — Lightweight Csound editor for Windows, macOS, and Linux
- [Nightly / CI Builds](https://github.com/csound/csound/actions/workflows/csound_builds.yml) — Latest automated development builds from GitHub Actions
- [Legacy Builds by Richard Knight](http://csound.1bpm.net/builds/) — Builds for older operating systems (including Windows XP)

## Building from Source

Building Csound from source is straightforward on Linux, macOS, and Windows using CMake. Full step-by-step instructions and dependency lists are maintained in [`BUILD.md`](https://github.com/csound/csound/blob/master/BUILD.md) in the Csound GitHub repository.
