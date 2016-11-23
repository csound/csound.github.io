flooper_flooper2.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL     | WIDTH | HEIGHT | X | Y
		FLpanel	"flooper2",  500,    445,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idloopstart			FLvalue	" ",     100,    20,     5, 125
idloopend			FLvalue	" ",     100,    20,     5, 175
idpitch				FLvalue	" ",     100,    20,     5, 225
idcrossfade			FLvalue	" ",     100,    20,     5, 275
idstart				FLvalue	" ",     100,    20,     5, 325
idamp				FLvalue	" ",     100,    20,     5, 375

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkloopstart,ihloopstart		FLslider 	"Loop Start",			0,     1,    0,    23,  idloopstart,   490,     25,    5, 100
gkloopend,ihloopend		FLslider 	"Loop End",			0,     1,    0,    23,  idloopend,     490,     25,    5, 150
gkpitch,ihpitch			FLslider 	"Pitch",			.25,   4,   -1,    23,  idpitch,       490,     25,    5, 200
gkcrossfade,ihcrossfade		FLslider 	"Crossfade (seconds)",		0,     1,    0,    23,  idcrossfade,   490,     25,    5, 250
gkstart,ihstart			FLslider 	"Start Position (i-rate)",	0,     1,    0,    23,  idstart,       490,     25,    5, 300
gkamp,ihamp			FLslider 	"Amplitude",			0,     1,    0,    23,  idamp,         490,     25,    5, 350

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gkfn, ihfn 			FLcount  "Soundfile", 		1,     2,     1,      1,      2,    145,     25,   175,   5,   -1
gkmode, ihmode 			FLcount  "Loop Mode (i-rate)", 	0,     2,     1,      1,      2,    145,     25,   350,   5,   -1

;TEXT BOXES              					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "1=808loop.wav 2=AndItsAll.wav", 	1,     9,      12,   150,     30,    175, 50
ih		 FLbox  "0=forward 1=backward 2=back-and-forth",1,     9,      12,   150,     30,    350, 50

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR
gkopcode, ihopcode	FLbutBank	14,     1,     2,     20,      40,   65,  401,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Opcode:", 	1,       5,    14,     60,      20,   5, 400
ih		 	FLbox  	"flooper ",	1,       5,    14,     75,      20,  80, 400
ih		 	FLbox  	"flooper2", 	1,       5,    14,     75,      20,  80, 420

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0, 	ihloopstart
		FLsetVal_i	1, 	ihloopend
		FLsetVal_i	1, 	ihpitch
		FLsetVal_i	.001, 	ihcrossfade
		FLsetVal_i	1, 	ihfn
		FLsetVal_i	0, 	ihstart
		FLsetVal_i	0.5, 	ihamp
		FLsetVal_i	1, 	ihopcode

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 640, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       flooper flooper2                      ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'flooper2' plays a sound file with a user definable loop.    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Loop start and end points can be changed at k-rate (i.e.     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"while the loop is already playing).                          ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Pitch is defined as a ratio of the original pitch of the     ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"sample. I.e. a pitch value of 1 plays the soundfile back at  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"its original speed, a pitch value of 2 plays it back at twice", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"its original speed, a pitch value of 0.5 plays it back at    ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"half its original speed and so on...                         ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The start position parameter allows the user to specify from ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"where the soundfile will begin playback, i.e. before entering", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"looping.                                                     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"In the opcode definition loop start and end points and start ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"time are given in seconds. For convenience in this example   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"the relevant sliders define these parameters as fractions of ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"the entire duration of the soundfile. (Subsequent rescaling  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"is done within the instrument code.) This allows the user to ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"swap between sound files of differing lengths without the    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"need to re-adjust the FLTK slider ranges.                    ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"The source sound for flooper2 should be stored in a GEN01    ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"function table.                                              ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"A parameter is provided to define a crossfade time for when  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"the file loops. Note that crossfade times are limited to the ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"current duration of the loop.                                ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"Three looping modes are offered. Details are provided in the ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"interface opposite.                                          ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"This example allows the user to choose between two source    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"samples.                                                     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"'flooper' is a simpler version of 'flooper2' in which loop   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"points are only editable at i-rate. Loop mode is not an      ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"option with 'flooper'.                                       ", 	1,      5,     14,    490,    20,     5, 620

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; THE SOUND FILES USED
; 		NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH     | IN_SKIP | FORMAT | CHANNEL
gifn1	ftgen	0,        0,     524288,      1,      "808loop.wav",       0,       4,       1 
gifn2	ftgen	0,        0,     524288,      1,      "AndItsAll.wav",     0,       4,       1 

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
	turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING

	kSwitch		changed	gkfn, gkstart, gkmode	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	ifn		=	gifn1+i(gkfn)-1
	ifilelength	=	nsamp(ifn)/sr
	kloopstart	=	ifilelength*gkloopstart
	kloopend	=	ifilelength*gkloopend
	if gkopcode==0 then
	  asig 		flooper	gkamp, gkpitch, i(gkloopstart)*ifilelength, (i(gkloopend)-i(gkloopstart))*ifilelength, i(gkcrossfade), ifn
	else
	  asig 		flooper2 gkamp, gkpitch, kloopstart, kloopend, gkcrossfade, ifn, i(gkstart), i(gkmode);, ifenv, iskip
	endif
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs		asig, asig
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>