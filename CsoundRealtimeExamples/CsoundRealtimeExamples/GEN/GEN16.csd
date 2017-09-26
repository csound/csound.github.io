GEN16.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN16",  500,    360,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Trigger Note",	1,    0,    21,    140,     25,    5,  5,    -1;0,      2,      0,      0.01
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
iddur				FLvalue	" ",       50,     17,  200,  20
;SLIDERS					            		MIN |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y
gkdur,ihdur			FLslider 	"Duration",		0.1,     8,  -1,    23,   iddur,      240,      15, 200,     5
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	1, 	ihdur
                                                                                                    
FLcolor	255, 255, 255, 0, 0, 0

;BORDERS & TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 			6,      9,     15,    248,    300,    1,  50	;BORDER AROUND AMPLITUDE ENVELOPE PANEL
ih		 	FLbox  	" ", 			6,      9,     15,    248,    300,  251,  50	;BORDER AROUND PITCH ENVELOPE PANEL
ih		 	FLbox  	"Amplitude Envelope", 	0,      9,     12,    240,     20,    5,  54	;BORDER AROUND PITCH ENVELOPE PANEL
ih		 	FLbox  	"Pitch Envelope", 	0,      9,     12,    240,     20,  255,  54	;BORDER AROUND PITCH ENVELOPE PANEL

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idampval1			FLvalue	"",        50,     17,    5, 100
idampdur1			FLvalue	"",        50,     17,    5, 135                  
idampshp1			FLvalue	"",        50,     17,    5, 170
idampval2			FLvalue	"",        50,     17,    5, 205
idampdur2			FLvalue	"",        50,     17,    5, 240
idampshp2			FLvalue	"",        50,     17,    5, 275
idampval3			FLvalue	"",        50,     17,    5, 310
idpchval1			FLvalue	"",        50,     17,  255, 100
idpchdur1			FLvalue	"",        50,     17,  255, 135                  
idpchshp1			FLvalue	"",        50,     17,  255, 170
idpchval2			FLvalue	"",        50,     17,  255, 205
idpchdur2			FLvalue	"",        50,     17,  255, 240
idpchshp2			FLvalue	"",        50,     17,  255, 275                                    
idpchval3			FLvalue	"",        50,     17,  255, 310

;SLIDERS					            		MIN |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y
gkampval1,ihampval1		FLslider 	"Value 1",		0,       1,   0,    23,   idampval1,  240,      15,   5,    85
gkampdur1,ihampdur1		FLslider 	"Duration 1",		1,    4096,   0,    23,   idampdur1,  240,      15,   5,   120
gkampshp1,ihampshp1		FLslider 	"Curvature 1",		-20,    20,   0,    23,   idampshp1,  240,      15,   5,   155
gkampval2,ihampval2		FLslider 	"Value 2",		0,       1,   0,    23,   idampval2,  240,      15,   5,   190
gkampdur2,ihampdur2		FLslider 	"Duration 2",		1,    4096,   0,    23,   idampdur2,  240,      15,   5,   225
gkampshp2,ihampshp2		FLslider 	"Curvature 2",		-20,    20,   0,    23,   idampshp2,  240,      15,   5,   260
gkampval3,ihampval3		FLslider 	"Value 3",		0,       1,   0,    23,   idampval3,  240,      15,   5,   295

