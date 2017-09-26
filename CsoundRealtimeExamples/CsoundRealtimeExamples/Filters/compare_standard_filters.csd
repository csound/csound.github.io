compare_standard_filters.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -iadc -dm0
</CsOptions>                                                                                             

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					 LABEL                     | WIDTH | HEIGHT | X | Y
				FLpanel	"compare standard filters",   620,    770,    0,  0
 
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    140,     25,   125, 5,    0,      1,      0,      -1
gkBalance,ihBalance	FLbutton	"Balance On/Off",	1,    0,    22,    140,     25,   475, 5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihBalance		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",       60,     20,  125, 275
gidbw				FLvalue	" ",       60,     20,  125, 325
gidres				FLvalue	" ",       60,     20,  125, 425
giddist				FLvalue	" ",       60,     20,  375, 425
idamp				FLvalue	" ",       60,     20,  125, 625
gidpbr				FLvalue	" ",       35,     20,  125, 525
gidsba				FLvalue	" ",       35,     20,  375, 525
gidasym				FLvalue	" ",       35,     20,  125, 575

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gkscl, gihscl 			FLcount  "Scaling Mode", 	0,     2,     1,      1,      2,    120,     25,   140,  350,   -1 ;0, 2,0,0
gkskip, gihskip			FLcount  "Init. 0=On 1=Off", 	0,     1,     1,      1,      2,    120,     25,   310,  350,   -1
gknumlayer, gihnumlayer		FLcount  "Number of Layers", 	1,   500,     1,     50,      1,    120,     25,   470,  350,   -1
gknpol, gihnpol			FLcount  "Num. Poles", 		2,    80,     1,     10,      1,    120,     25,   120,  450,   -1
gkkind, gihkind			FLcount  "Filter Design", 	0,     3,     1,      1,      2,    120,     25,   245,  450,   -1
gkscl2, gihscl2			FLcount  "Scaling", 		0,     1,     1,      1,      2,    120,     25,   370,  450,   -1

;TEXT BOXES						ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
gihsclmode		 	FLbox  	"None", 	1,       1,    12,    160,    20,    120, 399
                                                                                                     
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y                 
ih		 	FLbox  	"", 			3,       5,    14,    496,   185,  122,  40	;PANEL AROUND INPUT
ih		 	FLbox  	"INPUT", 		1,       4,    16,    490,    20,  125,  50	;

;SLIDERS					            			MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkcf,ihcf			FLslider 	"Filter Centre Frequency",	20,  20000, -1,    23,   idcf,      490,      25, 125,   250
gkbw,gihbw			FLslider 	"Bandwidth",			0.1, 10000, -1,    23,   gidbw,     490,      25, 125,   300
gkres,gihres			FLslider 	"Resonance",			0,       1,  0,    23,   -1,        240,      25, 125,   400
gkdist,gihdist			FLslider 	"Distortion",			0,       1,  0,    23,   -1,        240,      25, 375,   400
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       8,  0,    23,   idamp,     490,      25, 125,   600
gkPinkAmp,ihPinkAmp		FLslider 	"AMPLITUDE:",			0,       1,  0,    23,   -1,        100,      20, 320,    84
gkSawAmp,ihSawAmp		FLslider 	"AMPLITUDE:",			0,       1,  0,    23,   -1,        100,      20, 320,   109 
gkSawFrq,ihSawFrq		FLslider 	"FREQUENCY:",			1,    2000, -1,    23,   -1,        100,      20, 505,   109
gkSqAmp,ihSqAmp			FLslider 	"AMPLITUDE:",			0,       1,  0,    23,   -1,        100,      20, 320,   134 
gkSqFrq,ihSqFrq			FLslider 	"FREQUENCY:",			1,    2000, -1,    23,   -1,        100,      20, 505,   134
gkLiveGain,ihLiveGain		FLslider 	"GAIN:",			0,       1,  0,    23,   -1,        100,      20, 320,   159
gkpbr, gihpbr			FLslider 	"Pass Band Ripple",		0.1,    50,  0,    23,   gidpbr,    240,      25, 125,   500
gksba, gihsba			FLslider 	"Stop Band Attenuation",	-120,   -1,  0,    23,   gidsba,    240,      25, 375,   500
gkasym, gihasym			FLslider 	"Assymmetry",			0,     0.5,  0,    23,   gidasym,   240,      25, 125,   550

