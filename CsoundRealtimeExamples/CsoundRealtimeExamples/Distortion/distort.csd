distort.csd
Written by Iain McCurdy, 2009, updated 2015

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL     | WIDTH | HEIGHT | X | Y
		FLpanel	"distort",   500,    395,    0,  0


;TEXT BOXES (BORDERS)				TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"", 		6,       5,    12,   250,     100,    60, 189	; inputs

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,     0,     1,      0,      3600

FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
iddist      	FLvalue	" ",	 70,      20,    5,  75
idhp		FLvalue	" ",	 70,      20,    5, 125
idDryWetMix	FLvalue	" ",	 70,      20,    5, 320
idoutgain	FLvalue	" ",	 70,      20,    5, 370

;SLIDERS     				LABEL                 	MIN   | MAX | EXP | TYPE |  DISP      | WIDTH | HEIGHT | X  | Y
gkdist, ihdist		FLslider	"Distortion Amount",    0,         2,   0,   23,   iddist,       490,    25,     5,   50
gkhp,ihhp		FLslider	"Half Point (i-rate)",	0.0001,  500,  -1,   23,   idhp,         490,    25,     5,  100
gkDryWetMix,ihDryWetMix	FLslider	"Dry/Wet Mix",		0,         1,   0,   23,   idDryWetMix,  490,    25,     5,  295
gkoutgain,ihoutgain	FLslider	"Output Gain",		0.0001,   50,  -1,   23,   idoutgain,    490,    25,     5,  345

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				 TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput, ihinput	FLbutBank	 13,     1,     7,      18,   7*20,    70,150,   -1
gkfn, ihfn		FLbutBank	 13,     1,     8,      18,   8*20,   380,133,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input:",		1,       6,    12,    50,      15,    12, 162
ih		 	FLbox  	"Drum Loop       ", 	1,       5,    12,   120,      15,    90, 152
ih		 	FLbox  	"Classical Guitar", 	1,       5,    12,   120,      15,    90, 172
ih		 	FLbox  	"Sine            ", 	1,       5,    12,   120,      15,    90, 192
\ih		 	FLbox  	"1st+2nd Parts.  ", 	1,       5,    12,   120,      15,    90, 212
ih		 	FLbox  	"Triangle        ", 	1,       5,    12,   120,      15,    90, 232
ih		 	FLbox  	"Square          ", 	1,       5,    12,   120,      15,    90, 252
ih		 	FLbox  	"Sawtooth        ", 	1,       5,    12,   120,      15,    90, 272
ih		 	FLbox  	"Function:",		1,       6,    12,    50,      15,   322, 135
ih		 	FLbox  	"Sawtooth Up  ", 	1,       5,    12,    95,      15,   400, 135
ih		 	FLbox  	"Tanh         ", 	1,       5,    12,    95,      15,   400, 155
ih		 	FLbox  	"Sine         ", 	1,       5,    12,    95,      15,   400, 175
ih		 	FLbox  	"Odd Partials ", 	1,       5,    12,    95,      15,   400, 195
ih		 	FLbox  	"27th Partial ", 	1,       5,    12,    95,      15,   400, 215
ih		 	FLbox  	"Noise        ", 	1,       5,    12,    95,      15,   400, 235
ih		 	FLbox  	"Half Sine    ", 	1,       5,    12,    95,      15,   400, 255
ih		 	FLbox  	"Square Wave  ", 	1,       5,    12,    95,      15,   400, 275

idfreq		FLvalue	" ",	 60,      17,  200, 266
;SLIDERS     				LABEL		MIN   | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X  | Y
gkfreq, ihfreq		FLslider	"Osc.Freq.",    20,    2000,   -1,   23,  idfreq,  140,    12,    160, 240

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	0.5,    ihdist
		FLsetVal_i	2,      ihhp
		FLsetVal_i	2,      ihfn
		FLsetVal_i	1,      ihDryWetMix
		FLsetVal_i	2,      ihoutgain
		FLsetVal_i	200,    ihfreq

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                	WIDTH | HEIGHT | X | Y
				FLpanel	"",	515,     500,   512, 0
				FLscroll	512,     500,     0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          distort                            ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"The 'distort' opcode performs waveshaping and also sometimes ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"clipping upon an audio signal according to a tranfer function", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"supplied by the user via a function table.                   ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"This transfer function should be bipolar and roughly equal   ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"parts of it should lie in the negative and positive domains  ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"otherwise some DC offset may occur. In this example eight    ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"different transfer functions are offered. The first one, a   ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"sawtooth shape from -1 to +1 will not distort the signal at  ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"all, the second, a hyperbolic tan function, provides a gentle", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"'s' shape passing through the origin and will provide a      ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"typical subtle distortion effect. The other transfer function", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"options are rather more esoteric and are suggestions for     ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"further exploration. In general, the more complex transfer   ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"functions will only flatter simpler less harmonically rich   ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"input sounds such as sine and triangle waves. The results of ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"the 'Noise' transfer function will also depend on the size   ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"of the table used so the user is encouraged to go into the   ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"code and experiment with different table sizes. 'Square Wave'", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"will most likely produce the most aggressive distortion      ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"effects.                                                     ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"In addition to the normal wave distortion technique via      ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"transfer function, this opcode can also dynamically compress ", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"the signal before distortion thereby increasing the amount of", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"distortion. This feature is accessed through the 'Distortion ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"Amount' control. Typical values are within the range 0 to 1  ", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"but if an input amplitude value overeaches the limit of the  ", 	1,      5,     14,    490,     20,    5, 540
