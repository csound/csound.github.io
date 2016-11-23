GatedReverb.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
;NOTE: compress OPCODE EXPECTS AMPLITUDE VALUES IN THE RANGE -32768 TO 32767 SO DON'T USE 0dbfs=1 

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL          | WIDTH | HEIGHT | X | Y
		FLpanel	"Gated Reverb",   500,    375,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   230, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      20, 180,   0
ih		 	FLbox  	"Drum Loop", 		1,       5,    14,     75,      20, 250,   0
ih		 	FLbox  	"Live     ", 		1,       5,    14,     75,      20, 250,  20

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idlpt				FLvalue	" ",      100,     20,    5,  75
idrvt				FLvalue	" ",      100,     20,    5, 125
idamp				FLvalue	" ",      100,     20,    5, 175
idFreq				FLvalue	" ",      100,     20,    5, 100
idHFDamp			FLvalue	" ",      100,     20,    5, 150
idmix				FLvalue	" ",      100,     20,    5, 200
idgatethresh			FLvalue	" ",      100,     20,    5, 250
idgaterelease			FLvalue	" ",      100,     20,    5, 300

;SLIDERS					            			MIN |  MAX | EXP | TYPE | DISP         | WIDTH | HEIGHT | X | Y
gkRoomSize,ihRoomSize		FLslider 	"Room Size",			0,      1,    0,    23,  idFreq,          490,     25,    5,  75
gkHFDamp,ihHFDamp		FLslider 	"High Frequency Damping",	0,      1,    0,    23,  idHFDamp,        490,     25,    5, 125
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,      1,    0,    23,  idmix,           490,     25,    5, 175
gkgatethresh,ihgatethresh	FLslider 	"Gate Threshold",		0,     90,    0,    23,  idgatethresh,    490,     25,    5, 225
gkgaterelease,ihgaterelease	FLslider 	"Gate Release Time",		0.001,0.5,   -1,    23,  idgaterelease,   490,     25,    5, 275
gkingain,ihingain		FLslider 	"Live Input Gain",		0,      1,    0,    23,      -1,          140,     20, 350,    5
gkamp,ihamp			FLslider 	"Amplitude",			0,      1,    0,    23,      -1,          490,     25,    5, 325

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.9, 	ihRoomSize
		FLsetVal_i	.2, 	ihHFDamp
		FLsetVal_i	0.75, 	ihmix
		FLsetVal_i	50, 	ihgatethresh
		FLsetVal_i	0.001, 	ihgaterelease
		FLsetVal_i	0.5, 	ihamp

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 395, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Gated Reverb                        ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"A gated reverb is created by passing the audio signal into a ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"reverb effect then into a compressor and then into a noise   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"gate. The unprocessed input signal is used as the trigger    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"input for the noise gate.                                    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"            +------+   +----------+   +----------+           ",	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"        +---|REVERB|---|COMPRESSOR|---|(input)   |           ", 	1,      5,     14,    490,    15,     5, 135
ih		 	FLbox  	" INPUT->+   +------+   +----------+   |NOISE GATE|--->OUTPUT ", 	1,      5,     14,    490,    15,     5, 150
ih		 	FLbox  	"        |                             |          |           ", 	1,      5,     14,    490,    15,     5, 165
ih		 	FLbox  	"        +----------------------------->(trigger) |           ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                                      +----------+           ", 	1,      5,     14,    490,    15,     5, 195
ih		 	FLbox  	"Optionally the input signal could be passed through a        ", 	1,      5,     14,    490,    20,     5, 215
ih		 	FLbox  	"separate compressor before being passed into the trigger     ", 	1,      5,     14,    490,    20,     5, 235
ih		 	FLbox  	"input of the noise gate.                                     ", 	1,      5,     14,    490,    20,     5, 255
ih		 	FLbox  	"The gate threshold for the noise gate is effectively the     ", 	1,      5,     14,    490,    20,     5, 275
ih		 	FLbox  	"control of the duration of the gate reverb effect. Room size ", 	1,      5,     14,    490,    20,     5, 295
ih		 	FLbox  	"will, in this context, control the quality of the reverb     ", 	1,      5,     14,    490,    20,     5, 315
ih		 	FLbox  	"effect.                                                      ", 	1,      5,     14,    490,    20,     5, 335
ih		 	FLbox  	"Gated reverbs were a popular effect on snare drums in 1980s  ", 	1,      5,     14,    490,    20,     5, 355
ih		 	FLbox  	"pop music.                                                   ", 	1,      5,     14,    490,    20,     5, 375

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;PLAYS FILE AND OUTPUTS GLOBAL VARIABLES
	if gkOnOff=0	then
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT 'Drum Loop' IS SELECTED...
		gaSigL, gaSigR	diskin2	"808loop.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	else				;OTHERWISE
		aSigL, aSigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gaSigL	=	aSigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gaSigR	=	aSigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr	2	;REVERB - ALWAYS ON
	;REVERB
	denorm		gaSigL, gaSigR	;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
	arvbL, arvbR 	freeverb 	gaSigL, gaSigR, gkRoomSize, gkHFDamp
	rireturn			;RETURN TO PERFORMANCE TIME PASSES

	;COMPRESSOR		aasig, acsig, kthresh, kloknee, khiknee, kratio, katt, krel, ilook
	acompL	compress	arvbL, arvbL,    0,       40,     60,     10,    0.1,  0.5,  0.02	;COMPRESS REVERB SIGNAL
	acompR	compress	arvbR, arvbR,    0,       40,     60,     10,    0.1,  0.5,  0.02	;COMPRESS REVERB SIGNAL
	acompL	=		acompL * 8	;COMPENSATE FOR GAIN LOSS AS A RESULT OF COMPRESSION
	acompR	=		acompR * 8	;COMPENSATE FOR GAIN LOSS AS A RESULT OF COMPRESSION

	;NOISE GATE
	aMix	sum		gaSigL*0.5, gaSigR*0.5							;CREATE A MIX OF BOTH CHANNELS OF THE INPUT SIGNAL
	acomp	compress	aMix, aMix,  0,       40,     60,    100,    0.01,  0.1,  0.02	;COMPRESS DRY SIGNAL
	acomp	=	acomp * 20									;GAIN COMPENSATION
	krms	rms	acomp				;SCAN THE RMS *ROOT MEAN SQUARE) VALUE OF THE AUDIO 
	kdb	= 	dbamp(krms)			;CONVERT RMS TO A DECIBEL VALUE
	kgate	=	(kdb>gkgatethresh?1:0)		;DEFINE GATE AS 'OPEN' (1) OR 'CLOSED' (2) ACCORDING TO DECIBEL LEVEL IN REFERENECE TO GATE THRESHOLD DEFINE BY ON SCREEN SLIDER
	agate	interp	kgate				;COVERT GATE SIGNAL TO A-RATE WITH INTERPOLATION
	agate	follow2	agate,0.001,gkgaterelease	;SMOOTH GATE OPENING AND CLOSING USING follow2. NOTE THAT WE CAN DEFINE SEPARATE OPEN AND CLOSE TIMES
	agatedL	=	acompL * agate			;APPLY GATE DYNAMIC CONTROL TO REVERB SOUND (LEFT CHANNEL)
	agatedR	=	acompR * agate			;APPLY GATE DYNAMIC CONTROL TO REVERB SOUND (RIGHT CHANNEL)

	;WET/DRY MIXER
	amixL	ntrpol	gaSigL, agatedL, gkmix		;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
	amixR	ntrpol	gaSigR, agatedR, gkmix		;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
		outs	amixL*gkamp, amixR*gkamp	;SEND AUDIO TO OUTPUTS. SCALE AMPLITUDE WITH AMPLITUDE SLIDER
	clear	gaSigL, gaSigR	;CLEAR GLOBAL AUDIO VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       3600	;INSTRUMENT 2 (GATED REVERB INSTRUMENT) PLAYS A HELD NOTE AND KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>