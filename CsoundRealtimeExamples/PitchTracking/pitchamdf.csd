; pitchamdf.csd
; Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;USE DEFAULT AUDIO INPUT AND OUTPUT DEVICES. ADJUSTMENT TO THESE PERFORMANCE FLAGS AND THE ADDITION OF MORE (SUCH AS BUFFER SIZE DEFINITION) MAY BE NEEDED TO OPTIMIZE REALTIME PERFORMANCE 
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs	=	1	;MAXIMUM AMPLITUDE = 1, REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL		WIDTH | HEIGHT | X | Y
	FLpanel		"pitchamdf", 	500,      400,   0,  0

;SWITCHES	  	             				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff, ihOnOff	FLbutton	"On/Off",		1,    0,    22,    140,     25,   10,  5,    0,      1,      0,       -1
gkmeters, ihmeters	FLbutton	"Meters On/Off",	1,    0,    22,    140,     25,   10,260,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihmeters		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL | WIDTH | HEIGHT | X | Y
idmincps			FLvalue	" ",	 80,      20,   10,  75
idmaxcps			FLvalue	" ",	 80,      20,   10, 125
idinitcps			FLvalue	" ",	 80,      20,   10, 175
idrms				FLvalue	" ",	 80,      20,   10, 315
idcps				FLvalue	" ",	 80,      20,   10, 365

;SLIDERS				            					MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkInGain, ihInGain		FLslider 	"Input Gain",				0,         2,  0,    23,        -1,   160,    25,   160,    5
gkGateThresh, ihGateThresh	FLslider 	"Gate Threshold",			0,       0.3,  0,    23,        -1,   160,    25,   330,    5
gkmincps, ihmincps		FLslider 	"Minimum Frequency (cps)",		20,    10000, -1,    23,  idmincps,   480,    25,    10,   50
gkmaxcps, ihmaxcps		FLslider 	"Maximum Frequency (cps)",		20,    10000, -1,    23,  idmaxcps,   480,    25,    10,  100
gkinitcps, ihinitcps		FLslider 	"Initial CPS",				0,     10000,  0,    23,  idinitcps,  480,    25,    10,  150
gkrms, gihrms			FLslider 	"rms",					0,         1,  0,    21,     idrms,   480,    25,    10,  290
gkcps, gihcps			FLslider 	"cps",					20,    10000, -1,    21,     idcps,   480,    25,    10,  340

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkmedi, ihmedi		FLcount  	"Median CPS", 	0,    111,    1,     10,      1,    120,     25,    5, 200,   -1 
gkdowns, ihdowns	FLcount  	"Downsamp.", 	1,      4,    1,      1,      2,    120,     25,  130, 200,   -1 
gkexcps, ihexcps	FLcount  	"Anal.Freq.", 	0,   1000,    1,     10,      1,    120,     25,  255, 200,   -1
gkRMSmedi, ihRMSmedi	FLcount  	"Median RMS", 	0,    111,    1,     10,      1,    115,     25,  380, 200,   -1 

FLsetColor2	220,100,100,gihrms	;ADD A BIT OF COLOUR TO METERS
FLsetColor2	100,220,100,gihcps      ;ADD A BIT OF COLOUR TO METERS

;SET INITIAL VALUES FOR SLIDERS 	VALUE | HANDLE
			FLsetVal_i	1,	ihInGain
			FLsetVal_i	0.02,	ihGateThresh
			FLsetVal_i	0,	ihinitcps
			FLsetVal_i	1,	ihmedi
			FLsetVal_i	1,	ihdowns
			FLsetVal_i	0,	ihexcps
			FLsetVal_i	1,	ihRMSmedi
			FLsetVal_i	100,	ihmincps
			FLsetVal_i	600,	ihmaxcps
			FLsetVal_i	1,	ihmeters

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      560,  512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pitchamdf                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example presents a simple demonstration of the          ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"'pitchamdf' opcode, used for pitch and amplitude tracking. It", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"requires a live audio input so you should have a microphone  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"connected to your computer and get ready to sing into it!    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"'Pitchamdf' outputs two k-rate variables, one for frequency  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"and the other for the amplitude of an input audio signal. For", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"clarity, the usage of this data in this example is quite     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"trivial in that it is used merely as input data for the      ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"frequency and amplitude of a simple synthesizing oscillator. ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"With a little imagination, many more interesting applications", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"are possible.                                                ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Careful adjustment of the controls for minimum and maximum   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"allowed frequencies can improve the pitch tracker's          ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"accuracy.                                                    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"I have added a basic noise gate to prevent ambient noise     ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"being tracked between intentional notes being played or sung.", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"You can fine-tune the threshold of this noise gate.          ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"I have added meters that allow you to monitor the pitch      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"tracker's output visually. These can affect realtime         ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"performance so can be deactivated if necessary.              ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"An alternative opcode for pitch and amplitude tracking worth ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"investigating is 'pitch'.                                    ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"Pitch tracking is a much more involved and CPU intensive     ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"process than amplitude tracking. If you only require         ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"amplitude tracking it is recommended that you use one of the ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"'follow', 'follow2' or 'rms' opcodes.                        ", 	1,      5,     14,    490,    15,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giWave	ftgen	0, 0, 1024, 10, 1, 0.2, 0.15, 0.1, 0.2, 0.1, 0.05, 0.02, 0.01	;A RICH TONE - USED BY THE PITCH TRACKING SYNTHESISER

