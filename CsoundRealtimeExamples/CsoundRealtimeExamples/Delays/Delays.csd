Delays.csd
Written bu Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	128	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE==============================================================================================================================================================
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;	LABEL     | WIDTH | HEIGHT | X | Y
FLpanel	"Delays",    500,    650,    0,  0
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkNTaps, ihNTaps 			FLcount  "No. of Taps", 1,    128,    1,     10,      1,   130,     25,     5,   5,   -1

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihfilter		FLbox  	" ", 	6,        9,    15,   496,   240,     2, 255	;FILTER SECTION
FLsetColor	255, 255, 150, ihfilter	;SET SUB-PANEL COLOUR

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkFiltOnOff,ihFiltOnOff		FLbutton	"Filter",	1,    0,    22,    140,     25,    5,265,    -1
FLsetColor2	255, 255, 50, ihFiltOnOff		;SET SECONDARY COLOUR TO YELLOW

	;VALUE DISPLAY BOXES				WIDTH | HEIGHT |  X  |  Y
	idTotTime			FLvalue	"",     60,       20,     5,   75
	idTimeCurve			FLvalue	"",     60,       20,     5,  125
	idAmpEnv			FLvalue	"",     60,       20,     5,  175
	idAmpCurve			FLvalue	"",     60,       20,     5,  225
	idLPFEnv			FLvalue	"",     60,       20,     5,  325
	idLPFCurve			FLvalue	"",     60,       20,     5,  375
	idLPFOffset			FLvalue	"",     60,       20,     5,  425
	idLPFRes			FLvalue	"",     60,       20,     5,  525
	idDryGain			FLvalue	"",     60,       20,     5,  575
	idDelaysGain			FLvalue	"",     60,       20,     5,  625

	;SLIDERS				            			MIN  | MAX | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
	gkTotTime, ihTotTime		FLslider 	"Total Time",		0.1,   10,    0,    23,  idTotTime,    490,     25,    5,  50
	gkTimeCurve, ihTimeCurve	FLslider 	"Time Curve",		-8,     8,    0,    23,  idTimeCurve,  490,     25,    5, 100
	gkAmpEnv, ihAmpEnv		FLslider 	"Amp. Env.",		0,      1,    0,    23,  idAmpEnv,     490,     25,    5, 150
	gkAmpCurve, ihAmpCurve		FLslider 	"Amp. Curve",		-8,     8,    0,    23,  idAmpCurve,   490,     25,    5, 200
	gkLPFEnv, ihLPFEnv		FLslider 	"LPF Env.",		0,      1,    0,    23,  idLPFEnv,     490,     25,    5, 300
	gkLPFCurve, ihLPFCurve		FLslider 	"LPF Curve",		-8,     8,    0,    23,  idLPFCurve,   490,     25,    5, 350
	gkLPFOffset, ihLPFOffset	FLslider 	"LPF Offset",		0,     20,    0,    23,  idLPFOffset,  490,     25,    5, 400
	gkLPFRes, ihLPFRes		FLslider 	"LPF Resonance",	0,    0.9,    0,    23,  idLPFRes,     490,     25,    5, 450
	gkPanDep, ihPanDep		FLslider 	"Pan Depth",		0,      1,    0,    23,  -1,           490,     25,    5, 500
	gkDryGain, ihDryGain		FLslider 	"Dry Gain",		0,      1,    0,    23,  idDryGain,    490,     25,    5, 550
	gkDelaysGain, ihDelaysGain	FLslider 	"Delays Gain",		0,      1,    0,    23,  idDelaysGain, 490,     25,    5, 600
	gkInGain, ihInGain		FLslider 	"Input Gain",		0,      1,    0,    23,  -1,           170,     12,  320,  20

	;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
				FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
	
	;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
	gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   250, 0,   -1
	
	;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
				FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

	;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"Input", 		1,       5,    14,     50,      16, 200,   0
	ih		 	FLbox  	"Blips", 		1,       5,    14,     50,      16, 270,   0
	ih		 	FLbox  	"Live ", 		1,       5,    14,     50,      16, 270,  20

	;SET INITIAL VALUES OF FLTK VALUATORS
	FLsetVal_i	30, 	ihNTaps
	FLsetVal_i	2.5, 	ihTotTime
	FLsetVal_i	-3, 	ihTimeCurve
	FLsetVal_i	0.3, 	ihAmpEnv
	FLsetVal_i	-3, 	ihAmpCurve
	FLsetVal_i	0.15, 	ihLPFEnv
	FLsetVal_i	-3, 	ihLPFCurve
	FLsetVal_i	0.5, 	ihPanDep
	FLsetVal_i	0, 	ihDryGain
	FLsetVal_i	1, 	ihDelaysGain
	FLsetVal_i	0.5, 	ihInGain
	FLsetVal_i	0.5, 	ihLPFRes
	FLsetVal_i	20, 	ihLPFOffset
	FLsetVal_i	1, 	ihFiltOnOff