gkpchval1,ihpchval1		FLslider 	"Value 1",		6,      10,   0,    23,   idpchval1,  240,      15, 255,    85
gkpchdur1,ihpchdur1		FLslider 	"Duration 1",		1,    4096,   0,    23,   idpchdur1,  240,      15, 255,   120
gkpchshp1,ihpchshp1		FLslider 	"Curvature 1",		-20,    20,   0,    23,   idpchshp1,  240,      15, 255,   155
gkpchval2,ihpchval2		FLslider 	"Value 2",		6,      10,   0,    23,   idpchval2,  240,      15, 255,   190
gkpchdur2,ihpchdur2		FLslider 	"Duration 2",		1,    4096,   0,    23,   idpchdur2,  240,      15, 255,   225
gkpchshp2,ihpchshp2		FLslider 	"Curvature 2",		-20,    20,   0,    23,   idpchshp2,  240,      15, 255,   260
gkpchval3,ihpchval3		FLslider 	"Value 3",		6,      10,   0,    23,   idpchval3,  240,      15, 255,   295

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0, 	ihampval1
				FLsetVal_i	2048, 	ihampdur1
				FLsetVal_i	4, 	ihampshp1
				FLsetVal_i	1, 	ihampval2
				FLsetVal_i	2048, 	ihampdur2
				FLsetVal_i	4, 	ihampshp2
				FLsetVal_i	0, 	ihampval3
				FLsetVal_i	8, 	ihpchval1
				FLsetVal_i	2048, 	ihpchdur1
				FLsetVal_i	4, 	ihpchshp1
				FLsetVal_i	8, 	ihpchval2
				FLsetVal_i	2048, 	ihpchdur2
				FLsetVal_i	4, 	ihpchshp2
				FLsetVal_i	8, 	ihpchval3
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 380, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN16                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"GEN16 allows the creation of function tables made up of      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"break-point segments in a manner similar to GEN05 and GEN06. ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"GEN16 differs in that the user can define the curvature of   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"each segment individually. There is no restriction regarding ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"zero values or crossing the x-axis as there is with GEN05.   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Once again we can define an arbitrary number of segments     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"provided that we define each segment fully, ending with a    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"value. Note that the Csound Reference Manual is unclear in   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"this matter in that it implies that only one segment is      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"permitted. In this example two two-segment functions are     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"created to control amplitude and pitch (oct format).         ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"A curvature of zero will create a straight line segment.     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Increasingly negative or positive values will create         ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"increasingly concave or convex curves, which depends upon    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"whether the start value is larger or smaller that the end    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"value. Enable Csound displays (i.e. don't use the -d flag)   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"and you can observe changes visually as well as aurally.     ", 	1,      5,     14,    490,    15,     5, 360

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;UPDATES ENVELOPES (ALWAYS ON)
	ktrig1	changed	gkampval1,gkampdur1,gkampshp1,gkampval2,gkampdur2,gkampshp2,gkampval3	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE AMPLITUDE ENVELOPE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig1=1 then			;IF A PARAMETER FOR THE AMPLITUDE ENVELOPE HAS BEEN CHANGED...
	  reinit	UPDATE1			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE1' IN ORDER TO CREATE THE AMPLITUDE ENVELOPE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE1:				;A LABEL
	  ;CREATE THE AMPLITUDE ENVELOPE. A SPECIFIC FUNCTION TABLE NUMBER IS USED (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE. 
	  ;A NEGATIVE GEN NUMBER DEFINITION (-16) MEANS THAT THE TABLE WILL BE LEFT UN-NORMALISED.
	  giampenv	ftgen	1,0,4096,-16,i(gkampval1),i(gkampdur1),i(gkampshp1),i(gkampval2),i(gkampdur2),i(gkampshp2),i(gkampval3)
	  rireturn				;RETURN FROM REINITIALISATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH
	ktrig2	changed	gkpchval1,gkpchdur1,gkpchshp1,gkpchval2,gkpchdur2,gkpchshp2,gkpchval3	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE PITCH ENVELOPE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig2=1 then			;IF A PARAMETER FOR THE PITCH ENVELOPE HAS BEEN CHANGED...
	  reinit	UPDATE2			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE2' IN ORDER TO CREATE THE PITCH ENVELOPE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE2:				;A LABEL
	  ;CREATE THE PITCH ENVELOPE. A SPECIFIC FUNCTION TABLE NUMBER IS USED (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE. 
	  ;A NEGATIVE GEN NUMBER DEFINITION (-16) MEANS THAT THE TABLE WILL BE LEFT UN-NORMALISED.
	  gipchenv	ftgen	2,0,4096,-16,i(gkpchval1),i(gkpchdur1),i(gkpchshp1),i(gkpchval2),i(gkpchdur2),i(gkpchshp2),i(gkpchval3)
	  rireturn				;RETURN FROM REINITIALISATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH
endin

instr	2
	ktrig	changed	gkOnOff
	if ktrig==1 then
	 event	"i",3,0,i(gkdur)
	 gkOnOff=0
	endif
endin

instr	3	;PLAYS NOTES FOR AUDIO DEMONSTRATION OF ENVELOPES
	p3	init	i(gkdur)     		;DEFINE NOTE DURATION FROM FLTK SLIDER. (THE DURATION AS DEFINED BY THE FLTK BUTTON WILL BE OVER-WRITTEN)                                                                               
	kampenv	oscil	1,1/p3,giampenv		;DEFINE THE AMPLITUDE ENVELOPE (MUST BE K-RATE FOR vco2, A-RATE NOT PERMITTED)
	koctenv	oscil	1,1/p3,gipchenv		;DEFINE THE PITCH ENVELOPE (MUST BE K-RATE FOR vco2, A-RATE NOT PERMITTED)
	asig	vco2	0.3*kampenv,cpsoct(koctenv),4,0.5	;CREATE AN AUDIO OSCILLATOR USING vco2 - IN THIS CASE A TRIANGLE WAVE
		out	asig			;SEND AUDIO TO THE MONO OUTPUT
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTR 1 PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING)
i 2 0 3600
</CsScore>

</CsoundSynthesizer>
