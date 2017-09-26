SpectrumAnalyser100.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -iadc -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 250, 250, 50	;SET INTERFACE COLOURS
;			LABEL                   | WIDTH | HEIGHT | X | Y
		FLpanel	"Spectrum Analyser 100",  1010,    400,    0,  0
;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkAnaOnOff,ihAnaOnOff	FLbutton	"Analyser On/Off",		1,    0,    22,    180,     30,    5,  5,    -1

;VALUE INPUT BOXES				 		MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkfundHz, gihfundHz		FLtext		"Fund.(Hz)", 	20,  2000,  0.01,   1,   100,     20,     10,   50
gkfundNum, gihfundNum		FLtext		"Fund.(Num)", 	1,    127,  0.01,   1,   100,     20,    120,   50
gkbw, ihbw			FLtext		"Bandwidth", 	0.01,   1,  0.001,  1,   100,     20,    230,   50
gkpregain, ihpregain		FLtext		"Pre-gain", 	0,     50,  0.01,   1,   100,     20,    340,   50
gkpostgain, ihpostgain		FLtext		"Post-gain", 	0,     10,  0.01,   1,   100,     20,    450,   50
gksmoothing, ihsmoothing	FLtext		"Smoothing", 	0,    0.1,  0.01,   1,   100,     20,    560,   50

;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkWriteTable,ihWriteTable	FLbutton	"Write Table",		1,    0,    21,    130,     25,  670, 50,    0,      2,      0,       0
gkDumpTable,ihDumpTable		FLbutton	"Dump Table",		1,    0,    21,    130,     25,  810, 50,    0,      4,      0,       0.001

;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkPlayTone,ihPlayTone		FLbutton	"Play Tone",		1,    0,    22,    130,     25,   10, 100,    0,      3,      0,       -1

;SLIDERS								MIN |  MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X   | Y
gkToneVol, ihToneVol		FLslider	"Volume",		-98,     0,    0,    23,     -1,   200,    25,    170,  100	;
gkMaxAmp, gihMaxAmp		FLslider	"Maximum Amplitude",	0,       1,    0,     1,     -1,   600,    25,    390,  100	;

; INITIALISATION OF VALUATORS	VALUE          | HANDLE
		FLsetVal_i	cpsmidinn(60), 	gihfundHz
		FLsetVal_i	60,             gihfundNum
		FLsetVal_i	0.05, 		ihbw
		FLsetVal_i	1, 		ihpregain
		FLsetVal_i	0, 		ihpostgain                                                                                     
		FLsetVal_i	0.04, 		ihsmoothing
		FLsetVal_i	-40, 		ihToneVol

		
FLcolor	255,255,200
;TEXT BOXES																		TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"                                            Spectrum Analyser 100                                                       ",	1,      5,     14,     980,    20,   10, 150
ih	 	FLbox  	"------------------------------------------------------------------------------------------------------------------------", 	1,      5,     14,     980,    20,   10, 170
ih	 	FLbox  	"This example is very similar to the example SpectrumAnalyser.csd except that this one will analyse up to 100 harmonic   ", 	1,      5,     14,     980,    20,   10, 190
ih	 	FLbox  	"partials. Widget display of amplitude for each band is omitted as it would be impractical do do this for 100 bands.     ", 	1,      5,     14,     980,    20,   10, 210
ih	 	FLbox  	"Instead an indication of the highest amplitude being monitored by any of the bands is provided so that the user has some", 	1,      5,     14,     980,    20,   10, 230
ih	 	FLbox  	"idea of the data being receieved.                                                                                       ", 	1,      5,     14,     980,    20,   10, 250
ih	 	FLbox  	"Using this many bands can be beneficial when analysing notes with a low fundemental and a bright timbre. It is important", 	1,      5,     14,     980,    20,   10, 270
ih	 	FLbox  	"to protect against attempting to analyse frequencies beyond the Nyquist frequency as this may result in very unpleasant ", 	1,      5,     14,     980,    20,   10, 290
ih	 	FLbox  	"and anomalous sounds. Apart from the fact that data beyond the Nyquist frequency will probably be irrelevant, aliasing  ", 	1,      5,     14,     980,    20,   10, 310
ih	 	FLbox  	"could also become a problem when the waveform is recreated using an audio oscillator. In this example sounds beyond this", 	1,      5,     14,     980,    20,   10, 330
ih	 	FLbox  	"limit are simply given strength values of zero.                                                                         ", 	1,      5,     14,     980,    20,   10, 350
ih	 	FLbox  	"For more information on the mechanisms of this example please refer to the example 'SpectrumAnalyser.csd'.              ", 	1,      5,     14,     980,    20,   10, 370
		FLpanel_end	;END OF PANEL CONTENTS                                                                                                            

