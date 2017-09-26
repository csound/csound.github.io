delayCompletedPitchShifter.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -M0 -+rtmidi=virtual -+raw_controller_mode=1 -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL             | WIDTH | HEIGHT | X | Y
	FLpanel	"Completed Pitch Shifter",   500,    350,    0,  0

;SWITCHES                                              	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput, ihinput	FLbutBank	14,     1,     2,     18,      40,  165,  0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Source:",		1,       6,    12,    40,      18,   120,  0
ih		 	FLbox  	"Soundfile", 		1,       5,    12,    60,      20,   190,  0
ih		 	FLbox  	"Live     ", 		1,       5,    12,    60,      20,   190, 20

;VALUE_DISPLAY_BOXES		WIDTH | HEIGHT | X | Y
idtrans		FLvalue   " ",	88,       20,    5,   75
iddlt		FLvalue   " ",	88,       20,    5,  125
idFB		FLvalue   " ",	88,       20,    5,  175
idFB2		FLvalue   " ",	88,       20,    5,  225
idDryGain	FLvalue   " ",	88,       20,    5,  275
idWetgain	FLvalue   " ",	88,       20,    5,  325

;SLIDERS					            			MIN | MAX | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gktrans,gihtrans		FLslider 	"Transposition (semitones)",	-24,   24,    0,    23,   idtrans,    365,     25,    5,  50
gkdlt,gihdlt			FLslider 	"Delay Time",		0.01,   2,   -1,    23,   iddlt,      490,     25,    5, 100
gkFB,gihFB			FLslider	"Feedback (Type 1)",  		0,   0.99,    0,    23,   idFB,       490,     25,    5, 150
gkFB2,gihFB2			FLslider	"Feedback (Type 2)",  		0,   0.99,    0,    23,   idFB2,      490,     25,    5, 200
gkDryGain,ihDryGain		FLslider	"Dry Gain",  			0,      1,    0,    23,   idDryGain,  490,     25,    5, 250
gkWetGain,ihWetGain		FLslider	"Wet Gain",  			0,      1,    0,    23,   idWetgain,  490,     25,    5, 300

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gktrans, gihtrans2 	FLcount  "Transposition",	-24,  24,    1,      12,     1,     120,     25,   375, 50,   -1

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i   	0, 	gihtrans
		FLsetVal_i	0,	gihtrans2
		FLsetVal_i   	0.05, 	gihdlt
		FLsetVal_i   	0, 	gihFB
		FLsetVal_i   	0, 	gihFB2
		FLsetVal_i   	0, 	ihDryGain
		FLsetVal_i   	1, 	ihWetGain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 780, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               delay - completed pitch shifter               ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example is an refinement of the 'Delay: Simple Pitch    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Shifter' example in that amplitude enveloping is employed to ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"prevent glitching in the sound output whenever the sawtooth  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"LFO waveform that modulates delay time instantaneously jumps ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"from a maximum to a minimum (or vice versa).                 ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Two modulated delay taps (180 degrees out of phase with each ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"other) are employed and are enveloped individually.          ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"The outputs of the two delay taps are mixed to create an - as", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"smooth as possible - pitch shifted output.                   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"Pitch shifting effects can also be produced using any of the ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"granular synthesis opcodes but this method has the advantage ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"that it can be applied to a streamed live audio input or a   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"signal generated within Csound and it does not rely upon a   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"stored function table.                                       ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Some experimentation with the setting for 'Delay Time' can   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"enhance the resultant sound quality. An appropriate setting  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"for 'Delay Time' is partially dependent upon the type of     ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"sound material being processed. Most hardware implementations", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"of pitch shifters do not include this parameter.             ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Large values for 'Delay Time' tend to temporally smear the   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"processed sound whereas excessively small values for 'Delay  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"Time' tend to distort the harmonic content of the original   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"sound.                                                       ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"'Feedback' allows some of the pitch shifted sound to be fed  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"back into the pitch shifter to be pitch shifted again. Two   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"methods of feedback are employed in this example: In 'Type 1'", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"the unenveloped sound from each delay tap is fed directly    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"back into the input of the same delay buffer. In 'Type 2' the", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"enveloped and mixed outputs of the two delays buffers are fed", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"back into the input of both buffers. It can be heard that the", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"results of the two methods are subtly different.             ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"If the pitch shifter is triggered from a MIDI keyboard,      ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"transposition will be determined by the number of semitone   ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"steps from middle C. Polyphony is possible when MIDI         ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"triggering is used.                                          ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"The code for the pitch shifter is placed within a UDO to     ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"facilitate easy transplantation into other projects.         ", 	1,      5,     14,    490,    20,     5, 760

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gihalfsine	ftgen	0, 0, 1025, 9, 0.5, 1, 0	;HALF SINE  WINDOW FUNCTION USED FOR AMPLITUDE ENVELOPING
gasigL,gasigR	init	0

