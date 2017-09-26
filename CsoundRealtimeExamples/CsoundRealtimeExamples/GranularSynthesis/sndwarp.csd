sndwarp.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"sndwarp",   500,    750,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCloudEnv	 	FLbox  	"", 	6,        9,    15,   496,    65,    2, 680	;GRAIN CLOUD ENVELOPE

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ihMIDIrouting	 	FLbox  	" ", 	6,        9,    15,    280,    40,    1, 635	;MIDI ROUTING
;TEXT BOXES              			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "MIDI notes to:", 	1,      5,     12,    100,     15,   12, 645
;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkMIDItoWindow,ihMIDItoWindow		FLbutton	"Window",	1,    0,    2,     70,     20,   114, 641,    -1
gkMIDItoPitch,ihMIDItoPitch		FLbutton	"Pitch",	1,    0,    2,     70,     20,   194, 641,    -1
FLsetColor2	100, 100, 255, ihMIDItoWindow		;SET SECONDARY COLOUR TO BLUE
FLsetColor2	100, 100, 255, ihMIDItoPitch		;SET SECONDARY COLOUR TO BLUE

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp		FLvalue   "",	 80,      20,    5, 135
idptr		FLvalue   "",	 80,      20,    5, 185
idstretch	FLvalue   "",	 80,      20,    5, 235
idpch		FLvalue   "",	 80,      20,    5, 285
idwsize		FLvalue   "",	 80,      20,    5, 335
idrnd		FLvalue   "",	 80,      20,    5, 385
idbeg		FLvalue   "",	 80,      20,    5, 435
idAtt	  	FLvalue   "",    60,      20,    5, 725
idRel	  	FLvalue   "",    60,      20,  255, 725

;SWITCHES                                               ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,    145,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  |  Y | OPCODE 
gkolap, iholap		FLcount  "Number of Overlaps",		1,    200,    1,      20,     1,    150,      25,   175,   5,   -1
gkmode, ihmode		FLcount  "0-Warp 1-Pointer", 		0,    1,      1,       1,     2,    140,      25,   355,   5,   -1
gkwfn, ihwfn		FLcount  "Grain Envelope", 		1,    6,      1,     100,     2,    140,      25,     5, 463,   -1 
gkinput, ihinput	FLcount  "Sound File Input", 		1,    3,      1,     100,     2,     150,     25,   175,  50,   -1 

;TEXT BOXES              									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Half Sine                                     ", 	1,      5,     12,    500,     20,    0, 510
ih		 FLbox  "                 2 - Percussive (straight segments)                ", 	1,      5,     12,    500,     20,    0, 530
ih		 FLbox  "                 3 - Percussive (exponential segments)             ", 	1,      5,     12,    500,     20,    0, 550
ih		 FLbox  "                 4 - Gate (with anti click ramp up and ramp down)  ", 	1,      5,     12,    500,     20,    0, 570
ih		 FLbox  "                 5 - Reverse Percussive (straight segments)        ", 	1,      5,     12,    500,     20,    0, 590
ih		 FLbox  "                 6 - Reverse Percussive (exponential segments)     ", 	1,      5,     12,    500,     20,    0, 610
ih		 FLbox  "1 - Voice . 2 - Drum Loop . 3 - Classical Guitar",			1,      1,     12,    500,     15,    0,  90
ih		 FLbox	"Grain Cloud Envelope",							1,       3,    12,    130,     15,    5,  681

;SLIDERS				      						MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkamp,ihamp		FLslider	"Amplitude  (Portamento Applied)",		0,     1,    0,    23,   idamp,      490,     25,    5,   110
gkptr,ihptr		FLslider	"Pointer  (Portamento Applied)",  		0,     1,    0,    23,   idptr,      490,     25,    5,   160
gkstretch,ihstretch	FLslider	"Stretch Factor",				1,     50,   0,    23,   idstretch,  490,     25,    5,   210
gkpch,ihpch		FLslider	"Pitch (Portamento Applied)",			0.01,   8,   -1,    23,   idpch,      490,     25,    5,   260
gkwsize,ihwsize		FLslider	"Window Size (i-rate)",				1,    40000,-1,    23,   idwsize,    490,     25,    5,   310
gkrnd,ihrnd		FLslider	"Randomization Factor (i-rate)",		0,    10000, 0,    23,   idrnd,      490,     25,    5,   360
gkbeg,ihbeg		FLslider	"Inskip into Source Sound File (i-rate)",	0,    1,     0,    23,   idbeg,      490,     25,    5,   410
gkporttime,ihporttime	FLslider 	"Portamento Amount",				0,    1,     0,    23,      -1,      344,     16,  153,   460
gkAtt,ihAtt		FLslider	"Attack Time",					0.05,10,     0,    23,   idAtt,      240,     25,    5,   700
gkRel,ihRel		FLslider	"Release",					0.05,10,     0,    23,   idRel,      240,     25,  255,   700

