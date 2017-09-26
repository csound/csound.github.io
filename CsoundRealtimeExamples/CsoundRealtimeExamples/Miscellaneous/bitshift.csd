bitshift.csd
Written by Iain McCurdy, 2014

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
	FLpanel	"bitshift",   500,    145,    0,  0

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

;		FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkdir, ihdir	FLbutBank	4,     1,     2,     20,     15*2,   180, 15,   -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"bitshift left << ", 	1,      5,     12,    125,    15,   195,  15
FLsetColor	150,200,250,ih
ih		 	FLbox  	"bitshift right >>", 	1,      5,     12,    125,    15,   195,  30
FLsetColor	150,200,250,ih


;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	ihinput1
			FLsetVal_i	4, 	ihinput2
			FLsetVal_i	0, 	gihoutput


			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     260,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       bitshift << >>                        ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The bitshift operators:                                      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"bitshift left: '<<'                                          ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"bitshift left: '>>'                                          ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"apply bitshift operations between two values. The code for   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"bitshifting left would be:                                   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"  gkoutput   =    gkinput1  <<  gkinput2                     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Choose between bitshifing left (<<) and bitshifting right    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"(>>) using the two radio buttons. Output will always be an   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"integer. Inputs should also be integers.                     ", 	1,      5,     14,    490,    15,     5, 240
          
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1

instr	1
 
 if gkdir==0 then				; bitshift left
  koutput	=	gkinput1 << gkinput2
 elseif gkdir==1 then				; bitshift right
  koutput	=	gkinput1 >> gkinput2
 endif
 
 ktrig		changed		koutput		
 		FLsetVal	ktrig,koutput,gihoutput				; send output value to 'output' slider
endin

</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>