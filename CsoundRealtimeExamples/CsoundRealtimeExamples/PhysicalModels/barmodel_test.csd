; strike width produces tonal variations similar to strike position
; - therefore find a constant for strike width and use strike position to vary spectrum
; Strike velocity seems to have no spectral bearing , merely amplitude and whether the note sounds at all.
; - therefore derive a constant for strike velocity dependent upon boundary conditions.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
; --displays
; -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		FLcolor		255, 255, 240, 0, 0, 0

;			LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	" ",     500,    720,    5,  5

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	8,      9,     15,    240,   120,     5, 445	;BOUNDARY CONDITION L
ih		 	FLbox  	" ", 	8,      9,     15,    240,   120,   255, 445	;BOUNDARY CONDITION R

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
gkOnOff,ihOnOff1	FLbutton	"Note On/Off",	1,    0,    22,    150,     30,    25, 10,    0,     99,      0,      -1
gkOnOff,ihOnOff2	FLbutton	"Re-Strike",	1,    1,    21,    150,     30,   200, 10,    0,     99,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff1		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihOnOff2		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idT30		FLvalue	" ",      50,     20,    25,  100
idb		FLvalue	" ",      50,     20,    25,  150
idpos		FLvalue	" ",      50,     20,    25,  200
idvel		FLvalue	" ",      50,     20,    25,  250
idscan		FLvalue	" ",      50,     20,    25,  300
idwid		FLvalue	" ",      50,     20,    25,  350
idOutGain	FLvalue	" ",      50,     20,    25,  400
idPShapeAmt	FLvalue	" ",      50,     20,    25,  650


;VALUE BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkK, gihK		FLtext		"Stiffness", 			 0,   5000,0.0001,  1,      70,     20,    75,  50
gkTestAmp, ihTestAmp	FLtext		"Test Amp", 			 0,   1,   0.0001,  1,      70,     20,   150,  50
gkTestNote, ihTestNote	FLtext		"Test Note", 			 0,   127,      1,  1,      70,     20,   225,  50

;BUTTONS						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkTestOnOff,ihTestOnOff	FLbutton	"Test",	1,    0,    22,     80,     30,   300, 50,    -1
FLsetColor2	255, 255, 50, ihTestOnOff		;SET SECONDARY COLOUR TO YELLOW
gkAutoOnOff,ihAutoOnOff	FLbutton	"Auto",		1,    0,    22,     80,     30,   385, 50,    -1
FLsetColor2	255, 255, 50, ihAutoOnOff		;SET SECONDARY COLOUR TO YELLOW
gkFFTscan,ihFFTscan	FLbutton	"FFT Scan",	1,    0,    22,    100,     30,   365, 10,    -1
FLsetColor2	255, 255, 50, ihFFTscan		;SET SECONDARY COLOUR TO YELLOW
gkLPFOnOff,ihLPFOnOff	FLbutton	"On/Off",	1,    0,    22,     70,     18,     5,570,    -1
FLsetColor2	255, 255, 50, ihLPFOnOff	;SET SECONDARY COLOUR TO YELLOW
gkHPFOnOff,ihHPFOnOff	FLbutton	"On/Off",	1,    0,    22,     70,     18,     5,610,    -1
FLsetColor2	255, 255, 50, ihHPFOnOff	;SET SECONDARY COLOUR TO YELLOW

