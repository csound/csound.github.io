TB303.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;CONTROL PERIOD
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	220, 220, 220, 0, 0, 0
;		LABEL             | WIDTH | HEIGHT | X | Y
	FLpanel	"Bassline TB303",   1000,    320,    0,  0


;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      20, 320,  10
ih		 	FLbox  	"Sawtooth", 		1,       5,    12,     60,      20, 390,  10
ih		 	FLbox  	"Square  ", 		1,       5,    12,     60,      20, 390,  30
ih		 	FLbox  	"Pitch", 		1,       1,    13,     40,      20,   5,   170+25
ih		 	FLbox  	"On/Off", 		1,       1,    11,     40,      15,  20,   170+100
;FLsetTextSize	11,ih
ih		 	FLbox  	"Hold", 		1,       1,    11,     40,      15,  20,   170+115
;FLsetTextSize	11,ih
ih		 	FLbox  	"Accent", 		1,       1,    11,     40,      15,  20,   170+130
;FLsetTextSize	11,ih
ih		 	FLbox  	"Bass Line", 		1,       2,    36,    200,      40, 800,   5
FLsetTextType	5,ih
ih		 	FLbox  	"Transpose", 		1,       1,    15,    100,      15, 880,   100
ih		 	FLbox  	"Oct", 			1,       1,    10,     25,      15, 880,   145
ih		 	FLbox  	"Semi", 		1,       1,    10,     25,      15, 917,   145
ih		 	FLbox  	"Oct", 			1,       1,    10,     25,      15, 955,   145

FLcolor	255, 255, 255, 0, 0, 0
;SWITCHES					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"Run/Stop",	1,   0,    22,    140,     40,     5,  5,    0,      3,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetTextSize	20, ihOnOff
gk,ih			FLbutton	"CLEAR",	1,    0,    1,     50,      25,    880,     70,         0,      100,      0,      0
FLsetFont	2, ih
FLsetTextSize	12, ih
gk,ih			FLbutton	"RND.",		1,    0,    1,     50,      25,    930,     70,         0,      101,      0,      0
FLsetFont	2, ih
FLsetTextSize	12, ih
gkOctDn,ih		FLbutton	"@<-",		1,    0,    1,     25,      25,    880,    120,         0,       99,      0,      0, -1
gkSemiDn,ih		FLbutton	"@<-",		1,    0,    1,     25,      25,    905,    120,         0,       99,      0,      0, -1/12
gkSemiUp,ih		FLbutton	"@->",		1,    0,    1,     25,      25,    930,    120,         0,       99,      0,      0,  1/12
gkOctUp,ih		FLbutton	"@->",		1,    0,    1,     25,      25,    955,    120,         0,       99,      0,      0,  1

;NUMBER DISPLAY BOXES 		WIDTH | HEIGHT | X | Y 
idVol		FLvalue "", 	70,       20,   30, 145
idTuning	FLvalue "", 	70,       20,  105, 145
idCfBase	FLvalue "", 	70,       20,  180, 145
idCfEnv		FLvalue "", 	70,       20,  255, 145
idRes		FLvalue "", 	70,       20,  330, 145
idDecay		FLvalue "", 	70,       20,  405, 145
idAccent	FLvalue "", 	70,       20,  480, 145
idDist		FLvalue "", 	70,       20,  555, 145

