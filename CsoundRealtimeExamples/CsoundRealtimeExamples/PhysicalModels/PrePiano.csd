; PrePiano.csd
; Example written by Iain McCurdy

; Updated 2015

<CsoundSynthesizer>

<CsOptions>
-odac --midi-key-cps=4 -dm0 -M0 -+rtmidi=virtual
; -M8
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;FULLL SCALE AMPLITUDE

massign		0,1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		FLcolor		255, 255, 240, 0, 0, 0

;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"prepiano",   1000,    710,    5,  5

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	8,      9,     15,    490,   120,   505, 25	;RATTLE 1
ih		 	FLbox  	" ", 	8,      9,     15,    490,   120,   505, 170	;RUBBER 1
ih		 	FLbox  	" ", 	8,      9,     15,    240,   120,   505, 315	;BOUNDARY CONDITION L
ih		 	FLbox  	" ", 	8,      9,     15,    240,   120,   755, 315	;BOUNDARY CONDITION R
;BORDERS				                                                                                                                                             	TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihtitle		 	FLbox  	"Physical model of a Cageian prepared piano. Algorithm written by Stefan Bilbao. Opcode ported for Csound by John ffitch. Example written by Iain McCurdy.", 	8,      2,     24,    490,    200,   505, 500	;TITLE

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Rattle 1",		1,      4,     14,     70,     10,   510, 35
ih		 	FLbox  	"Rubber 1",		1,      4,     14,     70,     10,   510, 180
ih		 	FLbox  	"Boundary Condition L",	1,      4,     14,    150,     10,   510, 325
ih		 	FLbox  	"Boundary Condition R",	1,      4,     14,    150,     10,   760, 325
ih		 	FLbox  	"Clamped ",		1,      2,    11,     50,     10,   560, 358
ih		 	FLbox  	"Pivoting",		1,      2,    11,     50,     10,   560, 383
ih		 	FLbox  	"Free    ",		1,      2,    11,     50,     10,   560, 408
ih		 	FLbox  	"Clamped ",		1,      2,    11,     50,     10,   810, 358
ih		 	FLbox  	"Pivoting",		1,      2,    11,     50,     10,   810, 383
ih		 	FLbox  	"Free    ",		1,      2,    11,     50,     10,   810, 408


;BUTTONS						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Note On/Off(MIDI)",	1,    0,    22,    140,     30,    25, 10,    -1
gkrattle1,ihrattle1	FLbutton	"On/Off",	1,    0,     4,     60,     30,   525, 60,    -1
gkrubber1,ihrubber1	FLbutton	"On/Off",	1,    0,     4,     60,     30,   525, 205,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idfreqS		FLvalue	" ",      50,     20,    25,   50
idD		FLvalue	" ",      50,     20,    25,  100
idK		FLvalue	" ",      50,     20,    25,  150
idT30		FLvalue	" ",      50,     20,    25,  200
idB		FLvalue	" ",      50,     20,    25,  250
idmass		FLvalue	" ",      50,     20,    25,  300
idfreqH		FLvalue	" ",      50,     20,    25,  350
idinit		FLvalue	" ",      50,     20,    25,  400
idpos		FLvalue	" ",      50,     20,    25,  450
idvel		FLvalue	" ",      50,     20,    25,  500
idsfreq		FLvalue	" ",      50,     20,    25,  550
idsspread	FLvalue	" ",      50,     20,    25,  600
idOutGain	FLvalue	" ",      50,     20,    25,  650

;TEXT BOX INPUT 					MIN | MAX |  STEP | TYPE | WIDTH | HEIGHT | X | Y
gkposRat1, ihposRat1	FLtext	"Position",		0,     1,  0.0001,    1,    50,     25,   610, 60	; strictly greater than 0 less than 1 
gkMDRRat1, ihMDRRat1	FLtext	"Mass Density Ratio",	0, 10000,    0.1,    1,    50,     25,   680, 60 
gkFrqRat1, ihFrqRat1	FLtext	"Frequency",		0.1,1000,    0.1,    1,    50,     25,   750, 60 
gkLenRat1, ihLenRat1	FLtext	"Length",		0,     1,   0.001,    1,    50,     25,   820, 60 

