; pitch.csd
; Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
;USE DEFAULT AUDIO INPUT AND OUTPUT DEVICES. ADJUSTMENT TO THESE PERFORMANCE FLAGS AND THE ADDITION OF MORE (SUCH AS BUFFER SIZE DEFINITION) MAY BE NEEDED TO OPTIMISE REALTIME PERFORMANCE
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL		WIDTH | HEIGHT | X | Y
	FLpanel		"pitch", 	500,      540,   0,  0

;SWITCHES	  	             				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff, ihOnOff	FLbutton	"On/Off",		1,    0,    22,    140,     25,    5,  5,     0,     1,      0,       -1
gkskip, ihskip		FLbutton	"Skip Initialisation",	1,    0,    22,    140,     25,  175,400,    -1
gkmeters, ihmeters	FLbutton	"Meters On/Off",	1,    0,    22,    120,     20,    5,485,    -1
FLsetColor2	255, 255, 50, ihmeters		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihskip		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL | WIDTH | HEIGHT | X | Y
idupdte				FLvalue	" ",	  80,    20,     5,  65
idlo				FLvalue	" ",	  80,    20,     5, 115
idhi				FLvalue	" ",	  80,    20,     5, 165
iddbthresh			FLvalue	" ",	  80,    20,     5, 215
idstrt				FLvalue	" ",	  80,    20,     5, 315
idq				FLvalue	" ",	  80,    20,     5, 365
idrolloff			FLvalue	" ",	  80,    20,     5, 460
idoct				FLvalue	" ",	  80,    17,     5, 520

;SLIDERS				            					MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkupdte, ihupdte		FLslider 	"Update Period (seconds)",		.001,    .1,   0,    23,  idupdte,    490,    25,     5,   40
gklo, ihlo			FLslider 	"Lower Pitch Detection Limit (oct)",	4,       14,   0,    23,  idlo,       490,    25,     5,   90
gkhi, ihhi			FLslider 	"Upper Pitch Detection Limit (oct)",	4,       14,   0,    23,  idhi,       490,    25,     5,  140
gkdbthresh, ihdbthresh		FLslider 	"Threshold of Detection (db)",		-90,     20,   0,    23,  iddbthresh, 490,    25,     5,  190
gkstrt, ihstrt			FLslider 	"Starting Pitch of Tracker (oct)",	4,       14,   0,    23,  idstrt,     490,    25,     5,  290
gkq, ihq			FLslider 	"Q of Filters",				0,       50,   0,    23,  idq,        490,    25,     5,  340
gkrolloff, ihrolloff		FLslider 	"Rolloff",				.001,   .99,   0,    23,  idrolloff,  490,    25,     5,  435
gk_, gihoct			FLslider 	"Oct Output",				4,       12,   0,    21,  idoct,      490,    15,     5,  505

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkfrqs, ihfrqs 			FLcount  "Octave Divisions",	1,    120,    1,     12,      1,    140,     25,    5, 240,   -1
gkconf, ihconf 			FLcount  "Conformations",	1,    100,    1,      5,      1,    140,     25,  175, 240,   -1
gkocts, ihocts 			FLcount  "Octave Decimations",	1,    100,    1,      5,      1,    140,     25,  350, 240,   -1
gknptls, ihnptls 		FLcount  "No. of Harmonics",	1,     50,    1,      5,      1,    140,     25,    5, 390,   -1

