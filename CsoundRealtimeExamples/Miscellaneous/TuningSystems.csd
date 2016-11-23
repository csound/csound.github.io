TuningSystems.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;									LABEL | WIDTH | HEIGHT | X | Y
FLpanel	"Equal Temperament / Just Intonation / Pythagorean Tuning Compare",	1100,    280,   0,  0

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Equal", 		1,       5,    14,     50,      30,   0,  10
ih		 	FLbox  	"Just ", 		1,       5,    14,     50,      30,   0,  60
ih		 	FLbox  	"Pyth.", 		1,       5,    14,     50,      30,   0, 110


;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    12,    1,     3,     255,  255,    255
iwidth	=	80
iheight	=	50
itype	=	22
ix	=	50
iy	=	0
idur	=	3600
FLcolor2	255,100,100
FLlabel
;SWITCHES                                	ON | OFF | TYPE  |  WIDTH | HEIGHT | X |    Y          | OPCODE | INS | STARTTIM | DUR   |  p4 
FLcolor		255, 255, 255	;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,     0,    0,     0	;MAKE LABELS BLACK
gk1,ih1		FLbutton	"C",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    101,      0,      idur,     1   
gk2,ih2		FLbutton	"C",		1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    102,      0,      idur,     1
gk3,ih3		FLbutton	"C",		1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    103,      0,      idur,     1,              1
ix	=	ix + iwidth                                                                                
FLcolor		0, 0, 0		;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,    255,   255,   255	;MAKE LABELS WHITE
gk4,ih4		FLbutton	"C#",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    104,      0,      idur,     2^(1/12)
gk5,ih5		FLbutton	"C# 16/15",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    105,      0,      idur,     16/15
gk6,ih6		FLbutton	"C# 256/243",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    106,      0,      idur,     256/243
FLcolor		255, 255, 255	;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,     0,    0,     0	;MAKE LABELS BLACK
ix	=	ix + iwidth                                                                                 
gk7,ih7		FLbutton	"D",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    107,      0,      idur,     2^(2/12)
gk8,ih8		FLbutton	"D 9/8",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    108,      0,      idur,     9/8
gk9,ih9		FLbutton	"D 9/8",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    109,      0,      idur,     9/8
ix	=	ix + iwidth                                                                                 
FLcolor		0, 0, 0		;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,    255,   255,   255	;MAKE LABELS WHITE
gk10,ih10	FLbutton	"D#",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    110,      0,      idur,     2^(3/12)
gk11,ih11	FLbutton	"D# 6/5",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    111,      0,      idur,     6/5
gk12,ih12	FLbutton	"D# 32/27",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    112,      0,      idur,     32/27
ix	=	ix + iwidth                                                                                 
FLcolor		255, 255, 255	;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,     0,    0,     0	;MAKE LABELS BLACK
gk13,ih13	FLbutton	"E",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    113,      0,      idur,     2^(4/12)
gk14,ih14	FLbutton	"E 5/4",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    114,      0,      idur,     5/4
gk15,ih15	FLbutton	"E 81/64",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    115,      0,      idur,     81/64
ix	=	ix + iwidth                                                                                 
gk16,ih16	FLbutton	"F",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    116,      0,      idur,     2^(5/12)
gk17,ih17	FLbutton	"F 4/3",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    117,      0,      idur,     4/3
gk18,ih18	FLbutton	"F 4/3",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    118,      0,      idur,     4/3
ix	=	ix + iwidth                                                                                 
FLcolor		0, 0, 0		;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,    255,   255,   255	;MAKE LABELS WHITE
gk19,ih19	FLbutton	"F#",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    119,      0,      idur,     2^(6/12)
gk20,ih20	FLbutton	"F# 45/32",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    120,      0,      idur,     45/32
gk21,ih21	FLbutton	"F# 729/512",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    121,      0,      idur,     729/512
ix	=	ix + iwidth                                                                                 
FLcolor		255, 255, 255	;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,     0,    0,     0	;MAKE LABELS BLACK
gk22,ih22	FLbutton	"G",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    122,      0,      idur,     2^(7/12)
gk23,ih23	FLbutton	"G 3/2",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    123,      0,      idur,     3/2
gk24,ih24	FLbutton	"G 3/2",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    124,      0,      idur,     3/2
ix	=	ix + iwidth                                                                                 
FLcolor		0, 0, 0		;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,    255,   255,   255	;MAKE LABELS WHITE
gk25,ih25	FLbutton	"G#",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    125,      0,      idur,     2^(8/12)
gk26,ih26	FLbutton	"G# 8/5",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    126,      0,      idur,     8/5
gk27,ih27	FLbutton	"G# 128/81",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    127,      0,      idur,     128/81
ix	=	ix + iwidth                                                                                 
FLcolor		255, 255, 255	;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,     0,    0,     0	;MAKE LABELS BLACK
gk28,ih28	FLbutton	"A",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    128,      0,      idur,     2^(9/12)
gk29,ih29	FLbutton	"A 5/3",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    129,      0,      idur,     5/3
gk30,ih30	FLbutton	"A 27/16",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    130,      0,      idur,     27/16
ix	=	ix + iwidth                                                                                 
FLcolor		0, 0, 0		;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,    255,   255,   255	;MAKE LABELS WHITE
gk31,ih31	FLbutton	"A#",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    131,      0,      idur,     2^(10/12)
gk32,ih32	FLbutton	"A# 9/5",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    132,      0,      idur,     9/5
gk33,ih33	FLbutton	"A# 16/9",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    133,      0,      idur,     16/9
ix	=	ix + iwidth                                                                                 
FLcolor		255, 255, 255	;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    10,    1,      1,     0,    0,     0	;MAKE LABELS BLACK
gk34,ih34	FLbutton	"B",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    134,      0,      idur,     2^(11/12)
gk35,ih35	FLbutton	"B 15/8",	1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    135,      0,      idur,     15/8
gk36,ih36	FLbutton	"B 243/128",	1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    136,      0,      idur,     243/128
ix	=	ix + iwidth                                                                                 
gk37,ih37	FLbutton	"C",		1,    0,  itype,   iwidth, iheight, ix,  iy,                0,    137,      0,      idur,     2^(12/12)
gk38,ih38	FLbutton	"C 2",		1,    0,  itype,   iwidth, iheight, ix,  iy+iheight,        0,    138,      0,      idur,     2
gk39,ih39	FLbutton	"C 2",		1,    0,  itype,   iwidth, iheight, ix,  iy+(iheight*2),    0,    139,      0,      idur,     2

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    250,    90,   650, 180	;BORDER AROUND TUNING SYSTEM SELECTOR FOR MIDI INPUT

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkmode, ihmode		FLbutBank	1,     1,     3,     18,      60,   705, 195,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"MIDI", 		1,       5,    14,     50,      20, 655, 195
ih		 	FLbox  	"Equal Temperament", 	1,       5,    14,    150,      20, 725, 195
ih		 	FLbox  	"Just Intonation  ", 	1,       5,    14,    150,      20, 725, 215
ih		 	FLbox  	"Pythagorean      ", 	1,       5,    14,    150,      20, 725, 235

