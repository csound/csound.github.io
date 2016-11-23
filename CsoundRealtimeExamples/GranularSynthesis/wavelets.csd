wavelets.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE. INCREASING sr (AT THE EXPENSE OF CPU) WILL REDUCE ALIASING.
ksmps 		= 	1	;KR MUST EQUAL SR SO THEREFORE KSMPS MUST BE 1
nchnls 		= 	2	;NUMBER OF CHANNELS
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255,255,255
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"wavelets",   500,     550,   0,  0

;SWITCHES                                		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    120,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X  | Y
idFundMin  	FLvalue   " ",	80,       17,     5, 80
idFundMax  	FLvalue   " ",	80,       17,   415, 80
idFundRateMin  	FLvalue   " ",	80,       17,     5,130
idFundRateMax  	FLvalue   " ",	80,       17,   415,130
gidFundDeReg	FLvalue   " ",	80,       17,     5,175
idFormMin  	FLvalue   " ",	80,       17,     5,230
idFormMax  	FLvalue   " ",	80,       17,   415,230
idFormRateMin  	FLvalue   " ",	80,       17,     5,280
idFormRateMax  	FLvalue   " ",	80,       17,   415,280
idFormDeReg  	FLvalue   " ",	80,       17,     5,325

;SLIDERS								MIN | MAX | EXP | TYPE |   DISP      | WIDTH | HEIGHT | X   | Y
gkOutGain, ihOutGain		FLslider	"Output Gain",		0,     0.2,   0,   23,  -1,             180,     22,  160,     5
gkFundMin, ihFundMin		FLslider	"",			0.1,  5000,  -1,   23,  idFundMin,      490,     15,    5,    50
gkFundMax, ihFundMax		FLslider	"Fund. Rand. Range",	0.1,  5000,  -1,   23,  idFundMax,      490,     15,    5,    65
gkFundRateMin, ihFundRateMin	FLslider	"",			0.01,    2,  -1,   23,  idFundRateMin,  490,     15,    5,   100
gkFundRateMax, ihFundRateMax	FLslider	"Fund. Rand. Rate",	0.01,    2,  -1,   23,  idFundRateMax,  490,     15,    5,   115
gkFundDeReg, ihFundDeReg	FLslider	"Fund. De-regulate",	0.001,0.101, -1,   23,  -1,             490,     25,    5,   150
gkFormMin, ihFormMin		FLslider	"",			4,      14,   0,   23,  idFormMin,      490,     15,    5,   200
gkFormMax, ihFormMax		FLslider	"Form. Rand. Range",	4,      14,   0,   23,  idFormMax,      490,     15,    5,   215
gkFormRateMin, ihFormRateMin	FLslider	"",			0.01,    2,   0,   23,  idFormRateMin,  490,     15,    5,   250
gkFormRateMax, ihFormRateMax	FLslider	"Form. Rand. Rate",	0.01,    2,   0,   23,  idFormRateMax,  490,     15,    5,   265
gkFormDeReg, ihFormDeReg	FLslider	"Form. De-regulate",	0,       5,   0,   23,  idFormDeReg,    490,     25,    5,   300
gkRvbSnd, ihRvbSnd		FLslider	"Rvb. Send",		0,       1,   0,   23,  -1,             240,     25,    5,   450
gkRvbTim, ihRvbTim		FLslider	"Rvb. Time",		0,       1,   0,   23,  -1,             240,     25,  255,   450
gkAmpModDep, ihAmpModDep	FLslider	"Amp. Mod. Depth",	0,       1,   0,   23,  -1,             240,     25,    5,   500
gkPanModDep, ihPanModDep	FLslider	"Pan. Mod. Depth",	0,     0.5,   0,   23,  -1,             240,     25,  255,   500