;SET INITIAL VALUES FOR SLIDERS 	VALUE | HANDLE
			FLsetVal_i	.02,	ihupdte
			FLsetVal_i	4,	ihlo
			FLsetVal_i	9,	ihhi
			FLsetVal_i	-10,	ihdbthresh
			FLsetVal_i	120,	ihfrqs
			FLsetVal_i	10,	ihconf
			FLsetVal_i	7,	ihstrt
			FLsetVal_i	6,	ihocts
			FLsetVal_i	10,	ihq
			FLsetVal_i	5,	ihnptls
			FLsetVal_i	.75,	ihrolloff
			FLsetVal_i	0,	ihskip

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      700,  512, 0
				FLscroll     515,      700,    0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           pitch                             ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example presents a simple demonstration of the 'pitch'  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"opcode, used for pitch and amplitude tracking. It requires a ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"live audio input so you should have a microphone connected to", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"your computer and get ready to sing into it!                 ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"'Pitch' outputs two k-rate variables and for frequency and   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"the other for the amplitude of an input audio signal. For    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"clarity, the usage of this data in this example is quite     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"trivial in that it is used merely as input data for the      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"frequency and amplitude of a simple synthesizing oscillator. ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"With a little imagination, many more interesting applications", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"are possible.                                                ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'Update Period' defines the time period over which output    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"data is updated. Higher values here will stabilise the output", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"stream of frequency data at the expense of response time.    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Lower values will allow a faster response to changing pitch. ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"Upper and lower limits of pitch detection can be defined (in ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"the octave point decimal format). Careful setting of these   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"limits can help prevent incorrect pitch detections.          ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"'Threshold of Detection' allows the user to define an        ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"amplitude threshold (in dB) above which detection will begin.", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"Once the threshold is crossed the signal amplitude must drop ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"to beyond 6 dB lower than the threshold before detection     ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"ceases. This parameter can be used to prevent extraneous and ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"environmental noise from triggering the tracking process.    ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"'Octave Divisions' allows us to quantize the number of       ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"allowed pitches in an octave. A setting of 12 will limit the ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"output frequency values to twelve per octave (as in the      ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"equally tempered tuning system). Maximum allowed setting here", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"is 120.                                                      ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"'Conformations' defines the number of confirmations that will", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"be required before the tracker shifts to a higher or lower   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"octave. This parameter can be used to control unstable       ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"jumping between octaves. Experimentation is required to find ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"the appropriate setting.                                     ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"'Starting Pitch of the Tracker' defines the starting pitch   ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"(in oct) of the tracker.                                     ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"'Octave Decimations' defines the number of octave decimations", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"in the spectrum. This may need adjusting depending on the    ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"nature of the sound being tracked. Experimentation is        ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"required.                                                    ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"'Q of Filters' defines the sharpness or resonance of the     ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"analysis filters. Again this should be fine tuned according  ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"to the nature of the sound being tracked. Noisy or spectrally", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"unstable sounds may require lower settings for 'Q' to allow  ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"sucessful pitch tracking.                                    ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"'Number of Partials' defines the number of partials that will", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"be used in the pitch tracking process. Higher values here may", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"facilitate more successful pitch tracking in sounds with a   ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"weak fundemental, but at the expense CPU.                    ", 	1,      5,     14,    490,    20,     5, 1000
ih		 	FLbox  	"'Rolloff' defines the amplitude rolloff (expressed as a      ", 	1,      5,     14,    490,    20,     5, 1020
ih		 	FLbox  	"fraction of an octave) of the filters used in tracking.      ", 	1,      5,     14,    490,    20,     5, 1040
ih		 	FLbox  	"'Skip', if activated, skips initialisation.                  ", 	1,      5,     14,    490,    20,     5, 1060
ih		 	FLbox  	"An alternative opcode for pitch and amplitude tracking worth ", 	1,      5,     14,    490,    20,     5, 1080
ih		 	FLbox  	"investigating is 'pitchamdf'.                                ", 	1,      5,     14,    490,    20,     5, 1100
ih		 	FLbox  	"Pitch tracking is a much more involved and CPU intensive     ", 	1,      5,     14,    490,    20,     5, 1120
ih		 	FLbox  	"process than amplitude tracking. If you only require         ", 	1,      5,     14,    490,    20,     5, 1140
ih		 	FLbox  	"amplitude tracking it is recommended that you use either the ", 	1,      5,     14,    490,    20,     5, 1160
ih		 	FLbox  	"'follow' or 'follow2' opcodes.                               ", 	1,      5,     14,    490,    20,     5, 1180

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 		1
	if gkOnOff==0	then
		turnoff		; TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	asig		inch		1	; READ LEFT INPUT CHANNEL
	kSwitch		changed		gkupdte, gklo, gkhi, gkdbthresh, gkfrqs, gkconf, gkstrt, gkocts, gkq, gknptls, gkrolloff	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch==1 then
	 reinit UPDATE
	endif
	UPDATE:
	;CREATE A PITCH TRACKING VARIABLE AND AN AMPLITUDE TRACKING VARIABLE USING THE 'pitch' OPCODE - IMPROVED RESULTS CAN BE ACHIEVED BY FIRST ATTENUATING THE AMPLITUDE OF THE INPUT SIGNAL, YOU WILL NOTICE THAT 'aL' IS FIRST DIVIDED BY 10
	koct, kamp	pitch		asig/50, i(gkupdte), i(gklo), i(gkhi), i(gkdbthresh), i(gkfrqs), i(gkconf), i(gkstrt), i(gkocts), i(gkq), i(gknptls), i(gkrolloff), i(gkskip)
	rireturn
	kamp		port		kamp, 0.01		; SMOOTH OUT DISCONTINUITIES IN THE AMPLITUDE PARAMETER STREAM
	aamp		interp		kamp/500		; RECALIBRATE THE AMPLITUDE FOLLOWING SIGNAL - ALSO INTERPOLATE TO CREATE AN A-RATE SIGNAL TO PREVENT CLICKS AS THE AMPLITUDE FLUCTUATES
	asig		oscili		aamp, cpsoct(koct), 1	; CREATE A SYNTHESIZED TONE THAT MIMICS THE FREQUENCY AND AMPLITUDE ATTRIBUTES OF THE INPUT SIGNAL
			out		asig			; SEND THE SYNTHESIZED TONE TO THE OUTPUT

	/* METERS */
	if gkmeters==1 then
	 kmetro	metro	ksmps
	 if kmetro==1 then
	  FLsetVal	1,koct,gihoct
	 endif
	endif
endin

</CsInstruments>

<CsScore>
f 1 0 1024 10 1 0.2 0.15 0.1 0.2 0.1 0.05 0.02 0.01	;A RICH TONE - USED BY THE PITCH TRACKING SYNTHESIZER
f 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (THIS ALSO KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>