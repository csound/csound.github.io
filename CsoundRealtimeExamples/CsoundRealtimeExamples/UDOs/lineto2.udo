; lineto2
; ----------------
; The lineto opcode is buggy and doesn't always output the final value of a portamento glide.
; This UDO mimics the behaviour of lineto but fixes the bug.  
;

; kout  lineto2  kin,ktime

; Performance
; -----------
; kin   -  input signal
; ktime -  time taken to reach new value
; kout  -  output value


opcode	lineto2,k,kk
 kinput,ktime	xin
 ktrig	changed	kinput,ktime				; reset trigger
 if ktrig==1 then					; if new note has been received or if portamento time has been changed...
  reinit RESTART
 endif
 RESTART:						; restart 'linseg' envelope
 if i(ktime)==0 then					; 'linseg' fails if duration is zero...
  koutput	=	i(kinput)			; ...in which case output simply equals input
 else
  koutput	linseg	i(koutput),i(ktime),i(kinput)	; linseg envelope from old value to new value
 endif
 rireturn
 		xout	koutput
endop
