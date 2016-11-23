 =====================================================================================================================================
|                                                            CSOUND MULTI FX                                                          |
|-------------------------------------------------------------------------------------------------------------------------------------|
|                                                    Written by Iain McCurdy, 2010                                                    |
 =====================================================================================================================================

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	0, 0, 0, 0, 0, 0	;SET INTERFACE COLOURS

;				LABEL       | WIDTH | HEIGHT | X | Y
			FLpanel	"Multi-FX",    1000,   430,    0,  0
			FLscroll               1000,   430,    0,  0

ix = 5		;X LOCATION OF FIRST EFFECT
iy = 15		;RELATIVE Y LOCATION OF ALL WIDGETS
#define	COUNT	#0#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#VOLUME#
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES					TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"@->  $L  @->", 	4,      10,    24,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Volume",    0,    1,    0,    1,     -1,    70,  ix+74, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE				FLsetVal_i	0, 	ih1$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#1#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#FILEPLAY#
FLcolor	18, 104, 10, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES						TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"@-> FILE-PLAY @->", 	4,      12,    23,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"File",      0,    1,    0,    1,     -1,    60,  ix+34, iy+55
gk2$L, ih2$L		FLknob	"Live",      0,    1,    0,    1,     -1,    60,  ix+124, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.5, 	ih1$L
				FLsetVal_i	0, 	ih2$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#2#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;------------------------------------------------------------------------------------------------------------------------------------
#define	L	#COMPRESSOR#
FLcolor	100, 100, 255, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"$L", 	4,      15,    24,     210,    70,    ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | IDUR | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL      | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Thresh.",      0, 0.05,    0,    1,     -1,    50,  ix+  5, iy+55
gk2$L, ih2$L		FLknob	"Ratio",        1,  100,   -1,    1,     -1,    50,  ix+ 57, iy+55
gk3$L, ih3$L		FLknob	"Att.",      0.01, 0.3,    0,    1,     -1,    50,  ix+109, iy+55
gk4$L, ih4$L		FLknob	"Post Gain",    1,  20,   -1,    1,     -1,    50,  ix+165, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.025, 	ih1$L
				FLsetVal_i	  5, 	ih2$L
				FLsetVal_i	0.1, 	ih3$L
				FLsetVal_i	1.1, 	ih4$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#3#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#ENVFOLLOWER#
FLcolor	200, 200, 252, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,       9,    15,   220,    390,   ix,  iy
;TEXT BOXES						TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"ENV FOLLOWER", 	4,       6,    27,     210,    70,    ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX  | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Sens",      0,     1,   0,    1,     -1,    60,  ix+  8, iy+55
gk2$L, ih2$L		FLknob	"Freq",      0,     1,   0,    1,     -1,    60,  ix+ 80, iy+55
gk3$L, ih3$L		FLknob	"Res",      0,   0.95,   0,    1,     -1,    60,  ix+152, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.65, 	ih1$L
				FLsetVal_i	0.2, 	ih2$L
				FLsetVal_i	0.75, 	ih3$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#4#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#DISTORTION#
FLcolor	255, 50, 52, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,       9,    15,   220,    390,   ix,  iy
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"$L", 	4,       6,    29,     210,    70,    ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX  | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Level",      0,     1,   0,    1,     -1,    60,  ix+  8, iy+55
gk2$L, ih2$L		FLknob	"Drive",      0,     1,   0,    1,     -1,    60,  ix+ 80, iy+55
gk3$L, ih3$L		FLknob	"Tone",       0,     1,   0,    1,     -1,    60,  ix+152, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.5, 	ih1$L
				FLsetVal_i	0.06, 	ih2$L
				FLsetVal_i	5000, 	ih3$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------



#define	COUNT	#5#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT



;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#REVERSE#	;INSERT NAME OF EFFECT HERE - THIS WILL ALSO APPEAR AS ITS NAME ON THE GUI AND MUST CORRESPOND TO THE NAME GIVEN TO ITS CORRESPONDING ORCHESTRA INSTRUMENT (SEE INSTR. 19)
FLcolor	7, 27, 23, 0, 0, 0	;SET INTERFACE COLOURS. FIRST THREE NUMBERS GIVE THE RGB (RED.GREEN.BLUE) VALUES FOR THE PANEL, THE SECOND THREE GIVE THE RGB VALUES FOR THE WRITING
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy	;THE OUTER BOX OF THE EFFECT
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"$L", 	4,       4,    28,     210,    70,   ix+5, iy+145	;THE NAME PLATE
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1	;THE ON/OFF 'LED'
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT	;THE 'FOOT' SWITCH
;KNOBS				LABEL   | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Time",   0.3,   2,    0,    1,     -1,    70,  ix+74, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	 1, 	ih1$L
FLsetTextColor 255, 255, 255, ih$L
FLsetTextColor 255, 255, 255, ih1$L
FLsetColor2 255, 255, 255, ih1$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#6#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#PITCH_SHIFTER#
FLcolor	255, 255, 100, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,       9,    15,   220,    390,   ix,  iy
;TEXT BOXES					TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"PITCH SHIFTER",4,       6,    24,     210,    70,    ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN  | MAX  | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Mix",      0,       1,    0,    1,     -1,    50,  ix+  5, iy+55
gk2$L, ih2$L		FLknob	"Pitch",    -0.012,0.012,  0,    1,     -1,    50,  ix+ 57, iy+55
gk3$L, ih3$L		FLknob	"Fine",    -1/12, 1/12,    0,    1,     -1,    50,  ix+109, iy+55
gk4$L, ih4$L		FLknob	"F.Back",    0,      1,    0,    1,     -1,    50,  ix+165, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.25, 	ih1$L
				FLsetVal_i	0.007, 	ih2$L
				FLsetVal_i	0, 	ih3$L
				FLsetVal_i	0, 	ih4$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#7#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#FREQSHIFTER#
FLcolor	80, 10, 10, 0, 0, 0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES						TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"Frequency Shifter", 	4,       2,    23,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Mix",       0,     1,    0,    1,     -1,    50,  ix+  5, iy+55
gk2$L, ih2$L		FLknob	"Freq",   -1000, 1000,    0,    1,     -1,    50,  ix+ 57, iy+55
gk3$L, ih3$L		FLknob	"Mult",     -1,     1,    0,    1,     -1,    50,  ix+109, iy+55
gk4$L, ih4$L		FLknob	"F.back",    0,  0.75,    0,    1,     -1,    50,  ix+165, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.5, 	ih1$L
				FLsetVal_i	-50, 	ih2$L
				FLsetVal_i	0.1, 	ih3$L
				FLsetVal_i	0.6, 	ih4$L
FLsetTextColor 255, 255, 255, ih$L
FLsetTextColor 255, 255, 255, ih1$L
FLsetTextColor 255, 255, 255, ih2$L
FLsetTextColor 255, 255, 255, ih3$L
FLsetTextColor 255, 255, 255, ih4$L
FLsetColor2 255, 255, 255, ih1$L
FLsetColor2 255, 255, 255, ih2$L
FLsetColor2 255, 255, 255, ih3$L
FLsetColor2 255, 255, 255, ih4$L
ix = ix + 240
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#8#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#RINGMODULATOR#
FLcolor	7, 140, 130, 0, 0, 0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES						TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"RING MODULATOR", 	4,       8,    24,     210,     70,  ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT	;THE 'FOOT' SWITCH
;KNOBS				LABEL     | MIN  | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Mix",         0,    1,   0,    1,     -1,    60,  ix+  8, iy+55
gk2$L, ih2$L		FLknob	"Freq",        0,    1,   0,    1,     -1,    60,  ix+ 80, iy+55
gk3$L, ih3$L		FLknob	"Env",         0,    1,   0,    1,     -1,    60,  ix+152, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	1, 	ih1$L
				FLsetVal_i	0.2, 	ih2$L
				FLsetVal_i	0.5, 	ih3$L
ix = ix + 240
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#9#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#PHASER#
FLcolor	250, 130, 50, 0, 0, 0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES					TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"~PHASER~", 	4,      10,    26,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     |  MIN   | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Rate",         0,     1,    0,    1,     -1,    50,  ix+  5, iy+55
gk2$L, ih2$L		FLknob	"Depth",        0,     8,    0,    1,     -1,    50,  ix+ 57, iy+55
gk3$L, ih3$L		FLknob	"Freq",         6,    11,    0,    1,     -1,    50,  ix+109, iy+55
gk4$L, ih4$L		FLknob	"F.Back",       0,   0.9,    0,    1,     -1,    50,  ix+165, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.2, 	ih1$L
				FLsetVal_i	4, 	ih2$L
				FLsetVal_i	8, 	ih3$L
				FLsetVal_i	0.5, 	ih4$L
ix = ix + 240
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#10#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#LoFi#
FLcolor	50, 0, 15, 0, 0, 0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"$L", 	4,       6,    29,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Bits",      0,   0.6,   0,    1,     -1,    60,  ix+34, iy+55
gk2$L, ih2$L		FLknob	"Fold",      0,     1,   0,    1,     -1,    60,  ix+124, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0, 	ih1$L
				FLsetVal_i	0, 	ih2$L
FLsetTextColor 255, 255, 255, ih$L
FLsetTextColor 255, 255, 255, ih1$L
FLsetTextColor 255, 255, 255, ih2$L
FLsetColor2 255, 255, 255, ih1$L
FLsetColor2 255, 255, 255, ih2$L
ix = ix + 240
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#11#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#FILTER#
FLcolor	15, 0, 50, 0, 0, 0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"$L", 	4,       2,    29,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"HPF",      20,  20000,  -1,    1,     -1,    60,  ix+  8, iy+55
gk2$L, ih2$L		FLknob	"LPF",      20,  20000,  -1,    1,     -1,    60,  ix+ 80, iy+55
gk3$L, ih3$L		FLknob	"Gain",      1,     20,  -1,    1,     -1,    60,  ix+152, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	20, 	ih1$L
				FLsetVal_i	20000, 	ih2$L
				FLsetVal_i	1, 	ih3$L
