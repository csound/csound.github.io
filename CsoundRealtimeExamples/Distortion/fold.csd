fold.csd
Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;		LABEL   | WIDTH | HEIGHT | X | Y
	FLpanel	"fold",    500,    170,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,    0,    22,    100,     25,    5,  5,     0,     1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idincr			FLvalue	" ",      70,      20,    5,  95
idgain			FLvalue	" ",      70,      20,    5, 145

;SLIDERS				            	MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X  | Y
gkincr, ihincr		FLslider	"Foldover",  	1,   1024,  -1,    23,   idincr,   490,     25,    5,  70
gkgain,ihgain		FLslider 	"Output Gain",	0,     2,    0,    23,   idgain,   490,     25,    5, 120

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput, ihinput	FLbutBank	4 ,     1,     3,     18,      60,   150, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Voice     ", 		1,       5,    12,    70,      18,   170,   0
ih		 	FLbox  	"Drums     ", 		1,       5,    12,    70,      18,   170,  20
ih		 	FLbox  	"Live Input", 		1,       5,    12,    70,      18,   170,  40

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	   1,  	ihincr
		FLsetVal_i	   1,  	ihgain
		FLsetVal_i	   1,  	ihinput

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      240,  512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           fold                              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The opcode 'fold' adds artificial foldover to an audio       ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"signal. This gives the effect of downsampling the audio      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"signal to a lower sampling rate. Without interpolating       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"between audio samples this produces a distinctive degrading  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"of of the signal.                                            ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"The amount of foldover is expressed as a multiple of the     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"sampling rate therefore a value of 1 will produce no         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"foldover, avalue of 2 will produce the effect of downsampling", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"to 22050Hz (from 44100), a value of 4 will produce the effect", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of downsampling to 11025 and so on.                          ", 	1,      5,     14,    490,    15,     5, 220
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
instr 1
	if	gkOnOff=0	then	;IF ON/OFF SWITCH IS OFF...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	if		gkinput=0	then					;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
		asig		diskin2		"AndItsAll.wav", 1, 0, 1	;READ IN SOUND FILE FROM DISK
	elseif		gkinput=1	then					;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
		asig		diskin2		"808loopmono.wav", 1, 0, 1	;READ IN SOUND FILE FROM DISK
	elseif		gkinput=2	then					;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
		asig		inch		1				;READ THE COMPUTER'S LIVE AUDIO INPUT
	endif									;END OF if... BRANCHING
	afold 	fold 		asig, gkincr					;APPLY SAMPLING RATE FOLDOVER
		outs		afold * gkgain, afold * gkgain			;SEND AUDIO TO OUTPUTS AND RESCALE USING gkgain SLIDER VARIABLE
endin
		
</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>



