;SLIDERS				            					MIN |   MAX   | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X  | Y
;gkK, ihK			FLslider	"Stiffness (i-rate)",			0,     1000,     0,    23,   idK,         400,    20,    75,   50
gkT30, ihT30			FLslider	"30 dB Decay time (i-rate)",		0.1,   3000,     0,    23,   idT30,       400,    20,    75,  100
gkb, ihb			FLslider	"High Frequency Loss (i-rate)",		0.00001, 10,     0,    23,   idb,         400,    20,    75,  150
gkpos, ihpos			FLslider	"Strike Position Along Bar (i-rate)",   .004,    .5,     0,    23,   idpos,       400,    20,    75,  200
gkvel, ihvel			FLslider	"Normalised Strike Velocity (i-rate)",	0,    30000,     0,    23,   idvel,       400,    20,    75,  250
gkscan, ihscan			FLslider	"Scanning Frequency (k-rate)",		0,        5,     0,    23,   idscan,      400,    20,    75,  300
gkwid, ihwid			FLslider	"Width of Strike (i-rate)",		0.0001,   1,     0,    23,   idwid,       400,    20,    75,  350
gkOutGain, ihOutGain		FLslider	"Output Gain",				0,        5,     0,    23,   idOutGain,   400,    20,    75,  400

gkLPF, ihLPF			FLslider	"LPF",					20,   20000,    -1,    23,   -1,          400,    20,    75,  570
gkHPF, ihHPF			FLslider	"HPF",					20,   20000,    -1,    23,   -1,          400,    20,    75,  610
gkPShapeAmt, ihPShapeAmt	FLslider	"Powershape",				.1,      20,    -1,    23,   idPShapeAmt, 400,    20,    75,  650

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
		FLsetVal_i	130, 	gihK
		FLsetVal_i	0.1, 	ihTestAmp
		FLsetVal_i	60, 	ihTestNote
		FLsetVal_i	3000, 	ihT30
		FLsetVal_i	0, 	ihb
		FLsetVal_i	0, 	ihbcL
		FLsetVal_i	2, 	ihbcR
		FLsetVal_i	.837, 	ihpos
		FLsetVal_i	2200, 	ihvel
		FLsetVal_i	0, 	ihscan
		FLsetVal_i	0.5, ihwid
		FLsetVal_i	0.6, 	ihOutGain
		FLsetVal_i	20000, 	ihLPF
		FLsetVal_i	20, 	ihHPF
		FLsetVal_i	1, 	ihPShapeAmt
		FLsetVal_i	1, 	ihFFTscan
		FLpanel_end

		FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gicos	ftgen	0,0,131072,11,1
giPP	ftgen	0, 0, 128, -17, 0, 21.3	,23	,21.3,24	,22.15,25	,23.1,26	,24.1259,27	,25.2,28	,26.35,29	,27.85,30	,29.5,31	,31.5,32	,33.4,33	,35.00,34	,37.5,35	,38.86,36	,41.87,37	,44.46,38	,47.15,39	,49.89,40	,52.95,41	,56.22,42	,59.55,43	,63.26,44	,66.93,45	,71.0,46	,75.22,47	,79.84,48	,84.58,49	,88.57,50	,93.83,51	,99.45,52	,105.37,53	,111.63,54	,118.35,55	,125.4,56	,132.95,57	,140.86,58	,149.24,59	,158.3,60	,167.7,61	,177.7,62	,188.5,63	,199.7,64	,211.6,65	,224.6,66	,237.94,67	,252.1,68	,267.06,69	,283.7,70	,300.56,71	,318.5,72	,337.35,73	,358.9,74	,380.14,75	,402.73,76	,426.7,77	,454.8,78	,481.8,79	,510.4,80	,540.72,81	,572.9,82	,606.9,83	,649.4,84	,687.94,85	,728.77,86	,772.01,87	,817.8,88	,866.3,89	,934.92,90	,990.31,91	,1049,92	,1111.05,93	,1176.78,94	,1246.35,95	,1319.99,96	,1455.78,97	,1541.65,98	,1728.6,99	,1728.6,100	,1830.17,101	,1937.6,102	,2051.15,103	,2171.14,104	,2297.9,105	,2735.71,106	,2894.65,107	,3062.34,108	,3239.16,109	,3425.51,110	,3621.76,111	,3828.29,112	,4045.44,113	,4273.54,114	,4512.87,115	,4763.67,116	,5026.14,117	,5300.32
giPosScal	ftgen	0,0,1024,-16,1,1024,2,0.2