;PARTIAL STRENGTH SLIDERS

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    620,    95,    5, 175	;BORDER AROUND PARTIAL STRENGTH SLIDERS

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Partial Strengths", 	1,       5,    14,    190,      20,  10, 205

iheight	=	60
iwidth	=	25
ix	=	200
iy	=	185
itype	=	24

#define	SLIDER(N)
#
;SLIDERS					MIN  |   MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp$N, ihamp$N	FLslider 	"$N",	0,        1,    0,   itype, -1,   iwidth, iheight, ix, iy
FLsetVal_i	1-(1/($N)), ihamp$N
ix = ix + iwidth
#
$SLIDER(1)
$SLIDER(2)
$SLIDER(3)
$SLIDER(4)
$SLIDER(5)
$SLIDER(6)
$SLIDER(7)
$SLIDER(8)
$SLIDER(9)
$SLIDER(10)
$SLIDER(11)
$SLIDER(12)
$SLIDER(13)
$SLIDER(14)
$SLIDER(15)
$SLIDER(16)

;SLIDERS							MIN  |   MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkGlobAmp, ihGlobAmp	FLslider 	"Global Amplitude",	0,        1,    0,   23,     -1,    175,     20,   910, 180
FLsetVal_i	0.7, ihGlobAmp


	FLpanel_end

	
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 1100, 280, 0, 350
;TEXT BOXES								                                                               					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                            Comparing Tuning Systems                                                          ", 	1,      5,     14,   1100,    20,     5,   0
ih		 	FLbox  	"------------------------------------------------------------------------------------------------------------------------------", 	1,      5,     14,   1100,    20,     5,  20
ih		 	FLbox  	"This example allows users to compare the equal temperament, just intonation and pythagorean tuning systems in various ways.   ", 	1,      5,     14,   1100,    20,     5,  40
ih		 	FLbox  	"Equal temperament tuning is devised by dividing an octave into twelve equal intervals (semitones). The consequence of this is ", 	1,      5,     14,   1100,    20,     5,  60
ih		 	FLbox  	"that none of the intervals created will represent any sort of simple ratio with respect to the starting pitch (apart from the ", 	1,      5,     14,   1100,    20,     5,  80
ih		 	FLbox  	"octave). All intervals will be distorted (tempered) by varying degrees from the nearest simple ratio. The strength of equal   ", 	1,      5,     14,   1100,    20,     5, 100
ih		 	FLbox  	"temperament is that all keys sound equally tempered.                                                                          ", 	1,      5,     14,   1100,    20,     5, 120
ih		 	FLbox  	"The ratios used for just intonation (indicated as fractions on the key buttons) are derived from ratios revealed by the       ", 	1,      5,     14,   1100,    20,     5, 140
ih		 	FLbox  	"various degrees of the harmonic series. Most intervals will provide purer intervals without the 'beating' produced by equally ", 	1,      5,     14,   1100,    20,     5, 160
ih		 	FLbox  	"tempered intervals.                                                                                                           ", 	1,      5,     14,   1100,    20,     5, 180
ih		 	FLbox  	"Pythagorean tuning intervals are derived by stacking perfect fifths (3/2) and fourths (4/3) and transposing intervals down by ", 	1,      5,     14,   1100,    20,     5, 200
ih		 	FLbox  	"octaves (1/2) to bring them all within the same octave. Following this procedure all standard intervals can be created but the", 	1,      5,     14,   1100,    20,     5, 220
ih		 	FLbox  	"circle does not link up perfectly and an intervallic mismatch results between F# and C#.                                      ", 	1,      5,     14,   1100,    20,     5, 240
ih		 	FLbox  	"Notes in the various tuning systems can be activated either using the FLTK buttons or from a MIDI keyboard.                   ", 	1,      5,     14,   1100,    20,     5, 260
;ih		 	FLbox  	"", 	1,      5,     14,   1100,    20,     5,  40
                                                                                                                                                  
				FLpanel_end                                                                                       


	FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1	;A SINE WAVE
