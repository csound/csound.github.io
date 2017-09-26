cpstuni2.csd
A elaboration of the 'cpstuni' opcode which facilitates interpretation of fractional MIDI note numbers.

icps cpstuni2 inote,itable

icps   --  ouputted cycles per second value
inote  --  midi note number
itable --  table which contains the tuning ratios (see cpstuni opcode)

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>                                  

sr = 44100
ksmps = 64
nchnls = 1
0dbfs = 1

;GEN02 TUNING TABLE (SEE MANUAL ENTRY FOR 'cpstuni' OPCODE FOR DETAILS)
;			FN_NUM | INIT_TIME | SIZE | GEN_ROUTINE | NUM_GRADES | REPEAT |  BASE_FREQ     | BASE_KEY_MIDI | TUNING_RATIOS:-0-|----1----|---2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|----10-----|---11----|---12---|---13----|----14---|----15---|---16----|----17---|---18----|---19---|----20----|---21----|---22----|---23---|----24----|----25----|----26----|----27----|----28----|----29----|----30----|----31----|----32----|----33----|----34----|----35----|----36----|
giTTable1	ftgen     1,         0,       64,        -2,         12,        13,    cpsmidinn(60),        60,                       1/5,   2/5,     3/5,      4/5,      5/5,      6/5,      7/5,      8/5,      9/5,      10/5,     11/5,      12/5,     13/5

; icps  cpstuni2  inote,itable
; INITIALISATION:
; inote  -- Note number (as in MIDI). Fractional values will be interpretted appropriately.
; itable -- Function table number containing tuning ratios (see manual entry or my example for 'cpstun' for further details).
; OUPUT ARG:
; icps   -- CYCLES-PER-SECOND FREQUENCY

		opcode	cpstuni2,i,ii
inote,itable	xin
icpsLo 		cpstuni	int(inote), itable				; define a cps value for the integer note value beneath the fractional note value
icpsUp 		cpstuni	int(inote)+1, itable				; define a cps value for the integer note value above the fractional note value
ioctLo		=	octcps(icpsLo)					; lower pitch in oct format
ioctUp		=	octcps(icpsUp)					; upper pitch in oct format
icps		=	cpsoct(ioctLo+((ioctUp-ioctLo)*frac(inote))) 	; linearly interpoloated pitch according to fractional note value in oct format
		xout	icps			
endop

instr	1
	;print	p4
	prints "Note number: %2.3f%n" , p4
	icps	cpstuni2	p4,giTTable1			; DERIVE A CPS VALUE FROM NOTE PLAYED AND PITCH BEND USING THE USER DEFINED TUNING SYSTEM
	aenv	expseg	.001,.01,1,(p3/2)-.01,1,p3/5,.001	; AMPLITUDE ENVELOPE (RELEASE SENSING)
	asig	vco2	0.2, icps, 4, 0.5			; CREATE A TRIANGLE WAVE OSCILLATOR
		out	asig * aenv				; SEND AUDIO TO OUTPUT
endin

</CsInstruments>

<CsScore>
; p4 = note number
; a scale - whole number steps
i 1 0 0.2 60
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  72

; a scale - steps of 0.5
i 1 +  .  60
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >     
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  72

; a scale - steps of 0.25
i 1 + .1  60
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >     
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >     
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  >
i 1 +  .  72
e
</CsScore>

</CsoundSynthesizer>