moog.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;COMMENT/UNCOMMENT AS REQUIRED
;-odac -dm0			;NO MIDI
;-odac -dm0 -M0			;EXTERNAL MIDI
-odac -dm0 -M0 -+rtmidi=virtual	;VIRTUAL MIDI KEYBOARD
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	32
nchnls	=	1
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL  | WIDTH | HEIGHT | X | Y
	FLpanel	"moog",   500,    350,    0,  0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,   0,    22,    140,     28,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idamp				FLvalue	" ",     	60,       20,    5,   75
idfreq				FLvalue	" ",     	60,       20,    5,  125
idfiltq				FLvalue	" ",     	60,       20,    5,  175
idfiltrate			FLvalue	" ",     	60,       20,    5,  225
idvibf				FLvalue	" ",     	60,       20,    5,  275
idvamp				FLvalue	" ",     	60,       20,    5,  325

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider 	"Amplitude",			0,       0.1,   0,    23,      idamp,     490,    25,     5,  50
gkfreq, gihfreq			FLslider 	"Frequency",			20,    20000,  -1,    23,     idfreq,     490,    25,     5, 100
gkfiltq, ihfiltq		FLslider 	"Filter Resonance",		0.8,     0.9,   0,    23,    idfiltq,     490,    25,     5, 150
gkfiltrate, ihfiltrate		FLslider 	"Filter Rate",			0,    0.0002,   0,    23, idfiltrate,     490,    25,     5, 200
gkvibf, ihvibf			FLslider 	"Vibrato Frequency (hertz)",	0,        16,   0,    23,     idvibf,     490,    25,     5, 250
gkvamp, gihvamp			FLslider 	"Vibrato Amplitude",		0,       0.1,   0,    23,     idvamp,     490,    25,     5, 300

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkwfn, ihwfn		FLbutBank	13,     1,     2,     18,      40,   350, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"WAVEFORM:", 		1,       6,    14,     90,      20,  250,  0
ih		 	FLbox  	"Sawtooth", 		1,       5,    14,     90,      20,  370,  0
ih		 	FLbox  	"Square  ", 		1,       5,    14,     90,      20,  370, 20

			FLsetVal_i	0.03, 	ihamp
			FLsetVal_i	400, 	gihfreq
			FLsetVal_i	0.8, 	ihfiltq
			FLsetVal_i	0.8, 	ihfiltrate
			FLsetVal_i	5, 	ihvibf
			FLsetVal_i	0, 	gihvamp
			FLsetVal_i	0, 	ihwfn

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 340, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             moog                            ", 	1,       5,    14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,     20,    5,  20
ih		 	FLbox  	"The 'moog' opcode is a model of a tone created by a Moog     ", 	1,       5,    14,    490,     20,    5,  40
ih		 	FLbox  	"synthesizer. Only some of the controls of a Moog are         ", 	1,       5,    14,    490,     20,    5,  60
ih		 	FLbox  	"incorporated as input arguments into this opcode.            ", 	1,       5,    14,    490,     20,    5,  80
ih		 	FLbox  	"'Filter Rate' controls the speed of decay of the filter      ", 	1,       5,    14,    490,     20,    5, 100
ih		 	FLbox  	"envelope. There is no specific control of the filter cutoff  ", 	1,       5,    14,    490,     20,    5, 120
ih	  	 	FLbox  	"frequency.                                                   ", 	1,       5,    14,    490,     20,    5, 140
ih		 	FLbox  	"As well as the suggested waveform 'impuls20.aiff', I have    ", 	1,       5,    14,    490,     20,    5, 160
ih		 	FLbox  	"allowed the user to select a square waveform in this example.", 	1,       5,    14,    490,     20,    5, 180
ih		 	FLbox  	"Besides the main waveform for the sound the user supplies the", 	1,       5,    14,    490,     20,    5, 200
ih		 	FLbox  	"opcode with a waveform for the attack of the sound and       ", 	1,       5,    14,    490,     20,    5, 220
ih		 	FLbox  	"another for the vibrato shape.                               ", 	1,       5,    14,    490,     20,    5, 240
ih		 	FLbox  	"This example can be triggered either from the FLTK button or ", 	1,       5,    14,    490,     20,    5, 260
ih		 	FLbox  	"from a connected MIDI keyboard. If using MIDI, the modulation", 	1,       5,    14,    490,     20,    5, 280
ih		 	FLbox  	"wheel can be used to control vibrato amplitude and the pitch ", 	1,       5,    14,    490,     20,    5, 300
ih		 	FLbox  	"bend wheel can also be used.                                 ", 	1,       5,    14,    490,     20,    5, 320

				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


giwfn1	ftgen	1, 0, 256, 1, "impuls20.aiff", 0, 0, 0		;WAVEFORM SUGGESTED BY THE CSOUND MANUAL
giwfn2	ftgen	2, 0, 256, -7, 1, 128, 1, 0, -1, 128, -1	;SQUARE WAVE
giafn	ftgen	0, 0, 8192, 1, "mandpluk.aiff", 0, 0, 0		;ATTACK WAVEFORM
givfn	ftgen	0, 0, 256, 10, 1				;VIBRATO WAVEFORM

instr	1
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
		kfreq	=	icps*semitone(kbend)	;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		kamp	=	gkamp * ivel
	else						;OTHERWISE...
		kfreq		portk	gkfreq, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp		portk	gkamp, kporttime		;APPLY PORTAMENTO SMOOTHING
	endif						;END OF THIS CONDITIONAL BRANCH

	iwfn	=	i(gkwfn)+1
	ares 	moog 	kamp, kfreq, gkfiltq, gkfiltrate, gkvibf, gkvamp, giafn, iwfn, givfn
	aenv	linsegr		1,0.01,0		;ANTI-CLICK ENVELOPE
		out	ares				;SEND AUDIO TO OUTPUTS
endin

instr	3	;SYNCHRONIZE MIDI MOD. WHEEL AND FLTK 'Vibrato Amplitude' SLIDER
		kvamp	ctrl7	1,1,0,0.1			;READ MODULATION WHEEL VALUES
	ktrig	changed	kvamp				;CHECK TO SEE IF MOD. WHEEL HAS MOVED. OUTPUT A VALUE OF 1 IF IT HAS, OTHERWISE ZERO
		FLsetVal	ktrig, kvamp, gihvamp	;UPDATE FLTK SLIDER FOR VIBRATO AMPLITUDE IF ktrig=1
endin	
</CsInstruments>

<CsScore>
i 3 0 3600	;INSTRUMENT 3 PLAYS A NOTE FOR 1 HOUR AND KEEPS REALTIME PERFORMANCE GOING
</CsScore>

</CsoundSynthesizer>