;KNOBS				LABEL        | MIN | MAX | EXP | TYPE |  DISP   | WIDTH | X | Y
gkVol, ihVol		FLknob	"Volume",       0,    5,    0,    1,   idVol,      70,    30, 60
gkTuning,ihTuning	FLknob	"Tuning",      -1,    1,    0,    1,   idTuning,   70,   105, 60
gkCfBase, ihCfBase	FLknob	"Cutoff",       4,   14,    0,    1,   idCfBase,   70,   180, 60
gkCfEnv, ihCfEnv	FLknob	"Env.Mod.",     0,   10,    0,    1,   idCfEnv,    70,   255, 60
gkRes, ihRes		FLknob	"Resonance",    0, 0.98,    0,    1,   idRes,      70,   330, 60
gkDecay, ihDecay	FLknob	"Decay",        0.1,  5,   -1,    1,   idDecay,    70,   405, 60
gkAccent, ihAccent	FLknob	"Accent",       0,    1,    0,    1,   idAccent,   70,   480, 60
gkDist, ihDist		FLknob	"Distortion",   0,    1,    0,    1,   idDist,     70,   555, 60

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gkTempo, ihTempo	FLcount  "Tempo",	1,    500,    1,    10,     1,    150,     30,   150,  5,   -1

FLsetVal_i	2, ihVol
FLsetVal_i	0, ihTuning
FLsetVal_i	8.5, ihCfBase
FLsetVal_i	3.5, ihCfEnv
FLsetVal_i	0.5, ihRes
FLsetVal_i	0.37, ihDecay
FLsetVal_i	0.35, ihAccent
FLsetVal_i	0.2, ihDist
FLsetVal_i	110, ihTempo

;DELAY----------------------------------------------------------------------------------------------------------------
;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gkDelTimL, ihDelTimL	FLcount  "Delay Time L",	1,     8,    1,      10,     2,      85,     20,    650,   5,   -1
gkDelTimR, ihDelTimR	FLcount  "Delay Time R",	1,     8,    1,      10,     2,      85,     20,    650,  45,   -1

;KNOBS				LABEL        | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkDelSnd, ihDelSnd	FLknob	"Delay Send",   0,    1,    0,    1,     -1,    45,   650, 85
gkDelFB, ihDelFB	FLknob	"Delay F.B.",   0,    1,    0,    1,     -1,    45,   700, 85

FLsetVal_i	3, ihDelTimL
FLsetVal_i	5, ihDelTimR
FLsetVal_i	0.2, ihDelSnd
;---------------------------------------------------------------------------------------------------------------------

;REVERB---------------------------------------------------------------------------------------------------------------
;KNOBS				LABEL         | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkRvbSnd, ihRvbSnd	FLknob	"Reverb Send",   0,    1,    0,    1,     -1,    45,   750, 85
gkRvbFB, ihRvbFB	FLknob	"Reverb F.B.",   0, 0.99,    0,    1,     -1,    45,   800, 85

FLsetVal_i	0.2, ihRvbSnd
FLsetVal_i	0.8, ihRvbFB
;---------------------------------------------------------------------------------------------------------------------

#define	STEP(N)
#
;KNOBS				LABEL | MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkNote$N, gihNote$N	FLknob	"$N",    4,   12,    0,    3,     -1,    50,   ix,  iy+10

;TEXT INPUT		 		MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkpch$N, gihpch$N	FLtext	"", 	0,     20,    0,     1,     50,     20,  ix+2,  iy+75

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT |  X   |   Y    | OPCODE | INS | STARTTIM | IDUR
gkOn$N,gihOn$N		FLbutton	"",		1,    0,    3,     15,      15,   ix+17,  iy+100,    -1;0,      1,      0,       45
gkHold$N,gihHold$N	FLbutton	"",		1,    0,    3,     15,      15,   ix+17,  iy+115,    -1;0,      1,      0,       45
gkAcc$N,gihAcc$N	FLbutton	"",		1,    0,    3,     15,      15,   ix+17,  iy+130,    -1;0,      1,      0,       45

ix = ix + igap
#
ix = 45
iy = 170
igap = 60
$STEP(1)
$STEP(2)
$STEP(3)
$STEP(4)
$STEP(5)
$STEP(6)
$STEP(7)
$STEP(8)
$STEP(9)
$STEP(10)
$STEP(11)
$STEP(12)
$STEP(13)
$STEP(14)
$STEP(15)
$STEP(16)

