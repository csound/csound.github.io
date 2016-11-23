Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	1
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	210, 210, 255, 0, 0, 0	;SET INTERFACE COLOURS
		FLpanel	" ", 530, 300, 0, 0
;                                             		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR |  p4
gkOnOff,ihOnOff	FLbutton	"Play/Stop",		1,    0,    22,    100,     25,    5,  5,   0,      1,     0,       -1
gkClear,ihClear	FLbutton	"Clear All",		1,    0,    21,     80,     25,  235,  5,   0,    102,     0,       0.01

FLsetColor	190, 190, 190, ihOnOff		;SET PRIMARY COLOUR TO GREY
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;COUNTERS				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | OPCODE
gkBPM,ihBPM 	FLcount		"BPM",	1,    999,    1,     10,     21,   120,     25,     110,      5,     -1
FLsetColor	255, 255, 255, ihBPM		;SET SECONDARY COLOUR TO WHITE

;BORDERS					ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 		5,        9,    15,    80,    125,    98, 68
ih		 	FLbox  	" ", 		5,        9,    15,    80,    125,   178, 68
ih		 	FLbox  	" ", 		5,        9,    15,    80,    125,   258, 68
ih		 	FLbox  	" ", 		5,        9,    15,    80,    125,   338, 68
ih		 	FLbox  	"G A I N", 	1,        9,    15,   100,     20,   420, 22

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"       Kick",	1,      5,     13,     90,     12,     0,  73
ih		 	FLbox  	"    Kalimba",	1,      5,     13,     90,     12,     0,  93
ih		 	FLbox  	"      Snare",	1,      5,     13,     90,     12,     0, 113
ih		 	FLbox  	"H.H. Closed",	1,      5,     13,     90,     12,     0, 133
ih		 	FLbox  	"  H.H. Open",	1,      5,     13,     90,     12,     0, 153
ih		 	FLbox  	" Tambourine",	1,      5,     13,     90,     12,     0, 173

;SLIDERS			            			MIN  |  MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkswing, ihswing		FLslider 	"Swing",	0,    0.125,   0,    3,     -1,   100,      15,  320,   5
gkMasterGain, ihMasterGain	FLslider 	"Master",	0,        1,   0,    3,     -1,   100,      15,  420,  42
gkphs, gihphs			FLslider 	"",		0,        1,   0,    1,     -1,   305,       9,  106,  58
gkamp1, ihamp1			FLslider 	"",		0,        1,   0,    4,     -1,    15,      95,  100, 200
FLsetColor2	0,255,0,gihphs
FLsetColor	255, 255, 255, ihMasterGain		;SET PRIMARY COLOUR TO WHITE

