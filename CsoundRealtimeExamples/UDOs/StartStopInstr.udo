opcode StartStopInstr,0,ik
	insno,kOnOff	xin
  ktrig 	changed	kOnOff
  if ktrig==1 then
   if kOnOff!=0 then 
    event "i",insno,0,-1
   else
    turnoff2	insno,0,1
   endif
  endif
endop