FLsetVal_i	8.01, gihpch1
FLsetVal_i	8.06, gihpch2
FLsetVal_i	7.09, gihpch3
FLsetVal_i	8.10, gihpch4
FLsetVal_i	7.08, gihpch5
FLsetVal_i	7.11, gihpch6
FLsetVal_i	8.00, gihpch7
FLsetVal_i	8.02, gihpch8
FLsetVal_i	7.00, gihpch9
FLsetVal_i	8.09, gihpch10
FLsetVal_i	7.02, gihpch11
FLsetVal_i	7.03, gihpch12
FLsetVal_i	7.06, gihpch13
FLsetVal_i	8.05, gihpch14
FLsetVal_i	8.09, gihpch15
FLsetVal_i	8.01, gihpch16

FLsetVal_i	octpch(7.01), gihNote1
FLsetVal_i	octpch(8.06), gihNote2
FLsetVal_i	octpch(6.09), gihNote3
FLsetVal_i	octpch(8.10), gihNote4
FLsetVal_i	octpch(7.08), gihNote5
FLsetVal_i	octpch(7.11), gihNote6
FLsetVal_i	octpch(8.00), gihNote7
FLsetVal_i	octpch(6.02), gihNote8
FLsetVal_i	octpch(7.00), gihNote9
FLsetVal_i	octpch(6.09), gihNote10
FLsetVal_i	octpch(7.02), gihNote11
FLsetVal_i	octpch(8.03), gihNote12
FLsetVal_i	octpch(7.06), gihNote13
FLsetVal_i	octpch(6.05), gihNote14
FLsetVal_i	octpch(6.09), gihNote15
FLsetVal_i	octpch(6.01), gihNote16

FLsetVal_i	1, gihOn1
FLsetVal_i	0, gihOn2
FLsetVal_i	0, gihOn3
FLsetVal_i	1, gihOn4
FLsetVal_i	1, gihOn5
FLsetVal_i	1, gihOn6
FLsetVal_i	0, gihOn7
FLsetVal_i	1, gihOn8
FLsetVal_i	1, gihOn9
FLsetVal_i	0, gihOn10
FLsetVal_i	1, gihOn11
FLsetVal_i	0, gihOn12
FLsetVal_i	1, gihOn13
FLsetVal_i	1, gihOn14
FLsetVal_i	0, gihOn15
FLsetVal_i	1, gihOn16

FLsetVal_i	0, gihHold1
FLsetVal_i	0, gihHold2
FLsetVal_i	0, gihHold3
FLsetVal_i	1, gihHold4
FLsetVal_i	1, gihHold5
FLsetVal_i	0, gihHold6
FLsetVal_i	0, gihHold7
FLsetVal_i	1, gihHold8
FLsetVal_i	0, gihHold9
FLsetVal_i	0, gihHold10
FLsetVal_i	0, gihHold11
FLsetVal_i	0, gihHold12
FLsetVal_i	1, gihHold13
FLsetVal_i	1, gihHold14
FLsetVal_i	1, gihHold15
FLsetVal_i	0, gihHold16

FLsetVal_i	0, gihAcc1
FLsetVal_i	0, gihAcc2
FLsetVal_i	0, gihAcc3
FLsetVal_i	1, gihAcc4
FLsetVal_i	0, gihAcc5
FLsetVal_i	0, gihAcc6
FLsetVal_i	0, gihAcc7
FLsetVal_i	0, gihAcc8
FLsetVal_i	0, gihAcc9
FLsetVal_i	0, gihAcc10
FLsetVal_i	0, gihAcc11
FLsetVal_i	0, gihAcc12
FLsetVal_i	1, gihAcc13
FLsetVal_i	0, gihAcc14
FLsetVal_i	1, gihAcc15
FLsetVal_i	0, gihAcc16

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    220, 220, 220		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkWaveform, ihWaveform		FLbutBank	14,     1,     2,     18,      40,   370,10,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

FLpanel_end

