; NNToStr
; ----------------
; Converts a MIDI note number to a name description of that note as a string variable (name: C, C# etc. followed by octave number).

; Sname  NNToStr  iNN

; Initialisation
; --------------
; iNN   -  note number

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
