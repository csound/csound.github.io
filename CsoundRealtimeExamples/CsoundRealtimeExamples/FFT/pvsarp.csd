;Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b400
</CsOptions>

<CsInstruments>

sr	= 	44100
kr	= 	441
ksmps	= 	100
nchnls	= 	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL    | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsarp",   500,    400,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
iddepth			FLvalue	" ",	 80,      20,    5, 175
idgain			FLvalue	" ",	 80,      20,    5, 225
idLFOdepth		FLvalue	" ",	 80,      20,    5, 275
idLFOoffset		FLvalue	" ",	 80,      20,    5, 325
idLFOspeed		FLvalue	" ",	 80,      20,    5, 375

;SLIDERS				            			MIN   | MAX | EXP | TYPE |    DISP   | WIDTH | HEIGHT | X  | Y
gkdepth, ihdepth		FLslider 	"Depth",		0,       1,    0,   23,      iddepth,   490,     25,    5,  150
gkgain, ihgain			FLslider 	"Gain",			0,      20,    0,   23,       idgain,   490,     25,    5,  200
gkLFOdepth, ihLFOdepth		FLslider 	"LFO Depth",		0,      .5,    0,   23,   idLFOdepth,   490,     25,    5,  250
gkLFOoffset, ihLFOoffset	FLslider 	"LFO Offset",		0,       1,    0,   23,  idLFOoffset,   490,     25,    5,  300
gkLFOspeed, ihLFOspeed		FLslider 	"LFO Speed",		.001, 2000,   -1,   23,   idLFOspeed,   490,     25,    5,  350

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;					FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkLFOfn,  ihLFOfn			FLbutBank	14,     1,     6,     18,     120,   220, 1,   -1
gkinput,  ihinput			FLbutBank	14,     1,     3,     18,      60,   400, 1,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"LFO shape:", 	1,       5,    16,   100,      30,   110,   0
ih		 	FLbox  	"Sine      ", 	1,       5,    12,    70,      20,   240,   0
ih		 	FLbox  	"Triangle  ", 	1,       5,    12,    70,      20,   240,  20
ih		 	FLbox  	"Ramp down ", 	1,       5,    12,    70,      20,   240,  40
ih		 	FLbox  	"Ramp Up   ",    1,       5,    12,    70,      20,   240,  60
ih		 	FLbox  	"Square    ",    1,       5,    12,    70,      20,   240,  80
ih		 	FLbox  	"Random S&H",    1,       5,    12,    70,      20,   240, 100
ih		 	FLbox  	"Input:", 	1,       5,    16,    70,      30,   330,   0
ih		 	FLbox  	"Voice    ", 	1,       5,    12,    70,      20,   420,   0
ih		 	FLbox  	"Drum Loop", 	1,       5,    12,    70,      20,   420,  20
ih		 	FLbox  	"Songpan  ", 	1,       5,    12,    70,      20,   420,  40

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	.95, 	ihdepth
			FLsetVal_i	1, 	ihgain
			FLsetVal_i	.1, 	ihLFOdepth
			FLsetVal_i	0.11, 	ihLFOoffset
			FLsetVal_i	0.17, 	ihLFOspeed
			FLsetVal_i	1, 	ihLFOfn

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     280,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           pvsarp                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvsarp allows the user to dynamically select a single        ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"analysis bin, to amplify it (using the 'Gain' control and to ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"attenuate all other bins (using the 'depth' control).        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Bin selection is controlled in this example using as LFO.    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"The user can choose from a variety of different wave shapes  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"for this LFO and the depth of modulation, rate and offset of ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"this LFO can be modulated. If the 'LFO Depth' is set at      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"minimum the user can then manually select individual bins    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"using the 'LFO Offset' control.                              ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"This opcode has been inspired by the Spectral Arpeggiator in ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"Trevor Wishart's 'Composer's Desktop Project' (CDP) suite of ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"of sound design programs.                                    ", 	1,      5,     14,    490,    15,     5, 260

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine		ftgen 1, 0, 65536, 10, 1				;SINE WAVE
gitri		ftgen 2, 0, 65536, 7,  0, 16384, 1, 32768, -1, 16384, 0	;TRIANGLE WAVE
girampdn	ftgen 3, 0, 65536, 7,  1,  65536, -1		;RAMP DOWN
girampup	ftgen 4, 0, 65536, 7,  -1, 65536,  1		;RAMP UP
gisquare	ftgen 5, 0, 65536, 7,  1, 32768, 1, 0, -1, 32768, -1	;SQUARE

instr		1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING

	if		gkinput=0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		aL		diskin2		"AndItsAll.wav",    1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
		aR	=	aL
	elseif		gkinput=1 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		aL		diskin2		"loop.wav",      1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
		aR		=	aL	;MONO INPUT FILE SO DUPLICATE AUDIO IN RIGHT CHANNEL
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		aL, aR		diskin2		"Songpan.wav",      1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	
	fsig1L 		pvsanal		aL, 1024, 256, 1024, 1		;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1
	fsig1R 		pvsanal		aR, 1024, 256, 1024, 1		;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1

	kSwitch		changed		gkLFOfn	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif					;END OF CONDITIONAL BRANCHING
	START:					;LABEL
	if	gkLFOfn<=4	then
		kbin		oscili		gkLFOdepth, gkLFOspeed, i(gkLFOfn)+1
	elseif	gkLFOfn=5	then
		kbin		randomh		-gkLFOdepth, gkLFOdepth, gkLFOspeed
        endif
	kbin		=		kbin + gkLFOoffset	
	kbin		limit		kbin, 0, 1	
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	fsig2L		pvsarp 		fsig1L, kbin, gkdepth, gkgain	
	fsig2R		pvsarp 		fsig1R, kbin, gkdepth, gkgain	
	aresynL 	pvsynth  	fsig2L                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	aresynR 	pvsynth  	fsig2R                     		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
		outs		aresynL, aresynR				;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>