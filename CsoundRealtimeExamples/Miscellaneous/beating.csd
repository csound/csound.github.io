;WRITTEN BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400 -d -m0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	10
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
		FLpanel	"Beating", 500, 490, 0, 0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    150,     28,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X |  Y
idcps			FLvalue	" ",     	60,       20,    5,  75
iddtn			FLvalue	" ",     	60,       20,    5,  125

;SLIDERS							MIN   |   MAX | EXP | TYPE |    DISP   | WIDTH | HEIGHT | X | Y
gkcps, ihcps		FLslider 	"Base Frequency (hertz)",50,      5000,   -1,   23,    idcps,     490,     25,    5, 50
gkgain, ihgain		FLslider 	"Global Gain",		0,          1,    0,   23,    -1,        490,     25,    5,150

;KOUT, IHANDLE 		FLROLLER 	"LABEL", 		MIN | MAX | STEP | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkdtn, ihdtn 		FLroller 	"Detune (hertz)", 	-100, 100,  0.01,   0,     1,   iddtn,  490,     25,    5, 100 

;SET INITIAL VALUES FOR VALUATORS
FLsetVal_i	440, 	ihcps
FLsetVal_i	0, 	ihdtn
FLsetVal_i	0.5, 	ihgain

;PARTIAL STRENGTH SLIDERS

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    490,    95,    5, 195	;BORDER AROUND PARTIAL STRENGTH SLIDERS

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Partial Strengths", 	1,       5,    14,    90,      20,  10, 225

;VALUES USED FOR PARTIAL STRENGTH SLIDERS
iheight	=	60
iwidth	=	20
ix	=	100
iy	=	205
itype	=	24
;MACRO USED FOR PARTIAL STRENGTH SLIDER TO REDUCE CODE REPETITION. ARGUMENT IS A COUNTER.
#define	SLIDER(N)
#
;SLIDERS					MIN  |   MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp$N, ihamp$N	FLslider 	"$N",	0,        1,    0,   itype, -1,   iwidth, iheight, ix, iy
ix = ix + iwidth
#
;EXECUTE MACRO MULTIPLE TIMES
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

;SET INITIAL VALUES FOR VALUATORS
FLsetVal_i	0, ihamp1
FLsetVal_i	1, ihamp2
FLsetVal_i	1, ihamp3
FLsetVal_i	1, ihamp4
FLsetVal_i	1, ihamp5
FLsetVal_i	1, ihamp6
FLsetVal_i	1, ihamp7
FLsetVal_i	1, ihamp8
FLsetVal_i	1, ihamp9
FLsetVal_i	1, ihamp10
FLsetVal_i	1, ihamp11
FLsetVal_i	1, ihamp12
FLsetVal_i	1, ihamp13
FLsetVal_i	1, ihamp14
FLsetVal_i	1, ihamp15
FLsetVal_i	1, ihamp16

;SLIDERS								MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X | Y
gkTone1Amp, ihTone1Amp		FLslider 	"Tone 1 Amplitude",	0,     1,    0,    23,    -1,     490,     25,    5, 300
gkTone2Amp, ihTone2Amp		FLslider 	"Tone 2 Amplitude",	0,     1,    0,    23,    -1,     490,     25,    5, 350
FLsetVal_i	1, ihTone1Amp
FLsetVal_i	1, ihTone2Amp

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    240,    90,     5, 400	;BORDER

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinterval, ihinterval	FLbutBank	14,     1,     4,     18,      80,   90, 405,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Interval:", 		1,       5,    14,     80,      20,  10, 405
ih		 	FLbox  	"Unison (1/1)", 	1,       5,    14,    100,      20, 110, 405
ih		 	FLbox  	"Octave (2/1)", 	1,       5,    14,    100,      20, 110, 425
ih		 	FLbox  	"Fifth (3/2) ", 	1,       5,    14,    100,      20, 110, 445
ih		 	FLbox  	"Fourth (4/3)", 	1,       5,    14,    100,      20, 110, 465

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    240,    50,   255, 400	;BORDER

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkmode, ihmode	FLbutBank	14,     1,     2,     18,      40,   310,405,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Mode:", 		1,       5,    14,     50,      20,  260, 405
ih		 	FLbox  	"Mixed Mono", 		1,       5,    14,    100,      20,  330, 405
ih		 	FLbox  	"Binaural  ", 		1,       5,    14,    100,      20,  330, 425

FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 600, 512, 0
				FLscroll     515, 600,  0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            Beating                          ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'Beating' is the name given to the effect of amplitude       ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"modulation that occurs when two similar tones are sounded    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"together and detuned with respect to one other. Typically the", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"frequencies of the two tones need to be within about 20 hertz", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"of each other in order for the effect of amplitude modulation", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"to be perceived.                                             ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"The effect will be most clearly heard when the two tones are ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"sine waves.                                                  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The 'Base Frequency' slider controls the frequency of both   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"the tones. The 'Detune' roller controls the amount by which  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"the second tone will be detuned with respect to the first.   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"As detuning frequency is increased to around 15 hertz we     ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"begin to lose track of the amplitude modulation effect and   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"begin to perceive a tone with 'roughness'. As the detuning   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"is increased further the two tones un-fuse and we perceive   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"two distinct pitches.                                        ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"This example defaults to employing a sine wave for both of   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"the tone but the user can add partials to explore            ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"relationships between beating frequency and partial number.  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Beating frequency for the second partial will be twice that  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"for the first partial (fundemental), beat frequency for the  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"third partial will be three times that for the first partial ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"and so on.                                                   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"As more partials are added the clear sense of amplitude      ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"modulation is lost and instead a periodic swirling is        ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"perceived at the fundemental beat frequency.                 ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"The phenomenon of beating is often used by string players and", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"guitarists to tune their instruments.                        ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"Additionally, this example allows the user to offset the     ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"second tone by a number of just intoned intervals (octave,   ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"fifth or a fourth). It can be observed how beating occurs    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"between different partials when the two tones are not in     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"unison. When the interval is an octave, beating most clearly ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"occurs between partials 1 and 2, when the interval is a fifth", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"between partials 2 and 3 and when the interval is a fourth   ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"between partials 3 and 4.                                    ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"When 'binaural' mode is selected the two tones are sent      ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"separately to the left and right channels. If headphones are ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"used the beating effect effect no longer occurs acoustically ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"but instead within the brain. This effect is called 'binaural", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"beating' and is sometimes used as a therapy for insomnia and ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"to aid relaxation and concentration. This technique is called", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"'brainwave entrainment' or 'brainwave synchronization'. More ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"information on this subject can easily be researched.        ", 	1,      5,     14,    490,    20,     5, 860
FLscroll_end                                
FLpanel_end

FLrun	;RUN THE FLTK WIDGET THREAD

;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 131072, 10, 1	;SINE WAVE
giintervals	ftgen	0, 0, 4, -2, 1, 2, 3/2, 4/3	;TABLE OF JUST INTONATION INTERVALS

