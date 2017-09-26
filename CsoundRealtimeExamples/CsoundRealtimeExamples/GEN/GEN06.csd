GEN06.csd
Written by Iain McCurdy, 2011

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
				FLpanel	"GEN06",  500,    390,    0,  0
 
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Oscillator On/Off",	1,    0,    22,    120,     50,    5,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfrq				FLvalue	" ",       50,     17,  130,  20
idamp				FLvalue	" ",       50,     17,  130,  55
idval1				FLvalue	" ",       50,     17,    5,  90
iddur1				FLvalue	" ",       50,     17,    5, 125
idPOI1				FLvalue	" ",       50,     17,    5, 160
iddur2				FLvalue	" ",       50,     17,    5, 195
idval2				FLvalue	" ",       50,     17,    5, 230
iddur3				FLvalue	" ",       50,     17,    5, 265
idPOI2				FLvalue	" ",       50,     17,    5, 300
iddur4				FLvalue	" ",       50,     17,    5, 335
idval3				FLvalue	" ",       50,     17,    5, 370

;SLIDERS					            		MIN |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y 
gkfrq,ihfrq			FLslider 	"Oscillator Frequency",	1,    5000,   -1,    23,   idfrq,     360,      15,  130,    5
gkamp,ihamp			FLslider 	"Global Amp.",		0,       1,    0,    23,   idamp,     360,      15,  130,   40
gkval1,ihval1			FLslider 	"Value 1",		-1,      1,   0,    23,   idval1,     490,      15,    5,   75
gkdur1,ihdur1			FLslider 	"Duration 1",		0,    4096,   0,    23,   iddur1,     490,      15,    5,  110
gkPOI1,ihPOI1			FLslider 	"Point of Inflexion 1", -1,      1,   0,    23,   idPOI1,     490,      15,    5,  145
gkdur2,ihdur2			FLslider 	"Duration 2",		0,    4096,   0,    23,   iddur2,     490,      15,    5,  180
gkval2,ihval2			FLslider 	"Value 2",		-1,      1,   0,    23,   idval2,     490,      15,    5,  215
gkdur3,ihdur3			FLslider 	"Duration 3",		0,    4096,   0,    23,   iddur3,     490,      15,    5,  250
gkPOI2,ihPOI2			FLslider 	"Point of Inflexion 2", -1,      1,   0,    23,   idPOI2,     490,      15,    5,  285
gkdur4,ihdur4			FLslider 	"Duration 4",		0,    4096,   0,    23,   iddur4,     490,      15,    5,  320
gkval3,ihval3			FLslider 	"Value 3",		-1,      1,   0,    23,   idval3,     490,      15,    5,  355

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	440, 	ihfrq
				FLsetVal_i	0.3, 	ihamp
				FLsetVal_i	0, 	ihval1
				FLsetVal_i	1024, 	ihdur1                                
				FLsetVal_i	0.5, 	ihPOI1                                    
				FLsetVal_i	1024, 	ihdur2
				FLsetVal_i	1, 	ihval2
				FLsetVal_i	1024, 	ihdur3
				FLsetVal_i	0.5, 	ihPOI2
				FLsetVal_i	1024, 	ihdur4
				FLsetVal_i	0, 	ihval3
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 440, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN06                          ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"GEN06 can be used to create curve functions based upon cubic ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"polynomials.                                                 ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"When defining the function table p-fields beyond p4, values  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"and durations (in table points) alternate. Every other value,", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"however, defines a 'point of inflexion' where the curve      ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"changes from convex to concave or vice versa.                ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"The number of curve segments is arbitrary and can be defined ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"by the user in the function table provided the table ends on ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"a value or a point of inflexion.                             ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"In this example the function table created is used by an     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"audio oscillator ('poscil'). Function table size is modified ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"dynamically to always equal the sum of all durations defined.", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Post normalisation of the table is on, i.e. GEN routine (p4) ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"is given as a positive number. This means that the table will", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"be rescaled so that a maxima or minima hit 1 or -1.          ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Other uses of this GEN routine might be to design envelope   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"shapes for amplitude control, panning trajectory, window     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"functions etc.                                               ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"If you enable Csound displays (i.e. if you don't use the -d  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"flag) you can observe changes visually as well as aurally.   ", 	1,      5,     14,    490,    15,     5, 420

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                                              
instr	1	;UPDATES ENVELOPES (ALWAYS ON)
	ktrig	changed	gkval1,gkdur1,gkPOI1,gkdur2,gkval2,gkdur3,gkPOI2,gkdur4,gkval3	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS.
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO RECREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL - REINITIALIZE FROM HERE
	  ;CREATE THE FUNCTION TABLE. A SPECIFIC FUNCTION TABLE NUMBER IS USED (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE. 
	  ;GEN ROUTINE NUMBER (P4) IS POSITIVE SO THE TABLE WILL BE NORMALISED WITHIN THE RANGE -1 TO 1.
	  ;THE MINUS SIGN BEFORE THE FUNCTION TABLE SIZE (P3) ALLOWS US TO USE NON POWER 2 TABLE SIZES. THE FUNCTION TABLE SIZE WILL BE THE SUM OF ALL SEGMENT DURATIONS.
	  ;IN GENERAL CARE SHOULD BE TAKEN WHEN RESIZING AND OVER-WRITING AN EXISTING TABLE. IDEALLY ALL OPCODES THAT USE THAT FUNCTION TABLE SHOULD BE REINITIALIZED WHEN THAT IS DONE.
	  gifun	ftgen  1,0,-(i(gkdur1)+i(gkdur2)+i(gkdur3)+i(gkdur4)),-6,i(gkval1),i(gkdur1),i(gkPOI1),i(gkdur2),i(gkval2),i(gkdur3),i(gkPOI2),i(gkdur4),i(gkval3) 
	endif					;END OF THIS CONDITIONAL BRANCH
	kporttime	linseg	0,0.001,0.01	;CREATE A FUNCTION THAT RISES QUICKLY FROM ZERO TO A FIXED VALUE THAT WILL BE USED FOR PORTAMENTO TIME
	kfrq	portk	gkfrq,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	kamp	portk	gkamp,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	a1	poscil	kamp,kfrq,gifun		;AN AUDIO OSCILLATOR IS CREATED. poscil MUST BE USED (INSTEAD OF oscil ETC.) AS NON-POWER OF 2 FUNCTION TABLE SIZES CAN BE USED. 
	rireturn				;RETURN FROM REINITIALIZATION PASS (NOTE THAT THE poscil MUST BE WITHIN THE REINITIALIZATION LOOP SO THAT IT CAN REINITIALIZE WHENEVER THE FUNCTION TABLE SIZE CHANGES.)
	if gkOnOff=1 then			;IF ON/OFF
		out	a1
	endif
endin
  	
</CsInstruments>

<CsScore>                                    
i 1 0 3600	;INSTR 1 PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
