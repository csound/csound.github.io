mpulse_dust2_gausstrig.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL                     | WIDTH | HEIGHT | X | Y
		FLpanel	"mpulse/dust2/gausstrig",    500,    250,    0,  0

;SWITCHES                                              		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkmpulse,ih		FLbutton	"mpulse On/Off",	1,    0,    22,    130,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ih	;SET SECONDARY COLOUR TO YELLOW
gkdust2,ih		FLbutton	"dust2 On/Off",		1,    0,    22,    130,     25,  140,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ih	;SET SECONDARY COLOUR TO YELLOW
gkgausstrig,ih		FLbutton	"gausstrig On/Off",	1,    0,    22,    130,     25,  275,  5,    0,      3,      0,      -1
FLsetColor2	255, 255, 50, ih	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			iwidth iheight ix,  iy
idamp			FLvalue	" ",	70,    20,   5,  75
idFreqDens		FLvalue	" ",	70,    20,   5, 125
iddev			FLvalue	" ",	70,    20,   5, 175

;SLIDERS					     				MIN | MAX | EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider	"Amplitude",			0,     1,     0,    23,  idamp,        490,     25,    5,  50
gkFreqDens, ihFreqDens		FLslider	"Freq. / Density",		0.1,10000,   -1,    23,  idFreqDens,   490,     25,    5, 100
gkdev, ihdev			FLslider	"Deviation (gausstrig)",	0,     10,    0,    23,  iddev,        490,     25,    5, 150
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkmode, ihmode 			FLcount  "gausstrig mode", 	0,     1,    1,       1,     2,     140,     25,    5, 200,    -1

;INITIALISATION
FLsetVal_i	0.2, 	ihamp
FLsetVal_i	10, 	ihFreqDens
FLsetVal_i	1, 	ihdev

FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	"Info.", 515, 640, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                  mpulse / dust2 /gausstrig                  ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'mpulse', 'dust2' and 'gausstrig' can be used to generate    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"impulses. 'dust2' and 'gausstrig' can output either an a-rate", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"or a k-rate signal, 'mpulse' operates only at a rate.        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The impulses can be used as audio signals, when a-rate output", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"is used, or as triggers for subsequent opcodes when k-rate is", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"used. In this case the opcode outputs are simply sent to the ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"speakers as audio signals but further processing, for example", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"by filtering, is suggested.                                  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"'mpulse' simply outputs a train of impulses each separated by", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"time gap defined as 1/'Freq.'. Each impulse is of the same   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"value as defined by 'Amplitude'.                             ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'dust2' generates impulses within the range -Amplitude to    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"+Amplitude. 'Density' defines the average number of impulses ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"per second. There is also an opcode called 'dust' which      ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"generates unipolar impulses in the range zero to +Amplitude. ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"'gausstrig' generates random impulses with a gaussian        ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"distribution around a specified frequency. Impulses have a   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"fixed amplitude as defined by the 'Amplitude' slider. The    ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"extent of the deviation is controlled used the deviation     ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"slider. There are two modes of operation: in mode zero       ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"impulse generation is a continuous process of defining time  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"gaps to the next impulse, this means that if the frequency is", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"low but then increased dramatically the frequency of impulse ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"generation will not increase until the (long) time gap to the", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"next impulse as was defined by the low frequency is          ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"completed. In mode 1 the impulse generator is effectively    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"restarted when 'Freq.' is changed thereby preventing the     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"generator from getting 'stuck' at a low frequency. To        ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"demonstrate this mechanism the minimum value for the 'Freq.  ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"Density' slider is very low.                                 ", 	1,      5,     14,    490,    20,     5, 620
				FLpanel_end

FLrun		;RUN THE WIDGET THREAD

instr     1	;dust
	if gkmpulse=0	then			;...IF 'On/Off' BUTTON IS 'OFF'...
		turnoff				;...TURNOFF THIS INSTRUMENT IMMEDIATLEY
	endif					;END OF CONDIIONAL BRANCHING
	kporttime	linseg	0,0.01,0.01	;PORTAMENTO TIME RAMPS QUICK UP FROM ZERO TO A FIXED VALUE
	kFreqDens	portk	gkFreqDens,kporttime	;SMOOTH CHANGES TO THE VARIABLE gkFreqDens
	asig	mpulse	gkamp, 1/kFreqDens	;GENERATE 'mpulse' IMPULSES, N.B. 1/FREQUENCY = TIME_GAP
		out	asig			;SEND AUDIO TO OUTPUT
endin

instr     2	;dust2
	if gkdust2=0	then			;...IF 'On/Off' BUTTON IS 'OFF'...
		turnoff				;...TURNOFF THIS INSTRUMENT IMMEDIATLEY
	endif					;END OF CONDIIONAL BRANCHING
	asig	dust2	gkamp, gkFreqDens	;GENERATE 'dust2' IMPULSES
		out	asig			;SEND AUDIO TO OUTPUT
endin

instr	3	;gausstrig
	if gkgausstrig=0	then			;...IF 'On/Off' BUTTON IS 'OFF'...
		turnoff				;...TURNOFF THIS INSTRUMENT IMMEDIATLEY
	endif					;END OF CONDIIONAL BRANCHING
	ktrig	changed		gkmode		;IF gkmode COUNTER IS CHANGED GENERATE A MOMENTARY '1' IMPULSE
	if ktrig==1 then			;THEREFORE IF gkmode HAS BEEN CHANGED...
	 reinit	UPDATE				;BEGIN A REINITIALISATION PASS AT LABEL 'UPDATE'
	endif					;END OF CONDITIONAL BRANCH
	UPDATE:					;LABEL 'UPDATE'. REINITIALISATION BEGINS FROM HERE.
	asig	gausstrig	gkamp, gkFreqDens, gkdev, i(gkmode)	;GENERATE GAUSSIAN TRIGGERS
	rireturn				;RETURN FROM REINITIALISATION PASS
		out	asig			;SEND AUDIO TO OUTPUT
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>