FLcolor	255, 255, 255, 0, 0, 0
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 1000, 220, 0, 370
;TEXT BOXES												                                                      		TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                             Bassline (requires Csound 5.12 or higher)                                      ", 	1,      5,     14,    995,    15,     5,   0
ih		 	FLbox  	"----------------------------------------------------------------------------------------------------------------------------", 	1,      5,     14,    995,    15,     5,  20
ih		 	FLbox  	"This example is an emulation of a Roland TB303 Bassline step synthesizer. It makes use of Csound's looping envelopes lpshold", 	1,      5,     14,    995,    15,     5,  40
ih		 	FLbox  	"loopseg and looptseg to loop pitch, note on/off status, hold status and filter envelopes for each note. The filter used is  ", 	1,      5,     14,    995,    15,     5,  60
ih		 	FLbox  	"Csound's moogladder filter (this can be swapped with moogvcf2 if real-time performance is an issue). Distortion is          ", 	1,      5,     14,    995,    15,     5,  80
ih		 	FLbox  	"implemented using the 'clip' opcode. The pitch of each step is controlled by its own knob, the values of these are expressed", 	1,      5,     14,    995,    15,     5, 100
ih		 	FLbox  	"in Csound 'pch' format - middle C = 8.00, G above middle C = 8.07, C above middle C = 9.00 and so on.                       ", 	1,      5,     14,    995,    15,     5, 120
ih		 	FLbox  	"Each step has its own on/off switch and 'hold' switch. The hold function defeats a retriggering of the filter envelope to   ", 	1,      5,     14,    995,    15,     5, 140
ih		 	FLbox  	"create a smoother transition between notes. It will also activate a short 'glide' between pitches. 'Accent' switches        ", 	1,      5,     14,    995,    15,     5, 160
ih		 	FLbox  	"emphasise notes by boosting their amplitude, filter envelope amplitude and resonance (just as in the original 303).         ", 	1,      5,     14,    995,    15,     5, 180
ih		 	FLbox  	"A stereo delay and reverb effect are included. Delay times are defined in semiquavers.                                      ", 	1,      5,     14,    995,    15,     5, 200
				FLpanel_end

FLrun	;RUN THE FLTK WIDGET THREAD

;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 65536, 10, 1
;				1     2     3     4     5     6     7     8     9     10    11    12    13    14    15    16

opcode	moogladdersr,a,akk
	asig,kcf,kres	xin
		setksmps	1
	acf	interp	kcf
	kcf	downsamp	acf
	asig      moogladder   asig, kcf, kres
		xout	asig
endop

instr	1	;SENSE NOTE KNOBS
#define	NOTE(N)
	#
	koct$N	=	int(gkNote$N)		;DERIVE OCTAVE
	ksemi$N	=	frac(gkNote$N) * 0.12	;DERIVE PCH FORMAT INTERVAL ABOVE OCTAVE
	ksemi$N	=	int(ksemi$N*100) * 0.01	;CLEAN TO 2 DECIMAL PLACES
	kNote$N	=	koct$N + ksemi$N	;ADD OCTAVE TO SEMITONES
	ktrig$N	changed	kNote$N			;IF PCH HAS CHANGED GENERATE A TRIGGER
	if ktrig$N=1	then			;IF PCH VALUE HAS CHANGED...
		event "i", 2, 0, 0.01, kNote$N, $N
		ktrig$N=0			;PREVENT REITERATION
	endif					;END OF THIS CONDITIONAL BRANCH
	#
	$NOTE(1)				;EXPAND MACRO
	$NOTE(2)				;EXPAND MACRO
	$NOTE(3)				;EXPAND MACRO
	$NOTE(4)				;EXPAND MACRO
	$NOTE(5)				;EXPAND MACRO
	$NOTE(6)				;EXPAND MACRO
	$NOTE(7)				;EXPAND MACRO
	$NOTE(8)				;EXPAND MACRO
	$NOTE(9)				;EXPAND MACRO
	$NOTE(10)				;EXPAND MACRO
	$NOTE(11)				;EXPAND MACRO
	$NOTE(12)				;EXPAND MACRO
	$NOTE(13)				;EXPAND MACRO
	$NOTE(14)				;EXPAND MACRO
	$NOTE(15)				;EXPAND MACRO
	$NOTE(16)				;EXPAND MACRO
