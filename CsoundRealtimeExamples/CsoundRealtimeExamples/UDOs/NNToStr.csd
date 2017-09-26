NNToStr.csd
Written by Iain McCurdy, 2016

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

opcode NNToStr,S,i
 iNote	xin
 iNote	=	round(iNote)
 iOct	=	int(iNote/12) - 1
 iDeg	=	iNote % 12
 if iDeg==0 then
  Sdeg	=	"C"
 elseif iDeg==1 then
  Sdeg	=	"C#"
 elseif iDeg==2 then
  Sdeg	=	"D"
 elseif iDeg==3 then
  Sdeg	=	"D#"
 elseif iDeg==4 then
  Sdeg	=	"E"
 elseif iDeg==5 then
  Sdeg	=	"F"
 elseif iDeg==6 then
  Sdeg	=	"F#"
 elseif iDeg==7 then
  Sdeg	=	"G"
 elseif iDeg==8 then
  Sdeg	=	"G#"
 elseif iDeg==9 then
  Sdeg	=	"A"
 elseif iDeg==10 then
  Sdeg	=	"A#"
 elseif iDeg==11 then
  Sdeg	=	"B"
 endif
 Sname	sprintf	"%s%d",Sdeg,iOct
 		xout	Sname
endop

instr	1	; instrument that calls UDO
 Sname	NNToStr	p4
 Smsg	sprintf	"%d\t%s\n",p4,Sname
 		prints	Smsg
endin

</CsInstruments>

<CsScore>
f 0 60
i 1 0 0 0
i 1 0 0 1
i 1 0 0 2
i 1 0 0 12
i 1 0 0 60
i 1 0 0 127

</CsScore>

</CsoundSynthesizer>
