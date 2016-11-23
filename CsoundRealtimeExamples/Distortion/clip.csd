clip.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL  | WIDTH | HEIGHT | X | Y
		FLpanel	"clip",   500,    260,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,     0,     1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
idlimit      	FLvalue	" ",	 70,      20,    5,  75
idarg		FLvalue	" ",	 70,      20,    5, 125
idpostgain	FLvalue	" ",	 70,      20,    5, 240

;            				LABEL                 			MIN    |  MAX | EXP | TYPE |  DISP      | WIDTH | HEIGHT | X  | Y
gklimit, ihlimit	FLslider	"Limit",                 		0.0001,    1,   -1,    23,   idlimit,      490,    25,     5,  50
gkarg,iharg		FLslider	"Clipping Point (B.d.J Method only)",	0,         1,    0,    23,   idarg,        490,    25,     5, 100
gkpostgain,ihpostgain	FLslider	"Post Gain",        	 		1,      1000,   -1,    23,   idpostgain,   490,    25,     5, 215

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkmeth, ihmeth	FLbutBank	 13,     1,     3,      18,     60,   55, 150,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Method:",		1,       6,    12,    45,      25,     7, 147
ih		 	FLbox  	"Bram de Jong", 	1,       5,    12,    85,      25,    75, 147
ih		 	FLbox  	"Sine        ", 	1,       5,    12,    85,      25,    75, 167
ih		 	FLbox  	"Tanh        ", 	1,       5,    12,    85,      25,    75, 187

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	0.001,   ihlimit
		FLsetVal_i	0.5,     iharg
		FLsetVal_i	0,       ihmeth
		FLsetVal_i	100,     ihpostgain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     260,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            clip                             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The 'clip' opcode provides audio signal soft clipping using  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"one of three different methods.                              ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"'Limiting Value' defines the maximum amplitude that will be  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"passed unclipped. In this example maximum amplitude has been ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"defined as '1' therefore, in this instance, this value ranges", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"up to 1.                                                     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"'Clipping Point' defines the point at which clipping starts  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"and is only ised in the Bram de Jong method.                 ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"A 'Post Gain' control is included so that the user can       ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"compensate for the loss of gain that occurs when the signal  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"is clipped.                                                  ", 	1,      5,     14,    490,    15,     5, 240

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if gkOnOff=0	then		;...IF 'On/Off' BUTTON IS 'OFF'...
		turnoff			;...TURNOFF THIS INSTRUMENT IMMEDIATLEY
	endif				;END OF CONDIIONAL BRANCHING
	asig		diskin2		"808loopMono.wav", 1, 0, 1
	kSwitch		changed		gklimit, gkmeth, gkarg	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF A VARIABLE CHANGE INDICATOR IS RECEIVED...
		reinit	START		;...BEGIN A REINITIALISATION PASS FROM LABEL 'START' 
	endif				;END OF CONDITIONAL BRANCHING
	START:				;LABEL
	ares		clip 		asig, i(gkmeth), i(gklimit), i(gkarg)
	rireturn			;RETURN TO PERFORMANCE PASSES FROM INITIALISATION PASS
	outs		ares * gkpostgain, ares * gkpostgain
endin
		
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>