;		FN_NUM | INIT_TIME | SIZE | GEN_ROUTINE | NUM_GRADES | REPEAT | BASE_FREQ | BASE_KEY_MIDI | TUNING_RATIOS:-0-|----1----|---2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|----10----|---11----|-12-|
gijust	ftgen  0,           0,        64,        -2,          12,         2,     261.626,        60,                       1,   16/15,    9/8,     6/5,      5/4,       4/3,     45/32,     3/2,     8/5,      5/3,       9/5,     15/8,     2	;RATIOS FOR JUST INTONATION
gipyth	ftgen  0,           0,        64,        -2,          12,         2,     261.626,        60,                       1,  256/243,   9/8,    32/27,    81/64,      4/3,    729/512,    3/2,    128/81,   27/16,     16/9,     243/128,  2	;RATIOS FOR PYTHAGOREAN TUNING

instr	1	;MIDI ACTIVATED INSTRUMENT
	icpsET	cpsmidi		;NOTE PITCH IN CYCLES PER SECOND (EQUALLY TEMPERED)
	icpsJI	cpstmid	gijust	;NOTE PITCH IN CYCLES PER SECOND (JUST INTONATION)
	icpsPy	cpstmid	gipyth	;NOTE PITCH IN CYCLES PER SECOND (PYTHAGOREAN)
	if	gkmode==0	then	;IF 'EQUAL TEMPERAMENT' MIDI MODE HAS BEEN CHOSED...
		kcps	=	icpsET	;kcps TAKES EQUALLY TEMPERED PITCH VALUE
	elseif	gkmode==1	then	;IF 'JUST INTONATION' MIDI MODE HAS BEEN CHOSED...
		kcps	=	icpsJI  ;kcps TAKES JUST INTONATION PITCH VALUE
	elseif	gkmode==2	then	;IF 'PYTHAGOREAN' MIDI MODE HAS BEEN CHOSED...
		kcps	=	icpsPy  ;kcps TAKES PYTHAGOREAN PITCH VALUE
	endif				;END OF CONDITIONAL BRANCHING
	iporttime	=	0.01			;PORTAMENTO TIME
	kporttime	linseg	0,iporttime,1,1,1	;CREATE A RAMPING UP FUNCTION FOR PORTAMENTO TIME
	kamp1	portk	gkamp1, kporttime		;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE		
	kamp2	portk	gkamp2, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp3	portk	gkamp3, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp4	portk	gkamp4, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp5	portk	gkamp5, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp6	portk	gkamp6, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp7	portk	gkamp7, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp8	portk	gkamp8, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp9	portk	gkamp9, kporttime               ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp10	portk	gkamp10, kporttime              ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp11	portk	gkamp11, kporttime              ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp12	portk	gkamp12, kporttime              ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp13	portk	gkamp13, kporttime              ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp14	portk	gkamp14, kporttime              ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp15	portk	gkamp15, kporttime              ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	kamp16	portk	gkamp16, kporttime              ;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE
	
	a1	oscili	1-kamp1,  kcps, gisine		;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a2	oscili	1-kamp2,  kcps*2, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a3	oscili	1-kamp3,  kcps*3, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a4	oscili	1-kamp4,  kcps*4, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a5	oscili	1-kamp5,  kcps*5, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a6	oscili	1-kamp6,  kcps*6, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a7	oscili	1-kamp7,  kcps*7, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a8	oscili	1-kamp8,  kcps*8, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a9	oscili	1-kamp9,  kcps*9, gisine        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a10	oscili	1-kamp10, kcps*10, gisine       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a11	oscili	1-kamp11, kcps*11, gisine       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a12	oscili	1-kamp12, kcps*12, gisine       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a13	oscili	1-kamp13, kcps*13, gisine       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a14	oscili	1-kamp14, kcps*14, gisine       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a15	oscili	1-kamp15, kcps*15, gisine       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a16	oscili	1-kamp16, kcps*16, gisine       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	asig	sum	a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16	;SUM (MIX) ALL PARTIALS
	aenv	expsegr	0.01,0.001,1,0.05,0.001					;CREATE AN AMPLITUDE ENVELOPE WITH A RELEASE SEGMENT
	asig	=	(asig*aenv*gkGlobAmp)/16				;SCALE AUDIO SIGNAL USING GLOBAL AMPLITUDE SLIDER VARIABLE, AMPLITUDE ENVELOPE AND ACCORDING TO THE NUMBER OF PARTIALS PRESENT
	
	outs	asig,asig	;SEND AUDIO TO OUTPUTS
