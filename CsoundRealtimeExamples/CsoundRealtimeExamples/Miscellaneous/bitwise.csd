; bitwise.csd
; Written by Iain McCurdy, 2014

<CsoundSynthesizer>

<CsOptions>
-dm0 -n
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"bitwise",   500,    145,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	3,      9,     15,    490,    75,     5,  5	;
FLsetColor	150,200,250,ih
ih		 	FLbox  	" ", 	3,      9,     15,    490,    55,     5, 85	;
FLsetColor	250,150,100,ih

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkinput1, ihinput1	FLcount  "Input 1",	-128, 128,    1,     10,     1,    150,    25,    20,  15,    -1
gkinput2, ihinput2	FLcount  "Input 2",	-128, 128,    1,     10,     1,    150,    25,   330,  15,    -1

;VALUE INPUT BOXES				MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkoutput, gihoutput	FLtext	"Output", 	-512, 512,    1,    1,     60,      20,   220,  95


;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkoperator, ihoperator	FLbutBank	4,     1,     4,     20,     15*4,   180, 15,   -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"AND (&)       ", 	1,      5,     12,    125,    15,   195,  15
FLsetColor	150,200,250,ih
ih		 	FLbox  	"NOT (¬)       ", 	1,      5,     12,    125,    15,   195,  30
FLsetColor	150,200,250,ih
ih		 	FLbox  	"OR (|)        ", 	1,      5,     12,    125,    15,   195,  45
FLsetColor	150,200,250,ih
ih		 	FLbox  	"Non Equiv. (#)", 	1,      5,     12,    125,    15,   195,  60
FLsetColor	150,200,250,ih


;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	ihinput1
			FLsetVal_i	4, 	ihinput2
			FLsetVal_i	0, 	gihoutput


			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     500,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" bitwise operators AND (&) NOT (¬) OR (|) NON EQUIVALENCE (#)", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Demonstration of the bitwise operators for AND, NOT, OR and  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"non equivalence.                                             ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"NOT operates on input 1 only.                                ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"AND (&)                                                      ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"-------                                                      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"If both inputs are at the same value then the output also be ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"that value, otherwise the output is zero.                    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"NOT (¬)                                                      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"-------                                                      ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"The output will be an inversion of the input (reflected      ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"through -0.5).                                               ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"OR (|)                                                       ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"------                                                       ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"If either (or both) of the inputs are high then the output is", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"also high.                                                   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"NON-EQUVALENCE (#)                                           ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"------------------                                           ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"If the two inputs are not the same value then the output is  ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"equivalent to the higher value, otherwise the output is zero.", 	1,      5,     14,    490,    15,     5, 480

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1

instr	1
 
 if gkoperator==0 then					; AND &
  koutput	=	gkinput1 & gkinput2
 elseif gkoperator==1 then				; NOT ¬
  koutput	=	¬ gkinput1
 elseif gkoperator==2 then				; OR |
  koutput	=	gkinput1 | gkinput2
 elseif gkoperator==3 then				; non equivalence #
  koutput	=	gkinput1 # gkinput2
 endif
 
 ktrig		changed		koutput		
 		FLsetVal	ktrig,koutput,gihoutput				; send output value to 'output' slider
endin

</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>