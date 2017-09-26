risset_rhythms.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;					LABEL            | WIDTH | HEIGHT | X | Y
				FLpanel	"Risset Rhythms",   500,    490,    0,  0
;BUTTONS							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    2,     150,     28,    5,  5,    0,      3,      0,       -1

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    230,   150,    10, 150	;BORDER AROUND SOURCE
ih		 	FLbox  	" ", 	6,        9,    15,    230,   280,   260, 150	;BORDER AROUND LAYERS MIXER
ih		 	FLbox  	" ", 	6,        9,    15,    230,   110,    10, 320	;BORDER AROUND AMPLITUDE WINDOWS

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idrate				FLvalue	" ",       70,    16,    10,  75

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"SOURCE", 		1,       6,    14,     95,     20,   20,  155
ih		 	FLbox  	"LAYERS MIXER", 	1,       6,    14,    210,     20,  270,  155
ih		 	FLbox  	"AMPLITUDE WINDOWS", 	1,       6,    14,    210,     20,   20,  325

;SLIDERS						MIN | MAX | EXP | TYPE |    DISP | WIDTH | HEIGHT | X |  Y
gkrate, ihrate		FLslider 	"Rate (Hz.)",	-.1,   .1,   0,    3,     idrate,  480,     20,     10,  50
gkGSpeed, ihGSpeed	FLslider 	"Global Speed",	.25,    4,  -1,    3,         -1,  480,     20,     10, 100
gk1, gih1		FLslider 	"1",		0,      1,   0,    3,         -1,  200,     20,    280, 215
gk2, gih2		FLslider 	"2",		0,      1,   0,    3,         -1,  200,     20,    280, 235
gk3, gih3		FLslider 	"3",		0,      1,   0,    3,         -1,  200,     20,    280, 255
gk4, gih4		FLslider 	"4",		0,      1,   0,    3,         -1,  200,     20,    280, 275
gk5, gih5		FLslider 	"5",		0,      1,   0,    3,         -1,  200,     20,    280, 295
gk6, gih6		FLslider 	"6",		0,      1,   0,    3,         -1,  200,     20,    280, 315
gk7, gih7		FLslider 	"7",		0,      1,   0,    3,         -1,  200,     20,    280, 335
gk8, gih8		FLslider 	"8",		0,      1,   0,    3,         -1,  200,     20,    280, 355
gkamp1, gihamp1		FLslider 	"1",		0,      1,   0,    2,         -1,  25,      35,    280, 375
gkamp2, gihamp2		FLslider 	"2",		0,      1,   0,    2,         -1,  25,      35,    305, 375
gkamp3, gihamp3		FLslider 	"3",		0,      1,   0,    2,         -1,  25,      35,    330, 375
gkamp4, gihamp4		FLslider 	"4",		0,      1,   0,    2,         -1,  25,      35,    355, 375
gkamp5, gihamp5		FLslider 	"5",		0,      1,   0,    2,         -1,  25,      35,    380, 375
gkamp6, gihamp6		FLslider 	"6",		0,      1,   0,    2,         -1,  25,      35,    405, 375
gkamp7, gihamp7		FLslider 	"7",		0,      1,   0,    2,         -1,  25,      35,    430, 375
gkamp8, gihamp8		FLslider 	"8",		0,      1,   0,    2,         -1,  25,      35,    455, 375
gkOutGain, ihOutGain	FLslider 	"Output Gain",	0,      1,   0,    3,         -1,  480,     20,     10, 440

FLsetAlign	4, gih1	;
FLsetAlign	4, gih2	;
FLsetAlign	4, gih3	;
FLsetAlign	4, gih4	;
FLsetAlign	4, gih5	;
FLsetAlign	4, gih6	;
FLsetAlign	4, gih7	;
FLsetAlign	4, gih8	;