FLsetTextSize	10,ihPinkAmp
FLsetTextSize	10,ihSawAmp
FLsetTextSize	10,ihSawFrq
FLsetTextSize	10,ihSqAmp
FLsetTextSize	10,ihSqFrq
FLsetTextSize	10,ihLiveGain
FLsetAlign	4,ihPinkAmp                                                                               
FLsetAlign	4,ihSawAmp
FLsetAlign	4,ihSawFrq
FLsetAlign	4,ihSqAmp
FLsetAlign	4,ihSqFrq
FLsetAlign	4,ihLiveGain

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
FLcolor	255, 255, 255, 255, 255, 50                                                                                             
;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  |  Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	1,      1,     6,     18,     25*6,  140,  55,   -1
                                                                                                            
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE       
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Seashore  ", 		1,       5,    14,     80,     25,  170,  55
ih		 	FLbox  	"Pink Noise", 		1,       5,    14,     80,     25,  170,  80
ih		 	FLbox  	"Sawtooth  ", 		1,       5,    14,     80,     25,  170, 105
ih		 	FLbox  	"Square    ", 		1,       5,    14,     80,     25,  170, 130
ih		 	FLbox  	"Live      ", 		1,       5,    14,     80,     25,  170, 155
ih		 	FLbox  	"Drum Loop ", 		1,       5,    14,     80,     25,  170, 180

FLcolor	255, 255, 255, 255, 255, 55	;SET COLOUR SCHEME
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gktype, ihtype		FLbutBank	1,      1,     38,     20,    20*38,  5,  5,     -1;0,      2,   0,   0
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE                   
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT |  X  | Y                  
ih		 	FLbox  	"butlp       ", 	1,       5,    11,     65,     20,    35,   5
ih		 	FLbox  	"buthp       ", 	1,       5,    11,     65,     20,    35,  25
ih		 	FLbox  	"butbp       ", 	1,       5,    11,     65,     20,    35,  45  
ih		 	FLbox  	"butbr       ", 	1,       5,    11,     65,     20,    35,  65
ih		 	FLbox  	"tone        ", 	1,       5,    11,     65,     20,    35,  85         
ih		 	FLbox  	"tonex       ", 	1,       5,    11,     65,     20,    35, 105         
ih		 	FLbox  	"atone       ", 	1,       5,    11,     65,     20,    35, 125
ih		 	FLbox  	"atonex      ", 	1,       5,    11,     65,     20,    35, 145
ih		 	FLbox  	"reson       ", 	1,       5,    11,     65,     20,    35, 165
ih		 	FLbox  	"resonr      ", 	1,       5,    11,     65,     20,    35, 185
ih		 	FLbox  	"resonz      ", 	1,       5,    11,     65,     20,    35, 205
ih		 	FLbox  	"areson      ", 	1,       5,    11,     65,     20,    35, 225
ih		 	FLbox  	"moogvcf2    ", 	1,       5,    11,     65,     20,    35, 245
ih		 	FLbox  	"moogladder  ", 	1,       5,    11,     65,     20,    35, 265
ih		 	FLbox  	"lpf18       ", 	1,       5,    11,     65,     20,    35, 285
ih		 	FLbox  	"bqrez(lp)   ", 	1,       5,    11,     65,     20,    35, 305
ih		 	FLbox  	"bqrez(hp)   ", 	1,       5,    11,     65,     20,    35, 325
ih		 	FLbox  	"bqrez(bp)   ", 	1,       5,    11,     65,     20,    35, 345
ih		 	FLbox  	"bqrez(br)   ", 	1,       5,    11,     65,     20,    35, 365
ih		 	FLbox  	"clfilt(lp)  ", 	1,       5,    11,     65,     20,    35, 385
ih		 	FLbox  	"clfilt(hp)  ", 	1,       5,    11,     65,     20,    35, 405
ih		 	FLbox  	"lowpass2    ", 	1,       5,    11,     65,     20,    35, 425
ih		 	FLbox  	"lowres      ", 	1,       5,    11,     65,     20,    35, 445
ih		 	FLbox  	"lowresx     ", 	1,       5,    11,     65,     20,    35, 465
ih		 	FLbox  	"rezzy(lp)   ", 	1,       5,    11,     65,     20,    35, 485
ih		 	FLbox  	"rezzy(hp)   ", 	1,       5,    11,     65,     20,    35, 505
ih		 	FLbox  	"statevar(lp)", 	1,       5,    11,     65,     20,    35, 525
ih		 	FLbox  	"statevar(hp)", 	1,       5,    11,     65,     20,    35, 545
ih		 	FLbox  	"statevar(bp)", 	1,       5,    11,     65,     20,    35, 565
ih		 	FLbox  	"statevar(br)", 	1,       5,    11,     65,     20,    35, 585
ih		 	FLbox  	"svfilter(lp)", 	1,       5,    11,     65,     20,    35, 605
ih		 	FLbox  	"svfilter(hp)", 	1,       5,    11,     65,     20,    35, 625
ih		 	FLbox  	"svfilter(bp)", 	1,       5,    11,     65,     20,    35, 645
ih		 	FLbox  	"tbvcf       ", 	1,       5,    11,     65,     20,    35, 665
ih		 	FLbox  	"rbjeq(lp)   ", 	1,       5,    11,     65,     20,    35, 685
ih		 	FLbox  	"rbjeq(hp)   ", 	1,       5,    11,     65,     20,    35, 705
ih		 	FLbox  	"rbjeq(bp)   ", 	1,       5,    11,     65,     20,    35, 725
ih		 	FLbox  	"rbjeq(br)   ", 	1,       5,    11,     65,     20,    35, 745


