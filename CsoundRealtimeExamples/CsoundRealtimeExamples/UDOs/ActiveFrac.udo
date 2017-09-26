; ActiveFrac
; ----------
; Returns the number of active instances of an instrument. 
; It works in a similar fashion to the 'active' opcode but intsead differentiates between notes instances with an exact fractional value.
;  (active ignores the fractional part of p1 values.)
; 
; ir  ActiveFrac  insnum,inf
;
; Initialisation
; --------------
; insnum  --  number of the instrument to be reported 
; ifn     --  an empty function table used store p1s of active notes. 
;             It should be of sufficient size to contain the p1s of all notes expected.

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

