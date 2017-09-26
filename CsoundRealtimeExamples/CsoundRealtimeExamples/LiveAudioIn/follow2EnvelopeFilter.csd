follow2EnvelopeFilter.csd
Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	16
nchnls	=	2
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"follow2",  500,     450,   0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,     0,        -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;				WIDTH | HEIGHT | X | Y
idatt		FLvalue	"",	80,       20,    5,  75
idrel		FLvalue	"",	80,       20,    5, 125
idsensitivity	FLvalue	"",	80,       20,    5, 175
idoffset	FLvalue	"",	80,       20,    5, 225
idres		FLvalue	"",	80,       20,    5, 275
idspeed		FLvalue	"",	80,       20,    5, 325
idmix		FLvalue	"",	80,       20,    5, 375
idamp		FLvalue	"",	80,       20,    5, 425
                                                                                              
;					     						MIN   |  MAX   | EXP | TYPE |  DISP       | WIDTH | HEIGHT | X |  Y
gkatt, ihatt			FLslider	"Envelope Follow Attack",		0.001,   0.5,     0,    23,  idatt,          490,     25,    5,   50
gkrel, ihrel			FLslider	"Envelope Follow Release",		0.001,   0.5,     0,    23,  idrel,          490,     25,    5,  100
gksensitivity, ihsensitivity	FLslider	"Envelope Follow Sensitivity (Hz.)",  	1,     20000,    -1,    23,  idsensitivity,  490,     25,    5,  150
gkoffset, ihoffset		FLslider	"Filter Cutoff Offset (Hz.)",     	20,    15000,    -1,    23,  idoffset,       490,     25,    5,  200
gkres, ihres			FLslider	"Filter Resonance",          		0,         1,     0,    23,  idres,          490,     25,    5,  250
gkspeed, ihspeed		FLslider	"File Playback Speed",			0.125,     2,     0,    23,  idspeed,        490,     25,    5,  300
gkmix, ihmix			FLslider	"Filter Dry/Wet Mix",          		0,         1,     0,    23,  idmix,          490,     25,    5,  350
gkamp, ihamp			FLslider   	"Output Gain",				0,         2,     0,    23,  idamp,          490,     25,    5,  400
gkingain,ihingain		FLslider 	"Live Input Gain",			0,         1,     0,    23,  -1,             140,     20,  350,    5

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255	;LABELS MADE INVISIBLE
FLcolor2	255, 255, 50		;SET SECONDARY COLOUR TO YELLOW
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput	FLbutBank	12,     1,     2,     30,    40,    150,  0,   -1
                                                                                       
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       2,    12,    70,      20,   180,  0
ih		 	FLbox  	"Sound File", 		1,       2,    12,    70,      20,   180, 20

		FLsetVal_i	0.001,	ihatt
		FLsetVal_i	0.2,	ihrel
		FLsetVal_i	10000,	ihsensitivity
		FLsetVal_i	100,	ihoffset
		FLsetVal_i	0.5,	ihres
		FLsetVal_i	0.5,	ihspeed
		FLsetVal_i	1,	ihmix
		FLsetVal_i	1,	ihamp
		FLsetVal_i	1,	ihinput
		
		FLpanel_end	;END OF PANEL CONTENTS
                                                                                       
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           follow2                           ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The follow2 opcode outputs an amplitude following signal     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"based on an input audio signal. The output signal will be    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"unipolar (i.e. only positive values) and the response of the ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"envelope follower to dynamic transients can be tailored using", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"follow2's input arguments for attack time and release time.  ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"This example demonstrates a very common use of this control  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"signal in that it is used to derive the cutoff frequency of a", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"lowpass filter. Therefore as the amplitude of the input      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"signal increases the cutoff frequency of the filter also     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"rises. Some additional controls are offered to allow the user", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"to further refine the envelope follower response and some    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"other aspects of the effect.                                 ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'Envelope Follow Sensitivity' defines the increase in hertz  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"that a sound of maximum intensity will apply to the filter   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"cutoff value.                                                ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"'Filter Cutoff Offset' sets the base value for the filter    ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"cutoff in hertz before envelope following influence has been ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"added.                                                       ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"The 'moogvcf2' resonant lowpass filter has been used because ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"it allows us to use an a-rate variable for cutoff frequency. ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"The output from follow2 is also a-rate. If we wanted to use  ", 	1,      5,     14,    490,    20,     5, 440 
ih		 	FLbox  	"a different opcode that only permitted the use of k-rate     ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"variables to define cutoff frequency then we could have used ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"the 'downsamp' opcode to convert from a-rate to k-rate.      ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"The user can choose between using a stored file or the live  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"input as the source signal for the envelope follower.        ", 	1,      5,     14,    490,    20,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if gkOnOff=0	then                                                                              
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if		gkinput=0	then		;IF INPUT SWITCH IS SET TO 'LIVE INPUT' THEN... 
		aL, aR		ins			;READ THE LIVE AUDIO INPUT TO THE COMPUTER
		aL	=	aL * gkingain		;SCALE LIVE INPUT WITH FLTK SLIDER	
		aR	=	aR * gkingain           ;SCALE LIVE INPUT WITH FLTK SLIDER
	elseif		gkinput=1	then		;OR ELSE IF INPUT SWITCH IS SET TO 'SOUND FILE' THEN... 
		;OUTPUT		OPCODE		FILE_PATH |  SPEED  | INSKIP | LOOPING_0=OFF/1=ON
		aL		diskin2		"loop.wav", gkspeed,     0,        1		;CREATE AN AUDIO SIGNAL
		aR	=	aL	;ASSIGN RIGHT CHANNEL TO BE THE SAME AS THE LEFT CHANNEL SIGNAL
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.02	;FUNCTION THAT RAMPS UP QUICKLY FROM ZERO AND LEVELS OFF AT 0.02
	koffset		portk	gkoffset, kporttime	;APPLY PORTAMENTO SMOOTHING TO FLTK SLIDER VARIABLE koffset
	;LEFT CHANNEL===========================================================================================================================================================
	afollowL	follow2		aL, gkatt, gkrel				;CREATE AN ENVELOPE FOLLOWING SIGNAL FROM THE AUDIO SIGNAL		
	acfL		limit		(afollowL*gksensitivity)+koffset,20,sr/2	;LIMIT FILTER CUTOFF FREQUENCY VARIABLE TO PREVENT VALUES BEYOND THE NYQUIST FREQUENCY BEING ATTEMPTED
	afiltL		moogvcf2	aL, acfL, gkres					;FILTER THE AUDIO SIGNAL USING THE moogvcf2 RESONANT LOWPASS FILTER
	amixL		ntrpol		aL, afiltL, gkmix				;CREATE A DRY/WET MIX BETWEEN THE ORIGINAL SIGNAL AND THE FILTERED SIGNAL
	;=======================================================================================================================================================================

	;RIGHT CHANNEL==========================================================================================================================================================
	afollowR	follow2		aR, gkatt, gkrel				;CREATE AN ENVELOPE FOLLOWING SIGNAL FROM THE AUDIO SIGNAL		
	acfR		limit		(afollowR*gksensitivity)+koffset,20,sr/2	;LIMIT FILTER CUTOFF FREQUENCY VARIABLE TO PREVENT VALUES BEYOND THE NYQUIST FREQUENCY BEING ATTEMPTED  
	afiltR		moogvcf2	aR, acfR, gkres					;FILTER THE AUDIO SIGNAL USING THE moogvcf2 RESONANT LOWPASS FILTER
	amixR		ntrpol		aR, afiltR, gkmix				;CREATE A DRY/WET MIX BETWEEN THE ORIGINAL SIGNAL AND THE FILTERED SIGNAL
	;=======================================================================================================================================================================

	outs		amixL * gkamp, amixR * gkamp	;SEND DRY/WET MIX TO THE SPEAKERS - RESCALE WITH GAIN CONTROL
endin                                                                                     
		
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - PERMITS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>