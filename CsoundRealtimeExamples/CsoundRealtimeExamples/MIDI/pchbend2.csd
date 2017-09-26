pchbend2.csd
Written by Iain McCurdy, 2011. (Partially adapted from earlier examples.)

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	2	;NUMBER OF CHANNELS (1=STEREO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0   
;			LABEL	    WIDTH | HEIGHT | X | Y
	FLpanel		"pchbend2",  400,    75,    0,  0
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X |  Y  | OPCODE
gksource, ihsource	FLcount  "Sound File 1=Drums 2=Voice", 	1,     2,     1,      1,      2,    180,     28,    10,  5,    -1
gkmode, ihmode		FLcount  "Example", 			1,     5,     1,      1,      2,    180,     28,   210,  5,    -1

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	1,	ihsource
			FLsetVal_i	2,	ihmode

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,     760,   412, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          pchbend - some more elaborate applications         ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example suggests five examples of other ways of using a ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"MIDI pitch-bend wheel's unique characteristics.              ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"1. Diskin Player 1                                           ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"   Plays back a sound file using diskin2 and changes pitch   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"   and speed in the manner of changing the speed of a record.", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"   When pitch bend is at its equilibrium position playback   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"   speed is stop (zero). At the wheel's lowest extremity     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"   playback speed is double but reversed (-2), at its upper  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"   extremity playback speed is double (2).                   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"2. Diskin Player 2                                           ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"   Similar to example 1 except:                              ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"   When pitch bend is at its equilibrium position playback   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"   speed is normal (1). At the wheel's lowest extremity      ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"   playback speed is half (0.5), at its upper extremity      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"   playback speed is double (2).                             ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"3. Timestretching 1 (using 'mincer' opcode)                  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"   When pitch bend is at its equilibrium position playback   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"   speed is frozen. At the wheel's lowest extremity playback ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"   is reversed, at its upper extremity playback is normal.   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"   Pitch is derived from the MIDI note pressed.              ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"4. Timestretching 2 (using 'mincer' opcode)                  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"   When pitch bend is at its equilibrium position playback   ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"   speed is normal. At the wheel's lowest extremity playback ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"   speed is half, at its upper extremity playback speed is   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"   doubled. Pitch is derived from the MIDI note pressed.     ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"5. Panning                                                   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"   When pitch bend is at its equilibrium position the audio  ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"   is panned centrally. At the wheel's lowest extremity the  ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"   audio is panned to the left, at its upper extremity the   ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"   audio is panned to the right.                             ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"   Pitch is derived from the MIDI note pressed.              ", 	1,      5,     14,    490,    20,     5, 740
			FLpanel_end
			FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gifile1	ftgen	0,0,524288,1,"808loopMono.wav",0,0,0		;FILE 1 STORED TO RAM (FOR 'mincer' opcode)
gifile2	ftgen	0,0,262144,1,"AndItsAll.wav",0,0,0		;FILE 2 STORED TO RAM (FOR 'mincer' opcode)

instr	1
	kporttime	linseg	0,0.001,0.01			;A FUNCTION THAT RAMPS UP QUICKLY FROM ZERO TO A HELD VALUE
	
	if gkmode=1 then					;IF 'DISKIN PLAYER 1' EXAMPLE IS CHOSEN (OPTION 1). REVERSE_DOUBLE_SPEED -> STOP -> DOUBLE_SPEED
	  kbend	pchbend	0, 4					;PITCH BEND OUTPUTS VALUES IN THE RANGE -2 TO 2. EQUILIBRIUM POSITION = 0
	  kbend	portk	kbend, kporttime			;APPLY PORTAMENTO SMOOTHING TO PITCH BEND CHANGES	
	  if	gksource=1	then				;IF SOURCE IS 'DRUMS'...
		asig	diskin2	"808loopMono.wav",kbend,0,1	;CREATE AUDIO FROM DISKIN PLAYER USING FILE 1
	  else							;OTHERWISE (I.E. SOURCE IS 'VOICE')...
		asig	diskin	"AndItsAll.wav", kbend, 0, 1	;CREATE AUDIO FROM DISKIN PLAYER USING FILE 2
	  endif							;END OF CONDITIONAL
		outs	asig,asig				;SEND AUDIO TO OUPUTS

	elseif gkmode=2 then						;IF 'DISKIN PLAYER 2' EXAMPLE IS CHOSEN (OPTION 2). HALF-SPEED -> NORMAL-SPEED -> DOUBLE-SPEED
	  kbend	pchbend	0, 2						;PITCH BEND OUTPUTS VALUES IN THE RANGE -1 TO 1. EQUILIBRIUM POSITION = 0
	  kbend	portk	kbend, kporttime				;APPLY PORTAMENTO SMOOTHING TO PITCH BEND CHANGES	
	  if	gksource=1	then					;IF SOURCE IS 'DRUMS'...
		asig	diskin2	"808loopMono.wav",octave(kbend),0,1	;CREATE AUDIO FROM DISKIN PLAYER USING FILE 1
	  else								;OTHERWISE (I.E. SOURCE IS 'VOICE')...
		asig	diskin	"AndItsAll.wav",octave(kbend),0,1	;CREATE AUDIO FROM DISKIN PLAYER USING FILE 2
	  endif								;END OF CONDITIONAL
		outs	asig,asig					;SEND AUDIO TO OUPUTS

	elseif gkmode=3 then			;IF 'TIME-STRETCH 1' EXAMPLE IS CHOSEN (OPTION 3). REVERSE_NORMAL_SPEED -> STOP -> NORMAL_SPEED
	  kbend	pchbend	0, 2			;PITCH BEND OUTPUTS VALUES IN THE RANGE -1 TO 1. EQUILIBRIUM POSITION = 0
	  icps	cpsmidi				;READ IN MIDI PITCH
	  irtio	=	icps/cpsoct(8)		;CREATE A TRANSPOSITION RATIO (MIDDLE C WILL BE UNISON)
	  kbend	portk	kbend, kporttime	;APPLY PORTAMENTO SMOOTHING TO PITCH BEND CHANGES
	  ilen1	=	nsamp(gifile1)		;DEDUCE NUMBER OF AUDIO SAMPLE IN SOUND FILE
	  ilen2	=	nsamp(gifile2)		;DEDUCE NUMBER OF AUDIO SAMPLE IN SOUND FILE
	  aptr1	phasor	(kbend*sr)/ilen1	;CREATE A MOVING PHASE POINTER FOR FILE 1 (RANGE 0 - 1)
	  aptr2	phasor	(kbend*sr)/ilen2	;CREATE A MOVING PHASE POINTER FOR FILE 2 (RANGE 0 - 1)
	  if	gksource=1	then		;IF SOURCE IS 'DRUMS'...
	    asig	mincer	aptr1*(ilen1/sr),1,irtio,gifile1,0	;TIME STRETCHING OF FILE 1
	  else					;OTHERWISE (I.E. SOURCE IS 'VOICE')...
	    asig	mincer	aptr2*(ilen2/sr),1,irtio,gifile2,0	;TIME STRETCHING OF FILE 2
	  endif					;END OF CONDITIONAL BRANCH
	  	outs	asig,asig		;SEND AUDIO TO OUTPUTS AND CONTROL OUTPUT AMPLITUDE

	elseif gkmode=4 then			;IF 'TIME-STRETCH 2' EXAMPLE IS CHOSEN (OPTION 4). HALF_SPEED -> NORMAL_SPEED -> DOUBLE_SPEED
	  kbend	pchbend	0, 2			;PITCH BEND OUTPUTS VALUES IN THE RANGE -1 TO 1. EQUILIBRIUM POSITION = 0
	  icps	cpsmidi				;READ IN MIDI PITCH
	  irtio	=	icps/cpsoct(8)		;CREATE A TRANSPOSITION RATIO (MIDDLE C WILL BE UNISON)
	  kbend	=	octave(kbend)		;NOW WITHIN THE RANGE 0.5 - 2. EQUILIBRIUM POSITION = 1.
	  kbend	portk	kbend, kporttime	;APPLY PORTAMENTO SMOOTHING TO PITCH BEND CHANGES
	  ilen1	=	nsamp(gifile1)		;DEDUCE NUMBER OF AUDIO SAMPLE IN SOUND FILE
	  ilen2	=	nsamp(gifile2)		;DEDUCE NUMBER OF AUDIO SAMPLE IN SOUND FILE
	  aptr1	phasor	(kbend*sr)/ilen1	;CREATE A MOVING PHASE POINTER FOR FILE 1 (RANGE 0 - 1)
	  aptr2	phasor	(kbend*sr)/ilen2	;CREATE A MOVING PHASE POINTER FOR FILE 2 (RANGE 0 - 1)
	  if	gksource=1	then		;IF SOURCE IS 'DRUMS'...
	    asig	mincer	aptr1*(ilen1/sr), 1, irtio, gifile1, 0	;TIME STRETCHING OF FILE 1
	  else					;OTHERWISE (I.E. SOURCE IS 'VOICE')...
	    asig	mincer	aptr2*(ilen2/sr), 1, irtio, gifile2, 0	;TIME STRETCHING OF FILE 2
	  endif					;END OF CONDITIONAL BRANCH
	  	outs	asig,asig		;SEND AUDIO TO OUTPUTS AND CONTROL OUTPUT AMPLITUDE

	elseif gkmode=5 then					;IF 'PANNING' EXAMPLE IS CHOSEN (OPTION 5). PAN_TO_LEFT -> CENTRE -> PAN_TO_RIGHT
	  kbend	pchbend	0.5, 1.5				;PITCH BEND OUTPUTS VALUES IN THE RANGE 0 - 1. EQUILIBRIUM POSITION = 0.5
	  kbend	portk	kbend, kporttime			;APPLY PORTAMENTO SMOOTHING TO PITCH BEND CHANGES
	  icps	cpsmidi				;READ IN MIDI PITCH
	  irtio	=	icps/cpsoct(8)		;CREATE A TRANSPOSITION RATIO (MIDDLE C WILL BE UNISON)
	  if	gksource=1	then				;IF SOURCE IS 'DRUMS'...
		asig	diskin2	"808loopMono.wav",irtio,0,1	;CREATE LOOPING AUDIO SIGNAL FROM FILE 1
	  else							;OTHERWISE (I.E. SOURCE IS 'VOICE')...
		asig	diskin2	"AndItsAll.wav",irtio,0,1	;CREATE LOOPING AUDIO SIGNAL FROM FILE 2
	  endif							;END OF CONDITIONAL BRANCH
	  aL,aR	pan2	asig,kbend				;CREATE STEREO PANNED SIGNAL
		outs	aL,aR					;SEND AUDIO TO OUPUTS

	endif				 ;END OF CONDITIONAL BRANCH (SELECT EXAMPLE BLOCK)
endin

</CsInstruments>

<CsScore>
f 0 86400	; ALLOWS REALTIME MIDI PLAYING FOR 1 DAY
</CsScore>

</CsoundSynthesizer>