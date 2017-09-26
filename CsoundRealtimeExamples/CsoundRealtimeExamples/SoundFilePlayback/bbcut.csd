;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b400
</CsOptions>


<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL   | WIDTH | HEIGHT | X | Y
	FLpanel	"bbcut",   500,    400,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,    0,    22,    150,     30,    0,  0,     0,     1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gksubdiv,ihsubdiv 	FLcount  "Sub-division", 	1,    512,     1,      4,      1,    150,     25,     0,  50,   -1
gkbarlen,ihbarlen 	FLcount  "Bar Length", 		1,     16,   .25,      1,      1,    150,     25,   175,  50,   -1
gkphrase,ihphrase 	FLcount  "Phrase", 		.1,   512,   .25,      1,      1,    150,     25,   350,  50,   -1
gkrepeats,ihrepeats 	FLcount  "Repeats", 		1,     32,     1,      4,      1,    150,     25,     0, 100,   -1
gkstutspd,ihstutspd 	FLcount  "Stutter Speed", 	1,     32,   .25,      1,      1,    150,     25,   175, 100,   -1
gkstutchnc,ihstutchnc 	FLcount  "Stutter Chance", 	0,      1,   .25,      1,      1,    150,     25,   350, 100,   -1
gkBPM,ihBPM 		FLcount  "BPM", 		20,   500,     1,     10,      1,    150,     25,     0, 150,   -1
gkfltdiv,ihfltdiv 	FLcount  "Filter Div.",		1,     16,     1,      1,      2,    150,     25,     0, 300,   -1

;SLIDERS					            	MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X   | Y
gkDry, ihDry		FLslider 	"Dry Signal Gain",	0,     1,    0,    23,    -1,     290,     20,   205,  150
gkWet, ihWet		FLslider 	"BBCut Signal Gain",	0,     1,    0,    23,    -1,     290,     20,   205,  190
gkFltMix, ihFltMix	FLslider 	"Filter Mix",		0,     1,    0,    23,    -1,     290,     20,   205,  230
gkbw, ihbw		FLslider 	"Bandwidth",		0.01, 10,    0,    23,    -1,     290,     20,   205,  270
gkcfmin, ihcfmin	FLslider 	"",			50,10000,   -1,    23,    -1,     290,     10,   205,  310
gkcfmax, ihcfmax	FLslider 	"Cutoff Freq.",		50,10000,   -1,    23,    -1,     290,     10,   205,  320
gki_h, ihi_h		FLslider 	"Interpolate<=>S&H",	0,     1,    0,    23,    -1,     290,     20,   205,  350

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput	FLbutBank	4,     1,     2,     20,    50,     10, 200,   -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN


;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       2,    12,    70,      25,   30,  200
ih		 	FLbox  	"Stored File", 		1,       2,    12,    70,      25,   30,  225

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	8, 	ihsubdiv
			FLsetVal_i	2, 	ihbarlen
			FLsetVal_i	8, 	ihphrase
			FLsetVal_i	2, 	ihrepeats
			FLsetVal_i	4, 	ihstutspd
			FLsetVal_i	1, 	ihstutchnc
			FLsetVal_i	110, 	ihBPM
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	0.5, 	ihDry
			FLsetVal_i	0.5, 	ihWet
			FLsetVal_i	0.9, 	ihFltMix
			FLsetVal_i	0.3, 	ihbw
			FLsetVal_i	1, 	ihi_h
			FLsetVal_i	1, 	ihfltdiv
			FLsetVal_i	400, 	ihcfmin
			FLsetVal_i	5000, 	ihcfmax

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      700,  512, 0
				FLscroll     515,      700,    0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      bbcutm/bbcuts                          ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"bbcutm/bbcuts performs break-beat style cut-ups upon an input", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"audio signal. (bbcutm/bbcuts represents mono and stereo      ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"versions of the same basic algorithm.)                       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"In order to create rhythmically precise cut-ups it is        ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"necessary for the input audio loop to begin at the same time ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"that the opcode is triggered and for the tempo argument given", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"to the bbcuts/bbcutm opcode to correspond to that of the     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"input loop audio. This requires some planning and in this    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"example this is implemented by playing the audio loop using  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"the tablei opcode.                                           ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"Of course there is no reason why bbcutm/bbcutm cannot be     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"applied to unmetered sound material or even a live input     ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"signal. This example also provides the option of selecting   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"the computer's live input as the sound source. If the live   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"input is used then the results can be more aleatoric than    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"rhymical.                                                    ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"Bbcuts/bbcutm takes a variety of input arguments that        ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"determine the precise nature of the cut-ups executed.        ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"'Sub-division' determines the note duration used as the base ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"unit in  cut-ups. For example a value of 8 represents quavers", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"(eighth notes), 16 represents semiquavers (sixteenth notes)  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"and so on.                                                   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"'Bar Length' represents the number of beats per bar. For     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"example, a value of 4 represents a 4/4 bar and so on.        ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"'Phrase' defines the number of bars that will elapse before  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"the cutting up pattern restarts from the beginning.          ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"'Stutter' is a separate cut-up process which occasionally    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"will take a very short fragment of the input audio and repeat", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"it many times. 'Stutter Speed' defines the duration of each  ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"stutter in relation to 'Sub-division'. If subdivision is 8   ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"(quavers / eighth notes) and 'Stutter Speed' is 2 then each  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"stutter will be a semiquaver / sixteenth note.               ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"'Stutter Chance' defines the frequency of stutter moments.   ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"The range for this parameter is 0 to 1. Zero means stuttering", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"will be very unlikely, 1 means it will be very likely.       ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"'Repeats' defines the number of repeats that will be employed", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"in normal cut-up events.                                     ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"When processing non-rhythmical, unmetered material it may be ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"be more interesting to employ non-whole numbers for          ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"parameters such as 'Sub-division', 'Phrase' and 'Stutter     ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"Speed'.                                                      ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"Additionally in this example a randomly moving band-pass     ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"filter has been implemented. 'Filter Mix' crossfades between ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"the unfiltered bbcut signal and the filtered bbcut signal.   ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"'Cutoff Freq.' consists of two small sliders which determine ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"the range from which random cutoff values are derived.       ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"'Interpolate<=>S&H' fades continuously between an            ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"interpolated random function and a sample and hold type      ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"random function. 'Filter Div.' controls the frequency        ", 	1,      5,     14,    490,    20,     5, 1000