;INSTRUCTIONS AND INFO PANEL

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;STORED GEN10 WAVEFORM (DEFAULTS TO AN 'AHH' SOUND)
giwave	ftgen	2, 0, 4096, 10, 0.615880,0.089582,0.201498,0.202694,0.249961,0.225852,0.199864,0.029378,0.012306,0.007803,0.007846,0.007454,0.008827,0.007466,0.007495,0.007979,0.017837,0.061000,0.059055,0.039181,0.038364,0.032715,0.048415,0.029643,0.010094
;GEN 2 LIST OF THE VALUES NEEDED TO RECREATE THE GEN 10 WAVEFORM. IT IS THIS TABLE THAT CAN BE WRITTEN TO A TEXT FILE.                                                                                                                        
givals	ftgen	3, 0, -100,   -2, 0.615880,0.089582,0.201498,0.202694,0.249961,0.225852,0.199864,0.029378,0.012306,0.007803,0.007846,0.007454,0.008827,0.007466,0.007495,0.007979,0.017837,0.061000,0.059055,0.039181,0.038364,0.032715,0.048415,0.029643,0.010094, 0.615880,0.089582,0.201498,0.202694,0.249961,0.225852,0.199864,0.029378,0.012306,0.007803,0.007846,0.007454,0.008827,0.007466,0.007495,0.007979,0.017837,0.061000,0.059055,0.039181,0.038364,0.032715,0.048415,0.029643,0.010094, 0.615880,0.089582,0.201498,0.202694,0.249961,0.225852,0.199864,0.029378,0.012306,0.007803,0.007846,0.007454,0.008827,0.007466,0.007495,0.007979,0.017837,0.061000,0.059055,0.039181,0.038364,0.032715,0.048415,0.029643,0.010094, 0.615880,0.089582,0.201498,0.202694,0.249961,0.225852,0.199864,0.029378,0.012306,0.007803,0.007846,0.007454,0.008827,0.007466,0.007495,0.007979,0.017837,0.061000,0.059055,0.039181,0.038364,0.032715,0.048415,0.029643,0.010094

