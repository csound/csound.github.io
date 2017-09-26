mandol.csd
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
		FLpanel	"mandol",     500,    350,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"Pluck!",	1,    0,    21,    200,     30,   150, 5,    0,      1,      0,       -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,     18,    5,   75
idfreq		FLvalue	" ",      100,     18,    5,  125
idpluck		FLvalue	" ",      100,     18,    5,  175
iddetune	FLvalue	" ",      100,     18,    5,  225
idgain		FLvalue	" ",      100,     18,    5,  275
idsize		FLvalue	" ",      100,     18,    5,  325

;SLIDERS				            					MIN  | MAX   | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkamp, gihamp			FLslider	"Amplitude",				0,        1,    0,    23,   idamp,      490,     25,    5,    50
gkfreq, gihfreq			FLslider	"Frequency",				20,   10000,   -1,    23,   idfreq,     490,     25,    5,   100
gkpluck, ihpluck		FLslider	"Pluck Position",			0.001,    1,    0,    23,   idpluck,    490,     25,    5,   150
gkdetune, ihdetune		FLslider	"Detune",				0.9,      2,    0,    23,   iddetune,   490,     25,    5,   200
gkgain,ihgain			FLslider 	"Gain",					0.97,     1,    0,    23,   idgain,     490,     25,    5,   250
gksize,ihsize			FLslider 	"Size",					0.004,    2,    0,    23,   idsize,     490,     25,    5,   300

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.3, 	gihamp
		FLsetVal_i	250, 	gihfreq
		FLsetVal_i	0.1, 	ihpluck
		FLsetVal_i	0.9, 	ihdetune
		FLsetVal_i	0.97, 	ihgain
		FLsetVal_i	1, 	ihsize

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 260, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          mandol                             ", 	1,       5,    14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    20,     5,  20
ih		 	FLbox  	"'mandol' implements a physical model of a mandolin.          ", 	1,       5,    14,    490,    20,     5,  40
ih		 	FLbox  	"This instrument can be triggered by either the FLTK button or", 	1,       5,    14,    490,    20,     5,  60
ih		 	FLbox  	"by a connected MIDI keyboard.                                ", 	1,       5,    14,    490,    20,     5,  80
ih		 	FLbox  	"'detune' controls the amount of detuning between each pair of", 	1,       5,    14,    490,    20,     5, 100
ih		 	FLbox  	"strings.                                                     ", 	1,       5,    14,    490,    20,     5, 120
ih		 	FLbox  	"'Gain' controls the amount of feedback within the algorithm  ", 	1,       5,    14,    490,    20,     5, 140
ih		 	FLbox  	"which ultimately gives control over the sustain of the       ", 	1,       5,    14,    490,    20,     5, 160
ih		 	FLbox  	"instrument.                                                  ", 	1,       5,    14,    490,    20,     5, 180
ih		 	FLbox  	"'Size' is a control over the size of the instrument.         ", 	1,       5,    14,    490,    20,     5, 200
ih		 	FLbox  	"'Pluck Position' offers control over where, along the length ", 	1,       5,    14,    490,    20,     5, 220
ih		 	FLbox  	"of the string, plucking occurs.                              ", 	1,       5,    14,    490,    20,     5, 240

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gifn	ftgen	2,0,16384,1,"mandpluk.aiff",0,0,1 

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

	ares 	mandol 		iamp, ifreq, gkpluck, gkdetune, gkgain, gksize, gifn ;[, iminfreq]
	aenv	linsegr		1,0.01,0		;ANTI-CLICK ENVELOPE
		out 		ares*aenv		;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
