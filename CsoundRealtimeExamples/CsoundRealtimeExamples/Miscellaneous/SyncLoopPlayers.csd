SyncLoopPlayers.csd
Written by Iain McCurdy 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -d -m0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	4
nchnls 	= 	1
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH
zakinit	64,64		;INITIALISE ZAK SPACE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 255, 50
		FLpanel	"SyncLoopPlayers", 840, 300, 0, 0

;BUTTONS                                     	ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | I | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"@DnArrow",	1,    0,    22,    100,     25,    5,   5,   0,      2,     0,      -1                           

#define	LOOP_GUI(N'NBars'PchMod)
#
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihname$N		 	FLbox  	"    ", 	6,      1,     10,     96,    25,     2,  iy
;BUTTONS                                     				ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | I | STARTTIM | IDUR
gkLoop,gihLoop$N		FLbutton	"@>",			1,    0,    22,     40,     25,  105, iy,   0,      1,     0,      3600,  $N
gkPch,ihPch$N			FLbutton	"Pitch Correction",	1,    0,    22,     80,     30,  225, iy,   0,     99,     0,         0,  $N

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
;				FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkfftsize, ihfftsize$N		FLbutBank	1,      2,     1,     120,     17,  305, iy,     0,    103,  0,   0,  $N 
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
;			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"PITCHED", 	1,      1,     10,     60,     10,  305,  iy+18
ih		 	FLbox  	"UNPITCHED",	1,      1,     10,     60,     10,  365,  iy+18


FLsetTextSize	11,ihPch$N
;KOUT | HANDLE		FLTEXT	"LABEL"   | MIN | MAX | STEP | TYPE | WIDTH | HEIGHT |  X | Y
gkDelay$N, ihDelay$N	FLtext	"Delay $N", -0.01, 0.01, 0.001,   1,     60,     25,   160, iy
;SLIDERS						MIN  | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X   | Y
gkGain$N, ihGain$N		FLslider	"Gain",  0,     1,    0,    5,     -1,    100,     20,   430,   iy
;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE            p4  p5(IDENTIFIER)
gkNBars,ihNBars$N	FLcount		"Num.Bars",	1,    999,    1,      1,      2,    100,     22,     535,     iy,      0,    101, 0,0, $N,  1
gkRRpts,ihRRpts$N	FLcount		"Rate.Rpts",	1,     32,    1,      1,      2,    100,     22,     635,     iy,      0,    101, 0,0, $N,  2
gktrans,ihtrans$N	FLcount		"Transpose",	-24,   24,    1,      1,      2,    100,     22,     735,     iy,      0,    101, 0,0, $N,  3
		FLsetVal_i	0, 	ihDelay$N
		FLsetVal_i	0.75, 	ihGain$N
		FLsetVal_i	$NBars,	ihNBars$N
		FLsetVal_i	1,	ihRRpts$N
		FLsetVal_i	0,	ihtrans$N
		FLsetVal_i	$PchMod,ihfftsize$N
iy	=	iy+50
#
iy	=	100	
$LOOP_GUI(1'2'1)
$LOOP_GUI(2'2'1)
$LOOP_GUI(3'12'0)
$LOOP_GUI(4'1'1)
;***ADD FURTHER ROWS FOR ADDITIONAL LAYERS***








;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE
gkTempo,ihTempo 		FLcount		"Tempo",	1,    999,   0.01,    1,      1,    120,     25,     110,      5,      -1
gkBeatsPerBar,ihBeatsPerBar 	FLcount		"Beats per Bar",1,      4,      1,    1,      2,     90,     25,     235,      5,      -1

