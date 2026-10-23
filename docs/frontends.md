---
layout: page
title: Csound Frontends & Editors
subtitle: Choose the right creative environment for your workflow—from zero-install browser coding to VST plugin development and timeline composition.
permalink: /frontends.html
---

While Csound can be run directly from the command line (`csound mypiece.csd`), most musicians and sound designers work inside a **Frontend**. Frontends wrap the Csound audio engine with a code editor, interactive GUI widgets, transport controls, and documentation lookup.

<div class="row g-4 my-3">
  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <h3 class="mb-0">Csound Web IDE</h3>
        <span class="cs-badge cs-badge-primary">Browser / Cloud</span>
      </div>
      <p>Run Csound 7 directly in any modern browser via WebAssembly. Requires zero installation and includes live code evaluation, GUI widgets, project sharing, and built-in examples.</p>
      <div class="cs-card-footer d-flex gap-2">
        <a href="https://ide.csound.com/" class="btn btn-cs-primary btn-sm" target="_blank" rel="noopener">Launch Web IDE</a>
        <a href="https://github.com/csound/web-ide" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">GitHub</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <h3 class="mb-0">CsoundQt</h3>
        <span class="cs-badge">Desktop IDE</span>
      </div>
      <p>The classic cross-platform desktop editor for Csound. Features an integrated widget panel, live oscilloscope, interactive Reference Manual browser, and hundreds of ready-to-play examples.</p>
      <div class="cs-card-footer d-flex gap-2">
        <a href="https://csoundqt.github.io/" class="btn btn-cs-primary btn-sm" target="_blank" rel="noopener">Website</a>
        <a href="https://csoundqt.github.io/pages/documentation.html" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">CsoundQt Docs</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <h3 class="mb-0">Cabbage</h3>
        <span class="cs-badge">VST / AU Plugins</span>
      </div>
      <p>Design custom instrument and effect interfaces with declarative markup and export your Csound patches as VST3, AU, CLAP plugins or standalone applications for macOS, Windows, and Linux.</p>
      <div class="cs-card-footer d-flex gap-2">
        <a href="https://cabbageaudio.com/" class="btn btn-cs-primary btn-sm" target="_blank" rel="noopener">Website</a>
        <a href="https://cabbageaudio.com/docs/introduction/" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">Cabbage Docs</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <h3 class="mb-0">Blue</h3>
        <span class="cs-badge">Timeline Composition</span>
      </div>
      <p>A modular music composition environment built on Csound featuring a polyphonic timeline, soundObject libraries, Python/Clojure/JavaScript score generation, and parameter automation.</p>
      <div class="cs-card-footer d-flex gap-2">
        <a href="https://blue.kunstmusik.com/" class="btn btn-cs-primary btn-sm" target="_blank" rel="noopener">Website</a>
        <a href="https://blue.kunstmusik.com/#documentation" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">Blue Docs</a>
      </div>
    </div>
  </div>
</div>

### Code Editor Extensions

Prefer working in your favorite text editor? Official and community Csound packages are available for:

- **Visual Studio Code**: [Csound VS Code Extension](https://marketplace.visualstudio.com/items?itemName=kunstmusik.csound) (syntax highlighting, opcode hover documentation, and direct audio evaluation)
- **Vim / Neovim**: [csound-vim](https://github.com/luisjure/csound-vim)
- **Emacs**: [csound-mode](https://github.com/hlolli/csound-mode)
