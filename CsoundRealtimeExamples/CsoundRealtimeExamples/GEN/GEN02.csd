GEN02.csd
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
				FLpanel	"GEN02",  500,    100,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkindex, gihindex	FLtext		"Index", 	0,     7,    0,     1,     50,     20,     350,  5

;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkval0, ihval0		FLcount  	"Val. 0", 	0,    127,   1,     12,     2,      70,      20,    5, 50,   -1 
gkval1, ihval1		FLcount  	"Val. 1", 	0,    127,   1,     12,     2,      70,      20,   75, 50,   -1 
gkval2, ihval2		FLcount  	"Val. 2", 	0,    127,   1,     12,     2,      70,      20,  145, 50,   -1 
gkval3, ihval3		FLcount  	"Val. 3", 	0,    127,   1,     12,     2,      70,      20,  215, 50,   -1 
gkval4, ihval4		FLcount  	"Val. 4", 	0,    127,   1,     12,     2,      70,      20,  285, 50,   -1 
gkval5, ihval5		FLcount  	"Val. 5", 	0,    127,   1,     12,     2,      70,      20,  355, 50,   -1 
gkval6, ihval6		FLcount  	"Val. 6", 	0,    127,   1,     12,     2,      70,      20,  425, 50,   -1 

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	60, 	ihval0
				FLsetVal_i	62, 	ihval1
				FLsetVal_i	64, 	ihval2
				FLsetVal_i	65, 	ihval3
				FLsetVal_i	67, 	ihval4
				FLsetVal_i	69, 	ihval5
				FLsetVal_i	71, 	ihval6
			                                                           
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN02                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"GEN02 allows us to explicitly define the values stored within", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"a function table one by one.                                 ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"In this example a table that stores just seven values is     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"created. These values will be interpretted as MIDI note      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"numbers and are played as a note row in cyclical fashion.    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"If a value is zero, this is taken as an instruction to return", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"to the beginning of the row before reaching the end.         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"By prepending function table size (p3) with a minus sign this", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"allows us to use non power of 2 function table sizes. Note   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"that not all opcodes that make use of function tables will   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"work with non-power of 2 sizes but most now do.              ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"It is also important in this example to prepend the GEN      ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"routine number (p4) with a minus sign as otherwise the entire", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"table will be rescaled (normalised) so that the largest      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"absolute value stored does not exceed 1. There are some      ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"situations where normalisation is useful.                    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Values are numbered starting at zero as this is how they are ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"addressed using the 'table' opcode's index. The last value in", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"a table of size 7 will be addressed by an index of value 6.  ", 	1,      5,     14,    490,    15,     5, 400

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giindex	init	0	;SET INITIAL VALUE OF THE INDEX WHICH WILL BE USED AS A POINTER TO READ VALUES FROM THE FUCNTION TABLE

instr	1	;UPDATES FUNCTION TABLE
	ktrig	changed	gkval0,gkval1,gkval2,gkval3,gkval4,gkval5,gkval6	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS.
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE CREATION HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO REBUILD THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. REINITIALISATION PASS BEGINS FROM HERE.
	  ;CREATE THE GEN02 NOTE ROW. NOTE THE USE OF A MINUS SIGN BEFORE THE TABLE SIZE (P3) IN ORDER TO PERMIT A NON POWER OF 2 FUNCTION TABLE SIZE.
	  ;THE MINUS SIGN BEFORE THE GEN ROUNTINE NUMBER (P4) IS TO ENSURE THAT VALUES WITHIN THE TABLE WON'T BE NORMALISED TO LIE WITHIN THE RANGE -1 TO 1.
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE.
	  ginotes	ftgen	1,0,-7,-2,i(gkval0),i(gkval1),i(gkval2),i(gkval3),i(gkval4),i(gkval5),i(gkval6)	;CREATE THE FUNCTION TABLE
	  rireturn				;RETURN FROM REINITIALISATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH
	knotetrig	metro	3		;CREATE A TRAIN OF IMPULSES WITH WHICH TO TRIGGER NOTES
	schedkwhen	knotetrig*gkOnOff,0,0,2,0,0.4	;TRIGGER A NOTE IN INSTRUMENT 2 BUT ONLY IF ON/OFF SWITCH IS ON WHILE A TRIGGER IS RECEIVED
endin

instr	2	;PLAYS NOTES
	aampenv	expsega	0.001,0.01,1,p3-0.01,0.001		;DEFINE A PERCUSSIVE AMPLITUDE ENVELOPE
	inote	table	giindex,ginotes				;READ NOTE VALUE (MIDI NOTE NUMBER) FROM TABLE
	if inote=0 then						;IF NOTE VALUE IS ZERO...
	  giindex=0						;...RESET COUNTER TO ZERO (THE BEGINNING)...
	  inote	table	giindex,ginotes				;...AND READ THE NOTE VALUE THERE
	endif							;END OF THIS CONDITIONAL BRANCH
	FLsetVal_i	giindex,gihindex			;WRITE THE INDEX VALUE TO THE FLTK VALUE BOX
	giindex wrap	giindex+1,0,ftlen(ginotes)		;INCREMENT THE INDEX ONE STEP. WRAPAROUND WITHIN THE LIMITS OF THE TABLE IF REQUIRED.
	asig	vco2	0.3,cpsmidinn(inote),4,0.5	;CREATE AN AUDIO OSCILLATOR USING vco2 - IN THIS CASE A TRIANGLE WAVE. MIDI NOTE VALUE IS CONVERTED TO CPS FORMAT   
		out	asig*aampenv			;SEND AUDIO TO THE MONO OUTPUT
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>