;SLIDERS								MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkMetroGain, ihMetroGain	FLslider	"Metronone Vol.",	0,     1,  0,       5,     -1,       220,     15,     5,    65
gkOutGain, ihOutGain		FLslider	"Output Level",		0,     1,  0,       5,     -1,       100,     20,   430,    50
gkFlash, gihFlash1		FLslider	"",			0,     1,  0,       2,     -1,        55,     15,     5,    50
gkFlash, gihFlash2		FLslider	"",			0,     1,  0,       2,     -1,        55,     15,    60,    50
gkFlash, gihFlash3		FLslider	"",			0,     1,  0,       2,     -1,        55,     15,   115,    50
gkFlash, gihFlash4		FLslider	"",			0,     1,  0,       2,     -1,        55,     15,   170,    50
FLsetColor	100,100,50,gihFlash1
FLsetColor	100,100,50,gihFlash2
FLsetColor	100,100,50,gihFlash3
FLsetColor	100,100,50,gihFlash4

		FLsetVal_i	90, 	ihTempo
		FLsetVal_i	0.5, 	ihMetroGain
		FLsetVal_i	0.7, 	ihOutGain
		FLsetVal_i	4, 	ihBeatsPerBar

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 840, 180, 0, 370
;TEXT BOXES																	TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                             Sync Loop Players                                          ",	1,      5,     14,    840,    20,     0,   0
ih		 	FLbox  	"--------------------------------------------------------------------------------------------------------",	1,      5,     14,    840,    20,     0,  20
ih		 	FLbox  	"The example presents a framework within which sample and loops can be started and stopped and synced to ", 	1,      5,     14,    840,    20,     0,  40
ih		 	FLbox  	"a metrical clock in a manner similar to that employed by Ableton Live.                                  ", 	1,      5,     14,    840,    20,     0,  60
ih		 	FLbox  	"The code is designed in such a way as to be easily expandable to incorporate additional layers.         ", 	1,      5,     14,    840,    20,     0,  80
ih		 	FLbox  	"Loops can be transposed to retain their original pitch ('Pitch Correction') with two modes available to ", 	1,      5,     14,    840,    20,     0, 100
ih		 	FLbox  	"optimise sound quality for pitched or unpitched sounds. Loops can also be manually transposed in        ", 	1,      5,     14,    840,    20,     0, 120
ih		 	FLbox  	"semitone steps. The length of loops can be adjusted ('Num.Bars') and the periodicity with which they    ", 	1,      5,     14,    840,    20,     0, 140
ih		 	FLbox  	"repeat ('Rate Rpts.'). 'Delay' can be used to fine tune the sync. between loops.                        ", 	1,      5,     14,    840,    20,     0, 160
		FLpanel_end
		FLrun		;RUN THE WIDGET THREAD!	
		
gisine		ftgen	0,0,4096,10,1	;A SINE WAVE (USED BY THE METRONOME)
gkBarTimer	init	0		;BAR TIMER

/*CREATE STRING VARIABLES FOR FILE NAMES TO PREVENT HAVING TO RE-TYPE FILE NAMES MULTIPLE TIMES IN THE CODE*/
gSfile1	=	"loop.wav"
gSfile2	=	"808LoopMono.wav"
gSfile3	=	"SynthPad.wav"
gSfile4	=	"Bounce.wav"
;***ADD ADDITIONAL FILES***




/*FUNCTION TABLES USED TO STORE SOUND FILES*/
gifile1		ftgen	0,0,262144,1,gSfile1,0,0,1
gifile2		ftgen	0,0,524288,1,gSfile2,0,0,1	
gifile3		ftgen	0,0,1048576,1,gSfile3,0,0,1	
gifile4		ftgen	0,0,1048576,1,gSfile4,0,0,1	
;***ADD ADDITIONAL FUNCTION TABLES***




/*DATA STORAGE FOR ATTRIBUTES FOR EACH ROW. YOU CAN SET DEFAULT VALUES HERE.*/
giNBars		ftgen	0,0,128,-2,2,2,8,1			;TABLE FILLED WITH '1' VALUES
giRRpts		ftgen	0,0,128,-2,2,2,8,1			;TABLE FILLED WITH '1' VALUES
gitranss	ftgen	0,0,128,-2,0				;TABLE FILLED WITH '1' VALUES
giOnOffs	ftgen	0,0,128,2,0				;ON OFF STATUS FOR EACH LOOP. 1=ON 0=OFF
giPitches	ftgen	0,0,128,2,0				;PITCH CORRECTION STATUSES. 1=ON 0=OFF
giGains		ftgen	0,0,128,-17,0,0.7			;GAIN LEVELS. DEFAULT: ALL GAINS SET TO 0.7
giFFTSizes	ftgen	0,0,128,-2,1,1,0,1			;FFT SIZES