gkamp1, ihamp1			FLslider	"1",    0,     1,   0,    24,  -1,           15,     70,   85,   355
gkamp2, ihamp2			FLslider	"2",    0,     1,   0,    24,  -1,           15,     70,  105,   355
gkamp3, ihamp3			FLslider	"3",    0,     1,   0,    24,  -1,           15,     70,  125,   355
gkamp4, ihamp4			FLslider	"4",    0,     1,   0,    24,  -1,           15,     70,  145,   355
gkamp5, ihamp5			FLslider	"5",    0,     1,   0,    24,  -1,           15,     70,  165,   355
gkamp6, ihamp6			FLslider	"6",    0,     1,   0,    24,  -1,           15,     70,  185,   355
gkamp7, ihamp7			FLslider	"7",    0,     1,   0,    24,  -1,           15,     70,  205,   355
gkamp8, ihamp8			FLslider	"8",    0,     1,   0,    24,  -1,           15,     70,  225,   355
gkamp9, ihamp9			FLslider	"9",    0,     1,   0,    24,  -1,           15,     70,  245,   355
gkamp10, ihamp10		FLslider	"10",   0,     1,   0,    24,  -1,           15,     70,  265,   355
gkamp11, ihamp11		FLslider	"11",   0,     1,   0,    24,  -1,           15,     70,  285,   355
gkamp12, ihamp12		FLslider	"12",   0,     1,   0,    24,  -1,           15,     70,  305,   355
gkamp13, ihamp13		FLslider	"13",   0,     1,   0,    24,  -1,           15,     70,  325,   355
gkamp14, ihamp14		FLslider	"14",   0,     1,   0,    24,  -1,           15,     70,  345,   355
gkamp15, ihamp15		FLslider	"15",   0,     1,   0,    24,  -1,           15,     70,  365,   355
gkamp16, ihamp16		FLslider	"16",   0,     1,   0,    24,  -1,           15,     70,  385,   355
gkamp17, ihamp17		FLslider	"17",   0,     1,   0,    24,  -1,           15,     70,  405,   355
gkamp18, ihamp18		FLslider	"18",   0,     1,   0,    24,  -1,           15,     70,  425,   355
gkamp19, ihamp19		FLslider	"19",   0,     1,   0,    24,  -1,           15,     70,  445,   355
gkamp20, ihamp20		FLslider	"20",   0,     1,   0,    24,  -1,           15,     70,  465,   355

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"GEN10 Amplitudes", 	1,      1,     14,     85,    15,     0, 370

;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gknum, ihnum		FLcount  	"Num. Wavelets",1,    64,     1,     1,      2,     120,     25,   375, 5,   -1 

; INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	0.2, 	ihOutGain
FLsetVal_i   	0.5, 	ihFundMin
FLsetVal_i   	60, 	ihFundMax
FLsetVal_i   	0.07, 	ihFundRateMin
FLsetVal_i   	0.2, 	ihFundRateMax
FLsetVal_i   	0.001, 	ihFundDeReg
FLsetVal_i   	5, 	ihFormMin
FLsetVal_i   	12, 	ihFormMax
FLsetVal_i   	0.07, 	ihFormRateMin
FLsetVal_i   	0.2, 	ihFormRateMax
FLsetVal_i   	0.001, 	ihFormDeReg
FLsetVal_i   	1, 	ihnum
FLsetVal_i   	0, 	ihamp1
FLsetVal_i   	1, 	ihamp2
FLsetVal_i   	1, 	ihamp3
FLsetVal_i   	1, 	ihamp4
FLsetVal_i   	1, 	ihamp5
FLsetVal_i   	1, 	ihamp6
FLsetVal_i   	1, 	ihamp7
FLsetVal_i   	1, 	ihamp8
FLsetVal_i   	1, 	ihamp9
FLsetVal_i   	1, 	ihamp10
FLsetVal_i   	1, 	ihamp11
FLsetVal_i   	1, 	ihamp12
FLsetVal_i   	1, 	ihamp13
FLsetVal_i   	1, 	ihamp14
FLsetVal_i   	1, 	ihamp15
FLsetVal_i   	1, 	ihamp16
FLsetVal_i   	1, 	ihamp17
FLsetVal_i   	1, 	ihamp18
FLsetVal_i   	1, 	ihamp19
FLsetVal_i   	1, 	ihamp20
FLsetVal_i   	0.4, 	ihRvbSnd
FLsetVal_i   	0.85, 	ihRvbTim
FLsetVal_i   	0.2, 	ihAmpModDep
FLsetVal_i   	0.4, 	ihPanModDep
	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 520, 512, 0
				FLscroll     515, 520, 0,   0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         wavelets                            ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"Wavelet granular synthesis is a special type of granular     ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"synthesis in which each grain begins and end at a zero       ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"crossing in the source waveform, where phase equals zero.    ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"Typically each grain will represent a complete single cycle  ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"of the source waveform. For this reason the source waveform  ", 	1,      5,     14,    490,     20,    5, 120 