FLsetTextColor 255, 255, 255, ih$L
FLsetTextColor 255, 255, 255, ih1$L
FLsetTextColor 255, 255, 255, ih2$L
FLsetTextColor 255, 255, 255, ih3$L
FLsetColor2 255, 255, 255, ih1$L
FLsetColor2 255, 255, 255, ih2$L
FLsetColor2 255, 255, 255, ih3$L
ix = ix + 240
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#12#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#PANTREM#
FLcolor	250, 80, 130, 0, 0, 0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES						TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"AUTO-PAN / TREMOLO", 	4,       1,    18,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Rate",       0,  1,    0,    1,     -1,    50,  ix+  5, iy+55
gk2$L, ih2$L		FLknob	"Depth",      0,  1,    0,    1,     -1,    50,  ix+ 57, iy+55
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    250,    80,    130
;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT |   X   | Y    | OPCODE | INS | STARTTIM | DUR
gk3$L, ih3$L		FLbutBank	11,     1,     2,     18,      30,   ix+111, iy+64,   -1
gk4$L, ih4$L		FLbutBank	11,     1,     3,     18,      45,   ix+162, iy+58,   -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT |   X   |  Y
ih		 	FLbox  	"Pan ", 	1,       5,    11,     28,      15,  ix+131,  iy+64
ih		 	FLbox  	"Trem", 	1,       5,    11,     28,      15,  ix+131,  iy+79
ih		 	FLbox  	"Sine", 	1,       5,    11,     28,      15,  ix+182,  iy+58
ih		 	FLbox  	"Tri.", 	1,       5,    11,     28,      15,  ix+182,  iy+73
ih		 	FLbox  	"Sq. ", 	1,       5,    11,     28,      15,  ix+182,  iy+88
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
			FLsetVal_i	0.3, 	ih1$L
			FLsetVal_i	1, 	ih2$L
			FLsetVal_i	0, 	ih3$L
			FLsetVal_i	0, 	ih4$L
ix = ix + 240
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#13#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#CHORUS#
FLcolor	100, 0, 205, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES						TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"STEREO CHORUS", 	4,       6,    24,     210,    70,    ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX  | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Rate",       0,    1,    0,    1,     -1,    60,  ix+  8, iy+55
gk2$L, ih2$L		FLknob	"Depth",      0,    1,    0,    1,     -1,    60,  ix+ 80, iy+55
gk3$L, ih3$L		FLknob	"Width",      0,    1,    0,    1,     -1,    60,  ix+152, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.4, 	ih1$L
				FLsetVal_i	0.2, 	ih2$L
				FLsetVal_i	0.25,   ih3$L
FLsetTextColor 255, 255, 255, ih$L
FLsetTextColor 255, 255, 255, ih1$L
FLsetTextColor 255, 255, 255, ih2$L
FLsetTextColor 255, 255, 255, ih3$L
FLsetColor2 255, 255, 255, ih1$L
FLsetColor2 255, 255, 255, ih2$L
FLsetColor2 255, 255, 255, ih3$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#14#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#FLANGER#
FLcolor	100, 250, 100, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"$L", 	4,       3,    26,     210,    70,    ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     |  MIN   | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Rate",         0,     1,    0,    1,     -1,    50,  ix+  5, iy+55
gk2$L, ih2$L		FLknob	"Depth",        0,     1,    0,    1,     -1,    50,  ix+ 57, iy+55
gk3$L, ih3$L		FLknob	"Delay",        0,     1,    0,    1,     -1,    50,  ix+109, iy+55
gk4$L, ih4$L		FLknob	"F.Back",       0,  0.99,    0,    1,     -1,    50,  ix+165, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.1, 	ih1$L
				FLsetVal_i	0.5, 	ih2$L
				FLsetVal_i	0.1, 	ih3$L
				FLsetVal_i	0.9, 	ih4$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#15#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#DELAY#
FLcolor	80, 10, 75, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"$L", 	4,       9,    34,     210,    70,    ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN  | MAX  | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Mix",         0,     1,    0,    1,     -1,    50,  ix+  5, iy+55
gk2$L, ih2$L		FLknob	"Time",     0.01,     5,   -1,    1,     -1,    50,  ix+ 57, iy+55
gk3$L, ih3$L		FLknob	"F.back",      0,   1.5,    0,    1,     -1,    50,  ix+109, iy+55
gk4$L, ih4$L		FLknob	"HF Loss",     0,     1,    0,    1,     -1,    50,  ix+165, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.3, 	ih1$L
				FLsetVal_i	0.35, 	ih2$L
				FLsetVal_i	0.7, 	ih3$L
				FLsetVal_i	0.7, 	ih4$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
FLsetTextColor 255, 255, 255, ih$L
FLsetTextColor 255, 255, 255, ih1$L
FLsetTextColor 255, 255, 255, ih2$L
FLsetTextColor 255, 255, 255, ih3$L
FLsetTextColor 255, 255, 255, ih4$L
FLsetColor2 255, 255, 255, ih1$L
FLsetColor2 255, 255, 255, ih2$L
FLsetColor2 255, 255, 255, ih3$L
FLsetColor2 255, 255, 255, ih4$L
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#16#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#REVERB#
FLcolor	100, 52, 10, 0, 0, 0	;SET INTERFACE COLOURS
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih$L		 	FLbox  	"$L", 	4,       15,    24,     210,    70,   ix+5, iy+145
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"Mix",        0,     1,   0,    1,     -1,    60,  ix+  8, iy+55
gk2$L, ih2$L		FLknob	"Size",    0.01,     1,   0,    1,     -1,    60,  ix+ 80, iy+55
gk3$L, ih3$L		FLknob	"Tone",      20, 20000,  -1,    1,     -1,    60,  ix+152, iy+55
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.5, 	ih1$L
				FLsetVal_i	0.8, 	ih2$L
				FLsetVal_i	10000, 	ih3$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
FLsetTextColor 255, 255, 255, ih$L
FLsetTextColor 255, 255, 255, ih1$L
FLsetTextColor 255, 255, 255, ih2$L
FLsetTextColor 255, 255, 255, ih3$L
FLsetColor2 255, 255, 255, ih1$L
FLsetColor2 255, 255, 255, ih2$L
FLsetColor2 255, 255, 255, ih3$L
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#17#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#EQUALIZER#		;INSERT NAME OF EFFECT HERE - THIS WILL ALSO APPEAR AS ITS NAME ON THE GUI AND MUST CORRESPOND TO THE NAME GIVEN TO ITS CORRESPONDING ORCHESTRA INSTRUMENT (SEE INSTR. 19)
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS. FIRST THREE NUMBERS GIVE THE RGB (RED.GREEN.BLUE) VALUES FOR THE PANEL, THE SECOND THREE GIVE THE RGB VALUES FOR THE WRITING
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy	;THE OUTER BOX OF THE EFFECT
;TEXT BOXES					TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"EQUALIZER", 	4,       2,    28,     210,    70,   ix+5, iy+145	;THE NAME PLATE
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1	;THE ON/OFF 'LED'
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT	;THE 'FOOT' SWITCH
;SLIDERS				MIN   |  MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT |  X   |   Y
gk1$L, ih1$L	FLslider 	"100",	0,        1,    0,    24,      -1,       15,     80,     ix+15,   iy+40
gk2$L, ih2$L	FLslider 	"200",	0,        1,    0,    24,      -1,       15,     80,     ix+40,   iy+40
gk3$L, ih3$L	FLslider 	"400",	0,        1,    0,    24,      -1,       15,     80,     ix+65,   iy+40
gk4$L, ih4$L	FLslider 	"800",	0,        1,    0,    24,      -1,       15,     80,     ix+90,   iy+40
gk5$L, ih5$L	FLslider 	"1k6",	0,        1,    0,    24,      -1,       15,     80,     ix+115,  iy+40
gk6$L, ih6$L	FLslider 	"3k2",  0,        1,    0,    24,      -1,       15,     80,     ix+140,  iy+40
gk7$L, ih7$L	FLslider 	"6k4", 0,        1,    0,    24,      -1,       15,     80,     ix+165,  iy+40
gk8$L, ih8$L	FLslider 	"Gain", 0,        1,    0,    24,      -1,       15,     80,     ix+190,  iy+40
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.5, 	ih1$L
				FLsetVal_i	0.5, 	ih2$L
				FLsetVal_i	0.5, 	ih3$L
				FLsetVal_i	0.5, 	ih4$L
				FLsetVal_i	0.5, 	ih5$L
				FLsetVal_i	0.5, 	ih6$L
				FLsetVal_i	0.5, 	ih7$L
				FLsetVal_i	0.5, 	ih8$L
