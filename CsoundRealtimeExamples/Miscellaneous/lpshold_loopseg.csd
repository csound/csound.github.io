lpshold_loopseg.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>
sr	= 	44100
ksmps	= 	16
nchnls	= 	1
0dbfs	=	1
	seed	0	;SEED RANDOM NUMBER GENERATORS FROM SYSTEM CLOCK
	
;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL             | WIDTH | HEIGHT | X | Y
	FLpanel	"lpshold loopseg",   500,     300,   0,  0

;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",		1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
gkexit,ihexit			FLbutton	"Exit",			1,    0,    21,    100,     25,  395,  5,    0,    999,      0,       0
gkTrigOnOff,ihTrigOnOff		FLbutton	"Trigger On/Off",	1,    0,    22,    120,     25,    5,100,   -1
FLsetColor2	255, 255, 50, ihTrigOnOff		;SET SECONDARY COLOUR TO YELLOW
gkOctDn,ih			FLbutton	"@<-",			1,    0,     1,     20,     20,    65,200,    0,     99,      0,      0, -1
gkOctUp,ih			FLbutton	"@->",			1,    0,     1,     20,     20,   325,200,    0,     99,      0,      0,  1
gkrand,ih			FLbutton	"?",			1,    0,     1,     20,     20,   345,200,    0,    100,      0,      0,  1
FLsetFont	2,ih

;VALUE_DISPLAY_BOXES	 	WIDTH | HEIGHT | X | Y
idspeed		FLvalue	" ",      60,    20,     5,  75
idTrigFrq	FLvalue	" ",      60,    20,   130, 125
idamp		FLvalue	" ",      60,    20,     5, 175

;SLIDERS						  		MIN | MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y
gkspeed, ihspeed		FLslider	"Speed",  		-10,   10,   0,    23,   idspeed,    490,     25,    5,    50
gkTrigFrq, ihTrigFrq		FLslider	"Trigger Frequency",	0.001, 20,  -1,    23,   idTrigFrq,  295,     25,  130,   100
gkamp, ihamp			FLslider	"Amplitude",		0,      1,   0,    23,   idamp,      490,     25,    5,   150
gkfilter, ihfilter		FLslider	"Filter",		0,      1,   0,     1,   -1,          90,     20,    5,   260
gkenv, ihenv			FLslider	"Envelope",		0,      1,   0,     1,   -1,          90,     20,  105,   260
gkdec, ihdec			FLslider	"Decay",		0.02,   1,  -1,     1,   -1,          90,     20,  205,   260
gkres, ihres			FLslider	"Resonance",		0,      1,   0,     1,   -1,          90,     20,  305,   260
gkdist, ihdist			FLslider	"Distortion",		0,      1,   0,     1,   -1,          90,     20,  405,   260
gkgliss, ihgliss		FLslider	"Gliss",		0,    0.1,   0,    23,   -1,         125,     15,  370,   200
gkindicator, gihindicator	FLslider	"",			0,      1,   0,     1,   -1,         120,     20,    5,   125
FLsetColor	rnd(255),rnd(255),rnd(255),ihfilter
FLsetColor2	rnd(255),rnd(255),rnd(255),ihfilter
FLsetColor	rnd(255),rnd(255),rnd(255),ihenv
FLsetColor2	rnd(255),rnd(255),rnd(255),ihenv
FLsetColor	rnd(255),rnd(255),rnd(255),ihres
FLsetColor2	rnd(255),rnd(255),rnd(255),ihres
FLsetColor	rnd(255),rnd(255),rnd(255),ihdist
FLsetColor2	rnd(255),rnd(255),rnd(255),ihdist
;VALUE INPUT BOXES				 	MIN   | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkTrigFrq, ihTrigFrq2	FLtext		"Trig.Frq.", 	0.001,  20,  0.001,    1,     65,     25,    430,  100
FLsetVal_i	1,ihTrigFrq2