; INITIALISATION OF SLIDERS AND COUNTERS
		FLsetVal_i   	0.3, 	ihamp
		FLsetVal_i   	8, 	iholap
		FLsetVal_i   	0, 	ihmode
		FLsetVal_i   	.1, 	ihptr
		FLsetVal_i   	5, 	ihstretch
		FLsetVal_i   	1, 	ihpch
		FLsetVal_i   	1500, 	ihwsize
		FLsetVal_i   	1000, 	ihrnd
		FLsetVal_i   	1, 	ihwfn
		FLsetVal_i   	0, 	ihbeg
		FLsetVal_i	0.02, 	ihporttime
		FLsetVal_i   	3, 	ihinput
		FLsetVal_i   	0.05, 	ihAtt
		FLsetVal_i   	0.05, 	ihRel
		FLsetVal_i   	1, 	ihMIDItoPitch

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          sndwarp                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"sndwarp performs granular synthesis upon a stored function   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"table by employing either a timestretch (as in the 'granule' ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"opcode) or by making use of a time pointer (as in 'pvoc').   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The user can select between these two modes using sndwarp's  ", 	1,      5,     14,    490,    20,     5, 100 
ih		 	FLbox  	"'itimemode' input argument. Giving 'itimemode' a value of    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"zero means that a time stretching factor will be applied,    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"giving it a value of 1 means that a pointer variable will be ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"used to define from where within the source file grains      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"begin. On account of sndwarp's dual function nature, its     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"input argument 'xtimewarp' can mean two different things     ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"dependant upon the value of 'itimemode'. When itimemode=0    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'xtimewarp' defines the time-stretch factor, when itimemode=1", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'xtimewarp' defines the pointer location in seconds.         ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"For convenience in this example 'xtimewarp' is represented by", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"two different sliders, 'Pointer' and 'Stretch Factor'. The   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"appropriate slider will be chosen by the code for the value  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"of 'xtimewarp' depending upon the current setting for the    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"'Warp/Pointer' switch. Therefore when the switch is on 'Warp'", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"the 'Pointer' slider has no effect (and vice versa).         ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Instead of defining grain sizes in seconds 'sndwarp' refers  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"to grains as 'windows'. In effect, grain size is defined in  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"samples using the 'Window Size' slider (iwsize). The         ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"'Randomization' slider (irandw) applies randomization to the ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"value for 'Window Size' (iwsize). This value defines the     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"bandwidth of a random number generator. The random numbers   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"will be added to 'Window Size' (iwsize).                     ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"The density of the granular synthesis texture produced is    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"controlled using the 'Number of Overlaps' (ioverlap)         ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"parameter.                                                   ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"The pitch of the granular synthesis texture produced can be  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"rescaled using the 'Pitch' slider (xresample).               ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"1=no transposition, 2=up one octave, 0.5=down one octave and ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"so on.                                                       ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"The user must supply a windowing function via a function     ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"table that the opcode will use to apply an amplitude envelope", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"to each grain. In this example six different envelope types  ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"are offered for experimentation. Descriptions of the         ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"different types on offer are included on the main panel. To  ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"hear most clearly the effect of using different grain        ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"envelopes set 'Number of Overlaps' to a 1 value and set      ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"'Window Size' to a large number.                             ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"'Inskip into Source Sound File' (ibeg) allows the user to    ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"define where the opcode will begin reading grains from. If   ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"this value is zero 'sndwarp' will begin reading grains from  ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"the beginning of the source sound file.                      ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"The attack and release times of an amplitude envelope applied", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"to the entire grain cloud can be modulated by the user using ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"two on screen sliders. These controls are probably most      ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"useful when triggering this example via MIDI.                ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"material. A 24 bit sound file called 'Grain3Output.wav' will ", 	1,      5,     14,    490,    20,     5,1100
ih		 	FLbox  	"be created in the default directory for SFDIR.               ", 	1,      5,     14,    490,    20,     5,1120
                                
				FLscrollEnd
				FLpanel_end

;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35, 512, 755
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS
garecL		init		0	;INITIALIZE RECORD SIGNAL AUDIO VARIABLE LEFT CHANNEL (TO ZERO / SILENCE)
garecR		init		0	;INITIALIZE RECORD SIGNAL AUDIO VARIABLE LEFT CHANNEL (TO ZERO / SILENCE)

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; THE SOUND FILES USED IN THE GRANULATION
;              NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH          | IN_SKIP | FORMAT | CHANNEL
gifile1L ftgen 0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 
gifile2L ftgen 0,        0,     524288,       1,    "loop.wav",               0,        4,        1 
gifile3L ftgen 0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        1 

gifile1R ftgen 0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile2R ftgen 0,        0,     524288,       1,    "loop.wav",               0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile3R ftgen 0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        2 ;STEREO FILE SO USE RIGHT CHANNEL

;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
giwfn1	ftgen	0,  0, 131072,  9,   .5, 1, 	0 				; HALF SINE
giwfn2	ftgen	0,  0, 131072,  7,    0, 3072,  1, 128000,     0		; PERCUSSIVE - STRAIGHT SEGMENTS
giwfn3	ftgen	0,  0, 131072,  5, .001, 3072,  1, 128000, 0.001		; PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn4	ftgen	0,  0, 131072,  7,    0, 1536,  1, 128000,     1, 1536, 0	; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
giwfn5	ftgen	0,  0, 131072,  7,    0, 128000,1, 3072,       0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
giwfn6	ftgen	0,  0, 131072,  5, .001, 128000,1, 3072,   0.001		; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

instr	1
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	if	gkOnOff=0&&iMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif

	kSwitch	changed	gkolap, gkmode, gkwsize, gkrnd, gkwfn, gkbeg, gkinput	; IF ANY OF THE INPUT VARIABLES CHANGE GENERATE A MOMETARY '1' TRIGGER AT THE OUTPUT
	if	kSwitch=1	then						; IF ANY OF THE INPUT VARIABLES ABOVE HAVE CHANGED SINCE THE PREVIOUS K-RATE PASS...
		reinit	START							; BEGIN A REINITIALISATION PASS FROM LABEL NAMED 'START'
	endif									; END OF CONDITIONAL BRANCH
	START:									; LABEL CALLED 'START'

	kporttime	linseg	0, 0.1, 1		;USE OF A RAMPING UP ENVELOPE PREVENTS GLIDING PARAMETERS EACH TIME A NOTE IS RESTARTED
	kporttime	=	kporttime * gkporttime	;FLTK SLIDER FOR PORTAMENTO TIME MULTIPLIED TO kporttime FUNCTION

	if iMIDIflag=1&&gkMIDItoPitch=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		kpch	=	icps/cpsoct(8)		;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
	else					;OTHERWISE...
		kpch		portk	gkpch, kporttime		;PORTAMENTO APPLIED TO PARAMETER TO SMOOTH CHANGES
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1&&i(gkMIDItoWindow)=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		iwsize=sr/icps
	else					;OTHERWISE...
		iwsize		=	i(gkwsize)		;WINDOW SIZE (CONVERTED TO I-RATE)
	endif					;END OF THIS CONDITIONAL BRANCH

	kptr		portk	gkptr,kporttime		;PORTAMENTO APPLIED TO PARAMETER TO SMOOTH CHANGES
	kamp		portk	gkamp,kporttime		;PORTAMENTO APPLIED TO PARAMETER TO SMOOTH CHANGES

	isfnL 		= 	gifile1L + i(gkinput) - 1	;SOURCE SOUND FILE FUNCTION TABLE 
	isfnR 		= 	gifile1R + i(gkinput) - 1	;SOURCE SOUND FILE FUNCTION TABLE 
	iwfn 		= 	giwfn1 + i(gkwfn) - 1		;WINDOW FUNCTION
	ilen 		= 	nsamp(isfnL) / sr		;DURATION (IN SECONDS) OF THE SOURCE SOUND FILE IS DERIVED
	imode 		= 	i(gkmode) 		;ENTER WARP MODE: 1=POINTER / 0=PLAYBACK SPEED WARP
	ibeg 		= 	i(gkbeg)		;INSKIP (0=BEGINNING OF FILE)
	iolap 		= 	i(gkolap)		;NUMBER OF OVERLAPS (CONVERTED TO I-RATE)
	kptr	 	=	kptr*ilen		;DERIVE POINTER POSITION RELATIVE TO THE ACTUAL DURATION OF THE FILE USED
	
	kptr		limit	kptr,0,ilen-((iwsize+i(gkrnd))/sr)
	
	irnd		=	i(gkrnd)		;RANDOMIZATION OF WINDOW SIZE
	kwarp		=	(imode == 0 ? gkstretch : kptr )	;CHOOSE WHETHER TO USE 'STRETCH FACTOR' OR 'POINTER POSITION'
									;ACCORDING TO THE STATUS OF 'imode'
	apch		interp	kpch			;interpolating pitch transposition control to a-rate improves sound quality whenever this control is modulated
	asigL 		sndwarp kamp, kwarp, apch, isfnL, ibeg, iwsize, irnd, iolap, iwfn, imode
	asigR 		sndwarp kamp, kwarp, apch, isfnR, ibeg, iwsize, irnd, iolap, iwfn, imode
	rireturn
	aenv	expsegr	0.0001,i(gkAtt),1,i(gkRel),0.0001	; CLOUD AMPLITUDE ENVELOPE
	asigL	=	asigL * aenv	;APPLY AMPLITUDE ENVELOPE
	asigR	=	asigR * aenv	;APPLY AMPLITUDE ENVELOPE
	garecL	=	garecL + asigL				;ADD GRANULAR SYNTHESIS SIGNAL TO GLOBAL AUDIO RECORD SIGNAL VARIABLE
	garecR	=	garecR + asigR				;ADD GRANULAR SYNTHESIS SIGNAL TO GLOBAL AUDIO RECORD SIGNAL VARIABLE
		outs 	asigL, asigR				;SEND AUDIO TO OUTPUTS
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	aL,aR	monitor
	;	OPCODE	FILENAME               | FORMAT | OUT1  | OUT2 etc...
		fout	"sndwarpOutput.wav",       8,      aL,     aR	; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>