pluck.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0	;VIRTUAL MIDI KEYBOARD
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL   | WIDTH | HEIGHT | X | Y
	FLpanel	"pluck",   500,    400,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Pluck!",	1,    0,    21,    190,     25,    5,  5,    0,      1,      0,       -1

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X |  Y
idamp			FLvalue	" ",      100,    20,     5,  175
idcps			FLvalue	" ",      100,    20,     5,  225
idantcps		FLvalue	" ",      100,    20,     5,  275
idparm1			FLvalue	" ",      100,    20,     5,  325
idparm2			FLvalue	" ",      100,    20,     5,  375

;SLIDERS				            			MIN |  MAX  | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X  | Y
gkamp,ihamp		FLslider 	"Amplitude",			0,        1,   0,    23,   idamp,       490,     25,    5,  150
gkcps,ihcps		FLslider 	"Frequency",			1,    20000,  -1,    23,   idcps,       490,     25,    5,  200
gkantcps,ihantcps	FLslider 	"Frequency (Buffer) (i-rate)",	1,    20000,  -1,    23,   idantcps,    490,     25,    5,  250
gkparm1, ihparm1	FLslider 	"Smoothing Parameter 1", 	0,        1,   0,    23,   idparm1,     490,     25,    5,  300
gkparm2, ihparm2	FLslider 	"Smoothing Parameter 2", 	0,        1,   0,    23,   idparm2,     490,     25,    5,  350

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkmeth, ihmeth 			FLcount  "Decay Type (i-rate)", 	1,     6,    1,       1,     2,     140,     25,   205, 5,    -1
gkfn, ihfn 			FLcount  "Initial Buffer", 		0,     1,    1,       1,     2,     140,     25,   355, 5,    -1

;TEXT BOXES																				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Decay Type: 1=Simple Averaging   2=Stretched Averaging   3=Simple Drum   4=Stretched drum   5=Weighted Averaging   6=Recursive Filter",1,       9,    12,    500,    30,     0,  50
ih		 	FLbox  	"Initial Buffer: 0=Random Noise   1=Flat Pulse", 											1,       9,    12,    500,    30,     0,  100

