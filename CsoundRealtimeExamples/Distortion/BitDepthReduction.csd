BitDepthReduction.csd
Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;		LABEL                  | WIDTH | HEIGHT | X | Y
	FLpanel	"Bit Depth Reduction",    500,    220,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,    0,    22,    100,     25,    5,  5,     0,     1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idbitdepth		FLvalue	" ",      70,      20,    5,  95
idInGain		FLvalue	" ",      70,      20,    5, 145
idOutGain		FLvalue	" ",      70,      20,    5, 195

;SLIDERS				            	MIN | MAX | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X  | Y
gkbitdepth, ihbitdepth	FLslider	"Bit Depth",  	0,    16,    0,   23,   idbitdepth,   490,     25,    5,   70
gkInGain,ihInGain	FLslider 	"Input Gain",	0,     1,    0,   23,   idInGain,     490,     25,    5,  120
gkOutGain,ihOutGain	FLslider 	"Output Gain",	0,     5,    0,   23,   idOutGain,    490,     25,    5,  170

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
		FLsetVal_i	   16, 	ihbitdepth
		FLsetVal_i	   1,  	ihInGain
		FLsetVal_i	   1,  	ihOutGain
		FLsetVal_i	   1,  	ihinput

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      160,  512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"              Artificial Bit Depth Reduction                 ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example uses a mathematical quantizing procedure upon an", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"audio signal to create the effect of lower bit depth sample  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"storage.                                                     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Input and output gain controls allow separate control of the ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"amplitude going into and coming out of the bit depth         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"reduction procedure.                                         ", 	1,      5,     14,    490,    15,     5, 140
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

opcode	BitDepthReduce,a,ak
	asig,kbitdepth	xin
	setksmps	1
	kvalues		pow		2, kbitdepth	;RAISES 2 TO THE POWER OF kbitdepth. THE OUTPUT VALUE REPRESENTS THE NUMBER OF POSSIBLE VALUES AT THAT PARTICULAR BIT DEPTH
	ksig		downsamp	asig
	ksig		=		(int((ksig/0dbfs)*kvalues))/kvalues
	asig		upsamp	ksig
			xout	asig
endop

instr 1
	if	gkOnOff=0	then	;IF ON/OFF SWITCH IS OFF...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	if		gkinput=0	then					;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
		asig		diskin2		"AndItsAll.wav", 1, 0, 1	;READ IN SOUND FILE FROM DISK
	elseif		gkinput=1	then					;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
		asig		diskin2		"808loopmono.wav", 1, 0, 1	;READ IN SOUND FILE FROM DISK
	elseif		gkinput=2	then					;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
		asig	inch		1					;READ THE COMPUTER'S LIVE AUDIO INPUT
	endif									;END OF if... BRANCHING
	asig		BitDepthReduce	asig*gkInGain,gkbitdepth
			out		asig*gkOutGain
endin
		
</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>