instr 		1
	if	gkOnOff=0	then	;IF FLTK ON/OFF SWITCH IS OFF...
		turnoff			;...TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif				;END OF THIS CONDITIONAL BRANCH
	aL		inch	1			;READ FIRST/LEFT AUDIO INPUT TO THE COMPUTER
	aL		=	aL * gkInGain		;RESCALE AUDIO SIGNAL USING INPUT GAIN CONTROL
	;;;;;;;;;AUDIO GATE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	afollow 	follow2 	aL, .0001, .03		;CREATE A AMPLITUDE FOLLOWING UNIPOLAR SIGNAL
	kfollow		downsamp	afollow			;DOWNSAMPLE TO CREATE A K-RATE VERSION OF THE AMPLITUDE FOLLOWING SIGNAL
	kgate		=		(kfollow<gkGateThresh?0:1)	;CREATE A GATE SIGNAL (EITHER 1 OR ZERO DEPENDING UPON COMPARISON WITH THE THRESHOLD VALUE
	kgateport	port		kgate,0.01		;SMOOTH THE OPENING AND CLOSING OF THE GATE TO PREVENT CLICKS
			aL	=		aL*kgateport	;APPLY THE GATING SIGNAL
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CREATE A PITCH TRACKING VARIABLE AND AN AMPLITUDE TRACKING VARIABLE USING THE 'pitchamdf' OPCODE - IMPROVED RESULTS CAN BE ACHIEVED BY FIRST ATTENUATING THE AMPLITUDE OF THE INPUT SIGNAL, YOU WILL NOTICE THAT 'aL' IS FIRST DIVIDED BY 10
	kSwitch		changed		gkmincps, gkmaxcps, gkinitcps, gkmedi, gkdowns, gkexcps, gkRMSmedi	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if 		kSwitch=1	then			;IF A CHANGE HAS BEEN DETECTED...
			reinit		UPDATE			;BEGIN A REINITIALISATION PASS BEGINNING AT LABEL 'UPDATE'
	endif							;END OF CONDITIONAL BRANCHING
	UPDATE:							;LABEL
	kcps, krms 	pitchamdf	aL, i(gkmincps), i(gkmaxcps), i(gkinitcps), i(gkmedi), i(gkdowns), i(gkexcps), i(gkRMSmedi)	;TRACK PITCH AND RMS
	rireturn							;END OF INITIALISATION PASS
	arms		interp		krms*10		;RECALIBRATE THE AMPLITUDE FOLLOWING SIGNAL UPWARDS - ALSO INTERPOLATE TO CREATE AN A-RATE SIGNAL TO PREVENT CLICKS AS THE AMPLITUDE FLUCTUATES	
	asig		poscil		1, kcps, giWave	;CREATE A SYNTHESIZED TONE THAT MIMICS THE FREQUENCY AND AMPLITUDE ATTRIBUTES OF THE INPUT SIGNAL
	ares 		gain 		asig, krms
	outs		ares, ares	;SEND THE SYNTHESIZED TONE TO THE OUTPUTS
	;;;;;;;;UPDATE METERS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	if		kgate=0	then	;IF GATE IS ON...
		krms=0			;SET RMS TO MINIMUM - THIS IS TO PREVENT ERRATIC METER MOVEMENT WHEN GATE IS ON
		kcps=20			;SET CPS TO MINIMUM - THIS IS TO PREVENT ERRATIC METER MOVEMENT WHEN GATE IS ON
	endif				;END OF CONDITIONAL BRANCHING
	if gkmeters==1 then
		ktrigger	metro		ksmps			;UPDATE RATE FOR METERS
				FLsetVal	ktrigger, krms, gihrms	;UPDATE FLTK METERS
				FLsetVal	ktrigger, kcps, gihcps  ;UPDATE FLTK METERS
	endif
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (THIS ALSO KEEPS PERFORMANCE GOING)
</CsScore>
</CsoundSynthesizer>