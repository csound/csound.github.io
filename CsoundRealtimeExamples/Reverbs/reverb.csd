;Written by Iain McCurdy, 2006

;THE REVERB OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

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
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"reverb",  500,    150,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,      -1
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
idmix				FLvalue	" ",       60,    18,     5,   75
idrvbtime			FLvalue	" ",       60,    18,     5,  125

;SLIDERS					            	MIN | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X | Y
gkmix,ihmix		FLslider 	"Dry/Wet Mix",		0,     1,    0,    23,   idmix,       490,      25,   5,   50
gkrvbtime,ihrvbtime	FLslider 	"Reverb time",		.001,  20,   0,    23,   idrvbtime,   490,      25,   5,  100
gkingain,ihingain	FLslider 	"Live Input Gain",		0,       1,  0,    23,      -1,         140,      20, 350,     5

;SET INITIAL VALUES OF FLTK VALUATORS
;					VALUE | HANDLE
			FLsetVal_i	.5, 	ihmix
			FLsetVal_i	.5, 	ihrvbtime

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 580, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           reverb                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"reverb is a basic reverberation unit. Within the opcode an   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"algorithm consisting of four parallel comb filters and two   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"series allpass filters is employed (shown below).            ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Its only obligatory input argument besides the input audio   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"signal is for reverb time in seconds. An optional 2-way      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"switch defines the initial disposition of the delay loop data", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"(0=cleared, 1=previous data retained).                       ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"It should be bourne in mind that the 'reverb' algorithm      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"represents quite a basic reverb algorithm and that with      ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"transient input audio granularity in the reverb effect       ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"becomes quite evident. (0=no filtering, 1=more filtering)    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"In this example a Dry/Wet Mix crossfader is also implemented.", 	1,      5,     14,    490,    20,     5, 240

ih		 	FLbox  	"          +----+                                             ", 	1,      5,     14,    490,    20,     5,  30+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    20,     5,  45+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    20,     5,  60+260
ih		 	FLbox  	"       |          |                                          ", 	1,      5,     14,    490,    20,     5,  75+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    20,     5,  90+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    20,     5, 105+260
ih		 	FLbox  	"       |  +----+  |  +-------+  +-------+                    ", 	1,      5,     14,    490,    20,     5, 120+260
ih		 	FLbox  	" IN-->-+          +--|allpass|--|allpass|-->-OUT             ", 	1,      5,     14,    490,    20,     5, 135+260
ih		 	FLbox  	"       |  +----+  |  +-------+  +-------+                    ", 	1,      5,     14,    490,    20,     5, 150+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    20,     5, 165+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    20,     5, 180+260
ih		 	FLbox  	"       |          |                                          ", 	1,      5,     14,    490,    20,     5, 195+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    20,     5, 210+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    20,     5, 225+260
ih		 	FLbox  	"          +----+                                             ", 	1,      5,     14,    490,    20,     5, 240+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 255+260
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"input or the computer's live input. An input gain control on ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"the live input is also provided.                             ", 	1,      5,     14,    490,    15,     5, 560
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

instr	2	;REVERBERATING INSTRUMENT
	aRvbL		reverb	gaSigL*.3, gkrvbtime	;CREATE LEFT CHANNEL REVERB
	aRvbR		reverb	gaSigR*.3, gkrvbtime	;CREATE RIGHT CHANNEL REVERB
	outs	(aRvbL * gkmix * .5) + (gaSigL * (1 - gkmix)), (aRvbR * gkmix * .5) + (gaSigR * (1 - gkmix))	;MIX SOURCE SIGNAL AND REVERB SIGNAL AT THE OUTPUT AND IMPLEMENT WET/DRY CONTROL USING THE FLTK SLIDER VARIABLE gkmix
	clear	gaSigL, gaSigR	;CLEAR GLOBAL AUDIO VARIABLES
endin
	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       3600	;INSTRUMENT 2 PLAYS A HELD NOTE AND KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>