instr	2	;TURNS ON THE QUANTIZER
	giBeatsPerBar	init	i(gkBeatsPerBar)			;NUMBER OF BEATS PER BAR
	gkTempoClock	init	0					;INITIALISE VARIABLE FOR MAIN CLOCK	
	kBarFlag	init	1					;AN IMPULSE THAT INDICATED THE BEGINNING OF EACH BAR 
	if gkOnOff=0 then						;IF QUANTIZER IS OFF
	  turnoff							;TURN THIS INSTRUMENT OFF
	endif								;END OF CONDITIONAL BRANCH
	gkBeatTrigger	metro		gkTempo/60			;GENERATES AN IMPULSE ON EVERY BEAT
	kBeatDur	=		60/gkTempo			;DERIVE THE DURATION OF A BEAT
	gkBarTrigger	=		gkBeatTrigger*int(kBarFlag)	;NEW BAR TRIGGER: WHEN BAR FLAG IS '1', BUT ONLY ON A BEAT TO ENSURE THERE IS JUST A SINGLE IMPULSE
	if gkBarTrigger=1 then						;IF WE ARE AT THE BEGINNING OF A NEW BAR...
	  reinit START_BAR						;REINITIALISE FROM LABEL 'START_BAR'. I.E. RESTART BAR TIMER
	endif								;END OF CONDITIONAL BRANCH
	START_BAR:							;LABEL 'START_BAR'. REINITIALISATION OF THE BAR TIMER STARTS FORM HERE
	gkBarTimer	line	0,i(kBeatDur)*giBeatsPerBar,1		;TIMER RUNS FROM 0 TO 1 FOR THE REQUIRED NUMBER OF BEATS PER BAR
	rireturn							;RETURN FROM REINITIALISATION

	kBeatCount	init	giBeatsPerBar				;LOCATION OF WHAT BEAT WE ARE CURRENTLY ON (IT WILL BE IMMEDIATELY INCREMENTED SO START ON THE LAST BEAT)
	if gkBeatTrigger=1 then 					;IF A BEAT IMPULSE IS RECEIVED
	  kBarFlag	wrap	(kBarFlag+(1/giBeatsPerBar)),(1/giBeatsPerBar),1+(1/giBeatsPerBar)		;INCREMENT BAR FLAG BY BEAT FRACTION OF BAR AND WRAP 
	  kBeatCount	wrap	kBeatCount+1,1,giBeatsPerBar+1		;INCREMENT BEAT COUNTER AND WRAP AROUND TO THE BEGINNING OF THE BAR WHE REQUIRED
	  reinit BEAT
	endif
	BEAT:
		FLsetVal_i	i(gkBeatTrigger),gihFlash1+i(kBeatCount)-1	;TURN FLASH INDICATOR ON
	aenv	linseg		0,0.001,1,0.005-0.001,0	;PERCUSSIVE ENVELOPE
	afreq	expon		4000,0.005,20		;PITCH OF TONE (VERY FAST GLISS)
	rireturn
	asig	oscili	gkMetroGain*aenv*gkOutGain,afreq,gisine	;CREATE AUDIO FOR METRONOME 'CLICK'
		out	asig				;SEND AUDIO TO OUPUT

	kOffTrig	delayk	gkBeatTrigger,0.1		;OFF TRIGGER (FOR FLASH INDICATOR) DELAYED WITH RESPECT TO ON TRIGGER
	if kOffTrig=1 then					;IF OFF TRIGGER IS RECEIVED...
	  reinit TURN_OFF_FLASH					;REINIT FROM TURNOFF FLASH
	endif							;END OF CONDITIONAL BRANCH
	TURN_OFF_FLASH:						;LABEL. BEGIN REINITIALISATION FROM HERE
	FLsetVal	kOffTrig,0,gihFlash1+i(kBeatCount)-1	;TURN OFF FLASH INDICATOR
	rireturn						;RETURN FORM REINITIALISATION
endin

instr	3	;TIMER INSTRUMENT RUNS FOR 1 BAR
	gkBarTimer	line	0,p3,1	;TIMER RUNS FROM 0 TO 1 FOR 1 BEAT
endin

instr	1	;FLTK LOOP SWITCH TRIGGERED INSTRUMENT
		tableiw	i(gkLoop),p4-1,giOnOffs			;WRITE ON/OFF STATUS TO THE APPROPRIATE TABLE (AT I-TIME)
	if i(gkLoop)=0 then
	  turnoff
	endif
	
	iTime		init	frac(i(gkBarTimer))		;DURATION (AS A FRACTION OF A UNIT) THROUGH THE CURRENT QUANTIZE UNIT
	iDelay		=	(1-iTime+i(gkDelay1)) * ((60*giBeatsPerBar)/(i(gkTempo)) )	;REQUIRED DELAY TO SHIFT ONTO NEXT QUANTIZE POINT

			timout 0, iDelay*i(gkOnOff), PAUSE	;THIS LINE WILL DELAY THE SOUND PRODUCING PART OF THE INSTRUMENT BY JUMPING TO LABEL 'PAUSE' - 
	;		    p1 p2 p3    p4
		event	"i",6, 0, 3600, p4
		turnoff
	PAUSE:
endin