;SET INITIAL VALUES OF FLTK VALUATORS
;					VALUE | HANDLE
			FLsetVal_i	0.2, 	ihamp
			FLsetVal_i	400, 	ihcps
			FLsetVal_i	400, 	ihantcps
			FLsetVal_i	1, 	ihmeth
			FLsetVal_i	0, 	ihfn
			FLsetVal_i	0, 	ihparm1
			FLsetVal_i	0, 	ihparm2

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           pluck                             ", 	1,       5,    14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    20,     5,  20
ih		 	FLbox  	"pluck is an implementation of the Karplus-Strong algorithm   ", 	1,       5,    14,    490,    20,     5,  40
ih		 	FLbox  	"for spectrally decaying plucked string and drum sounds.      ", 	1,       5,    14,    490,    20,     5,  60
ih		 	FLbox  	"The main frequency control ('kcps' in the manual) controls   ", 	1,       5,    14,    490,    20,     5,  80
ih		 	FLbox  	"the pitch of the sound (in the case of a resonant plucked    ", 	1,       5,    14,    490,    20,     5, 100
ih		 	FLbox  	"string sound) and the timbre of the sound (in the case of an ", 	1,       5,    14,    490,    20,     5, 120
ih		 	FLbox  	"unpitched snare drum-like sound). The other frequency        ", 	1,       5,    14,    490,    20,     5, 140
ih		 	FLbox  	"argument ('icps' in the manual) defines the frequency at     ", 	1,       5,    14,    490,    20,     5, 160
ih		 	FLbox  	"which a buffer is updated. In audible terms this amounts to  ", 	1,       5,    14,    490,    20,     5, 180
ih		 	FLbox  	"how quickly the sound spectrum decays, i.e. damping.         ", 	1,       5,    14,    490,    20,     5, 200
ih		 	FLbox  	"A specific stored function can be used to initially fill the ", 	1,       5,    14,    490,    20,     5, 220
ih		 	FLbox  	"cyclic buffer used by the algorithm of the algorithm can be  ", 	1,       5,    14,    490,    20,     5, 240
ih		 	FLbox  	"instructed to fill it with random values therefore resulting ", 	1,       5,    14,    490,    20,     5, 260
ih		 	FLbox  	"in initial wideband noise. In this example the user can      ", 	1,       5,    14,    490,    20,     5, 280
ih		 	FLbox  	"choose between random noise and a flat source (wide pulse).  ", 	1,       5,    14,    490,    20,     5, 300
ih		 	FLbox  	"When using 1, 2, 5 or 6 for 'Decay Type', random noise is    ", 	1,       5,    14,    490,    20,     5, 320
ih		 	FLbox  	"recommended and when using 3 or 4 for 'Decay Type' the flat  ", 	1,       5,    14,    490,    20,     5, 340
ih		 	FLbox  	"pulse setting is recommended.                                ", 	1,       5,    14,    490,    20,     5, 360
ih		 	FLbox  	"The functioning of the two decay parameter variables is      ", 	1,       5,    14,    490,    20,     5, 380
ih		 	FLbox  	"dependent upon which decay method has been chosen. (def.=0)  ", 	1,       5,    14,    490,    20,     5, 400
ih		 	FLbox  	"Six decay methods are offered and are as follows:            ", 	1,       5,    14,    490,    20,     5, 420
ih		 	FLbox  	"1. simple averaging. A simple smoothing process, uninfluenced", 	1,       5,    14,    490,    20,     5, 440
ih		 	FLbox  	"by parameter values.                                         ", 	1,       5,    14,    490,    20,     5, 460
ih		 	FLbox  	"2. stretched averaging. As above, but with smoothing time    ", 	1,       5,    14,    490,    20,     5, 480
ih		 	FLbox  	"stretched by a factor of iparm1 (iparm1 must=1).             ", 	1,       5,    14,    490,    20,     5, 500
ih		 	FLbox  	"3. simple drum. The range from pitch to noise is controlled  ", 	1,       5,    14,    490,    20,     5, 520
ih		 	FLbox  	"by a 'roughness factor' in iparm1 (0 to 1). Zero gives the   ", 	1,       5,    14,    490,    20,     5, 540
ih		 	FLbox  	"plucked string effect, while 1 reverses the polarity of every", 	1,       5,    14,    490,    20,     5, 560
ih		 	FLbox  	"sample (octave down, odd harmonics). The setting .5 gives an ", 	1,       5,    14,    490,    20,     5, 580
ih		 	FLbox  	"optimum snare drum.                                          ", 	1,       5,    14,    490,    20,     5, 600
ih		 	FLbox  	"4. stretched drum. Combines both roughness and stretch       ", 	1,       5,    14,    490,    20,     5, 620
ih		 	FLbox  	"factors. iparm1 is roughness (0 to 1), and iparm2 the stretch", 	1,       5,    14,    490,    20,     5, 640
ih		 	FLbox  	"factor (iparm2 must=1).                                      ", 	1,       5,    14,    490,    20,     5, 660
ih		 	FLbox  	"5. weighted averaging. As method 1, with iparm1 weighting the", 	1,       5,    14,    490,    20,     5, 680
ih		 	FLbox  	"current sample (the status quo) and iparm2 weighting the     ", 	1,       5,    14,    490,    20,     5, 700
ih		 	FLbox  	"previous adjacent one. iparm1 + iparm2must be <= 1.          ", 	1,       5,    14,    490,    20,     5, 720
ih		 	FLbox  	"6. 1st order recursive filter, with coefs .5. Unaffected by  ", 	1,       5,    14,    490,    20,     5, 740
ih		 	FLbox  	"parameter values.                                            ", 	1,       5,    14,    490,    20,     5, 760
ih		 	FLbox  	"This instrument can also be activated via MIDI. It will be   ", 	1,       5,    14,    490,    20,     5, 780
ih		 	FLbox  	"velocity sensitive and will respond to pitch bend            ", 	1,       5,    14,    490,    20,     5, 800
ih		 	FLbox  	"information.                                                 ", 	1,       5,    14,    490,    20,     5, 820

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gipulse	ftgen 1, 0, 4096, 7, 1, 4096, 1		;A WIDE FLAT PULSE WAVEFORM

instr 	1
	kporttime	linseg	0,0.01,0.05		;PORTAMENTO TIME RAMPS UP QUICKLY FROM ZERO
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	ivel	veloc		0,1		;READ NOTE VELOCITY. WILL BE WITHIN THE RANGE 0 AND 1
	kbend	pchbend		0,2		;PITCH BEND VARIABLE (IN oct FORMAT)

	if gkOnOff==0&&iMIDIflag==0 then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
	 turnoff				;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag==1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		kcps	=	icps*semitone(kbend)	;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		kamp	=	gkamp * ivel
	else						;OTHERWISE...
		kcps		portk	gkcps, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp		portk	gkamp, kporttime		;APPLY PORTAMENTO SMOOTHING
	endif						;END OF THIS CONDITIONAL BRANCH

	asig	pluck	kamp, kcps, i(gkantcps), i(gkfn), i(gkmeth), i(gkparm1), i(gkparm2)
	aenv	linsegr	1,0.1,0
		out	asig*aenv
endin
	
</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>