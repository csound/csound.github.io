;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"vcomb", 500,    200,    0,  0
 
;SWITCHES                                           		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
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
idlpt				FLvalue	" ",       80,     20,    5,  75
idrvt				FLvalue	" ",       80,     20,    5, 125
idamp				FLvalue	" ",       80,     20,    5, 175

;SLIDERS					            			MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gklpt,ihlpt			FLslider 	"Loop Time",			.0001, .1,  -1,    23,   idlpt,     490,     25,    5,    50
gkrvt,ihrvt			FLslider 	"Reverb Time",			.0001, 10,  -1,    23,   idrvt,     490,     25,    5,   100
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,      1,   0,    23,   idamp,     490,     25,    5,   150
gkingain,ihingain	FLslider 	"Live Input Gain",		0,       1,  0,    23,      -1,         140,      20, 350,     5

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	.0025, 	ihlpt
				FLsetVal_i	.2, 	ihrvt
				FLsetVal_i	.7, 	ihamp
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 660, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            vcomb                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Vcomb implements a comb filtering effect on an audio input.  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"This is described in the manual as 'coloured reverb'.        ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"In effect the comb filter is simply a delay with a feedback  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"loop as illustrated below:                                   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"                         +-----+                             ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"            INPUT-->--+--+DELAY+---+-->OUTPUT                ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"                      |  +-----+   |                         ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"                      |            |                         ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"                      +-[FEEDBACK]-+                         ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"Delay time is expressed as 'Loop Time' in the context of this", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"opcode but it is effectively the same thing as delay time.   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"A ratio for the amount of feedback is not directly accessible", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"but instead the user defines a value for 'Reverb Time' which ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"is the time it will take for an impulse's reverberant tail to", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"decay to 1/1000 of its initial strength (a 60 dB drop).      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"The use of feedback can create dramatic rises in output      ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"amplitude, therefore in this example I have included a slider", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"that controls output amplitude.                              ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Vcomb produces an audible transformation similar to the      ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"'wguide1' and 'streson' opcodes but as it lacks any lowpass  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"filtering within its algorithm it produces a sharper sound.  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"Vcomb differs from the 'comb' opcode in that it allows the   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"user to vary the 'Loop Time' parameter at rates other than   ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"i-rate. Because of this vcomb takes an additional input      ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"argument in which the user must declare the maximum 'Loop    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"Time that the opcode should expect (for memory allocation    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"purposes).                                                   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"input or the computer's live input. An input gain control on ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"the live input is also provided.                             ", 	1,      5,     14,    490,    15,     5, 640

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

instr	2
	;OUTPUT		OPCODE | INPUT | REVERB_TIME | LOOP_TIME_(DELAY_TIME) | MAXIMUM_LOOP_TIME
	aresL 		vcomb	gaSigL,     gkrvt,         gklpt,                  .1 
	aresR 		vcomb	gaSigR,     gkrvt,         gklpt,                  .1 
			outs	aresL * gkamp, aresR * gkamp	;SEND vcomb OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
	clear	gaSigL, gaSigR	;CLEAR GLOBAL AUDIO VARIABLES
endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       3600	;INSTRUMENT 2 PLAYS A HELD NOTE AND KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>