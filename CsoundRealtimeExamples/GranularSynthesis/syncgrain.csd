syncgrain.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	64	;CONTROL RATE BLOCK SIZE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"syncgrain",   500,    750,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCloudEnv	 	FLbox  	"", 	6,        9,    15,   496,    70,    2, 670	;GRAIN CLOUD ENVELOPE
ihMIDIrouting	 	FLbox  	" ", 	6,        9,    15,   280,    40,   155, 5	;MIDI ROUTING
;TEXT BOXES              			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "MIDI notes to:", 	1,      5,     12,    100,     15,   170, 15
;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkMIDItoDensity,ihMIDItoDensity		FLbutton	"Density",	1,    0,    2,     70,     20,   270, 13,    -1
gkMIDItoPitch,ihMIDItoPitch		FLbutton	"Pitch",	1,    0,    2,     70,     20,   350, 13,    -1
FLsetColor2	100, 100, 255, ihMIDItoDensity		;SET SECONDARY COLOUR TO BLUE
FLsetColor2	100, 100, 255, ihMIDItoPitch		;SET SECONDARY COLOUR TO BLUE
;SWITCHES              						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",	1,    0,    22,    140,     25,    5,  5,     0,     1,      0,      -1
gkfreeze,ihfreeze		FLbutton	"Freeze",	0,    1,    22,     80,     20,  415,225,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihfreeze		;SET SECONDARY COLOUR TO YELLOW

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idamp				FLvalue	" ",     70,      20,    5,  75
idfreq				FLvalue	" ",     70,      20,    5, 125
idpitch				FLvalue	" ",     70,      20,    5, 175
idprate				FLvalue	" ",     70,      20,    5, 225
idgrsize			FLvalue	" ",     70,      20,    5, 275
idAtt	  			FLvalue   " ",    60,    20,     5, 715
idRel	  			FLvalue   " ",    60,    20,   255, 715

;SLIDERS				            				MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider 	"Amplitude",			0,        1,    0,    23,   idamp,       490,     25,    5,  50
gkfreq, ihfreq			FLslider 	"Density (Grain per Sec.)",	1,     2000,   -1,    23,   idfreq,      490,     25,    5, 100
gkpitch, ihpitch		FLslider 	"Pitch",			-2,       2,    0,    23,   idpitch,     490,     25,    5, 150
gkprate, ihprate		FLslider 	"Progress Rate",		-2,       2,    0,    23,   idprate,     490,     25,    5, 200
gkgrsize, ihgrsize		FLslider 	"Grain Size",			.001,     1,   -1,    23,   idgrsize,    490,     25,    5, 250
gkfreqOS, ihfreqOS		FLslider 	"Grain Density Offset",		0,        1,    0,    23,  -1,           490,     25,    5, 570
gksizeOS, ihsizeOS		FLslider 	"Grain Size Random Offset",	0,        1,    0,    23,  -1,           490,     25,    5, 620
gkAtt,ihAtt			FLslider	"Attack Time",			0.05,    10,    0,    23,  idAtt,        240,     25,    5, 690
gkRel,ihRel			FLslider	"Release",			0.05,    10,    0,    23,  idRel,        240,     25,  255, 690

gkwfn, ihwfn	FLcount  "Grain Envelope", 		1,    6,     1,     100,     2,    150,      27,     5,303,  -1 
gksfn, ihsfn	FLcount  "Source Sound", 		1,    3,     1,     100,     2,    150,      27,     5,473,  -1

