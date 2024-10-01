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

// umschalten zwischen
// - midi oder ein button durch den ein pitch getriggert wird
// - live oder sound file

instr dispatch
  schedule("voc_bands", 0, -1, p4, p5, p6, p7)
  chnset(diskin:a("fox.wav",1,0,1), "input")
  chnclear("excite")
endin
schedule("dispatch", 0, -1, 80, 8000, 8, 4)

// recursive vocoder bands
instr voc_bands
  out(butterbp(butterbp(chnget:a("excite"), p4, p4/p6), p4, p4/p6) *
    rms(butterbp(butterbp(chnget:a("input"), p4, p4/p6), p4, p4/p6)))
  nxt:i = p4*2^(p7/12)
  if nxt < p5 then
    schedule(nstrnum("voc_bands")+0.001, 0, -1, nxt, p5, p6, p7)
  endif
endin

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