FLpanel_end

	;INSTRUCTIONS AND INFO PANEL
	FLpanel	" ", 500, 780, 512, 0
	;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"                          Delays                             ", 	1,      5,     14,    490,    20,     5,    0
	ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,   20
	ih		 	FLbox  	"This example implements a multitap delay in which the number ", 	1,      5,     14,    490,    20,     5,   40
	ih		 	FLbox  	"of taps can be redefined in real time by the user from the   ", 	1,      5,     14,    490,    20,     5,   60
	ih		 	FLbox  	"interface. This is made possible through UDO (user defined   ", 	1,      5,     14,    490,    20,     5,   80
	ih		 	FLbox  	"opcode) recursion. For more information on this technique it ", 	1,      5,     14,    490,    20,     5,  100
	ih		 	FLbox  	"is recommended to study the code and comments and to also    ", 	1,      5,     14,    490,    20,     5,  120
	ih		 	FLbox  	"read Steven Yi's article 'Control Flow - Part II' in the     ", 	1,      5,     14,    490,    20,     5,  140
	ih		 	FLbox  	"summer 2006 Csound Journal.                                  ", 	1,      5,     14,    490,    20,     5,  160
	ih		 	FLbox  	"Delay tap times are defined as subdivisions of the 'Total    ", 	1,      5,     14,    490,    20,     5,  180
	ih		 	FLbox  	"Time' - these times can be evenly space or warped according  ", 	1,      5,     14,    490,    20,     5,  200
	ih		 	FLbox  	"to a curve defined by the 'Time Curve' control. This curve is", 	1,      5,     14,    490,    20,     5,  220
	ih		 	FLbox  	"created using GEN 16. If displays are enabled you can view   ", 	1,      5,     14,    490,    20,     5,  240
	ih		 	FLbox  	"changes made to this table (table number 1) in real time.    ", 	1,      5,     14,    490,    20,     5,  260
	ih		 	FLbox  	"Using this feature 'bounce' delay effects and 'reverse       ", 	1,      5,     14,    490,    20,     5,  280
	ih		 	FLbox  	"bounce' delay effects can be created.                        ", 	1,      5,     14,    490,    20,     5,  300
	ih		 	FLbox  	"In a similar way, an envelope that is applied across all of  ", 	1,      5,     14,    490,    20,     5,  320
	ih		 	FLbox  	"delay taps is created and modified using the controls 'Amp.  ", 	1,      5,     14,    490,    20,     5,  340
	ih		 	FLbox  	"Env.' and 'Amp. Curve' controls. 'Amp. Env' defines whether  ", 	1,      5,     14,    490,    20,     5,  360
	ih		 	FLbox  	"the envelope is building, decaying or flat. Once again the   ", 	1,      5,     14,    490,    20,     5,  380
	ih		 	FLbox  	"results are visible as table 2 if table displays are not     ", 	1,      5,     14,    490,    20,     5,  400
	ih		 	FLbox  	"suppressed.                                                  ", 	1,      5,     14,    490,    20,     5,  420
	ih		 	FLbox  	"Thirdly a resonant lowpass filter with envelope control can  ", 	1,      5,     14,    490,    20,     5,  440
	ih		 	FLbox  	"be applied across the entire delay sequence. Its shape can be", 	1,      5,     14,    490,    20,     5,  460
	ih		 	FLbox  	"viewed as 'ftable 3'.                                        ", 	1,      5,     14,    490,    20,     5,  480
	ih		 	FLbox  	"A panning effect is implemented in which delay taps are      ", 	1,      5,     14,    490,    20,     5,  500
	ih		 	FLbox  	"alternately sent to the left and right channels in ping-pong ", 	1,      5,     14,    490,    20,     5,  520
	ih		 	FLbox  	"delay fashion. The depth of this effect is controllable using", 	1,      5,     14,    490,    20,     5,  540
	ih		 	FLbox  	"the 'Pan Depth' slider.                                      ", 	1,      5,     14,    490,    20,     5,  560
	ih		 	FLbox  	"To test the effect short percussive noise 'blips' are        ", 	1,      5,     14,    490,    20,     5,  580
	ih		 	FLbox  	"generated, one for each delay cycle. It would be a simple    ", 	1,      5,     14,    490,    20,     5,  600
	ih		 	FLbox  	"operation to adapt this example to read live audio or a sound", 	1,      5,     14,    490,    20,     5,  620
	ih		 	FLbox  	"file as input. Alternatively the computer's live input can   ", 	1,      5,     14,    490,    20,     5,  640
	ih		 	FLbox  	"also be used.                                                ", 	1,      5,     14,    490,    20,     5,  660
	ih		 	FLbox  	"Use of the resonant lowpass filter feature in this example   ", 	1,      5,     14,    490,    20,     5,  680
	ih		 	FLbox  	"can be rather CPU intensive, particularly if many delay taps ", 	1,      5,     14,    490,    20,     5,  700
	ih		 	FLbox  	"are being employed. For this reason the filter section can be", 	1,      5,     14,    490,    20,     5,  720
	ih		 	FLbox  	"bypassed with its on/off switch if realtime operation        ", 	1,      5,     14,    490,    20,     5,  740
	ih		 	FLbox  	"glitches.                                                    ", 	1,      5,     14,    490,    20,     5,  760
                                                                                                                                                           
