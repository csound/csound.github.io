---
layout: sidebar_links
title: Coding Tips
---


The following are a list of suggestions to help write readable Csound code, and encourage good coding culture. They are by no means exhaustive, but might be particularly important for anyone learning Csound.

### Variable names
Variables carry a meaning. This meaning should be mirrored in their names. An uppercase character after the type-specifying leading *i|k|a|f* can lead to more readable code:

``` csound

//meaningful
aLeft, aRight pan2 aNoise, kPan

//anonym
a1, a2 pan2 asig, ksig
```

Some Csound programmers avoid abbreviations at all, whilst others like to use them to avoid very long names. The general advise is use long names while starting off as it will make your code easier to review and debug:

``` csound

//long
aLeft, aRight pan2 aWhiteNoise, kPanning

//short
aL, aR pan2 aWtNoise, kPan
```

 
### Instrument names
Instruments are the main building blocks in Csound. Beginners are usually encouraged to use instrument names rather than numbers. The instrument's name should describe what the instrument does:

``` csound

//more meaningful
instr TriggerGrains
 ...
endin

instr OneGrain
 ...
endin

//abstract
instr 1
 ...
endin

instr 10
 ...
endin
```

(When Csound runs, it will transform all instrument names to numbers. This number can be retrieved via the [*nstrnum*](https://csound.com/docs/manual/nstrnum.html) opcode.)

### Indentation
The use of indented blocks makes code far easier to read. For example, the following instrument blocks have been indented by one and two spaces:

``` csound

//one space
instr TriggerGrains
 kTrigFreq init 50
 kTrig metro kTrigFreq
 if kTrig == 1 then
  event "i", "OneGrain", 0, 1/kTrigFreq
  kTrigFreq random 20, 100
 endif
endin

//two spaces
instr TriggerGrains
  kTrigFreq init 50
  kTrig metro kTrigFreq
  if kTrig == 1 then
    event "i", "OneGrain", 0, 1/kTrigFreq
    kTrigFreq random 20, 100
  endif
endin
```

### Program flow
The lines of code in a Csound orchestra should clearly represent each instrument's program flow. For long instruments, the use of empty lines to separate logical blocks is encouraged.

``` csound

//clear flow
instr Transpose

 aIn = gaMic
 iFFTSize = 1024
 iWinSize = iFFTSize
 iHopSize = iFFTSize/4
 iWinShape = 1
 kCent chnget "cent"
 iPan random .1, .9

 fIn pvsanal aIn, iFFTSize, iHopSize, iWinSize, iWinShape
 fTranspose pvscale fIn, cent(kCent)

 aTranspose pvsynth fTranspose
 aLeft, aRight pan2 aTranspose, iPan
 out aLeft, aRight

endin

//unclear
instr Transpose
 iHopSize = 256
 aIn = gaMic
 iFFTSize = 1024
 iWinSize = 1024
 iWinShape = 1
 fIn pvsanal aIn, iFFTSize, iHopSize, iWinSize, iWinShape
 kCent chnget "cent"
 fTranspose pvscale fIn, cent(kCent)
 iPan random .1, .9
 aTranspose pvsynth fTranspose
 aLeft, aRight pan2 aTranspose, iPan
 out aLeft, aRight
endin
```

### User Defined Opcodes
Writing UDOs is a big opportunity to simplify code as it lets you create abstractions of commonly used operations. Compare the following two programs:

``` csound

//general UDO routines (which can be reused in other code) ...
opcode loadSample, i, S
 Sample xin
  iNum ftgen 0, 0, 0, -1, Sample, 0, 0, 0
 xout iNum
endop

opcode randInt, i, ii
 iMin, iMax xin
 iRand random iMin, iMax-0.000001
 iRandInt = int(iRand)
 xout iRandInt
endop

opcode randEl, i, i[]
 iArr[] xin
 iEl = iArr[randInt(0,lenarray(iArr))]
 xout iEl
endop

//... then the actual code here
giBeats loadSample "beats.wav"
giSeries[] fillarray 7, 3, 1, 5, 6
giStart randEl giSeries
```

``` csound

//all in one (shorter but less readable)
giBeats ftgen 0, 0, 0, -1, "beats.wav", 0, 0, 0
giSeries[] fillarray 7, 3, 1, 5, 6
giStart = giSeries[int(random(0,lenarray(giSeries-0.00001)))]
```

### Order of instruments
If named instruments are used, Csound executes the instruments exactly in the order they are written in the program. It's a good idea to try to group the instruments as much as possible to coincide with this order.

``` csound

//better
instr Mic_in
 ...
endin

instr MIDI_in
 ...
endin

instr FirstEffect
 ...
endin

instr SecondEffect
 ...
endin

instr Mixer
 ...
endin

//worse
instr Mic_in
 ...
endin

instr SecondEffect
 ...
endin

instr Mixer
 ...
endin

instr FirstEffect
 ...
endin

instr MIDI_in
 ...
endin

```

### Constants

Each Csound program normally starts with assigning a value to sr (sample rate), ksmps (number of samples in one control cycle), nchnls (number of channels), 0dbfs (value assigned to zero dB full scale):

``` csound

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1
```
The sr, ksmps and nchnls will change according to the situation. 0dbfs should always be set to 1. The usage of ksmps is preferable to using kr. (Users writing code for audio plugins using [Cabbage](https://cabbageaudio.com) should leave out the sr assignment so that it can be set by the host)

### Globals

Global variables and arrays should be declared on top of your program, after the header and before the first instrument:

``` csound

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

giPitch init 72
gkTime init 0
gSFiles[] directory "."
```

### Tables
Loading function tables with [*ftgen*](https://csound.com/docs/manual/ftgen.html) in the orchestra usually makes code more readable than loading tables in the score section. This is because one can choose meaningful variable names for them rather than assigning a number. For example, consider the following two version of the same thing:

``` csound

giImpulse ftgen 0, 0, 1024, 10, 1, 1, 1, 1
giHalfSine ftgen 0, 0, 1024, 9, .5, 1, 0

instr Synthesis
 aSynth poscil .2, 400, giImpulse
 aOut poscil aSynth, 1/p3, giHalfSine
 out aOut, aOut
endin
```
``` csound

instr Synthesis
 aSynth poscil .2, 400, 1
 aOut poscil aSynth, 1/p3, 2
 out aOut, aOut
endin
//(and in the score section:)
f 1 0 1024 10 1 1 1 1
f 2 0 1024 9 .5 1 0
```


### Score
Score events can often be replicated through events triggered in instruments. Compare the following two examples in which the first one encapsulates a sequence of events in an instrument, whilst the second one writes one line of code for each event.

``` csound

<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr Sequence
  iStartTime init 0
  while iStartTime &lt; 12 do
      schedule "Synth", iStartTime, 1, 60+iStartTime
      iStartTime += 1
  od
endin
 
instr Synth
  iMidiKey = p4
  aEnvelope linen 1, .5, p3, .5
  aOutput poscil aEnvelope, mtof(iMidiKey)
  out aOutput, aOutput
endin

</CsInstruments>
<CsScore>
i "Sequence" 0 10
</CsScore>
</CsoundSynthesizer>
```

``` csound

<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr Synth
  aEnvelope linen 1, .5, p3, .5
  aOutput poscil aEnvelope, mtof(p4)
  out aOutput, aOutput
endin

</CsInstruments>
<CsScore>
i"Synth" 0 1 60
i"Synth" 1 1 61
i"Synth" 2 1 62
i"Synth" 3 1 63
i"Synth" 4 1 64
i"Synth" 5 1 65
i"Synth" 6 1 66
i"Synth" 7 1 67
i"Synth" 8 1 68
i"Synth" 9 1 69
i"Synth" 10 1 70
i"Synth" 11 1 71
</CsScore>
</CsoundSynthesizer>
```

### Traditional vs. functional style
Since Csound 6, code can be written not only in the traditional Csound style, but also in a style which might be more familiar to those coming from other programming languages:

``` csound

//old style
instr FM
 kModFreq linseg 100, p3, 200
 kModAmp expseg 10, p3, 100
 aMod poscil kModAmp, kModFreq
 aCar poscil .5, 400+aMod
 out aCar, aCar
endin

//new style line by line
instr FM
 kModFreq = linseg:k(100,p3,200)
 kModAmp = expseg:k(10,p3,100)
 aMod = poscil:a(kModAmp,kModFreq)
 aCar = poscil:a(.5,400+aMod)
 out(aCar,aCar)
endin

//new style compressed
instr FM
 aMod = poscil:a(expseg:k(10,p3,100), linseg:k(100,p3,200))
 aCar = poscil:a(.5, 400+aMod)
 out(aCar,aCar)
endin
```
Both ways can be used to write readable code. A good example for new style coding is [Steven Yi's collection of live coding instruments](https://github.com/kunstmusik/csound-live-code/blob/master/livecode.orc).

