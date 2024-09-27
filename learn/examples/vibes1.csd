<CsoundSynthesizer>
<CsOptions>
-odac -m128
</CsOptions>
<CsInstruments>

// version 1: more or less the same as in your original example

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1
seed 1

giStrike = ftgen(1,0,256,1,"marmstk1.wav",0,0,0)
giSine = ftgen(2,0,128,10,1)

garev1 init 0
garev2 init 0

instr MakeChord
 
  idb = p4
  ifm = p5 ;repetition frequency
  itime = p6 ;phasor time
  ifreq1 = p7 ;base freq
  ifreq2 = p8
  iint1 = p9 ;interval in semitones (used for chords)
  iint2 = p10
  innotes = p11 ;number of notes in chord
   
  // slight irregularity in metro ticks
  kfm = randomi:k(ifm,ifm*1.05,1)
  // frequency shift if ifreq1 != ifreq2
  kfreq = ifreq1 + phasor:k(1/itime) * (ifreq2-ifreq1)
  // generate chord for each metro tick
  schedkwhen(metro(kfm),0,0,"Chord",0,1/kfm,idb,iint1,iint2,innotes,kfreq)
  
endin


instr Chord

  p3 *= random:i(1,3)
  iamp = ampdb(p4)
  iint1 = p5
  iint2 = p6
  innotes = p7
  ifreq = p8

  indx = 0  
  while (indx < innotes) do
    
    iint = round(random:i(iint1,iint2))
    iint = (indx > 0) ? iint : 0
    iffactor = semitone(iint)
    ifreq *= iffactor
    iamp = random:i(iamp,iamp*1.05)
    schedule "Tone", 0, p3, iamp, ifreq*iffactor
  
    indx += 1
  od
    
endin

instr Tone
  
  iamp = p4
  ifreq = p5
  ihrd = random:i(0.1,0.9)
  ipos = random:i(0,1)
  
  ares = vibes(iamp,ifreq,ihrd,ipos,1,6,0.05,2,0.1)

  // panning and dry output
  adryl,adryr pan2 linen:a(ares,0,p3,p3/2),random:i(0,1)
  out(adryl,adryr)
    
  // send part of it to reverb
  irsend random 0.2, 0.4
  garev1 += irsend * adryl
  garev2 += irsend * adryr
    
endin

instr Reverb
  arev1, arev2 reverbsc garev1, garev2, 0.85, sr/2
  out(arev1,arev2)
  clear(garev1,garev2)
endin
schedule("Reverb",0,-1)

</CsInstruments>
<CsScore>
;;        
;        amp[dB]  metro[Hz] phasor[s]  freq1 freq2  int1 int2 nnotes
i1 0  20   -15      5         1         110   110    5    5    4 
i1 +  10   -15      .         1         55    220    4    5    6 
i1 30 10   -15      .         10        220   220    4    4    2 
i1 +  10   -15      .         10        220   220    3    5    3 
i1 +  20   -18      .         20        220   55     2    8    7 
i1 +  10   -12       2         10        55    55     3    5    3
i1 71 30   -9      6         30        330   330    2    3    2 
i1 +  10   -18      6         10        330   330    1    4    5
i1 +  9    -18      2         10        30    20     4    8    6

e

</CsScore>
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
