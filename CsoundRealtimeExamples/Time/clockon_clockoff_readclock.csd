clockon_clockoff_readclock.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

FLcolor	255, 255, 255, 255, 255, 50	;SET INTERFACE COLOURS
;			LABEL                        | WIDTH | HEIGHT | X | Y
		FLpanel	"clockon clockoff readclock",   500,     80,   0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkClock,ihClock			FLbutton	"Clock 0",	1,   -1,    22,     80,     25,   10,  5,    -1
gkClock,ihClock			FLbutton	"Clock 1",	2,   -2,    22,     80,     25,   90,  5,    -1
gkClock,ihClock			FLbutton	"Clock 2",	3,   -3,    22,     80,     25,  170,  5,    -1
gkClock,ihClock			FLbutton	"Clock 3",	4,   -4,    22,     80,     25,  250,  5,    -1
gkClock,ihClock			FLbutton	"Clock 4",	5,   -5,    22,     80,     25,  330,  5,    -1
gkClock,ihClock			FLbutton	"Clock 5",	6,   -6,    22,     80,     25,  410,  5,    -1
gkRead,ihRead			FLbutton	"Read",		0,    0,    21,     80,     25,   10, 30,    0,      3,      0,      0.001
gkRead,ihRead			FLbutton	"Read",		1,    1,    21,     80,     25,   90, 30,    0,      3,      0,      0.001
gkRead,ihRead			FLbutton	"Read",		2,    2,    21,     80,     25,  170, 30,    0,      3,      0,      0.001
gkRead,ihRead			FLbutton	"Read",		3,    3,    21,     80,     25,  250, 30,    0,      3,      0,      0.001
gkRead,ihRead			FLbutton	"Read",		4,    4,    21,     80,     25,  330, 30,    0,      3,      0,      0.001
gkRead,ihRead			FLbutton	"Read",		5,    5,    21,     80,     25,  410, 30,    0,      3,      0,      0.001
;VALUE INPUT/DISPLAY BOXES		MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkTime0, gihTime0	FLtext	"", 	0,    100,    0,    1,      80,     20,   10,  55
gkTime1, gihTime1	FLtext	"", 	0,    100,    0,    1,      80,     20,   90,  55
gkTime2, gihTime2	FLtext	"", 	0,    100,    0,    1,      80,     20,  170,  55
gkTime3, gihTime3	FLtext	"", 	0,    100,    0,    1,      80,     20,  250,  55
gkTime4, gihTime4	FLtext	"", 	0,    100,    0,    1,      80,     20,  330,  55
gkTime5, gihTime5	FLtext	"", 	0,    100,    0,    1,      80,     20,  410,  55

		FLpanel_end	;END OF PANEL CONTENTS


		FLpanel	"info", 515, 280, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                clockon clockoff readclock                   ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'clockon', 'clockoff' and 'readclock' are used to turn on,   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"turn off and read from one of 32 available internal          ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"accumulating clocks.                                         ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Clock precision is system dependent.                         ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"A clock must be started and then stopped before it can be    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"read from.                                                   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Each clock accumulates for as long as they are active. If a  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"clock is restarted it does not reset but instead accumulates ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"onto the previous value for that clock. There is no way      ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"(other than retarting performance) to reset a clock.         ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"In this example six independent clocks are accessed which can", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"be started, stopped and read from using the on-screen GUI.   ", 	1,      5,     14,    490,    20,     5, 260
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD

/*////////////////////////////////////////////// END OF FLTK INTERFACE CODE ///////////////////////////////////////////////////////////*/

instr	1	;SENSES CHANGES WITH FLTK BUTTONS
	ktrig	changed	gkClock				;IF ONE OF THE CLOCK ARE STARTED OR STOPPED FROM THE GUI BUTTONS GENERATE A TRIGGER IMPULSE (A MOMENTARY '1' AT THE OUTPUT.
	schedkwhen	ktrig,0,0,2,0,0.01,gkClock	;INSTRUCT INSTR 2 TO PLAY A SHORT NOTE. P4 = THE VALUE OUTPUT BY THE MOST RECENTLY CLICKED ON-SCREEN BUTTON, I.E. CLOCK NUMBER. 
endin

instr	2	;STARTS OR STOPS THE APPROPRIATE INTERNAL CLOCK
	if p4>0 then			;IF p4 IS POSITIVE, I.E. IF BUTTON HAS BEEN SWITCHED ON...
		clockon		p4-1	;TURN THE RELEVANT CLOCK ON
	else				;OTHERWISE...
		clockoff	(-p4)-1	;TURN THE RELEVANT CLOCK OFF
	endif				;END OF CONDITIONAL BRANCH
endin

instr	3	;READ A CLOCK
	itim	readclock	i(gkRead)		;READ THE RELEVANT CLOCK
		FLsetVal_i	itim, gihTime0+i(gkRead);WRITE TO THE RELEVANT FLtext BOX
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTR 1 PLAYS A NOTE FOR 1 HOUR, AND KEEPS PERFORMANCE GOING
</CsScore>

</CsoundSynthesizer>