ih		 	FLbox  	"should really be a simple monophonic tone. In this example   ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"the source waveform is generated using additive synthesis    ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"techniques via a GEN 10 function table. The user can modify  ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"the structure of overtones in this waveform using the bank of", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"mini sliders. Because each grain is always starting at a zero", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"crossing in the waveform we do not need to worry about       ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"enveloping the amplitude of each grain to prevent clicks.    ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"The type of granular sythesis tone produced is governed by   ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"two main principles: the rate of grain generation which here ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"is referred to (and perceived as) the fundemental (Fund.) of ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"the generated tone, and the pitch of the sound material      ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"within the grain (formant/Form.). As each grain will be very ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"short the pitch of the sound material within the grain will  ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"not be perceived as a steady pitch, instead it will be       ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"perceived as a resonant peak in the tone, the fundemental of ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"which is instead governed by the rate of grain generation.   ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"Clearly wavelet granular synthesis shares many principles    ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"with FOF synthesis.                                          ", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"To faciltate the exploration of these two parameters in this ", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"implementation they are controlled via two random spline     ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"curve generators. For each of these generators the user has  ", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"control over the minimum and maximum values possible and the ", 	1,      5,     14,    490,     20,    5, 540
ih		 	FLbox  	"minimum and maximum rates of change of the generators.       ", 	1,      5,     14,    490,     20,    5, 560
ih		 	FLbox  	"In addition to these two spline generators as a method of    ", 	1,      5,     14,    490,     20,    5, 580
ih		 	FLbox  	"control, fundemental and formant can also be modulated using ", 	1,      5,     14,    490,     20,    5, 600
ih		 	FLbox  	"high frequency randomisation, referred to as 'de-regulation'.", 	1,      5,     14,    490,     20,    5, 620
ih		 	FLbox  	"As mentioned before, normally a wavelet contains just a      ", 	1,      5,     14,    490,     20,    5, 640
ih		 	FLbox  	"single cycle of the waveform but in the example the user can ", 	1,      5,     14,    490,     20,    5, 660
ih		 	FLbox  	"increase the number of wavelets ('Num. Wavelets'). This is   ", 	1,      5,     14,    490,     20,    5, 680
ih		 	FLbox  	"done in integer steps so that each grain will still begin and", 	1,      5,     14,    490,     20,    5, 700
ih		 	FLbox  	"end at a zero crossing. Increasing the number of wavelets per", 	1,      5,     14,    490,     20,    5, 720
ih		 	FLbox  	"grain will increase the apparent resonance of the formant.   ", 	1,      5,     14,    490,     20,    5, 740                                                             
ih		 	FLbox  	"In addition reverb can be added as well as a slow random     ", 	1,      5,     14,    490,     20,    5, 760
ih		 	FLbox  	"modulation of amplitude and panning.                         ", 	1,      5,     14,    490,     20,    5, 780
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave	ftgen	1,0,4096,10,1

gaL	init	0
gaR	init	0

