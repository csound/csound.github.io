table_tablei_table3.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;				LABEL                    | WIDTH | HEIGHT | X | Y
			FLpanel	"table, tablei, table3",    500,    425,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    150,     30,    0,  0,     0,     1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idloopbegin			FLvalue	" ",       80,     20,    5,  75
idloopend			FLvalue	" ",       80,     20,    5, 125
idspeed				FLvalue	" ",       80,     20,    5, 175
idgain				FLvalue	" ",       80,     20,    5, 400
idporttime			FLvalue	" ",       60,     20,  200,  20

;SLIDERS				            			MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkloopbegin,ihloopbegin		FLslider 	"Loop Begin Point",	0,     1,    0,    23,  idloopbegin,   490,      25,   5,   50
gkloopend,ihloopend		FLslider 	"Loop End Point",	0,     1,    0,    23,  idloopend,     490,      25,   5,  100
gkspeed,ihspeed			FLslider 	"Speed",	        -2,    2,    0,    23,  idspeed,       490,      25,   5,  150
gkgain,ihgain			FLslider 	"Gain",	        	0,     1,    0,    23,  idgain,        490,      25,   5,  375
gkporttime,ihporttime		FLslider 	"Portamento Time",	0,     1,    0,    23,  idporttime,    300,      20, 200,    0

;COUNTERS									MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkfn, ihfn 			FLcount  "Function Table 1=Drums 2=Voice",	1,     2,     1,      1,      2,    140,     25,   355,210,   -1
gkloopfn, ihloopfn 		FLcount  "1=Normal_Looping 2=Fwd_Bwd_Looping", 	1,     2,     1,      1,      2,    140,     25,     5,210,   -1

FLcolor2	 255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,     1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gktabletype, ihtabletype	FLbutBank	12,     1,     3,     30,    75,      5, 280,   -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"table ", 	1,       5,    12,    50,     30,    35, 280
ih		 	FLbox  	"tablei", 	1,       5,    12,    50,     25,    35, 305
ih		 	FLbox  	"table3", 	1,       5,    12,    50,     25,    35, 330

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	ihloopbegin
			FLsetVal_i	1, 	ihloopend
			FLsetVal_i	1, 	ihspeed
			FLsetVal_i	1, 	ihfn
			FLsetVal_i	1, 	ihloopfn 
			FLsetVal_i	0.7, 	ihgain
			FLsetVal_i	0, 	ihporttime

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     520,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           table, tablei, table3 - loop player               ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The example demonstrates the use of the table family of      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"opcodes to playback a sample stored in a GEN01 function      ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"table.                                                       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"It also demonstrates how to create a loop player that        ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"functions slightly differently to the flooper and flooper2   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"opcodes.                                                     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Using table/tablei/table3 to play back audio data is         ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"initially slightly more awkward than using, for example,     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"diskin or loscil, as we need to create a moving pointer      ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"ourselves which will used to read data from the function     ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"table but ultimately it will prove a more flexible and       ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"interesting method. As a case in point, this sound file loop ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"player could not be implemented with the same functionality  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"using diskin, loscil or flooper.                             ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Table, tablei and table3 operate in essentially the same way,", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"the difference being in how they interpolate between values  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"read from the table. Table does not interpolate at all,      ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"tablei implements linear interpolation and table3 implements ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"cubic interpolation. This example allows the user to switch  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"between table, tablei and table3 and observe the differences ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"in sound quality. This will be most noticable when           ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"transposing downwards. Table is computationally fastest but  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"offers the lowest audio quality, and table3 is               ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"computationally slowest but offers the audio highest quality.", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"Increasing the 'Portamento Time' slider from its default     ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"setting of zero applies damping to the rate of change of     ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"values output by 'Loop Begin Point' and 'Loop End Point'. The", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"upshot of this function is that pitch warping effects will   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"ensue when portamento time is greater than zero while        ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"adjusting the 'Loop Begin Point' and 'Loop End Point'        ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"sliders.                                                     ", 	1,      5,     14,    490,    20,     5, 640

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SOUND FILES
;               NUM | INIT_TIME | SIZE | GEN_ROUTINE |  FILE_PATH       | IN_SKIP | FORMAT | CHANNEL(0=ALL_CHANNELS 1=LEFT_CHANNEL)
gifile1	ftgen	0,       0,      524289,       1,       "808loopMono.wav",     0,         4,       0
gifile2	ftgen	0,       0,      524289,       1,       "AndItsAll.wav",       0,         4,       1

;POINTER FUNCTIONS:
giline	ftgen 	0,	    0,      129,          -7,       0, 129, 1		;STRAIGHT LINE - USED FOR POINTER NORMAL LOOPING
gitri	ftgen 	0,	    0,      129,          -7,       0, 65,  1, 65, 0	;TRIANGLE SHAPE - USED FOR POINTER FORWARD-BACKWARD LOOPING

;INSTR | START | DURATION

