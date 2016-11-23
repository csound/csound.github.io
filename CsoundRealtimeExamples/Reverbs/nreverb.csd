;Written by Iain McCurdy, 2006

;THE NREVERB OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
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
;				LABEL    | WIDTH | HEIGHT | X | Y
			FLpanel	"nreverb",  500,    200,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
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
idmix				FLvalue	" ",      60,      18,    5,   75
idrvbtime			FLvalue	" ",      60,      18,    5,  125
idHFDiff			FLvalue	" ",      60,      18,    5,  175

;SLIDERS					            			MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkmix,ihmix		FLslider 	"Dry/Wet Mix",		 		0,      1,    0,   23,   idmix,      490,    25,     5,   50
gkrvbtime,ihrvbtime	FLslider 	"Reverb time",		 		.001,   20,   0,   23,   idrvbtime,  490,    25,     5,  100
gkHFDiff,ihHFDiff	FLslider 	"High Freq Diffusion",		 	0,      1,    0,   23,   idHFDiff,   490,    25,     5,  150
gkingain,ihingain	FLslider 	"Live Input Gain",		0,       1,  0,    23,      -1,         140,      20, 350,     5

;SET INITIAL VALUES OF FLTK VALUATORS
;					VALUE | HANDLE
			FLsetVal_i	.5, 	ihmix
			FLsetVal_i	.5, 	ihrvbtime
			FLsetVal_i	.5, 	ihHFDiff

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 740, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          nreverb                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"nreverb is a reverberation unit within which is contained an ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"algorithm consisting of six parallel comb filters and five   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"series allpass filters (as shown below).                     ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Obligatory input arguments besides the input audio signal are", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"for reverb time in seconds and for high frequency diffusion  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"(range: 0 to 1). Use of high frequency diffusion activates   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"low pass filters within the algorithm which can help improve ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"the simulation of a real acoustic space.                     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"An optional 2-wayswitch defines the initial disposition of   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"the delay loop data (0=cleared, 1=previous data retained).   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"It should be bourne in mind that the 'reverb' algorithm      ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"represents quite a basic reverb algorithm and that with      ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"transient input audio granularity in the reverb effect       ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"becomes quite evident.                                       ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"In this example a Dry/Wet Mix crossfader is also implemented.", 	1,      5,     14,    490,    20,     5, 300

ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    20,     5,  30+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5,  45+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5,  60+300
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5,  75+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5,  90+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 105+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 120+300
ih		 	FLbox  	"     +        +                                              ", 	1,      5,     14,    490,    20,     5, 135+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 150+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 165+300
ih		 	FLbox  	"     | +----+ | +-----+ +-----+ +-----+ +-----+ +-----+      ", 	1,      5,     14,    490,    20,     5, 180+300
ih		 	FLbox  	"IN-->|        |-|alpas|-|alpas|-|alpas|-|alpas|-|alpas|-->OUT", 	1,      5,     14,    490,    20,     5, 195+300
ih		 	FLbox  	"     | +----+ | +-----+ +-----+ +-----+ +-----+ +-----+      ", 	1,      5,     14,    490,    20,     5, 210+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 225+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 240+300
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5, 255+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 270+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 285+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 300+300
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    20,     5, 315+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    20,     5, 330+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    20,     5, 345+300
ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    20,     5, 360+300
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"input or the computer's live input. An input gain control on ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"the live input is also provided.                             ", 	1,      5,     14,    490,    15,     5, 720

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
	aRvbL		nreverb	gaSigL*.3, gkrvbtime, gkHFDiff	;CREATE LEFT CHANNEL REVERB 
	aRvbR		nreverb	gaSigR*.3, gkrvbtime, gkHFDiff	;CREATE RIGHT CHANNEL REVERB
			outs	(aRvbL * gkmix * .5) + (gaSigL * (1 - gkmix)), (aRvbR * gkmix * .5) + (gaSigR * (1 - gkmix))	;MIX SOURCE SIGNAL AND REVERB SIGNAL AT THE OUTPUT AND IMPLEMENT WET/DRY CONTROL USING THE FLTK SLIDER VARIABLE gkmix
	clear	gaSigL, gaSigR	;CLEAR GLOBAL AUDIO VARIABLES
endin
	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       3600	;INSTRUMENT 2 PLAYS A HELD NOTE AND KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>