endin

instr	2	;UPDATE NOTE VALUE DISPLAYS
#define	PRINTVAL(N)
	#
	if p5=$N then
		FLsetVal_i	p4, gihpch$N
	endif
	#
	$PRINTVAL(1)
	$PRINTVAL(2)
	$PRINTVAL(3)
	$PRINTVAL(4)
	$PRINTVAL(5)
	$PRINTVAL(6)	
	$PRINTVAL(7)	
	$PRINTVAL(8)	
	$PRINTVAL(9)	
	$PRINTVAL(10)	
	$PRINTVAL(11)	
	$PRINTVAL(12)	
	$PRINTVAL(13)	
	$PRINTVAL(14)	
	$PRINTVAL(15)	
	$PRINTVAL(16)
endin


instr	3	;BASSLINE INSTRUMENT
	if gkOnOff=0 then			;IF START/STOP IS OFF...
		turnoff				;TURN THIS INSTRUMENT OFF
	endif					;END OF CONDITIONAL
	kPhFreq   =            gkTempo/240	;FREQUENCY WITH WHICH TO REPEAT THE ENTIRE PHRASE
	kBtFreq   =            gkTempo/15	;FREQUENCY OF EACH 1/16TH NOTE
	kNewNote	metro	kBtFreq		;GENERATES A TRIGGER FOR EACH BEAT
	kporttime	linseg	0,0.001,0.01	;PORTAMENTO TIME RAMPS UP QUICKLY FROM ZERO TO A HELD VALUE
	;ENVELOPES WITH HELD SEGMENTS        NOTE:1         2         3         4         5         6         7         8         9         10         11         12         13         14         15         16           DUMMY
	kPchLoop  lpshold      kPhFreq, 0,        0,gkpch1, 1,gkpch2, 1,gkpch3, 1,gkpch4, 1,gkpch5, 1,gkpch6, 1,gkpch7, 1,gkpch8, 1,gkpch9, 1,gkpch10, 1,gkpch11, 1,gkpch12, 1,gkpch13, 1,gkpch14, 1,gkpch15, 1,gkpch16,   1,gkpch1	;NEED AN EXTRA 'DUMMY' VALUE
	kOn       lpshold      kPhFreq, 0,        0,gkOn1,  1,gkOn2,  1,gkOn3,  1,gkOn4,  1,gkOn5,  1,gkOn6,  1,gkOn7,  1,gkOn8,  1,gkOn9,  1,gkOn10,  1,gkOn11,  1,gkOn12,  1,gkOn13,  1,gkOn14,  1,gkOn15,  1,gkOn16,     1,1		;NEED AN EXTRA 'DUMMY' VALUE
	kAcc      lpshold      kPhFreq, 0,        0,gkAcc1, 1,gkAcc2, 1,gkAcc3, 1,gkAcc4, 1,gkAcc5, 1,gkAcc6, 1,gkAcc7, 1,gkAcc8, 1,gkAcc9, 1,gkAcc10, 1,gkAcc11, 1,gkAcc12, 1,gkAcc13, 1,gkAcc14, 1,gkAcc15, 1,gkAcc16,     1,1		;NEED AN EXTRA 'DUMMY' VALUE
	kHoldLoop lpshold      kPhFreq, 0,        0,gkHold1,1,gkHold2,1,gkHold3,1,gkHold4,1,gkHold5,1,gkHold6,1,gkHold7,1,gkHold8,1,gkHold9,1,gkHold10,1,gkHold11,1,gkHold12,1,gkHold13,1,gkHold14,1,gkHold15,1,gkHold16,   1,0		;NEED AN EXTRA 'DUMMY' VALUE
	kNewOn	trigger	kOn,0.5,0	;SENSE A NOTE ON FOLLOWING A NOTE OFF
	kAcc	portk	kAcc*gkAccent,kporttime	;SCALE ACCENT USING ON-SCREEN KNOB AND SMOOTH CHANGES IN ACCENT VALUE TO PREVENT CLICKS
	
	;IGNORE PITCH VALUES AND HOLD VALUES FOR 'OFF' NOTES
	kPch	init	i(gkpch1)
	if kOn==1 then			;IF THIS IS AN 'ON' NOTE...
	 kPch = kPchLoop		;USE NOTE LOOP VALUE FOR PCH
	 kHold = kHoldLoop		;USE HOLD LOOP VALUE FOR HOLD
	endif
	
	kHoldDel  vdel_k       kHold, 1/(kBtFreq*2), 1	;OFFSET HOLD SO THAT ITS VALUE WILL OVERLAP THE NEXT NOTE
	kOct      portk        octpch(kPch), 0.01*kHoldDel*kOn	;APPLY PORTAMENTO TO PITCH CHANGES - IF NOTE IS NOT HELD, NO PORTAMENTO WILL BE APPLIED
		
	;FILTER ENVELOPE
	kFiltRetrig	=	(1-kHoldDel) * kNewNote * kOn ; + kOnTrig
	;CREATE A FILTER CUTOFF FREQUENCY ENVELOPE. FILTER ATTACK LEVEL IS A SUM OF BASE FREQUENCY, ENVELOPE DEPTH AND ACCENT
	kCfOct	  loopseg	1/3600, kFiltRetrig+kNewOn, 0, gkCfBase+gkCfEnv+(kAcc*2), gkDecay, gkCfBase, 3600-gkDecay, gkCfBase
	kCfOct    limit        kCfOct, 4, 14	;LIMIT THE CUTOFF FREQUENCY TO BE WITHIN SENSIBLE LIMITS

	;AMPLITUDE ENVELOPE - SEPARATES NOTES THAT ARE NOT HELD
	katt	=	0.02 * (60/gkTempo)
	kdec	=	0.02 * (60/gkTempo)
	kAmpEnv   loopseg      kBtFreq, 0,    0,0,  katt,1,  (1/kBtFreq)-katt-kdec,1,  kdec,0	;SUSTAIN SEGMENT DURATION (AND THEREFORE ATTACK AND DECAY SEGMENT DURATIONS) ARE DEPENDENT UPON TEMPO
	kAmp	=	(kHoldDel==1?1:kAmpEnv)
	
	;AUDIO OSCILLATOR
	kWavTrig  changed      gkWaveform		;GENERATE A 'BANG' IF WAVEFORM SELECTOR CHANGES
	if kWavTrig=1 then				;IF A 'BANG' HAS BEEN GENERATED...
	 reinit REINIT_VCO				;BEGIN A REINITIALIZATION PASS FROM THE LABEL 'REINIT_VCO'
	endif
	REINIT_VCO:							;A LABEL
	aSig      vco2         0.2, cpsoct(kOct)*semitone(gkTuning), i(gkWaveform)*2, 0.5	;GENERATE AUDIO USING VCO OSCILLATOR
	rireturn							;RETURN FROM INITIALIZATION PASS TO PERFORMANCE PASSES

	;FILTER (CALLS UDO: A VERSION OF moogladder IN WHICH CUTOFF FREQUENCY IS MODULATED AT kr=sr) IN ORDER TO PREVENT QUANTISATION NOISE)
	kres	limit	gkRes+(kAcc*0.4),0,0.98				;PREVENT EXCESSIVE RESONANCE THAT COULD RESULT FROM THE COMBINATION OF RESONANCE SETTING AND ACCENTING
	aFilt      moogladdersr   aSig, cpsoct(kCfOct), kres		;FILTER AUDIO 
	aFilt	buthp	aFilt,50
	aSig	balance	aFilt,aSig
	; DISTORTION
	if gkDist==0 kgoto SKIP_DISTORTION 
	iSclLimit ftgentmp     0, 0, 1024, -16, 1, 1024,  -8, 0.01	;RESCALING CURVE FOR CLIP 'LIMIT' PARAMETER
	iSclGain  ftgentmp     0, 0, 1024, -16, 1, 1024,   4, 10	;RESCALING CURVE FOR GAIN COMPENSATION
	kLimit    table        gkDist, iSclLimit, 1			;READ LIMIT VALUE FROM RESCALING CURVE
	kGain     table        gkDist, iSclGain, 1			;READ GAIN VALUE FROM RESCALING CURVE
	kTrigDist changed      kLimit					;IF LIMIT VALUE CHANGES GENERATE A 'BANG'
	if kTrigDist=1 then						;IF A 'BANG' HAS BEEN GENERATED...
		reinit REINIT_CLIP					;BEGIN A REINITIALIZATION PASS FROM LABEL 'REINIT_CLIP'
	endif
	REINIT_CLIP:
	aSig      clip         aSig, 0, i(kLimit)			;CLIP DISTORT AUDIO SIGNAL
	rireturn							;
	aSig      =            aSig * kGain				;COMPENSATE FOR GAIN LOSS FROM 'CLIP' PROCESSING
	SKIP_DISTORTION:
	
	kOn       port         kOn, 0.006				;SMOOTH CHANGES IN ON OFF SWITCHING
	aAmp	interp	((kAmp*kOn)*((kAcc*0.7)+1)*gkVol)		;COMBINE ALL FACTORS THAT CONTRIBUTE TO AMPLITUDE AND INTERPOLATE AND CREATE AN A-RATE VERSION OF THIS RESULT (TO PREVENT QUANTISATION NOISE) 
	aSig	=	aSig * aAmp					;SCALE AUDIO USING AMPLITUDE CONTROL FUNCTION
		outs	aSig, aSig     					;AUDIO SENT TO OUTPUT, APPLY AMP. ENVELOPE, VOLUME CONTROL AND NOTE ON/OFF STATUS
	gaDelSnd	=	aSig * gkDelSnd				;SEND SOME AUDIO TO THE DELAY
	gaRvbSndL	=	aSig * gkRvbSnd				;SEND SOME AUDIO TO THE REVERB
	gaRvbSndR	=	gaRvbSndL				;THIS IS A MONO INPUT SIGNAL SO SEND THE SAME SIGNAL TO REVERB RIGHT CHANNEL