instr	6	;SOUND PRODUCING INSTRUMENT
	iRRpts	tablei	p4-1,giRRpts
	irel	init	0.1			;AMPLITUDE RELEASE TIME
	iNBars	tablei	p4-1,giNBars		;LENGTH OF LOOP IN BARS
	ktrans	tablei	p4-1,gitranss		;TRANSPOSITION
	kOnOff	table	p4-1,giOnOffs
	ifn	=	gifile1+p4-1		;FUNCTION TABLE FOR THE APPROPRIATE LAYER
	iNSamps	=	nsamp(ifn)		;LENGTH OF LOOP (IN SAMPLES)
	aptr	phasor	gkTempo/(60*giBeatsPerBar*iNBars*iRRpts)	;TEMPO DIVIDED BY (N.SECONDS_IN_MINUTE * BEATS_PER_BAR * N.BARS_IN_LOOP)
	
	kDurCycle	=	(60*giBeatsPerBar*iNBars)/gkTempo	;DURATION OF A CYCLE OF THE LOOP PLAYING
	ktimer	downsamp	(aptr*iNBars*giBeatsPerBar*60)/gkTempo

	aptr	limit	aptr*iNSamps*iRRpts, 0, iNSamps
	
	if kOnOff=0&&(ktimer>(kDurCycle-irel)) then	;IF ON/OFF BUTTON FOR THIS LOOP IS OFF *AND* IF LOOP HAS REACHED THE END... 
	  turnoff					;...TURN THIS LOOP PLAYER OFF
	endif
	
	asig	table3	aptr,ifn			;READ AUDIO FROM GEN01 TABLE USING POINTER
	
	kPitch	table	p4-1,giPitches			;READ WHETHER THIS LOOP PLAYER SHOULD BE 'PITCH CORRECTED'
	
	if kPitch=1 then
	  kFFTSize	table	p4-1, giFFTSizes	;READ iFFTSize (I.E. 'PITCHED/UNPITCHED') FOR THIS LOOP PLAYER FROM TABLE
	  
	  ktrig		changed	kFFTSize
	  ktrig	init	1
	  if ktrig==1 then
	    reinit update
	  endif
	  update:
	  iFFTSize	=	(i(kFFTSize)=0?2048:256)				;DERIVE ACTUAL FFT SIZE FROM 0/1 SWITCH
	  asig		mincer	(aptr/sr), 1, 1, ifn, 0, iFFTSize, 4	;APPLY PITCH CORRECTION
	  rireturn
	endif
	if ktrans!=0 then
	 fsig1	pvsanal	asig,1024,256,1024,1	;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.
	 fsig2	pvscale	fsig1,semitone(ktrans)
	 asig	pvsynth	fsig2
	endif
	aenv	linsegr	0,0.001,1,irel,0	;ANTI-CLICK
		zaw	asig*aenv, p4		;WRITE LOOP PLAYER AUDIO INTO ZAK CHANNEL
endin

instr	99	;UPDATE	PITCH WRITE STATUS
	tableiw	i(gkPch),p4-1,giPitches	;WRITE PITCH STATUS TO TABLE
endin

instr	101	;UPDATE	NUMBER OF BARS TABLE ITEM
	if p5==1 then
	  itime	times
	  if itime<0.1 goto SKIP
	  tableiw	i(gkNBars),p4-1,giNBars		;WRITE NUMBER OF BARS VALUE TO TABLE
	  SKIP:
	elseif p5==2 then
	  tableiw	i(gkRRpts),p4-1,giRRpts		;WRITE NUMBER OF BARS VALUE TO TABLE
	elseif p5==3 then
	  tableiw	i(gktrans),p4-1,gitranss	;WRITE TRANSPOSITION TO TABLE
	endif
endin

instr	102	;WRITE SOUND FILE NAMES INTO GUI
	FLsetText	gSfile1,gihname1
	FLsetText	gSfile2,gihname2
	FLsetText	gSfile3,gihname3
	FLsetText	gSfile4,gihname4
	;***ADD ADDITIONAL FILE NAMING STATEMENTS AS REQUIRED***
	
	
endin

instr	103	;UPDATE FFT SIZE TABLE
	itime	times
	if itime>0.1 then
		tableiw	i(gkfftsize),p4-1,giFFTSizes
	endif
endin

instr	999	;AUDIO MIXING AND OUTPUT (ALWAYS ON)
	amix	init	0
#define	CHANNEL(N)
	#
	asig	zar	$N
	amix	=	amix+(asig*gkGain$N)
	#
	$CHANNEL(1)
	$CHANNEL(2)
	$CHANNEL(3)
	$CHANNEL(4)
	;***ADD ADDITIONAL MIX CHANNELS AS REQUIRED***
	
	
	
	
		out	amix*gkOutGain
		clear	amix
endin


</CsInstruments>

<CsScore>
i 102 0 0	;WRITE SOUNDFILE NAMES AT STARTUP
i 999 0 3600	;AUDIO MIXING AND OUTPUT
</CsScore>

</CsoundSynthesizer>