dconv.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
;TRY REDUCING BUFFER SIZES TO IMPROVE LATENCY - SETTING BUFFERS TOO SMALL HOWEVER MAY CAUSE UNDER-RUNS 
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	1024
nchnls	=	2
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FLcolor		255,255,255
FLcolor2	  0,  0,  0

;		LABEL         | WIDTH | HEIGHT | X | Y
	FLpanel	"dconv",      500,    250,    0,  0

;                                            	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X  |  Y
idGain			FLvalue	" ",    60,       20,    5,    75
idMix			FLvalue	" ",    60,       20,    5,   125

;SLIDERS				            	MIN  |   MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkGain,ihGain		FLslider 	"Gain",		0,        1,    0,    23,    idGain,    490,     25,    5,  50
gkMix,ihMix		FLslider 	"Dry/Wet Mix",	0,        1,    0,    23,    idMix,     490,     25,    5, 100

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    160,     60,    5, 170	;BORDER AROUND INPUT SELECTOR
ih		 	FLbox  	" ", 	6,      9,     15,    300,     60,  170, 170	;BORDER AROUND CONVOLUTION FILE SELECTOR

;LABELS MADE INVISIBLE
FLlabel    13, 1, 1, 255,255,255
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	12,      1,     2,     25,     50,   55,175,   -1
gkfile,   ihfile			FLbutBank	12,      1,     2,     25,     50,  320,175,   -1

;LABELS MADE VISIBLE AGAIN
FLlabel    13, 5, 4, 0, 0, 0

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih     		FLbox  	"Sound File", 		1,      1,     12,    70,      30,    80, 173
ih     		FLbox  	"Live Input", 		1,      1,     12,    70,      30,    80, 198
ih     		FLbox  	"Wood", 		1,      1,     12,    70,      30,   350, 173
ih     		FLbox  	"Mug ", 		1,      1,     12,    70,      30,   350, 198
ih		FLbox	"Input",       		1,      4,     14,    30,      20,    15, 175
ih		FLbox	"Convolution File",	1,      4,     14,   130,      20,   180, 175

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0.3, 	ihGain
			FLsetVal_i	1, 	ihMix
			FLsetVal_i	0, 	ihinput

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     180,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            dconv                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"dconv performs direct convolution between an input signal and", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"an impulse file. dconv works best, at least in real-time,    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"with very short impulse files and is therefore less well     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"suited to reverberation application but better suited for    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"filtering. With long impulse files dconv will struggle to    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"perform at all. The two impulse files provided with this     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"example are both extremely short.                            ", 	1,      5,     14,    490,    15,     5, 160

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;IMPULSE (SOUND) FILES
gifile1L	ftgen	0,0,4096,1,"Wood.wav",0,0,1
gifile1R	ftgen	0,0,4096,1,"Wood.wav",0,0,2
gifile2L	ftgen	0,0,4096,1,"Mug.wav",0,0,1
gifile2R	ftgen	0,0,4096,1,"Mug.wav",0,0,2

instr 1	;GENERATE INPUT AUDIO INDEPENDENTLY OF REVERBERATING INSTRUMENT
	if	gkOnOff=0	then				;IF ON/OFF SWITCH IS OFF...
		turnoff						;TURN THIS INSTRUMENT OFF
	endif							;END OF CONDITIONAL BRANCHING
	if	gkinput=0	then				;IF 'Sound File' IS SELECTED...
		gaL, gaR	diskin2	"808loop.wav", 1, 0, 1	;READ AUDIO FROM SOUND FILE ON HARD DISC
	elseif	gkinput=1	then				;IF 'Live Input' IS SELECTED
		gaL	inch	1				;READ AUDIO FROM SOUND CARD'S FIRST (LEFT) INPUT
		gaR	=	gaL				;MONO INPUT THEREFORE ASSIGN RIGHT CHANNEL TO LEFT CHANNEL ALSO 
	endif
endin

instr	2	;CONVOLUTION REVERB INSTRUMENT (ALWAYS ON)	
	if	gkfile=0	then			;IF 'STAIRWELL' IS CHOSEN AS CONVOLUTION FILE...
		ifnL		=	gifile1L
		ifnR		=	gifile1R
		iftlen	=	ftlen(ifnL)
		isize	=	iftlen
		ar1 	dconv 	  gaL, isize, ifnL
		ar2 	dconv 	  gaR, isize, ifnR
	elseif	gkfile=1	then			;IF 'DISH' IS CHOSEN AS CONVOLUTION FILE...
		ifnL		=	gifile2L
		ifnR		=	gifile2R
		iftlen	=	ftlen(ifnL)
		isize	=	iftlen
		ar1 	dconv 	  gaL, isize, ifnL
		ar2 	dconv 	  gaR, isize, ifnR
	endif

	aL	ntrpol	gaL, ar1*0.3, gkMix	;CREATE DRY/WET MIX (LEFT CHANNEL)  
	aR	ntrpol	gaR, ar2*0.3, gkMix	;CREATE DRY/WET MIX (RIGHT CHANNEL)
		outs	aL*gkGain, aR*gkGain	;SEND AUDIO TO OUTPUTS
	gaL	=	0			;CLEAR GLOBAL AUDIO SIGNAL FROM INSTR 1 (LEFT CHANNEL) 
	gaR	=	0			;CLEAR GLOBAL AUDIO SIGNAL FROM INSTR 1 (RIGHT CHANNEL)
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;INSTRUMENT 2 (CONVOLUTION INSTRUMENT) RUNS FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING) 
</CsScore>

</CsoundSynthesizer>