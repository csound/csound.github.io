;pvsstencil.csd
;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b512 -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	16
nchnls	= 	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL        | WIDTH | HEIGHT | X | Y
	FLpanel	"pvstencil",    500,    250,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idgain			FLvalue	" ",	 80,      20,    5,  75
idlevel			FLvalue	" ",	 80,      20,    5, 125
idDryWet		FLvalue	" ",	 80,      20,    5, 175
idOutGain		FLvalue	" ",	 80,      20,    5, 225

;SLIDERS							MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkgain, ihgain		FLslider 	"Gain",			0,     1,    0,    23,    idgain,      490,     25,    5,   50
gklevel, ihlevel	FLslider 	"Level",		0,   100,    0,    23,    idlevel,     490,     25,    5,  100
gkDryWet, ihDryWet	FLslider 	"Dry/Wet Mix",		0,     1,    0,    23,    idDryWet,    490,     25,    5,  150
gkOutGain, ihOutGain	FLslider 	"Output Gain",		0,     2,    0,    23,    idOutGain,   490,     25,    5,  200

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	0, 	ihgain
			FLsetVal_i	10, 	ihlevel
			FLsetVal_i	1, 	ihDryWet
			FLsetVal_i	1, 	ihOutGain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     420,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvstencil                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvstencil is performs masking of a streaming pvoc signal     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"according to secondary pvoc data held in a GEN 43 function   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"table. The most typical application for this would be to     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"remove unwanted constant noise from a recording by first     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"analysing a short isolated sample of that noise.             ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"The amplitude of each pvoc channel for a given instant is    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"compared to the amplitude of the corresponding channel in the", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"GEN 43 masking function. If the value falls below that of the", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"masking function a user definable gain is applied. Values    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"read from the masking function are first scaled by the       ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"parameter 'Level'. Increasing level will increase the        ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"threshold below which gain will be applied and therefore     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"increase the influence of the masking function. Extreme      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"values for 'Level' will result in extreme transformations of ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"the input sound that go beyond noise reduction.              ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"By using samples other than noise samples as input for the   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"masking function this opcode can have other creative uses.   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"In this example a slider is provided that allows the user to ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"compare the signal before filter with that after filtering.  ", 	1,      5,     14,    490,    15,     5, 400
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;STENCILLING FFT ANALYSIS IS STORED IN A GEN 43 FUNCTION TABLE (-VE GEN NUMBER SO THAT POST NORMALISATION IS SKIPPED)
;TABLE SIZE SHOUDL BE AT LEAST FFT_SIZE/2
ginoise	ftgen	0, 0, 131072, -43, "noise.pvx", 0

instr	1
	if	gkOnOff=0	then					;IF On/Off SWITCH IS SET TO 'Off'
		turnoff							;TURN THIS INSTRUMENT
	endif								;END OF CONDITIONAL BRANCHING
	
	asigin		diskin2		"sample.wav",1,0,1		;CREATE AUDIO SIGNAL OF AUDIO SAMPLE TO WHICH STENCILLING WILL BE APPLIED
	fsigin 		pvsanal		asigin, 1024, 256, 1024, 1	;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.      	
	
	/*
	;pvread ON THE SAMPLE FILE CAN ALSO BE USED
#define	ANALYSISFILE	#"sample.pvx"#
	ilen		filelen		$ANALYSISFILE
	gkspeed		=		0.5
	kptr		phasor		gkspeed/ilen
	fsigin		pvsfread	kptr*ilen,$ANALYSISFILE
	*/
	fres		pvstencil	fsigin, gkgain, gklevel, ginoise;APPLY STENCIL GATING
	aresyn 		pvsynth  	fres				;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	amix		ntrpol		asigin, aresyn, gkDryWet	;CREATE A MIX BETWEEN THE DRY (UNFILTERED) AND WET (FILTERED) SOUND
			out		amix * gkOutGain		;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>