instr	1	;SPECTRUM ANALYSER 100
	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; SYNCHRONIZE FUNDAMENTAL HERTZ/NOTE NUMBER FORMAT INPUTS 
	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	koldHz	init	i(gkfundHz)				;INITIALISE OLD VALUE OF FUNDAMENTAL IN HERTZ FOR FIRST PASS
	koldNum	init	i(gkfundNum)				;INITIALISE OLD VALUE OF FUNDAMENTAL AS A NOTE NUMBER FOR FIRST PASS
	if koldHz!=gkfundHz then				;IF OLD VALUE FOR FUNDAMENTAL IN HERTZ IS NOT THE SAME AS THE NEW VALUE...
	  gkNum	=	(octcps(gkfundHz)-3)*12			;...DERIVE A NEW VALUE FOR FUNDAMENTAL AS A NOTE NUMBER FROM NEW VALUE 
		FLsetVal	1,gkNum,gihfundNum		;SET FUNDAMENTAL (NOTE NUMBER FORMAT) VALUE BOX BASED ON FUNDAMENTAL (HERTZ) VALUE
	elseif koldNum!=gkfundNum then				;IF OLD VALUE FOR FUNDAMENTAL AS A NOTE NUMBER IS NOT THE SAME AS THE NEW VALUE...
	  gkFundHz	=	cpsmidinn(gkfundNum)		;...DERIVE A NEW VALUE FOR FUNDAMENTAL IN HERTZ FROM NEW VALUE FOR FUNDMANETAL AS A NOTE NUMBER
		FLsetVal	1,gkFundHz,gihfundHz		;SET FUNDAMENTAL (IN HERTZ) VALUE BOX BASED ON FUNDAMENTAL (NOTE NUMBER) VALUE
	endif
	koldHz	=	gkfundHz				;SET FUNDAMENTAL IN HERTZ 'OLD VALUE' FOR NEXT PASS
	koldNum	=	gkfundNum				;SET FUNDAMENTAL AS A NOTE NUMBER 'OLD VALUE' FOR NEXT PASS

	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; READ IN AN AUDIO INPUT (LIVE AUDIO IN) 
	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	;LIVE AUDIO IN
	asig	inch		1
	;OR USE A SOUND FILE IF YOU PREFER...
	;asig,aR	diskin	"OneNoteSoundfile.wav",1,0,1
	asig	=		asig * gkpregain	;RESCALE AUDIO BEFORE ANALYSER WITH PRE-GAIN CONTROL


	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; CREATE I-RATE VERSION OF FUNDAMENTAL AND BANDWIDTH TO IMPROVE REAL-TIME EFFICIENCY 
	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	ktrig	changed	gkfundHz,gkbw			;IF FUNDAMENTAL OR BANDWIDTH ARE CHANGED GENERATE A TRIGGER IMPULSE
	if ktrig==1 then				
	  reinit	UPDATE				;REINIT FROM 'UPDATE' WHENEVER FUNDAMENTAL OR BANDWIDTH ARE CHANGED
	endif
	UPDATE:
	ibw	=		i(gkbw)			;BANDWIDTH AS A FRACTION OF THE BAND FREQUENCY
	iFund	=		i(gkfundHz)		;FUNDAMENTAL FREQUENCY

	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; DEFINE A MACRO FOR THE CODE FOR AN ANALYSIS BAND 
	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