FLsetTextSize	10, ih1$L
FLsetTextSize	10, ih2$L
FLsetTextSize	10, ih3$L
FLsetTextSize	10, ih4$L
FLsetTextSize	10, ih5$L
FLsetTextSize	10, ih6$L
FLsetTextSize	10, ih7$L
FLsetTextSize	10, ih8$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#18#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
#define	L	#BLANK#		;INSERT NAME OF EFFECT HERE - THIS WILL ALSO APPEAR AS ITS NAME ON THE GUI AND MUST CORRESPOND TO THE NAME GIVEN TO ITS CORRESPONDING ORCHESTRA INSTRUMENT (SEE INSTR. 19)
FLcolor	250, 90, 0, 0, 0, 0	;SET INTERFACE COLOURS. FIRST THREE NUMBERS GIVE THE RGB (RED.GREEN.BLUE) VALUES FOR THE PANEL, THE SECOND THREE GIVE THE RGB VALUES FOR THE WRITING
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   220,    390,   ix,  iy	;THE OUTER BOX OF THE EFFECT
;TEXT BOXES				TYPE | FONT | SIZE |  WIDTH | HEIGHT | X   | Y
ih		 	FLbox  	"$L", 	4,       1,    24,     210,    70,   ix+5, iy+145	;THE NAME PLATE
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |   X   |  Y   | OPCODE | INS | STARTTIM | DUR  | p4
gk$L.LED, gih$L.LED		FLbutton	"",	1,    0,     4,     10,     10,   ix+100, iy+15,   -1	;THE ON/OFF 'LED'
FLsetColor2	255, 0, 0, gih$L.LED	;SET INTERFACE COLOURS
gk$L.OnOff, ih$L.OnOff		FLbutton	"",	1,    0,    21,    200,    140,   ix+10,  iy+235,   0,     1,      0,       0.01,  $COUNT	;THE 'FOOT' SWITCH
;KNOBS				LABEL     | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gk1$L, ih1$L		FLknob	"-",        0,     1,    0,    1,     -1,    50,  ix+  5, iy+55	;KNOB 1. NOTE THAT THE TEXT MACRO FOR THE EFFECT NAME IS ADDED TO THE VARIABLE NAME TO ENSURE THAT EACH KNOB WILL HAVE A UNIQUE VARIABLE NAME (PROVIDED EACH EFFECT HAS A UNIQUE NAME)
gk2$L, ih2$L		FLknob	"-",        0,     1,    0,    1,     -1,    50,  ix+ 57, iy+55	;KNOB 2
gk3$L, ih3$L		FLknob	"-",        0,     1,    0,    1,     -1,    50,  ix+109, iy+55	;KNOB 3
gk4$L, ih4$L		FLknob	"-",        0,     1,    0,    1,     -1,    50,  ix+165, iy+55	;KNOB 4
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0, 	ih1$L
				FLsetVal_i	0, 	ih2$L
				FLsetVal_i	0, 	ih3$L
				FLsetVal_i	0, 	ih4$L
ix = ix + 240		;DEFINES THE SPACING BETWEEN EACH EFFECT
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#19#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
;INSERT EFFECT GUI HERE
;-----------------------------------------------------------------------------------------------------------------------------------


#define	COUNT	#20#	;COUNTER IS INCREMENTED FOR EACH ADDITIONAL EFFECT


;-----------------------------------------------------------------------------------------------------------------------------------
;INSERT EFFECT GUI HERE
;-----------------------------------------------------------------------------------------------------------------------------------










		FLscrollEnd
		FLpanel_end

		
		
		
		
		
		
		
		
;INSTRUCTIONS AND INFO PANEL
FLcolor	255, 255, 255, 0, 0, 0
				FLpanel	" ", 1000, 300, 0, 500
				FLscroll     1000, 300, 0, 0
