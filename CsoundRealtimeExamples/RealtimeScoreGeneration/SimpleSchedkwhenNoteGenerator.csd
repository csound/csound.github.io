SimpleSchedkwhenNoteGenerator
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	16	;NUMBER OF AUDIO SAMPLE IN A CONTROL PERIOD
nchnls 	= 	2	;NUMBER OF AUDIO OUTPUT CHANNELS
0dbfs	=	1	;MAXIMUM AUDIO LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL | WIDTH | HEIGHT | X | Y
	FLpanel	" ",     500,    150,    0,  0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   0,    22,    150,     30,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idTrigFreqMin			FLvalue	" ",     	60,       20,    5,   80
idTrigFreqMax			FLvalue	" ",     	60,       20,  435,   80

;					            				MIN  |   MAX | EXP | TYPE |     DISP      | WIDTH | HEIGHT | X | Y
gkTrigFreqMin, ihTrigFreqMin	FLslider 	" ",				.01,     20,     0,    3,   idTrigFreqMin,   490,     15,    5, 50
gkTrigFreqMax, ihTrigFreqMax	FLslider 	"Trigger Frequency: min/max",	.01,     20,     0,    3,   idTrigFreqMax,   490,     15,    5, 65

;GENERAL_TEXT_SETTINGS			SIZE |  FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,  255,    255		;NUMBERS MADE INVISIBLE

;FLcolor2	255, 255, 50		;SET SECONDARY COLOUR TO YELLOW
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkscale, ihscale	FLbutBank	4,     1,     2,      20,      40,    5, 105,   -1