;TEXT BOXES              									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Half Sine                                     ", 	1,      5,     12,    500,     20,    0, 350
ih		 FLbox  "                 2 - Percussive (straight segments)                ", 	1,      5,     12,    500,     20,    0, 370
ih		 FLbox  "                 3 - Percussive (exponential segments)             ", 	1,      5,     12,    500,     20,    0, 390
ih		 FLbox  "                 4 - Gate (with anti click ramp up and ramp down)  ", 	1,      5,     12,    500,     20,    0, 410
ih		 FLbox  "                 5 - Reverse Percussive (straight segments)        ", 	1,      5,     12,    500,     20,    0, 430
ih		 FLbox  "                 6 - Reverse Percussive (exponential segments)     ", 	1,      5,     12,    500,     20,    0, 450
ih		 FLbox  "Source Sounds    1 - Voice                                         ", 	1,      5,     12,    500,     20,    0, 515
ih		 FLbox  "                 2 - Drums                                         ", 	1,      5,     12,    500,     20,    0, 530
ih		 FLbox  "                 3 - Classical Guitar                              ", 	1,      5,     12,    500,     20,    0, 545
ih		 FLbox	"Grain Cloud Envelope",							1,      3,     12,    130,     15,    5, 671

		FLsetVal_i	0.5, 	ihamp
		FLsetVal_i	20, 	ihfreq
		FLsetVal_i	1, 	ihpitch
		FLsetVal_i	1, 	ihprate
		FLsetVal_i	.05, 	ihgrsize
		FLsetVal_i   	1, 	ihwfn
		FLsetVal_i   	3, 	ihsfn
		FLsetVal_i   	0.05, 	ihAtt
		FLsetVal_i   	0.05, 	ihRel
		FLsetVal_i   	1, 	ihMIDItoPitch
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 600, 512, 0  
				FLscroll     515, 600, 0, 0 
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          syncgrain                          ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Syncgrain offers granular synthesis upon a stored sound file ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"stored in a gen 1 function table.                            ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Syncgrain's strength lies in its use of k-rate control for   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"its main input arguments which encourages real time          ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"manipulation.                                                ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Another distinctive feature of syncgrain is the interaction  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"between the density (kfreq), grain size (kgrsize) and        ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"progress rate (kprate). Density or grain frequency (kfreq)   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"defines the number of grains per second. Higher values for   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"grain density have the effect of increasing the progress rate", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"through the sound file (kprate). Increasing the grain size   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"also increases the rate of progress through the sound file.  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"The progress rate  (kprate) defines the location from where a", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"grain will begin playback as a fraction of the previous      ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"grain's entire trajectory. If progress rate is given a value ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"of 1 then a grain will begin exactly where the previous grain", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"finished. If progress rate is given a value of 0.5 then it   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"will begin at the halfway point of the previous grain's      ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"trajectory. Negative values for progress rate cause the      ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"progress pointer to move backwards through the file (but     ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"playback of each grain is still forwards).                   ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"The user is required to provide an amplitude envelope which  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"is stored in a function table. In this example the user is   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"provided with six grain envelopes from which to choose.      ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"Details are provided on the interface.                       ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"Some additional functions have been added that are not part  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"of the original opcode: 'Grain Density' (frequency) and      ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"'Grain Size' can be randomized. The 'Freeze' button sets     ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"the 'Progress Rate' slider to zero thereby effectively       ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"freezing progress through the sound file.                    ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"This instrument can also be activated via MIDI. MIDI pitch   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"values can be mapped to grain density and/or to the pitch of ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"the material contained within the grain. In the latter       ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"mapping option, middle C is the point at which no            ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"transposition occurs. Using MIDI activation, polyphony is    ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"possible.                                                    ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"The attack and release times of an amplitude envelope applied", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"to the entire grain cloud can be modulated by the user using ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"two on screen sliders. These controls are probably most      ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"useful when triggering this example via MIDI.                ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"material. A 24 bit sound file called 'SyncgrainOutput.wav'   ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"will be created in the default directory for SFDIR.          ", 	1,      5,     14,    490,    20,     5, 940

				FLscrollEnd
				FLpanel_end

;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35,  515, 655
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; THE SOUND FILE USED IN THE GRANULATION
;		NUM | INIT_TIME |  SIZE   | GEN_ROUTINE | FILE_PATH            | IN_SKIP | FORMAT | CHANNEL
gisfn1L	 ftgen	0,        0,        0,          1,       "AndItsAll.wav",            0,       4,        1 ;SYNCLOOP ACCEPTS DEFERRED SIZE (SIZE=0) FUNCTION TABLES 
gisfn2L  ftgen	0,        0,        0,          1,       "808loop.wav",              0,       4,        1 
gisfn3L  ftgen	0,        0,        0,          1,       "ClassicalGuitar.wav",      0,       4,        1 

gisfn1R	 ftgen	0,        0,        0,          1,       "AndItsAll.wav",            0,       4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gisfn2R  ftgen	0,        0,        0,          1,       "808loop.wav",              0,       4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN 
gisfn3R  ftgen	0,        0,        0,          1,       "ClassicalGuitar.wav",      0,       4,        2 ;STEREO FILE SO USE RIGHT CHANNEL

; WINDOWING FUNCTIONS USED TO DYNAMICALLY SHAPE THE GRAINS
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | PARTIAL_NUM | STRENGTH | PHASE
;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
giwfn1	ftgen	0,  0, 131072,  9,   .5, 1, 0 					; HALF SINE
giwfn2	ftgen	0,  0, 131072,  7,    0, 3072,   1, 128000,    0		; PERCUSSIVE - STRAIGHT SEGMENTS
giwfn3	ftgen	0,  0, 131072,  5, .001, 3072,   1, 128000, .001		; PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn4	ftgen	0,  0, 131072,  7,    0, 1536,   1, 128000,    1, 1536, 0	; GATE - WITH DE-CLICKING RAMP UP AND RAMP DOWN SEGMENTS
giwfn5	ftgen	0,  0, 131072,  7,    0, 128000, 1, 3072,      0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
giwfn6	ftgen	0,  0, 131072,  5, .001, 128000, 1, 3072,   .001		; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

instr	1
	iporttime	=	0.1
	kporttime	linseg	0,0.01,iporttime,1,iporttime

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	if	gkOnOff=0&&iMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif
	if iMIDIflag=1&&gkMIDItoDensity=1 then	;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-DENSITY SWITCH IS ON... 
		kfreq	=	icps		;MAP TO MIDI NOTE VALUE TO DENSITY
	else					;OTHERWISE...
		kfreq		portk	gkfreq, kporttime	;USE THE FLTK SLIDER VALUE
	endif					;END OF THIS CONDITIONAL BRANCH
	if iMIDIflag=1&&gkMIDItoPitch=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		kpitch	=	icps/cpsoct(8)		;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
	else					;OTHERWISE...
		kpitch		portk	gkpitch, kporttime	;USE THE FLTK SLIDER VALUE
	endif					;END OF THIS CONDITIONAL BRANCH
	kSwitch		changed		gksfn, gkwfn
	if kSwitch=1	then
	reinit	START
	endif	
	kgrsize		portk	gkgrsize, kporttime
	kprate		portk	gkprate, kporttime
	iolaps		=		2000	;NUMBER OF ALLOWED OVERLAPS - BEST JUST TO GIVE THIS A LARGE CONSTANT VALUE

	kfreqOS		rand		gkfreqOS		;kfreqOS IS A K-RATE RANDOM NUMBER WITHIN THE RANGE -gkfreqOS TO gkfreqOS
	kfreqOS		=		kfreqOS * kfreq		;kfreqOS IS REDEFINED RELATIVE TO THE CURRENT VALUE OF kfreq 
	
	kgrsizeOS	gauss		gksizeOS		;kgrsizeOS IS A K-RATE GAUSSIAN RANDOM NUMBER WITHIN THE RANGE -gksizeOS TO gksizeOS
	kgrsizeOS	=		kgrsizeOS * kgrsize	;kgrsizeOS IS REDEFINED RELATIVE TO THE CURRENT VALUE OF kgrsize 

	START:
	isfnL		=		gisfn1L + i(gksfn) - 1	;FUNCTION TABLE NUMBER FOR SOURCE SOUND FILE IS DERIVED
	isfnR		=		gisfn1R + i(gksfn) - 1	;FUNCTION TABLE NUMBER FOR SOURCE SOUND FILE IS DERIVED
	iwfn		=		giwfn1 + i(gkwfn) - 1	;FUNCTION TABLE NUMBER FOR WINDOWING FUNCTION IS DERIVED
	asigL 		syncgrain	gkamp, kfreq+kfreqOS, kpitch, kgrsize+kgrsizeOS, kprate*gkfreeze, isfnL, iwfn, iolaps	; LEFT CHANNEL
	asigR 		syncgrain	gkamp, kfreq+kfreqOS, kpitch, kgrsize+kgrsizeOS, kprate*gkfreeze, isfnR, iwfn, iolaps	; RIGHT CHANNEL
	rireturn
	aenv		expsegr		0.0001,i(gkAtt),1,i(gkRel),0.0001	; CLOUD AMPLITUDE ENVELOPE
			outs 		asigL*aenv, asigR*aenv
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	aL,aR	monitor
	;	OPCODE	FILENAME               | FORMAT | OUT1  | OUT2 etc...
		fout	"SyncgrainOutput.wav",     8,      aL,     aR	; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
endin

</CsInstruments>

<CsScore>
f 0 3600		;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>