;TEXT BOXES												                                                      		TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                                   Effects Modules                                                        ", 	1,      5,     14,    990,    20,     5,   0
ih		 	FLbox  	"--------------------------------------------------------------------------------------------------------------------------", 	1,      5,     14,    990,    20,     5,  20
ih		 	FLbox  	"This example proposes a method of designing Csound effects modules. It is designed so that modules can be moved or added  ", 	1,      5,     14,    990,    20,     5,  40
ih		 	FLbox  	"with a minumum of fuss. To add a module it is only required to copy the GUI code from another existing effect and to      ", 	1,      5,     14,    990,    20,     5,  60
ih		 	FLbox  	"change its name. Positioning and spacing of GUI widgets will be handled automatically. The code for the effect is added in", 	1,      5,     14,    990,    20,     5,  80
ih		 	FLbox  	"a single inatrument. Effect instruments are added sequentially from instr 10 onwards and the numeric sequence in which    ", 	1,      5,     14,    990,    20,     5, 100
ih		 	FLbox  	"they are added defines the sequence in which they will be connected. A blank effect has been placed at the end of the line", 	1,      5,     14,    990,    20,     5, 120
ih		 	FLbox  	"to serve as a template for adding an additional effect. Effects can be repeated by simply copying and pasting the GUI and ", 	1,      5,     14,    990,    20,     5, 140
ih		 	FLbox  	"the instrument code for that effect. It is only required that each effect has a unique name so, for example, to add a     ", 	1,      5,     14,    990,    20,     5, 160
ih		 	FLbox  	"second pitch shifter the second one could be called PITCHSHIFTER2 using its text macro in order to distinuish it from the ", 	1,      5,     14,    990,    20,     5, 180
ih		 	FLbox  	"first one. The GUI design and general approach has been based on so called 'stomp boxes' that might be used by an electric", 	1,      5,     14,    990,    20,     5, 200
ih		 	FLbox  	"guitarist. Efficient use of the computer's resources is made by making each effect a unique Csound instrument which is    ", 	1,      5,     14,    990,    20,     5, 220
ih		 	FLbox  	"switched on or off as needed. Many of the effects make use of UDOs so that they can be transplanted into a different      ", 	1,      5,     14,    990,    20,     5, 240
ih		 	FLbox  	"project if required. These UDOs are also available individually in my UDOs download section.                              ", 	1,      5,     14,    990,    20,     5, 260 
ih		 	FLbox  	"This example works on the computer's live input. Input is stereo and all effects are stereo in, stereo out.               ", 	1,      5,     14,    990,    20,     5, 280
ih		 	FLbox  	"If you don't have live input configured on your computer you can also access a built-in sound file using the 'File Play'  ", 	1,      5,     14,    990,    20,     5, 300
ih		 	FLbox  	"module.                                                                                                                   ", 	1,      5,     14,    990,    20,     5, 320
ih		 	FLbox  	"Instructions for each individual effect follows:                                                                          ", 	1,      5,     14,    990,    20,     5, 340
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5, 360
ih		 	FLbox  	"VOLUME                                                                                                                    ", 	1,      5,     14,    990,    20,     5, 380
ih		 	FLbox  	"------                                                                                                                    ", 	1,      5,     14,    990,    20,     5, 400
ih		 	FLbox  	"A simple volume control. If the effect is bypassed the input signal passes through unchanged.                             ", 	1,      5,     14,    990,    20,     5, 420
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5, 440
ih		 	FLbox  	"FILE-PLAY                                                                                                                 ", 	1,      5,     14,    990,    20,     5, 460
ih		 	FLbox  	"---------                                                                                                                 ", 	1,      5,     14,    990,    20,     5, 480
ih		 	FLbox  	"A file player effect. Edit code to change the sound file used. Separate volume controls for the sound file and the input  ", 	1,      5,     14,    990,    20,     5, 500
ih		 	FLbox  	"sound. The main purpose of this module is to provide some audio input for auditioning effects if live audio is not        ", 	1,      5,     14,    990,    20,     5, 520
ih		 	FLbox  	"available.                                                                                                                ", 	1,      5,     14,    990,    20,     5, 540
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5, 560
ih		 	FLbox  	"COMPRESSOR                                                                                                                ", 	1,      5,     14,    990,    20,     5, 580
ih		 	FLbox  	"----------                                                                                                                ", 	1,      5,     14,    990,    20,     5, 600
ih		 	FLbox  	"A dynamic compressor with controls for threshold (turning the knob clockwise lowers the threshold), compressions ratio    ", 	1,      5,     14,    990,    20,     5, 620
ih		 	FLbox  	"(1:1 - 100:1), attack time of the compression (0.01 - 0.3 seconds) and a gain compensation control (1 - 20).              ", 	1,      5,     14,    990,    20,     5, 640
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5, 660
ih		 	FLbox  	"ENV FOLLOWER                                                                                                              ", 	1,      5,     14,    990,    20,     5, 680
ih		 	FLbox  	"------------                                                                                                              ", 	1,      5,     14,    990,    20,     5, 700
ih		 	FLbox  	"A dynamic envelope following low-pass filter that used Csound's moogladder low-pass filter. Controls are for the          ", 	1,      5,     14,    990,    20,     5, 720
ih		 	FLbox  	"sensitivity of the envelope following, basic frequency of the filter (100-10000 Hz) and resonance of the filter.          ", 	1,      5,     14,    990,    20,     5, 740
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5, 760
ih		 	FLbox  	"DISTORTION                                                                                                                ", 	1,      5,     14,    990,    20,     5, 780 
ih		 	FLbox  	"----------                                                                                                                ", 	1,      5,     14,    990,    20,     5, 800 
ih		 	FLbox  	"A distortion effect with controls for level whenever the effect is active, drive (amount of distortion) and tone          ", 	1,      5,     14,    990,    20,     5, 820 
ih		 	FLbox  	"(basically a low-pass filter).                                                                                            ", 	1,      5,     14,    990,    20,     5, 840 
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5, 860 
ih		 	FLbox  	"REVERSE                                                                                                                   ", 	1,      5,     14,    990,    20,     5, 880
ih		 	FLbox  	"-------                                                                                                                   ", 	1,      5,     14,    990,    20,     5, 900
ih		 	FLbox  	"Reverses buffered chunks of sound received in real-time at its input. The user can control the length of the buffer from  ", 	1,      5,     14,    990,    20,     5, 920
ih		 	FLbox  	"0.1 - 2 seconds.                                                                                                          ", 	1,      5,     14,    990,    20,     5, 940
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5, 960
ih		 	FLbox  	"PITCH SHIFTER                                                                                                             ", 	1,      5,     14,    990,    20,     5, 980
ih		 	FLbox  	"-------------                                                                                                             ", 	1,      5,     14,    990,    20,     5,1000
ih		 	FLbox  	"A pitch shifter that uses streaming phase vocoding technology. Controls for mix (minimum=all dry signal, maximum=all      ", 	1,      5,     14,    990,    20,     5,1020
ih		 	FLbox  	"effect), pitch (-1 octave to +1 octave in semitone steps), fine (-100 cents to +100 steps) and amount of output signal    ", 	1,      5,     14,    990,    20,     5,1040
ih		 	FLbox  	"fed back into the input (0% - 100%).                                                                                      ", 	1,      5,     14,    990,    20,     5,1060
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1080
ih		 	FLbox  	"FREQUENCY SHIFTER                                                                                                         ", 	1,      5,     14,    990,    20,     5,1100
ih		 	FLbox  	"-----------------                                                                                                         ", 	1,      5,     14,    990,    20,     5,1120
ih		 	FLbox  	"A frequency shifter using Csound's hilbert opcode. Controls for mix (minimum=all dry signal, maximum=all effect),         ", 	1,      5,     14,    990,    20,     5,1140
ih		 	FLbox  	"frequency shift (-1000 to +1000), multiplier - a value in the range -1 to +1 which is multiplied to the frequency shift   ", 	1,      5,     14,    990,    20,     5,1160
ih		 	FLbox  	"value and can be used to adjust the sensitivity of the 'Freq.' control - and finally a feedback control which controls    ", 	1,      5,     14,    990,    20,     5,1180
ih		 	FLbox  	"the amount of output signal that is fed back into the input (0% - 75%).                                                   ", 	1,      5,     14,    990,    20,     5,1200
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1220
ih		 	FLbox  	"RING MODULATOR                                                                                                            ", 	1,      5,     14,    990,    20,     5,1240
ih		 	FLbox  	"--------------                                                                                                            ", 	1,      5,     14,    990,    20,     5,1260
ih		 	FLbox  	"A ring modulator effect with controls for mix (minimum=all dry signal, maximum=all effect), modulating frequency          ", 	1,      5,     14,    990,    20,     5,1280
ih		 	FLbox  	"(10-5000Hz) and an envelope control which controls the amount of influence the dynamics of the input sound has over the   ", 	1,      5,     14,    990,    20,     5,1300
ih		 	FLbox  	"modulating frequency.                                                                                                     ", 	1,      5,     14,    990,    20,     5,1320
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1340
ih		 	FLbox  	"PHASER                                                                                                                    ", 	1,      5,     14,    990,    20,     5,1360
ih		 	FLbox  	"------                                                                                                                    ", 	1,      5,     14,    990,    20,     5,1380
ih		 	FLbox  	"An 8 ordinate phaser effect with controls for rate (0.01 Hz - 14 Hz), depth (0 - 8 octaves), base frequency (65 - 4000 Hz)", 	1,      5,     14,    990,    20,     5,1400
ih		 	FLbox  	"and a feedback control which controls the intensity of the effect.                                                        ", 	1,      5,     14,    990,    20,     5,1420
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1440
ih		 	FLbox  	"LoFi                                                                                                                      ", 	1,      5,     14,    990,    20,     5,1460
ih		 	FLbox  	"------                                                                                                                    ", 	1,      5,     14,    990,    20,     5,1480
ih		 	FLbox  	"Digital decimation of the input signal. Controls for bit depth reduction from 16 to 2 bits and for sample rate reduction  ", 	1,      5,     14,    990,    20,     5,1500
ih		 	FLbox  	"(44100Hz to 172Hz).                                                                                                       ", 	1,      5,     14,    990,    20,     5,1520
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1540
ih		 	FLbox  	"FILTER                                                                                                                    ", 	1,      5,     14,    990,    20,     5,1560
ih		 	FLbox  	"------                                                                                                                    ", 	1,      5,     14,    990,    20,     5,1580
ih		 	FLbox  	"A high-pass followed by a low-pass filter, both 48dB/octave. Controls for high-pass filter cutoff, high-pass filter cutoff", 	1,      5,     14,    990,    20,     5,1600
ih		 	FLbox  	"and gain.                                                                                                                 ", 	1,      5,     14,    990,    20,     5,1620
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1640
ih		 	FLbox  	"AUTO-PAN/TREMOLO                                                                                                          ", 	1,      5,     14,    990,    20,     5,1660
ih		 	FLbox  	"----------------                                                                                                          ", 	1,      5,     14,    990,    20,     5,1680
ih		 	FLbox  	"A effect that applies lfo controlled panning or amplitude modulation. Controls for LFO rate (0.1 - 50 Hz), depth of       ", 	1,      5,     14,    990,    20,     5,1700
ih		 	FLbox  	"modulation, mode (auto-panning or tremolo/amplitude modulation) and LFO waveform type (sine, triangle or square).         ", 	1,      5,     14,    990,    20,     5,1720
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1740
ih		 	FLbox  	"STEREO CHORUS                                                                                                             ", 	1,      5,     14,    990,    20,     5,1760
ih		 	FLbox  	"-------------                                                                                                             ", 	1,      5,     14,    990,    20,     5,1780
ih		 	FLbox  	"A stereo chorus effect with controls for the rate of modulation (0.001 - 7 Hz), depth of modulation (0 - 0.01 secs.) and  ", 	1,      5,     14,    990,    20,     5,1800
ih		 	FLbox  	"phase interval between the left and right channel LFOs (0degs - 180degs).                                                 ", 	1,      5,     14,    990,    20,     5,1820
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1840
ih		 	FLbox  	"FLANGER                                                                                                                   ", 	1,      5,     14,    990,    20,     5,1860
ih		 	FLbox  	"-------                                                                                                                   ", 	1,      5,     14,    990,    20,     5,1880
ih		 	FLbox  	"A flanger effect with controls for rate of modulation (0.001 - 7 Hz), depth of modulation (0 - 0.1 secs.), delay          ", 	1,      5,     14,    990,    20,     5,1900
ih		 	FLbox  	"modulation offset (0.0001 - 0.01 secs) and feedback (0% - 99%).                                                           ", 	1,      5,     14,    990,    20,     5,1920
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,1940
ih		 	FLbox  	"ANALOG DELAY                                                                                                              ", 	1,      5,     14,    990,    20,     5,1960
ih		 	FLbox  	"-----                                                                                                                     ", 	1,      5,     14,    990,    20,     5,1980
ih		 	FLbox  	"An analog style delay effect with controls for effect mix (minimum=all dry signal, maximum=all effect), delay time ,      ", 	1,      5,     14,    990,    20,     5,2000
ih		 	FLbox  	"(0.01 - 5 secs.) feedback (0% - 150%) and high frequency loss (a low-pass filter within the delay feedback loop 200 -     ", 	1,      5,     14,    990,    20,     5,2020
ih		 	FLbox  	"20000 Hz). High feedback settings will produce clipped saturation.                                                        ", 	1,      5,     14,    990,    20,     5,2040
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,2060
ih		 	FLbox  	"REVERB                                                                                                                    ", 	1,      5,     14,    990,    20,     5,2080
ih		 	FLbox  	"------                                                                                                                    ", 	1,      5,     14,    990,    20,     5,2100
ih		 	FLbox  	"A reverb effect that uses Csound's reverbsc opcode and with controls for effect mix (minimum=all dry signal, maximum=all  ", 	1,      5,     14,    990,    20,     5,2120
ih		 	FLbox  	"effect), room size and high frequency damping.                                                                            ", 	1,      5,     14,    990,    20,     5,2140
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,2160
ih		 	FLbox  	"EQUALIZER                                                                                                                 ", 	1,      5,     14,    990,    20,     5,2180
ih		 	FLbox  	"---------                                                                                                                 ", 	1,      5,     14,    990,    20,     5,2200
ih		 	FLbox  	"A stereo graphic equalizer. Gain controls centering around the frequencies 100Hz, 200Hz, 400Hz, 800Hz, 1600Hz, 3200Hz and ", 	1,      5,     14,    990,    20,     5,2220
ih		 	FLbox  	"6400Hz. The lowest control is a low shelving filter and the highest is a high shelving control.                           ", 	1,      5,     14,    990,    20,     5,2240
ih		 	FLbox  	"                                                                                                                          ", 	1,      5,     14,    990,    20,     5,2260
ih		 	FLbox  	"BLANK                                                                                                                     ", 	1,      5,     14,    990,    20,     5,2280
ih		 	FLbox  	"-----                                                                                                                     ", 	1,      5,     14,    990,    20,     5,2300
ih		 	FLbox  	"A blank effect intended for user modification.                                                                            ", 	1,      5,     14,    990,    20,     5,2320
			FLscrollEnd                                                                                                                                                                    
			FLpanel_end
			FLrun	;RUN THE FLTK WIDGET THREAD

;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	tables
giOnOffStatus	ftgen	0,0,16,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	;TABLE THAT STORES THE ON/OFF STATUS OF EACH EFFECT 0=OFF 1=ON
gisine	ftgen	0,0,4096,10,1
giWet	ftgentmp	0,0,1024,-7,0,512,1,512,1	;RESCALING FUNCTION FOR WET LEVEL CONTROL
giDry	ftgentmp	0,0,1024,-7,1,512,1,512,0	;RESCALING FUNCTION FOR DRY LEVEL CONTROL
endin

;UDOs----------------------------------------------------------------------------------------------------------------------
opcode	EnvelopeFollower,a,akkk
	ain,ksens,kfreq,kres	xin						;READ IN INPUT ARGUMENTS
	kfreq		expcurve	kfreq,4					;CREATE AN EXPONENTIAL REMAPPING OF kfreq
	kfreq		scale	kfreq,10000,10					;RESCALE 0 - 1 VALUE
	ksens		logcurve	ksens,3					;CREATE LOGARITHMIC REMAPPING OF ksens
	aFollow		follow2		ain, 0.01, 0.05				;AMPLITUDE FOLLOWING AUDIO SIGNAL
	kFollow		downsamp	aFollow					;DOWNSAMPLE TO K-RATE
	kFrq		=		kfreq + (cpsoct(kFollow*ksens*150))	;CREATE A LEFT CHANNEL MODULATING FREQUENCY BASE ON THE STATIC VALUE CREATED BY kfreq AND THE AMOUNT OF DYNAMIC ENVELOPE FOLLOWING GOVERNED BY ksens
	kFrq		port		kFrq, 0.05				;SMOOTH CONTROL SIGNAL USING PORTAMENTO
	kFrq		limit		kFrq, 20,sr/2				;LIMIT FREQUENCY RANGE TO PREVENT OUT OF RANGE FREQUENCIES  
	aout		moogladder	ain, kFrq, kres				;REDEFINE GLOBAL AUDIO SIGNAL AS FILTERED VERSION OF ITSELF
			xout		aout					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	Distortion, a, akkk
	ain,klevel,kdrive,ktone	xin							;READ IN INPUT ARGUMENTS
	klevel		scale		klevel,0.8,0					;RESCALE LEVEL CONTROL
	kdrive		expcurve	kdrive,8					;EXPONENTIALLY REMAP kdrive
	kdrive		scale		kdrive,0.4,0.01					;RESCALE kdrive
	kLPF		expcurve	ktone,4						;EXPONENTIALLY REMAP ktone
	kLPF		scale		kLPF,12000,200					;RESCALE klpf
	kGainComp1	logcurve	ktone,700					;LOGARITHMIC RESCALING OF ktone TO CREAT A GAIN COMPENSATION VARIABLE FOR WHEN TONE IS LOWERED
	kGainComp1	scale		kGainComp1,1,5					;RESCALE GAIN COMPENSATION VARIABLE
	kpregain	=		(kdrive*100)					;DEFINE PREGAIN FROM kdrive
	kpostgain	=		0.5 * (((1-kdrive) * 0.4) + 0.6)		;DEFINE POSTGAIN FROM kdrive
	aDist		distort1	ain*(32768/0dbfs), kpregain, kpostgain, 0, 0	;CREATE DISTORTION SIGNAL
	aDist		butlp		aDist/(32768/0dbfs), kLPF			;LOWPASS FILTER DISTORTED SIGNAL
			xout		aDist*klevel*kGainComp1				;SEND AUDIO BACK TO CALLER INSTRUMENT. RESCALE WITH USER LEVEL CONTROL AND GAIN COMPENSATION			
