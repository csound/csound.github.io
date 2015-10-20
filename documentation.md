---
layout: sidebar_links
title: Get started 
---
<a name="top"></a>
[Csound editors](#editors)<br>
[Csound syntax](#syntax)<br>
[Your first synthesiser](#first_instrument)<br>
[Your first effect](#first_effect)<br>
[Common errors](#common_errors)<br>
[Where to now?](#where_to_now)<br>

<a name="editor"></a>
##Csound Editors
Csound text can be written using any source code editor. Csound ships with an editor called CsoundQT which provide syntax highlighting of text, as well as a vast array of useful functions. While CsoundQT is the default editor for Csound it is not the only Csound-based editor available to users. The following is a list of editors and extensions written specifically for editing Csound source files.

<li><a href="http://csound.github.io/winxound.codeplex.com">WinXound</a></li>
<li><a href="http://www.zogotounga.net/comp/csoundx.html">Csound for Emacs</a></li>
<li><a href="">Csound for Sublime</a></li>
<li><a href="http://blue.kunstmusik.com">Blue</a></li>
<li><a href="http://cabbageaudio.com/">Cabbage</a></li>


<a name="syntax"></a>
##Csound syntax
All Csound source code is made up of several sections which are defined in XML type tags. The most important sections are the **CsInstruments** and **CsScore** sections. These sections defined how our instruments will sound, and when they start. All Csound code is case sensitive. That means upper-case letters are not the same as lower-case letters. Presented below is the typical document structures for a single unified Csound file. 

<CsoundSynthesizer>
;all code relating to Csound should be encapsulated between 
;<CsoundSynthesizer> and </CsoundSynthesizer>
<CsOptions>
;this sections tell Csound how to interact with various devices and hardware
</CsOptions>
<CsInstruments>
;this section contains instrument definitions
</CsInstruments>  
<CsScore>
;this section tells Csound when and how to perform instruments defined
;in the CsInstruments section above. 
</CsScore>
</CsoundSynthesizer>

Csound code can be described in terms of its syntax and grammar. Each section uses a slightly different syntax. For instance, the syntax used to define an instrument is not the same as the simplified syntax used in the CsScore section. While the score section is made up of so-called i and f statements, the CsInstruments syntax is made up of 6 different components: keywords, variables, constants, opcodes, operators and comments. 

###Keywords

Keywords are special reserved words that have a unique function and meaning. The two most commonly used keywords in the Csound language are **instr** and **endin**. These two keywords define an instrument block which contain instructions on how an instrument functions. Each instrument must be given a unique name or number which follows the **instr** keyword.

<pre><font face="courier new">
instr 1
;to stuff
endin

instr DoStuff
;do stuff
endin
</font></pre>

Other common keywords are found in the CsInstruments *header section*. The *header section* appears before any instrument block and sets up vital information about things such as sampling rates, **sr**, the number of audio channels to use, **nchnls**, and decibels relative to full scale, **0dbfs**.

<pre><font face="courier new">
sr = 44100
nchnls = 2
0dbfs = 1

instr 1
;to stuff
endin
</font></pre>

[Return to top](#top)

###Constants and variables.

Constants are easy to spot in Csound code. They appear as fixed numbers. Their values cannot change at any stage during performance, or between performances. Variables on the other hand are temporary memory slots that can be used to store data. The three simplest and most common types of variables in Csound are **i**, **k** and **a**-rate variables. These types of variables are very easy to spot in Csound because they will always begin with an i, k or a. 

<pre><font face="courier new">
instr 1
iAmp = 1
kFreq = 440
aSignal = 0
endin
</font></pre>

Variables can be given any name so long as they start with an i, k or a. So what do the i, k and a mean? 

When Csound starts it begins looping very quickly through the code of each of its instruments. For the sake of simplicity we can say that it does this sampling rate times a second. So by default, it will read and process each instrument's code 44100 times a second. Each time it runs through the instrument code it will update its variables. How quickly it updates each of its variables is determined by the variable type. 

**a**-rate variables are updated each time Csound runs through the instrument code. **k-rate** variables are updated less often, and **i**-rate variables are only updated once just as an instrument starts. Why the different update rates? Performance. Each and every update to a variable forces the PC to compute something. And each time it does it use some of its CPU. By limiting the update rate of different variables users can improve the performance of their instruments and avoid unwanted audio dropouts.     

###Opcodes
Opcodes do things. They are the brains of each and every Csound instrument. What they do is usually described by their name. **reverb** for example applies a reverb to an audio signal while **random** generates random numbers. Opcodes, like variables can be **a**, **k**, or **i**-rate. 

In their most common form, opcodes are given input arguments and output a result. The rate at which an opcode operates is determined by the output variable name. Outputs always appear to the left of an opcode name, while inputs always appear to the right of the opcode name. The typical syntax for most opcodes in Csound is give as 

```
aOutput opcode input1, input2, input3, ...
```

While most opcodes in Csound have outputs as well as inputs, some opcodes only have inputs, while others only have outputs. It should also be noted that not every opcode can operate at a, k and i rate. The simplest way to see what rates are supported by what opcode is by looking at the Csound reference manual. 

Lines of opcodes can be connected to create a signal graph which described the flow of the signal from one place to another. We can see in the next code example how the signal generated by myOcopde1 is being fed into the input of myOpcode2, which is in turn send to the inputs of myOpode3. Remember that the result of each opcode's calculations are passed to its output parameter, which is located to the right of the opcode. These variables can then be used anywhere else in the instrument block.  

<pre><font face="courier new">
instr 1
a1 myOpcode1 
a2 myOpcode2 a1
a3 myOpcode3 a3
endin
</font></pre>

Csound features almost 1500 opcodes, making it one of the world's most extensive audio programming languages. 
[Return to top](#top)

###Operators 
Mathematical operators are essential to all programming languages. Csound is no different. Any **a**, **k** or **i** rate variable can be operated on using the standard set of mathematical operators, *, /, +, -, etc. Note that multiplying a variable by 20 does not alter the variable's value. It simply returns a new value. This new value can then be assigned for use later.

<pre><font face="courier new">
kVal1 = 100
kVal2 = kVal1*100
</font></pre>

###Comments
Single line comments can be added using **;** or **//**. Multi-line comments are be added using **/*** to start the comment, and ***/** to end it. 

<a name="first_instrument"></a>
##Your first synthesiser

Now that the basics of the Csound language have been outlined, it's time to look at creating a simple instrument. The opcodes used in this simple instrument are [vco2](vco2.html), [madsr](madsr.html), [moogladder](moog.html) and [out](out.html).

The vco2 opcode models a voltage controlled oscillator. It provides users with an effective way of generating band-limited waveforms and can be the building blocks of many a synthesiser. Its syntax, taken from the Csound reference manual, is given as:

<pre><font face="courier new">
ares vco2 kamp, kcps [, imode] [, kpw] [, kphs] [, inyx]
</font></pre>

It outputs an a-rate signal and accepts several different input argument. An x before an input argument indicates that i, k or a-rate variables can be used. Square brackets around an input argument means that argument is optional and can be left out. **kamp** determines the amplitude of the signal, while **kcps** set the frequency of the signal. The default type of waveform created by a **vco2** is a sawtooth waveform. The simplest instrument that can be written to use a **vco2** is given below. The **out** opcode is used to output an a-rate signal as audio.  

<pre><font face="courier new">
instr 1
aOut vco2 1, 440
out aOut
endin
</font></pre>


In order to start the above instrument, an i-statement will need to be added to the Csound score section. A Csound score isn't all that different to a traditional musical score. In a traditional score, dots are used to provide information to the musician. In Csound the dots are replaced with i-statements, or instrument statements. Each i-statement must contain at least 3 so-called p-fields. The first 3 p-fields have a fixed meaning. The always give the instrument name or number, its start time in seconds, and its duration in seconds. The following i-statement instructs instrument 1 to start playing after 0 seconds and continue playing for 100 second. 

<pre><font face="courier new">
i1 0 100
</font></pre>

One obvious limitation here is that the instrument always plays a frequency of 440. The simplest way to address this problem is by adding an extra p-field to the i-statement. 

<pre><font face="courier new">
i1 0 100 500
</font></pre>

With the new p-field in place, the instrument block can be modified to access that value using a special i-rate variable named p4. Whenever Csound starts reading through the code, it will replace all instances of p4 with the value from the i-statement. Here is a full example that will play back 3 notes, all with a unique pitch and starting time. 
<pre><font face="courier new">
<CsoundSynthesizer>
<CsInstruments>

instr 1
aOut vco2 1, p4
out aOut
endin

</CsInstruments>
<CsScore>
i1 0 1 100
i1 1 1 200
i1 2 1 300
</CsScore>
[TODO] add sound file of output
</CsoundSynthesizer>
</pre></font>
i-statements may contain a huge number of p-fields and each one can be accessed in the instrument block using its associated p-field variable. Here is the same instrument, only this time both the amplitude and pitch are being controlled via the score. Named variables have been added to hold the values of p4 and p5. While not necessary, it is good to get into a habit of using clear and well defined variable names in your code. 

<pre><font face="courier new">
<CsoundSynthesizer>
<CsInstruments>

instr 1
iFreq = p4
iAmp = p5
aOut vco2 iFreq, iAmp
out aOut
endin

</CsInstruments>
<CsScore>
i1 0 1 100 1
i1 1 1 200 .2
i1 2 1 300 .7
</CsScore>
[TODO] add sound file of output
</CsoundSynthesizer>
</font></pre>
Another issue in the instrument presented above is that the notes will click each time they sound. To avoid this, an amplitude envelope should be applied to the output signal. The most common envelope used in synthesisers is the ubiquitous ADSR envelope. ADSR stands for Attack, Decay, Sustain and Release. The attack, decay and sustain sections are given in seconds as they relate to time values. The sustain value describes the sustain level which kicks in after the attack and decay have passed. The note's amplitude will rest at this sustain level until it is released. 

[TODO] Add graphic....

Csound offers several ADSR envelopes. The one used here is **madsr** which is a MIDI ready ADSR. Its syntax is given as:

<pre><font face="courier new">
kres madsr iatt, idec, islev, irel
</font></pre>

There are several places in the instrument code where the output of this opcode can be used. It could be applied directly to the first input argument of the **vco2** opcode, or it can be placed in the line with the **out** opcode. Both are valid approaches. 

<pre><font face="courier new">
<CsoundSynthesizer>
<CsInstruments>

instr 1
iFreq = p4
iAmp = p5
iAtt = 0.1
iDec = 0.4
iSus = 0.6
iRel = 0.7
kEnv madsr iAtt, iDec, iSus, iRel 
aOut vco2 iFreq, iAmp
out aOut*kEnv
endin

</CsInstruments>
<CsScore>
i1 0 1 100 1
i1 1 1 200 .2
i1 2 1 300 .7
</CsScore>
[TODO] add sound file of output
</CsoundSynthesizer>
</font></pre>

ADSR envelope are often used to control the cut-off frequency of low-pass filters. A low-pass filter blocks high frequency components of a sound, while letting lower frequencies pass. A popular low-pass filter found in Csound is the moogladder filter which is modeled on the famous filters found in Moog synthesisers. Its syntax is given as:

<pre><font face="courier new">
asig moogladder ain, kcf, kres
</font></pre>

Its first input argument is an a-rate variable. The next two arguments set the filter cut-off frequency and the amount of resonance to be added to the signal. Both of these can be k-rate variables, thus allowing them to be changed during the note. using the output from the **madsr** to control the filter's cut-off is trivial and can be seen in the next example. 

<pre><font face="courier new">
<CsoundSynthesizer>
<CsInstruments>

instr 1
iFreq = p4
iAmp = p5
iAtt = 0.1
iDec = 0.4
iSus = 0.6
iRel = 0.7
iCutoff = 5000
iRes = .4
kEnv madsr iAtt, iDec, iSus, iRel 
aVco vco2 iFreq, iAmp
aLp moogladder aVco, iCutoff*kEnv, iRes
out aLp*kEnv
endin

</CsInstruments>
<CsScore>
i1 0 1 100 1
i1 1 1 200 .2
i1 2 1 300 .7
</CsScore>
[TODO] add sound file of output
</CsoundSynthesizer>
</font></pre>
[Return to top](#top)

### Controlling your instrument with MIDI
While the score section offers lots of versatility when it comes to writing and composing music with Csound, it can be a little restrictive when it comes to performing live. Many musicians will prefer to use a MIDI keyboard to trigger notes. Csound offers a very simple way of accessing values from the MIDI keyboard. But first Csound must be instructed to listen to messages from a MIDI keyboard. This can be done in the <CsOptions> section of the source code. The <CsOptions> section is populated with unique flags that tell Csound how to interact with different devices. A **-Ma** will tell Csound to listen for MIDI messages from all available devices. A **-odac** can also be added. This will instruct Csound to output audio to the computer's sound card. In order to pass MIDI note and amplitude data to an instrument, so-called MIDI-interop command line flags can be used. Consider the following example:

<pre><font face="courier new">
<CsOptions>
-odac -Ma --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
</font></pre> 

Csound will open any available MIDI device. Every time a note is pressed, the note's frequency will be passed to p4, while the note's amplitude will be passed to p5. The previous i-statements used to trigger the instrument can now be removed from the score section and replaced with a single **f0 3600** statement. This is a special statement that instructs Csound to wait and respond to incoming events for 3600 seconds. 3600 was chosen arbitrarily. Just remember that whatever value is used should be long enough to account for a full performance. The last thing you want is Csound stopping half way through your final solo in front of 100,000 adoring fans! Below is the code for a fully functioning MIDI synth. A second, slightly out of tune vco2 has been added
to provide a little warmth to the overall sound. 

<pre><font face="courier new">
<CsoundSynthesizer>
<CsOptions>
-odac -Ma --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>

instr 1
iFreq = p4
iAmp = p5
iAtt = 0.1
iDec = 0.4
iSus = 0.6
iRel = 0.7
iCutoff = 5000
iRes = .4
kEnv madsr iAtt, iDec, iSus, iRel 
aVco vco2 iFreq, iAmp
aLp moogladder aVco, iCutoff*kEnv, iRes
out aLp*kEnv
endin

</CsInstruments>
<CsScore>
f0 3600
</CsScore>
[TODO] add sound file of output
</CsoundSynthesizer>
</font></pre> 

[Return to top](#top)

<a name="first_effect"></a>
###Your first effect
Two things are required in order to create an audio affect in Csound. First, audio must be sent from the analogue digital converter to Csound, and second, that audio needs to be accessed within an instrument block. Csound can be instructed to open the ADC using the **-iadc** command line option in the <CsOptions> section of the source code. 

<pre><font face="courier new">
<CsOptions>
-odac -iadc
</CsOptions>
</font></pre> 

The **inch** opcode can be used to access audio from the computer's sound card. It takes a single input argument which specifies the audio channel. Once the audio signal has been accessed, it can be passed through any number of opcodes that accept audio inputs. The **comb** filter opcode can be used to create a simple echo type effect. It takes 3 input arguments.

<pre><font face="courier new">
ares comb asig, krvt, ilpt
</font></pre>

**asig** will be an audio signal, while **krvt** sets the reverberation time in seconds. **ilpt** sets the loop time of each echo. Note that the loop time should always be less than the reverberation time, otherwise you will not hear any effect. In the next code example a simple stereo echo effect is created by setting up two comb filters with different loop times and sending them to the left and right output channels. 

<pre><font face="courier new">
<CsoundSynthesizer>
<CsOptions>
-odac -iadc
</CsOptions>
<CsInstruments>

instr 1
aInL inch 1
aInR inch 2
aCombL comb aInL, 3, .5
aCombR comb aInR, 3, .7
out aCombL, aCombR
endin

</CsInstruments>
<CsScore>
i1 0 1000
</CsScore>
[TODO] add sound file of output
</CsoundSynthesizer> 
</font></pre>

<a name="common_errors"></a>
##Common Errors
Csound will inform you of any errors contained in your source file. Understanding syntax errors is key to making the most out of Csound. The most common error is the 'used before defined' error. This occurs whenever a variable is accessed before it has been defined. For instance, in the following code kAmp is passed as an input argument to **oscili** before it is declared.

<pre><font face="courier new">
<CsInstruments>

instr 1
a1 oscili kAmp, 440
out a1
endin

</CsInstruments> 
</font></pre>

When Csound reads through this code and gets to the line with **oscili** it gets confused because it can't find a value for kAmp because it has not been defined. In order to avoid this error we have to insure that all variables are defined before use.

<pre><font face="courier new">
<CsInstruments>

instr 1
kAmp = 1
a1 oscili kAmp, 440
out a1
endin

</CsInstruments> 
</font></pre>

Another common error is 'unexpected T_IDENT'. The most common reason for this error is a typo. The typo can be caused by calling an opcode by an incorrect name, or from spelling an opcode with capital letters. Remember that Csound is case sensitive; oscil is not the same as Oscil! 

<a name="where_to_now"></a>
##Where to now?

There are lots of great resources available to those wishing to learn more about Csound. The [Csound FLOSS Manual](http://www.flossmanuals.net/csound/index/) is a comprehensive online textbook for learning and using Csound. It covers all aspects of the language and provide detailed code examples for you to follow. 

The official [Csound Reference Manual](docs/manual/index.html) is available online as well as included with most Csound editors and frontends. It contains all information about the usage of the 1500+ opcodes and includes an example of each one in use. That's more than 1500 Csound instruments ready to play straight away!

There are also a number of excellent printed books available through a variety of different publishers. 

[The Csound Book](https://mitpress.mit.edu/books/csound-book)
[Virtual Sound](http://www.amazon.com/Virtual-Sound-Synthesis-Processing-Practice/dp/8890026146)<br>
[Csound Power](http://www.amazon.com/Csound-Power-Jim-Aikin/dp/1435460049)<br>
[Inside Csound](http://www.ibs.it/code/9788888849904/zucco-giorgio/inside-csound-ediz.html)<br>
[The Audio Programming Book](https://mitpress.mit.edu/books/audio-programming-book)<br>


