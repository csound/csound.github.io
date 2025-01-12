<CsoundSynthesizer>
<CsOptions>
-Ma -odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

// by victor lazzarini

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

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>541</x>
 <y>242</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
 <bsbObject type="BSBButton" version="2">
  <objectName>button0</objectName>
  <x>108</x>
  <y>76</y>
  <width>100</width>
  <height>30</height>
  <uuid>{844df1a4-b794-44d0-9cb1-396de2d28706}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>button0</text>
  <image>/</image>
  <eventLine>i 2 0 -1 66</eventLine>
  <latch>false</latch>
  <momentaryMidiButton>false</momentaryMidiButton>
  <latched>false</latched>
  <fontsize>10</fontsize>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
