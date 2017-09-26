modulus.csd
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
	FLpanel	"modulus '%'",   500,    175,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	3,      9,     15,    490,   105,     5,  5	;
FLsetColor	150,200,250,ih
ih		 	FLbox  	" ", 	3,      9,     15,    490,    55,     5, 115	;
FLsetColor	250,150,100,ih

;VALUE INPUT BOXES			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkinput1b, gihinput1b	FLtext	"", 	-2,    2,   0.001,  1,     60,      20,   10,  35
gkinput2b, gihinput2b	FLtext	"", 	-2,    2,   0.001,  1,     60,      20,   10,  85

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idoutput		FLvalue	"",       60,     17,    10, 145

;SLIDERS				            	MIN     | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkinput1, gihinput1	FLslider 	"Input 1",	-2,        2,    0,    23,   -1,        480,     25,   10,   10
gkinput2, gihinput2	FLslider 	"Input 2",	-2,        2,    0,    23,   -1,        480,     25,   10,   60
gkoutput, gihoutput	FLslider 	"Output",	-2,        2,    0,    23,   idoutput,  480,     25,   10,  120



;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	gihinput1
			FLsetVal_i	1, 	gihinput2
			FLsetVal_i	0, 	gihinput1b
			FLsetVal_i	0, 	gihinput2b
			FLsetVal_i	0, 	gihoutput


			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     300,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          modulus %                          ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The modulus operator '%' performs the modulation function    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"between two variables (with no rate restriction). In this    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"example this operation is performed between 'Input 1' and    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"'Input 2'. i.e. the code is as follows:                      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"   gkoutput  =   gkinput1 % gkinput2                         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Input 1 and input 2 can be changed using their sliders or by ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"typing values directly into their number boxes.              ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Input 1 wraps around to zero at the displacement value set by", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"input 2. It is therefore irrelevant whether the input 2 value", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"is positive or negative, it is only its absolute value that  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"is relevant.                                                 ", 	1,      5,     14,    490,    15,     5, 280
          
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1

instr	1

 ktrig1		changed		gkinput1
 ktrig2		changed		gkinput1b
 if ktrig1==1 then
 		FLsetVal	ktrig1,gkinput1,gihinput1b
 elseif ktrig2==1 then
 		FLsetVal	ktrig2,gkinput1b,gihinput1
 endif
 
 ktrig1		changed		gkinput2
 ktrig2		changed		gkinput2b
 if ktrig1==1 then
 		FLsetVal	ktrig1,gkinput2,gihinput2b
 elseif ktrig2==1 then
 		FLsetVal	ktrig2,gkinput2b,gihinput2
 endif
  
 koutput	=	gkinput1 % gkinput2

 ktrig		changed		koutput		
 		FLsetVal	ktrig,koutput,gihoutput				; send output value to 'output' slider
endin

</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>