opcode	PitchShifterDelay,a,akkkki
	;		setksmps	1			;UDO ksmps CAN BE SET INDEPENDENTLY OF GLOBAL ksmps
	ain,ktrans,kdlt,kFB,kFB2,imaxdlt	xin
	ihalfsine	ftgen	0, 0, 1025, 9, 0.5, 1, 0	;HALF SINE  WINDOW FUNCTION USED FOR AMPLITUDE ENVELOPING
	koctfract	=	ktrans/12			;TRANSPOSITION AS FRACTION OF AN OCTAVE
	kratio		=	octave(koctfract)		;RATIO TO PRODUCE PITCH SHIFT
	krate		=	(kratio-1)/kdlt			;SUBTRACT 1/1 SPEED
	
	aphase1		phasor	-krate				;MOVING PHASE 1-0
	aphase2		phasor	-krate, .5			;MOVING PHASE 1-0 - PHASE OFFSET BY 180 DEGREES (.5 RADIANS)
	
	agate1		tablei	aphase1, ihalfsine, 1, 0, 1	;WINDOW FUNC =HALF SINE
	agate2		tablei	aphase2, ihalfsine, 1, 0, 1	;WINDOW FUNC =HALF SINE
	
	adlt		interp	kdlt				;CREATE A RATE (INTERPOLATED FROM K-RATE) VERSION OF kdlt
	aout		init	0				;INITIALISE OUTPUT AUDIO SIGNAL (NEEDED FOR FEEDBACK SIGNAL (METHOD 2))
	
	abuffer		delayr	imaxdlt				;DECLARE DELAY BUFFER
	adelsig1	deltap3	aphase1 * adlt			;VARIABLE TAP
	aGatedSig1	=	adelsig1 * agate1
			delayw	ain + (aGatedSig1*kFB) + (aout*kFB2)	;WRITE AUDIO TO THE BEGINNING OF THE DELAY BUFFER, MIX IN FEEDBACK SIGNAL - PROPORTION DEFINED BY gkFB
	
	abuffer		delayr	imaxdlt				;DECLARE DELAY BUFFER
	adelsig2	deltap3	aphase2 * adlt			;VARIABLE TAP
	aGatedSig2	=	adelsig2 * agate2
			delayw	ain + (aGatedSig2*kFB) + (aout*kFB2)	;WRITE AUDIO TO THE BEGINNING OF THE DELAY BUFFER, MIX IN FEEDBACK SIGNAL - PROPORTION DEFINED BY gkFB
	aout		=	(aGatedSig1 + aGatedSig2) * 0.5
	aout		dcblock2	aout			;REMOVE DC OFFSET (DC OFFSET CAN SOMETIMES BE A PROBLEM WHEN BOTH FEEDBACKS ARE COMBINED)
		xout	aout					;SUM AND RESCALE PITCH SHIFTER OUTPUTS (LEFT CHANNEL)
endop

instr	SourceSound
	if	gkinput=0	then					;...IF INPUT IS SOUND FILE 
	 
	 ;ENSURE SOUND FILE ALWAYS BEGINS AT THE BEGINNING EACH TIME A NEW CHORD IS BEGUN 	;
	 kactive	active	1								;SENSE NUMBER OF ACTIVE MIDI NOTES
	 kreset	trigger	kactive,0.5,0								;IF THIS IS THE FIRST NOTE OF A CHORD...
	 if kreset==1 then									;
	  reinit reset										;...REINIT
	 endif											;
	 reset:											;
	 
	  gasigL,gasigR	diskin2	"ClassicalGuitar.wav",1, 0, 1	;   ...READ SOUND FILE
	 rireturn
	 else								;   OTHERWISE...
	 gasigL, gasigR	ins					;   ...READ LIVE INPUT
	endif
endin

instr	1	;PITCH SHIFTER
	kporttime	linseg	0,0.001,0.005		;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	
	if iMIDIflag==1 then				;IF MIDI ACTIVATED...
	 inum	notnum					;...READ IN MIDI NOTE NUMBER
	 ktrans	=	inum-60				;   TRANSPOSITION IN SEMITONES ABOUT MIDDLE C (NOTE NUMBER 60)
	else						;OTHERWISE THIS MUST HAVE BEEN FLTK ACTIVATED AND THEREFORE...
	 ktrans		portk	gktrans, kporttime	;...SMOOTH CHANGES IN SLIDER VARIABLE
	endif
	
	aenv	linsegr	0,0.02,1,0.1,0					;ANTI-CLICK ENVELOPE

	asigL	=	gasigL*aenv					;APPLY ANTI CLICK ENVELOPE AND CREATE LOCAL AUDIO VARIABLE FOR THIS INSTRUMENT INSTANCE
	asigR	=	gasigR*aenv					; " " " ...
	kdlt		portk	gkdlt, kporttime*100	;SMOOTH CHANGES IN SLIDER VARIABLE
	
	;CALL THE UDO - ONCE FOR EACH CHANNEL
	aPSL		PitchShifterDelay		asigL,ktrans,kdlt,gkFB,gkFB2,2
	aPSR		PitchShifterDelay		asigR,ktrans,kdlt,gkFB,gkFB2,2
	
	aoutL		=	((aPSL*gkWetGain)+(asigL*gkDryGain))*aenv
	aoutR		=	((aPSR*gkWetGain)+(asigR*gkDryGain))*aenv
			outs	aoutL, aoutR		;SEND AUDIO TO OUTPUTS

	if gkOnOff=0&&iMIDIflag=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif			;END OF CONDITIONAL BRANCHING
endin

</CsInstruments>

<CsScore>
i "SourceSound" 0 3600
</CsScore>

</CsoundSynthesizer>