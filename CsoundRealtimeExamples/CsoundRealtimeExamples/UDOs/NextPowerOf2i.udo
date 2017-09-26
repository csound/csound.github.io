; NextPowerOf2i
; -------------
; Calculates the next power of 2 greater than an input at i-rate
;
; iPO2   NextPowerOf2i   iInVal
;
; Initialisation
; --------------
; iInVal --  input value to above which the next power of 
; iPO2   --  the next highest power of 2
;


opcode	NextPowerOf2i,i,i
 iInVal	xin
 icount	=	1
 LOOP:
 if 2^icount>iInVal then
  goto DONE
 else
  icount	=	icount + 1
  goto LOOP
 endif
 DONE:
 	xout	2^icount
endop