FLpanel_end

FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE=======================================================================================================================================================

gaIn	init	0	;INPUT SIGNAL

;TECHNIQUE OF ITERATION WITHIN A UDO WAS INSPIRED BY STEVEN YI'S ARTICLE IN SUMMER 2006 CSOUND JOURNAL - THANKS STEVEN!
;UDOS=============================================================================================================================================================================
opcode delaytap, aa, kiiiiii	;DEFINE UDO. NO OUTPUTS (AUDIO IS WRITTEN TO ZAK SPACE). ONE K-RATE INPUT, SIX I-RATE INPUTS.
	kLPFRes, iTimeTable, iAmpTable, iLPFTable, itaps, ipan, icount  xin	;NAME INPUT ARGUMENTS
	itime	tablei	(icount-1)/itaps, iTimeTable, 1			;READ DELAY TIME OF CURRENT TAP FROM FUNCTION TABLE WITH TABLE NUMBER iTimeTable (CREATED IN INSTR 3)
	iamp	table	(icount-1)/itaps, iAmpTable, 1			;READ AMPLITUDE OF CURRENT TAP FROM FUNCTION TABLE WITH TABLE NUMBER iAmpTable (CREATED IN INSTR 3)
	;prints	"Count%d Time%5.2f Amp%5.2f\\n", icount, itime, iamp	;PRINTING LINE - USE FOR CHECKING AND TROUBLE SHOOTING
	a1	deltap	itime						;CREATE DELAY TAP
	if	gkFiltOnOff=0	goto	SKIP
	iLPFoct	tablei	(icount-1)/itaps, iLPFTable, 1			;READ FILTER CUTOFF OF CURRENT TAP FROM FUNCTION TABLE WITH TABLE NUMBER iLPFTable (CREATED IN INSTR 3)
	a1	moogvcf	a1, cpsoct(iLPFoct), kLPFRes			;APPLY RESONANT LOWPASS FILTER
	SKIP:
	ipan	init	abs(ipan-1)					;PAN POSITION ALTERNATING BETWEEN LEFT AND RIGHT
	a1,a2	pan2	a1*2, ((ipan*gkPanDep) + (0.5 * (1 - gkPanDep)));PANNING APPLIED USING pan2 OPCODE, DEPTH OF PANNING EFFECT IS DEFINED BY 'Pan Depth' SLIDER
	icount	=	icount + 1					;INCREMENT TAP COUNTER
	if	icount<=itaps	then					;CHECK IF WE ARE ON THE FINAL TAP, IF NOT, CALL delaytap UDO AGAIN
		a1mix,a2mix	delaytap	kLPFRes, iTimeTable, iAmpTable, iLPFTable, itaps, ipan, icount	;CALL delaytap UDO
	endif								;END OF CONDITIONAL BRANCHING
		xout	(a1*iamp)+a1mix, (a2*iamp)+a2mix				;SEND AUDIO BACK TO CALLER INSTRUMENT
endop
;================================================================================================================================================================================

instr	1	;GENERATE NOTE EVENTS FOR INPUT SIGNAL
	if	gkinput=0	then
		kdur	random	0.01,0.1				;NOTE DURATION SLIGHTLY RANDOMISED
		ktrig	metro	1/(gkTotTime+0.5)		;NOTE EVENT TRIGGER IS TIMED TO OCCUR ONCE EVERY DELAY CYCLE
		schedkwhen	ktrig, 0, 0, 2, 0, kdur		;TRIGGER NOTE EVENT IN INSTRUMENT 2
	else
		a1	inch	1			;READ LIVE AUDIO IN FROM COMPUTER INPUT (CHANNEL 1)
		gaIn	=	gaIn + a1*gkInGain	;MIX INTO GLOBAL INPUT AUDIO SIGNAL
	endif
endin
	
