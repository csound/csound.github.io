GEN41.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>                 

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH
     
/*///////////////////////////////////////////////////////// FLTK INTERFACE CODE ///////////////////////////////////////////////////////*/
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"GEN41",   500,     200,   0,  0

/*//////////////////////////////////////////////////////////// MAIN CONTROL ///////////////////////////////////////////////////////////*/
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
                                              
;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkval1, ihval1		FLcount  	"Val. 1", 	0,    127,    1,     12,     1,     120,     25,    5, 50,   -1 
gkval2, ihval2		FLcount  	"Val. 2", 	0,    127,    1,     12,     1,     120,     25,    5,100,   -1 
gkval3, ihval3		FLcount  	"Val. 3", 	0,    127,    1,     12,     1,     120,     25,    5,150,   -1 
gkprob1, ihprob1	FLcount  	"Prob 1", 	0,    100,    1,     10,     1,     120,     25,  130, 50,   -1 
gkprob2, ihprob2	FLcount  	"Prob 2", 	0,    100,    1,     10,     1,     120,     25,  130,100,   -1 
gkprob3, ihprob3	FLcount  	"Prob 3", 	0,    100,    1,     10,     1,     120,     25,  130,150,   -1 

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idrate			FLvalue	"",	60,      17,   160,  20
                                                      
;SLIDERS					      		MIN  | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X  | Y
gkrate, ihrate		FLslider	"Note Rate",  		0.2,    10,  -1,    23,  idrate,    335,     15,  160,    5

;INITIALISATION OF VALUATORS	VALUE | HANDLE
		FLsetVal_i	75, 	ihprob1
		FLsetVal_i	5, 	ihprob2
		FLsetVal_i	20, 	ihprob3
		FLsetVal_i	60, 	ihval1
		FLsetVal_i	64, 	ihval2
		FLsetVal_i	70, 	ihval3
		FLsetVal_i	4, 	ihrate

		FLpanel_end	;END OF PANEL CONTENTS

/*//////////////////////////////////////////////// INSTRUCTIONS AND INFO PANEL ///////////////////////////////////////////////////////*/
				FLpanel	" ", 515, 480, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            GEN41                            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"GEN41 can be used to generate histogram type functions than  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"might be useful in algorithmic composition.                  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Values are defined in pairs: first the value and then the    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"probability of its occurence in the table. Each probability  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"is relative to the sum total of all probabilities in the     ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"table. It may be useful to assume a total when designing the ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"table. '1' would be typical when working with probabilities, ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"a total of 100 would imply that the individual values        ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"represent a percentage probability of occurence.             ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"In this example three values and the probabilities of their  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"occurrence can be defined by the user. The author suggests   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"that this GEN routine should be used with opcodes such as    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"'urd', 'duserrnd' and 'cuserrnd' but it can be also be used  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"by other more generic table reading opcodes.                 ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"In this example a random note generator picks notes according", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"to the values and probabilities in the GEN41 function table  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"created. Values are interpretted as MIDI note numbers and    ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"are converted accordingly into frequencies.                  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"If Csound displays are enabled (i.e. if the -d flag is not   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"used) changes to the table can be observed in realtime.       ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"See also GEN40 and GEN42.                                    ", 	1,      5,     14,    490,    20,     5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD

/*////////////////////////////////////////////// END OF FLTK INTERFACE CODE ///////////////////////////////////////////////////////////*/

gifn	ftgen	1,0,4096,-41, 60,75, 64,5, 70,20

instr	1
	ktrig	changed	       gkval1,gkprob1,gkval2,gkprob2,gkval3,gkprob3	;IF ANY OF THE INPUT VARIABLES ARE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT
	if ktrig=1 then		;IF A TRIGGER HAS BEEN GENERATED. I.E. IF A GUI WIDGET PERTAINING TO THE CREATION OF THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit UPDATE		;...REINITIALISE TABLE CREATION FROM LABEL 'UPDATE'
	  UPDATE:               ;LABEL CALLED UPDATE. REINITIALISATION BEGINS FROM HERE.                           
	    ;USE OF MINUS SIGN BEFORE GEN ROUTINE NUMBER PREVENTS POST NORMALISATION
	    gifunc	ftgen	1,0,4096,-41,i(gkval1),i(gkprob1),i(gkval2),i(gkprob2),i(gkval3),i(gkprob3)	;CREATE PROBABILITY FUNCTION FROM DATA USING GEN 41
	  rireturn		;RETURN FROM REINITIALISATION PASS TO PERFORMANCE PASS HERE
	endif			;END OF THIS CONDITIONAL BRANCH
	kNoteTrig	metro	gkrate	;A METRONOME TO GENERATE NOTE TRIGGERS
	schedkwhen	kNoteTrig*gkOnOff,0,0,2,0,0.5	;TRIGGER A NOTE IN INSTRUMENT 2 ACCORDING TO THE METRONOME ABOVE AND WHETHER THE ON/OFF BUTTON IS ON
endin                                                                                                     

instr	2
	inote	=	urd(gifunc)	;RANDOMLY READ A VALUE FROM THE HISTOGRAM gifunc
	print	inote			;PRINT NOTE CHOSEN TO THE TERMINAL
	aenv	expseg	0.001,0.01,1,p3-0.01,0.001	;CREATE A PERCUSSIVE TYPE AMPLITUDE ENVELOPE
	asig	vco2	0.5,cpsmidinn(int(inote)),4,0.5	;CREATE AN AUDIO CHIME USING THE PITCH CHOSEN FROM THE HISTOGRAM
		out	asig*aenv      	;SEND AUDIO TO OUTPUT AND APPLY THE AMPLITUDE ENVELOPE    
endin
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTR 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>