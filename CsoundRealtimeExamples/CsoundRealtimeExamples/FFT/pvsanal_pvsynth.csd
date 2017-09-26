;Written by Iain McCurdy, 2007

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                 | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsanal and pvsynth",   500,    120,    0,  0

;SWITCHES  	                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    120,     25,    5,  5,    0,     1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
idGain			FLvalue	" ",     50,     18,      5,  85

;SLIDERS					            	MIN |  MAX | EXP | TYPE | DISP    | WIDTH | HEIGHT | X | Y
gkGain,ihGain			FLslider 	"Gain",		0,      1,    0,    23,   idGain,    490,     25,    5,  60

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput	FLbutBank	14,     1,     2,     30,     40,    175,  0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input ", 		1,       5,    12,    80,      20,   205,   0
ih		 	FLbox  	"Stored File", 		1,       5,    12,    80,      20,   205,  20

;SET INITIAL VALUES FOR SLIDERS 	VALUE | HANDLE
			FLsetVal_i	0.5, 	ihGain
			FLsetVal_i	1, 	ihinput
                                                
			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     460,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                  pvsanal and pvsynth                        ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Pvsanal and pvsynth are two of the core opcodes used when    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"when working with streaming phase vocoding analysis in       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Csound.                                                      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Pvsanal is used to create a streaming FFT analysis signal of ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"an audio signal input. It outputs an 'fsig' signal which can ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"be read and modified by Csound's streaming FFT opcodes.      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Pvsynth is the compliment to pvsanal in that it takes an fsig", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"signal and reynthesises it into an audio signal.             ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"This example is rather undramatic in that it merely takes an ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"audio signal (either the live input or a stored sound file), ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"converts it into an fsig, and then resynthesises it back into", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"its initial state as an audio signal. Normally, as           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"demonstrated in subsequent examples, further processing of   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"the fsig would be applied before the resynthesis.            ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Pvsanal also allows the user to make settings for aspects of ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"the analysis such as window size, window type, FFT size and  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"overlap but these setting should normally hard set into the  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"code and left unchanged. The settings used in this example   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"represent a good default setting. For further information    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"regarding these parameters refer to the Csound Reference     ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"Manual.                                                      ", 	1,      5,     14,    490,    15,     5, 440

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 	1
	if		gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if		gkinput=1 then			;IF 'INPUT' SWITCH IS SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"AndItsAll.wav",    1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		asig		inch		1				;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
	endif
	;OUTPUT		OPCODE		INPUT | IFFTSIZE | IOVERLAP | IWINSIZE | IWINTYPE [, IFORMAT] [, IINIT]
	fsig  		pvsanal		asig,    1024,      256,       1024,        1	;ANALYSE THE AUDIO SIGNAL AND CREATE AN 'F' SIGNAL (OPTIONAL INPUT ARGUMENTS ARE OMITTED)
	;OUTPUT		OPCODE		INPUT
	aresyn 		pvsynth  	fsig                      	;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
			outs		aresyn * gkGain, aresyn * gkGain	;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS AND RESCALE GAIN USING ON-SCREEN SLIDER
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REAL TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>