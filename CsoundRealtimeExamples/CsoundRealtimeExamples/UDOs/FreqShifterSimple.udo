; FreqShifterSimple
; ----------------
; A frequency shifter effect using the hilbert filter with a minimum of features
;
; ares  FreqShifterSimple  asig,kfreq,ifn
;
; Performance
; -----------
; asig   --  input audio to be frequency shifted
; kfreq  --  frequency (in hertz) by which to frequency shift the input signal
; ifn    --  function table of the waveform used to ring modulate the two hilbert outputs (normally a sine wave)

opcode	FreqShifterSimple,a,aki					; SIMPLE FREQUENCY SHIFTER
	asig,kfshift,ifn	xin				; READ IN INPUT ARGUMENTS
	areal, aimag hilbert asig				; HILBERT OPCODE OUTPUTS TWO PHASE SHIFTED SIGNALS, EACH 90 OUT OF PHASE WITH EACH OTHER
	asin 	oscili       1,    kfshift,     ifn,          0
	acos 	oscili       1,    kfshift,     ifn,          0.25	
	;RING MODULATE EACH SIGNAL USING THE QUADRATURE OSCILLATORS AS MODULATORS
	amod1	=		areal * acos
	amod2	=		aimag * asin	
	;UPSHIFTING OUTPUT
	ares	= (amod1 - amod2)				; MIX OUTPUTS (INVERTED WITH RESPECT TO EACH OTHER)
		xout	ares					; SEND AUDIO BACK TO CALLER INSTRUMENT
endop