#define	NOTE_INPUT(N)	#
;VALUE BOXES				 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gknote$N, gihnote$N	FLtext		"$N", 	0,    127,    1,    1,     30,     20,    ix,  200
gkdur$N, ihdur$N	FLtext		"", 	1,      8,    1,    1,     30,     20,    ix,  235
FLsetVal_i	int(rnd(24))+48,gihnote$N
FLsetVal_i	1,ihdur$N
ix	= ix + 30#
ix	= 85
$NOTE_INPUT(1)
$NOTE_INPUT(2)
$NOTE_INPUT(3)
$NOTE_INPUT(4)
$NOTE_INPUT(5)
$NOTE_INPUT(6)
$NOTE_INPUT(7)
$NOTE_INPUT(8)

;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih     		FLbox  	"Note Row:",	1,      2,     11,    60,      20,    5,  200
ih     		FLbox  	"Durations:",	1,      2,     11,    60,      20,    5,  235

FLsetColor	255,255,255,gihindicator
FLsetColor2	255,0,0,gihindicator

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0.5, 	ihspeed
		FLsetVal_i	1, 	ihTrigFrq
		FLsetVal_i	0.1, 	ihamp
		FLsetVal_i	0, 	gihindicator		
		FLsetVal_i	0.3, 	ihfilter
		FLsetVal_i	0.7, 	ihenv
		FLsetVal_i	0.4, 	ihdec
		FLsetVal_i	0.6, 	ihres
		FLsetVal_i	0.1, 	ihdist

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      lpshold loopseg                        ", 	1,      6,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"lpshold can be used to generate an function which consists of", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"a sequence of held values which will be repeated at a user   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"defined frequency. All values and durations are individually ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"adjustable at krate. The example uses lpshold to play an 8   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"note sequence of notes. Additionally lpshold can be sent a   ", 	1,      5,     14,    490,    20,     5, 120                     
ih		 	FLbox  	"trigger impulse (a non zero value) to force the sequence to  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"return to the beginning before completion. In this example   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"trigger impulses are generated using the 'metro' opcode.     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"and are defined as a ratio of the main loop sequence         ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"frequency. This value can be entered using the slider or the ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"value input box.                                             ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"The notes in the row can be adjusted individually using the  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"value boxes or transposed up or down and octave (using the   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"arrow buttons) or randomised (using the '?' button).         ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"The durations of each note can also be defined as integers.  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"In this example the filter envelope is generated using the   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"loopseg opcode. loopseg functions similary to lpshold, with  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"the distinction that it generates linear interpolations      ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"between pairs of values as opposed to held values in a       ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"manner similar to linseg. This time envelope looping is      ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"effectively ignored by setting frequency very low but instead", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"the envelope is retriggered whenvever lpshold reads a new    ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"note value.                                                  ", 	1,      5,     14,    490,    20,     5, 480
		FLpanel_end

		FLrun	;RUN THE FLTK WIDGET THREAD

;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1

instr	1
	if gkOnOff==0 then			;IF MAIN ON/OFF SWITCH IS OFF...
	 turnoff				;TURN INSTRUMENT OFF
	endif					
	kTotDur		=	gkdur1+gkdur2+gkdur3+gkdur4+gkdur5+gkdur6+gkdur7+gkdur8		;TOTAL DURATION (NOT IN SECONDS)
	iNNotes		=	8
	iNoteDur	=	1/iNNotes			;DURATION EACH VALUE IS HELD
	kLoopFrq	=	gkspeed/(iNoteDur*kTotDur)	;FREQUENCY OF SEQUENCE LOOP
	kTrigFrq	=	kLoopFrq*gkTrigFrq
	ktrig		metro	kTrigFrq*gkTrigOnOff	;METRONOME TRIGGER
	if ktrig==1 then
	 event	"i","Indicator",0,   0,1	;TURN TRIGGER INDICATION ON NOW
	 event	"i","Indicator",0.05,0,0	;TURN TRIGGER INDICATOR OFF IN 0.05 SECONDS
	endif
	;GENRATE A LOOPING SEQUENCE OF HELD VALUES (MIDI NOTE NUMBERS)
	knote	lpshold	kLoopFrq, ktrig*gkTrigOnOff, 0, gknote1, gkdur1, gknote2, gkdur2, gknote3, gkdur3, gknote4, gkdur4, gknote5, gkdur5, gknote6, gkdur6, gknote7, gkdur7, gknote8, gkdur8
	kporttime	linseg	0,0.01,1		;PORTAMENTO FUNCTION
	knote_gliss	portk	knote,kporttime*gkgliss	;APPLY PORTAMENTO TO NOTE VALUE
	asig	vco2	gkamp, cpsmidinn(knote_gliss)	;GENERATE A SAWTOOTH TONE
	kchanged	changed	knote			;IF NOTE VALUE HAS CHANGED GENERATE A TRIGGER
	kFilterBase	=	(knote-12)+(gkfilter*48);FILTER ENVELOPE BASE CUTOFF VALUE (AS A MIDI NOTE NUMBER)
	kFilterMax	=	60*gkenv		;FILTER ENVELOPE MAXIMUM CUTOFF VALUE
	;GENERATE A FILTER ENVELOPE THAT WILL BE RESTARTED UPON EACH NEW NOTE VALUE FROM lpshold
	;		kfreq  ktrig    iphase
	;kcf	loopseg	1/3600, kchanged, 0,       0, kFilterBase+kFilterMax, gkdec,kFilterBase, 1-gkdec,kFilterBase

	;GENERATE A FILTER ENVELOPE THAT WILL BE RESTARTED UPON EACH NEW NOTE VALUE FROM lpshold
	;		f      tr         ph    value                   time  value        time       value        ?
	kcf	loopseg	1/3600,kchanged,  0,    kFilterBase+kFilterMax, gkdec,kFilterBase, 3600-gkdec,kFilterBase, 0

	kcf	limit	cpsmidinn(kcf),20,sr/3		;PREVENT OUT OF RANGE CUTOFF VALUES AND CONVERT FROM MIDI NOTE NUMBER TO CPS
	asig	lpf18	asig, kcf, gkres, gkdist	;FILTER SAWTOOTH SIGNAL
		out	asig				;SEND AUDIO TO OUTPUT
endin

instr	Indicator					;TRIGGER INDICATOR
	FLsetVal_i	p4,gihindicator			;TURN TRIGGER ON OR OFF DEPENDING ON p4 VALUE ('1' OR ZERO)
endin

instr	99						;SHIFT NOTES BY AN OCTAVE UP OR DOWN DEPENDING ON RECEIVED p4 VALUE
;CREATE A MACRO FOR CONVENIENCE
#define	SHIFT_NOTE(N)	
	#
	inote	limit	i(gknote$N)+(p4*12),0,127	;SHIFT MIDI NOTES AND LIMIT TO BE WITHIN ACCEPTABLE LIMITS
	FLsetVal_i	int(inote),gihnote$N		;WRITE NEW NOTE NUMBER VALUE TO FL WIDGET
	#
	;EXPAND MACRO FOR EACH NOTE IN THE ROW
	$SHIFT_NOTE(1)
	$SHIFT_NOTE(2)
	$SHIFT_NOTE(3)
	$SHIFT_NOTE(4)
	$SHIFT_NOTE(5)
	$SHIFT_NOTE(6)
	$SHIFT_NOTE(7)
	$SHIFT_NOTE(8)
endin

instr	100						;GENERATE A NEW RANDOM NOTE ROW
;CREATE A MACRO FOR CONVENIENCE
#define	RANDOMISE_NOTE(N)
	#
	inote	random	48,72				;GENERATE A RANDOM NOTE  
	FLsetVal_i	int(inote),gihnote$N		;WRITE NEW NOTE NUMBER VALUE TO FL WIDGET
	#
	;EXPAND MACRO FOR EACH NOTE IN THE ROW
	$RANDOMISE_NOTE(1)
	$RANDOMISE_NOTE(2)
	$RANDOMISE_NOTE(3)
	$RANDOMISE_NOTE(4)
	$RANDOMISE_NOTE(5)
	$RANDOMISE_NOTE(6)
	$RANDOMISE_NOTE(7)
	$RANDOMISE_NOTE(8)
endin

instr	999						;EXIT CSOUND
	exitnow
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>