gkposRub1, ihposRub1	FLtext	"Position",		0,     1,  0.0001,    1,    50,     25,   610, 205 
gkMDRRub1, ihMDRRub1	FLtext	"Mass Density Ratio",	0, 10000,     0.1,    1,    50,     25,   680, 205 
gkFrqRub1, ihFrqRub1	FLtext	"Frequency",		0,  1000,       1,    1,    50,     25,   750, 205 
gkLosRub1, ihLosRub1	FLtext	"Loss",			0, 10000,     0.1,    1,    50,     25,   820, 205	; values less than 1 will result in feedback and continuous sound 

;SET INITIAL VALUES		VALUE | HANDLE
		FLsetVal_i	1,      ihrattle1
		FLsetVal_i	0.6,    ihposRat1
		FLsetVal_i	1000,   ihMDRRat1
		FLsetVal_i	30,    ihFrqRat1
		FLsetVal_i	0.001,  ihLenRat1

		FLsetVal_i	1,      ihrubber1
		FLsetVal_i	0.7,    ihposRub1
		FLsetVal_i	1000,   ihMDRRub1
		FLsetVal_i	40,    ihFrqRub1
		FLsetVal_i	1000,   ihLosRub1

;SLIDERS				            					MIN |   MAX   | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X  | Y
gkMuteThresh, ihMuteThresh	FLslider	"Mute Thresh.",				0.1,      1,     0,     3,        -1,     100,    15,   170,   10
gkmute, gihmute			FLslider	"MUTE",					0,        1,     0,     2,        -1,      30,    20,   275,   10
FLsetColor2	255, 0, 0, gihmute
FLsetTextSize	10, gihmute
gkreinit, gihreinit		FLslider	"REINIT.",				0,        1,     0,     2,        -1,      30,    20,   315,   10
FLsetColor2	255, 0, 0, gihreinit
FLsetTextSize	10, gihreinit
gkfreqS, ihfreqS		FLslider	"String Frequency (i-rate)",		20,   10000,    -1,    23,   idfreqS,     400,    20,    75,   50
gkD, ihD			FLslider	"Detuning (i-rate)",			0,     5000,     0,    23,   idD,         400,    20,    75,  100
gkK, ihK			FLslider	"Stiffness (i-rate)",			1,     1000,    -1,    23,   idK,         400,    20,    75,  150
gkT30, ihT30			FLslider	"30 dB Decay time (i-rate)",		.1,      30,     0,    23,   idT30,       400,    20,    75,  200
gkB, ihB			FLslider	"High Frequency Loss (i-rate)",		0.0001,   1,     0,    23,   idB,         400,    20,    75,  250
gkmass, ihmass			FLslider	"Hammer Mass (i-rate)",			0.0001,  10,     0,    23,   idmass,      400,    20,    75,  300
gkfreqH, ihfreqH		FLslider	"Hammer Frequency (i-rate)",		20,   40000,    -1,    23,   idfreqH,     400,    20,    75,  350
gkinit, ihinit			FLslider	"Hammer Initial Position (i-rate)",	0,      0.5,     0,    23,   idinit,      400,    20,    75,  400
gkpos, ihpos			FLslider	"Hammer Position Along String (i-rate)",.004,  .996,     0,    23,   idpos,       400,    20,    75,  450
gkvel, ihvel			FLslider	"Normalised String Velocity (i-rate)",	0,      100,     0,    23,   idvel,       400,    20,    75,  500
gksfreq, ihsfreq		FLslider	"Scanning Frequency (i-rate)",		0,      100,     0,    23,   idsfreq,     400,    20,    75,  550
gksspread, ihsspread		FLslider	"Scanning Frequency Spread (i-rate)",	0,        1,     0,    23,   idsspread,   400,    20,    75,  600
gkOutGain, ihOutGain		FLslider	"Output Gain",				0,        1,     0,    23,   idOutGain,   400,    20,    75,  650

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkNS, ihNS 			FLcount  "Number of Strings", 		1,    50,    1,       1,     2,     120,     20,   355, 10,   -1