instr	1
	if	gkOnOff==0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
	 turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING

	kSwitch	changed		gkfn, gkloopfn	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	kporttime	linseg	0, .001, 1, 1, 1	;CREATE A RAMPING UP VARIBLE FOR PORTAMENTO TIME
	kporttime	=	kporttime * gkporttime	;MULTIPLY RAMPING UP VARIABLE FROM THE PREVIOUS LINE BY THE OUTPUT FROM THE 'PORTAMENTO TIME' SLIDER
	kloopbegin	lineto	gkloopbegin, kporttime	;APPLY PORTAMENTO TO THE NAMED VARIABLE
	kloopend	lineto	gkloopend, kporttime	;APPLY PORTAMENTO TO THE NAMED VARIABLE
	ifn		=	i(gkfn)+gifile1-1	; FUNCTION TABLE NUMBER OF SOURCE SOUND
	ifilelen	=	nsamp(ifn)/sr	; LENGTH OF THE SAMPLE IN SECONDS
	kloopbegin	=	kloopbegin * ifilelen	;RESCALE gkloopbegin (RANGE 0-1) TO BE WITHIN THE RANGE 0-FILE_LENGTH. THIS ALLOW THE EASY INTERCHANGE OF SOUND FILES. NEW OUTPUT VARIABLE kloopbegin.
	kloopend	=	kloopend * ifilelen	;RESCALE gkloopend (RANGE 0-1) TO BE WITHIN THE RANGE 0-FILE_LENGTH. THIS ALLOW THE EASY INTERCHANGE OF SOUND FILES. NEW OUTPUT VARIABLE kloopend.
	klooplen	=	kloopend - kloopbegin	;DERIVE LOOP LENGTH FROM LOOP START AND END POINTS
	
	;                       NUMERATOR | DENOMINATOR | SUBSTUTION_VALUE_(IF_DENOMINATOR=0)
	kphasFrq	divz	gkspeed,    klooplen,         .00001
					; THE DIVZ OPCODE IS USED HERE TO PREVENT DIVISIONS BY ZERO (DIVISION BY ZERO MEANS CRASH!)
					; IN SITUATIONS WHERE klooplen=0 (I.E. WHEN kloopend=kloopbegin)
					; IN NORMAL OPERATION kphasFrq=gkspeed/klooplen
					; BUT IF klooplen=0 THEN kphasFrq IS GIVEN THE VALUE SUBSITUTION VALUE .00001
					
	kptr		phasor	kphasFrq	; POINTER IS CREATED WITH FREQUENCY kphasFrq
	
	iloopfn		=	giline+i(gkloopfn)-1				;FUNCTION TABLE THAT DEFINES THE LOOP POINTER MOVEMENT: 'FORWARD' OR 'FORWARD-BACKWARD'
	kphasFrq 	=	(iloopfn = gitri ? kphasFrq*.5 : kphasFrq)	;IF LOOP POINTER MOVEMENT IS 'FORWARD-BACKWARD' THEN POINTER FREQUENCY SHOULD BE HALVED
	
	;OUTPUT		OPCODE	AMPLITUDE | FREQUENCY | FUNCTION_TABLE
	kptr		oscili	1,           kphasFrq,     iloopfn	;CREATE POINTER MOVEMENT
	
	kinskip		=	(kloopbegin < kloopend ? kloopbegin : kloopend)
				;A NEW VARIABLE IS CREATED THAT IS DEPENDENT UPON A CONDITIONAL STATEMENT
				;IF kloopbegin < kloopend THEN kinskip=kloopbegin
				;OTHERWISE kinskip=kloopend
				;IN OTHER WORDS iinskip IS ALWAYS EQUAL TO WHICHEVER IS LESS BETWEEN iloopbegin AND iloopend.
				;THE REASON FOR USING THIS CONDITIONAL IS TO CREATE A TRUE VALUE FOR THE 'NEAREST' LOOP POINT IN THE LOOP
				;THE VARIABLE CREATED, iinskip, IS NEEDED IN THE NEXT LINE
	
	kptr		=	(kptr*abs(klooplen)) + kinskip						
				;kptr IS RESCALED TO MATCH THE LENGTH OF THE LOOP DEFINED BY iloopbegin AND iloopend 
				;AND IS ALSO RESCALED TO COMPESATE FOR ANY 'inskip' INTO THE SOUNDFILE	
	
	aptr		interp	kptr			;a-rate VERSION OF kptr IS CREATED
	if	gktabletype==0	then	;THE NEXT LINE OF CODE CONDITIONALLY EXECUTED IF gktabletype==0 (FLTK 3-WAY SWITCH)
		asig		table	aptr*sr, ifn		;READ GEN01 FUNCTION TABLE USING table OPCODE
	elseif	gktabletype==1	then	;THE NEXT LINE OF CODE CONDITIONALLY EXECUTED IF gktabletype==1 (FLTK 3-WAY SWITCH)
		asig		tablei	aptr*sr, ifn		;READ GEN01 FUNCTION TABLE USING tablei OPCODE
	elseif	gktabletype==2	then	;THE NEXT LINE OF CODE CONDITIONALLY EXECUTED IF gktabletype==2 (FLTK 3-WAY SWITCH)
		asig		table3	aptr*sr, ifn		;READ GEN01 FUNCTION TABLE USING tabl3 OPCODE
	endif
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs	asig * gkgain, asig * gkgain
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>