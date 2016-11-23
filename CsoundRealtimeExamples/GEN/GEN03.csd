GEN03.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0                                                             
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN03",  500,    600,    0,  0
 
;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idval1				FLvalue	" ",       50,     17,    5,  25
idval2				FLvalue	" ",       50,     17,    5,  75
idc0				FLvalue	" ",       50,     17,    5, 125
idc1				FLvalue	" ",       50,     17,    5, 175
idc2				FLvalue	" ",       50,     17,    5, 225
idc3				FLvalue	" ",       50,     17,    5, 275
idc4				FLvalue	" ",       50,     17,    5, 325
idc5				FLvalue	" ",       50,     17,    5, 375
idc6				FLvalue	" ",       50,     17,    5, 425
idamp				FLvalue	" ",       50,     17,    5, 525
idfrq				FLvalue	" ",       50,     17,    5, 575

;SLIDERS					            	MIN |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y 
gkval1,ihval1			FLslider 	"Value 1",	-1,      1,    0,   23,   idval1,     490,      25,    5,    0
gkval2,ihval2			FLslider 	"Value 2",	-1,      1,    0,   23,   idval2,     490,      25,    5,   50
gkc0,gihc0			FLslider 	"Coefficient 0",-1,     1,    0,   23,   idc0,       490,      25,    5,   100
gkc1,gihc1			FLslider 	"Coefficient 1",-1,     1,    0,   23,   idc1,       490,      25,    5,   150
gkc2,gihc2			FLslider 	"Coefficient 2",-1,     1,    0,   23,   idc2,       490,      25,    5,   200
gkc3,gihc3			FLslider 	"Coefficient 3",-1,     1,    0,   23,   idc3,       490,      25,    5,   250
gkc4,gihc4			FLslider 	"Coefficient 4",-1,     1,    0,   23,   idc4,       490,      25,    5,   300
gkc5,gihc5			FLslider 	"Coefficient 5",-1,     1,    0,   23,   idc5,       490,      25,    5,   350
gkc6,gihc6			FLslider 	"Coefficient 6",-1,     1,    0,   23,   idc6,       490,      25,    5,   400
gkamp,ihamp			FLslider 	"Amplitude",     0,     1,    0,   23,   idamp,      490,      25,    5,   500
gkfrq,ihfrq			FLslider 	"Frequency",     20, 5000,    0,   23,   idfrq,      490,      25,    5,   550

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR | p4
gkzero,ihzero			FLbutton	"zero",		0,    0,    21,     50,     18,  445,125,     0,     99,      0,       0,   0
gkzero,ihzero			FLbutton	"zero",		0,    0,    21,     50,     18,  445,175,     0,     99,      0,       0,   1
gkzero,ihzero			FLbutton	"zero",		0,    0,    21,     50,     18,  445,225,     0,     99,      0,       0,   2
gkzero,ihzero			FLbutton	"zero",		0,    0,    21,     50,     18,  445,275,     0,     99,      0,       0,   3
gkzero,ihzero			FLbutton	"zero",		0,    0,    21,     50,     18,  445,325,     0,     99,      0,       0,   4
gkzero,ihzero			FLbutton	"zero",		0,    0,    21,     50,     18,  445,375,     0,     99,      0,       0,   5
gkzero,ihzero			FLbutton	"zero",		0,    0,    21,     50,     18,  445,425,     0,     99,      0,       0,   6

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	-1, 	ihval1                                          
				FLsetVal_i	1, 	ihval2
				FLsetVal_i	0, 	gihc0
				FLsetVal_i	1, 	gihc1                                
				FLsetVal_i	0, 	gihc2                                    
				FLsetVal_i	0, 	gihc3
				FLsetVal_i	0, 	gihc4
				FLsetVal_i	0.1, 	ihamp
				FLsetVal_i	200, 	ihfrq
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 520, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             GEN03                           ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This subroutine generates a stored function table by         ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"evaluating a polynomial in x over a fixed interval and with  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"specified coefficients.                                      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"xval1, xval2 -- left and right values of the x interval over ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"which the polynomial is defined (xval1 < xval2). These will  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"produce the 1st stored value and the (power-of-2 plus l)th   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"stored value respectively in the generated function table.   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"c0, c1, c2, ..., cn -- coefficients of the nth-order         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"polynomial.                                                  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"C0 + C1x + C2x2 + . . . + Cnxn                               ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Coefficients may be positive or negative real numbers; a zero", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"denotes a missing term in the polynomial. The coefficient    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"list begins in p7, providing a current upper limit of 144    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"terms.                                                       ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"The defined segment [fn(xval1), fn(xval2)] is evenly         ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"distributed. Thus a 512-point table over the interval [-1,1] ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"will have its origin at location 257 (at the start of the 2nd", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"half). Provided the extended guard point is requested, both  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"fn(-1) and fn(1) will exist in the table.                    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"GEN03 is useful in conjunction with table or tablei for audio", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"waveshaping (sound modification by non-linear distortion).   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"Coefficients to produce a particular formant from a          ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"sinusoidal lookup index of known amplitude can be determined ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"at preprocessing time using algorithms such as Chebyshev     ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"formulae. See also GEN13.                                    ", 	1,      5,     14,    490,    15,     5, 500

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1

instr	1	;
	ktrig	changed	gkval1,gkval2,gkc0,gkc1,gkc2,gkc3,gkc4,gkc5,gkc6	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS.
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO RECREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL - REINITIALIZE FROM HERE
	  ;CREATE THE FUNCTION TABLE. A SPECIFIC FUNCTION TABLE NUMBER IS USED (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE. 
	  ;GEN ROUTINE NUMBER (P4) IS POSITIVE SO THE TABLE WILL BE NORMALISED WITHIN THE RANGE -1 TO 1.
	  ;THE MINUS SIGN BEFORE THE FUNCTION TABLE SIZE (P3) ALLOWS US TO USE NON POWER 2 TABLE SIZES. THE FUNCTION TABLE SIZE WILL BE THE SUM OF ALL SEGMENT DURATIONS.
	  ;IN GENERAL CARE SHOULD BE TAKEN WHEN RESIZING AND OVER-WRITING AN EXISTING TABLE. IDEALLY ALL OPCODES THAT USE THAT FUNCTION TABLE SHOULD BE REINITIALIZED WHEN THAT IS DONE.
	  ifun	ftgen  1,0,1024,3,i(gkval1),i(gkval2),i(gkc0),i(gkc1),i(gkc2),i(gkc3),i(gkc4),i(gkc5),i(gkc6)
	endif					;END OF THIS CONDITIONAL BRANCH

	andx	poscil	gkamp, gkfrq, gisine						; sine wave to be distorted
	asig	tablei	(andx+gkamp)*(1-gkamp), ifun, 1					; waveshaping
		out	asig
endin
 
instr	99
	FLsetVal_i	0,gihc0+p4
endin
</CsInstruments>

<CsScore>                                    
i 1 0 3600	;INSTR 1 PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
