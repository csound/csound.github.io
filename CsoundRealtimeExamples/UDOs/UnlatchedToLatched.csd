UnlatchedToLatched.csd
Written by Iain McCurdy, 2012.

This UDO takes a trigger signal that switches between non-zero and zero and halves the rate at which it switches and outputs a 1 or a zero as illustrated below.

Input trigger:  1 0 1 0 1 0 1 0
Output trigger: 1   0   1   0

This mechanism can be useful for turning an unlatched switched into a latched switch within the software.
In this example a beep is turned on when a MIDI note is pressed. The beep stays on until the next note is pressed.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 100
nchnls = 1
0dbfs = 1

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

instr	1
	kstatus, kchan, kdata1, kdata2 midiin			; READ IN ALL INCOMING MIDI DATA
	if kstatus==144 then					; IF A NOTE EVENT HAS BEEN RECEIVED...
	 klatched	UnlatchedToLatched	kdata2		; CALL UDO. NOTE VELOCITY IS USED AS THE INPUT TRIGGER SIGNAL: NOTE ON = VELOCITY VALUE, NOTE OFF = ZERO
	endif							; END OF CONDITIONAL BRANCH
	a2	vco2	0.1*klatched,cpsmidinn(kdata1),4,0.5	; GENERATE A BEEP. APPLY THE LATCHED TRIGGER SIGNAL TO THE AMPLITUDE
		out	a2					; SEND AUDIO TO OUTPUT
	
	
endin

</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>