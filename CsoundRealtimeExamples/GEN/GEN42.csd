GEN42.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

/*///////////////////////////////////////////////////////// FLTK INTERFACE CODE ///////////////////////////////////////////////////////*/
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"GEN42",   500,     200,   0,  0

/*//////////////////////////////////////////////////////////// MAIN CONTROL ///////////////////////////////////////////////////////////*/
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
                                              
;VALUE INPUT BOXES				 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkmin1, ihmin1		FLtext		"Min 1", 	0,    127,  0.01,     1,   100,     20,     5,  50
gkmax1, ihmax1		FLtext		"Max 1", 	0,    127,  0.01,     1,   100,     20,   130,  50
gkmin2, ihmin2		FLtext		"Min 2", 	0,    127,  0.01,     1,   100,     20,     5, 100
gkmax2, ihmax2		FLtext		"Max 2", 	0,    127,  0.01,     1,   100,     20,   130, 100
gkmin3, ihmin3		FLtext		"Min 3", 	0,    127,  0.01,     1,   100,     20,     5, 150
gkmax3, ihmax3		FLtext		"Max 3", 	0,    127,  0.01,     1,   100,     20,   130, 150
;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkprob1, ihprob1	FLcount  	"Prob 1", 	0,    200,   1,      10,     1,     120,      25,  255, 50,   -1 
gkprob2, ihprob2	FLcount  	"Prob 2", 	0,    200,   1,      10,     1,     120,      25,  255,100,   -1 
gkprob3, ihprob3	FLcount  	"Prob 3", 	0,    200,   1,      10,     1,     120,      25,  255,150,   -1 
                 
;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idrate			FLvalue	"",	60,      17,   160,  20
                                                      
;SLIDERS					      		MIN  | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X  | Y
gkrate, ihrate		FLslider	"Note Rate",  		0.2,    10,  -1,    23,  idrate,    335,     15,  160,    5

;INITIALISATION OF VALUATORS	VALUE | HANDLE
		FLsetVal_i	95, 	ihprob1
		FLsetVal_i	25, 	ihprob2
		FLsetVal_i	80, 	ihprob3
		FLsetVal_i	59.8, 	ihmin1
		FLsetVal_i	60.2, 	ihmax1
		FLsetVal_i	63.8, 	ihmin2
		FLsetVal_i	64.2, 	ihmax2
		FLsetVal_i	69.8, 	ihmin3
		FLsetVal_i	70.2, 	ihmax3
		FLsetVal_i	4, 	ihrate

		FLpanel_end	;END OF PANEL CONTENTS

/*//////////////////////////////////////////////// INSTRUCTIONS AND INFO PANEL ///////////////////////////////////////////////////////*/
				FLpanel	" ", 515, 400, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            GEN42                            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"GEN42 works in a similar fashion to GEN41 with the difference", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"that rather than specifying a single value for each          ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"probability zone a minimum and maximum value are specified in", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"each zone. In the histogram created this results in slanted  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"segments. (Note that minimum values do not need to be lower  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"than their corresponding maximum values.)                    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"For further information regarding this example please first  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"examine the example for GEN41.                               ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"Changes to the function table as reflected in the resulting  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"histogram can be observed visually by ensuring that Csound   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"displays are enabled (i.e. by not using the -d flag).        ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"This GEN routine does not appear to function correctly as of ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"writing. I have had to add a 'dummy' fourth zone in order to ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"get the third to work correctly. Proportional re-adjustment  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"does not seem to work either with sometimes a zone of zeroes ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"being left at the end of the table. The best workaround is to", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"observe the table visually as changes are made to ensure the ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"table is filled and reflects the desired results.            ", 	1,      5,     14,    490,    20,     5, 380

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD

/*////////////////////////////////////////////// END OF FLTK INTERFACE CODE ///////////////////////////////////////////////////////////*/

instr	1
	ktrig	changed	       gkmin1,gkmax1,gkprob1,gkmin2,gkmax2,gkprob2,gkmin3,gkmax3,gkprob3	;IF ANY OF THE INPUT VARIABLES ARE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT
	if ktrig=1 then		;IF A TRIGGER HAS BEEN GENERATED. I.E. IF A GUI WIDGET PERTAINING TO THE CREATION OF THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit UPDATE		;...REINITIALISE TABLE CREATION FROM LABEL 'UPDATE'
	  UPDATE:               ;LABEL CALLED UPDATE. REINITIALISATION BEGINS FROM HERE.
	    ;USE OF MINUS SIGN BEFORE GEN ROUTINE NUMBER PREVENTS POST NORMALISATION
	    ;                                                                                                                  *NOTE THE USE OF A DUMMY FOURTH ZONE*
	    gifunc	ftgen	1,0,4096,-42,i(gkmin1),i(gkmax1),i(gkprob1),i(gkmin2),i(gkmax2),i(gkprob2),i(gkmin3),i(gkmax3),i(gkprob3),0,0,0	;CREATE PROBABILITY FUNCTION FROM DATA USING GEN 42
	  rireturn		;RETURN FROM REINITIALISATION PASS TO PERFORMANCE PASS HERE
	endif			;END OF THIS CONDITIONAL BRANCH
	kNoteTrig	metro	gkrate	;A METRONOME TO GENERATE NOTE TRIGGERS
	schedkwhen	kNoteTrig*gkOnOff,0,0,2,0,0.5	;TRIGGER A NOTE IN INSTRUMENT 2 ACCORDING TO THE METRONOME ABOVE AND WHETHER THE ON/OFF BUTTON IS ON
endin                                                                                                     

instr	2
	inote	=	urd(gifunc)			;RANDOMLY READ A VALUE FROM THE HISTOGRAM gifunc
	print	inote					;PRINT NOTE CHOSEN TO THE TERMINAL			
	aenv	expseg	0.001,0.01,1,p3-0.01,0.001	;CREATE A PERCUSSIVE TYPE AMPLITUDE ENVELOPE
	asig	vco2	0.5,cpsmidinn(inote),4,0.5	;CREATE AN AUDIO CHIME USING THE PITCH CHOSEN FROM THE HISTOGRAM
		out	asig*aenv          		;SEND AUDIO TO OUTPUT AND APPLY THE AMPLITUDE ENVELOPE
endin
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTR 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>