FLcolor2	255, 255, 50		;SET SECONDARY COLOUR TO YELLOW

;;;;;;;;;;;;;;;;;;;BOUNDARY CONDITIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,    240		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkbcL, ihbcL		FLbutBank	12,     1,     3,     25,    75,    525, 350,    -1	;-1 = OPCODE FUNCTION NOT USED 
gkbcR, ihbcR		FLbutBank	12,     1,     3,     25,    75,    775, 350,    -1	;-1 = OPCODE FUNCTION NOT USED

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	100, 	ihfreqS
		FLsetVal_i	3, 	ihNS
		FLsetVal_i	0, 	ihD
		FLsetVal_i	1, 	ihK
		FLsetVal_i	12, 	ihT30
		FLsetVal_i	0.002, 	ihB
		FLsetVal_i	0, 	ihbcL
		FLsetVal_i	0, 	ihbcR
		FLsetVal_i	1, 	ihmass
		FLsetVal_i	10000, 	ihfreqH
		FLsetVal_i	-0.01, 	ihinit
		FLsetVal_i	0.09, 	ihpos
		FLsetVal_i	50, 	ihvel
		FLsetVal_i	0, 	ihsfreq
		FLsetVal_i	0.1, 	ihsspread
		FLsetVal_i	0.75, 	ihOutGain
		FLsetVal_i	0.9, 	ihMuteThresh

		FLpanel_end

		FLcolor2	255, 255, 240


;INSTRUCTIONS AND INFO PANEL
;				                WIDTH | HEIGHT | X | Y
				FLpanel	" ", 	515,      700,  900,10
				FLscroll     	515,      700,  0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         prepiano                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The prepiano opcode implements a physical model of a Cageian ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"prepared piano. The user has control of the base frequency of", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"a string (or group of strings), the number of strings beneath", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"the hammer, the amount of detuning between a group of        ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"strings, the stiffness of the strings, the time for a note to", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"decay by 30 dB, the amount of high frequency damping that    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"occurs during a note's decay, the mass of the hammer, the    ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"frequency of the hammer's natural vibrations, the location   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"along the string's length at which the hammer strikes and the", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"velocity of the hammer as it moves to strike the string.     ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"The user can choose the method of restraint applied to the   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"string independently for its left and right extremities.     ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"Choosing 'clamped' reflects the normal method of binding a   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"piano string, 'pivoting' reflects the method used to bind a  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"note on a marimba and 'free' means that the string extremity ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"is not bound at all.                                         ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"To imbue the sound with some movement the author has         ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"imagined the sound being received by a pick-up that moves to ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"and fro along the length of the string. 'Scanning Spread'    ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"controls the amplitude of this movement and 'Scanning        ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"Frequency' controls the frequency of this movement.          ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"The methods of Cageian piano preparation that are implemented", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"in this opcode are the addition of hard objects that vibrate ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"in sympathy with the string but are not firmly attached to   ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"it rattles and soft objects that damp the string (rubbers).  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"For rattles the user is able to define its position along the", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"string, the mass/density ratio between rattle and string, its", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"frequency and its length.                                    ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"For rubbers the user can define position, mass/density ratio,", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"frequency and loss.                                          ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"By using function tables for the definition of rubbers and   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"rattles it is possible to have any amount of them applied to ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"the same string.                                             ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"As with many physical models we have the opportunity to      ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"specify conditions that would not be possible in the real    ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"world, for this reason it is easily to produce mathematical  ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"procedures that quickly 'blow up' and produce extremely loud ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"and distorted sounds. Approach parameter changes with caution", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"and protect your ears and speakers.                          ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"This example includes a safety cutout mechanism so that if   ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"the audio signal output by the opcode does explode suddenly, ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"the signal will be instantly muted and will only be unmuted  ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"when the signal amplitude returns to normal.                 ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"This example can also be played from a MIDI keyboard in which", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"case 'String Frequency' will adopt the value of the MIDI key.", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"Hints                                                        ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"-----                                                        ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"prepiano has a tendency to build and build in amplitude and  ", 	1,      5,     14,    490,    20,     5,1000 
