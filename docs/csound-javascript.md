---
layout: page
title: Csound JavaScript & WebAssembly
subtitle: Run the full Csound 7.0.0 audio engine in any modern browser using @csound/browser and WebAssembly.
permalink: /csound-javascript.html
---

The JavaScript / WebAssembly (`@csound/browser`) implementation allows **Csound 7.0.0** to run directly in a web browser via WebAudio and AudioWorklet, with zero native installation required. Both the [Csound Web IDE](https://ide.csound.com) and the [Csound FLOSS Manual](https://flossmanual.csound.com) use `@csound/browser` to synthesize audio in real time.

### Quick Start (`@csound/browser@7.0.0`)

You can import `@csound/browser` directly as an ES module from jsDelivr or npm:

```javascript
const csoundUrl = "https://cdn.jsdelivr.net/npm/@csound/browser@7.0.0/dist/csound.js";

async function playCsound() {
  const { Csound } = await import(csoundUrl);
  const csound = await Csound();

  await csound.setOption("-odac");
  await csound.compileOrc(`
    sr = 44100
    ksmps = 32
    nchnls = 2
    0dbfs = 1

    instr 1
      aSig = poscil(0.2, 440)
      outall(aSig)
    endin
    schedule(1, 0, 2)
  `);

  await csound.start();
}
```

### Tutorials & Documentation

- [Live Browser Examples on csound.com](/examples.html) — Inspect and run *Pling*, *Waveguide*, *Vibes*, and *Vocoder* with `@csound/browser@7.0.0`.
- [Steven Yi and Hlöðver Sigurðsson — Csound on the Web (ICSC 2022)](https://kunstmusik.github.io/icsc2022-csound-web/)
- [Victor Lazzarini's Vanilla Guide to WebAudio Csound](https://vlazzarini.github.io/vanilla/)

<div class="d-flex flex-wrap gap-2 mt-3">
  <a href="https://www.npmjs.com/package/@csound/browser" class="btn btn-cs-primary" target="_blank" rel="noopener">@csound/browser on npm</a>
  <a href="https://github.com/csound/csound/tree/master/platform/wasm-wasi/browser" class="btn btn-cs-outline" target="_blank" rel="noopener">WASM Browser Source &amp; Docs</a>
</div>
