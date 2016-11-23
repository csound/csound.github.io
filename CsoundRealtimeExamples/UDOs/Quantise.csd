<CsoundSynthesizer>

<CsOptions>
-odac
</CsOptions>

<CsInstruments>

sr = 44100

opcode  Quantise,k,kkk
 kVal, kQVal, kQOffset      xin
 if kQVal!=0 then
  kVal                      =         (round((kVal - kQOffset)/kQVal) * kQVal) + kQOffset
 endif
  							xout      kVal
endop

instr 1
 kInVal     line        8, p3, 10                   ; a function 0 to 1 across the duration of the note
 kQVal      =           p4                          ; quantise value
 kQOffset   =           p5                          ; quantise offset
 kOutVal    Quantise    kInVal, kQVal, kQOffset     ; apply UDO
 aSig		poscil		0.1*0dbfs,cpsoct(kOutVal)
 			outs		aSig, aSig
endin

</CsInstruments>

<CsScore>
; p4 = quantise value (grid pitch)
; p5 = quantise offset
;         p4     p5
i 1 0  10 [1/12] 0
i 1 12 10 [3/12] 0
e
</CsScore>

</CsoundSynthesizer>