endin

;CREATE A MACRO FOR FLTK INSTRUMENT TO REDUCE CODE REPETITION
;THIS MACRO WILL TAKE TWO INPUT ARGUMENTS FOR INSTRUMENT NUMBER AND A COUNTER THAT WILL RELATE TO THE NAMES OF THE VARIABLES OUTPUT BY FLTK BUTTONS
#define FLTK_INSTRUMENT(I'N)
#
instr	$I	;FLTK INSTRUMENT
	if	gk$N=0	then	;IF BUTTON IS 'OFF'
		turnoff		;TURN THIS INSTRUMENT OFF
	endif			;END OF CONDITIONAL BRANCHING
	icps	=	cpsoct(8) * p4	;CREATE THE RELEVANT PITCH VALUE IN CYCLES PER SECOND (THE INTERVAL (AS A RATIO) WITH REFERENCE TO MIDDLE C IS OUTPUT AS p4 BY THE FLTK BUTTONS)

	iporttime	=	0.01					;PORTAMENTO TIME
	kporttime	linseg	0,iporttime,iporttime,1,iporttime       ;CREATE A RAMPING UP FUNCTION FOR PORTAMENTO TIME
	kamp1	portk	gkamp1, kporttime				;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp2	portk	gkamp2, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp3	portk	gkamp3, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp4	portk	gkamp4, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp5	portk	gkamp5, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp6	portk	gkamp6, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp7	portk	gkamp7, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp8	portk	gkamp8, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp9	portk	gkamp9, kporttime                               ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp10	portk	gkamp10, kporttime                              ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp11	portk	gkamp11, kporttime                              ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp12	portk	gkamp12, kporttime                              ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp13	portk	gkamp13, kporttime                              ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp14	portk	gkamp14, kporttime                              ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp15	portk	gkamp15, kporttime                              ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp16	portk	gkamp16, kporttime                              ;APPLY PORTAMENTO TO SLIDER VARIABLE

	a1	oscili	1-kamp1,  icps, gisine				;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a2	oscili	1-kamp2,  icps*2, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a3	oscili	1-kamp3,  icps*3, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a4	oscili	1-kamp4,  icps*4, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a5	oscili	1-kamp5,  icps*5, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a6	oscili	1-kamp6,  icps*6, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a7	oscili	1-kamp7,  icps*7, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a8	oscili	1-kamp8,  icps*8, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a9	oscili	1-kamp9,  icps*9, gisine                        ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a10	oscili	1-kamp10, icps*10, gisine                       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a11	oscili	1-kamp11, icps*11, gisine                       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a12	oscili	1-kamp12, icps*12, gisine                       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a13	oscili	1-kamp13, icps*13, gisine                       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a14	oscili	1-kamp14, icps*14, gisine                       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a15	oscili	1-kamp15, icps*15, gisine                       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	a16	oscili	1-kamp16, icps*16, gisine                       ;CREATE OSCILLATOR FOR PARTIAL OF ADDITIVE SYNTHESIS TONE
	asig	sum	a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16	;SUM (MIX) ALL PARTIALS
	aenv	expsegr	0.01,0.001,1,0.05,0.001					;CREATE AN AMPLITUDE ENVELOPE WITH A RELEASE SEGMENT
	asig	=	(asig*aenv*gkGlobAmp)/16                                ;SCALE AUDIO SIGNAL USING GLOBAL AMPLITUDE SLIDER VARIABLE, AMPLITUDE ENVELOPE AND ACCORDING TO THE NUMBER OF PARTIALS PRESENT
	
	outs	asig,asig	;SEND AUDIO TO OUTPUTS
