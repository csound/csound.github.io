---
layout: page
title: Report a Bug
subtitle: Help improve Csound by reporting issues to the right repository tracker.
permalink: /bugs.html
---

Csound is an ecosystem of projects maintained by several teams. Routing your bug report to the specific tracker below ensures the maintainers see it quickly.

### A bug on this website (`csound.com`)

*Example: You click on a link and get a "page not found" error.*

Please report the issue on [this site's GitHub issue tracker](https://github.com/csound/csound.github.io/issues). If you are not on GitHub, you can also email *website* at *cs-conf.de*.

### A bug in the Csound core engine

*Example: Opcode XYZ outputs 0 when the third input argument is set to 1, although the [Reference Manual](/docs/manual/index.html) states it should output -1.*

Please file an issue on the [Csound Core Issue Tracker](https://github.com/csound/csound/issues). Please include:
- A minimal `.csd` code example that reproduces the problem
- Whether you ran Csound from the command line, a host API, or a frontend
- Your Csound version (e.g., Csound 7.0.0 or 6.18.1) and operating system

### A bug in a Frontend or Host Interface

Please report frontend or binding issues directly to their respective trackers:

- **Csound Web IDE**: [github.com/csound/web-ide/issues](https://github.com/csound/web-ide/issues)
- **Cabbage**: [forum.cabbageaudio.com](https://forum.cabbageaudio.com/c/cabbage-slugs)
- **CsoundQt**: [github.com/CsoundQt/CsoundQt/issues](https://github.com/CsoundQt/CsoundQt/issues)
- **Blue**: [github.com/kunstmusik/blue/issues](https://github.com/kunstmusik/blue/issues)
- **ctcsound (Python)**: [github.com/csound/ctcsound/issues](https://github.com/csound/ctcsound/issues)
- **csound~ (Max/MSP)**: [github.com/csound/csound_tilde/issues](https://github.com/csound/csound_tilde/issues) / [github.com/iainctduncan/csound_max/issues](https://github.com/iainctduncan/csound_max/issues)
- **csound6~ (PureData)**: [github.com/csound/csound_pd/issues](https://github.com/csound/csound_pd/issues)
- **Android**: [github.com/gogins/csound-extended/issues](https://github.com/gogins/csound-extended/issues)
- **API Examples**: [github.com/csound/csoundAPI_examples/issues](https://github.com/csound/csoundAPI_examples/issues)

### A bug in the [Csound Reference Manual](/docs/manual/index.html)

*Example: A typo in an opcode description or a broken example.*

Please report it on the [Reference Manual Issue Tracker](https://github.com/csound/manual/issues).

### A bug in the [Csound FLOSS Manual](https://flossmanual.csound.com/)

*Example: An interactive browser example fails to play.*

Please report it on the [FLOSS Manual Issue Tracker](https://github.com/csound-flossmanual/csound-floss/issues).
