; UnlatchedToLatched
; ------------------
; Converts an unlatched trigger signal to a latched one
;
; kTrigOut  UnlatchedToLatched  kTrigIn
;
; Performance
; -----------
; kTrigIn  --  input trigger

opcode	UnlatchedToLatched,k,k
	kTrigIn		xin			; READ IN INPUT ARGUMENT 
	kTrigOut	init	0		; INITIALISE OUTPUT TRIGGER VALUE
	kcross		trigger	kTrigIn,0,2	; IF INPUT TRIGGER CHANGES FROM ZERO OR BACK TO ZERO SWITCH THE OUTPUT TRIGGER VALUE ACCORDING TO ITS CURRENT VALUE
	if kcross==1 then			; IF INPUT TRIGGER HAS CHANGED FROM ZERO OR BACK TO ZERO...
	 kTrigOut	=	abs(kTrigOut-1)	; FLIP THE OUTPUT TRIGGER FROM 0 TO 1 OR FROM 1 TO 0 (DEPENDING UPON WHAT ITS CURRENT VALUE IS)
	endif					; END OF CONDITIONAL BRANCH
			xout	kTrigOut	; SEND OUTPUT TRIGGER BACK TO CALLER INSTRUMENT
endop

