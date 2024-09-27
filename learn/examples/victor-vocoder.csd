<CsoundSynthesizer>
<CsOptions>
-Ma -odac 
</CsOptions>
<CsInstruments>

// MIDI vocoder
// instr 1 - channel dispatcher, input receiver
// instr 2 - MIDI-controlled synth source
// instr 3 - channel bands and output

massign 0, 2
instr 1 // dispatch
 cf:i = p4
 band:i = 3
 while cf < p5 do
  schedule(band, 0, -1, cf, p6)
  band, cf = band + 0.001, cf*2^(p7/12)
 od
 chnset(diskin:a("fox.wav",1,0,1), "input")
 chnclear("excite") 
endin
schedule(1, 0, -1, 80, 8000, 8, 4)

instr 2 // MIDI synth
 fo:k cpsmidib 2
 chnmix(linenr:a(ampmidi(8), 0.01, 0.1, 0.01)*
        (vco2(1, fo*0.99) + vco2(1, fo*1.01)), "excite")
endin

instr 3  // vocoder band
 out(butterbp(butterbp(chnget:a("excite"), p4, p4/p5), p4, p4/p5) *
     rms(butterbp(butterbp(chnget:a("input"), p4, p4/p5), p4, p4/p5)))
endin

</CsInstruments>
</CsoundSynthesizer>
