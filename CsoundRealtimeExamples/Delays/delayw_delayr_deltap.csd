delayw_delayr_deltap.csd
Written by Iain McCurdy, 2006

THE delay OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

ksmps MAY NEED TO BE LOW (AND kr THEREFORE HIGH) WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                 | WIDTH | HEIGHT | X | Y
		FLpanel	"delayr,delayw,deltap",  500,    200,    0,  0

;                                                      	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Input On/Off",	1,    0,    22,    180,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   250, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      16, 200,   0
ih		 	FLbox  	"Drum Loop", 		1,       5,    14,     75,      16, 270,   0
ih		 	FLbox  	"Live     ", 		1,       5,    14,     75,      16, 270,  20

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",      80,    20,     5,  75
idmix				FLvalue	" ",      80,    20,     5, 125
idgain				FLvalue	" ",      80,    20,     5, 175

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",		.001,  5,    0,    23,   iddlt,    490,     25,    5,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,     1,    0,    23,   idmix,    490,     25,    5, 100
gkgain,ihgain			FLslider 	"Output Gain",			0,     1,    0,    23,   idgain,   490,     25,    5, 150
gkingain,ihingain		FLslider 	"Live Input Gain",		0,     1,    0,    23,   -1,       140,     20,  350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihdlt
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	1, 	ihgain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 740, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      delayr delayw deltap                   ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"A common way to implement a delay line in Csound is through a", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"combination of three opcodes.                                ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Delayr is used to inititiate a delay buffer. This allocates  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"computer RAM for audio storage. Delayr's only input argument ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"is the duration of the buffer in seconds. The buffer duration", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"should be at least equal to the duration of the longest delay", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"tap required. The buffer duration can be overestimated but   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"vast overestimation is wasteful of computer RAM.             ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Delayr's audio output is the audio signal read at the end of ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"the buffer. Normally this signal is left unused but it is    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"still required that we define it as a variable nonetheless.  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Delayw is used to write audio into the beginning of the delay", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"buffer. Its only input argument is the source signal to be   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"written into the buffer. Delayw has no output arguments.     ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Deltap is used to tap the delay buffer at some point across  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"its duration. Its only input argument is the delay time      ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"(in seconds) at which to tap the audio buffer. This time     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"value should not exceed the entire duration of the buffer    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"previously defined using delayr and it should not be less    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"than ksmps (ksmps=control rate cycle duration) For this      ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"reason ksmps may need to be set low and therefore kr         ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"(kr=number of audio samples in a control-rate cycle) may need", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"to be set high in to allow very short delay times. The delay ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"time given to the deltap opcode should not be zero or a      ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"negative value. The deltap code is placed after the delayr   ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"code and before the delayw code.                             ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"There are opcodes that allow the creation of a delay in a    ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"single line of code but they do not allow the flexibilty of  ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"including further signal processing within the delay buffer. ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"Examples of the kind of processing that can be used within   ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"the delay buffer are explored in subsequent examples in this ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"section.                                                     ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"In this example the user can choose between a drum loop sound", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"file as input or the computer's live input. A gain control is", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"is provided to control the gain of the live input.           ", 	1,      5,     14,    490,    15,     5, 720

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;PLAYS FILE
	if gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT '808loop.wav' IS SELECTED...
		gasigL, gasigR	diskin2	"808loop.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	else				;OTHERWISE
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr 		2	;DELAY INSTRUMENT
	;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	abufferL	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigL 	deltap	gkdlt	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasigL	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER
	
	;;;RIGHT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	abufferR	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigR 	deltap	gkdlt	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasigR	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER
	
			aL	ntrpol	gasigL, adelsigL, gkmix
			aR	ntrpol	gasigR, adelsigR, gkmix
			outs		aL * gkgain, aR * gkgain	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
	clear	gasigL, gasigR	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























