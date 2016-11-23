WhitePinkFractalNoise.csd
Written by Iain McCurdy, 2012.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;				LABEL                       | WIDTH | HEIGHT | X | Y
			FLpanel	"White Noise / Pink Noise",    500,    470,    0,  0

;BORDERS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihwhitebox		 	FLbox  	" ", 	6,      9,     15,    490,    145,    5,  5
ihpinkbox		 	FLbox  	" ", 	6,      9,     15,    490,    160,    5,155
ihfractalbox		 	FLbox  	" ", 	6,      9,     15,    490,    145,    5,320
FLsetColor	255, 255, 255, ihwhitebox	;SET PRIMARY COLOUR TO WHITE
FLsetColor	255, 200, 200, ihpinkbox	;SET PRIMARY COLOUR TO PINK
FLsetColor	200, 200, 255, ihfractalbox	;SET PRIMARY COLOUR TO BLUE

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkwhite, ihwhite		FLbutton	"White Noise",	1,    0,    22,     150,     25,  10, 10,    0,     1,      0,       -1
gkpink, ihpink			FLbutton	"Pink Noise",	1,    0,    22,     150,     25,  10,160,    0,     2,      0,       -1
gkfractal, ihfractal		FLbutton	"Fractal Noise",1,    0,    22,     150,     25,  10,325,    0,     3,      0,       -1
FLsetColor2	255, 255, 50, ihwhite	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihpink	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihfractal	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idwhiteamp		FLvalue	" ",      100,     20,   10,  70
idbeta			FLvalue	" ",      100,     20,   10, 120
idpinkamp		FLvalue	" ",      100,     20,   10, 220
idfractalamp		FLvalue	" ",      100,     20,   10, 385
idfractalbeta		FLvalue	" ",      100,     20,   10, 435

;SLIDERS				            		MIN | MAX   | EXP     | TYPE |    DISP      | WIDTH | HEIGHT | X  | Y
gkwhiteamp, ihwhiteamp		FLslider 	"Amplitude",	0,     1,      0,        23,    idwhiteamp,     480,     25,   10,   45
gkbeta, ihbeta			FLslider 	"Beta",		-1,    1,      0,        23,    idbeta,         480,     25,   10,   95
gkpinkamp, ihpinkamp		FLslider 	"Amplitude",	0,     1,      0,        23,    idpinkamp,      480,     25,   10,  195
gkfractalamp, ihfractalamp	FLslider 	"Amplitude",	0.0001,1,     -1,        23,    idfractalamp,   480,     25,   10,  360
gkfractalbeta, ihfractalbeta	FLslider 	"Beta",		-2,    5,      0,        23,    idfractalbeta,  480,     25,   10,  410

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gknumbands, ihnumbands		FLcount  "Num. Bands", 	4,    32,     1,      1,      2,    120,     25,  200, 245,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkmethod, ihmethod	FLbutBank	4,      1,      3,     15,     60,   15, 245,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
FLcolor	255, 200, 200	;SET PRIMARY COLOUR TO PINK
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Gardner          ", 	1,       5,    12,    130,      20,  30,  245
ih		 	FLbox  	"Kellet 1         ", 	1,       5,    12,    130,      20,  30,  265
ih		 	FLbox  	"Kellet 2 (faster)", 	1,       5,    12,    130,      20,  30,  285
                                                                                                  
;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	ihbeta
			FLsetVal_i	0.3, 	ihwhiteamp
			FLsetVal_i	0.3, 	ihpinkamp
			FLsetVal_i	20, 	ihnumbands
			FLsetVal_i	0.1, 	ihfractalamp
			FLsetVal_i	0, 	ihfractalbeta

			FLpanel_end

FLcolor	255, 255, 255, 0, 0, 0

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     360,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                white / pink / fractal noise                 ", 	1,      6,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example demonstrates the opcodes 'noise', 'pinkish' and ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"'fractalnoise' which might form useful sources sounds for    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"subtractive synthesis or as impulse sounds.                  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"'noise' produces white noise and 'pinkish' produces pink     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"noise.                                                       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Three different methods of pink noise production are         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"available. When the first option (Gardner) is chosen the     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"number of noise bands can be varied. This parameter has no   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"influence whenever either of the other two methods has been  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"chosen.                                                      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"'fractalnoise' implements white noise filtered by a cascade  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"of 15 first-order filters. 'beta' defines a spectral         ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"parameter related to the fractal dimension. A value of '0'   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"here will result in white noise, '1' in pink noise and a     ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"value of '2' will result in brown noise. Higher 'beta' values", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"may demand a reduction in amplitude to prevent overloading.  ", 	1,      5,     14,    490,    15,     5, 340
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;WHITE NOISE
	if gkwhite=0 then			;IF WHITE NOISE ON/OFF IS OFF...
		turnoff				;...TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH
	asig 	noise 	gkwhiteamp, gkbeta	;GENERATE WHITE NOISE
		out	asig			;SEND AUDIO SIGNAL TO OUTPUT
endin

instr	2	;PINK NOISE
	if	gkpink=0	then					;IF PINK NOISE ON/OFF IS OFF...      
				turnoff					;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif								;END OF THIS CONDITIONAL BRANCH      
	ktrig	changed	gkmethod, gknumbands				;GENERATE BANG (A MOMENTARY '1') IF ANY OF THE INPUT VARIABLES CHANGE
	if ktrig==1 then						;IF AN I-RATE VARIABLE HAS CHANGED
	 reinit UPDATE							;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif								;END OF CONDITIONAL BRANCH
	UPDATE:								;LABEL CALLED 'UPDATE'
	imethod	init	i(gkmethod)					;DERIVE I-TIME VERSION OF gkmethod
	if imethod=0 then						;IF GARDNER METHOD HAS BEEN CHOSEN...
		asig	pinkish	gkpinkamp, imethod, i(gknumbands)	;GENERATE PINK NOISE
	else								;OTHERWISE (I.E. 2ND OR 3RD METHOD HAS BEEN CHOSEN)
		anoise	unirand	2					;WHITE NOISE BETWEEN ZERO AND 2
		anoise	=	(anoise-1)				;OFFSET TO RANGE BETWEEN -1 AND 1
		asig	pinkish anoise, i(gkmethod)   			;GENERATE PINK NOISE
		asig	=	asig * gkpinkamp			;RESCALE AMPLITUDE WITH gkpinkamp
	endif								;END OF CONDITIONAL
	rireturn							;RETURN FROM REINITIALISATION PASS
		out	asig						;SEND AUDIO SIGNAL TO OUTPUT
endin

instr	3	;FRACTAL NOISE
	if	gkfractal=0	then				;IF FRACTAL NOISE ON/OFF IS OFF...      
				turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif							;END OF THIS CONDITIONAL BRANCH      
	asig	fractalnoise	gkfractalamp, gkfractalbeta	;GENERATE FRACTAL NOISE
		out		asig				;SEND AUDIO TO OUTPUT
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>