ih		 	FLbox  	"ultimately overload in an exponential fashion on of account  ", 	1,      5,     14,    490,    20,     5,1020 
ih		 	FLbox  	"of feedback loops within the algorithm. This tendency can be ", 	1,      5,     14,    490,    20,     5,1040 
ih		 	FLbox  	"aggravated when using rubbers and rattles but certain trends ", 	1,      5,     14,    490,    20,     5,1060 
ih		 	FLbox  	"can still be identified. Lower notes Ilower 'String          ", 	1,      5,     14,    490,    20,     5,1080 
ih		 	FLbox  	"Frequency' become more likely to explode. The use of         ", 	1,      5,     14,    490,    20,     5,1100 
ih		 	FLbox  	"'Detuning' away from '1' will also increase the likelihood of", 	1,      5,     14,    490,    20,     5,1120 
ih		 	FLbox  	"explosion. Higher 'Mass Density Ratios' in the rattles and   ", 	1,      5,     14,    490,    20,     5,1140 
ih		 	FLbox  	"rubbers will generally increase the speed of feedback build- ", 	1,      5,     14,    490,    20,     5,1160 
ih		 	FLbox  	"up but not necessarily the likelihood. Moving rattles and    ", 	1,      5,     14,    490,    20,     5,1180 
ih		 	FLbox  	"rubbers away from the central location of a string/strings   ", 	1,      5,     14,    490,    20,     5,1200 
ih		 	FLbox  	"to either end (close to zero or close to 1) will suppress    ", 	1,      5,     14,    490,    20,     5,1220 
ih		 	FLbox  	"build-up. The best control over unrestrained build-up is the ", 	1,      5,     14,    490,    20,     5,1240 
ih		 	FLbox  	"'30 dB Decay' control. Increase of 'High Frequency Loss' will", 	1,      5,     14,    490,    20,     5,1260 
ih		 	FLbox  	"also suppress feedback but if '30 dB Decay' is large then a  ", 	1,      5,     14,    490,    20,     5,1280 
ih		 	FLbox  	"low frequency feedback can still intrude. Despite all these  ", 	1,      5,     14,    490,    20,     5,1300 
ih		 	FLbox  	"warnings of the algorithm feeding back, controlled sustained ", 	1,      5,     14,    490,    20,     5,1320 
ih		 	FLbox  	"textures that can sound quite interesting can with care still", 	1,      5,     14,    490,    20,     5,1340 
ih		 	FLbox  	"be achieved. Perhaps a wise approach is to explore the opcode", 	1,      5,     14,    490,    20,     5,1360 
ih		 	FLbox  	"without rattles or rubbers and first gain an understanding of", 	1,      5,     14,    490,    20,     5,1380 
ih		 	FLbox  	"its basic control paramters.                                 ", 	1,      5,     14,    490,    20,     5,1400 
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 920

				FLscrollEnd
				FLpanel_end

		FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;	 				COUNT | POSITION | MASS DENSITY RATIO OF RATTLE/STRING | FREQUENCY OF RATTLE | VERTICAL LENGTH OF THE RATTLE/ RUBBER LOSS
girattles	ftgen	1, 0, 8, -2,   	1,         0.6,                    10,                           100,                    0.001
girubbers	ftgen	2, 0, 8, -2,   	1,         0.7,                    50,                           500,                    1000

instr	2
 kOnTrig	trigger	gkOnOff,0.5,0
 kOffTrig	trigger	gkOnOff,0.5,1
 if kOnTrig==1 then
  event "i",1,0,3600,gkfreqS
 endif
endin

