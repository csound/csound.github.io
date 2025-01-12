---
layout: examples
title: Examples
permalink: /examples.html
---

This is a small collection of modern coding practice in Csound.  
All audio is generated in real time via [Javascript Csound](/csound-javascript.html).

## Pling

Three lines of code generating a structure of short events.

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

<button id="play" onclick="start()"><i class="fa fa-play"></i></button>
<button id="pause" onclick="pause()"><i class="fa fa-pause"></i></button>&nbsp;
<button><a href="/learn/examples/pling.csd"><i class="fa fa-download"></i></a></button>
<p><textarea class="console" cols="80" rows="5" id="console"></textarea></p>


## Vocoder

A condensed code of the classical analogue vocoder. Originally it uses a MIDI keyboard to trigger instrument 2 and change the vocoder pitch. This is here substituted by buttons.

```csound
instr 1 // dispatch
 schedule(3, 0, -1, p4, p5, p6, p7)
 chnset(diskin:a("fox.wav",1,0,1), "input")
 chnclear("excite")
endin
schedule(1, 0, -1, 80, 8000, 8, 4)

instr 2 // synth (original midi triggered)
 kfo = mtof(p4) //kfo cpsmidib 2
 chnmix(linenr:a(8, 0.01, 0.1, 0.01)*
        (vco2(1, kfo*0.99) + vco2(1, kfo*1.01)), "excite")
endin
schedule(2,0,-1,60)

instr 3  // recursive vocoder bands
 outall(butterbp(butterbp(chnget:a("excite"), p4, p4/p6), p4, p4/p6) *
     rms(butterbp(butterbp(chnget:a("input"), p4, p4/p6), p4, p4/p6)))
 inxt = p4*2^(p7/12)
 if inxt < p5 then
  schedule(p1+0.001, 0, -1, inxt, p5, p6, p7)
 endif
endin
```

<button id="play" onclick="startvoc()"><i class="fa fa-play"></i></button>
<button id="pause" onclick="pausevoc()"><i class="fa fa-pause"></i></button>&nbsp;
<button><a href="/learn/examples/vocoder-orig-cs6.csd"><i class="fa fa-download"></i></a></button>
<p><textarea class="console" cols="80" rows="5" id="console-voc"></textarea></p>

