; WrapTrigger
; ----------------
; Generates a trigger whenever a signal wraps around
;

; kTrig  WrapTrigger  kSig

; Performance
; -----------
; kSig   -  Input Signal


	opcode WrapTrigger,k,k
kSig	xin
kSig2	init	0
kDir	init	1
kTrig	init	0
if kTrig==1 then
 kTrig	=	0
 kgoto skip
endif
if kDir=1 then
 kTrig	=	kSig<kSig2?1:0
elseif kDir=-1 then
 kTrig	=	kSig>kSig2?1:0
endif
skip:
kDir	=	(kSig>kSig2?1:-1)
kSig2	=	kSig
	xout	kTrig
	endop