iy	init	50	;Y OFFSET
#define	ROW(COUNT)	#iy	=	iy+20
;                                             	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE |   I     | STARTTIM | IDUR | p4(Row Counter) | p5 (Column Counter)
gkval,gih$COUNT._01	FLbutton	"",	1,    0,    4,     20,     20,    100, iy,   0,       10,        0,        0,       $COUNT,         1 
gkval,gih$COUNT._02	FLbutton	"",	1,    0,    4,     20,     20,    120, iy,   0,       10,        0,        0,       $COUNT,         2  
gkval,gih$COUNT._03	FLbutton	"",	1,    0,    4,     20,     20,    140, iy,   0,       10,        0,        0,       $COUNT,         3  
gkval,gih$COUNT._04	FLbutton	"",	1,    0,    4,     20,     20,    160, iy,   0,       10,        0,        0,       $COUNT,         4  
gkval,gih$COUNT._05	FLbutton	"",	1,    0,    4,     20,     20,    180, iy,   0,       10,        0,        0,       $COUNT,         5  
gkval,gih$COUNT._06	FLbutton	"",	1,    0,    4,     20,     20,    200, iy,   0,       10,        0,        0,       $COUNT,         6  
gkval,gih$COUNT._07	FLbutton	"",	1,    0,    4,     20,     20,    220, iy,   0,       10,        0,        0,       $COUNT,         7  
gkval,gih$COUNT._08	FLbutton	"",	1,    0,    4,     20,     20,    240, iy,   0,       10,        0,        0,       $COUNT,         8  
gkval,gih$COUNT._09	FLbutton	"",	1,    0,    4,     20,     20,    260, iy,   0,       10,        0,        0,       $COUNT,         9  
gkval,gih$COUNT._10	FLbutton	"",	1,    0,    4,     20,     20,    280, iy,   0,       10,        0,        0,       $COUNT,        10 
gkval,gih$COUNT._11	FLbutton	"",	1,    0,    4,     20,     20,    300, iy,   0,       10,        0,        0,       $COUNT,        11 
gkval,gih$COUNT._12	FLbutton	"",	1,    0,    4,     20,     20,    320, iy,   0,       10,        0,        0,       $COUNT,        12 
gkval,gih$COUNT._13	FLbutton	"",	1,    0,    4,     20,     20,    340, iy,   0,       10,        0,        0,       $COUNT,        13 
gkval,gih$COUNT._14	FLbutton	"",	1,    0,    4,     20,     20,    360, iy,   0,       10,        0,        0,       $COUNT,        14 
gkval,gih$COUNT._15	FLbutton	"",	1,    0,    4,     20,     20,    380, iy,   0,       10,        0,        0,       $COUNT,        15 
gkval,gih$COUNT._16	FLbutton	"",	1,    0,    4,     20,     20,    400, iy,   0,       10,        0,        0,       $COUNT,        16
gk$COUNT.Gain, ih$COUNT.Gain		FLslider 	"",		0,      1,    0,    3,     -1,   100,      15,  420, iy+2
FLsetVal_i	0.7, 	ih$COUNT.Gain
FLsetColor	255, 255, 255, ih$COUNT.Gain		;SET PRIMARY COLOUR TO WHITE
#
$ROW(1)
$ROW(2)
$ROW(3)
$ROW(4)
$ROW(5)
$ROW(6)


ix	=	102
#define	AMP_SLIDER(COUNT)
#
;SLIDERS	            			MIN  |  MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp$COUNT, ih		FLslider 	"",	0,        1,   0,    4,     -1,    15,      95,  ix, 200
ix	=	ix + 20
#
$AMP_SLIDER(1)
$AMP_SLIDER(2)
$AMP_SLIDER(3)
$AMP_SLIDER(4)
$AMP_SLIDER(5)
$AMP_SLIDER(6)
$AMP_SLIDER(7)
$AMP_SLIDER(8)
$AMP_SLIDER(9)
$AMP_SLIDER(10)
$AMP_SLIDER(11)
$AMP_SLIDER(12)
$AMP_SLIDER(13)
$AMP_SLIDER(14)
$AMP_SLIDER(15)
$AMP_SLIDER(16)

;INITIALISE FLTK VALUATORS
		FLsetVal_i	100, 	ihBPM
		FLsetVal_i	0.4, 	ihMasterGain

;SET INITIAL PATTERN
		FLsetVal_i	1, gih1_01
		FLsetVal_i	1, gih1_04
		FLsetVal_i	1, gih1_09
		FLsetVal_i	1, gih1_11
		FLsetVal_i	1, gih1_14
	
		FLsetVal_i	1, gih2_05
		FLsetVal_i	1, gih2_16
	
		FLsetVal_i	1, gih3_05
		FLsetVal_i	1, gih3_08
		FLsetVal_i	1, gih3_13
		FLsetVal_i	1, gih3_15
	
		FLsetVal_i	1, gih4_01
		FLsetVal_i	1, gih4_02
		FLsetVal_i	1, gih4_04
		FLsetVal_i	1, gih4_05
		FLsetVal_i	1, gih4_06
		FLsetVal_i	1, gih4_09
		FLsetVal_i	1, gih4_10
		FLsetVal_i	1, gih4_12
		FLsetVal_i	1, gih4_13
		FLsetVal_i	1, gih4_14
	
		FLsetVal_i	1, gih5_03
		FLsetVal_i	1, gih5_07
		FLsetVal_i	1, gih5_11
		FLsetVal_i	1, gih5_15
	
		FLsetVal_i	1, gih6_01
		FLsetVal_i	1, gih6_03
		FLsetVal_i	1, gih6_05
		FLsetVal_i	1, gih6_07
		FLsetVal_i	1, gih6_09
		FLsetVal_i	1, gih6_11
		FLsetVal_i	1, gih6_13
		FLsetVal_i	1, gih6_15       

		FLpanel_end	;END OF PANEL CONTENTS

FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 540, 562, 0
				FLscroll     512, 540, 0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                    Simple Drum Sequencer                    ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates how to contruct a simple looping   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"drum sequencer. Sequence data (i.e. play/don't play) is      ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"stored is GEN 2 function tables. This data is retrieved and  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"played by the 'timedseq' and 'schedkwhen' opcodes.           ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Each time a sequence event is changed the function table     ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"corresponding to that sound is updated with the new data.    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Tempo is adjustable and there is a gain control for each     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"sound as well as a master gain control.                      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"An additional feature is that sound 4 (closed hi-hat) will   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"mute any sustaining instances of sound 5 (open hi-hat) as    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"would happen with a real hi-hat.                             ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"The swing control delays every other loop event (events 2, 4,", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"6 etc.) to create a continuously variable 'swing' effect. If ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"this is at minimum the rhythm played is straight semiquavers,", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"set to its midway location each rhythmic pair is a triplet   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"quaver semiquaver and at maximum each pair is dotted-quaver  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"semiquaver.                                                  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"Sixteen small sliders are used to vary the amplitude of each ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"individual beat for all sounds simulataneously.              ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Sounds are produced using either simple synthesis or one of  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"Csound's physical modelling opcodes.                         ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"Obviously there are numererous programs and plugins that     ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"perform a similar task but this example at least serves to   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"prove that this can be done in Csound and there remains the  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"possibility to expand this technique into something much more", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"unique.                                                      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"The code has been written so that it should be fairly simple ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"to add additional voices or to extend the length of the loop.", 	1,      5,     14,    490,    20,     5, 580
				FLscroll_end                                                        
				FLpanel_end

		FLrun		;RUN THE WIDGET THREAD!

gisine		ftgen		0,0,4096,10,1	;SINE WAVE
gkphs		init		0

;FUNCTION TABLE FOR STORAGE OF SEQUENCE DATA FOR SOUND 1 p4=On/Off_Status p5=amplitude
gi01		ftgen		0,0,128,-2,	0,	1,	0.001,	0,0,\
						0,	1.25,	0.001,	0,0,\
						0,	1.5,	0.001,	0,0,\
						0,	1.75,	0.001,	0,0,\                       
						0,	2,	0.001,	0,0,\
						0,	2.25,	0.001,	0,0,\
						0,	2.5,	0.001,	0,0,\
						0,	2.75,	0.001,	0,0,\                  
						0,	3,	0.001,	0,0,\
						0,	3.25,	0.001,	0,0,\
						0,	3.5,	0.001,	0,0,\
						0,	3.75,	0.001,	0,0,\
						0,	4,	0.001,	0,0,\
						0,	4.25,	0.001,	0,0,\
						0,	4.5,	0.001,	0,0,\
						0,	4.75,	0.001,	0,0,\
						-1,	5,	-1,	-1,-1

gi02		ftgen		0,0,128,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE gi01
gi03		ftgen		0,0,128,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE gi01
gi04		ftgen		0,0,128,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE gi01
gi05		ftgen		0,0,128,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE gi01
gi06		ftgen		0,0,128,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE gi01
		tableicopy 	gi02, gi01	;COPY TABLE 1 INTO ALL OTHER TABLES
		tableicopy 	gi03, gi01
		tableicopy 	gi04, gi01
		tableicopy 	gi05, gi01
		tableicopy 	gi06, gi01

