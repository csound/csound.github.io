---
layout: post
title:  "Csound-expression 4.9 is out"
date:   2015-10-29 9:00:00
categories: site news 
---

The 4.9.0 is out! New features:

github: [https://github.com/spell-music/csound-expression](https://github.com/spell-music/csound-expression)

hackage: [https://hackage.haskell.org/package/csound-expression](https://hackage.haskell.org/package/csound-expression)

csound-expression

* Functions for creation of FM-synthesizers. We can create
the whole graph of FM-units (with feedback). Check out the module `Csound.Air.Fm`

* Support for Monosynth patches. See atMono in the module `Csound.Air.Patch`

* Easy to use Binaural panning. See the module `Csound.Air.Pan`

* Construction of patches for sound fonts (`sfPatch`, `sfPatchHall`). 

* Table of tables. We can create a table that contains tables.

* Harmonic oscillators for subtractive synth: `buz` and `gbuz`

* Reverbs for patches. It's very easy to add a reverb to your  patch
 (`withSmallHall patch`, `withLargeHall patch`, etc)

* Some bug-fixes