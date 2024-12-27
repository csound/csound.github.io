---
layout: examples
title: Examples
permalink: /examples.html
---

This is a small collection of modern coding practice in Csound.

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
