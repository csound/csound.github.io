---
layout: post
title: "Csound VSCode Extension 0.8.0 released"
date: 2026-10-28 00:00:00 -0400
categories: site news
---

Csound VSCode Extension 0.8.0 is now available, bringing expanded language
support to Visual Studio Code on desktop and in the browser. Built on the
[Csound Language Server](https://github.com/PasqualeMainolfi/csound-lsp) and
[Csound Tree-sitter grammar](https://github.com/PasqualeMainolfi/tree-sitter-csound),
the extension supports Csound 7 and helps you write, check, and run Csound code
directly in the editor.

Highlights of this release include:

* Syntax-tree-based highlighting, diagnostics as you type, opcode completion,
  hover documentation, and formatting on desktop and web.
* Highlighting for Python, HTML, Cabbage JSON, and CsTest TOML embedded in CSD
  files.
* CodeLens links at the top of each file for quick access to Csound actions.
* Automatic language-server downloads and updates on desktop, with the installed
  version available offline.
* A bundled Csound manual for offline use on desktop, and access to the online
  manual from the web extension.
* A new **Csound: Save As Audio File** command (`Alt+S`) on desktop to render the
  active document to a WAV file.

The extension works in desktop VS Code as well as vscode.dev and github.dev,
where Csound runs in the browser through WebAudio. Version 0.8.0 requires
VS Code 1.82 or later. The previous `csound.htmlFilePath` setting has been
removed, as the desktop manual is now bundled with the language server.

Many thanks to **Pasquale Mainolfi** and **Rory Walsh** for contributing new
features and testing this release!

The extension is published in both the
[Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=kunstmusik.csound-vscode-plugin)
and the [Open VSX Registry](https://open-vsx.org/extension/kunstmusik/csound-vscode-plugin).
To install it in VS Code or another compatible VS Code-based editor:

1. Open the **Extensions** view from the Activity Bar, or press
   `Ctrl+Shift+X` (`Cmd+Shift+X` on macOS).
2. Search for **Csound** and select the extension by **kunstmusik**
   (extension ID: `kunstmusik.csound-vscode-plugin`).
3. Click **Install**, or **Update** if you already have an earlier version.

See the [project on GitHub](https://github.com/csound/csound-vscode-plugin) for
the full changelog and setup instructions.