gisine		ftgen		0,0,4096,10,1	;SINE WAVE

instr	1	; NOTE TRIGGERING INSTRUMENT
	if	gkOnOff!=0	goto	CONTINUE                                                      
	turnoff                     
	CONTINUE:
	
	kBPS		=	gkBPM/60		;CONVERT BEATS PER MINUTE TO BEATS PER SECOND
	isubdiv		=	4			;NUMBER OF SUBDIVISIONS OF THE BEAT
	kphs    	phasor  kBPS/isubdiv		;CREATE MOVING PHASE VALUE 
	ktrigger	metro	20			;RATE OF UPDATE OF GREEN LOOP POSITION INDICATOR (REDUCE IF THIS AFFECTS REAL-TIME PERFORMANCE)
	FLsetVal	ktrigger, kphs, gihphs		;UPDATE GREEN LOOP POSITION INDICATOR
	ktimpnt 	=	kphs*isubdiv+0.99	;MULTIPLY PHASE VALUE BY NUMBER OF BEATS, OFFSET BY ALMOST 1 (THIS IS TO ENSURE THE FIRST EVENT ON BEAT ONE IS ALWAYS TRIGGERED)
	kp1		init	0			;INITIALISE P-FIELD VALUES OUTPUT BY timedseq AS INPUT VARIABLES
	kp2		init	0               	;INITIALISE P-FIELD VALUES OUTPUT BY timedseq AS INPUT VARIABLES
	kp3		init	0               	;INITIALISE P-FIELD VALUES OUTPUT BY timedseq AS INPUT VARIABLES
	kp4		init	0               	;INITIALISE P-FIELD VALUES OUTPUT BY timedseq AS INPUT VARIABLES
	kp5		init	0               	;INITIALISE P-FIELD VALUES OUTPUT BY timedseq AS INPUT VARIABLES
	