ih		 	FLbox  	"transfer function table it is simple held at the maximum     ", 	1,      5,     14,    490,     20,    5, 560
ih		 	FLbox  	"limit (positive or negative) thereby invoking hard clipping. ", 	1,      5,     14,    490,     20,    5, 580
ih		 	FLbox  	"The opcode also incorporates an internal lowpass filter, the ", 	1,      5,     14,    490,     20,    5, 600
ih		 	FLbox  	"cutoff frequency of which can be set by the user. How its    ", 	1,      5,     14,    490,     20,    5, 620
ih		 	FLbox  	"effect manifests is very much dependent upon the transfer    ", 	1,      5,     14,    490,     20,    5, 640
ih		 	FLbox  	"function chosen and the 'Distortion Amount' setting so again ", 	1,      5,     14,    490,     20,    5, 660
ih		 	FLbox  	"experimentation is encouraged. Filter half-point is an       ", 	1,      5,     14,    490,     20,    5, 680
ih		 	FLbox  	"optional argument and its default is 10 hz.                  ", 	1,      5,     14,    490,     20,    5, 700
ih		 	FLbox  	"In this example I have provided six waveform functions to    ", 	1,      5,     14,    490,     20,    5, 720
ih		 	FLbox  	"provide some ideas.                                          ", 	1,      5,     14,    490,     20,    5, 740
ih		 	FLbox  	"'Half Point' provides the half point of an internal low-pass ", 	1,      5,     14,    490,     20,    5, 760
ih		 	FLbox  	"filter in cycles per second.                                 ", 	1,      5,     14,    490,     20,    5, 780
ih		 	FLbox  	"An output gain control can be used to compensate for a loss  ", 	1,      5,     14,    490,     20,    5, 800
ih		 	FLbox  	"in power when half point is low and distortion level is high.", 	1,      5,     14,    490,     20,    5, 820
				FLscroll_end
				FLpanel_end
                                                                                        
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


0dbfs	=	1	;MAXIMUM AMPLITUDE WILL BE 1

;WAVESHAPING FUNCTIONS
gifn1	ftgen	1,0,1025,7,-1,1024,1		;SAWTOOTH UP
gifn2   ftgen   2,0,1025, "tanh", -5, 5, 0	;TANH
gifn3	ftgen	3,0,1025,10,1			;SINE WAVE
gifn4	ftgen	4,0,1025,10,1,0,1,0,1,0,1,0,1	;ODD PARTIALS
gifn5	ftgen	5,0,1025,9,27,1,0		;27th PARTIAL
gifn6	ftgen	6,0,65,21,3,1			;TRIANGLE NOISE
gifn7	ftgen	7,0,1025,9,.5,1,0		;HALF SINE
;gifn8	ftgen	8,0,1025,7,1,512,1,0,-1,512,-1	;SQUARE WAVE
;                                (amp) 0, 1  2  3  4  5
;giTF    ftgen   8, 0, 1025, 13, 1,  1,  0, 5, 4, 3, 2, 1


gisine	ftgen	0,0,4096,10,1
giOctParts	ftgen	0,0,4096,10,1,1
instr	1		;DISTORT INSTRUMENT
	if gkOnOff=0	then		;...IF 'On/Off' BUTTON IS 'OFF'...
		turnoff			;...TURNOFF THIS INSTRUMENT IMMEDIATLEY
	endif				;END OF CONDIIONAL BRANCHING
	if gkinput==0 then
	 asig		diskin2		"808loopMono.wav", 1, 0, 1
	elseif gkinput==1 then
	 asig,ar	diskin2 		"ClassicalGuitar.wav", 1, 0, 1
	elseif  gkinput==2 then
	 asig	oscili	1,gkfreq,gisine
	elseif  gkinput==3 then
	 asig	oscili	1,gkfreq,giOctParts
	elseif  gkinput==4 then
	 asig	vco2	1,gkfreq,4,0.5
	elseif  gkinput==5 then
	 asig	vco2	1,gkfreq,2,0.5
	elseif  gkinput==6 then
	 asig	vco2	1,gkfreq
	endif

	kporttime	linseg	0,0.001,0.05
	kdist		portk	gkdist,kporttime
	
	kSwitch		changed		gkhp, gkfn	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF A VARIABLE CHANGE INDICATOR IS RECEIVED...
		reinit	START		;...BEGIN A REINITIALISATION PASS FROM LABEL 'START' 
	endif				;END OF CONDITIONAL BRANCHING
	START:				;LABEL
	ar 		distort asig, kdist, i(gkfn)+1, i(gkhp);, istor]
	ar		buthp	ar, gkfreq*4
	ar		buthp	ar, gkfreq*4
	ar		buthp	ar, gkfreq*4
	rireturn			;RETURN TO PERFORMANCE PASSES FROM INITIALISATION PASS
	amix		ntrpol	asig,ar,gkDryWetMix
			out		amix * gkoutgain	;SEND AUDIO TO OUTPUTS AND MULTIPLY BY OUTPUT GAIN FLTK SLIDER
endin
		
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>