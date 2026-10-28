---
layout: examples
title: Interactive Csound Examples
subtitle: Hear Csound synthesis in real time directly in your browser via WebAssembly—no installation required.
permalink: /examples.html
---

All audio in these examples is synthesized live in your browser using [Csound JavaScript / WebAssembly](/csound-javascript.html) (`@csound/browser`). Click any example to listen, inspect the Csound orchestra code, or download the `.csd` file.

<div class="row g-4 my-2">
  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <span class="cs-badge cs-badge-primary">Modal Synthesis</span>
        <span class="text-muted small">Joachim Heintz</span>
      </div>
      <h3><a href="{{ '/examples/pling.html' | relative_url }}" class="text-decoration-none">Pling</a></h3>
      <p>A self-scheduling recursive instrument that excites a resonant modal filter (`mode`) with short impulses (`mpulse`), spanning crisp percussive clicks to ringing pitched tones across the stereo field.</p>
      <div class="cs-card-footer">
        <a href="{{ '/examples/pling.html' | relative_url }}" class="btn btn-cs-primary btn-sm">
          <i class="fa fa-play" aria-hidden="true"></i> Listen &amp; View Code
        </a>
        <a href="{{ '/learn/examples/pling.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-1" download>
          <i class="fa fa-download" aria-hidden="true"></i> .csd
        </a>
        <a href="https://ide.csound.com/editor/1cDgMwlXoVvB2aWnZgXr" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">
            <i class="fa fa-external-link" aria-hidden="true"></i> Open in Web IDE
        </a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <span class="cs-badge cs-badge-primary">Physical Modeling</span>
        <span class="text-muted small">Iain McCurdy</span>
      </div>
      <h3><a href="{{ '/examples/waveguide.html' | relative_url }}" class="text-decoration-none">Waveguide (Csound Haiku III)</a></h3>
      <p>A generative soundscape driven by random spline generators (`rspline`), feeding harmonic impulses into dual beaten waveguides (`wguide2`), Doppler spatialization (`vdelay`), and `reverbsc`.</p>
      <div class="cs-card-footer">
        <a href="{{ '/examples/waveguide.html' | relative_url }}" class="btn btn-cs-primary btn-sm">
          <i class="fa fa-play" aria-hidden="true"></i> Listen &amp; View Code
        </a>
        <a href="{{ '/learn/examples/waveguide.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-1" download>
          <i class="fa fa-download" aria-hidden="true"></i> .csd
        </a>
        <a href="https://ide.csound.com/editor/AQQeAaA78Ce4ZwRodCRm" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">
            <i class="fa fa-external-link" aria-hidden="true"></i> Open in Web IDE
        </a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <span class="cs-badge cs-badge-primary">Algorithmic Chords</span>
        <span class="text-muted small">Luís Antunes Pena</span>
      </div>
      <h3><a href="{{ '/examples/vibes.html' | relative_url }}" class="text-decoration-none">Vibes</a></h3>
      <p>Uses a 2D global parameter array (`gkAllParams[][]`) to sequence evolving harmonic sections played by Csound's `vibes` physical model vibraphone opcode.</p>
      <div class="cs-card-footer">
        <a href="{{ '/examples/vibes.html' | relative_url }}" class="btn btn-cs-primary btn-sm">
          <i class="fa fa-play" aria-hidden="true"></i> Listen &amp; View Code
        </a>
        <a href="{{ '/learn/examples/vibes.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-1" download>
          <i class="fa fa-download" aria-hidden="true"></i> .csd
        </a>
        <a href="https://ide.csound.com/editor/JU6CkuidYq0wkULO63Zr" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">
            <i class="fa fa-external-link" aria-hidden="true"></i> Open in Web IDE
        </a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <span class="cs-badge cs-badge-primary">Spectral / Filterbank</span>
        <span class="text-muted small">Victor Lazzarini</span>
      </div>
      <h3><a href="{{ '/examples/vocoder.html' | relative_url }}" class="text-decoration-none">Recursive Channel Vocoder</a></h3>
      <p>Multi-band Butterworth channel vocoder analyzing speech (`fox.wav`) to modulate a detuned sawtooth synth is driven by MIDI keyboard realtime input.</p>
      <div class="cs-card-footer">
        <a href="{{ '/examples/vocoder.html' | relative_url }}" class="btn btn-cs-primary btn-sm">
          <i class="fa fa-play" aria-hidden="true"></i> Listen &amp; View Code
        </a>
        <a href="{{ '/learn/examples/vocoder.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-1" download>
          <i class="fa fa-download" aria-hidden="true"></i> .csd
        </a>
        <a href="https://ide.csound.com/editor/R3gmWcFzVE29nDSGoUeY" class="btn btn-cs-outline btn-sm" target="_blank" rel="noopener">
            <i class="fa fa-external-link" aria-hidden="true"></i> Open in Web IDE
        </a>
      </div>
    </div>
  </div>
</div>

### Want to experiment with your own code?

Open the **[Csound Web IDE](https://ide.csound.com/)** to edit instruments live, browse community compositions, or follow the interactive examples in the **[Csound FLOSS Manual](https://flossmanual.csound.com/)**.
