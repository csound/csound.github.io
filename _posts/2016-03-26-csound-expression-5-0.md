---
layout: post
title:  "Csound-expression 5.0 is out"
date:   2016-03-26 9:00:00
categories: site news 
---

The 5.0 is out! New features:

github: [https://github.com/spell-music/csound-expression](https://github.com/spell-music/csound-expression)

hackage: [https://hackage.haskell.org/package/csound-expression](https://hackage.haskell.org/package/csound-expression)


csound-expression

* **Microtonal tunings**. We can use custom temperaments with insturments, patches, soundfonts and MIDI-instruments.
   Check out the guide on tuning and microtonal music (see also module `Csound.Tuning`).
   There are many predefined tunings (including ancient ones).
   Now we can play the authentic Bach music with Haskell! 
   See [Custom temperament. Microtonal music](https://github.com/anton-k/csound-expression/blob/master/tutorial/chapters/Tuning.md)
   for details.

* **Functions for Csound API**. We can interface with generated code through many other languages.
   We can generate the code with Haskell and the use it in other environments. we can build UI with Python or Clojure,
     we can create an Android synthesizer. See the guide section on Csound API.
     See [Csound API. Using generated code with another languages](https://github.com/anton-k/csound-expression/blob/master/tutorial/chapters/CsoundAPI.md)
     for details.

* **Padsynth algorithm** (need Csound 6.05). There are functions that makes it easy to use wonderful PADsynth algorithm,
    This algorithm is designed to make "alive" instruments, natural pads. 
    There are not only function that explore the algorithm but also new PAtches in the
    package csound-catalog that are based on it! See the section in the guide on the PADsynth.
    Lot's of padsynth instruments are mode with morphing support. We can crossfade between 2 or even 4 timbres.    
    See [Padsynth algorithm](https://github.com/anton-k/csound-expression/blob/master/tutorial/chapters/Padsynth.md)
    for details.

* **Argument modifiers** make it very convinient to modulate the rguments (apply vibrato to frequency
   or add some randomness to the parameter). See [Arguments modulation](https://github.com/anton-k/csound-expression/blob/master/tutorial/chapters/ModArg.md)
   for details.

* The **hard clipping** was substituted with **limiter**. There should be no distortion when
   amplitude goes higher than `0dbfs` value.

* Adds **Ping-pong delay** implementation. See function `pingPong` at the module `Csound.Air.Fx`.

* Adds Rory Walsh's brand **new analog filters** (need Csound 6.07). See functions `alp1`, `alp2` and `alp3` at the module `Csound.Air.Filter`.

* Bugfixes for `mixAt` function. Now it doesn't duplicates the effectful-code.
   Now `mixAt` is not a function that is based on class `At`. It becomes
   a method in it's own class called `MixAt`. That fixes the code duplication problem.

csound-catalog

* **new instruments** that are based on **PADsynth algorithm**. Check out `Csound.Patch`
   at the section on PADsynth Sharc instruments. There are new deep spiritual vedic pads
   (vibhu, rishi, agni, prakriti, rajas, avatara, bhumi).
   See [Padsynth algorithm](https://github.com/anton-k/csound-expression/blob/master/tutorial/chapters/Padsynth.md)
    for details.


csound-sampler

* adds some useful instances for class `At` and `MixAt`.