endin

instr	10	;Delay
	kDelTimL	limit	(gkDelTimL * 60) / (gkTempo * 4), 0.001, 9.99	;DERIVE DELAY TIME IN SECONDS
	kDelTimR	limit	(gkDelTimR * 60) / (gkTempo * 4), 0.001, 9.99
	aDelTimL	interp	kDelTimL					;CREATE INTERPOLATED A-RATE DELAY TIME VALUES
	aDelTimR	interp	kDelTimR
	aBuffer		delayr	10					;LEFT CHANNEL
	atapL		deltap3	aDelTimL
			delayw	gaDelSnd + (atapL * gkDelFB)
	aBuffer		delayr	10					;RIGHT CHANNEL
	atapR		deltap3	aDelTimR
			delayw	gaDelSnd + (atapR * gkDelFB)
			outs	atapL, atapR				;SEND DELAY EFFECT AUDIO TO OUTPUTS
	gaRvbSndL	=	gaRvbSndL + (atapL * gkRvbSnd)		;SEND SOME OF THE DELAY OUTPUT TO REVERB
	gaRvbSndR	=	gaRvbSndR + (atapR * gkRvbSnd)
			clear	gaDelSnd				;CLEAR DELAY SEND AUDIO SIGNAL
endin

instr	11	;REVERB
	aRvbL, aRvbR	reverbsc	gaRvbSndL, gaRvbSndR, gkRvbFB, 10000	;CREATE REVERB SIGNAL
			outs		aRvbL, aRvbR				;SEND REVERB AUDIO TO OUTPUTS
			clear		gaRvbSndL, gaRvbSndR			;CLEAR REVERB SEND VARIABLES
