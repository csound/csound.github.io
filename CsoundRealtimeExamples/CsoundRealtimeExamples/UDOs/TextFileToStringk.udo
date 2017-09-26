; Sres  TextFileToStringk  SInputFile

; reads a text file and converts the entire file to a string at k-rate
; in addition, carriage returns will be removed

; Performance
; --------------
; SInputFile - path to a text file as input

opcode	TextFileToStringk,S,S
 STextFile	xin
 Scomplete    init     ""
 kline        init     0
 while kline!=-1 do
 Sline,kline  readf	  STextFile
 Scomplete    strcatk  Scomplete,Sline
 if	strchark:k(Scomplete,strlenk:k(Scomplete)-1)==10 then
  Scomplete	strsubk	Scomplete,0,strlenk:k(Scomplete)-1
 endif
 od
 xout	Scomplete
endop
