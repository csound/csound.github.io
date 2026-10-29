---
layout: post
title: "Csound VSCode Extension 0.9.0 released"
date: 2026-10-29 00:00:00 -0400
categories: site news
---

Csound VSCode Extension 0.9.0 is now available! This release focuses primarily
on improving the Web Extension experience when using Csound in browser-based
editors such as [vscode.dev](https://vscode.dev) and
[github.dev](https://github.dev).

Highlights of this release include:

* A redesigned, compact **Csound** player for the web in the bottom Panel, with
  editor and player toolbar controls, a status-bar indicator, and new
  **Pause/Resume** and **Show Output** commands. Audio continues playing even
  when the panel is collapsed or hidden, and running a file keeps focus in your
  editor.
* Support for multi-file Csound projects on the web, allowing CSD files run in
  the browser to load relative `#include` files and audio samples from your
  workspace (with a `csound.web.projectRoot` setting to scope larger
  repositories to a specific project folder).
* Smoother web playback and live coding, including stopping active or paused
  performances from anywhere with `Alt+Escape` or the toolbar, plus shared
  block evaluation (`instr ... endin` / `opcode ... endop`) and visual highlight
  feedback across desktop and web.
* Updated WebAudio Csound (`@csound/browser`) to 7.0.0 for in-browser rendering.

The extension is published in both the
[Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=kunstmusik.csound-vscode-plugin)
and the [Open VSX Registry](https://open-vsx.org/extension/kunstmusik/csound-vscode-plugin).
To install or update it in VS Code or another compatible VS Code-based editor:

1. Open the **Extensions** view from the Activity Bar, or press
   `Ctrl+Shift+X` (`Cmd+Shift+X` on macOS).
2. Search for **Csound** and select the extension by **kunstmusik**
   (extension ID: `kunstmusik.csound-vscode-plugin`).
3. Click **Install**, or **Update** if you already have an earlier version.

See the [project on GitHub](https://github.com/csound/csound-vscode-plugin) for
the full changelog and documentation.