instr	1	; WAVELET GENERATING INSTRUMENT
	if gkOnOff=0 then
		turnoff
	endif

	;GENERATE A TRIGGER IMPULSE (MOMENTARY '1' VALUE) IN kupdate IF ANY OF THE INPUT ARGUMENTS CHANGE
	kupdate	changed	gkamp1, gkamp2, gkamp3, gkamp6, gkamp5, gkamp6, gkamp7, gkamp8, gkamp9, gkamp10, gkamp11, gkamp12, gkamp13, gkamp14, gkamp15, gkamp16, gkamp17, gkamp18, gkamp19, gkamp20 
	if kupdate=1 then		;IF A TRIGGER IMPULSE HAS BEEN GENERATED...
		reinit	UPDATE		;...BEGIN AN INTIALISATION PASS FROM LABEL 'UPDATE'
		UPDATE:			;LABEL 'UPDATE'
		;CREATE A NEW FUNCTION TABLE TO BE USED BY THE AUDIO OSCILLLATOR IN INSTR 2
		giwave	ftgen	1,0,4096,10,1-i(gkamp1), 1-i(gkamp2), 1-i(gkamp3), 1-i(gkamp6), 1-i(gkamp5), 1-i(gkamp6), 1-i(gkamp7), 1-i(gkamp8), 1-i(gkamp9), 1-i(gkamp10), 1-i(gkamp11), 1-i(gkamp12), 1-i(gkamp13), 1-i(gkamp14), 1-i(gkamp15), 1-i(gkamp16), 1-i(gkamp17), 1-i(gkamp18), 1-i(gkamp19), 1-i(gkamp20)
		rireturn		;RETURN FROM REINITIALISATION PASS
	endif
	krate	rspline	gkFundMin, gkFundMax, gkFundRateMin, gkFundRateMax	;RATE OF WAVELET GENERATION
	ktrigger	metro	krate						;GENERATE A STREAM OF TRIGGER IMPULSES '1' VALUES OVER A BED OF ZEROES
	koct	rspline	gkFormMin, gkFormMax, gkFormRateMin, gkFormRateMax	;PITCH OF THE WAVEFORM CONTAINED WITHIN THE WAVELET (IN oct FORMAT)
	kFormOS	gauss	gkFormDeReg
	kcps	=	cpsoct(koct+kFormOS)					;CONVERT oct FORMAT VARIABLE TO A cps FORMAT VARIABLE
	kamp	rspline	1-gkAmpModDep, 1, 0.05, 0.1					;AMPLITUDE OF WAVELET TRAIN DEFINED BY A RANDOM SPLINE
	kpan	rspline	0.5-gkPanModDep, 0.5+gkPanModDep, 0.1, 0.2					;PANNING OF WAVELET TRAIN DEFINED BY A RANDOM SPLINE
	kDelay	exprand	gkFundDeReg-0.001
	;GENERATE A WAVELET:
	;                                                   p4    p5    p6
	schedkwhen	ktrigger, 0, 0, 2, kDelay, 0.001, kcps, kamp, kpan	;p3 IS IRRELEVANT AS IT WILL BE DEFINED IN INSTR 2
endin

instr	2	;WAVELET SOUNDING INSTRUMENT
	icps	=	p4
	p3	=	i(gknum)/icps	;NOTE DURATION WILL BE DESCRIBED AS A PRECISE NUMBER OF COMPLETE CYCLES OF THE OSCILLATOR WAVEFORM
	a1	poscil	gkOutGain*p5,icps,giwave
	
	aL,aR	pan2	a1, p6
	outs	aL,aR
	gaL	=	gaL+aL*gkRvbSnd
	gaR	=	gaR+aL*gkRvbSnd
endin

instr	4	;REVERB
	aRvbL,aRvbR	reverbsc	gaL,gaR,gkRvbTim,5000
	outs	aRvbL,aRvbR
	clear	gaL,gaR
endin

instr	5	;UPDATE DE-REGULATE DISPLAY BOX
	FLprintk2	gkFundDeReg-0.001, gidFundDeReg
endin

</CsInstruments>

<CsScore>
f 0 3600
i 4 0 3600	;REVERB
i 5 0 3600	;UPDATE DE-REGULATE DISPLAY BOX
</CsScore>

</CsoundSynthesizer>