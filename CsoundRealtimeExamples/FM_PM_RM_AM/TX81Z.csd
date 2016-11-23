TX81Z.csd
Written by Iain McCurdy, 2009. 

<CsoundSynthesizer>

<CsOptions>
;COMMENT/UNCOMMENT AS REQUIRED
;-odac -dm0			;NO MIDI
;-odac -dm0 -M0			;EXTERNAL MIDI
-odac -dm0 -M0 -+rtmidi=virtual	;VIRTUAL MIDI KEYBOARD
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps		=	128	;SIZE OF k-PERIOD IN SAMPLES
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL                  | WIDTH | HEIGHT | X | Y
				FLpanel	"Yamaha TX817 Models",    500,    450,    0,  0

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idamp				FLvalue	" ",       80,    18,     5,  25
idc1				FLvalue	" ",       80,    18,     5,  75
idc2				FLvalue	" ",       80,    18,     5, 125
idvdepth			FLvalue	" ",       80,    18,     5, 175
idvrate				FLvalue	" ",       80,    18,     5, 225

;SLIDERS					            			MIN   |  MAX  | EXP | TYPE |    DISP    | WIDTH | HEIGHT | X  |  Y
gkamp,gihamp			FLslider 	"Amplitude (CC#7)",		0,          1,   0,    23,       idamp,    490,     25,    5,    0	;VALUE DISPLAY FOR THIS VARIABLE IS UPDATED FROM WITHIN THE MAIN ORCHESTRA (INSTR 2)
gkc1,gihc1			FLslider 	"Control 1 (CC#3)",		0,         99,   0,    23,        idc1,    490,     25,    5,   50
gkc2,gihc2			FLslider 	"Control 2 (CC#4)",		0,         99,   0,    23,        idc2,    490,     25,    5,  100
gkvdepth,gihvdepth		FLslider 	"Vibrato Depth (CC#1)",		0.0001,     1,   0,    23,    idvdepth,    490,     25,    5,  150
gkvrate,gihvrate		FLslider 	"Vibrato Rate (CC#2)",		0,         10,   0,    23,     idvrate,    490,     25,    5,  200

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkpreset, ihpreset	FLbutBank	3,     1,     7,     18,     175,     50,250,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"TYPE:",			1,       6,    14,    50,      25,     0, 250
ih		 	FLbox  	"B3                      ",	1,       5,    12,   170,      25,    70, 250
ih		 	FLbox  	"Bell                    ", 	1,       5,    12,   170,      25,    70, 275
ih		 	FLbox  	"Heavy Metal             ", 	1,       5,    12,   170,      25,    70, 300
ih		 	FLbox  	"Percussive Flute        ", 	1,       5,    12,   170,      25,    70, 325
ih		 	FLbox  	"Rhodes Electric Piano   ", 	1,       5,    12,   170,      25,    70, 350
ih		 	FLbox  	"Voice                   ", 	1,       5,    12,   170,      25,    70, 375
ih		 	FLbox  	"Wurlitzer Electric Piano",	1,       5,    12,   170,      25,    70, 400

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.5, 	gihamp
				FLsetVal_i	1, 	gihc1
				FLsetVal_i	1, 	gihc2
				FLsetVal_i	0.2, 	gihvdepth
				FLsetVal_i	0, 	gihvrate
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 675, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                  Yamaha TX81Z Models                        ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"A set of opcodes that implement presets from the FM synthesis", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"module, the Yamaha TX81Z, have been written by John ffitch   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"for Csound, based on work by Perry Cook.                     ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The seven different opcodes can be selected using the tick   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"boxes in the GUI. All seven opcodes share the same set of    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"input arguments, the only difference between them in terms of", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"setting them up is that some of them use waveforms besides   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"sine waves for some of their operators (oscillators).        ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The TX81Z implements four-operator FM algorithms and in      ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"theory there is no reason why these algorithms could not be  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"implemented from first principles using individual           ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"oscillators.                                                 ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"The functions of controls 1 and 2 are as follows:            ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"+-------------------+---+------------------+----------------+", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"| OPCODE            |ALG| CONTROL 1        | CONTROL 2      |", 	1,      5,     14,    490,    20,     5, 315
ih		 	FLbox  	"+-------------------+---+------------------+----------------+", 	1,      5,     14,    490,    20,     5, 330
ih		 	FLbox  	"| Hammond B3 Organ  | 4 | Total Mod. Index |Crossfade of the|", 	1,      5,     14,    490,    20,     5, 345
ih		 	FLbox  	"|                   |   |                  |two modulators  |", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"| Tubular Bell      | 5 | Mod. Index 1     |Crossfade of two|", 	1,      5,     14,    490,    20,     5, 375
ih		 	FLbox  	"|                   |   |                  |outputs         |", 	1,      5,     14,    490,    20,     5, 390
ih		 	FLbox  	"| Heavy Metal       | 4 | Total Mod. Index |Crossfade of the|", 	1,      5,     14,    490,    20,     5, 405
ih		 	FLbox  	"|                   |   |                  |two modulators  |", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"| Percussive Flute  | 4 | Total Mod. Index |Crossfade of the|", 	1,      5,     14,    490,    20,     5, 435
ih		 	FLbox  	"|                   |   |                  |two modulators  |", 	1,      5,     14,    490,    20,     5, 450
ih		 	FLbox  	"| Rhodes Elec. Piano| 5 | Mod. Index 1     |Crossfade of two|", 	1,      5,     14,    490,    20,     5, 465
ih		 	FLbox  	"|                   |   |                  |outputs         |", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"| Voice             | ? | Vowel            |Tilt            |" , 	1,      5,     14,    490,    20,     5, 495
ih		 	FLbox  	"| Wurlitzer -       | 5 | Mod. Index 1     |Crossfade of two|", 	1,      5,     14,    490,    20,     5, 510
ih		 	FLbox  	"| - Elec. Piano     |   |                  |outputs         |", 	1,      5,     14,    490,    20,     5, 525
ih		 	FLbox  	"+-------------------+---+------------------+----------------+", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 555                                                       
ih		 	FLbox  	"This example is MIDI-ified, responding to MIDI notes, key    ", 	1,      5,     14,    490,    20,     5, 575                                                       
ih		 	FLbox  	"velocity, pitch bend and additional continuous controller    ", 	1,      5,     14,    490,    20,     5, 595                                                       
ih		 	FLbox  	"assignments which double the functions of the on-screen      ", 	1,      5,     14,    490,    20,     5, 615                                                       
ih		 	FLbox  	"sliders.                                                     ", 	1,      5,     14,    490,    20,     5, 635                                                       
ih		 	FLbox  	"Enveloping of the sound is contained within the opcode.       ", 	1,      5,     14,    490,    20,     5, 655                                                       
				FLpanel_end                                                                                                       
                                                                                                                                                  
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine		ftgen	0, 0, 1024, 10, 1
gitwopeaks	ftgen	0, 0, 1024,  1, "twopeaks.aiff", 0, 0, 0
gifwavblnk	ftgen	0, 0, 1024,  1, "fwavblnk.aiff", 0, 0, 0