endin

instr	99						;SHIFT NOTES DEPENDING ON RECEIVED p4 VALUE
;CREATE A MACRO FOR CONVENIENCE
#define	SHIFT_NOTE(N)	
	#
	iNote	limit	i(gkNote$N)+p4,4,12	;SHIFT MIDI NOTES AND LIMIT TO BE WITHIN ACCEPTABLE LIMITS
	FLsetVal_i	iNote,gihNote$N		;WRITE NEW NOTE NUMBER VALUE TO FL WIDGET
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
	$SHIFT_NOTE(9)
	$SHIFT_NOTE(10)
	$SHIFT_NOTE(11)
	$SHIFT_NOTE(12)
	$SHIFT_NOTE(13)
	$SHIFT_NOTE(14)
	$SHIFT_NOTE(15)
	$SHIFT_NOTE(16)
endin

instr	100
#define	CLEAR_WIDGETS(N)
	#
	FLsetVal_i	8,gihpch$N
	FLsetVal_i	8,gihNote$N
	FLsetVal_i	0,gihOn$N
	FLsetVal_i	0,gihHold$N
	FLsetVal_i	0,gihAcc$N
	#
	$CLEAR_WIDGETS(1) 
	$CLEAR_WIDGETS(2) 
	$CLEAR_WIDGETS(3) 
	$CLEAR_WIDGETS(4) 
	$CLEAR_WIDGETS(5) 
	$CLEAR_WIDGETS(6) 
	$CLEAR_WIDGETS(7) 
	$CLEAR_WIDGETS(8) 
	$CLEAR_WIDGETS(9) 
	$CLEAR_WIDGETS(10)
	$CLEAR_WIDGETS(11)
	$CLEAR_WIDGETS(12)
	$CLEAR_WIDGETS(13)
	$CLEAR_WIDGETS(14)
	$CLEAR_WIDGETS(15)
	$CLEAR_WIDGETS(16)
