<CsoundSynthesizer>

<CsOptions>
-odac -m0d
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		FLcolor		255, 255, 240, 0, 0, 0

;			LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	" ",     500,    720,    5,  5

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	8,      9,     15,    240,   120,     5, 445	;BOUNDARY CONDITION L
ih		 	FLbox  	" ", 	8,      9,     15,    240,   120,   255, 445	;BOUNDARY CONDITION R
;BORDERS				                                                                                                                                             		TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihtitle		 	FLbox  	"Physical model of a vibrating metal bar. Algorithm written by Stefan Bilbao. Opcode ported for Csound by John ffitch. Example written by Iain McCurdy.", 	8,      2,     24,    490,    140,    5, 570	;TITLE

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Boundary Condition L",	1,      4,     14,    150,     10,    10, 455
ih		 	FLbox  	"Boundary Condition R",	1,      4,     14,    150,     10,   260, 455
ih		 	FLbox  	"Clamped ",		1,      15,    11,     50,     10,    60, 488
ih		 	FLbox  	"Pivoting",		1,      15,    11,     50,     10,    60, 513
ih		 	FLbox  	"Free    ",		1,      15,    11,     50,     10,    60, 538
ih		 	FLbox  	"Clamped ",		1,      15,    11,     50,     10,   310, 488
ih		 	FLbox  	"Pivoting",		1,      15,    11,     50,     10,   310, 513
ih		 	FLbox  	"Free    ",		1,      15,    11,     50,     10,   310, 538


;BUTTONS						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff1	FLbutton	"Note On/Off",	1,    0,    22,    150,     30,    25, 10,    0,     1,      0,      -1
gkOnOff,ihOnOff2	FLbutton	"Re-Strike",	1,    1,    21,    150,     30,   200, 10,    0,     1,      0,      -1
gkHoldT30,ihHoldT30	FLbutton	"Hold",		1,    0,     3,     45,     12,   452,105,   -1
gkHoldHF,ihHoldHF	FLbutton	"Hold",		1,    0,     3,     45,     12,   452,155,   -1
gkx100,ihx100		FLbutton	"*100",		1000,  1,     3,     45,     12,   452,305,   -1
FLsetColor2	255, 255, 50, ihOnOff1		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihOnOff2		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idK		FLvalue	" ",      50,     20,     5,   50
idT30		FLvalue	" ",      50,     20,     5,  100
idb		FLvalue	" ",      50,     20,     5,  150
idpos		FLvalue	" ",      50,     20,     5,  200
idvel		FLvalue	" ",      50,     20,     5,  250
idscan		FLvalue	" ",      50,     20,     5,  300
idwid		FLvalue	" ",      50,     20,     5,  350
idOutGain	FLvalue	" ",      50,     20,     5,  400

;SLIDERS				            					MIN |   MAX   | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X  | Y
gkK, ihK			FLslider	"Stiffness (i-rate)",			0.1,   8000,    -1,    23,   idK,         400,    20,    55,   50
gkT30, ihT30			FLslider	"30 dB Decay time (i-rate)",		.1,      30,     0,    23,   idT30,       400,    20,    55,  100
gkb, ihb			FLslider	"High Frequency Loss (i-rate)",		.00001,  10,     0,    23,   idb,         400,    20,    55,  150
gkpos, ihpos			FLslider	"Strike Position Along Bar (i-rate)",   .004,  .996,     0,    23,   idpos,       400,    20,    55,  200
gkvel, ihvel			FLslider	"Normalised Strike Velocity (i-rate)",	0,    30000,     0,    23,   idvel,       400,    20,    55,  250
gkscan, ihscan			FLslider	"Scanning Frequency (k-rate)",		0,        1,     0,    23,   idscan,      400,    20,    55,  300
gkwid, ihwid			FLslider	"Width of Strike (i-rate)",		0.01,     2,    -1,    23,   idwid,       400,    20,    55,  350
gkOutGain, ihOutGain		FLslider	"Output Gain",				0,        5,     0,    23,   idOutGain,   400,    20,    55,  400