;GENERAL_TEXT_SETTINGS			SIZE |  FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Pentatonic", 		1,       5,    14,    80,     20,    25, 104
ih		 	FLbox  	"Whole Tone", 		1,       5,    14,    80,     20,    25, 124

			FLsetVal_i	5, 	ihTrigFreqMin
			FLsetVal_i	5, 	ihTrigFreqMax
			FLsetVal_i	0, 	ihscale

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      640,  512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"       schedkwhen - Simple Algorithmic Note Generator        ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example demonstrates how the opcode 'schedkwhen' can be ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"used to implement a simple algorithmic note generator.       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"'Algorithmic' refers to the fact that the pitches of notes   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"generated will be indeterminate but not completely random.   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Pitches will be chosen at random from a set of notes defined ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"in a function table.                                         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Schedkwhen allows one instrument to generate multiple notes  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"that will be played by another instrument. Schedkwhen is     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"activated by a trigger signal which could be pulsed,         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"rhythmical or unpulsed/rhymically aleatoric. Schedkwhen      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"also allows the user to define start time, note duration and ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"any number of additional p-fields at k-rate. (The            ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"called instrument will receive these values as i-rate        ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"p-values. With these capabilties the possiblities for        ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"algorithmically generating notes are immense.                ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"In this very simple example the user can vary the random     ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"value limits for the trigger frequency. Setting these two    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"controls to the same value will create metered note          ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"generation.                                                  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"The user can also choose between two different scale types   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"(stored in two separate GEN-02 function tables).             ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"Each time a note is generated its duration will be a randomly", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"chosen value between .1 and 2 (seconds).                     ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"The amplitude of each note will also be random.              ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"Each note will occupy a randomly chosen location between the ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"left and right speakers.                                     ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"This example employs very simple and uniform random number   ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"generators. Csound offers a wide variety of more powerful    ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"random number generators portraying a variety of             ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"distributions.                                               ", 	1,      5,     14,    490,    15,     5, 620

			FLpanel_end	;END OF PANEL CONTENTS

			FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;THIS INSTRUMENT TRIGGERS NOTES IN INSTRUMENT 2 WITH A MINIMUM TIME GAP BETWEEN NOTES OF kmintim SECONDS
instr		1
	if	gkOnOff=0	then		;IF FLTK ON/OFF BUTTON IS OFF...
		turnoff				;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF CONDITIONAL BRANCHING
	;TRIGGER FREQUENCY - DEFINED RANDOMLY WITHIN THE GIVEN RANGE - FREQUENCY OF NEW RANDOM NUMBER OUTPUT=5Hz
	kTrigFreq	randomi		gkTrigFreqMin, gkTrigFreqMax, 5
	;CREATE A TRIGGER SIGNAL (MOMENTARY '1' IMPULSES) ACCORDING TO THE FLUCTUATING VARIABLE 'kTrigFreq'
	ktrigger	metro		kTrigFreq
	;NOTE DURATIONS WILL BE DEFINED RANDOMLY:
	;				MIN | MAX | FREQUENCY
	kdur		randomh		.1,    2,       5	;SAMPLE-AND-HOLD RANDOM NUMBER GENERATOR
	;		 		TRIGGER | MINTIM | MAXNUM | INSNUM | WHEN | KDUR
			schedkwhen 	ktrigger,   0,        0,       2,      0,   kdur
endin

;THIS IS THE SOUND PRODUCING INSTRUMENT - A SIMPLE SINE WAVE 'PING'
instr	2
	iamp		random	0.03,0.5			;AMPLITUDES WILL BE RANDOM VALUES BETWEEN 1000 (VERY QUIET) AND 10000 (LOUD)
	ipan		random	0, 1				;PAN VALUES WILL BE RANDOM VALUES BETWEEN 0 (LEFT SPEAKER) AND 1 (RIGHT SPEAKER)
	ipchndx		random	0,13				;A RANDOM INDEX VALUE IS DEFINED FOR EACH NEW NOTE.
								;THIS INDEX WILL BE USED TO SELECT VALUES FROM THE 'SCALE' FUNCTION TABLE.
								;THE MAXIMUM POSSIBLE VALUE SHOULD NOT EXCEED THE NUMBER OF VALUES (NOTES) DEFINED IN THE CORRESPONDING FUNCTION TABLE (SCALE).
	ipch		table	ipchndx, 2+i(gkscale)		;THE VARIABLE ipch WILL BE SELECTED FROM THE ipchndx VALUE IN FUNCTION TABLE 2
	aenv		expseg	1, (p3), .001			;PERCUSSIVE-TYPE AMPLITUDE ENVELOPE
	asig		oscil	iamp * aenv, cpspch(ipch), 1	;GENERATE AN AUDIO SIGNAL ACCORDING TO THE WAVEFORM IN FUNCTION TABLE 1 - USE THE SELECTED PCH VALUE AND APPLY THE AMPLITUDE ENVELOPE AND RANDOM AMPLITUDE VALUE
			outs	asig * ipan, asig * (1-ipan)	;SEND AUDIO TO OUTPUTS AND APPLY SIMPLE PANNING
endin

</CsInstruments>

<CsScore>
f 1 0 4096 10 1	;SINE WAVE

;TABLE_NO.|INIT_TIME|SIZE|GEN_NUMBER|VALUES.1..	2	3	4	5	6	7	8	9	10	11	12	13	
f   2          0      64      -2 	7 	7.03 	7.05 	7.07 	7.10 	8	8.03 	8.05 	8.07 	8.10 	9			;PENTATONIC SCALE - 2 OCTAVES
f   3          0      64      -2 	7 	7.02 	7.04 	7.06 	7.08 	7.10	8.00 	8.02 	8.04 	8.06 	8.08	8.10	9.00	;WHOLE TONE SCALE - 2 OCTAVES
;GEN 2 OFFERS US A MEANS TO STORE DISCRETE VALUES, DEFINED VALUE BY VALUE - IN THIS CASE THESE VALUES WILL BE INTERPRETED IN THE ORCHESTRA AS PCH FORMAT VALUES
;IF THE GEN ROUTINE NUMBER IS GIVEN AS A NEGATIVE NUMBER THEN VALUES WON'T BE NORMALIZED (RESCALED WITHIN THE RANGE -1 TO 1)

f 0 3600		;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>