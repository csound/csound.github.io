---
layout: post
title:  "Csound-expression 5.1 is out"
date:   2016-12-01 9:00:00
categories: site news 
---

New  release of Haskell to Csound computer music framework

github: [https://github.com/spell-music/csound-expression](https://github.com/spell-music/csound-expression)

hackage: [https://hackage.haskell.org/package/csound-expression](https://hackage.haskell.org/package/csound-expression)

csound-expression


* **New data type for Patches!** This change is incompatible but it brings better support for playing patches live!
   The polyphonic and monophonic patches are united with single data-type so we can play them with the same functions.
   Also now we can create layered patches to play several patches at the same time and also we can split the keyboard
   on sections to play different patches on different sections. It's useful feature available in many modern synthesizers.
   But here we can include any number of layers! and we can mix mono and poly instruments together! 

   See the [guide on patches](https://github.com/spell-music/csound-expression/blob/master/tutorial/chapters/Patches.md) to read the details.

* **Hard and soft sync**. Lots of functions added for hard and soft sync. Check out the module `Csound.Air.Wave.Sync`.

* **Morpheus is here**. New cool granular synthesizer is included. It's based on partikkel opcode. 
   The aim is to simplify the work-flow with partikkel opcode. The API is experimental right now and might change.
   See the module `Csound.Air.Granular.Morpheus` for details.

* **Rewrite for filters**. Filters get new names that suppose the audio-quality of the filter. Also many filters were redesigned
   to unify the parameters (order of arguments and ranges). Check out the module `Csound.Air.Filter`.

* **Many great filters were added** thanks to the work of Steven Yi. Now we can use 

   * zero-delay filters: `zlp`, `zhp`, `zbp`, `zladder`, `zdf2`, `zdf4`.

   * diode ladder filter (famous acid sound of TB-303): `diode`, `linDiode`

   * Korg 35 filters: `korg_lp`, `linKorg_lp`, `korg_hp`

   New classical analog-like filters:

   * Chebyshev type I and II low pass filters: lpCheb1, lpCheb2 (also there are high-pass versions)

   * new butterworth filters: `clp`

  Named filters with specific character suggested with a name: `plastic`, `wobble`, `trumpy`, `harsh`.

* **Transforming the audio with impulse responses now is super easy**. Check out the new functions `monoIR`, `stereoIR`
   from the module `Csound.Air.Fx`. With those functions we can easily add complicated and beautiful reverbs
   from natural environments or classical reverberation units. There are plenty IR resources you can find out on the WEB.
   Also it adds the cool `zconv` function for zero convolution delay kindly provided by Victor Lazzarini.

* **Cabbage support**. Adds full support for building [cabbage](http://cabbageaudio.com/) interfaces. Checkout the module `Csound.Cabbage`.
  We can create vst-plugins with it!  Still needs help for testing. We can check out the tutorial on how to build cabbage interfaces
  with csound-expression library: [Cabbage guide](https://github.com/spell-music/csound-expression/blob/master/tutorial/chapters/CabbageTutorial.md).

* **Useful aliases for classic reverbs** with single dry-wet ratio as a parameter: `room`, `chamber`, `hall`, `cave`.
  We can use it like this: `dac $ hall 0.25 mySynt` instead of `dec $ mixAt 0.25 largeHall2 mySynt`.

* **Raw waveforms for analogue-like oscillators**: `rawSaw`, `rawTri`, `rawSqr` non-band limited based
  on table lookup. Can be useful for LFOs or more light-weight versions of oscillators than `saw`, `tri` or `sqr`.

* **mul' new scaling function**. Scaling with side-effects. Can be useful to scale with random envelope.

* **Adds table read and write opcodes**. Adds opcodes `tablewa`, `tablew`, `readTab`, `readTable`, `readTable3`, `readTablei`.
    See the module `Csound.Tab` for details.

* **Convenient aliases for reading from audio-files to tables**. New names `wavLeft`, `wavRight`, `mp3Left`, `mp3Right` to read  
   audio by channels. Also we can read both channels with functions `wavs` and `mp3s`.

* **Support for up to 8 outputs**. More instances for `RenderCsd` were added. Now we can play back up to 8 signals at the same time!

* **Useful option to suppress the event printing on the screen**. By default the Csound prints out every message on the screen (with time stamps and amplitudes).
    Now we have useful function `noTrace` to suppress those messages. Just write `dacBy noTrace $ mySigs` to stop them.

* **Adds More option setters for RT-audio engines**. New option setters: `setAlsa`, `setMme`, `setCoreAudio`.
    Also it fixes the name of the RT-engine for OSX.

csound-sampler

* **Adds randomized patterns** with which we can skip the beats in the fixed pattern by given probability: `rndPat` and `rndPat'`.
