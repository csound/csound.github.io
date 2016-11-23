opcode StartStopNamedInstr,0,Sk
	Sname,kOnOff	xin
  insno	nstrnum	Sname
  ktrig 	changed	kOnOff
  if ktrig==1 then
   if kOnOff!=0 then 
    event "i",insno,0,-1
   else
    turnoff2	insno,0,1
   endif
  endif
endop