endop

opcode	Reverse, a, aK				;nb. CAPITAL K CREATE A K-RATE VARIABLE THAT HAS A USEFUL VALUE ALSO AT I-TIME
	ain,ktime	xin			;READ IN INPUT ARGUMENTS
	ktrig	changed	ktime			;IF ktime CONTROL IS MOVED GENERATE A MOMENTARY '1' IMPULSE
	if ktrig=1 then				;IF A TRIGGER HAS BEEN GENERATED IN THE LINE ABOVE...
		reinit	UPDATE			;...BEGIN A REINITILISATION PASS FROM LABEL 'UPDATE'
	endif					;END OF CONDITIONAL BRANCH
	UPDATE:					;LABEL CALLED 'UPDATE'
	itime	=	i(ktime)		;CREATE AN I-TIME VERSION OF ktime
	aptr	phasor	2/itime			;CREATE A MOVING PHASOR THAT WITH BE USED TO TAP THE DELAY BUFFER
	aptr	=	aptr*itime		;SCALE PHASOR ACCORDING TO THE LENGTH OF THE DELAY TIME CHOSEN BY THE USER
	ienv	ftgentmp	0,0,1024,7,0,(1024*0.01),1,(1024*0.98),1,(0.01*1024),0	;ANTI-CLICK ENVELOPE SHAPE
 	aenv	poscil	1, 2/itime, ienv	;CREATE A CYCLING AMPLITUDE ENVELOPE THAT WILL SYNC TO THE TAP DELAY TIME PHASOR 
 	abuffer	delayr	itime			;CREATE A DELAY BUFFER
	atap	deltap3	aptr			;READ AUDIO FROM A TAP WITHIN THE DELAY BUFFER
		delayw	ain			;WRITE AUDIO INTO DELAY BUFFER
	rireturn				;RETURN FROM REINITIALISATION PASS
	xout	atap*aenv			;SEND AUDIO BACK TO CALLER INSTRUMENT. APPLY AMPLITUDE ENVELOPE TO PREVENT CLICKS.
endop

