---
layout: page
title: Get Started with Csound
subtitle: Play your first sound in seconds in your browser, then learn how instruments, opcodes, envelopes, and scores work together.
permalink: /get-started.html
toc:
  - title: "1. Try Csound Online"
    href: "#try-csound-online"
  - title: "2. Desktop Frontends"
    href: "#csound-frontends"
  - title: "3. Csound File & Syntax"
    href: "#csound-syntax"
  - title: "4. Rates & Variables (i, k, a)"
    href: "#variables"
  - title: "5. Opcodes & Functional Style"
    href: "#opcodes"
  - title: "6. Score Lines (p-fields)"
    href: "#score-lines"
  - title: "7. Your First Synthesizer"
    href: "#your-first-synthesiser"
  - title: "8. Envelopes & Filters"
    href: "#envelope"
  - title: "9. MIDI Control"
    href: "#controlling-your-instrument-with-midi"
  - title: "10. Your First Audio Effect"
    href: "#your-first-effect"
  - title: "11. Recording to Disk"
    href: "#writing-sounds-to-disk"
  - title: "12. Common Errors & Next Steps"
    href: "#common-errors"
---

<div class="cs-card cs-card-featured mb-4">
  <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
    <div>
      <span class="cs-badge cs-badge-primary mb-2">Fastest Way to Begin</span>
      <h3 class="mb-1">Make your first sound in 30 seconds — no installation needed</h3>
      <p class="mb-0">Open the interactive starter project in the <strong>Csound Web IDE</strong>, press <strong>Play</strong> to hear a 550 Hz tone, then change <code>550</code> to <code>660</code> on line 11 and press Play again.</p>
    </div>
    <div class="d-flex flex-wrap gap-2">
      <a href="https://ide.csound.com/editor/21zOuoahdiJj8DnT7UN8" class="btn btn-cs-primary" target="_blank" rel="noopener">
        <i class="fa fa-play" aria-hidden="true"></i> Open Starter Project in Web IDE
      </a>
      <a href="{{ '/download.html' | relative_url }}" class="btn btn-cs-outline">
        Install on Desktop
      </a>
    </div>
  </div>
</div>

## Try Csound Online!