instr	1
	if	gkOnOff=0	then	;IF ON/OFF BUTTON IS OFF...
		turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif				;END OF CONDITIONAL BRANCHING
	
	iporttime	=	0.05				;PORTAMENTO TIME
	kporttime	linseg	0,0.001,iporttime,1,iporttime	;RAMPING UP FUNCTION FOR PORTAMENTO TIME
	kamp1 	portk	gkamp1, kporttime			;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp2 	portk	gkamp2, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp3 	portk	gkamp3, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp4 	portk	gkamp4, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp5 	portk	gkamp5, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp6 	portk	gkamp6, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp7 	portk	gkamp7, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp8 	portk	gkamp8, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp9 	portk	gkamp9, kporttime                       ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp10	portk	gkamp10, kporttime                      ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp11	portk	gkamp11, kporttime                      ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp12	portk	gkamp12, kporttime                      ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp13	portk	gkamp13, kporttime                      ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp14	portk	gkamp14, kporttime                      ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp15	portk	gkamp15, kporttime                      ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kamp16	portk	gkamp16, kporttime                      ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kcps	portk	gkcps, kporttime                        ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kTone1Amp	portk	gkTone1Amp, kporttime           ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kTone2Amp	portk	gkTone2Amp, kporttime           ;APPLY PORTAMENTO TO SLIDER VARIABLE
	kgain	portk	gkgain, kporttime			;APPLY PORTAMENTO TO SLIDER VARIABLE
	
	kcps1	=	kcps					;PITCH (IN CYCLES PER SECOND) OF FIRST TONE
	kinterval	table	gkinterval, giintervals		;INTERVAL BY WHICH SECOND TONE WILL BE TRANSPOSED
	kcps2	=	(kcps*kinterval)+gkdtn			;PITCH (IN CYCLES PER SECOND) PF SECOND TONE
	
	a1_1 	poscil3	1-kamp1 , kcps1,    gisine		;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_2 	poscil3	1-kamp2 , kcps1*2,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_3 	poscil3	1-kamp3 , kcps1*3,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_4 	poscil3	1-kamp4 , kcps1*4,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_5 	poscil3	1-kamp5 , kcps1*5,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_6 	poscil3	1-kamp6 , kcps1*6,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_7 	poscil3	1-kamp7 , kcps1*7,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_8 	poscil3	1-kamp8 , kcps1*8,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_9 	poscil3	1-kamp9 , kcps1*9,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_10	poscil3	1-kamp10, kcps1*10, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_11	poscil3	1-kamp11, kcps1*11, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_12	poscil3	1-kamp12, kcps1*12, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_13	poscil3	1-kamp13, kcps1*13, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_14	poscil3	1-kamp14, kcps1*14, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_15	poscil3	1-kamp15, kcps1*15, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1_16	poscil3	1-kamp16, kcps1*16, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF FIRST ADDITIVE SYNTHESIS TONE
	a1	sum	a1_1,a1_2,a1_3,a1_4,a1_5,a1_6,a1_7,a1_8,a1_9,a1_10,a1_11,a1_12,a1_13,a1_14,a1_15,a1_16	;SUM (MIX) ALL PARTIALS OF FIRST TONE
	
	a2_1 	poscil3	1-kamp1 , kcps2,    gisine		;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_2 	poscil3	1-kamp2 , kcps2*2,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_3 	poscil3	1-kamp3 , kcps2*3,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_4 	poscil3	1-kamp4 , kcps2*4,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_5 	poscil3	1-kamp5 , kcps2*5,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_6 	poscil3	1-kamp6 , kcps2*6,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_7 	poscil3	1-kamp7 , kcps2*7,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_8 	poscil3	1-kamp8 , kcps2*8,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_9 	poscil3	1-kamp9 , kcps2*9,  gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_10	poscil3	1-kamp10, kcps2*10, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_11	poscil3	1-kamp11, kcps2*11, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_12	poscil3	1-kamp12, kcps2*12, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_13	poscil3	1-kamp13, kcps2*13, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_14	poscil3	1-kamp14, kcps2*14, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_15	poscil3	1-kamp15, kcps2*15, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2_16	poscil3	1-kamp16, kcps2*16, gisine              ;CREATE OSCILLATOR FOR PARTIAL OF SECOND ADDITIVE SYNTHESIS TONE
	a2	sum	a2_1,a2_2,a2_3,a2_4,a2_5,a2_6,a2_7,a2_8,a2_9,a2_10,a2_11,a2_12,a2_13,a2_14,a2_15,a2_16	;SUM (MIX) ALL PARTIALS OF SECOND TONE
	
	if	gkmode==0	then				;IF MONO MIX MODE IS SELECTED...
		amix	sum	a1*kTone1Amp,a2*kTone2Amp	;MIX THE TWO TONES
		amix	=	(amix*kgain) / 16		;RESCALE AMPLTUDE WITH 'Gain' SLIDER AND ALSO SCALE AMPLITUDE DOWN TO COMPENSATE FOR THE SUMMATION OF THE 16 PARTIALS
		outs	amix, amix				;SEND MIX OF TWO TONES TO EACH SPEAKER
	else							;ELSE (BINAURAL MODE IS SELECTED)...
		a1	=	(a1*kTone1Amp*kgain)/16		;RESCALE AMPLTUDE OF TONE 1 WITH 'TONE 1 AMPLITUDE' SLIDER AND ALSO SCALE AMPLITUDE DOWN TO COMPENSATE FOR THE SUMMATION OF THE 16 PARTIALS
		a2	=	(a2*kTone2Amp*kgain)/16		;RESCALE AMPLTUDE OF TONE 2 WITH 'TONE 2 AMPLITUDE' SLIDER AND ALSO SCALE AMPLITUDE DOWN TO COMPENSATE FOR THE SUMMATION OF THE 16 PARTIALS
		outs	a1, a2					;SEND TONE 1 AND TONE 2 SEPARATELY TO THE LEFT AND RIGHT SPEAKERS
	endif							;END OF CONDITIONAL BRANCHING
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - 	ALLOWS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>