opcode	PitchShifter,a,akkkk
	ain,kmix,kpitch,kfine,kfback	xin			;READ IN INPUT ARGUMENTS
	iWet	ftgentmp	0,0,1024,-7,0,512,1,512,1	;RESCALING FUNCTION FOR WET LEVEL CONTROL
	iDry	ftgentmp	0,0,1024,-7,1,512,1,512,0	;RESCALING FUNCTION FOR DRY LEVEL CONTROL
	kWet	table	kmix, iWet, 1				;RESCALE WET LEVEL CONTROL ACCORDING TO FUNCTION TABLE iWet
	kDry	table	kmix, iDry, 1				;RESCALE DRY LEVEL CONTROL ACCORDING TO FUNCTION TABLE iWet
	aPS	init	0                                       ;INITIALIZE aOutL FOR FIRST PERFORMANCE TIME PASS
	kscal	=	octave(((kpitch*1000)/12)+kfine)	;DERIVE PITCH SCALING RATIO. NOTE THAT THE 'COARSE' PITCH DIAL BECOMES STEPPED IN SEMITONE INTERVALS
	fsig1 	pvsanal	ain+(aPS*kfback), 1024,256,1024,0	;PHASE VOCODE ANALYSE LEFT CHANNEL
	fsig2 	pvscale fsig1, kscal				;RESCALE PITCH
	aPS 	pvsynth fsig2					;RESYNTHESIZE FROM FSIG
	aout	sum 	ain*kDry, aPS*kWet			;REDEFINE GLOBAL AUDIO SIGNAL FROM MIX OF DRY AND WET SIGNALS
		xout	aout					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	FreqShifter,a,akkkk
	adry,kmix,kfreq,kmult,kfback	xin			;READ IN INPUT ARGUMENTS
	iWet	ftgentmp	0,0,1024,-7,0,512,1,512,1	;RESCALING FUNCTION FOR WET LEVEL CONTROL
	iDry	ftgentmp	0,0,1024,-7,1,512,1,512,0	;RESCALING FUNCTION FOR DRY LEVEL CONTROL
	isine	ftgentmp	0,0,4096,10,1			;A SINE WAVE SHAPE
	kWet	table	kmix, iWet, 1				;RESCALE WET LEVEL CONTROL ACCORDING TO FUNCTION TABLE giWet
	kDry	table	kmix, iDry, 1				;RESCALE DRY LEVEL CONTROL ACCORDING TO FUNCTION TABLE giWet
	aFS	init	0					;INITILISE FEEDBACK SIGNAL (FOR FIRST K-PASS)
	ain	=	adry + (aFS * kfback)			;ADD FEEDBACK SIGNAL TO INPUT (AMOUNT OF FEEDBACK CONTROLLED BY 'Feedback Gain' SLIDER)
	areal, aimag hilbert ain				;HILBERT OPCODE OUTPUTS TWO PHASE SHIFTED SIGNALS, EACH 90 OUT OF PHASE WITH EACH OTHER
	kporttime	linseg	0,0.001,0.02
	kfshift	portk	kfreq*kmult, kporttime
	;QUADRATURE OSCILLATORS. I.E. 90 OUT OF PHASE WITH RESPECT TO EACH OTHER
	;OUTUTS	OPCODE	AMPLITUDE | FREQ. | FUNCTION_TABLE | INITIAL_PHASE (OPTIONAL;DEFAULTS TO ZERO)
	asin 	oscili       1,    kfshift,     isine,          0
	acos 	oscili       1,    kfshift,     isine,          0.25	
	;RING MODULATE EACH SIGNAL USING THE QUADRATURE OSCILLATORS AS MODULATORS
	amod1	=		areal * acos
	amod2	=		aimag * asin	
	;UPSHIFTING OUTPUT
	aFS	= (amod1 - amod2)
	aout	sum	aFS*kWet, adry*kDry		;CREATE WET/DRY MIX
		xout	aout				;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	RingModulator,a,akkk
	ain,kmix,kfreq,kenv	xin					;READ IN INPUT ARGUMENTS
	kfreq		expcurve	kfreq,4				;CREATE AN EXPONENTIAL REMAPPING OF kfreq
	kfreq		scale	kfreq,5000,10				;RESCALE 0 - 1 VALUE TO 10 - 5000
	iWet	ftgentmp	0,0,1024,-7,0,512,1,512,1		;RESCALING FUNCTION FOR WET LEVEL CONTROL
	iDry	ftgentmp	0,0,1024,-7,1,512,1,512,0		;RESCALING FUNCTION FOR DRY LEVEL CONTROL
	isine	ftgentmp	0,0,4096,10,1				;SINE WAVE
	kWet	table	kmix, iWet, 1					;RESCALE WET LEVEL CONTROL ACCORDING TO FUNCTION TABLE iWet
	kDry	table	kmix, iDry, 1					;RESCALE DRY LEVEL CONTROL ACCORDING TO FUNCTION TABLE iDry
	kporttime	linseg	0,0.001,0.02				;PORTAMENTO VARIABLE
	kModFrq	portk	kfreq, kporttime				;SMOOTH VARIABLE CHANGES
	kRMS	rms	ain						;FOLLOW THE RMS VALUE OF THE INPUT AUDIO
	kModFrq	=	kModFrq + (cpsoct(kRMS*kenv*100))     		;CREATE A LEFT CHANNEL MODULATING FREQUENCY BASE ON THE STATIC VALUE CREATED BY kfreq AND THE AMOUNT OF DYNAMIC ENVELOPE FOLLOWING GOVERNED BY kenv
	aMod	poscil	1, kModFrq, isine  				;CREATE RING MODULATING SIGNAL
	aout	sum	ain*kDry, ain*aMod*kWet				;MIX DRY AND WET SIGNALS
		xout	aout						;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	Phaser,a,akkkk
	ain,krate,kdepth,kfreq,kfback	xin					;READ IN INPUT ARGUMENTS
	krate		expcurve	krate,10					;CREATE AN EXPONENTIAL REMAPPING OF krate
	krate		scale	krate,14,0.01					;RESCALE 0 - 1 VALUE TO 0.01 - 14	
	klfo	lfo	kdepth*0.5, krate, 1					;LFO FOR THE PHASER (TRIANGULAR SHAPE)
	aout	phaser1	ain, cpsoct((klfo+(kdepth*0.5)+kfreq)), 8, kfback	;PHASER1 IS APPLIED TO THE INPUT AUDIO
		xout	aout							;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	LoFi,a,akk
	ain,kbits,kfold	xin									;READ IN INPUT ARGUMENTS
	kfold		expcurve	kfold,500						;CREATE AN EXPONENTIAL REMAPPING OF kfold
	kfold		scale	kfold,1024,1							;RESCALE 0 - 1 VALUE TO 1 - 1024	
	kvalues		pow	2, ((1-(kbits^0.25))*15)+1					;RAISES 2 TO THE POWER OF kbitdepth. THE OUTPUT VALUE REPRESENTS THE NUMBER OF POSSIBLE VALUES AT THAT PARTICULAR BIT DEPTH
	aout		=	(int((ain/0dbfs)*kvalues))/kvalues
	aout		fold 	aout, kfold							;APPLY SAMPLING RATE FOLDOVER
			xout	aout									;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	PanTrem,aa,aakkkk
	ainL,ainR,krate,kdepth,kmode,kwave	xin	;READ IN INPUT ARGUMENTS
	krate	expcurve	krate,5			;CREATE AN EXPONENTIAL REMAPPING OF krate
	krate	scale	krate,50,0.1			;RESCALE VALUE
	ktrig	changed	kwave				;IF LFO WAVEFORM TYPE IS CHANGED GENERATE A MOMENTARY '1' (BANG)
	if ktrig=1 then					;IF A 'BANG' HAS BEEN GENERATED IN THE ABOVE LINE
		reinit	UPDATE				;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE' SO THAT LFO WAVEFORM TYPE CAN BE UPDATED
	endif						;END OF THIS CONDITIONAL BRANCH
	UPDATE:						;LABEL CALLED UPDATE
	klfo	lfo	kdepth, krate, i(kwave)		;CREATE AN LFO
	rireturn					;RETURN FROM REINITIALIZATION PASS
	klfo	=	(klfo*0.5)+0.5			;RESCALE AND OFFSET LFO SO IT STAY WITHIN THE RANGE 0 - 1 ABOUT THE VALUE 0.5
	if kwave=2 then					;IF SQUARE WAVE MODULATION HAS BEEN CHOSEN...
		klfo	portk	klfo, 0.001		;SMOOTH THE SQUARE WAVE A TINY BIT TO PREVENT CLICKS
	endif						;END OF THIS CONDITIONAL BRANCH	
	if kmode=0 then	;PAN				;IF PANNING MODE IS CHOSEN FROM BUTTON BANK...
		alfo	interp	klfo			;INTERPOLATE K-RATE LFO AND CREATE A-RATE VARIABLE
		aoutL	=	ainL*sqrt(alfo)		;REDEFINE GLOBAL AUDIO LEFT CHANNEL SIGNAL WITH AUTO-PANNING
		aoutR	=	ainR*(1-sqrt(alfo))	;REDEFINE GLOBAL AUDIO RIGHT CHANNEL SIGNAL WITH AUTO-PANNING
	elseif kmode=1 then	;TREM			;IF TREMELO MODE IS CHOSEN FROM BUTTON BANK...
		klfo	=	klfo+(0.5-(gk2$L*0.5))	;MODIFY LFO AT ZERO DEPTH VALUE IS 1 AND AT MAX DEPTH CENTRE OF MODULATION IS 0.5
		alfo	interp	klfo			;INTERPOLATE K-RATE LFO AND CREATE A-RATE VARIABLE
		aoutL	=	ainL*(alfo^2)		;REDEFINE GLOBAL AUDIO LEFT CHANNEL SIGNAL WITH TREMELO
		aoutR	=	ainR*(alfo^2)		;REDEFINE GLOBAL AUDIO RIGHT CHANNEL SIGNAL WITH TREMELO
	endif						;END OF THIS CONDITIONAL BRANCH
		xout	aoutL,aoutR			;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	StChorus,aa,aakkk
	ainL,ainR,krate,kdepth,kwidth	xin					;READ IN INPUT ARGUMENTS
	krate	expcurve	krate,20					;CREATE AN EXPONENTIAL REMAPPING OF krate
	krate	scale	krate,7,0.001						;RESCALE VALUE
	ilfoshape	ftgentmp	0, 0, 131072, 19, 1, 0.5, 0,  0.5	;POSITIVE DOMAIN ONLY SINE WAVE	
	kporttime	linseg	0,0.001,0.02					;RAMPING UP PORTAMENTO VARIABLE
	kChoDepth	portk	kdepth*0.01, kporttime				;SMOOTH VARIABLE CHANGES WITH PORTK
	aChoDepth	interp	kChoDepth					;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE
	amodL 		osciliktp 	krate, ilfoshape, 0			;LEFT CHANNEL LFO
	amodR 		osciliktp 	krate, ilfoshape, kwidth*0.5		;THE PHASE OF THE RIGHT CHANNEL LFO IS ADJUSTABLE
	amodL		=		(amodL*aChoDepth)+.01			;RESCALE AND OFFSET LFO (LEFT CHANNEL)
	amodR		=		(amodR*aChoDepth)+.01			;RESCALE AND OFFSET LFO (RIGHT CHANNEL)
	aChoL		vdelay	ainL, amodL*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (LEFT CHANNEL) 
	aChoR		vdelay	ainR, amodR*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (RIGHT CHANNEL)
	aoutL		sum 	aChoL*0.6, ainL*0.6                 		;MIX DRY AND WET SIGNAL (LEFT CHANNEL) 
	aoutR		sum 	aChoR*0.6, ainR*0.6				;MIX DRY AND WET SIGNAL (RIGHT CHANNEL)
			xout	aoutL,aoutR					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	Flanger,a,akkkk
	ain,krate,kdepth,kdelay,kfback	xin					;READ IN INPUT ARGUMENTS
	krate		expcurve	krate,50				;CREATE AN EXPONENTIAL REMAPPING OF krate
	krate		scale	krate,14,0.001					;RESCALE VALUE	
	kdelay		expcurve	kdelay,200				;CREATE AN EXPONENTIAL REMAPPING OF kdelay
	kdelay		scale		kdelay,0.1,0.0001			;RESCALE VALUE	
	ilfoshape	ftgentmp	0, 0, 131072, 19, 0.5, 1, 180, 1	;U-SHAPE PARABOLA FOR LFO
	kporttime	linseg		0, 0.001, 0.1 				;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERON TO THE REQUIRED VALUE PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED
	kdlt		portk		kdelay, kporttime 			;PORTAMENTO IS APPLIED TO A VARIABLE. A NEW VARIABLE 'kdlt' IS CREATED.
	adlt		interp		kdlt					;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt'
	kdep		portk		kdepth*0.01, kporttime 			;PORTAMENTO IS APPLIED TO A VARIABLE. A NEW VARIABLE 'kdep' IS CREATED.
	amod		oscili		kdep, krate, ilfoshape			;OSCILLATOR THAT MAKES USE OF THE POSITIVE DOMAIN ONLY U-SHAPE PARABOLA WITH FUNCTION TABLE NUMBER ilfoshape
	adlt		sum		adlt, amod				;STATIC DELAY TIME AND MODULATING DELAY TIME ARE SUMMED
	adelsig		flanger 	ain, adlt, kfback , 1.2			;FLANGER SIGNAL CREATED
	aout		sum		ain*0.5, adelsig*0.5			;CREATE DRY/WET MIX 
			xout		aout					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	AnalogDelay,a,akkkk
	ain,kmix,ktime,kfback,ktone	xin			;READ IN INPUT ARGUMENTS
	ktone	expcurve	ktone,4				;CREATE AN EXPONENTIAL REMAPPING OF ktone
	ktone	scale	ktone,12000,100				;RESCALE 0 - 1 VALUE
	iWet	ftgentmp	0,0,1024,-7,0,512,1,512,1	;RESCALING FUNCTION FOR WET LEVEL CONTROL
	iDry	ftgentmp	0,0,1024,-7,1,512,1,512,0	;RESCALING FUNCTION FOR DRY LEVEL CONTROL
	kWet	table	kmix, iWet, 1				;RESCALE WET LEVEL CONTROL ACCORDING TO FUNCTION TABLE iWet
	kDry	table	kmix, iDry, 1                 		;RESCALE DRY LEVEL CONTROL ACCORDING TO FUNCTION TABLE iWet
	kporttime	linseg	0,0.001,0.1			;RAMPING UP PORTAMENTO TIME
	kTime	portk	ktime, kporttime*3			;APPLY PORTAMENTO SMOOTHING TO DELAY TIME PARAMETER
	kTone	portk	ktone, kporttime			;APPLY PORTAMENTO SMOOTHING TO TONE PARAMETER
	aTime	interp	kTime					;INTERPOLATE AND CREAT A-RATE VERSION OF DELAY TIME PARAMETER
	aBuffer	delayr	5					;READ FROM (AND INITIALIZE) BUFFER
	atap	deltap3	aTime					;TAP DELAY BUFFER
	atap	clip	atap, 0, 0dbfs				;SIGNAL IS CLIPPED AT MAXIMUM AMPLITUDE USING BRAM DE JONG METHOD
	atap	tone	atap, kTone				;LOW-PASS FILTER DELAY TAP WITHIN DELAY BUFFER 
		delayw	ain+(atap*kfback)			;WRITE INPUT AUDIO AND FEEDBACK SIGNAL INTO DELAY BUFFER
	aout	sum	ain*kDry, atap*kWet			;MIX DRY AND WET SIGNALS 
		xout	aout					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop
;--------------------------------------------------------------------------------------------------------------------------

instr	1	;TRIGGERED BY EFFECT ON/OFF SWITCHES - AMENDS ON/OFF STATUS TABLE ACCORDINGLY AND STARTS THE DESIRED EFFECT
	iStatus	table	p4, giOnOffStatus		;CURRENT STATUS
	iStatus	=	abs(iStatus - 1)		;NEW STATUS - SWAPS BETWEEN ZERO AND 1
		tablew	iStatus, p4, giOnOffStatus	;WRITE NEW STATUS
	if iStatus=1 then				;IF EFFECT IS NOW ON...
		event_i	"i", p4 + 10, 0, -1		;TURN ON THE RELELVANT EFFECT. EFFECT NUMBER DERIVED FROM p4 OF FLTK BUTTON
	endif						;END OF THIS CONDITIONAL  BRANCH
