---
layout: examples
title: "Examples: Vibes"
subtitle: Algorithmic chord progressions using 2D parameter arrays and Csound's vibes physical model (by Luís Antunes Pena, modified by Joachim Heintz).
permalink: /examples/vibes.html
---

<script type="text/javascript" src="{{ '/learn/examples/vibes.js' | relative_url }}"></script>

<div class="cs-example-player-box">
  <div class="cs-example-toolbar">
    <button id="play" type="button" class="cs-play-btn" onclick="start()">
      <i class="fa fa-play" aria-hidden="true"></i> Play
    </button>
    <button id="pause" type="button" class="cs-stop-btn" onclick="pause()">
      <i class="fa fa-pause" aria-hidden="true"></i> Pause / Resume
    </button>
    <a href="{{ '/learn/examples/vibes.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-auto" download>
      <i class="fa fa-download" aria-hidden="true"></i> Download vibes.csd
    </a>
  </div>
  <label for="console" class="visually-hidden">Csound Console Output</label>
  <textarea class="console" cols="80" rows="5" id="console" readonly placeholder="Click Play to start the Csound WebAssembly engine..."></textarea>
</div>

```csound
// load function tables
giStrike = ftgen(1,0,256,1,"marmstk1.wav",0,0,0)
giSine = ftgen(2,0,128,10,1)
garev1,garev2 init 0,0

opcode RndInt,k,kk
  kMin,kMax xin
  xout int(random:k(kMin,kMax+.9999))
endop

// generate a 2-dimensional global array with the parameters of each section
instr Params
  gkAllParams[][] init 9,8
  gkAllParams = fillarray(-15,5,1, 110,110,5,5,4,
                          -15,5,1,  55,220,4,5,6,
                          -15,5,10,220,220,4,4,2,
                          -15,5,10,220,220,3,5,3,
                          -18,5,20,220, 55,2,8,7,
                          -12,2,10, 55, 55,3,5,3,
                           -9,6,30,330,330,2,3,2,
                          -18,6,10,330,330,1,4,5,
                          -18,2,10, 30, 20,4,8,6)
  turnoff
endin
schedule("Params",0,1)

// create one tone with the vibes physical model
instr Tone
  iamp = p4
  ifreq = p5
  ihrd = random:i(0.1,0.9)
  ipos = random:i(0,1)
  ares = vibes(iamp,ifreq,ihrd,ipos,1,6,0.05,2,0.1)
  adryl,adryr pan2 linen:a(ares,0,p3,p3/2),random:i(0,1)
  out(adryl,adryr)
  irsend random 0.2, 0.4
  garev1 += irsend * adryl
  garev2 += irsend * adryr
endin
```