instr	1	;SOUND PRODUCING INSTRUMENT
	
	imidiflag	init	0
	mididefault 1, imidiflag
	
	if gkOnOff==0&&imidiflag=0 then
	 turnoff
	endif

 	ifreqS	=		p4
 	
	kreinit	changed		gkD, gkK, gkT30, gkB-0.0001, gkmass, gkfreqH, gkinit, gkpos, gkvel, gksfreq, gksspread, gkNS, gkrattle1, gkposRat1, gkMDRRat1, gkFrqRat1, gkLenRat1, gkrubber1, gkposRub1, gkMDRRub1, gkFrqRub1, gkLosRub1
	
	ktrig	changed		kreinit
	ktrig2	delayk		ktrig,0.05
	ktrig	samphold	ktrig,ktrig+ktrig2
	FLsetVal	ktrig+ktrig2, ktrig, gihreinit
	
	if kreinit==1 then
	 reinit RESTART_PREPIANO
	endif
	RESTART_PREPIANO:
	;	 				COUNT        |  POSITION    | MASS DENSITY RATIO OF RATTLE/STRING | FREQUENCY OF RATTLE | VERTICAL LENGTH OF THE RATTLE/ RUBBER LOSS
	girattles	ftgen	1, 0, 8, -2,   	i(gkrattle1), i(gkposRat1),             i(gkMDRRat1),                  i(gkFrqRat1),        i(gkLenRat1)
	girubbers	ftgen	2, 0, 8, -2,   	i(gkrubber1), i(gkposRub1),             i(gkMDRRub1),                  i(gkFrqRub1),        i(gkLosRub1)
	;OUTPUTS OPCODE		BASE-FREQ | NUM_OF_STRINGS | DETUNING | STIFFNESS | 30 DB DECAY TIME | HIGH_FREQUENCY_LOSS | LEFT_BOUNDARY_CONDITION | RIGHT_BOUNDARY_CONDITION | HAMMER_MASS | HAMMER_FREQUENCY | HAMMER_INITIAL_POSITION | POSITION_ALONG_STRING | HAMMER_VELOCITY | SCANNING_FREQ | SCANNING_FREQ_SPREAD | RATTLES_FUNCTION_TABLE | RUBBERS_FUNCTION_TABLE             
	al,ar 	prepiano 	ifreqS,        i(gkNS),       i(gkD),     i(gkK),      i(gkT30),             i(gkB),                 i(gkbcL)+1,                   i(gkbcR)+1,            i(gkmass),     i(gkfreqH),             i(gkinit),              i(gkpos),            i(gkvel),       i(gksfreq),        i(gksspread),       girattles,               girubbers
	aenv	linsegr		1,0.1,0


	; EMERGENCY GATE - CUTS AUDIO OUT COMPLETELY IF prepiano STARTS TO EXPLODE ON ACCOUNT OF A PARTICULAR COMBINATION OF INPUT PARAMETERS
	krms	rms	al			; scan RMS of left channel
	kgate	=	krms>i(gkMuteThresh)?0:1	; gate 'on' or 'off' (1 or zero) depending on rms value
	agate	interp	kgate			; interpolate to a-rate. agate will ramp from 1 to zero (or vice versa) across the duration of ksmps. This will be a bit smoother and less 'clicky' than a simple zero to 1 switch (i.e. if using 'upsamp')
	ktrig	changed	kgate			; trigger for updating FLTK indicator
	krel	release				; sense release
	FLsetVal	ktrig,1-kgate,gihmute	; update FLTK indicator (FLslider)
	if krel==1 then				; always deactivate indicator when note is released
	 FLsetVal	k(1),k(0),gihmute	; update FLTK indicator (FLslider)
	endif
	
	al	=	al * gkOutGain * aenv * agate
	ar	=	ar * gkOutGain * aenv * agate
		outs 		al,ar
endin

</CsInstruments>

<CsScore>
i 2 0 3600
</CsScore>

</CsoundSynthesizer>