0dbfs	=	1	;MAXIMUM AMPLITUDE IS SET AT A VALUE OF 1

instr	1	;TX81Z INSTRUMENT
	ioct	octmidi
	;PITCH BEND INFORMATION IS READ
	iSemitoneBendRange = 2		;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	imin = 0			;EQUILIBRIUM POSITION
	imax = iSemitoneBendRange * .0833333	;MAX PITCH DISPLACEMENT (IN oct FORMAT)
	kbend	pchbend	imin, imax	;PITCH BEND VARIABLE (IN oct FORMAT)
	kfreq	=	cpsoct(ioct+ kbend)
	iporttime	=	0.1					;PORTAMENTO TIME
	kporttime	linseg	0, 0.001, iporttime, 1, iporttime	;PORTAMENTO TIME RISES UP QUICKLY TO DESIRED VALUE
	kc1		portk	gkc1, kporttime	;PORTAMENTO IS APPLIED TO CONTROL VARIABLES
	kc2		portk	gkc2, kporttime	;PORTAMENTO IS APPLIED TO CONTROL VARIABLES
	ikvel	veloc	0,1		;KEY VELOCITY IS READ
	kamp	portk	gkamp * ikvel, kporttime	;AMPLITUDE IS DERIVED FROM ON-SCREEN AMPLITUDE CONTROL AND KEY VELOCITY / PORTAMENTO IS APPLIED

	;SELECT THE APPRORIATE FM OPCODE ACCORDING TO THE SETTING OF THE 'TYPE' TICK BOX SELECTER 
	if	gkpreset==0	then
		;HAMMOND B3 ORGAN
		;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | CONTROL_1 | CONTROL_2 | VIBRATO_DEPTH | VIBRATO_RATE | F.TABLE_1 | F.TABLE_2 | F.TABLE_3 | F.TABLE_4 | VIBRATO_F.TABLE
		ares	fmb3	kamp,        kfreq,      kc1,        kc2,       gkvdepth,       gkvrate,       gisine,    gisine,      gisine,    gisine,        gisine
        
        elseif	gkpreset==1	then
		;TUBULAR BELL	
		;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | CONTROL_1 | CONTROL_2 | VIBRATO_DEPTH | VIBRATO_RATE | F.TABLE_1 | F.TABLE_2 | F.TABLE_3 | F.TABLE_4 | VIBRATO_F.TABLE
		ares	fmbell	kamp,        kfreq,      kc1,       kc2,       gkvdepth,       gkvrate,       gisine,    gisine,      gisine,    gisine,        gisine

	elseif	gkpreset==2	then
		;HEAVY METAL
		;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | CONTROL_1 | CONTROL_2 | VIBRATO_DEPTH | VIBRATO_RATE | F.TABLE_1 | F.TABLE_2 | F.TABLE_3 | F.TABLE_4 | VIBRATO_F.TABLE
		ares	fmmetal	kamp,        kfreq,      kc1,       kc2,       gkvdepth,       gkvrate,      gisine,   gitwopeaks,  gitwopeaks,  gisine,        gisine

	elseif	gkpreset==3	then
		;PERCUSSIVE FLUTE
		;OUTPUT	OPCODE		AMPLITUDE | FREQUENCY | CONTROL_1 | CONTROL_2 | VIBRATO_DEPTH | VIBRATO_RATE | F.TABLE_1 | F.TABLE_2 | F.TABLE_3 | F.TABLE_4 | VIBRATO_F.TABLE
		ares	fmpercfl	kamp,        kfreq,      kc1,       kc2,       gkvdepth,       gkvrate,      gisine,      gisine,     gisine,     gisine,        gisine

	elseif	gkpreset==4	then
		;RHODES ELECTRIC PIANO
		;OUTPUT	OPCODE		AMPLITUDE | FREQUENCY | CONTROL_1 | CONTROL_2 | VIBRATO_DEPTH | VIBRATO_RATE | F.TABLE_1 | F.TABLE_2 | F.TABLE_3 | F.TABLE_4 | VIBRATO_F.TABLE
		ares	fmrhode		kamp,        kfreq,      kc1,       kc2,       gkvdepth,       gkvrate,      gisine,      gisine,     gisine,   gifwavblnk,        gisine

	elseif	gkpreset==5	then
		;VOICE
		;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | CONTROL_1 | CONTROL_2 | VIBRATO_DEPTH | VIBRATO_RATE | F.TABLE_1 | F.TABLE_2 | F.TABLE_3 | F.TABLE_4 | VIBRATO_F.TABLE
		ares	fmvoice	kamp,        kfreq,      kc1,       kc2,       gkvdepth,       gkvrate,       gisine,    gisine,      gisine,    gisine,        gisine

	elseif	gkpreset==6	then
		;WURLITZER ELECTRIC PIANO
		;OUTPUT	OPCODE		AMPLITUDE | FREQUENCY | CONTROL_1 | CONTROL_2 | VIBRATO_DEPTH | VIBRATO_RATE | F.TABLE_1 | F.TABLE_2 | F.TABLE_3 | F.TABLE_4  | VIBRATO_F.TABLE
		ares	fmwurlie	kamp,        kfreq,      kc1,       kc2,       gkvdepth,       gkvrate,       gisine,    gisine,      gisine,   gifwavblnk,        gisine

	endif
	
	aenv	linsegr	0, 0.0001, 1, 3600, 1, 0.1, 0		;A SIMPLE MIDI RESPONSIVE ENVELOPE TO PREVENT CLICKS AT THE START AND END OF NOTES
	outs	ares * aenv, ares * aenv			;SEND AUDIO TO OUTPUTS - MULTIPLY BY AMPLITUDE ENVELOPE
