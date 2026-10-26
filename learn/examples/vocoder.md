---
layout: examples
title: "Examples: Recursive Channel Vocoder"
subtitle: Connect MIDI keyboard to play multi-band Butterworth channel vocoder (by Victor Lazzarini). 
permalink: /examples/vocoder.html
---

<script type="text/javascript" src="{{ '/learn/examples/vocoder.js' | relative_url }}"></script>

<div class="cs-example-player-box">
  <div class="cs-example-toolbar">
    <button id="play" type="button" class="cs-play-btn" onclick="start()">
      <i class="fa fa-play" aria-hidden="true"></i> Play
    </button>
    <button id="pause" type="button" class="cs-stop-btn" onclick="pause()">
      <i class="fa fa-pause" aria-hidden="true"></i> Pause / Resume
    </button>
    <a href="{{ '/learn/examples/vocoder.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-auto" download>
      <i class="fa fa-download" aria-hidden="true"></i> Download vocoder.csd
    </a>
  </div>
  <label for="console" class="visually-hidden">Csound Console Output</label>
  <textarea class="console" cols="80" rows="5" id="console" readonly placeholder="Click Play to start the Csound WebAssembly engine..."></textarea>
</div>

```csound
massign 0, 2

instr 1 // dispatch
 schedule(3, 0, -1, p4, p5, p6, p7)
 chnset(diskin:a("fox.wav",1,0,1), "input")
 chnclear("excite")
endin
schedule(1, 0, -1, 80, 8000, 8, 4)

instr 2 // MIDI synth
 fo:k cpsmidib 2
 chnmix(linenr:a(ampmidi(8), 0.01, 0.1, 0.01)*
        (vco2(1, fo*0.99) + vco2(1, fo*1.01)), "excite")
endin

instr 3  // recursive vocoder bands
 out(butterbp(butterbp(chnget:a("excite"), p4, p4/p6), p4, p4/p6) *
     rms(butterbp(butterbp(chnget:a("input"), p4, p4/p6), p4, p4/p6)))
 nxt:i = p4*2^(p7/12)
 if nxt < p5 then
  schedule(p1+0.001, 0, -1, nxt, p5, p6, p7)
 endif
endin
```
