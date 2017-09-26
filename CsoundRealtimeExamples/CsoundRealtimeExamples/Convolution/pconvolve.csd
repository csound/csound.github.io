pconvolve.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -b800 -dm0
;TRY REDUCING BUFFER SIZES TO IMPROVE LATENCY - SETTING BUFFERS TOO SMALL HOWEVER MAY CAUSE UNDER-RUNS 
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	64
nchnls	=	2
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FLcolor		255,255,255
FLcolor2	  0,  0,  0

;		LABEL          | WIDTH | HEIGHT | X | Y
	FLpanel	"pconvolve",      500,    250,    0,  0

;                                            	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idGain			FLvalue	" ",    60,       20,    5,    75
idMix			FLvalue	" ",    60,       20,    5,   125

;					            	MIN  | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkGain,ihGain		FLslider 	"Gain",		0,      1,    0,    23,   idGain,     490,    25,     5,  50
gkMix,ihMix		FLslider 	"Dry/Wet Mix",	0,      1,    0,    23,    idMix,     490,    25,     5, 100

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
ih     		FLbox  	"Stairwell", 		1,      1,     12,    70,      30,   350, 173
ih     		FLbox  	"Dish     ", 		1,      1,     12,    70,      30,   350, 198
ih		FLbox	"Input",       		1,      4,     14,    30,      20,    15, 175
ih		FLbox	"Convolution File",	1,      4,     14,   130,      20,   180, 175

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0.7, 	ihGain
			FLsetVal_i	0.17, 	ihMix
			FLsetVal_i	0, 	ihinput

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     440,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pconvolve                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pconvolve offers a computationally efficient method for      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"performing convolution and is therefore ideally suited for   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"real-time convolution reverbs.                               ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The input file for the convolution impulse is a sound file   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"and is typically a short recording of the reverberant tail of", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"of a sharp loud sound, sounding in the space. The sounds used", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"in these recordings is often a starting pistol or a balloon  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"bursting. The aim is that all frequencies are present in the ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"initial inpulse sound. For more accurate convolution a sine  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"sweep is used but in this case further decoding is needed    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"before the recording can be used.                            ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"If too long an impulse sound is used the opcode will struggle", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"to run in real-time as convolution is fundementally a        ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"computationally expensive procedure.                         ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Two user controls are included, 'Dry/Wet Mix' and 'Output    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Gain' (both dry and wet signals).                            ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"There is no reason why the impulse file has to be that of a  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"reverberant space. One of the options for 'Convolution       ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"File' in this example is a glass dish. Other possibilities   ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"might be vintage amplifiers and microphones.                 ", 	1,      5,     14,    490,    15,     5, 420

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 1	;GENERATE INPUT AUDIO INDEPENDENTLY OF REVERBERATING INSTRUMENT
	if	gkOnOff=0	then	;IF ON/OFF SWITCH IS OFF...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	if	gkinput=0	then			;IF 'Sound File' IS SELECTED...
		gaL, gaR	diskin2	"808loop.wav", 1, 0, 1	;READ AUDIO FROM SOUND FILE ON HARD DISC
	elseif	gkinput=1	then			;IF 'Live Input' IS SELECTED
		gaL	inch	1	;READ AUDIO FROM SOUND CARD'S FIRST (LEFT) INPUT
		gaR	=	gaL	;MONO INPUT THEREFORE ASSIGN RIGHT CHANNEL TO LEFT CHANNEL ALSO 
	endif
endin

instr	2	;CONVOLUTION REVERB INSTRUMENT
		kSwitch		changed		gkfile	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then			;IF I-RATE VARIABLE IS CHANGED...
		reinit	UPDATE				;BEGIN A REINITIALISATION PASS IN ORDER TO EFFECT THIS CHANGE. BEGIN THIS PASS AT LABEL ENTITLED 'UPDATE' AND CONTINUE UNTIL rireturn OPCODE 
	endif						;END OF CONDITIONAL BRANCHING
	UPDATE:						;LABEL
if	gkfile=0	then				;IF 'STAIRWELL' IS CHOSEN AS CONVOLUTION FILE...
		ar1	pconvolve gaL, "StairwellL.wav"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (LEFT CHANNEL)
		ar2	pconvolve gaR, "StairwellR.wav"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (RIGHT CHANNEL)
	elseif	gkfile=1	then			;IF 'DISH' IS CHOSEN AS CONVOLUTION FILE...
		ar1	pconvolve gaL, "dishL.wav"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (LEFT CHANNEL)
		ar2	pconvolve gaR, "dishR.wav"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (RIGHT CHANNEL)
	endif						;END OF CONDITIONAL BRANCHING
	aL	ntrpol	gaL, ar1*0.1, gkMix		;CREATE DRY/WET MIX (LEFT CHANNEL)  
	aR	ntrpol	gaR, ar2*0.1, gkMix		;CREATE DRY/WET MIX (RIGHT CHANNEL)
		outs	aL*gkGain, aR*gkGain		;SEND AUDIO TO OUTPUTS
	gaL	=	0				;CLEAR GLOBAL AUDIO SIGNAL FROM INSTR 1 (LEFT CHANNEL) 
	gaR	=	0				;CLEAR GLOBAL AUDIO SIGNAL FROM INSTR 1 (RIGHT CHANNEL)
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;INSTRUMENT 2 (CONVOLUTION INSTRUMENT) RUNS FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING) 
</CsScore>

</CsoundSynthesizer>