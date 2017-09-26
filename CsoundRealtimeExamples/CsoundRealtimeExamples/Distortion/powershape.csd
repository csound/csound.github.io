powershape.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL        | WIDTH | HEIGHT | X | Y
		FLpanel	"powershape",   500,    150,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,    0,    22,    100,     25,    5,  5,     0,     1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
idShapeAmount  	FLvalue	" ",	 70,      20,    5,  75
idOutputGain  	FLvalue	" ",	 70,      20,    5, 125

;SLIDERS       					LABEL                 	MIN   | MAX | EXP | TYPE |  DISP        | WIDTH | HEIGHT | X  | Y
gkShapeAmount, ihShapeAmount	FLslider	"Waveshaping Amount",   0,        2,   0,    23,   idShapeAmount,   490,    25,     5,  50
gkOutputGain, ihOutputGain	FLslider	"Output Gain",   	0.0001,  50,  -1,    23,   idOutputGain,    490,    25,     5, 100

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	1,       ihShapeAmount
		FLsetVal_i	1,       ihOutputGain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     200,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        powershape                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'powershape' waveshapes an audio signal by raising it to a   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"variable exponent ('Waveshaping Amount').                    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The opcode is given a value for the maximum expected         ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"amplitude of the input signal. Using this it normalises the  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"input signal before processing and then expands the output to", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"the original amplitude range.                                ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"An output gain control is added to allow for compensating for", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"gain increase or decrease depending on waveshaping amount.   ", 	1,      5,     14,    490,    15,     5, 180

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF ON/OFF SWITCH IS OFF...
	 turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	ain		diskin2		"808loopMono.wav", 1, 0, 1
	ifullscale	=	1	;DEFINE FULLSCALE AMPLITUDE VALUE
	aout 		powershape 	ain, gkShapeAmount , ifullscale	;CREATE POWERSHAPED SIGNAL
	outs		aout * gkOutputGain, aout * gkOutputGain	;SEND AUDIO TO OUTPUTS AND RESCALE USING gkOutputGain SLIDER VARIABLE
endin
		
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT. ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR.
</CsScore>

</CsoundSynthesizer>