endin

instr	101
#define	RANDOMISE_WIDGETS(N)
	#
	inote	random	36,60
	FLsetVal_i	pchmidinn(int(inote)),gihpch$N
	FLsetVal_i	octmidinn(int(inote)),gihNote$N
	FLsetVal_i	int(rnd(1.999)),gihOn$N
	FLsetVal_i	int(rnd(1.999)),gihHold$N
	FLsetVal_i	int(rnd(1.999)),gihAcc$N
	#
	$RANDOMISE_WIDGETS(1) 
	$RANDOMISE_WIDGETS(2) 
	$RANDOMISE_WIDGETS(3) 
	$RANDOMISE_WIDGETS(4) 
	$RANDOMISE_WIDGETS(5) 
	$RANDOMISE_WIDGETS(6) 
	$RANDOMISE_WIDGETS(7) 
	$RANDOMISE_WIDGETS(8) 
	$RANDOMISE_WIDGETS(9) 
	$RANDOMISE_WIDGETS(10)
	$RANDOMISE_WIDGETS(11)
	$RANDOMISE_WIDGETS(12)
	$RANDOMISE_WIDGETS(13)
	$RANDOMISE_WIDGETS(14)
	$RANDOMISE_WIDGETS(15)
	$RANDOMISE_WIDGETS(16)
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;SCAN FOR NOTE KNOB CHANGES
i 10 0 3600	;DELAY
i 11 0 3600	;REVERB
</CsScore>

</CsoundSynthesizer>