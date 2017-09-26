Schroeder Reverb
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS

;				LABEL              | WIDTH | HEIGHT | X | Y
			FLpanel	"Schroeder Reverb",   500,    520,    0,  0
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    150,     30,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;SLIDERS					            	MIN |  MAX  | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkingain,ihingain	FLslider 	"Live Input Gain",	0,      1,     0,    23,    -1,    140,     20,   350, 5

;BORDERS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 		6,        9,    15,   115,    110,    5,  50
ih		 	FLbox  	"", 		6,        9,    15,   115,    110,  130,  50
ih		 	FLbox  	"", 		6,        9,    15,   115,    110,  255,  50
ih		 	FLbox  	"", 		6,        9,    15,   115,    110,  380,  50
ih		 	FLbox  	"Comb 1", 	1,        2,    16,   105,     15,   10,  60
ih		 	FLbox  	"Comb 2", 	1,        2,    16,   105,     15,  135,  60
ih		 	FLbox  	"Comb 3", 	1,        2,    16,   105,     15,  260,  60
ih		 	FLbox  	"Comb 4", 	1,        2,    16,   105,     15,  385,  60
ih		 	FLbox  	"", 		6,        9,    15,   115,    110,  195, 170
ih		 	FLbox  	"Allpass 1", 	1,        2,    16,   105,     15,  198, 180
ih		 	FLbox  	"", 		6,        9,    15,   115,    110,  195, 290
ih		 	FLbox  	"Allpass 2", 	1,        2,    16,   105,     15,  198, 300
ih		 	FLbox  	"", 		6,        9,    15,   490,     40,    5, 475
ih		 	FLbox  	"Presets:", 	1,        4,    16,    60,     20,   20, 485

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR,  LPT1   LPT2     LPT3    LPT4   RVT1  RVT2  RVT3  RVT4    LPT5      LPT6   RVT5  RVT6  MIX
gkLHall,ihLHall			FLbutton	"Large Hall",	1,    0,    21,     90,     20,  100,485,    0,      3,      0,      0.01, 0.0297, 0.0371, 0.0411, 0.0437,3.5,  3.5,  3.5,  3.5,   0.09683,  0.03292, 2,    2.7,  0.8
gkHall,ihHall			FLbutton	"Med. Hall",	1,    0,    21,     90,     20,  195,485,    0,      3,      0,      0.01, 0.0297, 0.0371, 0.0411, 0.0437,1.5,  1.5,  1.5,  1.5,   0.03297,  0.04233, 0.5,  0.5,  0.85
gkRoom,ihRoom			FLbutton	"Med. Room",	1,    0,    21,     90,     20,  290,485,    0,      3,      0,      0.01, 0.0297, 0.0371, 0.0411, 0.0437, 0.8,  0.8,  0.8,  0.8,  0.01297,  0.01233, 0.1, 0.1, 0.85
gkHall,ihSRoom			FLbutton	"Sm. Room",	1,    0,    21,     90,     20,  385,485,    0,      3,      0,      0.01, 0.0297, 0.0371, 0.0411, 0.0437, 0.3,  0.3,  0.3,  0.3,  0.0029683,0.0023292,0.05,  0.05,  0.9

;TEXT INPUT BOXES			 	MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   |  Y
gklpt1, gihlpt1	FLtext		"Loop Time 1",	0.0001,  0.5, 0.0001,    1,    105,     20,    10,   80
gklpt2, gihlpt2	FLtext		"Loop Time 2",	0.0001,  0.5, 0.0001,    1,    105,     20,   135,   80
gklpt3, gihlpt3	FLtext		"Loop Time 3",	0.0001,  0.5, 0.0001,    1,    105,     20,   260,   80
gklpt4, gihlpt4	FLtext		"Loop Time 4",	0.0001,  0.5, 0.0001,    1,    105,     20,   385,   80
gkrvt1, gihrvt1	FLtext		"Reverb Time 1",0.01,    20,  0.0001,    1,    105,     20,    10,  120
gkrvt2, gihrvt2	FLtext		"Reverb Time 2",0.01,    20,  0.0001,    1,    105,     20,   135,  120
gkrvt3, gihrvt3	FLtext		"Reverb Time 3",0.01,    20,  0.0001,    1,    105,     20,   260,  120
gkrvt4, gihrvt4	FLtext		"Reverb Time 4",0.01,    20,  0.0001,    1,    105,     20,   385,  120
gklpt5, gihlpt5	FLtext		"Loop Time 5",	0.0001,  0.5, 0.0001,    1,    105,     20,   198,  200
gkrvt5, gihrvt5	FLtext		"Reverb Time 5",0.01,    20,  0.0001,    1,    105,     20,   198,  240
gklpt6, gihlpt6	FLtext		"Loop Time 6",	0.0001,  0.5, 0.0001,    1,    105,     20,   198,  320
gkrvt6, gihrvt6	FLtext		"Reverb Time 6",0.01,    20,  0.0001,    1,    105,     20,   198,  360

