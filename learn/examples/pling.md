---
layout: examples
title: "Examples: Pling"
permalink: /examples/pling.html
---

<script type="text/javascript" src="/learn/examples/pling.js"></script>

Three lines of code generating a structure of short events.

<button id="play" onclick="start()"><i class="fa fa-play"></i></button>
<button id="pause" onclick="pause()"><i class="fa fa-pause"></i></button>&nbsp;
<button><a href="/learn/examples/pling.csd"><i class="fa fa-download"></i></a></button>
<p><textarea class="console" cols="80" rows="5" id="console"></textarea></p>

```csound
instr Pling
  // generate one tone in a wide range between short/noisy and long/pitched
  aMode = mode(mpulse(ampdb(random:i(-22,0)),p3),mtof:i(random:i(80,100)),10^(p3-1))
  // distribute anywhere in the stereo field and output
  aL,aR pan2 aMode,random:i(0,1)
  out(aL,aR)
  // call the next instance of this instrument
  schedule("Pling",rnd:i(1),random:i(1,4))
endin
schedule("Pling",0,3)
```



