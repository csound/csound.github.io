; Sres  TextFileToStringi  SInputFile

; reads a text file and converts the entire file to a string at i-time
; in addition, carriage returns will be removed

; Initialisation
; --------------
; SInputFile - path to a text file as input

opcode	TextFileToStringi,S,S
 STextFile	xin
 Scomplete    init     ""
 iline        init     0
 while iline!=-1 do
 Sline,iline  readfi	  STextFile
 Scomplete    strcat  Scomplete,Sline
 if	strchar:i(Scomplete,strlen:i(Scomplete)-1)==10 then
  Scomplete	strsub	Scomplete,0,strlen:i(Scomplete)-1
 endif
 od
 xout	Scomplete
endop