;            R    G   B
FLsetColor2 190, 190,190, gihamp1
FLsetColor2 190, 190,190, gihamp2
FLsetColor2 190, 190,190, gihamp3
FLsetColor2 190, 190,190, gihamp4
FLsetColor2 190, 190,190, gihamp5
FLsetColor2 190, 190,190, gihamp6
FLsetColor2 190, 190,190, gihamp7
FLsetColor2 190, 190,190, gihamp8
FLsetColor    0,   0,  0, gihamp1
FLsetColor    0,   0,  0, gihamp2
FLsetColor    0,   0,  0, gihamp3
FLsetColor    0,   0,  0, gihamp4
FLsetColor    0,   0,  0, gihamp5
FLsetColor    0,   0,  0, gihamp6
FLsetColor    0,   0,  0, gihamp7
FLsetColor    0,   0,  0, gihamp8

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gklayers, ihlayers		FLcount  "No. of Layers", 	2,     8,     1,      1,      2,    100,     20,   325,175,   0,      1,       0,     .1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    190,   190,   190		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfile, ihfile			FLbutBank	14,     1,     4,     18,      80,    20, 180,   -1
gkAmpWindow, ihAmpWindow	FLbutBank	14,     1,     3,     18,      60,    20, 350,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Loop 1", 		1,       5,    14,     60,      20,   40, 180
ih		 	FLbox  	"Loop 2", 		1,       5,    14,     60,      20,   40, 200
ih		 	FLbox  	"Loop 3", 		1,       5,    14,     60,      20,   40, 220
ih		 	FLbox  	"Loop 4", 		1,       5,    14,     60,      20,   40, 240
ih		 	FLbox  	"Half-sine          ", 	1,       5,    14,    170,      20,   40, 350
ih		 	FLbox  	"Bartlett (triangle)", 	1,       5,    14,    170,      20,   40, 370
ih		 	FLbox  	"Blackman-Harris    ", 	1,       5,    14,    170,      20,   40, 390

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	0.003, 	ihrate
				FLsetVal_i	1, 	gih1
				FLsetVal_i	1, 	gih2
				FLsetVal_i	1, 	gih3
				FLsetVal_i	1, 	gih4
				FLsetVal_i	1, 	gih5
				FLsetVal_i	1, 	gih6
				FLsetVal_i	1, 	gih7
				FLsetVal_i	1, 	gih8
				FLsetVal_i	8, 	ihlayers
				FLsetVal_i	1, 	ihGSpeed
				FLsetVal_i	2, 	ihfile
				FLsetVal_i	2, 	ihAmpWindow
				FLsetVal_i	0.3, 	ihOutGain

				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 700, 512, 0
				FLscroll     512, 700, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                     risset rhythms                          ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Risset rhythms is a variation of the Shepard-Risset Glissando", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"which employs a rhythmic loop instead of a sine tone.        ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"This implementation uses speed control of sampled loops to   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"vary tempo, therefore pitch as well as tempo is modulated.   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"A repeating loop fades in as it gradually increases in tempo ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"(and pitch). By the time it has doubled its tempo (and risen ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"in pitch by an octave) a second layer of this loop is faded  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"in at the same initial tempo of the original layer. It then  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"follows the trajectory of the first layer, always half its   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"tempo (and an octave lower). As the layers get faster and    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"faster, they eventually fade out, just as they faded in. As  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"many layers can be used as desired but the greater the number", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"of layers, the greater the range of tempi (& pitch) covered. ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"The effect of this should be a cognative contradiction in    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"which, from moment to moment, the music appears to be getting", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"faster, but over the longer term doesn't get faster.         ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"A frequently cited visual analog is that of the spinning     ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"barber's pole in which parallel lines appear to be rising but", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"obviously aren't.                                            ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"In this implementation 'Rate' controls the rate of           ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"acceleration of the loops. One period will be the time it    ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"take for a loop to begin fading in at its lowest tempo, to   ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"when it finally fades our at its highest tempo. Negative     ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"values here will result in loops slowing down (getting lower ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"in pitch). The greater the number of layers employed the     ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"greater the rate of acceleration will appear as each loop    ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"will cover a greater range of tempi from fading in to fading ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"out. Careful tuning of the 'Number of Layers' and 'Rate' is  ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"needed to properly create the illusion. Setting rate too high", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"will reveal the workings of the illusion.                    ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"The amplitudes of each of the layers are adjustable using the", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"numbered sliders. These are normally all left at maximum but ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"listening to one layer on its own can help in understanding  ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"the mechanism of this example. The yellow bars indicate how  ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"the different layers fade in and out.                        ", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"A choice of amplitude window functions are available. These  ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"determine exactly how each layer fades in and out.           ", 	1,      5,     14,    490,    15,     5, 780
ih		 	FLbox  	"A choice of four source loops are provided (including a sine ", 	1,      5,     14,    490,    15,     5, 800
ih		 	FLbox  	"tone which allows creation of the Shepard-Risset Glissando). ", 	1,      5,     14,    490,    15,     5, 820
ih		 	FLbox  	"'Global Speed' scales the speed of all layers equally.       ", 	1,      5,     14,    490,    15,     5, 840
                                                                                                                                                  
				FLscroll_end                
				FLpanel_end                                                                                       

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giloop1		ftgen	0, 0, 524289, 1, "808loopMono.wav", 0, 0, 0
giloop2		ftgen	0, 0, 262144, 1, "loop.wav", 0, 0, 0
giloop3		ftgen	0, 0, 131073, 1, "MFEM.wav", 0, 0, 0
giloop4		ftgen	0, 0, 131073, 9, 1200, 1, 0

giAmpWindow1	ftgen	11, 0, 131073, 9, 0.5, 1, 0	;HALF SINE
giAmpWindow2	ftgen	12, 0, 131073, 20, 3, 1		;BARTLETT (TRIANGLE)
giAmpWindow3	ftgen	13, 0, 131073, 20,  5, 1	;BLACKMAN-HARRIS

instr	1	;HIDE OR REVEAL LAYER WIDGETS
	ilayers	init	i(gklayers)
	
	;A LOOP IS USED TO REPEAT AN I-RATE CODE BLOCK
	icount	=	3			;LOOP COUNTER
	loopbegin:				;LOOP BEGINNING (LABEL)
	if ilayers<icount then			;IF THIS LAYER SHOULD BE HIDDEN...
		FLhide	gih1+icount-1		;HIDE ENVELOPE STATUS DISPLAY
		FLhide	gihamp1+icount-1	;HIDE AMPLITUDE SLIDER
	else					;OTHERWISE...
		FLshow	gih1+icount-1		;SHOW ENVELOPE STATUS DISPLAY
		FLshow	gihamp1+icount-1	;SHOW AMPLITUDE SLIDER 
	endif					;END OF CONDITIONAL BRANCHING
		loop_le	icount,1,8,loopbegin	;CONDITIONALLY LOOP BACK TO LABEL 'loopbegin'
endin

instr	2	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
	kSwitch	changed		gkfile, gkAmpWindow, gklayers	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	;			ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,        0,        3,        0,    -1	;RESTART INSTRUMENT 3 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
endin

instr	3
	if	gkOnOff=0	then			;SENSE FLTK ON/OFF SWITCH - IF 'OFF' IS SELECTED...
		turnoff					;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif						;END OF THIS CONDITIONAL BRANCH
	kSwitch	changed		gkfile, gkAmpWindow, gklayers	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch=1 then					;IF ANY OF THE SCANNED I-RATE CONTROLS CHANGE...
		reinit	UPDATE					;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif							;END OF THIS CONDITIONAL BRANCH
	UPDATE:							;LABEL 'UPDATE'
	ifn		=	giloop1+i(gkfile)	;FUNCTION TABLE
	ilen		=	nsamp(ifn)		;LENGTH OF THE SOUND FILE
	if i(gkfile)=3 then				;IF SINE WAVE HAS BEEN CHOSEN...
	  ilen	=	ftlen(ifn)			;USE ftlen() INSTEAD OF nsamp()
	endif						;END OF CONDITIONAL BRANCH
	iAmpWindow	=	i(gkAmpWindow)+11	;CHOSEN WINDOW
	kSpeedRatio	=	sr*gkGSpeed/ilen	;PLAYBACK SPEED RATIO BASED ON FILE LENGTH AND 'GLOBAL SPEED' SLIDER
	ilayers		=	i(gklayers)		;NUMBER OF LAYERS CHOSEN
	rireturn					;RETURN FROM REINITIALISATION PASS
	
	kupdate		metro	20			;RATE OF UPDATE
	
	aout		init	0			;ACCUMULATING AUDIO VARIABLE INITIALISED

	;CREATE FIRST LAYER
	kspeed1	phasor	gkrate				;PHASOR THAT TRACES AMPLITUDE ENVELOPE
	kenv1	tablei	kspeed1, iAmpWindow, 1		;AMPLITUDE ENVELOPE
	FLsetVal	kupdate, 1-kenv1, gihamp1	;UPDATE ENVELOPE INDICATOR BAR
	kratio1	=		octave((kspeed1*ilayers)-(ilayers*.5))	;MOVING PLAYBACK RATIO
	aptr1	phasor	kratio1*kSpeedRatio		;PHASOR THAT TRACES MOVEMENT THROUGH THE SOUND FILE
	asig1	tablei	aptr1*ilen, ifn			;READ AUDIO FROM TABLE
	aout	=	aout + (asig1*kenv1*gk1)	;ADD AUDIO TO ACCUMULATING AUDIO VARIABLE

;MACRO DEFINED FOR ALL SUBSEQUENT LAYERS
#define	LAYER(N)
	#
	kspeed$N	phasor	gkrate, ($N-1)/ilayers				;PHASOR THAT TRACES AMPLITUDE ENVELOPE
	kenv$N	tablei	kspeed$N, iAmpWindow, 1                                 ;AMPLITUDE ENVELOPE                   
	FLsetVal	kupdate, 1-kenv$N, gihamp$N                             ;UPDATE ENVELOPE INDICATOR BAR        
	kratio$N	=	octave((kspeed$N*ilayers)-(ilayers*.5))		;MOVING PLAYBACK RATIO
	aptr$N		phasor	kratio$N*kSpeedRatio				;PHASOR THAT TRACES MOVEMENT THROUGH THE SOUND FILE
	asig$N		tablei	aptr$N*ilen, ifn		                ;READ AUDIO FROM TABLE                             
	aout	=	aout + (asig$N*kenv$N*gk$N)                             ;ADD AUDIO TO ACCUMULATING AUDIO VARIABLE          
	if	gklayers==$N	goto	FINISH					;IF THIS IS THE FINAL LAYER JUMP TO 'FINISH' LABEL
	#
	;EXECUTE MACRO MULTIPLE TIMES
	$LAYER(2)
	$LAYER(3)
	$LAYER(4)
	$LAYER(5)
	$LAYER(6)
	$LAYER(7)
	$LAYER(8)

	FINISH:									;'FINISH' LABEL
	outs	aout*gkOutGain, aout*gkOutGain					;SEND AUDIO TO OUTPUTS
	clear	aout								;CLEAR ACCUMULATING AUDIO VARIABLE
endin                                    

</CsInstruments>                         
                                         
<CsScore>                                
;INSTR | START | DURATION                
i  2       0       3600	;INSTRUMENT 2 (SCANS FOR I-RATE CHANGES) PLAYS FOR 1 HOUR AND KEEPS REALTIME PERFORMANCE GOING
</CsScore>                               
                                         
</CsoundSynthesizer>                     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         