;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	1000, 	ihcf
				FLsetVal_i	1000, 	gihbw                            
				FLsetVal_i	1, 	gihscl
				FLsetVal_i	0, 	gihres
				FLsetVal_i	0, 	gihdist
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	0.6, 	ihPinkAmp
				FLsetVal_i	0.4, 	ihSawAmp
				FLsetVal_i	100, 	ihSawFrq
				FLsetVal_i	0.4, 	ihSqAmp
				FLsetVal_i	100, 	ihSqFrq
				FLsetVal_i	0.5, 	ihLiveGain
				FLsetVal_i	2, 	gihnumlayer
				FLsetVal_i	2, 	gihnpol
				FLsetVal_i	1, 	gihpbr
				FLsetVal_i	-60, 	gihsba
				FLsetVal_i	0.5, 	gihasym
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 400, 520, 622, 0
;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          compare standard filters              ", 	1,      5,     14,    390,    20,     5,  0
ih		 	FLbox  	"------------------------------------------------", 	1,      5,     14,    390,    20,     5,  20
ih		 	FLbox  	"This example allows the user to compare the     ", 	1,      5,     14,    390,    20,     5,  40
ih		 	FLbox  	"characteristics of many of Csound's standard    ", 	1,      5,     14,    390,    20,     5,  60
ih		 	FLbox  	"filters using a variety of input sounds.        ", 	1,      5,     14,    390,    20,     5,  80
ih		 	FLbox  	"The different opcodes (or modes thereof) are    ", 	1,      5,     14,    390,    20,     5, 100
ih		 	FLbox  	"selected using the bank of buttons on the left  ", 	1,      5,     14,    390,    20,     5, 120
ih		 	FLbox  	"of the GUI.                                     ", 	1,      5,     14,    390,    20,     5, 140
ih		 	FLbox  	"Input parameters specific to individual opcodes ", 	1,      5,     14,    390,    20,     5, 160
ih		 	FLbox  	"have their GUI valuators hidden when that opcode", 	1,      5,     14,    390,    20,     5, 180
ih		 	FLbox  	"is not selected. 'Cutoff Frequency' is common   ", 	1,      5,     14,    390,    20,     5, 200
ih		 	FLbox  	"to all the filter opcodes included so is        ", 	1,      5,     14,    390,    20,     5, 220
ih		 	FLbox  	"therefore always visible.                       ", 	1,      5,     14,    390,    20,     5, 240
ih		 	FLbox  	"The 'Balance On/Off' activates the use of the   ", 	1,      5,     14,    390,    20,     5, 260
ih		 	FLbox  	"balance opcode to balance the amplitude of the  ", 	1,      5,     14,    390,    20,     5, 280
ih		 	FLbox  	"input sound with the amplitude of the filtered  ", 	1,      5,     14,    390,    20,     5, 300
ih		 	FLbox  	"output. This can be useful when using opcodes   ", 	1,      5,     14,    390,    20,     5, 320
ih		 	FLbox  	"that can cause an increase in gain.             ", 	1,      5,     14,    390,    20,     5, 340
ih		 	FLbox  	"Some of Csound's filter opcodes can be a little ", 	1,      5,     14,    390,    20,     5, 360
ih		 	FLbox  	"unstable (such as tbvcf and statevar) so care   ", 	1,      5,     14,    390,    20,     5, 380
ih		 	FLbox  	"should be taken when using these in case of very", 	1,      5,     14,    390,    20,     5, 400
ih		 	FLbox  	"loud unpleasant noises if they 'blow up'.       ", 	1,      5,     14,    390,    20,     5, 420
ih		 	FLbox  	"Protect your ears and your speakers!            ", 	1,      5,     14,    390,    20,     5, 440
ih		 	FLbox  	"For further consideration of the filter opcodes ", 	1,      5,     14,    390,    20,     5, 460
ih		 	FLbox  	"considered here please consult their individual ", 	1,      5,     14,    390,    20,     5, 480
ih		 	FLbox  	"examples (or the Csound Manual).                ", 	1,      5,     14,    390,    20,     5, 500

				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1
	if	gkOnOff==0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
	  turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kcf	portk	gkcf, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	kbw	portk	gkbw, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
                                                                  
	if gkinput==0 then
	  asigL, asigR	diskin2	"Seashore.wav", 1, 0, 1		;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE
	elseif gkinput==1 then
	  kPinkAmp	portk	gkPinkAmp,kporttime
	  asigL	pinkish	kPinkAmp
	  asigR	=	asigL
	elseif gkinput==2 then
	  kVCOAmp	portk	gkSawAmp,kporttime
	  kVCOFrq	portk	gkSawFrq,kporttime
	  asigL	vco2	kVCOAmp, kVCOFrq
	  asigR	=	asigL
	elseif gkinput==3 then
	  kVCOAmp	portk	gkSqAmp,kporttime
	  kVCOFrq	portk	gkSqFrq,kporttime
	  asigL	vco2	kVCOAmp, kVCOFrq, 2, 0.5
	  asigR	=	asigL
	elseif gkinput==4 then
	  asigL,asigR	ins
	else
	  asigL		diskin2	"loop.wav",1,0,1
	  asigR		=	asigL
	endif

	kSwitch		changed	gkscl, gkskip,gknumlayer,gknpol,gkpbr,gksba,gkkind,gkscl	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch==1 then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
	  reinit	START		;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	
	if gktype==0 then					;butlp
	  aresL 	butlp 	asigL, kcf, i(gkskip)		;FILTER EACH CHANNEL SEPARATELY
	  aresR 	butlp 	asigR, kcf, i(gkskip)		;FILTER EACH CHANNEL SEPARATELY
	elseif gktype==1 then					;buthp
	  aresL 	buthp 	asigL, kcf, i(gkskip)
	  aresR 	buthp 	asigR, kcf, i(gkskip)
	elseif gktype==2 then					;butbp
	  aresL 	butbp 	asigL, kcf, kbw, i(gkskip)
	  aresR 	butbp 	asigR, kcf, kbw, i(gkskip)
	elseif gktype==3 then					;butbr
	  aresL 	butbr 	asigL, kcf, kbw, i(gkskip)
	  aresR 	butbr 	asigR, kcf, kbw, i(gkskip)
	elseif gktype==4 then					;tone
	  aresL 	tone 	asigL, kcf, i(gkskip)
	  aresR 	tone 	asigR, kcf, i(gkskip)
	elseif gktype==5 then					;tonex
	  aresL 	tonex 	asigL, kcf, i(gknumlayer), i(gkskip)
	  aresR 	tonex 	asigR, kcf, i(gknumlayer), i(gkskip)
	elseif gktype==6 then					;atone
	  aresL 	atone 	asigL, kcf, i(gkskip)
	  aresR 	atone 	asigR, kcf, i(gkskip)
	elseif gktype==7 then					;atonex
	  aresL 	atonex 	asigL, kcf, i(gknumlayer), i(gkskip)
	  aresR 	atonex 	asigR, kcf, i(gknumlayer), i(gkskip)
	elseif gktype==8 then					;reson
	  aresL 	reson 	asigL, kcf, kbw, i(gkscl), i(gkskip)
	  aresR 	reson 	asigR, kcf, kbw, i(gkscl), i(gkskip)
	elseif gktype==9 then					;resonr
	  aresL 	resonr 	asigL, kcf, kbw, i(gkscl), i(gkskip)
	  aresR 	resonr 	asigR, kcf, kbw, i(gkscl), i(gkskip)
	elseif gktype==10 then					;resonz
	  aresL 	resonz 	asigL, kcf, kbw, i(gkscl), i(gkskip)
	  aresR 	resonz 	asigR, kcf, kbw, i(gkscl), i(gkskip)
	elseif gktype==11 then					;areson
	  aresL 	areson 	asigL, kcf, kbw, i(gkscl), i(gkskip)
	  aresR 	areson 	asigR, kcf, kbw, i(gkscl), i(gkskip)
	elseif gktype==12 then					;moogvcf2
	  kres		=		gkres
	  		FLprintk2	kres, gidres
	  aresL 	moogvcf2 	asigL, kcf, kres
	  aresR 	moogvcf2 	asigR, kcf, kres
	elseif gktype==13 then					;moogladder
	  kres		=		gkres
	  		FLprintk2	kres, gidres
	  aresL 	moogladder 	asigL, kcf, kres
	  aresR 	moogladder	asigR, kcf, kres
	elseif gktype==14 then					;lpf18
	  kdist		=		gkdist*11
	  		FLprintk2	kdist,giddist
	  kres		=		gkres
	  		FLprintk2	kres, gidres
	  aresL 	lpf18 		asigL, kcf, gkres, kdist
	  aresR 	lpf18		asigR, kcf, gkres, kdist
	elseif gktype==15 then					;bqrez(lp)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  aresL 	bqrez 		asigL, kcf, kres, 0, i(gkskip)
	  aresR		bqrez 		asigR, kcf, kres, 0, i(gkskip)
	elseif gktype==16 then					;bqrez(hp)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  aresL 	bqrez 		asigL, kcf, kres, 1, i(gkskip)
	  aresR		bqrez 		asigR, kcf, kres, 1, i(gkskip)
	elseif gktype==17 then					;bqrez(bp)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  aresL 	bqrez 		asigL, kcf, kres, 2, i(gkskip)
	  aresR		bqrez 		asigR, kcf, kres, 2, i(gkskip)
	elseif gktype==18 then					;bqrez(br)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  aresL 	bqrez 		asigL, kcf, kres, 3, i(gkskip)
	  aresR		bqrez 		asigR, kcf, kres, 3, i(gkskip)
	elseif gktype==19 then					;clfilt(lp)
	  aresL		clfilt 	asigL, kcf, 0, i(gknpol), i(gkkind), i(gkpbr), i(gksba), i(gkskip)
	  aresR		clfilt 	asigR, kcf, 0, i(gknpol), i(gkkind), i(gkpbr), i(gksba), i(gkskip)
	elseif gktype==20 then					;clfilt(hp)
	  aresL		clfilt 	asigL, kcf, 1, i(gknpol), i(gkkind), i(gkpbr), i(gksba), i(gkskip)
	  aresR		clfilt 	asigR, kcf, 1, i(gknpol), i(gkkind), i(gkpbr), i(gksba), i(gkskip)
	elseif gktype==21 then					;lowpass2
	kres		=		((gkres^2)*149)+1
	  		FLprintk2	kres, gidres
  	  aresL 	lowpass2	asigL, kcf, kres, i(gkskip)
	  aresR 	lowpass2	asigR, kcf, kres, i(gkskip)
	elseif gktype==22 then					;lowres
	kres		=		((gkres^2)*149)+1
	  		FLprintk2	kres, gidres
	  aresL		lowres 		asigL, (kcf/5)-4, kres, i(gkskip)
	  aresR		lowres 		asigR, (kcf/5)-4, kres, i(gkskip)
	elseif gktype==23 then					;lowresx
	kres		=		((gkres^2)*149)+1
	  		FLprintk2	kres, gidres
	  aresL 	lowresx 	asigL, (kcf/4)-4, kres, i(gknumlayer), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	  aresR 	lowresx 	asigR, (kcf/4)-4, kres, i(gknumlayer), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	elseif gktype==24 then					;rezzy(lp)
	kres		=		(gkres*99)+1
	  		FLprintk2	kres, gidres
	  kcf		limit		kcf, 20, 10000
	  aresL		rezzy 		asigL, kcf, kres, 0, i(gkskip)
	  aresR		rezzy 		asigR, kcf, kres, 0, i(gkskip)
	elseif gktype==25 then					;rezzy(hp)                               
	kres		=		(gkres*99)+1
	  		FLprintk2	kres, gidres
	  kcf		limit		kcf, 20, 10000
	  aresL		rezzy 		asigL, kcf, kres, 1, i(gkskip)
	  aresR		rezzy 		asigR, kcf, kres, 1, i(gkskip)            
	elseif gktype==26 then					;statevar(lp)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  ahpL,aresL,abpL,abrL 	statevar asigL, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	  ahpR,aresR,abpR,abrR 	statevar asigR, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	elseif gktype==27 then					;statevar(hp)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  aresL,alpL,abpL,abrL 	statevar asigL, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	  aresR,alpR,abpR,abrR 	statevar asigR, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	elseif gktype==28 then					;statevar(bp)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  ahpL,alpL,aresL,abrL 	statevar asigL, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	  ahpR,alpR,aresR,abrR 	statevar asigR, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	elseif gktype==29 then					;statevar(br)
	kres		=		(gkres*19)+1
	  		FLprintk2	kres, gidres
	  ahpL,alpL,abpL,aresL 	statevar asigL, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	  ahpR,alpR,abpR,aresR 	statevar asigR, kcf, kres, i(gknumlayer), i(gkskip)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	elseif gktype==30 then					;svfilter(lp)
	  kres		=		(gkres*40)
	  		FLprintk2	kres, gidres
	  aresL, ahighL, abandL svfilter  asigL, kcf, kres, i(gkscl2)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	  aresR, ahighR, abandR svfilter  asigR, kcf, kres, i(gkscl2)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	elseif gktype==31 then					;svfilter(hp)
	  kres		=		(gkres*40)
	  		FLprintk2	kres, gidres
	  kcf		limit		kcf, 20, 10000
  	  alowL, aresL, abandL 	svfilter  asigL, kcf, kres, i(gkscl2)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	  alowR, aresR, abandR 	svfilter  asigR, kcf, kres, i(gkscl2)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	elseif gktype==32 then					;svfilter(bp)
	  kres		=		(gkres*40)
	  		FLprintk2	kres, gidres
	  kcf		limit		kcf, 20, 10000
  	  alowL, ahighL, aresL 	svfilter  asigL, kcf, kres, i(gkscl2)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	  alowR, ahighR, aresR 	svfilter  asigR, kcf, kres, i(gkscl2)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	elseif gktype==33 then					;tbvcf
	  kres		=		gkres*3
	  		FLprintk2	kres, gidres
	  kdist		=		gkdist*2
	  		FLprintk2	kdist,giddist                                                    
	  aresL 	tbvcf 		asigL, kcf, kres, kdist, gkasym, i(gkskip)
	  aresR 	tbvcf 		asigR, kcf, kres, kdist, gkasym, i(gkskip)
	elseif gktype==34 then					;rbjeq(lp)
	  kres		=		(((gkres^2)*(0.05-0.0001))+0.0001)*kcf                              
	  		FLprintk2	kres, gidres
	  aresL		rbjeq 		asigL, kcf, 1, kres, 1, 0+i(gkskip)
	  aresR		rbjeq 		asigR, kcf, 1, kres, 1, 0+i(gkskip)
	elseif gktype==35 then					;rbjeq(hp)                                        
	  kres		=		(((gkres^2)*(0.05-0.0001))+0.0001)*kcf                              
	  		FLprintk2	kres, gidres
	  aresL		rbjeq 		asigL, kcf, 1, kres, 1, 2+i(gkskip)
	  aresR		rbjeq 		asigR, kcf, 1, kres, 1, 2+i(gkskip)
	elseif gktype==36 then					;rbjeq(bp)
	  kres		=		(((gkres^2)*(0.05-0.0001))+0.0001)*kcf                              
	  		FLprintk2	kres, gidres
	  aresL		rbjeq 		asigL, kcf, 1, kres, 1, 4+i(gkskip)
	  aresR		rbjeq 		asigR, kcf, 1, kres, 1, 4+i(gkskip)
	elseif gktype==37 then					;rbjeq(br)
	  kres		=		(((gkres^2)*(0.05-0.0001))+0.0001)*kcf                              
	  		FLprintk2	kres, gidres
	  aresL		rbjeq 		asigL, kcf, 1, kres, 1, 6+i(gkskip)
	  aresR		rbjeq 		asigR, kcf, 1, kres, 1, 6+i(gkskip)
	endif	

	itime	init	0
	FLprintk	itime,kres,gidres
	FLprintk	itime,kdist,giddist
	itime	=	9999
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	if gkBalance==1 then
	  aresL	balance	aresL,asigL
	  aresR	balance	aresR,asigR
	endif
		outs	aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin

instr	2
	kSwitch		changed	gkscl, gktype	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch==1 then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
	  reinit	UPDATE		;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	UPDATE:
	FLhide	gihskip
	FLhide	gihscl                                                                           
	FLhide	gihsclmode                                                                          
	FLhide	gihscl2
	FLhide	gihbw
	FLhide	gidbw
	FLhide	gihnumlayer                                                                           
	FLhide	gihres
	FLhide	gidres
	FLhide	gihdist
	FLhide	giddist
	FLhide	gihnpol
	FLhide	gihkind
	FLhide	gihscl2
	FLhide	gihpbr
	FLhide	gidpbr
	FLhide	gihsba
	FLhide	gidsba
	FLhide	gihasym
	FLhide	gidasym
	
	if     i(gktype)==0 then					;butlp
	  FLshow	gihskip
	elseif i(gktype)==1 then					;buthp
	  FLshow	gihskip
	elseif i(gktype)==2 then					;butbp
	  FLshow	gihskip
	  FLshow	gihbw
	  FLshow	gidbw
	elseif i(gktype)==3 then					;butbr
	  FLshow	gihskip
	  FLshow	gihbw
	  FLshow	gidbw
	elseif i(gktype)==4 then					;tone
	  FLshow	gihskip
	elseif i(gktype)==5 then					;tonex
	  FLshow	gihskip
	  FLshow	gihnumlayer                                                                           
	elseif i(gktype)==6 then					;atone
	  FLshow	gihskip
	elseif i(gktype)==7 then					;atonex
	  FLshow	gihskip
	  FLshow	gihnumlayer                                                                           
	elseif i(gktype)==8 then					;reson
	  FLshow	gihskip
	  FLshow	gihbw
	  FLshow	gidbw
	  FLshow	gihscl
	  if i(gkscl)==0 then
	    FLsetText	"none", gihsclmode
	  endif
	  if i(gkscl)==1 then
	    FLsetText	"Peak Response Factor of 1", gihsclmode
	  endif
	  if i(gkscl)==2 then
	    FLsetText	"RMS Response Factor=1", gihsclmode
	  endif
	  FLshow	gihsclmode
	elseif i(gktype)==9 then					;resonr
	  FLshow	gihskip
	  FLshow	gihbw
	  FLshow	gidbw
	  FLshow	gihscl
	  if i(gkscl)==0 then
	    FLsetText	"none", gihsclmode
	  endif
	  if i(gkscl)==1 then
	    FLsetText	"Peak Response Factor of 1", gihsclmode
	  endif
	  if i(gkscl)==2 then
	    FLsetText	"RMS Response Factor=1", gihsclmode
	  endif
	  FLshow	gihsclmode
	elseif i(gktype)==10 then					;resonz
	  FLshow	gihskip
	  FLshow	gihbw
	  FLshow	gidbw
	  FLshow	gihscl
	  if i(gkscl)==0 then
	    FLsetText	"none", gihsclmode
	  endif
	  if i(gkscl)==1 then
	    FLsetText	"Peak Response Factor of 1", gihsclmode
	  endif
	  if i(gkscl)==2 then
	    FLsetText	"RMS Response Factor=1", gihsclmode
	  endif
	  FLshow	gihsclmode
	elseif i(gktype)==11 then					;areson
	  FLshow	gihskip
	  FLshow	gihbw
	  FLshow	gidbw
	  FLshow	gihscl
	  if i(gkscl)==0 then
	    FLsetText	"none", gihsclmode
	  endif
	  if i(gkscl)==1 then
	    FLsetText	"Peak Response Factor of 1", gihsclmode
	  endif
	  if i(gkscl)==2 then
	    FLsetText	"RMS Response Factor=1", gihsclmode
	  endif
	  FLshow	gihsclmode
	elseif i(gktype)==12 then					;moogvcf2
	  FLshow	gihres
	  FLshow	gidres
	elseif i(gktype)==13 then					;moogladder
	  FLshow	gihres
	  FLshow	gidres
	elseif i(gktype)==14 then					;lpf18
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihdist
	  FLshow	giddist
	elseif i(gktype)==15 then					;bqrez(lp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==16 then					;bqrez(hp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==17 then					;bqrez(bp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==18 then					;bqrez(br)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==19 then					;clfilt(lp)
	  FLshow	gihnpol
	  FLshow	gihkind
	  FLshow	gihpbr
	  FLshow	gihsba
	  FLshow	gidpbr
	  FLshow	gidsba
	  FLshow	gihskip
	elseif i(gktype)==20 then					;clfilt(hp)
	  FLshow	gihnpol
	  FLshow	gihkind
	  FLshow	gihpbr
	  FLshow	gihsba
	  FLshow	gidpbr
	  FLshow	gidsba
	  FLshow	gihskip
	elseif i(gktype)==21 then					;lowpass2
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==22 then					;lowres
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==23 then					;lowresx
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	  FLshow	gihnumlayer
	elseif i(gktype)==24 then					;rezzy(lp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==25 then					;rezzy(hp)                               
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==26 then					;statevar(lp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihnumlayer
	  FLsetVal_i	3,gihnumlayer
	  FLshow	gihskip
	elseif i(gktype)==27 then					;statevar(hp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihnumlayer
	  FLsetVal_i	3,gihnumlayer
	  FLshow	gihskip
	elseif i(gktype)==28 then					;statevar(bp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihnumlayer
	  FLsetVal_i	3,gihnumlayer
	  FLshow	gihskip
	elseif i(gktype)==29 then					;statevar(br)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihnumlayer
	  FLsetVal_i	3,gihnumlayer
	  FLshow	gihskip
	elseif i(gktype)==30 then					;svfilter(lp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihscl2
	elseif i(gktype)==31 then					;svfilter(hp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihscl2
	elseif i(gktype)==32 then					;svfilter(bp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihscl2
	elseif i(gktype)==33 then					;tbvcf
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihdist
	  FLshow	giddist
	  FLshow	gihasym
	  FLshow	gidasym
	  FLshow	gihskip
	elseif i(gktype)==34 then					;rbjeq(lp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==35 then					;rbjeq(hp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==36 then					;rbjeq(bp)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	elseif i(gktype)==37 then					;rbjeq(br)
	  FLshow	gihres
	  FLshow	gidres
	  FLshow	gihskip
	endif
endin

</CsInstruments>

<CsScore>
i 2 0 3600
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
