---
layout: page
title: Opcode Finder
subtitle: Navigate Csound's 1,500+ unit generators by synthesis technique and signal processing category.
permalink: /opcode-finder.html
---

Csound includes one of the most comprehensive DSP libraries in audio programming. If you are not sure which opcode to choose for a task, explore the curated starting points below or consult the full category overviews.

<div class="d-flex flex-wrap gap-2 mb-4">
  <a href="{{ '/docs/manual/PartOpcodesOverview.html' | relative_url }}" class="btn btn-cs-primary">
    <i class="fa fa-list" aria-hidden="true"></i> Reference Manual Opcode Overview
  </a>
  <a href="https://flossmanual.csound.com/miscellanea/opcode-guide" class="btn btn-cs-outline" target="_blank" rel="noopener">
    <i class="fa fa-compass" aria-hidden="true"></i> FLOSS Manual Curated Opcode Guide
  </a>
</div>

<div class="row g-4">
  <div class="col-md-6">
    <div class="cs-card">
      <h3><i class="fa fa-area-chart text-muted me-2" aria-hidden="true"></i>Oscillators &amp; Phasors</h3>
      <p>Table-lookup oscillators, band-limited analog waveforms, and dynamic spectrum generators.</p>
      <p class="mb-2 small">
        <strong>Essential Opcodes:</strong>
        <a href="{{ '/docs/manual/poscil.html' | relative_url }}"><code>poscil</code></a>,
        <a href="{{ '/docs/manual/vco2.html' | relative_url }}"><code>vco2</code></a>,
        <a href="{{ '/docs/manual/oscili.html' | relative_url }}"><code>oscili</code></a>,
        <a href="{{ '/docs/manual/buzz.html' | relative_url }}"><code>buzz</code></a>,
        <a href="{{ '/docs/manual/gbuzz.html' | relative_url }}"><code>gbuzz</code></a>,
        <a href="{{ '/docs/manual/phasor.html' | relative_url }}"><code>phasor</code></a>
      </p>
      <div class="cs-card-footer">
        <a href="{{ '/docs/manual/SiggenBasic.html' | relative_url }}" class="small fw-bold text-decoration-none">Browse Basic Signal Generators &rarr;</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <h3><i class="fa fa-sliders text-muted me-2" aria-hidden="true"></i>Filters &amp; Resonators</h3>
      <p>Zero-delay feedback filters, classic analog ladder models, state-variable, Butterworth, and modal filters.</p>
      <p class="mb-2 small">
        <strong>Essential Opcodes:</strong>
        <a href="{{ '/docs/manual/zdf_ladder.html' | relative_url }}"><code>zdf_ladder</code></a>,
        <a href="{{ '/docs/manual/moogladder.html' | relative_url }}"><code>moogladder</code></a>,
        <a href="{{ '/docs/manual/svfilter.html' | relative_url }}"><code>svfilter</code></a>,
        <a href="{{ '/docs/manual/butterlp.html' | relative_url }}"><code>butterlp</code></a>,
        <a href="{{ '/docs/manual/mode.html' | relative_url }}"><code>mode</code></a>,
        <a href="{{ '/docs/manual/reson.html' | relative_url }}"><code>reson</code></a>
      </p>
      <div class="cs-card-footer">
        <a href="{{ '/docs/manual/SigmodStandard.html' | relative_url }}" class="small fw-bold text-decoration-none">Browse Standard Filters &rarr;</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <h3><i class="fa fa-line-chart text-muted me-2" aria-hidden="true"></i>Envelopes, LFOs &amp; Random</h3>
      <p>Linear and exponential breakpoints, MIDI-ready ADSRs, random splines, and stochastic generators.</p>
      <p class="mb-2 small">
        <strong>Essential Opcodes:</strong>
        <a href="{{ '/docs/manual/linseg.html' | relative_url }}"><code>linseg</code></a>,
        <a href="{{ '/docs/manual/expseg.html' | relative_url }}"><code>expseg</code></a>,
        <a href="{{ '/docs/manual/transeg.html' | relative_url }}"><code>transeg</code></a>,
        <a href="{{ '/docs/manual/madsr.html' | relative_url }}"><code>madsr</code></a>,
        <a href="{{ '/docs/manual/rspline.html' | relative_url }}"><code>rspline</code></a>,
        <a href="{{ '/docs/manual/randomi.html' | relative_url }}"><code>randomi</code></a>
      </p>
      <div class="cs-card-footer">
        <a href="{{ '/docs/manual/SiggenLineexp.html' | relative_url }}" class="small fw-bold text-decoration-none">Browse Envelope Generators &rarr;</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <h3><i class="fa fa-braille text-muted me-2" aria-hidden="true"></i>Granular &amp; Sample Playback</h3>
      <p>Synchronous/asynchronous granular synthesis, time-stretching, pitch-shifting, and soundfile streaming.</p>
      <p class="mb-2 small">
        <strong>Essential Opcodes:</strong>
        <a href="{{ '/docs/manual/partikkel.html' | relative_url }}"><code>partikkel</code></a>,
        <a href="{{ '/docs/manual/grain3.html' | relative_url }}"><code>grain3</code></a>,
        <a href="{{ '/docs/manual/fog.html' | relative_url }}"><code>fog</code></a>,
        <a href="{{ '/docs/manual/mincer.html' | relative_url }}"><code>mincer</code></a>,
        <a href="{{ '/docs/manual/diskin2.html' | relative_url }}"><code>diskin2</code></a>,
        <a href="{{ '/docs/manual/flooper2.html' | relative_url }}"><code>flooper2</code></a>
      </p>
      <div class="cs-card-footer">
        <a href="{{ '/docs/manual/SiggenGranular.html' | relative_url }}" class="small fw-bold text-decoration-none">Browse Granular Opcodes &rarr;</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <h3><i class="fa fa-signal text-muted me-2" aria-hidden="true"></i>Spectral DSP (Phase Vocoder / PVS)</h3>
      <p>Real-time streaming FFT analysis, spectral morphing, filtering, blurring, and resynthesis (`fsig`).</p>
      <p class="mb-2 small">
        <strong>Essential Opcodes:</strong>
        <a href="{{ '/docs/manual/pvsanal.html' | relative_url }}"><code>pvsanal</code></a>,
        <a href="{{ '/docs/manual/pvsynth.html' | relative_url }}"><code>pvsynth</code></a>,
        <a href="{{ '/docs/manual/pvsblur.html' | relative_url }}"><code>pvsblur</code></a>,
        <a href="{{ '/docs/manual/pvsmorph.html' | relative_url }}"><code>pvsmorph</code></a>,
        <a href="{{ '/docs/manual/pvshift.html' | relative_url }}"><code>pvshift</code></a>,
        <a href="{{ '/docs/manual/pvsfreeze.html' | relative_url }}"><code>pvsfreeze</code></a>
      </p>
      <div class="cs-card-footer">
        <a href="{{ '/docs/manual/SpectralRealTime.html' | relative_url }}" class="small fw-bold text-decoration-none">Browse Real-Time Spectral Opcodes &rarr;</a>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="cs-card">
      <h3><i class="fa fa-bell-o text-muted me-2" aria-hidden="true"></i>Physical Modeling &amp; Reverbs</h3>
      <p>Waveguide strings/plates, plucked/struck models, feedback delay networks, and convolution reverbs.</p>
      <p class="mb-2 small">
        <strong>Essential Opcodes:</strong>
        <a href="{{ '/docs/manual/wguide2.html' | relative_url }}"><code>wguide2</code></a>,
        <a href="{{ '/docs/manual/wgpluck2.html' | relative_url }}"><code>wgpluck2</code></a>,
        <a href="{{ '/docs/manual/vibes.html' | relative_url }}"><code>vibes</code></a>,
        <a href="{{ '/docs/manual/reverbsc.html' | relative_url }}"><code>reverbsc</code></a>,
        <a href="{{ '/docs/manual/freeverb.html' | relative_url }}"><code>freeverb</code></a>,
        <a href="{{ '/docs/manual/ftconv.html' | relative_url }}"><code>ftconv</code></a>
      </p>
      <div class="cs-card-footer">
        <a href="{{ '/docs/manual/SigmodReverbn.html' | relative_url }}" class="small fw-bold text-decoration-none">Browse Reverberators &amp; Models &rarr;</a>
      </div>
    </div>
  </div>
</div>