#define	LoopTrigger(N)
	#ktrig   timedseq ktimpnt,gi0$N, kp1, kp2,kp3, kp4,kp5	;CREATE NOTE TRIGGERS AND P-FIELDS FOR SOUND 1 FROM FUNCTION TABLE gi01 
	;OPCODE 	TRIGGER | MINTIM | MAXNUM | INSNUM | WHEN | DUR | P4 | P5 |P6
	schedkwhen 	ktrig,      0,       0,        2,     0,    kp3,  kp4, kp5, $N	;TRIGGER INTERROGATION INSTRUMENT#
	;EXPAND MACRO MULTIPLE TIMES FOR EACH SEQUENCER ROW
	$LoopTrigger(1)
	$LoopTrigger(2)
	$LoopTrigger(3)
	$LoopTrigger(4)
	$LoopTrigger(5)
	$LoopTrigger(6)
	
	;--SWING CONTROL------------------------------------------------------------------------------------------------------
	;TWO NESTED LOOPS ARE EMPLOYED: LOOP 1 APPLIES PROCEDURE FOR EACH ROW. LOOP 2 (WITHIN EACH LOOP1 PASS) FOR EACH COLUMN
	kSwTrig	changed	gkswing				;IF SWING SLIDER HAS BEEN CHANGED GENERATE A TRIGGER IMPULSE
	if kSwTrig==1 then				;IF SWING CHANGE TRIGGER HAS BEEN GENERATED...
		kcount1	=	0			;LOOP 1 COUNTER
		loop1:					;LOOP 1 BEGINS HERE. REITERATED FOR EACH ROW (INSTRUMENT)
			kcount2	=	6		;LOOP 2 COUNTER (USED TO REFERENCE START TIME FOR ALTERNATE TABLE NOTE EVENTS HENCE INITIAL VALUE OF 5 AND INCREMENT OF 8
			loop2:				;LOOP 2 BEGINS HERE. REITERATED FOR EACH COLUMN (INSTRUMENT)
				tablewkt	1+(((kcount2-1)/20)) + gkswing, kcount2, gi01+kcount1	;WRITE NEW VALUE
			loop_le	kcount2,10,5*16,loop2	;LOOP BACK TO LABEL FOR EACH PATTERN COLUMN
		loop_lt	kcount1,1,6,loop1		;LOOP BACK TO LABEL FOR EACH PATTERN ROW
	endif
	
	;--WRITE AMPS--------------------------------------------------------------------------------------------------------
	;DEFINE A MACRO...
#define	WRITE_AMP(N)
	#
	ktrig	changed	gkamp$N
	if ktrig==1 then
		kcount=0
		loop3$N:
		tablewkt	gkamp$N, (5 * $N)-1, gi01+kcount
		loop_lt	kcount,1,6,loop3$N
	endif
	#
	;EXPAND MACRO MULTIPLE TIMES. ONCE FOR EACH AMPLITUDE FADER
	$WRITE_AMP(1)
	$WRITE_AMP(2)
	$WRITE_AMP(3)
	$WRITE_AMP(4)
	$WRITE_AMP(5)
	$WRITE_AMP(6)
	$WRITE_AMP(7)
	$WRITE_AMP(8)
	$WRITE_AMP(9)
	$WRITE_AMP(10)
	$WRITE_AMP(11)
	$WRITE_AMP(12)
	$WRITE_AMP(13)
	$WRITE_AMP(14)
	$WRITE_AMP(15)
	$WRITE_AMP(16)	
endin

instr	2	;INTERROGATE EVENT AND DETERMINE WHETHER A SOUND SHOULD BE PLAYED OR NOT
	if	p4=1	then			;IF EVENT VARIABLE IS '1'...
		event_i	"i", p1+p6, 0, p3, 1-p5	;...PLAY A SOUND. (p4=amplitude)
	endif					;END OF CONDITIONAL BRANCH
endin
                                                                                         
instr	3	;SOUND 1 - BASS DRUM
	p3	=	0.2		;DEFINE DURATION FOR THIS SOUND
	aenv	expon	1,p3,0.001	;AMPLITUDE ENVELOPE - PERCUSSIVE DECAY                    
	kcps	expon	200,p3,20	;PITCH GLISSANDO
	;OUTPUT	OPCODE	AMPLITUDE                               | FREQUENCY | FUNCTION_TABLE
	asig	oscil	aenv*i(gk1Gain)*i(gkMasterGain)*1.6*p4,     kcps,       gisine 		;OSCILLATOR
		outs	asig, asig	;SEND AUDIO TO OUTPUTS
endin

instr	4	;SOUND 2 - KALIMBA (BAR MODEL)
	p3	=	2.6		;DEFINE DURATION FOR THIS SOUND
	asig 	barmodel	1, 1, 80, 1, 0, 2.6, 0.5, 6000, 0.07	;KALIMBA SOUND CREATED USING barmodel OPCODE (SEE CSOUND MANUAL FOR MORE INFO.)
		outs	asig*i(gk2Gain)*i(gkMasterGain)*p4, asig*i(gk2Gain)*i(gkMasterGain)*p4 	;SEND AUDIO TO OUTPUTS AND ATTENUATE  USING GAIN CONTROLS
endin

instr	5	;SOUND 3 - SNARE
	p3	=	0.3		;DEFINE DURATION FOR THIS SOUND
	aenv	expon	1,p3,0.001	;AMPLITUDE ENVELOPE - PERCUSSIVE DECAY
	anse	noise	1, 0 	;CREATE NOISE COMPONENT FOR SNARE DRUM SOUND
	kcps	expon	400,p3,20				;CREATE TONE COMPONENT FREQUENCY GLISSANDO FOR SNARE DRUM SOUND
	ajit	randomi	0.2,1.8,10000				;JITTER ON FREQUENCY FOR TONE COMPONENT
	atne	oscil	aenv*i(gk3Gain)*i(gkMasterGain),kcps*ajit,gisine	;CREATE TONE COMPONENT
	asig	sum	anse*0.5, atne*5	;MIX NOISE AND TONE SOUND COMPONENTS
	ares 	vcomb 	asig, 0.02, 0.0035, .1	;PASS SIGNAL THROUGH ACOMB FILTER TO CREATE STATIC HARMONIC RESONANCE
		outs	ares*aenv*i(gk3Gain)*i(gkMasterGain)*p4, ares*aenv*i(gk3Gain)*i(gkMasterGain)*p4	;SEND AUDIO TO OUTPUTS, APPLY ENVELOPE AND ATTENTUATE USING GAIN CONTROLS 
endin

instr	6	;SOUND 4 - CLOSED HI-HAT
	ktime	timeinstk
	if ktime<=1 then
	  turnoff2 7,0,0	;TURN OFF ALL INSTANCES OF instr 7 (OPEN HI-HAT)
	endif
	p3	=	0.1		;DEFINE DURATION FOR THIS SOUND
	aenv	expon	1,p3,0.001	;AMPLITUDE ENVELOPE - PERCUSSIVE DECAY
	asig	noise	aenv*i(gk4Gain)*i(gkMasterGain)*p4, 0	;CREATE SOUND FOR CLOSED HI-HAT
	asig	buthp	asig, 7000					;HIGHPASS FILTER SOUND
		outs	asig, asig	;SEND AUDIO TO OUTPUTS
endin

instr	7	;SOUND 5 - OPEN HI-HAT
	p3	=	1		;DEFINE DURATION FOR THIS SOUND
	aenv	expon	1,p3,0.001	;AMPLITUDE ENVELOPE - PERCUSSIVE DECAY
	asig	noise	aenv*i(gk5Gain)*i(gkMasterGain)*p4, 0	;CREATE SOUND FOR CLOSED HI-HAT
	asig	buthp	asig, 7000					;HIGHPASS FILTER SOUND	
		outs	asig, asig	;SEND AUDIO TO OUTPUTS
endin

instr	8	;SOUND 6 - TAMBOURINE
	        p3	=	0.5		;DEFINE DURATION FOR THIS SOUND
	asig	tambourine	i(gk6Gain)*i(gkMasterGain)*0.3*p4,0.01 ,32, 0.47, 0, 2300 , 5600, 8000	;TAMBOURINE SOUND CREATED USING tambourine PHYSICAL MODELLING OPCODE (SEE CSOUND MANUAL FOR MORE INFO.)
		outs	asig, asig	;SEND AUDIO TO OUTPUTS
endin

instr	10	;SEND NEW SEQUENCE VALUE ('ON' 0R 'OFF', '1' OR 'ZERO') TO THE RELEVANT TABLE
	tableiw	i(gkval), ((p5-1)*5)+3, gi01+p4-1
endin

instr	102	;CLEAR ALL PATTERNS
#define	ROW(N)
	#
	FLsetVal_i	0, gih$N._01
	FLsetVal_i	0, gih$N._02
	FLsetVal_i	0, gih$N._03
	FLsetVal_i	0, gih$N._04
	FLsetVal_i	0, gih$N._05
	FLsetVal_i	0, gih$N._06
	FLsetVal_i	0, gih$N._07
	FLsetVal_i	0, gih$N._08
	FLsetVal_i	0, gih$N._09
	FLsetVal_i	0, gih$N._10
	FLsetVal_i	0, gih$N._11
	FLsetVal_i	0, gih$N._12
	FLsetVal_i	0, gih$N._13
	FLsetVal_i	0, gih$N._14
	FLsetVal_i	0, gih$N._15
	FLsetVal_i	0, gih$N._16
	#
	$ROW(1)
	$ROW(2)
	$ROW(3)
	$ROW(4)
	$ROW(5)
	$ROW(6)
endin
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>