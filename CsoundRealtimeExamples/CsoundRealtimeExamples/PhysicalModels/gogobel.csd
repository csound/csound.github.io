gogobel.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;COMMENT OR UNCOMMENT CSOUND FLAGS AS REQUIRED
;-odac -M0 -dm0				;EXTERNAL MIDI
-odac -M0 -+rtmidi=virtual -dm0		;VIRTUAL MIDI DEVICE
;-odac -dm0				;NO MIDI DEVICE
</CsOptions>

<CsInstruments>

sr 		= 	22050	;SAMPLE RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL      | WIDTH | HEIGHT | X | Y
		FLpanel	"gogobel",   500,    350,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"Strike!",	1,    0,    21,    200,     30,    5,  5,    0,      1,      0,       -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      80,      18,    5,   75
idfreq		FLvalue	" ",      80,      18,    5,  125
idhrd		FLvalue	" ",      80,      18,    5,  175
idpos		FLvalue	" ",      80,      18,    5,  225
idvibf		FLvalue	" ",      80,      18,    5,  275
idvamp		FLvalue	" ",      80,      18,    5,  325

;SLIDERS				            					MIN |  MAX  |  EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y
gkamp, gihamp			FLslider	"Amplitude",				0,        1,    0,    23,   idamp,    490,    25,     5,    50
gkfreq, gihfreq			FLslider	"Frequency",				20,   10000,   -1,    23,   idfreq,   490,    25,     5,   100
gkhrd, ihhrd			FLslider	"Stick Hardness",			0,        1,    0,    23,   idhrd,    490,    25,     5,   150
gkpos, ihpos			FLslider	"Strike Position",			0,        1,    0,    23,   idpos,    490,    25,     5,   200
gkvibf,ihvibf			FLslider 	"Vibrato Frequency",			0,       15,    0,    23,   idvibf,   490,    25,     5,   250
gkvamp,ihvamp			FLslider 	"Vibrato Amplitude",			0,        1,    0,    23,   idvamp,   490,    25,     5,   300

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkimp, ihimp			FLbutBank	3,      1,      2,    18,      40,   330, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"IMPULSE:", 		1,       6,    14,     60,      20,  270,   0
ih		 	FLbox  	"marmstk1", 		1,       5,    14,     60,      20,  350,   0
ih		 	FLbox  	"bounce  ", 		1,       5,    14,     60,      20,  350,  20

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.2, 	gihamp
		FLsetVal_i	750, 	gihfreq
		FLsetVal_i	0.5, 	ihhrd
		FLsetVal_i	0.65, 	ihpos
		FLsetVal_i	5, 	ihvibf
		FLsetVal_i	0, 	ihvamp

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 280, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          gogobel                            ", 	1,       5,    14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,     20,    5,  20
ih		 	FLbox  	"'gogobel' is a physical model of a cow bell or agogo bell.   ", 	1,       5,    14,    490,     20,    5,  40
ih		 	FLbox  	"'Stick Hardness' and 'Strike Position' impact some variation ", 	1,       5,    14,    490,     20,    5,  60
ih		 	FLbox  	"in tone but this is quite subtle.                            ", 	1,       5,    14,    490,     20,    5,  80
ih		 	FLbox  	"It is difficult to imagine why vibrato has been included in  ", 	1,       5,    14,    490,     20,    5, 100
ih		 	FLbox  	"an emulation of a cow bell. It is actually difficult to      ", 	1,       5,    14,    490,     20,    5, 120
ih		 	FLbox  	"experience the vibrato as the duration of the sound is so    ", 	1,       5,    14,    490,     20,    5, 140
ih		 	FLbox  	"short.                                                       ", 	1,       5,    14,    490,     20,    5, 160
ih		 	FLbox  	"By replacing the sample suggested for the strike impulse     ", 	1,       5,    14,    490,     20,    5, 180
ih		 	FLbox  	"(marmstk1.wav) with a longer sample, a longer duration tone  ", 	1,       5,    14,    490,     20,    5, 200
ih		 	FLbox  	"is possible.                                                 ", 	1,       5,    14,    490,     20,    5, 220
ih		 	FLbox  	"This instrument can be triggered either from the FLTK button ", 	1,       5,    14,    490,     20,    5, 240
ih		 	FLbox  	"or via a connected MIDI keyboard.                            ", 	1,       5,    14,    490,     20,    5, 260

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gimp1	ftgen	1,0,1024,1,"marmstk1.wav",0,0,0
gimp2	ftgen	2,0,131072,1,"bounce.wav",0,0,0
givfn	ftgen	0,0,4096,10,1			;A SINE WAVE

instr	1
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	if iMIDIflag==1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		ifreq	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
		ivel	veloc		0,1		;READ NOTE VELOCITY. WILL BE WITHIN THE RANGE 0 AND 1
		iamp	init	i(gkamp) * ivel
	else						;OTHERWISE (FLTK)...
		ifreq		init	i(gkfreq)	;SMOOTH VARIABLE CHANGES WITH PORTK
		iamp		init	i(gkamp)	;APPLY PORTAMENTO SMOOTHING
	endif						;END OF THIS CONDITIONAL BRANCH

	kSwitch		changed		gkhrd, gkpos	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then
		reinit	UPDATE
	endif
	UPDATE:
	imp	=		i(gkimp)+1
	ares 	gogobel 	iamp, ifreq, i(gkhrd), i(gkpos), imp, gkvibf, gkvamp, givfn
	rireturn
	aenv	linsegr		1,0.01,0		;ANTI-CLICK ENVELOPE
		out 		ares*aenv
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT, SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
