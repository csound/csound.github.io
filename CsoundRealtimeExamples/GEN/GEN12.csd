GEN12.csd
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
				FLpanel	"GEN12",  500,     60,    0,  0
 
;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idxint				FLvalue	" ",      100,     20,    5,  30

;SLIDERS					            	MIN |  MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y 
gkxint,ihxint			FLslider 	"xint",		1,   1000000, -1,   23,   idxint,   490,      25,    5,    5

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	 1, 	ihxint
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 440, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             GEN12                           ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"GEN12 generates the log of a modified Bessel function of the ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"second kind, order 0, suitable for use in amplitude-modulated", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"FM.                                                          ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"'xint' specifies the x interval [0 to +xint] over which the  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"function is defined.                                         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"This subroutine draws the natural log of a modified Bessel   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"function of the second kind, order 0 (commonly written as I  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"subscript 0), over the x-interval requested. The call should ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"have rescaling inhibited.                                    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"The function is useful as an amplitude scaling factor in     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"cycle-synchronous amplitude-modulated FM. (See Palamin &     ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Palamin, J. Audio Eng. Soc., 36/9, Sept. 1988, pp.671-684.)  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"The algorithm is interesting because it permits the normally ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"symmetric FM spectrum to be made asymmetric around a         ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"frequency other than the carrier, and is thereby useful for  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"formant positioning. By using a table lookup index of        ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"I(r - 1/r), where I is the FM modulation index and r is an   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"exponential parameter affecting partial strengths, the       ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"Palamin algorithm becomes relatively efficient, requiring    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"only oscil's, table lookups, and a single exp call.          ", 	1,      5,     14,    490,    15,     5, 420

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;
	ktrig	changed	gkxint			;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS.
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO RECREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL - REINITIALIZE FROM HERE
	  ;CREATE THE FUNCTION TABLE. A SPECIFIC FUNCTION TABLE NUMBER IS USED (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE. 
	  ;GEN ROUTINE NUMBER (P4) IS POSITIVE SO THE TABLE WILL BE NORMALISED WITHIN THE RANGE -1 TO 1.
	  ;THE MINUS SIGN BEFORE THE FUNCTION TABLE SIZE (P3) ALLOWS US TO USE NON POWER 2 TABLE SIZES. THE FUNCTION TABLE SIZE WILL BE THE SUM OF ALL SEGMENT DURATIONS.
	  ;IN GENERAL CARE SHOULD BE TAKEN WHEN RESIZING AND OVER-WRITING AN EXISTING TABLE. IDEALLY ALL OPCODES THAT USE THAT FUNCTION TABLE SHOULD BE REINITIALIZED WHEN THAT IS DONE.
	  ifun	ftgen  1,0,-1024,-12,i(gkxint)
	endif					;END OF THIS CONDITIONAL BRANCH
endin
 
</CsInstruments>

<CsScore>                                    
i 1 0 3600	;INSTR 1 PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