endin

instr	2	;INPUT (ALWAYS ON)
	gaSigL, gaSigR	ins		;READ STEREO INPUT INTO GLOBAL AUDIO VARIABLES
endin









;THE EFFECTS...




instr	10
#define	L	#VOLUME#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED			;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus		;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then				;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED		;SWITCH OFF THE LED
		turnoff					;TURN THIS INSTRUMENT OFF
	endif						;END OF THIS CONDITIONAL BRANCH
	gaSigL	= gaSigL*gk1$L				;SCALE LEFT CHANNEL AMPLITUDE USING VOLUME CONTROL KNOB
	gaSigR	= gaSigR*gk1$L				;SCALE RIGHT CHANNEL AMPLITUDE USING VOLUME CONTROL KNOB
endin


instr	11
#define	L	#FILEPLAY#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED			;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus		;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then				;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED		;SWITCH OFF THE LED
		turnoff					;TURN THIS INSTRUMENT OFF
	endif						;END OF THIS CONDITIONAL BRANCH
	aFileL, aFileR	diskin2	"ClassicalGuitar.wav",1,0,1	;READ A FILE FROM DISK
	gaSigL	sum	aFileL*gk1$L, gaSigL*gk2$L	;MIX FILE PLAYER AUDIO WITH LIVE AUDIO ACCORDING TO THE SETTING OF KNOB 1 & 2 (LEFT CHANNEL)
	gaSigR	sum	aFileR*gk1$L, gaSigR*gk2$L	;MIX FILE PLAYER AUDIO WITH LIVE AUDIO ACCORDING TO THE SETTING OF KNOB 1 & 2 (LEFT CHANNEL)
endin

	
instr	12
#define	L	#COMPRESSOR#						;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED                     		;THIS TURNS ON THE LED FOR THE EFFECT                    
	kStatus	table	p1-10, giOnOffStatus            		;READ EFFECT ON/OFF STATUS FROM TABLE                    
	if kStatus=0 then                               		;IF THIS EFFECT HAS BEEN TURNED OFF                      
		FLsetVal	1, 0, gih$L.LED          		;SWITCH OFF THE LED                                      
		turnoff                                 		;TURN THIS INSTRUMENT OFF                                
	endif                                           		;END OF THIS CONDITIONAL BRANCH                          
	ktrigger	changed	gk2$L, gk3$L				;RATIO AND ATTACK TIME ARE I-RATE SO RE-INITIALIZATION IS REQUIRED IN ORDER FOR THEM TO TAKE EFFECT
	if ktrigger=1 then						;IF A REINITIALIZATIO  TRIGGER HAS BEEN RECEIVED...
		reinit	UPDATE						;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif								;END OF THIS CONDITIONAL BRANCH
	UPDATE:								;LABEL
	aCompL	dam 	gaSigL, gk1$L, 1/i(gk2$L), 1, i(gk3$L), 0.1	;COMPRESSOR (LEFT CHANNEL)
	aCompR	dam 	gaSigR, gk1$L, 1/i(gk2$L), 1, i(gk3$L), 0.1	;COMPRESSOR (RIGHT CHANNEL)
	rireturn							;RETURN FROM INTIALIZATION PASS
	gaSigL	=	aCompL*gk4$L					;REDEFINE GLOBAL AUDIO SIGNAL WITH COMPRESSOR OUTPUT AUDIO (LEFT CHANNEL)
	gaSigR	=	aCompR*gk4$L	                                ;REDEFINE GLOBAL AUDIO SIGNAL WITH COMPRESSOR OUTPUT AUDIO (RIGHT CHANNEL)
endin


instr	13
#define	L	#ENVFOLLOWER#					;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED				;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus			;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then					;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED			;SWITCH OFF THE LED
		turnoff						;TURN THIS INSTRUMENT OFF
	endif							;END OF THIS CONDITIONAL BRANCH
	gaSigL	EnvelopeFollower	gaSigL,gk1$L,gk2$L,gk3$L
	gaSigR	EnvelopeFollower	gaSigR,gk1$L,gk2$L,gk3$L
endin



instr	14
#define	L	#DISTORTION#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED                     ;THIS TURNS ON THE LED FOR THE EFFECT                    
	kStatus	table	p1-10, giOnOffStatus            ;READ EFFECT ON/OFF STATUS FROM TABLE                    
	if kStatus=0 then                               ;IF THIS EFFECT HAS BEEN TURNED OFF                      
		FLsetVal	1, 0, gih$L.LED          ;SWITCH OFF THE LED                                      
		turnoff                                 ;TURN THIS INSTRUMENT OFF                                
	endif                                           ;END OF THIS CONDITIONAL BRANCH                          
	gaSigL	Distortion	gaSigL,gk1$L,gk2$L,gk3$L
	gaSigR	Distortion	gaSigR,gk1$L,gk2$L,gk3$L
endin


instr	15
#define	L	#REVERSE#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED		;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus	;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then			;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED	;SWITCH OFF THE LED
		turnoff				;TURN THIS INSTRUMENT OFF
	endif					;END OF THIS CONDITIONAL BRANCH
	gaSigL	Reverse	gaSigL,gk1$L
	gaSigR	Reverse	gaSigR,gk1$L
endin


instr	16
#define	L	#PITCH_SHIFTER#					;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED				;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus			;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then					;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED			;SWITCH OFF THE LED
		turnoff						;TURN THIS INSTRUMENT OFF
	endif							;END OF THIS CONDITIONAL BRANCH
	gaSigL	PitchShifter	gaSigL,gk1$L,gk2$L,gk3$L,gk4$L
	gaSigR	PitchShifter	gaSigR,gk1$L,gk2$L,gk3$L,gk4$L
endin


instr	17
#define	L	#FREQSHIFTER#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED		;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus	;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then			;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED	;SWITCH OFF THE LED
		turnoff				;TURN THIS INSTRUMENT OFF
	endif					;END OF THIS CONDITIONAL BRANCH
	gaSigL	FreqShifter	gaSigL,gk1$L,gk2$L,gk3$L,gk4$L
	gaSigR	FreqShifter	gaSigR,gk1$L,gk2$L,gk3$L,gk4$L
endin


instr	18
#define	L	#RINGMODULATOR#						;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED					;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus				;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then						;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED				;SWITCH OFF THE LED
		turnoff							;TURN THIS INSTRUMENT OFF
	endif								;END OF THIS CONDITIONAL BRANCH
	gaSigL	RingModulator	gaSigL,gk1$L,gk2$L,gk3$L
	gaSigR	RingModulator	gaSigR,gk1$L,gk2$L,gk3$L
endin


instr	19
#define	L	#PHASER#							;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED						;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus					;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then							;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED					;SWITCH OFF THE LED
		turnoff								;TURN THIS INSTRUMENT OFF
	endif									;END OF THIS CONDITIONAL BRANCH
	gaSigL	Phaser	gaSigL,gk1$L,gk2$L,gk3$L,gk4$L
	gaSigR	Phaser	gaSigR,gk1$L,gk2$L,gk3$L,gk4$L
endin


instr	20
#define	L	#LoFi#										;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED								;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus							;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then									;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED							;SWITCH OFF THE LED
		turnoff										;TURN THIS INSTRUMENT OFF
	endif											;END OF THIS CONDITIONAL BRANCH
	gaSigL	LoFi	gaSigL,gk1$L,gk2$L
	gaSigR	LoFi	gaSigR,gk1$L,gk2$L
endin


instr	21
#define	L	#FILTER#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED			;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus		;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then				;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED		;SWITCH OFF THE LED
		turnoff					;TURN THIS INSTRUMENT OFF
	endif						;END OF THIS CONDITIONAL BRANCH
	kporttime	linseg	0,0.001,0.02		;RAMPING UP PORTAMENTO TIME VARIABLE
	kHPF	portk	gk1$L, kporttime		;APPLY PORTAMENTO TO HIGH-PASS FILTER CUTOFF VARIABLE
	kLPF	portk	gk2$L, kporttime		;APPLY PORTAMENTO TO HIGH-PASS FILTER CUTOFF VARIABLE
	aFiltL	buthp	gaSigL, kHPF			;HIGH-PASS FILTER GLOBAL AUDIO SIGNAL (LEFT CHANNEL)
	aFiltR	buthp	gaSigR, kHPF			;HIGH-PASS FILTER GLOBAL AUDIO SIGNAL (RIGHT CHANNEL)
	aFiltL	buthp	aFiltL, kHPF			;HIGH-PASS FILTER AUDIO SIGNAL FROM PREVIOUS FILTER (LEFT CHANNEL) 
	aFiltR	buthp	aFiltR, kHPF			;HIGH-PASS FILTER AUDIO SIGNAL FROM PREVIOUS FILTER (RIGHT CHANNEL)
	aFiltL	butlp	aFiltL, kLPF			;LOW-PASS FILTER GLOBAL AUDIO SIGNAL (LEFT CHANNEL)       
	aFiltR	butlp	aFiltR, kLPF			;LOW-PASS FILTER GLOBAL AUDIO SIGNAL (RIGHT CHANNEL)      
	aFiltL	butlp	aFiltL, kLPF			;LOW-PASS FILTER AUDIO SIGNAL FROM PREVIOUS FILTER (LEFT CHANNEL) 
	aFiltR	butlp	aFiltR, kLPF			;LOW-PASS FILTER AUDIO SIGNAL FROM PREVIOUS FILTER (RIGHT CHANNEL)
	gaSigL	=	aFiltL*gk3$L			;REDEFINE GLOBAL AUDIO LEFT CHANNEL SIGNAL WITH OUTPUT FROM LAST FILTER. RESCALE WITH GAIN CONTROL (LEFT CHANNEL)  
	gaSigR	=	aFiltR*gk3$L			;REDEFINE GLOBAL AUDIO RIGHT CHANNEL SIGNAL WITH OUTPUT FROM LAST FILTER. RESCALE WITH GAIN CONTROL (RIGHT CHANNEL)
endin