#define	BAND(N)
	#
	iFrq$N	=		iFund*$N                                                            
	if gkAnaOnOff==1 then					;IF SPECTRUM ANALYSER ON/OFF SWITCH IS ON...
	  if iFrq$N>=sr/2 then					;IF THIS FREQUENCY BAND EXCEEDS NYQUIST...
	    gk$N = 0						;SET STRENGTH FOR THIS BAND TO ZERO
	    goto SKIP$N						;SKIP ALL OTHER PROCESSING FOR THIS BAND
	  endif							
	  ab$N	butbp		asig, iFrq$N, iFrq$N * ibw	;...BANDPASS FILTER INPUT AUDIO SIGNAL
	  ab$N	butbp		ab$N, iFrq$N, iFrq$N * ibw	;BANDPASS FILTERING IS REPEATED IN ORDER TO SHARPEN CUTOFF SLOPES
	  gk$N	rms		ab$N				;SCAN RMS OF ANALYSIS BAND
	  gk$N	portk		gk$N,gksmoothing		;SMOOTH RMS SIGNAL
	endif
	SKIP$N:							;LABEL. SKIP TO HERE IF BAND FREQUENCY IS BEYOND NYQUIST
	#

	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; EXPAND MACRO FOR EACH BAND REQUIRED 
	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	$BAND(1)
	$BAND(2)
	$BAND(3)
	$BAND(4)
	$BAND(5)
	$BAND(6)
	$BAND(7)                              
	$BAND(8)
	$BAND(9)
	$BAND(10)
	$BAND(11)
	$BAND(12)
	$BAND(13)
	$BAND(14)
	$BAND(15)
	$BAND(16)
	$BAND(17)
	$BAND(18)
	$BAND(19)
	$BAND(20)
	$BAND(21)
	$BAND(22)
	$BAND(23)
	$BAND(24)
	$BAND(25)
	$BAND(26)
	$BAND(27)
	$BAND(28)
	$BAND(29)
	$BAND(30)
	$BAND(31)
	$BAND(32)
	$BAND(33)
	$BAND(34)
	$BAND(35)
	$BAND(36)
	$BAND(37)
	$BAND(38)
	$BAND(39)
	$BAND(40)
	$BAND(41)
	$BAND(42)
	$BAND(43)
	$BAND(44)
	$BAND(45)
	$BAND(46)
	$BAND(47)
	$BAND(48)
	$BAND(49)
	$BAND(50)
	$BAND(51)
	$BAND(52)
	$BAND(53)
	$BAND(54)
	$BAND(55)
	$BAND(56)
	$BAND(57)
	$BAND(58)
	$BAND(59)
	$BAND(60)
	$BAND(61)
	$BAND(62)
	$BAND(63)
	$BAND(64)
	$BAND(65)
	$BAND(66)
	$BAND(67)
	$BAND(68)
	$BAND(69)
	$BAND(70)
	$BAND(71)
	$BAND(72)
	$BAND(73)
	$BAND(74)
	$BAND(75)
	$BAND(76)
	$BAND(77)
	$BAND(78)
	$BAND(79)
	$BAND(80)
	$BAND(81)
	$BAND(82)
	$BAND(83)
	$BAND(84)
	$BAND(85)
	$BAND(86)
	$BAND(87)
	$BAND(88)
	$BAND(89)
	$BAND(90)
	$BAND(91)
	$BAND(92)
	$BAND(93)
	$BAND(94)
	$BAND(95)
	$BAND(96)
	$BAND(97)
	$BAND(98)
	$BAND(99)
	$BAND(100)

	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; SCAN FOR MAXIMUM AMPLITUDE SCANNED BY ANY OF THE ANALYSIS BANDS
	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	kmax	max	 gk1,  gk2,  gk3,  gk4,  gk5,  gk6,  gk7,  gk8,  gk9,\
	          gk10, gk11, gk12, gk13, gk14, gk15, gk16, gk17, gk19,\
	          gk20, gk21, gk22, gk23, gk24, gk25, gk26, gk27, gk29,\
	          gk30, gk31, gk32, gk33, gk34, gk35, gk36, gk37, gk39,\
	          gk40, gk41, gk42, gk43, gk44, gk45, gk46, gk47, gk49,\
	          gk50, gk51, gk52, gk53, gk54, gk55, gk56, gk57, gk59,\
	          gk60, gk61, gk62, gk63, gk64, gk65, gk66, gk67, gk69,\
	          gk70, gk71, gk72, gk73, gk74, gk75, gk76, gk77, gk79,\
	          gk80, gk81, gk82, gk83, gk84, gk85, gk86, gk87, gk89,\
	          gk90, gk91, gk92, gk93, gk94, gk95, gk96, gk97, gk99, gk100
	koldmax	init	0				;INITIALISATION OF THE MAXIMUM OLD VALUE (FOR THE FIRST PASS)
	kporttime	=	(kmax<koldmax?0.4:0.01)	;PORTAMENTO HIGHER WHEN THE METER IS ON THE WAY DOWN
	kmax	portk	kmax,kporttime			;PORTAMENTO SMOOTH CHANGES OF THE MAXIMUM VALUE
	koldmax	=	kmax				;SET OLD MAX TO CURRENT MAX (FOR NEXT PASS)
	kmetro	metro	20				;RATE OF UPDATE OF THE METER
	FLsetVal	kmetro,kmax,gihMaxAmp		;SET MAXIMUM AMPLITUDE METER TO THE MAXIMUM AMPLITUDE OUT OF ALL THE ANALYSIS BANDSS
			outs		asig*gkpostgain,asig*gkpostgain		; SEND AUDIO TO OUTPUT	
endin                                                                                                                                        