instr	1
 inote	notnum
 print	inote
 iK	table	inote,giPP
 FLsetVal_i	iK,gihK
endin


	instr		99
; SENSE FLTK ON/OFF SWITCH
if	gkOnOff!=0	kgoto	CONTINUE	;IF SWITCH IS *NOT* OFF, JUMP TO 'CONTINUE' LABEL, OTHERWISE...
			turnoff			;...TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:  					;'CONTINUE' LABEL

gkK	limit	gkK,1,15000

kSwitch		changed		gkK, gkT30, gkb, gkpos, gkvel, gkwid	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
if		kSwitch=1	then	;IF kSwitch=1, I.E. IF ANY OF THE ABOVE LISTED PARAMETERS HAVE CHANGED...
	reinit		START		;...PERFORM AN I-RATE PASS BEGINNING FROM THE GIVEN LABEL
endif					;END OF CONDITIONAL BRANCHING
START:					;A LABEL
;			LEFT      | RIGHT     | STIFFNESS | HIGH-             | SCANNING | 30dB   | STRIKE   | STRIKE   | WIDTH
;			BOUNDARY  | BOUNDARY  |           | -FREQUENCY        | SPEED    | DECAY  | POSITION | VELOCITY | OF
;			CONDITION | CONDITION |           | LOSS              |          | TIME   |          |          | STRIKE
ares 	barmodel 	gkbcL+1,     gkbcR+1,    i(gkK),     i(gkb)-.00001,      gkscan,   i(gkT30), i(gkpos), i(gkvel), i(gkwid)
;aR 	barmodel 	gkbcL+1,     gkbcR+1,    i(gkK),     i(gkb)-.00001,      gkscan*2,   i(gkT30), i(gkpos), i(gkvel), i(gkwid)
;ares	=	ares + aR

;amp scaling
iscal	tablei	i(gkpos)*2,giPosScal,1
ares	=	ares * iscal

if gkLPFOnOff==1 then
 ares	butlp	ares,gkLPF
 ares	butlp	ares,gkLPF
endif

if gkHPFOnOff==1 then
 ares	buthp	ares,gkHPF
 ares	buthp	ares,gkHPF
endif

;POWERSHAPE
ifullscale	=	0dbfs					;DEFINE FULLSCALE AMPLITUDE VALUE
;ares 		powershape 	ares, gkPShapeAmt, ifullscale	;CREATE POWERSHAPED SIGNAL

rireturn



	outs 		ares * gkOutGain, ares * gkOutGain	;SEND AUDIO TO OUTPUTS. RESCALE WITH VARIBLE FROM FLTK 'OUTPUT GAIN' SLIDER

if gkFFTscan==1 then
 ifftsize	=	2048
 ioverlap	=	ifftsize/4
 fsig 	pvsanal		ares,ifftsize,ioverlap,ifftsize,1	; track note number
 kf,ka 	pvspitch 	fsig, 0.01
 koct	=		octcps(kf)
 knote	=		(koct-3)*12
 kmed 	mediank 	knote, 333, 333
 if knote>0 then
  printk	0.5,knote
 endif
endif


if gkAutoOnOff==1 then
 kmetro	metro	100
 if kmetro==1 then
  knote	=	(round(knote*100))*0.01		; round to 2 decimal places
  if knote<gkTestNote then
   FLsetVal	kmetro,gkK+0.1, gihK
  elseif knote>gkTestNote then
   FLsetVal	kmetro,gkK-0.1, gihK
  endif
 endif
endif
 
;atest	poscil		gkTestAmp*gkTestOnOff,cpsmidinn(gkTestNote)
atest	gbuzz		gkTestAmp*gkTestOnOff,cpsmidinn(gkTestNote),80,1,0.5,gicos
	outs		atest,atest


	endin

</CsInstruments>

<CsScore>
f 0 [3600*24]	;DUMMY SCORE EVENT. SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>