Csound code can run in any browser without installing Csound. The main site for it is:
  
  * [Csound Web IDE](https://ide.csound.com)

To try it out, you can open any project, for instance 
[Getting Started 1](https://ide.csound.com/editor/21zOuoahdiJj8DnT7UN8). Push the Play button, 
and you should hear a tone. Change the code, for instance in line 11 replace `550` by `660`,
and you will hear 660 Hz as frequency of this tone.

The [Csound FLOSS Manual](https://flossmanual.csound.com/introduction/preface) can also
be used in this interactive way. Try out the [Getting Started](https://flossmanual.csound.com/get-started/GS-01)
there, with examples and exercises.


## Csound Frontends

The classical way to use Csound is to install a "Frontend". A frontend provides a Code Editor,
and you can execute the code by running Csound. Note that Csound is running "inside"
the frontend, so usually you will have to install at first Csound via the
[Download Page](https://csound.com/download.html), and then one of the Frontends.
The most popular are:

* [Cabbage](https://cabbageaudio.com/)
* [CsoundQt](https://csoundqt.github.io/)
* [Blue](https://blue.kunstmusik.com)

Some general installation instructions can be found [here](https://flossmanual.csound.com/how-to/installation).

Csound also runs out of the box on [Android](https://play.google.com/store/apps/details?id=com.csounds.Csound6&hl=en).


## Csound syntax

We write Csound code in a text file with 
[XML](https://www.w3schools.com/xml/) type tags. The most
important sections are the `<CsInstruments>` and `<CsScore>` sections. 
Simply put, `<CsInstruments>` defines how our instruments will sound,
while `<CsScore>` defines when and how long they will sound. 
Presented below is the typical document structures for a single unified Csound file.

```csound
// start of the csound code
<CsoundSynthesizer>

<CsOptions>
// this section tells Csound how to interact with various devices and hardware
</CsOptions>

<CsInstruments>
// this section contains instrument definitions
</CsInstruments>  

<CsScore>
// this section tells Csound when and how to perform instruments defined
// in the CsInstruments section above. 
</CsScore>

</CsoundSynthesizer>
// end of the Csound code
```

The most important part of such a file is the `<CsInstruments>` section.
Here we combine unit generators and encapsulate them in software instruments.

When we describe Csound syntax (the grammar of Csound as audio programming language),
we mean this `<CsInstruments>` section which is also called "orchestra".

The `<CsScore>` section uses a different syntax. Basically this "score" calls 
the "instruments" at specified start times and for certain durations. It is 
a list of instrument events.

We will begin by introducing the `<CsInstruments>` syntax.
Basic components are: 
* [keywords](#keywords)
* [constants](#constants)
* [variables](#variables)
* [opcodes](#opcodes)
* [operators](#operators) and 
* [comments](#comments).


### Instrument code

All Csound code is case sensitive. 
That means that `aSig` and `asig` are two different names.


#### Keywords

Keywords are special reserved words that have a unique function and meaning. The two most commonly
used keywords in the Csound language are `instr` and `endin`. These two keywords define an
instrument block which contains instructions on how an instrument functions. Each instrument must be
given a unique name or number which follows the `instr` keyword.

```csound
instr 1
;do stuff
endin

instr DoStuff
;do stuff
endin
```


#### Constants

System constants are found in the CsInstruments *header section*. The *header section* appears
before any instrument block and sets up vital information about: 
+ **sr**: the sample rate (number of audio samples per second)
+ **ksmps**: the number of samples in an audio vector or block of samples
+ **nchnls**: the number of audio channels to use
+ **0dbfs**: which number to be set as zero decibel full scale

These are common settings:

```csound
sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

instr 1
;do stuff
endin
```


#### Variables

Variables are used to store data. An audio programming language produces a
stream of numbers, so the most important variable types in Csound contain numbers.

The variable types for numbers depend on this question: In which rate can the
number be changed?

If the number can only be **set at the start of an instrument**, we call it 
an **i-rate** (initialization) variable. In legacy Csound these variables always start with 
a lower-case **i**, for instance `iduration`. In Csound 7, we can use any name and declare the type as **:i**, 
for instance `duration:i`.

If the number is **constantly updated during the performance of an instrument**,
we call it a **k-rate** (control-rate) variable. In legacy Csound these variables always start with 
a lower-case **k**, for instance `kfrequency`. In Csound 7, we can use any name and declare the type as **:k**, 
for instance `frequency:k`.

If the variable contains a number **for every audio sample**, we call it an
**a-rate** (audio-rate) variable. In legacy Csound these variables always start with 
a lower-case **a**, for instance `aleft`. In Csound 7, we can use any name and declare the type as **:a**, 
for instance `reverb_send:a`.

A more in depth explanation of these different variable types can be found in the
[Csound FLOSS Manual](https://flossmanual.csound.com/csound-language/initialization-and-performance-pass). 

Csound also has other types of variables such as 
[Strings](https://flossmanual.csound.com/csound-language/local-and-global-variables#variable-types) and 
[Arrays](https://flossmanual.csound.com/csound-language/arrays).
However for the moment, we only need the variable types already described to continue this tutorial.


#### Opcodes

Opcodes do things. They are the core of each and every Csound instrument. What they do is usually
described by their name. `reverb` for example applies a reverb to an audio signal while `random`
generates random numbers. Opcodes, like variables, can be **a**, **k**, or **i**-rate.

In their most common form, opcodes are given input arguments and they output a result. The rate at which
an opcode operates is determined by the output variable name. Outputs always appear to the left of
an opcode name, while inputs always appear to the right of the opcode name. The typical syntax for
most opcodes in Csound is given as

```csound
output1 [,output2,...] opcode input1[, input2, ...]
```

for legacy Csound, and as

```csound
output1:type [,output2:type,...] = opcode(input1:type[, input2:type, ...])
```

in modern Csound. Here are two examples, the first one with one single output, the second one with 
two outputs. Both examples are given in legacy and in modern Csound coding.

```csound
// one output with classical csound 
aWet reverb adry, krvrbtime
// one output with modern csound
wet:a = reverb(dry, rvrbtime)
// two outputs with classical csound
aWetL, aWetR reverbsc aDryL, aDryR, kFbLev, kCoFreq
// two outputs with modern csound
wetL:a, wetR:a = reverbsc(dryL, dryR, fbLev, coFreq)
```

While most opcodes in Csound have outputs as well as inputs, some opcodes only have inputs, while
others only have outputs. It should also be noted that not every opcode can operate at a, k and i
rate. The simplest way to see what rates are supported by what opcode is by looking at the [Csound
reference manual](https://csound.com/manual/).

Lines of opcodes can be connected to create a signal graph which describes the flow of the signal
from one place to another. We can see in the next code example how the signal generated by myOpcode1
is being fed into the input of myOpcode2, which is in turn sent to the inputs of myOpode3. Remember
that the result of each opcode's calculations are passed to its output parameter, which is located
to the left of the opcode. These variables can then be used anywhere else in the instrument block.

```csound
instr 1
a1 myOpcode1 
a2 myOpcode2 a1
a3 myOpcode3 a2
endin
```

Csound features more than 1500 opcodes, making it one of the world's most
extensive audio programming languages.


#### Operators

Mathematical operators are essential to all programming languages. Csound is no different. Any
**a**, **k** or **i** rate variable can be operated on using the standard set of mathematical
operators, *, /, +, -, etc. Note that multiplying a variable by 20 does not alter the variable's
value. It simply returns a new value. This new value can then be assigned for use later.

```csound
// classic syntax
kVal1 = 100
kVal2 = kVal1 * 20
// modern syntax
val1:k = 100
val2:k = val1 * 20
```


#### Comments

Single line comments can be added using `;` or `//`. Multi-line comments are added using
`/*` to start the comment, and `*/` to end it.



### Score lines

With an *instrument event* in the `<CsScore>` section of the *.csd* file 
we can call an instrument with a specified time and duration. 
The first character of a score line's instrument event is a lower-case *i*.
Separated by spaces follow "parameter fields", like columns in a spread sheet.

i  p1  p2  p3  [p4  p5  ...]

The first three "p-fields" carry these meanings:

- **p1:** the instrument name or number to be called  
- **p2:** the starting time of the specified instrument in beats (default bpm is 60)  
- **p3:** duration time in beats, usually a positive number. A negative value will initiate a held note (see also [ihold](https://csound.com/manual/opcodes/ihold/)).  
A negative value can also be used for 'always on' instruments like reverberation (one instance only). 
- **p4, p5, ... :** optional parameters whose significance is determined by the instrument.



## Your first synthesiser

Now that the basics of the Csound language have been outlined, it's time to look at creating a
simple instrument. The opcodes used in this simple instrument are [vco2](docs/manual/vco2.html),
[madsr](docs/manual/madsr.html), [moogladder](docs/manual/moogladder.html) and [outall](docs/manual/outall.html).

The vco2 opcode models a voltage controlled oscillator. It provides users with an effective way of
generating band-limited waveforms and can be a building block of a synthesiser. In simpler terms, 
it produces a particular sound with a determined timbre, amplitude and frequency.
Its syntax, taken from the Csound reference manual, is given as:

```csound
res:a = vco2(amp:k, cps:k [, imode] [, kpw] [, kphs] [, inyx])
```

Square brackets around an input argument mean that argument is optional and can be left out. 
This means that for learning purposes we can write this opcode in a simpler way:

```csound
res:a = vco2(amp, cps)
```

It outputs an a-rate signal and accepts several different input arguments. **amp:k** determines the amplitude of
the signal, while **cps:k** sets the frequency of the signal. The default type of waveform created by
a **vco2** is a sawtooth waveform. An x before an input argument in the manual indicates that i, k or a-rate variables can be used. 
This is not the case in the vco2 opcode but in 
[vco](docs/manual/vco.html) which has two x-input arguments:

```csound
ares vco xamp, xcps, iwave, kpw
```

The simplest instrument that can be written to use a **vco2** is
given below. The **outall** opcode is used to output an a-rate signal as audio.

```csound
instr 1
  saw:a = vco2(0.1,440)
  outall(saw)
endin
```

In order to start the above instrument, this line will need to be added to the Csound score section:

```csound
i 1 0 3
```

This will play for 3 seconds and then terminates.
Try it [here](https://ide.csound.com/editor/ummJntzs5ciAX8wDTxJi) online.


### New p-fields

One obvious limitation here is that the instrument always plays a frequency of 440 Hz,
and an amplitude of 0.1. The simplest way to address this problem is by adding 
two extra p-fields to the score line. `p4` is meant to be the amplitude, and `p5`
is meant to be the frequency.

```csound
i 1 0 3 0.1 440
i 1 3 3 0.2 550
```
 
With the new p-field in place, the instrument block can be modified to access that value using
special i-rate variables named `p4` and `p5`. Whenever Csound starts reading through the code,
it will put as `p4` and `p5` the numbers from the score line. 

We can use this feature to play notes in sequence, or simultaneously.
Both is used in the next example. Try it online 
[here](https://ide.csound.com/editor/KEJqT73vctEisvUdRcd7).

```csound
<CsoundSynthesizer>
<CsOptions>
-o dac // real-time output
</CsOptions>
<CsInstruments>
sr = 44100 // sample rate
0dbfs = 1 // maximum amplitude (0 dB) is 1
nchnls = 2 // number of channels is 2 (stereo)
ksmps = 64 // number of samples in one control cycle (audio vector)

instr 1
  // get p4 from the score line as amplitude
  amp:i = p4
  // get p5 from the score line as frequency
  freq:i = p5
  // sawtooth tone with these amplitude and frequency values
  saw:a = vco2(amp,freq)
  // output to all channels
  outall(saw)
endin

</CsInstruments>
<CsScore>
// call instrument 1 in sequence
i 1 0 3 0.1 440
i 1 3 3 0.2 550
// call instrument 1 simultaneously
i 1 7 3 0.05 550
i 1 7 3 0.05 660
</CsScore>
</CsoundSynthesizer>
```


### Envelope

Another issue in the instrument presented above is that the notes will click each time they sound.
To avoid this, an amplitude envelope should be applied to the output signal. An envelope causes the 
amplitude of a signal to change smoothly over time to avoid instant jumps which produce unwanted clicking.
The most common envelope used in synthesisers is the ubiquitous ADSR envelope. ADSR stands for Attack, Decay,
Sustain and Release. The attack, decay and release sections are given in seconds as they relate to
time values. The sustain value describes the sustain level which kicks in after the attack and decay
have passed. The note's amplitude will rest at this sustain level until it is released.

<img src="images/ADSR.png" class="img-fluid" alt="ADSR" width=75% />

Csound offers several ADSR envelopes. The one used here is `madsr`, which is a MIDI ready ADSR.
Its syntax is given as:

```csound
res:k = madsr(iatt, idec, islev, irel)
```

There are several places in the instrument code where the output of this opcode can be used. It
could be applied directly to the first input argument of the `vco2` opcode, or it can be placed in
the line with the `outall` opcode. Both are valid approaches.

```csound
<CsoundSynthesizer>
<CsOptions>
-o dac // real-time output
</CsOptions>
<CsInstruments>
sr = 44100 // sample rate
0dbfs = 1 // maximum amplitude (0 dB) is 1
nchnls = 2 // number of channels is 2 (stereo)
ksmps = 64 // number of samples in one control cycle (audio vector)

instr 1
  // get p4 from the score line as amplitude
  amp:i = p4
  // get p5 from the score line as frequency
  freq:i = p5
  // settings for madsr envelope
  att:i, dec:i, sus:i, rel:i = 0.1, 0.4, 0.6, 0.7
  // create envelope with madsr opcode
  env:k = madsr(att,dec,sus,rel)
  // sawtooth tone 
  saw:a = vco2(amp,freq)
  // apply envelope by multiplication and output to all channels
  outall(saw*env)
endin

</CsInstruments>
<CsScore>
// call instrument 1 in sequence
i 1 0 2 0.1 440
i 1 3 2 0.2 550
// call instrument 1 simultaneously
i 1 7 3 0.1 550
i 1 7 3 0.1 660
</CsScore>
</CsoundSynthesizer>
```

Try out this code [here](https://ide.csound.com/editor/10Ska1IWvCgBrRyEPgJg) online.

### Filter

ADSR envelopes are often used to control the cut-off frequency of low-pass filters. A low-pass
filter blocks high frequency components of a sound, while letting lower frequencies pass. A popular
low-pass filter found in Csound is the moogladder filter which is modeled on the famous filters
found in Moog synthesisers. Its syntax is given as:

```csound
sig:a = moogladder(ain, kcf, kres)
```

Its first input argument is an a-rate variable: the signal to be fed into the filter. 
The next two arguments set the filter's cut-off
frequency and the amount of resonance to be added to the signal. Both of these can be k-rate
variables, thus allowing them to be changed during the note. Using the output from the `madsr` to
control the filter's cut-off frequency is trivial and can be seen in the next example.

```csound
<CsoundSynthesizer>
<CsOptions>
-o dac // real-time output
</CsOptions>
<CsInstruments>
sr = 44100 // sample rate
0dbfs = 1 // maximum amplitude (0 dB) is 1
nchnls = 2 // number of channels is 2 (stereo)
ksmps = 64 // number of samples in one control cycle (audio vector)

instr 1
  // get p4 from the score line as amplitude
  amp:i = p4
  // get p5 from the score line as frequency
  freq:i = p5
  // settings for madsr envelope
  att:i, dec:i, sus:i, rel:i = 0.1, 0.4, 0.6, 0.7
  // create envelope with madsr opcode
  env:k = madsr(att,dec,sus,rel)
  // set the cutoff frequency and the resonance
  cutoff:i, res:i = 5000, 0.4
  // sawtooth tone 
  saw:a = vco2(amp,freq)
  // moogladder low pass filter with variable cutoff frequency
  lp:a = moogladder(saw,cutoff*env,res)
  // apply envelope by multiplication and output to all channels
  outall(lp*env)
endin

</CsInstruments>
<CsScore>
// call instrument 1 in sequence
i 1 0 2 0.1 440
i 1 3 2 0.2 550
// call instrument 1 simultaneously
i 1 7 3 0.1 550
i 1 7 3 0.1 660
</CsScore>
</CsoundSynthesizer>
```

Try out the code [here](https://ide.csound.com/editor/21gdbdb9mEeW1WB5z852) online.


### Controlling your instrument with MIDI

While the score section offers lots of versatility when it comes to writing and composing music with
Csound, it can be a little restrictive when it comes to performing live. Many musicians will prefer
to use a MIDI keyboard to trigger notes. Csound offers a very simple way of accessing values from
the MIDI keyboard. But first Csound must be instructed to listen to messages from a MIDI keyboard.
This can be done in the `<CsOptions>` section of the source code. The `<CsOptions>` section
is populated with unique flags that tell Csound how to interact with different devices. A `-Ma`
will tell Csound to listen for MIDI messages from all available devices. The `-odac` we already
added to pipe Csound's output to the computer's sound card. In order to pass MIDI
note and amplitude data to an instrument, so-called MIDI-interop command line flags can be used.
Consider the following example:

```csound
<CsOptions>
-odac -Ma --midi-velocity-amp=4 --midi-key-cps=5
</CsOptions>
```

Csound will open any available MIDI device. Every time a note is pressed, the note's velocity will
be passed as amplitude to `p4`, while the note's key will be passed as frequency to `p5`. The previous score lines used to
trigger the instrument can now be removed from the score section. Below is the code for a fully
functioning MIDI synth. A second, slightly out of tune `vco2` has been added to provide a little
warmth to the overall sound.

```csound
<CsoundSynthesizer>
<CsOptions>
-odac -Ma --midi-velocity-amp=4 --midi-key-cps=5
</CsOptions>
<CsInstruments>
sr = 44100 // sample rate
0dbfs = 1 // maximum amplitude (0 dB) is 1
nchnls = 2 // number of channels is 2 (stereo)
ksmps = 64 // number of samples in one control cycle (audio vector)

instr 1
  // get p4 from the MIDI velocity as amplitude
  amp:i = p4
  // get p5 from the MIDI note number as frequency
  freq:i = p5
  // settings for madsr envelope
  att:i, dec:i, sus:i, rel:i = 0.1, 0.4, 0.6, 0.7
  // create envelope with madsr opcode
  env:k = madsr(att,dec,sus,rel)
  // set the cutoff frequency and the resonance
  cutoff:i, res:i = 5000, 0.4
  // sawtooth tone 
  saw1:a = vco2(amp,freq)
  // another one slightly out of tune
  saw2:a = vco2(amp,freq*0.99)
  // moogladder low pass filter with variable cutoff frequency
  lp = moogladder((saw1+saw2)/2,cutoff*env,res)
  // apply envelope by multiplication and output to all channels
  outall(lp*env)
endin

</CsInstruments>
<CsScore>
// empty score as we expect midi to trigger the instrument

</CsScore>
</CsoundSynthesizer>
```

Note that most frontends offer their own MIDI handling. Once this is set up, the user can omit
the `-Ma` option.

The online code is [here](https://ide.csound.com/editor/Sitwl5x6xHEqYd84NX1K)
but it requires WebMIDi.


## Your first effect

### Real-time audio input

If we want to create an audio effect in Csound on real-time audio input, we need
to feed the microphone signal into Csound. This is done by the `-i adc` command line option
in the `<CsOptions>` section of the source code. It tells Csound to listen for 
input `-i` on the analog-to-digital converter `adc`.

These two command line options give both, real-time output and real-time input:

```csound
<CsOptions>
-o dac -i adc
</CsOptions>
```

As usual, most Csound frontends handle this for you, so you may not need to
write these options explicitly.


### Instrument code

The `inch` opcode can be used to access audio from the computer's sound card. It takes a single
argument which specifies the channel number. Once the audio signal has been accessed, it can be
passed through any number of opcodes that accept audio inputs. The `comb` filter opcode can be
used to create a simple echo type effect. It takes 3 input arguments.

```csound
res:a = comb(asig, krvt, ilpt)
```

`asig` will be our audio input signal, while `krvt` sets the reverberation time in seconds. `ilpt` sets
the loop time of each echo. Note that the loop time should always be less than the reverberation
time, otherwise you will not hear any effect. In the next code example a simple stereo echo effect
is created by setting up two comb filters with different loop times and sending them to the left and
right output channels.

```csound
<CsoundSynthesizer>
<CsOptions>
-o dac -i adc
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 64
0dbfs = 1
nchnls = 2

instr Effect
  inL:a = inch(1)
  inR:a = inch(2)
  combL:a = comb(inL,3,0.5)
  combR:a = comb(inR,3,0.7)
  out(combL,combR)
endin

</CsInstruments>
<CsScore>
i "Effect" 0 100
</CsScore>
</CsoundSynthesizer> 
```

You can access this instrument [here](https://ide.csound.com/editor/qT7qEkqOc723IyphTKLp) online.


## Writing sounds to disk

### Record a live performance with fout

There may be times when you will want to record the sounds your instruments produce in realtime. The
easiest way to do this is using a combination of the `fout` and `monitor` opcodes. `fout` allows us
to write a number of audio signals to file, while `monitor` grabs the contents of Csound's audio output
buffer. Every sound that Csound produces is passed to its output buffer, so it's the go-to place
when we need to record audio output. Presented below is a simple instrument that will record all
sounds to a file called "fout_all.wav".

```csound
instr Collect 
  ;read the stereo csound output buffer
  allL, allR monitor
  ;write the output of csound to a 24 bit wav file
  fout("fout_all.wav",18,allL,allR)
endin
```

In modern Csound, we can use an audio array rather than single audio signals for each channel.
In this version, the `channels:a[]` array contains all audio signals in one container:

```csound
instr Collect 
  ;read the stereo csound output buffer
  channels:a[] monitor
  ;write the output of csound to a 24 bit wav file
  fout("fout_all.wav",18,channels)
endin
```

Some frontends provide possibilities to record any live session just by pushing a button,
but `fout` can be used in any situation. 


### Render to file

Csound can not only record real-time performances but also render any score directly
to a sound file. This is done "as fast as possible", so usually much faster than in
real-time. 

To apply this, instead of writing `-o dac` we write any file name as output.
This statement will render to a file called "csound_output.wav":

```csound
<CsOptions>
-o csound_output.wav
</CsOptions>
```


## Common Errors

Csound will inform you of any errors contained in your code. Understanding syntax errors is
key to making the most out of Csound. The most common error is the "used before defined" error. This
occurs whenever a variable is accessed before it has been defined. For instance, in the following
code `kAmp` is passed as an input argument to `oscili` before it is declared.

```csound
<CsInstruments>

instr 1
  aSound = oscili(kAmp,440)
  outall(aSound)
endin

</CsInstruments> 
```

When Csound reads through this code and gets to the line with `oscili` it reports an error because it
can't find a value for `kAmp` as it has not been defined. In order to avoid this error we have to
ensure that all variables are defined before use.

```csound
<CsInstruments>

0dbfs = 1

instr 1
  kAmp = 0.1
  aSound = oscili(kAmp,440)
  outall(aSound)
endin

</CsInstruments> 
```

Another common error is "unexpected T_IDENT". The most common reason for this error is a typo. The
typo can be caused by calling an opcode by an incorrect name, or from spelling an opcode with
capital letters. Remember that Csound is case sensitive; "oscil" is not the same as "Oscil"!


## Where to now?

There are lots of great resources available to those wishing to learn more about Csound. The [Csound
FLOSS Manual](https://flossmanual.csound.com/) is a comprehensive online textbook for
learning and using Csound. It covers all aspects of the language and provides detailed code examples
for you to follow. You also find another [Get Started](https://flossmanual.csound.com/get-started) there.
It can be read and executed in any browser.

Iain McCurdy's "realtime examples" are a wonderful source of inspiration and
models for how to get high-quality sounds out of Csound. They are available on his
[Website](http://iainmccurdy.org/csound.html) and also included in the [Cabbage](https://cabbageaudio.com)
frontend (the older ones also in [CsoundQt](https://csoundqt.github.io)).

The official [Csound Reference Manual](https://csound.com/manual/) is available online as well as
included with most Csound editors and frontends. It contains all information about the usage of the
1500+ opcodes and includes an example of each one in use. That's more than 1500 Csound instruments
ready to play straight away!

There are also a number of excellent printed books available through a variety of different
publishers. You can check out the [Books](/books.html) section to find more information.