;SLIDERS	            			MIN | MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X   | Y
gkmix,gihmix	FLslider 	"Wet/Dry Mix",	0,     1,    0,    23,     -1,    490,     25,    5,   420

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

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE  | HANDLE
				FLsetVal_i	0.0297, gihlpt1
				FLsetVal_i	0.0371, gihlpt2
				FLsetVal_i	0.0411, gihlpt3
				FLsetVal_i	0.0437, gihlpt4
				FLsetVal_i	3.5, gihrvt1
				FLsetVal_i	3.5, gihrvt2
				FLsetVal_i	3.5, gihrvt3
				FLsetVal_i	3.5, gihrvt4
				FLsetVal_i	0.09683, gihlpt5
				FLsetVal_i	0.03292, gihlpt6
				FLsetVal_i	2, gihrvt5
				FLsetVal_i	2.7, gihrvt6
				FLsetVal_i	0.8, gihmix

				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 600, 512, 0
				FLscroll     515, 600, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                     Schroeder Reverb                        ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The Schroeder reverb represents a reverb design that was     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"invented in the early 1960s and that has been used often     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"since. Today, with increases in computing power, more        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"elaborate designs have replaced the Schroeder design but it  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"is still used and in fact Csound's freeverb is based on it.  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"In the Schroeder algorithm the input sound is passed through ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"four or more comb filters in parallel and the mix of their   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"outputs in passed through two allpass filters in series. The ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"layout of the controls for the filters in the GUI opposite   ", 	1,      5,     14,    490,    20,     5, 200 
ih		 	FLbox  	"therefore reflects this scheme as the signal passes from top ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"to bottom.                                                   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"The comb filters create the main body of the reverb and the  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"allpass filters serve to 'scatter' ringing artefacts created ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"by the comb filters.                                         ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"The key to minimizing ringing artefacts is chosing           ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"appropriate values of the loop times of the filters. If      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"values are too low ringing will become obvious but if they   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"are too large individual echoes will be heard in a 'grainy'  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"sounding reverb tail. Loop times should all be different and ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"should be prime to prevent periodicity between different     ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"filters which would again result in ringing artefacts.       ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"In this example all controls for each filter are included but", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"obviously in a finished instrument multiple parameters would ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"be combined within a more descriptive global control named   ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"something live reverb time or room size.                     ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"To emulate smaller room reverbs in will be necessary to      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"reduce some of the loop times, particularly those of the     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"allpass filters in order for this to be possible.            ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"This basic Schroeder can be quickly improved upon by         ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"incorporating additional comb filters and perhaps one or two ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"additional allpass filters. Adding too many allpass filters  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"will delay the onset of the reverb tail excessively.         ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"Four preset buttons change reverb time and loop times for all", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"filters and offer suggested starting points for different    ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"reverb effects.                                              ", 	1,      5,     14,    490,    20,     5, 720
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	tables
gisine		ftgen	0, 0, 4096, 10, 1	;SINE WAVE
gaRvbSend	init	0			;GLOBAL AUDIO VARIABLE INITIALIZED TO ZERO
endin

instr	1	;SOUND GENERATING INSTRUMENT
	if gkOnOff=0 then	;IF ON/OFF SWITCH IS OFF...
		turnoff		;TURN THIS INSTRUMENT OFF
	endif			;END OF THIS CONDITIONAL BRANCH