;;;;;;;;;;;;;;;;;;;BOUNDARY CONDITIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,    240		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkbcL, ihbcL		FLbutBank	12,     1,     3,     25,    75,     25, 480,    -1
gkbcR, ihbcR		FLbutBank	12,     1,     3,     25,    75,    275, 480,    -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	130, 	ihK
		FLsetVal_i	20, 	ihT30
		FLsetVal_i	.0775, 	ihb
		FLsetVal_i	1, 	ihbcL
		FLsetVal_i	1, 	ihbcR
		FLsetVal_i	.837, 	ihpos
		FLsetVal_i	16000, 	ihvel
		FLsetVal_i	0.775, 	ihscan
		FLsetVal_i	0.0156, ihwid
		FLsetVal_i	0.6, 	ihOutGain

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 520, 512, 0
				FLscroll     512, 520, 0,0 
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          barmodel                           ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'barmodel' is an implementation of physical model of a struck", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"metal bar.                                                   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Boundary conditions define how the bar behaves at either     ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"extremity. The options here are clamped (as in a kalimba     ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"tangent), pivoting (as in a vibraphone bar), or free (as in  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"the lower end of a tubular bell). If 'free' is chosen as one ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"of the boundary conditions then the other needs to be        ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'clamped' otherwise the opcode will 'blow up'.               ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"There is no specific control of the frequency of the tone    ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"produced, instead it is consequnce to the attributes chosen  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"for 'Stiffness' (of the material of which the bar has been   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"constructed) and the boundary conditions.                    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'30dB Decay Time' and 'High Frequency Loss' impact upon the  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"duration of the sound produced, 'High Frequency Loss'        ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"defining how much more quickly higher frequencies decay than ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"lower ones. If the boundary conditions are 'clamped' & 'free'", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"then the fundemental will not be affected by 'High Frequency ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"Loss' (unlike the other partials) but instead its duration   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"will only be dependent upon the setting for 30dB Decay Time. ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"'Strike Position Along Bar' defines where the bar is struck  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"along its length. Effectively this controls the strengths of ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"the various partials that make up the tone. If 'Strike Width'", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"is low there may be a limited number of strike positions     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"available that will produce sound.                           ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"'Strike Velocity' has an impact upon the brightness of the   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"tone produced.                                               ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"'Scanning Frequency' controls the frequency of oscillation   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"about a position from which the sound is scanned. This       ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"oscillation results in variations in tone and amplitude. This", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"situation could also be thought of as the bar swinging as in ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"the swinging of a tubular bell. If this parameter is set to  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"zero scanning oscillation is prevented. This is barmodel's   ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"only parameter that can be modulated in realtime.            ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"'Width of Strike' has an impact upon strength and shrillness ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"of the tone produced. Low values here will limit the values  ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"for 'Stiffness' and 'Strike Location' that will produce      ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"sound.                                                       ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"'Hold' buttons are provided for '30 dB Decay' and for 'High  ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"Frequency Decay'. '30 dB Decay':'Hold' will set '30 dB Decay'", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"to 3600, ignoring the slider value. 'High Frequency Decay':  ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"'Hold' will set 'High Frequency Decay' to zero, ignoring the ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"slider value.                                                ", 	1,      5,     14,    490,    20,     5, 860

		FLscroll_end
		FLpanel_end

		FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	instr		1
; SENSE FLTK ON/OFF SWITCH
if	gkOnOff!=0	kgoto	CONTINUE	;IF SWITCH IS *NOT* OFF, JUMP TO 'CONTINUE' LABEL, OTHERWISE...
			turnoff			;...TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:  					;'CONTINUE' LABEL
kSwitch		changed		gkK, gkT30, gkb, gkpos, gkvel, gkwid, gkHoldT30, gkHoldHF, gkx100	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
if		kSwitch=1	then	;IF kSwitch=1, I.E. IF ANY OF THE ABOVE LISTED PARAMETERS HAVE CHANGED...
	reinit		START		;...PERFORM AN I-RATE PASS BEGINNING FROM THE GIVEN LABEL
endif					;END OF CONDITIONAL BRANCHING
START:					;A LABEL
kporttime	linseg		0,0.01,0.1
ib	=	i(gkHoldHF)  = 1 ? 0    : i(gkb)
iT30	=	i(gkHoldT30) = 1 ? 3600 : i(gkT30)
kscan	portk	gkscan,kporttime
;			LEFT      | RIGHT     | STIFFNESS | HIGH-      |  SCANNING   | 30dB   | STRIKE   | STRIKE   | WIDTH
;			BOUNDARY  | BOUNDARY  |           | -FREQUENCY |  SPEED      | DECAY  | POSITION | VELOCITY | OF
;			CONDITION | CONDITION |           | LOSS       |             | TIME   |          |          | STRIKE
ares 	barmodel 	gkbcL+1,     gkbcR+1,    i(gkK),       ib,      kscan*gkx100,  iT30,    i(gkpos), i(gkvel), i(gkwid)
rireturn
	outs 		ares * gkOutGain, ares * gkOutGain	;SEND AUDIO TO OUTPUTS. RESCALE WITH VARIBLE FROM FLTK 'OUTPUT GAIN' SLIDER
	endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT. SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>