instr	2       ;WRITE SNAPSHOT OF WAVEFORM SCANNED BOTH AS A GEN 10 HARMONIC WAVEFORM AND A GEN 2 LIST OF VALS
	giwave	ftgen	2, 0, 4096, 10, i(gk1),  i(gk2),  i(gk3),  i(gk4),  i(gk5),  i(gk6),  i(gk7),  i(gk8),  i(gk9),\
	                                i(gk10), i(gk11), i(gk12), i(gk13), i(gk14), i(gk15), i(gk16), i(gk17), i(gk18), i(gk19), \
					i(gk20), i(gk21), i(gk22), i(gk23), i(gk24), i(gk25), i(gk26), i(gk27), i(gk28), i(gk29), \ 	
					i(gk30), i(gk31), i(gk32), i(gk33), i(gk34), i(gk35), i(gk36), i(gk37), i(gk38), i(gk39), \
					i(gk40), i(gk41), i(gk42), i(gk43), i(gk44), i(gk45), i(gk46), i(gk47), i(gk48), i(gk49), \
					i(gk50), i(gk51), i(gk52), i(gk53), i(gk54), i(gk55), i(gk56), i(gk57), i(gk58), i(gk59), \
					i(gk60), i(gk61), i(gk62), i(gk63), i(gk64), i(gk65), i(gk66), i(gk67), i(gk68), i(gk69), \
					i(gk70), i(gk71), i(gk72), i(gk73), i(gk74), i(gk75), i(gk76), i(gk77), i(gk78), i(gk79), \
					i(gk80), i(gk81), i(gk82), i(gk83), i(gk84), i(gk85), i(gk86), i(gk87), i(gk88), i(gk89), \
					i(gk90), i(gk91), i(gk92), i(gk93), i(gk94), i(gk95), i(gk96), i(gk97), i(gk98), i(gk99), i(gk100) 	
	givals	ftgen	3,0,-100,-2,    i(gk1),  i(gk2),  i(gk3),  i(gk4),  i(gk5),  i(gk6),  i(gk7),  i(gk8),  i(gk9),   i(gk10), i(gk11), i(gk12), i(gk13), i(gk14), i(gk15), i(gk16), i(gk17), i(gk18), i(gk19),  i(gk20), i(gk21), i(gk22), i(gk23), i(gk24), i(gk25), i(gk26), i(gk27), i(gk28), i(gk29),  i(gk30), i(gk31), i(gk32), i(gk33), i(gk34), i(gk35), i(gk36), i(gk37), i(gk38), i(gk39),  i(gk40), i(gk41), i(gk42), i(gk43), i(gk44), i(gk45), i(gk46), i(gk47), i(gk48), i(gk49),  i(gk50), i(gk51), i(gk52), i(gk53), i(gk54), i(gk55), i(gk56), i(gk57), i(gk58), i(gk59), i(gk60), i(gk61), i(gk62), i(gk63), i(gk64), i(gk65), i(gk66), i(gk67), i(gk68), i(gk69), i(gk70), i(gk71), i(gk72), i(gk73), i(gk74), i(gk75), i(gk76), i(gk77), i(gk78), i(gk79), i(gk80), i(gk81), i(gk82), i(gk83), i(gk84), i(gk85), i(gk86), i(gk87), i(gk88), i(gk89), i(gk90), i(gk91), i(gk92), i(gk93), i(gk94), i(gk95), i(gk96), i(gk97), i(gk98), i(gk99), i(gk100)
endin

instr	3	;PLAY TONE BASED ON STORED GEN10 TABLE
	kporttime	linseg	0,0.01,0.01			;PORTAMENTO FUNCTION RAMPS UP QUICKLY FROM ZERO TO A FIXED VALUE
	kToneVol	portk	gkToneVol,kporttime		;APPLY PORTAMENTO TO FLTK AUDIO TONE VOLUME CONTROL
	if gkPlayTone==0 then
	  turnoff
	endif
	asig	poscil	ampdbfs(kToneVol),gkfundHz,2		;GENERATE AN AUDIO TONE
		outs	asig,asig				;SEND TO OUTPUTS
endin