;	gaRvbSend	diskin2	"808loopMono.wav", 1, 0, 1	;READ IN STEREO SOUND FILE WITH LOOPING ON

	if	gkinput==0	then	;IF INPUT 'Drum Loop' IS SELECTED...
		gaRvbSend	diskin2	"808loopMono.wav",    1,       0,         1	;GENERATE 1 AUDIO SIGNALS FROM A MONO SOUND FILE (NOTE THE USE OF A GLOBAL VARIABLE)
	else				;OTHERWISE
		gaRvbSend	inch	1	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gaRvbSend	=	gaRvbSend * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr	2	;REVERB - ALWAYS ON
	ktrigger	changed	gklpt1, gklpt2, gklpt3, gklpt4, gklpt5, gklpt6	;IF ANY OF THE INPUT ARGUMENTS CHANGES GENERATE A MOMENTARY '1' VALUE (BAND)
	if ktrigger=1 then			;IF QUERY IS TRUE...
		reinit	UPDATE			;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE' IN ORDER TO FORCE AN UPDATE OF I-RATE CONTROLLERS
	endif					;END OF THIS CONDITIONAL BRANCH
	UPDATE:					;LABEL CALLED 'UPDATE'
	ilpt1	limit	i(gklpt1), 0.0001, 0.5	;LIMIT LOOP TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	ilpt2	limit	i(gklpt2), 0.0001, 0.5	;LIMIT LOOP TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	ilpt3	limit	i(gklpt3), 0.0001, 0.5	;LIMIT LOOP TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	ilpt4	limit	i(gklpt4), 0.0001, 0.5	;LIMIT LOOP TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	ilpt5	limit	i(gklpt5), 0.0001, 0.5	;LIMIT LOOP TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	ilpt6	limit	i(gklpt6), 0.0001, 0.5	;LIMIT LOOP TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	krvt1	limit	gkrvt1, 0.01, 20	;LIMIT REVERB TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	krvt2	limit	gkrvt2, 0.01, 20	;LIMIT REVERB TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	krvt3	limit	gkrvt3, 0.01, 20	;LIMIT REVERB TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	krvt4	limit	gkrvt4, 0.01, 20	;LIMIT REVERB TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	krvt5	limit	gkrvt5, 0.01, 20	;LIMIT REVERB TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	krvt6	limit	gkrvt6, 0.01, 20	;LIMIT REVERB TIME PARAMETER - ESSENTIALLY TO PREVENT VALUES OF ZERO BEING GIVEN TO THE OPCODE WHICH WOULD BE BAD
	a1	comb	gaRvbSend, krvt1, ilpt1	;COMB FILTER 1
	a2	comb	gaRvbSend, krvt2, ilpt2	;COMB FILTER 2
	a3	comb	gaRvbSend, krvt3, ilpt3	;COMB FILTER 3
	a4	comb	gaRvbSend, krvt4, ilpt4	;COMB FILTER 4
	aSum	sum	a1,a2,a3,a4		;MIX THE OUTPUT FROM THE FOUR COMB FILTERS
	a5	alpass aSum, krvt5, ilpt5	;SEND THE MIXED OUTPUT INTO THE FIRST ALLPASS FILTER
	aRvb	alpass a5, krvt6,   ilpt6	;SEND THE OUTPUT OF THE FIRST ALLPASS FILTER INTO THE SECOND ALLPASS FILTER
	rireturn				;RETURN FROM REINITIALIZATION PASS (IF APPLICABLE)
	amix	ntrpol	aRvb, gaRvbSend, gkmix	;CREATE A MIX BETWEEN THE WET AND DRY SIGNALS. CONTROLLABLE BY THE USER FROM AN ON SCREEN SLIDER
		outs	amix*0.7, amix*0.7	;SEND WET/DRY MIX AUDIO TO OUTPUTS
	clear	gaRvbSend			;CLEAR GLOBAL AUDIO VARIABLES
endin

instr	3	;ACTIVATE PRESETS
	;UPDATE FLTK VALUATORS WITH VALUES RECEIVED VIA P-FIELDS
	FLsetVal_i	p4, gihlpt1
	FLsetVal_i	p5, gihlpt2
	FLsetVal_i	p6, gihlpt3
	FLsetVal_i	p7, gihlpt4
	FLsetVal_i	p8, gihrvt1
	FLsetVal_i	p9, gihrvt2
	FLsetVal_i	p10, gihrvt3
	FLsetVal_i	p11, gihrvt4
	FLsetVal_i	p12, gihlpt5
	FLsetVal_i	p13, gihlpt6
	FLsetVal_i	p14, gihrvt5
	FLsetVal_i	p15, gihrvt6
	FLsetVal_i	p16, gihmix
endin

</CsInstruments>

<CsScore>
i "tables" 0 3600
i 2 0.01 3600	;REVERB INSTRUMENT
e
</CsScore>

</CsoundSynthesizer>