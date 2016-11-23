; scale_i
; ----------
; i-rate version of the 'scale' opcode
; 
; ir  scale_i  ival,imax,imin
;
; Initialisation
; --------------
; ival    --  value to be rescaled (should be within the range 0 to 1) 
; imax    --  maximum possible value after rescaling. (If ival = 1, then ir = imax) 
; imin    --  minimum possible value after rescaling. (If ival = 0, then ir = imin) 

opcode	scale_i,i,iii
 ival,imax,imin	xin
 ival	=	(ival * (imax-imin)) + imin
	xout	ival
endop