endin

instr	2	;SCAN MIDI CONTROLLERS AND UPDATE FLTK ON-SCREEN SLIDER. THIS IMPLEMENTS DUAL FLTK AND MIDI CAPABILITY
	;OUTPUT			OPCODE		CHANNEL | CC.NUMBER |  MIN  | MAX
	kvdepth			ctrl7		1,            1,     0.0001,    1	;VIBRATO DEPTH
	kvrate			ctrl7		1,            2,          0,   10	;VIBRATO RATE
	kc1			ctrl7		1,            3,          0,   99	;CONTROL 1
	kc2			ctrl7		1,            4,          0,   99	;CONTROL 2
	kamp			ctrl7		1,            7,          0,    1	;VOLUME
	ktrig1			changed		kvdepth	;IF THE VARIABLE CHANGES FROM ITS PREVIOUS VALUE
	ktrig2			changed		kvrate	;IF THE VARIABLE CHANGES FROM ITS PREVIOUS VALUE
	ktrig3			changed		kc1	;IF THE VARIABLE CHANGES FROM ITS PREVIOUS VALUE
	ktrig4			changed		kc2	;IF THE VARIABLE CHANGES FROM ITS PREVIOUS VALUE
	ktrig7			changed		kamp	;IF THE VARIABLE CHANGES FROM ITS PREVIOUS VALUE
							;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
;			OPCODE      |   TRIGGER |  VALUE  | HANDLE
			FLsetVal	ktrig1,  kvdepth,   gihvdepth	;UPDATE SLIDER
			FLsetVal	ktrig2,   kvrate,   gihvrate	;UPDATE SLIDER
			FLsetVal	ktrig3,      kc1,   gihc1	;UPDATE SLIDER
			FLsetVal	ktrig4,      kc2,   gihc2	;UPDATE SLIDER
			FLsetVal	ktrig7,      kamp,  gihamp	;UPDATE SLIDER
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;i2 IMPLEMENTS DUAL FLTK AND MIDI CAPABILITIES AND ALSO KEEPS PERFORMANCE GOING FOR 1 HOUR 
</CsScore>
</CsoundSynthesizer>