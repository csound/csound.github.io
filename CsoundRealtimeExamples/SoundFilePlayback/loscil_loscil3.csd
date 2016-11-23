loscil_loscil3.csd
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
;				LABEL             | WIDTH | HEIGHT | X | Y
			FLpanel	"loscil loscili",    500,    575,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idbeg1				FLvalue	" ",       80,     20,    5,  75
idend1				FLvalue	" ",       80,     20,    5, 125
idbeg2				FLvalue	" ",       80,     20,    5, 175
idend2				FLvalue	" ",       80,     20,    5, 225
idspeed				FLvalue	" ",       80,     20,    5, 275
idrelease			FLvalue	" ",       80,     20,    5, 325
idgain				FLvalue	" ",       80,     20,    5, 550

;					            				MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkbeg1,ihbeg1			FLslider 	"Loop Beginning 1 (i-rate)",	0,     1,    0,    23,    idbeg1,      490,     25,    5,   50
gkend1,ihend1			FLslider 	"Loop End 1 (i-rate)",	        0,     1,    0,    23,    idend1,      490,     25,    5,  100
gkbeg2,ihbeg2			FLslider 	"Loop Beginning 2 (i-rate)",	0,     1,    0,    23,    idbeg2,      490,     25,    5,  150
gkend2,ihend2			FLslider 	"Loop End 2 (i-rate)",	        0,     1,    0,    23,    idend2,      490,     25,    5,  200
gkspeed,ihspeed			FLslider 	"Speed",	        	0,     2,    0,    23,    idspeed,     490,     25,    5,  250
gkrelease,ihrelease		FLslider 	"Release Time",	        	.001, 15,    0,    23,  idrelease,     490,     25,    5,  300
gkgain,ihgain			FLslider 	"Gain",		        	0,     1,    0,    23,     idgain,     490,     25,    5,  525

;COUNTERS													MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkfn, ihfn 			FLcount  "Function Table 1=Drums 2=Voice (i-rate)",				1,     2,     1,      1,      2,    145,     25,   350,360,   -1
gkmode1, ihmode1 		FLcount  "Sustain_Loop 0=No_Looping 1=Fwd_Looping 2=Fwd_Bwd_Looping (i-rate)", 	0,     2,     1,      1,      2,    145,     25,     5,360,   -1
gkmode2, ihmode2 		FLcount  "Release_Loop 0=No_Looping 1=Fwd_Looping 2=Fwd_Bwd_Looping (i-rate)", 	0,     2,     1,      1,      2,    145,     25,   175,360,   -1

FLcolor2	 255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,     1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gklosciltype, ihlosciltype	FLbutBank	12,     1,     2,     30,      50,    5, 470,   -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"loscil ", 	1,       5,    12,    50,     30,    35, 470
ih		 	FLbox  	"loscil3", 	1,       5,    12,    50,     25,    35, 495

;SET INITIAL VALUES			VALUE | HANDLE
			FLsetVal_i	1, 	ihspeed
			FLsetVal_i	2, 	ihfn
			FLsetVal_i	0, 	ihlosciltype
			FLsetVal_i	1, 	ihmode1
			FLsetVal_i	.37, 	ihbeg1
			FLsetVal_i	.42, 	ihend1
			FLsetVal_i	2, 	ihmode2
			FLsetVal_i	.5, 	ihbeg2
			FLsetVal_i	.55, 	ihend2
			FLsetVal_i	10, 	ihrelease
			FLsetVal_i	0.7, 	ihgain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     520,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        loscil, loscil3                      ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"This example demonstrates the use of loscil/loscil3 to       ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"playback a sample stored in a GEN01 function table. When     ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"designing a sampler type orchestra based upon the            ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"architecture of traditional hardware samplers then           ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"loscil/loscil3 is the best opcode to choose for this task.   ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"Loscil/loscil3 is capable of reading base pitch and sustain  ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"and release looping information stored in the sound file     ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"itself or this information can be passed to the opcode using ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"optional input arguments (as in this example).               ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"Loscil/loscil3 enters the first loop during the sustain      ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"portion of the note and enters the second loop during the    ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"release stage of the note. In order to implement a release   ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"stage an envelope with release mechanism (such as linsegr)   ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"must be used in the same instrument as the loscil/loscil3.   ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"The nature of the sustain and release loops is determined by ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"the two 3-way mode switches. Details of these modes is given ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"in the interface.                                            ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"Loscil3 operates in a similar fashion to loscil with the     ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"difference that it performs cubic interpolation between      ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"samples. This example allows the user to switch between      ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"loscil and loscil3 and here the difference in sound quality  ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"that they offer. Loscil3 is computationally slower but offers", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"a higher quality of sound, particularly when a sound is      ", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"transposed downwards.                                        ", 	1,      5,     14,    490,     20,    5, 500

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
	turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING

	kSwitch		changed	gkfn, gkbeg1, gkend1, gkbeg2, gkend2, gkrelease, gkmode1, gkmode2	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	ifn		=	i(gkfn)		; FUNCTION TABLE NUMBER OF SOURCE SOUND
	ifilelen	=	nsamp(ifn)	; LENGTH OF THE SAMPLE IN SAMPLES

	ibeg1		=	ifilelen * i(gkbeg1)
	iend1		=	ifilelen * i(gkend1)
	ibeg2		=	ifilelen * i(gkbeg2)
	iend2		=	ifilelen * i(gkend2)
	
	aenv		linsegr	0, (.01), 1, i(gkrelease), 0
	
	asigloscil	loscil	aenv, gkspeed, ifn, 1, i(gkmode1), ibeg1, iend1, i(gkmode2), ibeg2, iend2	;READ GEN01 FUNCTION TABLE USING loscil OPCODE
	asigloscil3	loscil3	aenv, gkspeed, ifn, 1, i(gkmode1), ibeg1, iend1, i(gkmode2), ibeg2, iend2	;READ GEN01 FUNCTION TABLE USING loscil3 OPCODE
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES

			if	gklosciltype==0	then	;THE NEXT LINE OF CODE CONDITIONALLY EXECUTED IF gklosciltype==0 (FLTK 3-WAY SWITCH)
	asig		=	asigloscil		;ASSIGN THE AUDIO SIGNAL asigloscil TO THE AUDIO VARIABLE asig
			elseif	gklosciltype==1	then	;THE NEXT LINE OF CODE CONDITIONALLY EXECUTED IF gklosciltype==1 (FLTK 3-WAY SWITCH)
	asig		=	asigloscil3		;ASSIGN THE AUDIO SIGNAL asigloscil3 TO THE AUDIO VARIABLE asig
			endif
	outs	asig * gkgain, asig * gkgain
endin

</CsInstruments>

<CsScore>
; NUM | INIT_TIME | SIZE | GEN_ROUTINE |  FILE_PATH   | IN_SKIP | FORMAT | CHANNEL
f  1      0        524289       -1      "808loopMono.wav"   0         4         0
f  2      0        262145       -1      "AndItsAll.wav"     0         4         0
f 101	    0      129          -7       0 129 1	;STRAIGHT LINE - NORMAL LOOPING
f 102	    0      129          -7       0 65 1 65 0	;TRIANGLE SHAPE - FORWARD BACKWARD LOOPING
;INSTR | START | DURATION
f       0       3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>