instr	22
#define	L	#PANTREM#			;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED		;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus	;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then			;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED	;SWITCH OFF THE LED
		turnoff				;TURN THIS INSTRUMENT OFF
	endif					;END OF THIS CONDITIONAL BRANCH
	gaSigL,gaSigR	PanTrem		gaSigL,gaSigR,gk1$L,gk2$L,gk3$L,gk4$L
endin


instr	23
#define	L	#CHORUS#							;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED						;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus					;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then							;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED					;SWITCH OFF THE LED
		turnoff								;TURN THIS INSTRUMENT OFF
	endif									;END OF THIS CONDITIONAL BRANCH
	gaSigL,gaSigR	StChorus	gaSigL,gaSigR,gk1$L,gk2$L,gk3$L
endin


instr	24
#define	L	#FLANGER#							;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED                     			;THIS TURNS ON THE LED FOR THE EFFECT                    
	kStatus	table	p1-10, giOnOffStatus            			;READ EFFECT ON/OFF STATUS FROM TABLE                    
	if kStatus=0 then                               			;IF THIS EFFECT HAS BEEN TURNED OFF                      
		FLsetVal	1, 0, gih$L.LED          			;SWITCH OFF THE LED                                      
		turnoff                                 			;TURN THIS INSTRUMENT OFF                                
	endif                                           			;END OF THIS CONDITIONAL BRANCH                          
	gaSigL	Flanger	gaSigL,gk1$L,gk2$L,gk3$L,gk4$L
	gaSigR	Flanger	gaSigR,gk1$L,gk2$L,gk3$L,gk4$L
endin


instr	25						
#define	L	#DELAY#                                 ;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED                     ;THIS TURNS ON THE LED FOR THE EFFECT                    
	kStatus	table	p1-10, giOnOffStatus            ;READ EFFECT ON/OFF STATUS FROM TABLE                    
	if kStatus=0 then                               ;IF THIS EFFECT HAS BEEN TURNED OFF                      
		FLsetVal	1, 0, gih$L.LED          ;SWITCH OFF THE LED                                      
		turnoff                                 ;TURN THIS INSTRUMENT OFF                                
	endif                                           ;END OF THIS CONDITIONAL BRANCH                          
	gaSigL	AnalogDelay	gaSigL,gk1$L,gk2$L,gk3$L,gk4$L
	gaSigR	AnalogDelay	gaSigR,gk1$L,gk2$L,gk3$L,gk4$L
endin


instr	26
#define	L	#REVERB#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED                     ;THIS TURNS ON THE LED FOR THE EFFECT                    
	kStatus	table	p1-10, giOnOffStatus            ;READ EFFECT ON/OFF STATUS FROM TABLE                    
	if kStatus=0 then                               ;IF THIS EFFECT HAS BEEN TURNED OFF                      
		FLsetVal	1, 0, gih$L.LED          ;SWITCH OFF THE LED                                      
		turnoff                                 ;TURN THIS INSTRUMENT OFF                                
	endif                                           ;END OF THIS CONDITIONAL BRANCH                          
	kWet	table	gk1$L, giWet, 1			;RESCALE WET LEVEL CONTROL ACCORDING TO FUNCTION TABLE giWet
	kDry	table	gk1$L, giDry, 1                 ;RESCALE DRY LEVEL CONTROL ACCORDING TO FUNCTION TABLE giWet
	aRvbL, aRvbR	reverbsc	gaSigL, gaSigR, gk2$L, gk3$L	;CREATE STEREO REVERB SIGNAL
	gaSigL	sum	gaSigL*kDry, aRvbL*kWet  	;REDEFINE GLOBAL AUDIO SIGNAL FROM MIX OF DRY AND WET SIGNALS (LEFT CHANNEL) 
	gaSigR	sum	gaSigR*kDry, aRvbR*kWet       	;REDEFINE GLOBAL AUDIO SIGNAL FROM MIX OF DRY AND WET SIGNALS (RIGHT CHANNEL)
endin


instr	27
#define	L	#EQUALIZER#					;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED				;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus			;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then					;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED			;SWITCH OFF THE LED
		turnoff						;TURN THIS INSTRUMENT OFF
	endif							;END OF THIS CONDITIONAL BRANCH
	iQ	init	1					;Q OF THE FILTERS
	iEQcurve	ftgen	0,0,4096,-16,1/64,4096,7.9,64	;AMPLITUDE GAIN CURVE
	iGainCurve	ftgen	0,0,4096,-16,0.5,4096,3,4	;GLOBAL GAIN CURVE
	k1	table	1-gk1$L, iEQcurve, 1			;RESCALE INPUT 1 USING THE CURVE DEFINED ABOVE
	k2	table	1-gk2$L, iEQcurve, 1			;RESCALE INPUT 2 USING THE CURVE DEFINED ABOVE
	k3	table	1-gk3$L, iEQcurve, 1			;RESCALE INPUT 3 USING THE CURVE DEFINED ABOVE
	k4	table	1-gk4$L, iEQcurve, 1			;RESCALE INPUT 4 USING THE CURVE DEFINED ABOVE
	k5	table	1-gk5$L, iEQcurve, 1			;RESCALE INPUT 5 USING THE CURVE DEFINED ABOVE
	k6	table	1-gk6$L, iEQcurve, 1			;RESCALE INPUT 6 USING THE CURVE DEFINED ABOVE
	k7	table	1-gk7$L, iEQcurve, 1			;RESCALE INPUT 7 USING THE CURVE DEFINED ABOVE
	k8	table	1-gk8$L, iGainCurve, 1			;RESCALE INPUT 7 USING THE CURVE DEFINED ABOVE
	aInL	=	gaSigL*0.15*k8				;INPUT SIGNAL (LEFT CHANNEL)
	aInR	=	gaSigR*0.15*k8				;INPUT SIGNAL (RIGHT CHANNEL)	
	a1L	pareq 	aInL,  100,  k1, iQ , 1			;LOW SHELVING FILTER (LEFT CHANNEL)
	a2L	pareq 	aInL,  200,  k2, iQ , 0			;PEAKING FILTER (LEFT CHANNEL)
	a3L	pareq 	aInL,  400,  k3, iQ , 0			;PEAKING FILTER (LEFT CHANNEL) 
	a4L	pareq 	aInL,  800,  k4, iQ , 0			;PEAKING FILTER (LEFT CHANNEL) 
	a5L	pareq 	aInL, 1600,  k5, iQ , 0			;PEAKING FILTER (LEFT CHANNEL) 
	a6L	pareq 	aInL, 3200,  k6, iQ , 0			;PEAKING FILTER (LEFT CHANNEL) 
	a7L	pareq 	aInL, 6400,  k7, iQ , 2			;HIGH SHELVING FILTER (LEFT CHANNEL) 
	a1R	pareq 	aInR,  100,  k1, iQ , 1			;LOW SHELVING FILTER (RIGHT CHANNEL) 
	a2R	pareq 	aInR,  200,  k2, iQ , 0			;PEAKING FILTER (RIGHT CHANNEL)
	a3R	pareq 	aInR,  400,  k3, iQ , 0			;PEAKING FILTER (RIGHT CHANNEL) 
	a4R	pareq 	aInR,  800,  k4, iQ , 0			;PEAKING FILTER (RIGHT CHANNEL) 
	a5R	pareq 	aInR, 1600,  k5, iQ , 0			;PEAKING FILTER (RIGHT CHANNEL) 
	a6R	pareq 	aInR, 3200,  k6, iQ , 0			;PEAKING FILTER (RIGHT CHANNEL) 
	a7R	pareq 	aInR, 6400,  k7, iQ , 2			;HIGH SHELVING FILTER (RIGHT CHANNEL) 
	gaSigL	sum	a1L, a2L, a3L, a4L, a5L, a6L, a7L 	;SUM THE FILTER OUTPUTS (LEFT CHANNEL)
	gaSigR	sum	a1R, a2R, a3R, a4R, a5R, a6R, a7R       ;SUM THE FILTER OUTPUTS (RIGHT CHANNEL)
endin



instr	28	;A BLANK EFFECT
#define	L	#BLANK#				;THIS NAME SHOULD CORRESPOND TO THE NAME USED FOR THE GUI
	FLsetVal_i	1, gih$L.LED		;THIS TURNS ON THE LED FOR THE EFFECT
	kStatus	table	p1-10, giOnOffStatus	;READ EFFECT ON/OFF STATUS FROM TABLE
	if kStatus=0 then			;IF THIS EFFECT HAS BEEN TURNED OFF
		FLsetVal	1, 0, gih$L.LED	;SWITCH OFF THE LED
		turnoff				;TURN THIS INSTRUMENT OFF
	endif					;END OF THIS CONDITIONAL BRANCH
	aInL	=	gaSigL			;LEFT CHANNEL INPUT SIGNAL TAKEN FROM GLOBAL VARIABLE
	aInR	=	gaSigR			;RIGHT CHANNEL INPUT SIGNAL TAKEN FROM GLOBAL VARIABLE

	;SOME SIGNAL PROCESSING CODE HERE...

	;gaSigL	= aFXL				;ASSIGN THE LEFT CHANNEL GLOBAL AUDIO VARIABLE TO THE EFFECT OUTPUT - MIXING OPTIONS WILL DEPEND ON THE EFFECT
	;gaSigR	= aFXR				;ASSIGN THE LEFT CHANNEL GLOBAL AUDIO VARIABLE TO THE EFFECT OUTPUT - MIXING OPTIONS WILL DEPEND ON THE EFFECT
endin


;ADDITIONAL EFFECTS...


instr	29
endin

instr	30
endin

;etc...








instr	99	;OUTPUT (ALWAYS ON)
	outs	gaSigL, gaSigR	;SEND AUDIO FROM THE FINAL ACTIVE EFFECT TO THE OUTPUTS
endin

</CsInstruments>

<CsScore>
i "tables" 0 3600
i 2  0 3600	;INPUT
i 99 0 3600	;OUTPUT
</CsScore>

</CsoundSynthesizer>