instr	4	;DUMP TABLE TO A TEXT FILE ON DISK
	; - TEXT WILL BE FORMATTED AS A GEN 10 FUNCTION TABLE READY TO BE COPY-AND-PASTED INTO A NEW ORCHESTRA 
	;READ ALL PARTIAL STRENGTH VALUES FROM GEN 2 TABLE ONE BY ONE
	ival1	table	0	,givals
	ival2	table	1 	,givals
	ival3	table	2 	,givals
	ival4	table	3 	,givals
	ival5	table	4 	,givals
	ival6	table	5 	,givals
	ival7	table	6 	,givals
	ival8	table	7 	,givals
	ival9	table	8 	,givals
	ival10	table	9 	,givals
	ival11	table	10	,givals
	ival12	table	11	,givals
	ival13	table	12	,givals
	ival14	table	13	,givals
	ival15	table	14	,givals
	ival16	table	15	,givals
	ival17	table	16	,givals
	ival18	table	17	,givals
	ival19	table	18	,givals
	ival20	table	19	,givals
	ival21	table	20	,givals
	ival22	table	21	,givals
	ival23	table	22	,givals
	ival24	table	23	,givals
	ival25	table	24	,givals
	ival26	table	25	,givals
	ival27	table	26	,givals
	ival28	table	27	,givals
	ival29	table	28	,givals
	ival30	table	29	,givals
	ival31	table	30	,givals
	ival32	table	31	,givals
	ival33	table	32	,givals
	ival34	table	33	,givals
	ival35	table	34	,givals
	ival36	table	35	,givals
	ival37	table	36	,givals
	ival38	table	37	,givals
	ival39	table	38	,givals
	ival40	table	39	,givals
	ival41	table	40	,givals
	ival42	table	41	,givals
	ival43	table	42	,givals
	ival44	table	43	,givals
	ival45	table	44	,givals
	ival46	table	45	,givals
	ival47	table	46	,givals
	ival48	table	47	,givals
	ival49	table	48	,givals
	ival50	table	49	,givals
	ival51	table	50	,givals
	ival52	table	51	,givals
	ival53	table	52	,givals
	ival54	table	53	,givals
	ival55	table	54	,givals
	ival56	table	55	,givals
	ival57	table	56	,givals
	ival58	table	57	,givals
	ival59	table	58	,givals
	ival60	table	59	,givals
	ival61	table	60	,givals
	ival62	table	61	,givals
	ival63	table	62	,givals
	ival64	table	63	,givals
	ival65	table	64	,givals
	ival66	table	65	,givals
	ival67	table	66	,givals
	ival68	table	67	,givals
	ival69	table	68	,givals
	ival70	table	69	,givals
	ival71	table	70	,givals
	ival72	table	71	,givals
	ival73	table	72	,givals
	ival74	table	73	,givals
	ival75	table	74	,givals
	ival76	table	75	,givals
	ival77	table	76	,givals
	ival78	table	77	,givals
	ival79	table	78	,givals
	ival80	table	79	,givals
	ival81	table	80	,givals
	ival82	table	81	,givals
	ival83	table	82	,givals
	ival84	table	83	,givals
	ival85	table	84	,givals
	ival86	table	85	,givals
	ival87	table	86	,givals
	ival88	table	87	,givals
	ival89	table	88	,givals
	ival90	table	89	,givals
	ival91	table	90	,givals
	ival92	table	91	,givals
	ival93	table	92	,givals
	ival94	table	93	,givals
	ival95	table	94	,givals
	ival96	table	95	,givals
	ival97	table	96	,givals
	ival98	table	97	,givals
	ival99	table	98	,givals
	ival100	table	99	,givals
	;WRITE TEXT FOR A GEN10 FUNCTION TABLE
	fprints "PartialStrengths100.txt", "giwave ftgen 0,0,4096,10,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f%n",\
	    ival1, ival2, ival3, ival4, ival5, ival6, ival7, ival8, ival9,ival10,ival11,ival12,ival13,ival14,ival15,ival16,ival17,ival18,ival19,ival20,\
	    ival21,ival22,ival23,ival24,ival25,ival26,ival27,ival28,ival29,ival30,ival31,ival32,ival33,ival34,ival35,ival36,ival37,ival38,ival39,ival40,\
	    ival41,ival42,ival43,ival44,ival45,ival46,ival47,ival48,ival49,ival50,ival51,ival52,ival53,ival54,ival55,ival56,ival57,ival58,ival59,ival60,\
	    ival61,ival62,ival63,ival64,ival65,ival66,ival67,ival68,ival69,ival70,ival71,ival72,ival73,ival74,ival75,ival76,ival77,ival78,ival79,ival80,\
	    ival81,ival82,ival83,ival84,ival85,ival86,ival87,ival88,ival89,ival90,ival91,ival92,ival93,ival94,ival95,ival96,ival97,ival98,ival99,ival100
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;RUN SPECTRUM ANALYSER
</CsScore>

</CsoundSynthesizer>