instr	2	;INPUT SIGNAL - A SHORT 'BLIP' SOUND
	aenv	expsega	1,p3,0.001	;PERCUSSIVE TYPE AMPLITUDE ENVELOPE
	ioct	random	6, 12		;OSCILLATOR PITCH (OCT FORMAT) SLIGHTLY RANDOMISED
	a1	pinkish	1		;PINK NOISE
	icfoct	random	8,13		;GENERATE A RANDOM CUTOFF FREQUENCY FOR UPCOMIMG LOW-PASS FILTER
	a1	butlp	a1, cpsoct(icfoct)	;FILTER AUDIO SIGNAL
		gaIn	=	gaIn + a1*aenv	;MIX INTO GLOBAL INPUT AUDIO SIGNAL
endin

instr	3	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
	ktrig	changed	gkNTaps, gkTotTime, gkTimeCurve, gkAmpEnv, gkAmpCurve, gkLPFEnv, gkLPFCurve, gkLPFOffset	;IF ANY OF THE LISTED K-RATE VARIABLES ARE CHANGED PART OF THIS INSTRUMENT GENERATE A MOMENTARY 1 VALUE IN THE OUTPUT ktrig 
	if	ktrig=1	then		;IF ktrig=1 ...
		reinit	RESTART		;REINITIALISE FROM LABEL 'RESTART'
	endif				;END OF CONDITIONAL BRANCHING
	RESTART:			;LABEL
	
	;GENERATE TABLE OF DELAY TIMES============================================================================================================================================
	iTimeTable	ftgen	1,0,4096,-16, 1/kr, 4096, i(gkTimeCurve) , i(gkTotTime)	;TABLE OF DELAY TIMES DEFINES AS A UUSER DEFINABLE CURVE (DELAY OFFSET IS 1/kr)
	;=========================================================================================================================================================================
	
	;GENERATE TABLE OF AMPLITUDES=============================================================================================================================================
	iAmpStart	=	(1 - i(gkAmpEnv)) * 2	;AMPLITUDE ENVELOPE START VALUE DEFINED WITH RESPECT TO gkAmpEnv CONTROL
	iAmpStart	limit	iAmpStart, 0, 1		;LIMIT VALUES BETWEEN 0 AND 1
	iAmpEnd		=	i(gkAmpEnv) * 2		;AMPLITUDE ENVELOPE END VALUE DEFINED WITH RESPECT TO gkAmpEnv CONTROL
	iAmpEnd		limit	iAmpEnd, 0, 1           ;LIMIT VALUES BETWEEN 0 AND 1                                
	iAmpTable	ftgen	2,0,4096,-16, iAmpStart, 4096, i(gkAmpCurve) , iAmpEnd	;DEFINE AMPLITUDE ENVELOPE THAT WILL BE APPLIED OVER THE ENTIRE DELAY CYCLE
	;=========================================================================================================================================================================

	if	gkFiltOnOff=0	goto	SKIP
	;GENERATE TABLE OF FILTER CUTOFF VALUES===================================================================================================================================
	iLPFStart	=	((1-i(gkLPFEnv))*i(gkLPFOffset))+4	;LOW-PASS FILTER ENVELOPE START VALUE DEFINED WITH RESPECT TO gkLPFEnv CONTROL
	iLPFStart	limit	iLPFStart, 4, 14	;LIMIT VALUES BETWEEN 4 AND 14
	iLPFEnd		=	(i(gkLPFEnv)*i(gkLPFOffset))+4	;LOW-PASS FILTER ENVELOPE END VALUE DEFINED WITH RESPECT TO gkLPFEnv CONTROL
	iLPFEnd		limit	iLPFEnd, 4, 14           ;LIMIT VALUES BETWEEN 4 AND 14                                
	iLPFTable	ftgen	3,0,4096,-16, iLPFStart, 4096, i(gkLPFCurve) , iLPFEnd	;DEFINE LOW-PASS FILTER ENVELOPE THAT WILL BE APPLIED OVER THE ENTIRE DELAY CYCLE
	;=========================================================================================================================================================================
	SKIP:
	
	icount	init	1						;DELAY TAP COUNTER IS INITIALISED
	ipan	init	0						;ipan VARIABLE IS DEFINED
	abuffer	delayr	i(gkTotTime)					;DEFINE ENTIRE DELAY BUFFER	
	aL,aR	delaytap	gkLPFRes, iTimeTable, iAmpTable, iLPFTable, i(gkNTaps), ipan, icount	;CALL UDO delaytap
		delayw	gaIn						;WRITE AUDIO INTO DELAY BUFFER
	rireturn							;RETURN FROM INITIALISATION PASS
	adry	delay	gaIn, 1/kr					;DELAY INPUT SIGNAL TO ALIGN DRY SIGNAL WITH FIRST DELAY TAP
	outs	(aL * gkDelaysGain) + (adry * gkDryGain), (aR * gkDelaysGain) + (adry * gkDryGain)	;SEND AUDIO TO OUTPUTS
		clear	gaIn
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 INPUT 
i 3 0 3600	;INSTRUMENT 2 CREATES DELAYS
</CsScore>

</CsoundSynthesizer>