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

// MIDI vocoder
// instr 1 - channel dispatcher, input receiver
// instr 2 - MIDI-controlled synth source
// instr 3 - channel bands and output

massign 0, 2

instr 1 // dispatch
 schedule(3, 0, -1, p4, p5, p6, p7)
 chnset(diskin:a("fox.wav",1,0,1), "input")
 chnclear("excite")
endin
schedule(1, 0, -1, 80, 8000, 8, 4)

instr 2 // MIDI synth
 fo:k cpsmidib 2
 chnmix(linenr:a(ampmidi(8), 0.01, 0.1, 0.01)*
        (vco2(1, fo*0.99) + vco2(1, fo*1.01)), "excite")
endin

instr 3  // recursive vocoder bands
 out(butterbp(butterbp(chnget:a("excite"), p4, p4/p6), p4, p4/p6) *
     rms(butterbp(butterbp(chnget:a("input"), p4, p4/p6), p4, p4/p6)))
 nxt:i = p4*2^(p7/12)
 if nxt < p5 then
  schedule(p1+0.001, 0, -1, nxt, p5, p6, p7)
 endif
endin

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
