; PitchShifterDelaySt
; -------------------
; A stereo in -> stereo out pitch shifter effect that employs delay lines
;
; aout  PitchShifterDelaySt  ain1,ain2,ktrans,kdlt,kFB,imaxdlt
;
; Initialisation
; --------------
; imaxdlt --  maximum delay time (kdlt should not exceed this value)
;
; Performance
; -----------
; ain1,ain2 --  input audio signals to be pitch shifted
; ktrans    --  pitch transposition (in semitones)
; kdlt      --  delay time employed by the pitch shifter effect (should be within the range ksmps/sr and imaxdlt) 
; kFB       --  feedback (should be within the range 0 to 1)
 
opcode	PitchShifterDelaySt,aa,aakkki
	ainL,ainR,ktrans,kdlt,kFB,imaxdlt	xin
	adlt	interp	kdlt					;INTERPOLATE DELAY TIME CONTROL TO CREATE A-RATE VERSION
	ihalfsine	ftgen	0, 0, 1025, 9, 0.5, 1, 0	;HALF SINE  WINDOW FUNCTION USED FOR AMPLITUDE ENVELOPING
	koctfract	=	ktrans/12			;TRANSPOSITION AS FRACTION OF AN OCTAVE
	kratio		=	octave(koctfract)		;RATIO TO PRODUCE PITCH SHIFT
	krate		=	(kratio-1)/kdlt			;SUBTRACT 1/1 SPEED
	
	aphase1		phasor	-krate				;MOVING PHASE 1-0
	aphase2		phasor	-krate, .5			;MOVING PHASE 1-0 - PHASE OFFSET BY 180 DEGREES (.5 RADIANS)
	
	agate1		tablei	aphase1, ihalfsine, 1, 0, 1	;WINDOW FUNC =HALF SINE
	agate2		tablei	aphase2, ihalfsine, 1, 0, 1	;WINDOW FUNC =HALF SINE

	aoutL,aoutR	init	0	;INITIALISE OUTPUT SIGNAL (NEEDED IN ORDER TO CREATE FEEDBACK SIGNAL)
	iws		=	4	;WINDOW SIZE FOR INTERPOLATION - INCREASE THIS FOR IMPROVED QUALITY AT SOME CPU COST 
	aout1L, aout1R	vdelayxs ainL+(aoutL*kFB), ainR+(aoutR*kFB), aphase1*adlt, imaxdlt, iws
	aout2L, aout2R	vdelayxs ainL+(aoutL*kFB), ainR+(aoutR*kFB), aphase2*adlt, imaxdlt, iws
	
	aoutL		=	((aout1L * agate1)+(aout2L * agate2))*0.5
	aoutR		=	((aout1R * agate1)+(aout2R * agate2))*0.5
			
			xout	aoutL, aoutR		;SUM AND RESCALE PITCH SHIFTER OUTPUTS (LEFT CHANNEL)
endop

