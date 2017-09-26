<CsoundSynthesizer>

<CsOptions>
-dm0
</CsOptions>

<CsInstruments>

giTab ftgen 0,0,4096,-2,0

opcode ActiveFrac,i,ii
 ip1,iTab xin
 iN active p1
 tableiw ip1,iN,iTab
 iIndx = 1
 iInsts = 0
 loop:
 iVal table iIndx,iTab
 iInsts = (iVal==ip1?iInsts+1:iInsts)
 loop_le iIndx,1,iN,loop
 krel release
 ; when note is release remove p1 value from table and shunt subsequent values back
 if trigger(krel,0.5,0)==1 then
  kNdx = iN
  kactive active p1
  loop2:
  kVal table kNdx+1,iTab
  tablew kVal,kNdx,iTab
  loop_le kNdx,1,kactive,loop2
 endif                                                              
 xout iInsts                                                                    
endop


instr 1                                                                       
 ia ActiveFrac p1,giTab
 print ia
endin

</CsInstruments>

<CsScore>
i 1.1 0 2.9  ; prints 1
i 1.2 1 3    ; prints 1
i 1.1 2 2    ; prints 2
i 1.1 3 1    ; prints 2 (the first note has been released)
</CsScore>

</CsoundSynthesizer>
