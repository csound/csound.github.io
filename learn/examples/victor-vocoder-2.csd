<CsoundSynthesizer>
<CsOptions>
-Ma -odac 
</CsOptions>
<CsInstruments>

instr 1 // dispatch
schedule(3, 0, -1, p4, p5, p6, p7)
chnset(diskin:a("fox.wav",1,0,1), "input")
chnclear("excite")
endin
schedule(1, 0, -1, 80, 8000, 8, 4)

instr 3  // recursive vocoder bands
out(butterbp(butterbp(chnget:a("excite"), p4, p4/p6), p4, p4/p6) *
    rms(butterbp(butterbp(chnget:a("input"), p4, p4/p6), p4, p4/p6)))
nxt:i = p4*2^(p7/12)
if nxt < p5 then
 schedule(p1+0.001, 0, -1, nxt, p5, p6, p7)
endif
endin

</CsInstruments>
</CsoundSynthesizer>