ih		 	FLbox  	"subdivision with which new random cutoff frequency values are", 	1,      5,     14,    490,    20,     5, 1020
ih		 	FLbox  	"generated - a value of '1' means that new values are         ", 	1,      5,     14,    490,    20,     5, 1040
ih		 	FLbox  	"generated once every bar.                                    ", 	1,      5,     14,    490,    20,     5, 1060

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	
	inumbar		=	2		;NUMBER OF BARS IN THE INPUT SOUND FILE
	kBarPS		=	gkBPM/240	;DERIVE BARS PER SECOND
	
	kSwitch	changed		gkBPM, gkrepeats, gkphrase, gkstutspd, gkstutchnc, gkbarlen, gksubdiv, gkinput, gkfltdiv	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	
	if		gkinput==1 then			;IF 'INPUT' SWITCH IS SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		ifn		=	1		;FUNCTION TABLE
		aptr		phasor	kBarPS/inumbar	;CREATE A MOVING PHASE VALUE
		ain		tablei	aptr*nsamp(ifn), ifn	;READ AUDIO FROM TABLE
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		ain, aignore	ins			;READ AUDIO FROM THE COMPUTER'S LIVE INPUT (LEFT INPUT ONLY IS READ, RIGHT CHANNEL IS IGNORED IN SUBSEQUENT CODE. A STEREO VERSION COULD EASILY BE BUILT BUT THIS WOULD DOUBLE CPU DEMANDS!)
	endif						;END OF 'IF'...'THEN' BRANCHING
	
	;OUTPUT		OPCODE	INPUT |   BPM      | SUBDIVISION | BAR_LENGTH | PHRASE_LENGTH | NUM.OF_REPEATS | STUTTER_SPEED | STUTTER_CHANCE	
	abbcutL		bbcutm	ain,   i(gkBPM)/60, i(gksubdiv),  i(gkbarlen),   i(gkphrase),    i(gkrepeats),   i(gkstutspd),   i(gkstutchnc)
	abbcutR		bbcutm	ain,   i(gkBPM)/60, i(gksubdiv),  i(gkbarlen),   i(gkphrase),    i(gkrepeats),   i(gkstutspd),   i(gkstutchnc)
	;bbcutm IS THE MONO VERSION OF THE BREAK BEAT CUTTER

	;FILTER=================================================================================================================================================================
	kfreq	=	(kBarPS*gkfltdiv)/inumbar	;FREQUENCY WITH WHICH NEW FILTER CUTOFF VALUES ARE GENERATED			;LEFT CHANNEL
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES

	kcf1h	randomh	gkcfmin, gkcfmax, kfreq		;SAMPLE AND HOLD RANDOM FREQUENCY VALUES					;LEFT CHANNEL
	kcf1i	lineto		kcf1h, 1/kfreq		;INTERPOLATE VALUES								;LEFT CHANNEL
	kcf1	ntrpol		kcf1i, kcf1h, gki_h   	;CROSSFADE BETWEEN INTERPOLATING AND SAMPLE AND HOLD TYPE RANDOM VALUES		;LEFT CHANNEL
	abbFltL	reson	abbcutL, kcf1, kcf1*gkbw, 2	;BAND-PASS FILTER								;LEFT CHANNEL
	abbMixL	ntrpol	abbcutL, abbFltL, gkFltMix	;CROSSFADE BETWEEN UNFILTERED AND FILTER AUDIO SIGNAL				;LEFT CHANNEL
	kcf2h	randomh	gkcfmin, gkcfmax, kfreq		;SAMPLE AND HOLD RANDOM FREQUENCY VALUES					;RIGHT CHANNEL
	kcf2i	lineto		kcf2h, 1/kfreq		;INTERPOLATE VALUES                                                             ;RIGHT CHANNEL
	kcf2	ntrpol		kcf2i, kcf2h, gki_h   	;CROSSFADE BETWEEN INTERPOLATING AND SAMPLE AND HOLD TYPE RANDOM VALUES		;RIGHT CHANNEL
	abbFltR	reson	abbcutR, kcf2, kcf2*gkbw, 2	;BAND-PASS FILTER								;RIGHT CHANNEL
	abbMixR	ntrpol	abbcutR, abbFltR, gkFltMix	;CROSSFADE BETWEEN UNFILTERED AND FILTER AUDIO SIGNAL				;RIGHT CHANNEL
	;=======================================================================================================================================================================
	
	amixL	sum	ain*gkDry, abbMixL*gkWet	;SUM AND MIX DRY SIGNAL AND BBCUT SIGNAL (LEFT CHANNEL)
	amixR	sum	ain*gkDry, abbMixR*gkWet	;SUM AND MIX DRY SIGNAL AND BBCUT SIGNAL (RIGHT CHANNEL)
	outs	amixL, amixR				;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
;FUNCTION_TABLE_NUMBER | INIT_TIME | TABLE_SIZE | GEN_ROUTINE |  FILE_PATH  | INSKIP | FORMAT | CHANNEL 
f          1                 0         524289         -1        "loop.wav"       0       4         1
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
