;Written by Iain McCurdy, 2006

;THE freeverb OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"freeverb", 500,    275,    0,  0

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

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idFreq				FLvalue	" ",     100,    20,     5, 100
idHFDamp			FLvalue	" ",     100,    20,     5, 150
idmix				FLvalue	" ",     100,    20,     5, 200

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    140,     25,   355,225,   -1

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkRoomSize,ihRoomSize		FLslider 	"Room Size",			0,     1,    0,    23,  idFreq,    490,     25,    5,  75
gkHFDamp,ihHFDamp		FLslider 	"High Frequency Damping",	0,     1,    0,    23,  idHFDamp,  490,     25,    5, 125
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,     1,    0,    23,  idmix,     490,     25,    5, 175
gkingain,ihingain		FLslider 	"Live Input Gain",		0,       1,  0,    23,      -1,         140,      20, 350,     5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihRoomSize
		FLsetVal_i	.5, 	ihHFDamp
		FLsetVal_i	.5, 	ihmix

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 820, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           freeverb                          ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"freeverb is a Csound implementation of Jezar's Freeverb      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"reverb plugin effect. This algorithm uses 8 parallel comb    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"filters followed by 4 series allpass filters (as show below).", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The opcode is stereo and this algorithm is applied separately", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"on both channels. The comb and allpass filters on the right  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"channel are detuned with respect to those on the left in     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"order to create a stereo effect. Input arguments include room", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"size and high frequency damping.                             ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"Optional arguments are for a value defining the expected     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"sample rate (default=44100) and an optional 2-way switch     ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"is provided, if non-zero initialisation will, whenever       ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"possible, be skipped.                                        ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    20,     5, 300-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 315-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 330-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5, 345-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 360-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 375-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 390-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5, 405-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 420-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 435-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 450-20
ih		 	FLbox  	"     +        +                                              ", 	1,      5,     14,    490,    20,     5, 465-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 480-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 495-20
ih		 	FLbox  	"     | +----+ | +-------+ +-------+ +-------+ +-------+      ", 	1,      5,     14,    490,    20,     5, 510-20
ih		 	FLbox  	"IN-->|        |-|allpass|-|allpass|-|allpass|-|allpass|-->OUT", 	1,      5,     14,    490,    20,     5, 525-20
ih		 	FLbox  	"     | +----+ | +-------+ +-------+ +-------+ +-------+      ", 	1,      5,     14,    490,    20,     5, 540-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 555-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 570-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5, 585-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 600-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 615-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 630-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5, 645-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 660-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 675-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 690-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5, 705-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 720-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 735-20
ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    20,     5, 750-20
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"input or the computer's live input. An input gain control on ", 	1,      5,     14,    490,    15,     5, 780
ih		 	FLbox  	"the live input is also provided.                             ", 	1,      5,     14,    490,    15,     5, 800

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gaSigL,gaSigR	init	0

instr	1	;PLAYS FILE AND OUTPUTS GLOBAL VARIABLES
	if gkOnOff==0	then
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
	kSwitch		changed		gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF kSwitch=1 THEN
		reinit	UPDATE		;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;A LABEL
	denorm		gaSigL, gaSigR	;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
	arvbL, arvbR 	freeverb 	gaSigL, gaSigR, gkRoomSize, gkHFDamp , sr, i(gkskip)
	rireturn			;RETURN TO PERFORMANCE TIME PASSES
	amixL		ntrpol		gaSigL, arvbL, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
	amixR		ntrpol		gaSigR, arvbR, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
			outs		amixL, amixR
	gaSigL		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
	gaSigR		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
	clear	gaSigL, gaSigR	;CLEAR GLOBAL AUDIO VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       3600	;INSTRUMENT 2 PLAYS A HELD NOTE AND KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>