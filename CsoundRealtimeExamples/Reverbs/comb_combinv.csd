;comb_combinv.csd
;Written by Iain McCurdy, 2006
;combinv added 2013

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
				FLpanel	"comb",    500,    250,    0,  0
 
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,   22,     80,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   140, 0,   -1
gkopcode, ihopcode		FLbutBank	14,     1,     2,     18,      40,   240, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      18,  90,   0
ih		 	FLbox  	"Seashore", 		1,       5,    14,     65,      18, 160,   0
ih		 	FLbox  	"Live    ", 		1,       5,    14,     65,      18, 160,  20
ih		 	FLbox  	"comb   ", 		1,       5,    14,     50,      18, 262,   0
ih		 	FLbox  	"combinv", 		1,       5,    14,     50,      18, 262,  20

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idlpt				FLvalue	" ",      100,     20,    5,  75
idrvt				FLvalue	" ",      100,     20,    5, 125
iddrywet			FLvalue	" ",      100,     20,    5, 175
idamp				FLvalue	" ",      100,     20,    5, 225

;SLIDERS					            			MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gklpt,ihlpt			FLslider 	"Loop Time (i-rate)",		.0001, .1,  -1,    23,   idlpt,     490,     25,    5,    50
gkrvt,ihrvt			FLslider 	"Reverb Time",			.0001, 10,  -1,    23,   idrvt,     490,     25,    5,   100
gkdrywet,ihdrywet		FLslider 	"Dry/Wet Mix",			0,      1,   0,    23,   iddrywet,  490,     25,    5,   150
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,      1,   0,    23,   idamp,     490,     25,    5,   200
gkingain,ihingain		FLslider 	"Live Input Gain",		0,      1,   0,    23,      -1,     140,      20, 350,     5

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	.0025, 	ihlpt
				FLsetVal_i	.2, 	ihrvt
				FLsetVal_i	.7, 	ihamp
				FLsetVal_i	1, 	ihdrywet
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 600, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       comb combinv                          ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Comb implements a comb filtering effect on an audio input.   ", 	1,      5,     14,    490,    20,     5,  40
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
ih		 	FLbox  	"Comb produces an transformation similar to the 'wguide1'     ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"and 'streson' opcodes but as it lacks any lowpass filtering  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"within its algorithm it produces a brighter sound.           ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"'combinv' is a variation of the comb algorithm in which the  ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"internal feedback is inverted resulting in a markedly        ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"different sound.                                             ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"input or the computer's live input. An input gain control on ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"the live input is also provided.                             ", 	1,      5,     14,    490,    15,     5, 580

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;PLAYS FILE AND OUTPUTS GLOBAL VARIABLES
	if gkOnOff=0	then
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT 'Seashore' IS SELECTED...
		gaSigL, gaSigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	else				;OTHERWISE
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gaSigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gaSigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr	2	;REVERB - ALWAYS ON
	kSwitch		changed	gklpt		;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF kSwitch=1 THEN
		reinit	UPDATE		;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;A LABEL
	if gkopcode=0 then
	 ;OUTPUT	OPCODE          | INPUT | REVERB_TIME | LOOP_TIME_(DELAY_TIME)
	 aresL		comb 		gaSigL,     gkrvt,       i(gklpt) 
	 aresR		comb 		gaSigR,     gkrvt,       i(gklpt) 
	else
	 aresL		combinv 	gaSigL,     gkrvt,       i(gklpt) 
	 aresR		combinv 	gaSigR,     gkrvt,       i(gklpt) 
	endif
	rireturn			;RETURN TO PERFORMANCE TIME PASSES
	amixL		ntrpol		gaSigL,aresL,gkdrywet
	amixR		ntrpol		gaSigR,aresR,gkdrywet
			outs	amixL*gkamp, amixR*gkamp	;SEND comb/combinv OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
	clear	gaSigL, gaSigR	;CLEAR GLOBAL AUDIO VARIABLES
endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>