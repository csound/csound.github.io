---
layout: examples
title: "Examples: Pling"
subtitle: Three lines of DSP code generating a self-scheduling structure of modal percussion events (by Joachim Heintz).
permalink: /examples/pling.html
---

<script src="{{ '/assets/js/csound-example-player.js' | relative_url }}"
        data-csd="{{ '/learn/examples/pling.csd' | relative_url }}"></script>

<div class="cs-example-player-box">
  <div class="cs-example-toolbar">
    <button id="play" type="button" class="cs-play-btn" onclick="start()">
      <i class="fa fa-play" aria-hidden="true"></i> Play
    </button>
    <button id="pause" type="button" class="cs-stop-btn" onclick="pause()">
      <i class="fa fa-pause" aria-hidden="true"></i> Pause / Resume
    </button>
    <a href="{{ '/learn/examples/pling.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-auto" download>
      <i class="fa fa-download" aria-hidden="true"></i> Download pling.csd
    </a>
  </div>
  <label for="console" class="visually-hidden">Csound Console Output</label>
  <textarea class="console" cols="80" rows="5" id="console" readonly placeholder="Click Play to start the Csound WebAssembly engine..."></textarea>
</div>

```csound
instr Pling
  // generate one sound in a wide range between short/noisy and long/pitched
  plg:a = mode(mpulse(ampdb(random(-22,0)),p3), mtof(random(80,100)),10^(p3-1))
  // distribute anywhere in the stereo field and output
  out(pan2:a[](plg,random(0,1)))
  // call the next instance of this instrument
  schedule(Pling,rnd(1),random(1,4))
endin
schedule(Pling,0,1)
```
