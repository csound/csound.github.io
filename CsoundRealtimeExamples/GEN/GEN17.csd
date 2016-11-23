GEN17.csd
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
				FLpanel	"GEN17",  500,    200,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idval1				FLvalue	" ",       50,     17,    5,  75
idloc2				FLvalue	" ",       50,     17,    5, 125
idval2				FLvalue	" ",       50,     17,    5, 175

;SLIDERS					            		MIN |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y
gkrate,ihrate			FLslider 	"Rate of Notes",	1,      10,  -1,    23,       -1,     280,      15, 200,      5
gkval1,ihval1			FLslider 	"Value 1",		6,      10,   0,    23,   idval1,     490,      25,   5,     50
gkloc2,ihloc2			FLslider 	"Location 2",		1,     100,   0,    23,   idloc2,     490,      25,   5,    100
gkval2,ihval2			FLslider 	"Value 2",		6,      10,   0,    23,   idval2,     490,      25,   5,    150

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	4, 	ihrate
				FLsetVal_i	8, 	ihval1
				FLsetVal_i	80, 	ihloc2
				FLsetVal_i	9, 	ihval2
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 480, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN17                          ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"GEN17 can be used to generate function tables that resemble  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"histograms. This GEN routine can be useful when working with ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"probabilities. (See also GEN40-42)                           ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"A value is defined at a specified location in the table,     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"that value is sustained throughout the table until another   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"value is defined later in the later (or until the end of the ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"table is reached). In this example just two defined values / ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"locations are used but any number could be used.             ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The location of the first value must always be zero - the    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"first location in the table. That is why no slider is        ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"provided for 'Location 1' in this example.                   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"In this example a random note generator must choose between  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"two pitches (defined by values 1 & 2) each time a new note is", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"generated. Pitches are defined in the 'oct' format. The      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"probability of each note being chosen is reflected in its    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"prevalence in the function table. Therefore the probability  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"weighting for one note or the other being chosen can be      ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"controlled by moving 'Location 2'.                           ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"The function table used is of size 100. This may prove useful", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"in this application as it allows us to think in terms of     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"percentage probability.                                      ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"If you enable Csound displays (i.e. if you don't use the -d  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"flag) you can observe changes visually as well as aurally.   ", 	1,      5,     14,    490,    15,     5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;UPDATES ENVELOPES (ALWAYS ON)
	ktrig1	changed	gkval1,gkloc2,gkval2	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig1=1 then			;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO CREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL
	  ;CREATE THE AMPLITUDE ENVELOPE. A SPECIFIC FUNCTION TABLE NUMBER IS USED (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE. 
	  ;A NEGATIVE GEN NUMBER DEFINITION (-16) MEANS THAT THE TABLE WILL BE LEFT UN-NORMALISED.
	  ;THE MINUS SIGN BEFORE THE FUNCTION TABLE SIZE (P3) ALLOWS US TO USE NON POWER 2 TABLE SIZES
	  ginotes	ftgen	1,0,-100,-17,0,i(gkval1),i(gkloc2),i(gkval2)
	  rireturn				;RETURN FROM REINITIALISATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH
	ktrig	metro	gkrate			;GENERATE A TRAIN OF TRIGGER IMPULSES THAT WILL BE USED TO GENERATE NOTES IN INSTR 2
	schedkwhen	ktrig,0,0,2,0,0.4	;TRIGGER A NOTE IN INSTRUMENT 2
endin

instr	2	;PLAYS NOTES
	if gkOnOff=0 then		;IF ON/OFF BUTTON IS OFF...
	  turnoff			;...TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif				;END OF THIS CONDITIONAL BRANCH
	indx	random	0,100		;GENERATE A RANDOM NUMBER AT INITIALISATION TIME WITHIN THE RANGE 0 - 100
	ioct	table	indx,ginotes	;READ A NOTE VALUE (OCT FORMAT) FROM THE TABLE ginotes. (FRACTIONAL PART OF indx WILL BE IGNORED.)
	kampenv	transeg	0,0.01,0,1,p3-0.01,-8,0	;CREATE A PERCUSSIVE AMPLITUDE ENVELOPE
	asig	vco2	0.3*kampenv,cpsoct(ioct),4,0.5	;CREATE AN AUDIO OSCILLATOR USING vco2 - IN THIS CASE A TRIANGLE WAVE
		out	asig			;SEND AUDIO TO THE MONO OUTPUT
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTR 1 PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
