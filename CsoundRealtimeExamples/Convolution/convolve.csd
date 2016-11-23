convolve.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
;TRY REDUCING BUFFER SIZES TO IMPROVE LATENCY - SETTING BUFFERS TOO SMALL, HOWEVER, MAY CAUSE UNDER-RUNS 
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	1024
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor		255,255,255
FLcolor2	  0,  0,  0

;		LABEL         | WIDTH | HEIGHT | X | Y
	FLpanel	"convolve",      500,    250,    0,  0

;                                            	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  0,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X  |  Y
idDly			FLvalue	" ",    60,       20,   105,   25
idGain			FLvalue	" ",    60,       20,     5,   75
idMix			FLvalue	" ",    60,       20,     5,  125

;SLIDERS				            	MIN  |   MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkDly,gihDly		FLslider 	"Delay",	0.001,    3,    0,    23,    idDly,     390,     25,   105,  0
gkGain,ihGain		FLslider 	"Gain",		0,        1,    0,    23,    idGain,    490,     25,     5, 50
gkMix,ihMix		FLslider 	"Dry/Wet Mix",	0,        1,    0,    23,    idMix,     490,     25,     5,100

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    160,     60,    5, 170	;BORDER AROUND INPUT SELECTOR
ih		 	FLbox  	" ", 	6,      9,     15,    300,     60,  170, 170	;BORDER AROUND CONVOLUTION FILE SELECTOR

;LABELS MADE INVISIBLE
FLlabel    13, 1, 1, 255,255,255
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	12,      1,     2,     25,     50,   55,175,   -1
gkfile,   ihfile			FLbutBank	12,      1,     2,     25,     50,  320,175,   0,    3, 0, 0.1

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
			FLsetVal_i	1.175, 	gihDly

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     360,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           convolve                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"convolve performs convolution between an input signal and an ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"impulse file created using Csound's cvanal utility.          ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"I have provided two impulse files to work with in this       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"example. convolve is rather CPU intensive and depending upon ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the computer system used, may struggle to run in real-time.  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Adjustment of buffer sizes and of ksmps (and kr) might assist", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"real-time performance.                                       ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The output of the convolve opcode will be delayed by a       ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"duration equal to the duration of the impulse file. It is    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"therefore necessary to delay the input signal if it is used  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"as part of a Dry/Wet mix after convolution. For this reason  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"convolve is probably less useful when applied to the         ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"live input. (pconvolve is better suited to real-time         ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"situations.)                                                 ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Furthermore there does not seem to be a noticable drop in    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"fidelity in pconvolve.                                       ", 	1,      5,     14,    490,    15,     5, 340

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gaL,gaR	init	0

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
		ar1 	convolve  gaL, "StairwellL.cv"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (LEFT CHANNEL) 
		ar2 	convolve  gaR, "StairwellR.cv"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (RIGHT CHANNEL)
	elseif	gkfile=1	then			;IF 'DISH' IS CHOSEN AS CONVOLUTION FILE...
		ar1	convolve  gaL, "dishL.cv"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (LEFT CHANNEL)
		ar2	convolve  gaR, "dishR.cv"	;PERFORM CONVOLUTION BETWEEN AUDIO INPUT FROM INSTR 1 AND SOUNDFILE STORED ON DISK (RIGHT CHANNEL)
	endif
	aDlyL	vdelay	gaL, gkDly*1000, 3000		;CREATE A DELAYED VERSION OF THE INPUT SIGNAL TO TEMPORALLY CORRELATE WITH THE CONVOLUTION OUTPUT SO THAT IT CAN BE USED IN A DRY/WET MIX
	aDlyR	vdelay	gaR, gkDly*1000, 3000		;CREATE A DELAYED VERSION OF THE INPUT SIGNAL TO TEMPORALLY CORRELATE WITH THE CONVOLUTION OUTPUT SO THAT IT CAN BE USED IN A DRY/WET MIX
	aL	ntrpol	aDlyL, ar1*0.1, gkMix		;CREATE DRY/WET MIX (LEFT CHANNEL)  
	aR	ntrpol	aDlyR, ar2*0.1, gkMix		;CREATE DRY/WET MIX (RIGHT CHANNEL)
		outs	aL*gkGain, aR*gkGain		;SEND AUDIO TO OUTPUTS
	gaL=0	;CLEAR GLOBAL AUDIO SIGNAL FROM INSTR 1 (LEFT CHANNEL) 
	gaR=0	;CLEAR GLOBAL AUDIO SIGNAL FROM INSTR 1 (RIGHT CHANNEL)
endin

instr	3	;CHANGE DELAY TIME SETTING
	if	i(gkfile)=0	then		;IF 'STAIRWELL' IS CHOSEN AS CONVOLUTION FILE...
		ilen filelen	"StairwellL.cv"
		FLsetVal_i	ilen, gihDly	;UPDATE DELAY TIME SLIDER ACCORDINGLY
	elseif	i(gkfile)=1	then		;IF 'DISH' IS CHOSEN AS CONVOLUTION FILE...
		ilen filelen	"dishL.cv"
		FLsetVal_i	ilen, gihDly	;UPDATE DELAY TIME SLIDER ACCORDINGLY
	endif					;END OF CONDITIONAL BRANCHING
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;INSTRUMENT 2 (CONVOLUTION INSTRUMENT) RUNS FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING) 
</CsScore>

</CsoundSynthesizer>