<CsoundSynthesizer>
<CsOptions>
-Ma -odac -m128
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1
seed(0)

// TODO:
// add gui to select betwween life vs sample
// and between midi versus random 
// UDO in new syntax?

// vocoder code by victor lazzarini, modified and commented by joachim heintz

// custom function for two butterworth filters in a row
opcode but2,a,aii
  ain,icf,ibw xin
  xout butbp(butbp(ain,icf,ibw),icf,ibw)
endop

// assign all midi to the "synth" instrument
massign 0, "midi_synth"

// set a very long duration
gilong = 99999999

// select and set input signal
instr in_sel
  // input signal
  chnset(diskin:a("fox.wav",1,0,1), "input")
  // clear the excitation signal
  chnclear("excite")
endin
schedule("in_sel", 0, gilong)

// instrument triggered by a midi keyboard
instr midi_synth
  // get midi note plus pitch bend and convert to freq
  fo:k = cpsmidib:k(2)
  // envelope and add to excitation signal
  chnmix(linenr:a(ampmidi(8), 0.01, 0.1, 0.01)*
        (vco2(1, fo*0.99) + vco2(1, fo*1.01)), "excite")
endin

// in case no midi keyboard is available
instr substitute_midi_control
  // trigger in a way that mostly there are two simultaneous layers
  trig_freq:k init 1
  if (metro(trig_freq) == 1) then
    schedulek("substitute_midi_play",0,random:k(1,3),random:k(55,66))
    trig_freq = random:k(2/3,4/3)
  endif
endin
;schedule("substitute_midi_control",0,-1)

instr substitute_midi_play
  // get midi note and convert to frequency
  fo:i = mtof:i(p4)
  // envelope and add to excitation signal
  chnmix(linenr:a(ampdb(random:i(0,12)), 0.01, 0.1, 0.01)*
        (vco2(1, fo*0.99) + vco2(1, fo*1.01)), "excite")
endin

// recursive vocoder bands
instr voc_bands
  // center frequency for this band
  cf:i = p4 
  // maximum center frequency for all bands
  cf_max:i = 8000 
  // one band is 1/3 of an octave
  oct_div:i = 4/12
  // call as many instances of this instrument as necessary
  if cf*2^oct_div < cf_max then
    schedule("voc_bands", 0, gilong, cf*2^oct_div)
  endif
  // band width
  bw:i = cf/8 
  // create vocoder band depending on the input signal and output
  outall(but2(chnget:a("excite"),cf,bw) * rms(but2(chnget:a("input"),cf,bw)))
endin
schedule("voc_bands", 0, gilong, 80)


</CsInstruments>
</CsoundSynthesizer>






<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
