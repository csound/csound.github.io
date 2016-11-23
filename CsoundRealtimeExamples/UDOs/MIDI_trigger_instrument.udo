; PanTrem
; ----------------
; Auto-panning and tremolo effects
;
;             MIDI_trigger_instrument  insno,ichan
;
; Initialization
; --------------
; insno  --  number of the instrument that will be triggered.
; ichan  --  MIDI channel on which note will be triggered (1 - 16), or a value of zero will allow triggering on all channels.

opcode	MIDI_trigger_instrument,0,ii					;INPUT ARGUMENT FOR INSTRUMENT NUMBER OF THE INSTRUMENT TO BE TRIGGERED AND THE MIDI CHANNEL ON WHICH TRIGGERING WILL OCCUR (VALUE OF ZERO HERE MEANS THAT NOTES WILL BE TRIGGERED ON ALL CHANNELS)
	insno,ichan	xin						;READ IN INPUT ARGUMENTS
	kstatus, kchan, kdata1, kdata2  midiin				;READ IN MIDI
	if kchan==ichan||ichan==0 then					;IF A MESSAGE ON THE CORRECT CHANNEL HAS BEEN RECEIVED (OR ON ANY CHANNEL IF CHANNEL WAS DEFINED AS ZERO)
	 if kstatus==144 then						;IF MIDI MESSAGE IS A NOTE...
	  if kdata2>0 then						;IF VELOCITY IS MORE THAN ZERO, I.E. NOT A NOTE OFF
	 	event "i",insno+(kdata1*0.001),0,-1,kdata1,kdata2	;TRIGGER INSTRUMENT WITH A HELD NOTE. NOTE NUMBER TRANSMITTED AS p4, VELOCITY AS p5
	  else								;OTHERWISE (I.E. MUST BE A NOTE OFF / ZERO VELOCITY)
	   turnoff2	insno+(kdata1*0.001),4,1			;TURN OFF INSTRUMENT WITH THIS SPECIFIC FRACTIONAL NOTE NUMBER
	  endif								;END OF CONDITIONAL BRANCH
	 elseif kstatus==128 then					;IF MESSAGE USES A 'NOTE OFF' STATUS BYTE (128)
	  turnoff2	insno+(kdata1*0.001),4,1			;TURN OFF INSTRUMENT WITH THIS SPECIFIC FRACTIONAL NOTE NUMBER
	 endif								;END OF CONDITIONAL BRANCH
	endif								;END OF CONDITIONAL BRANCH
endop
