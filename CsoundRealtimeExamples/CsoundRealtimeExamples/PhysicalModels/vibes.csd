;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;COMMENT OR UNCOMMENT CSOUND FLAGS AS REQUIRED
;-odevaudio -M0 -b400			;EXTERNAL MIDI
-odevaudio -M0 -+rtmidi=virtual -b400	;VIRTUAL MIDI DEVICE
;-odevaudio -b400			;NO MIDI DEVICE
</CsOptions>

<CsInstruments>

sr 		= 	22050	;SAMPLE RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE = 1, REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"vibes",   500,    400,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"Strike!",	1,    0,    21,    200,     30,    5,  5,    0,      2,      0,       -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",       80,     18,    5,   75
idfreq		FLvalue	" ",       80,     18,    5,  125
idhrd		FLvalue	" ",       80,     18,    5,  175
idpos		FLvalue	" ",       80,     18,    5,  225
idvibf		FLvalue	" ",       80,     18,    5,  275
idvamp		FLvalue	" ",       80,     18,    5,  325
iddec		FLvalue	" ",       80,     18,    5,  375

;SLIDERS				            					MIN | MAX    | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X   | Y
gkamp, gihamp			FLslider	"Amplitude",				0,        1,    0,    23,    idamp,       490,    25,     5,    50
gkfreq, gihfreq			FLslider	"Frequency",				20,   10000,   -1,    23,    idfreq,      490,    25,     5,   100
gkhrd, ihhrd			FLslider	"Stick Hardness",			0,        1,    0,    23,    idhrd,       490,    25,     5,   150
gkpos, ihpos			FLslider	"Strike Position",			0,        1,    0,    23,    idpos,       490,    25,     5,   200
gkvibf,ihvibf			FLslider 	"Vibrato Frequency",			0,       15,    0,    23,    idvibf,      490,    25,     5,   250
gkvamp,ihvamp			FLslider 	"Vibrato Amplitude",			0,        1,    0,    23,    idvamp,      490,    25,     5,   300
gkdec,ihdec			FLslider 	"Decay Time",				0,        5,    0,    23,    iddec,       490,    25,     5,   350

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkimp, ihimp			FLbutBank	3,      1,      2,    18,      40,   330, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"IMPULSE:", 		1,       6,    14,     60,      20,  270,   0
ih		 	FLbox  	"marmstk1  ", 		1,       5,    14,     60,      20,  360,   0
ih		 	FLbox  	"soundscape", 		1,       5,    14,     60,      20,  360,  20

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.3, 	gihamp
		FLsetVal_i	250, 	gihfreq
		FLsetVal_i	0.5, 	ihhrd
		FLsetVal_i	0.4, 	ihpos
		FLsetVal_i	0.5, 	ihvibf
		FLsetVal_i	0.8, 	ihvamp
		FLsetVal_i	1, 	ihdec

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            vibes                            ", 	1,       5,    14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    20,     5,  20
ih		 	FLbox  	"'vibes' is a physical model of a vibraphone tone.            ", 	1,       5,    14,    490,    20,     5,  40
ih		 	FLbox  	"'Stick Hardness' and 'Strike Position' create some variation ", 	1,       5,    14,    490,    20,     5,  60
ih		 	FLbox  	"in tone but this is quite subtle.                            ", 	1,       5,    14,    490,    20,     5,  80
ih		 	FLbox  	"'Decay Time' controls the time before the end of the note    ", 	1,       5,    14,    490,    20,     5, 100
ih		 	FLbox  	"when damping is introduced.                                  ", 	1,       5,    14,    490,    20,     5, 120
ih		 	FLbox  	"By replacing the sample suggested for the strike impulse     ", 	1,       5,    14,    490,    20,     5, 140
ih		 	FLbox  	"(marmstk1.wav) with a longer sample, a longer duration tone  ", 	1,       5,    14,    490,    20,     5, 160
ih		 	FLbox  	"is possible.                                                 ", 	1,       5,    14,    490,    20,     5, 180
ih		 	FLbox  	"This instrument can be triggered either from the FLTK button ", 	1,       5,    14,    490,    20,     5, 200
ih		 	FLbox  	"or via a connected MIDI keyboard.                            ", 	1,       5,    14,    490,    20,     5, 220

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gimp1	ftgen	1,0,1024,1,"marmstk1.wav",0,0,0
gimp2	ftgen	2,0,1048576,1,"Songpan.wav",0,0,1
givibfn	ftgen	0,0,4096,10,1			;A SINE WAVE

instr		1	;MIDI ACTIVATED INSTRUMENT (TRIGGERS INSTR 2 AS A SUB-INSTRUMENT)
	ifreq	cpsmidi		;FREQUENCY IS READ FROM INCOMING MIDI NOTE
	iamp	ampmidi	1	;AMPLITUDE IS READ FROM INCOMING MIDI NOTE
	FLsetVal_i	ifreq, gihfreq	;SEND FREQUENCY VALUE TO FREQUENCY SLIDER
	a1,a2	subinstr 2	;CALL INSTRUMENT 2 AS A SUB-INSTRUMENT. OUTPUT ARGUMENTS WILL BE THE AUDIO OUTS OF CALLED INSTRUMENT
	aenv	linsegr	1,3600,1,0.1,0	;CREATE AN AMPLITUDE ENVELOPE. THIS WILL BE USED TO PREVENT CLICKS.
		outs 		a1*aenv*iamp, a2*aenv*iamp	;SEND AUDIO TO OUTPUTS
endin

instr	2	;VIBES INSTRUMENT
	kSwitch		changed		gkamp, gkhrd, gkpos, gkdec	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then
		reinit	START
	endif
	START:
	imp	=		i(gkimp)+1
	ares 	vibes 		i(gkamp), i(gkfreq), i(gkhrd), i(gkpos), imp, gkvibf, gkvamp, givibfn, i(gkdec)
	rireturn
		outs 		ares, ares
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>