endin
#

;EXECUTE MACRO FOR EACH FLTK BUTTON
$FLTK_INSTRUMENT(101'1)
$FLTK_INSTRUMENT(102'2)
$FLTK_INSTRUMENT(103'3)
$FLTK_INSTRUMENT(104'4)
$FLTK_INSTRUMENT(105'5)
$FLTK_INSTRUMENT(106'6)
$FLTK_INSTRUMENT(107'7)
$FLTK_INSTRUMENT(108'8)
$FLTK_INSTRUMENT(109'9)
$FLTK_INSTRUMENT(110'10)
$FLTK_INSTRUMENT(111'11)
$FLTK_INSTRUMENT(112'12)
$FLTK_INSTRUMENT(113'13)
$FLTK_INSTRUMENT(114'14)
$FLTK_INSTRUMENT(115'15)
$FLTK_INSTRUMENT(116'16)
$FLTK_INSTRUMENT(117'17)
$FLTK_INSTRUMENT(118'18)
$FLTK_INSTRUMENT(119'19)
$FLTK_INSTRUMENT(120'20)
$FLTK_INSTRUMENT(121'21)
$FLTK_INSTRUMENT(122'22)
$FLTK_INSTRUMENT(123'23)
$FLTK_INSTRUMENT(124'24)
$FLTK_INSTRUMENT(125'25)
$FLTK_INSTRUMENT(126'26)
$FLTK_INSTRUMENT(127'27)
$FLTK_INSTRUMENT(128'28)
$FLTK_INSTRUMENT(129'29)
$FLTK_INSTRUMENT(130'30)
$FLTK_INSTRUMENT(131'31)
$FLTK_INSTRUMENT(132'32)
$FLTK_INSTRUMENT(133'33)
$FLTK_INSTRUMENT(134'34)
$FLTK_INSTRUMENT(135'35)
$FLTK_INSTRUMENT(136'36)
$FLTK_INSTRUMENT(137'37)
$FLTK_INSTRUMENT(138'38)
$FLTK_INSTRUMENT(139'39)

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>