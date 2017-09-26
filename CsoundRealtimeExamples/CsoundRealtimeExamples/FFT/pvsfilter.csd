pvsfilter.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	16
nchnls	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL       | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsfilter",   500,    420,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    500,    166,    0, 32	;BORDER AROUND FILTERING SIGNAL TEMPLATE
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 280	;BORDER AROUND FFT ATTRIBUTES
ih		 	FLbox  	" ", 	6,      9,     15,    160,     80,    5, 200	;BORDER AROUND INPUT SELECTOR
ih		 	FLbox  	" ", 	6,      9,     15,    320,     80,  170, 200	;BORDER AROUND MIXER

;BUTTONS						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    120,     25,    5,  3,    0,      5,      0,       0.01
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idpow		FLvalue	" ",       70,     18,  210,   80
idfreq		FLvalue	" ",      100,     18,   10,  125
idmltfreq	FLvalue	" ",      100,     18,   10,  170

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X |  Y  | OPCODE P1 P2  P3
gkpartials, ihpartials		FLcount  "No. of Partials", 	1,     60,     1,      1,      2,    100,     25,   10, 55,    0,   1, 0, 0.01
gkoffset, ihoffset		FLcount  "Offset", 		0,     59,     1,      1,      2,    100,     25,  110, 55,    0,   1, 0, 0.01
gkmode, ihmode			FLcount  "Mode", 		1,      2,     1,      1,      2,     50,     25,  440, 55,    -1

;SLIDERS				            					MIN | MAX   | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X   | Y
gkpow, ihpow			FLslider	"Power",				0.01,     2,    0,   23,   idpow,        230,    25,   210,    55
gkfreq, gihfreq			FLslider	"Frequency",				20,   10000,   -1,   23,   idfreq,       480,    25,    10,   100
gkmltfreq, ihmltfreq		FLslider	"Mult Frequency",			0.1,      2,    0,   23,   idmltfreq,    480,    25,    10,   145
gkDrySigGain, ihDrySigGain	FLslider	"Dry Signal",				0,        1,    0,   23,   -1,           250,    12,   230,   204
gkFiltSigGain, ihFiltSigGain	FLslider	"Filter Signal",			0,        1,    0,   23,   -1,           250,    12,   230,   229
gkResSigGain, ihResSigGain	FLslider	"Resultant Signal",			0,       10,    0,   23,   -1,           250,    12,   230,   254

;MODIFY VALUATOR LABEL SIZES
FLsetTextSize 10, ihDrySigGain
FLsetTextSize 10, ihFiltSigGain
FLsetTextSize 10, ihResSigGain

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	4,      1,     3,     18,      60,    55,210,   -1
gkFFTattributes, ihFFTattributes	FLbutBank	4,      1,     4,     18,      78,   120,320,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X  |  Y
ih		 	FLbox  	"Live Input", 						1,       5,    12,     70,     25,    78,  206
ih		 	FLbox  	"Songpan   ", 						1,       5,    12,     70,     25,    78,  226
ih		 	FLbox  	"Drum Loop ", 						1,       5,    12,     70,     25,    78,  246
ih		 	FLbox  	"FFT Attributes",       				1,       4,    14,    100,     25,    15,  285
ih		 	FLbox  	"Input",       						1,       4,    14,     30,     25,    15,  205
ih		 	FLbox  	"Mixer",       						1,       4,    14,     30,     25,   185,  205
ih		 	FLbox  	"Filtering Template Signal",				1,       4,    14,    180,     15,     5,   35
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,     20,   140,  300
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,    340,     20,   140,  318
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,    340,     20,   140,  338
ih		 	FLbox  	" 2048        128        2048            1     ",	1,       5,    11,    340,     20,   140,  358
ih		 	FLbox  	" 4096        128        4096            1     ",	1,       5,    11,    340,     20,   140,  378

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	1, 	ihFFTattributes
			FLsetVal_i	8, 	ihpartials
			FLsetVal_i	0, 	ihoffset
			FLsetVal_i	250, 	gihfreq
			FLsetVal_i	1, 	ihmltfreq
			FLsetVal_i	1, 	ihpow
			FLsetVal_i	0, 	ihDrySigGain
			FLsetVal_i	0, 	ihFiltSigGain
			FLsetVal_i	1, 	ihResSigGain
			FLsetVal_i	1, 	ihmode

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     460,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvsfilter                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvsfilter filters an fsig according to the spectral content  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"of another signal. This allows for complex spectrally dynamic", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"filtering.                                                   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"In this example the filter signal used as the template for   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the filtering process is an additive synthesis tone. The     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"user has a number of controls over this tone, namely         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"'Frequency', 'Number of Partials', 'Offset' (lowest partial),", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"'Power' (a kind of parametric EQ sweep) and finally 'Mult.   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Frequency', which affects how partials are spaced in         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"conjunction with the selection made for mode (1 or 2). For   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"further clarification it is probably best to study the code. ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"A mixer is provided to allow the user to mix between the     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"input signal, the filtering template signal and the sound    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"resulting from the filtering process.                        ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Three options are provided for the input source sound.       ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"The user can select between a variety of combinations of     ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"parameters for the FFT analysis. Larger values for FFT size  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"will give better harmonic reproduction but greater time      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"smearing effects and higher computational cost. Lower values ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"will result in less time smearing but greater harmonic       ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"distortion.                                                  ", 	1,      5,     14,    490,    15,     5, 440

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;TABLES THAT STORE FFT ANALYSIS ATTRIBUTES DATA
giFFTattributes0	ftgen	1, 0, 4, -2,  512, 256, 1024, 1
giFFTattributes1	ftgen	2, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes2	ftgen	3, 0, 4, -2, 2048, 128, 2048, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 4096, 128, 4096, 1
gisine			ftgen	0, 0, 4096, 10, 1  	;SINE WAVE

zakinit	1,1

instr 5		;GENERATES PARTIAL INSTANCES FOR FILTER SIGNAL
	turnon	3		;TURN ON INSTR 3 (FILTERING INSTRUMENT) WITH A HELD NOTE
	turnoff2 2, 0, 1	;CLEAR ALL INSTANCES OF INSTR 2 (FILTER SIGNAL PARTIALS) BEFORE STARTING AGAIN
	kcount init i(gkoffset)+1	;SET INITIAL VALUE OF COUNTER
	begin:				;LABEL
	;         P1 | P2 | P3 |    P4
	event "i",2,    0, 3600,  kcount	;TRIGGER INSTR 2 - I.E. A PARTIAL
	kcount = kcount + 1			;INCREMENT COUNTER
	if (kcount <= i(gkpartials)) kgoto begin	;IF MAX NUMBER OF PARTIALS NOT YET REACHED GO BACK TO LABEL 'BEGIN'
	turnoff						;TUNOFF THIS INSTRUMENT - ITS JOB OS DONE
endin
 
instr 2		;PARTIAL FOR FILTER SIGNAL (MAY BE CALLED MULTIPLES TIME BY INSTR 1)
	if gkOnOff=0 then	;IF ON/OFF BUTTON IS OFF...
		turnoff2 2, 0, 0
	endif			;END OF CONDITIONAL BRANCHING
	iporttime	=	0.1				;GENERATE A RAMPING-UP VARIABLE FOR PORTAMENTO TIME
	kporttime	linseg	0,0.001,iporttime,1,iporttime   ;GENERATE A RAMPING-UP VARIABLE FOR PORTAMENTO TIME
	kfreq		portk	gkfreq, kporttime               ;APPLY PORTAMENTO TO SMOOTH SLIDER MOVEMENT
	kpow		portk	gkpow, kporttime                ;APPLY PORTAMENTO TO SMOOTH SLIDER MOVEMENT
	kmltfreq	portk	gkmltfreq, kporttime            ;APPLY PORTAMENTO TO SMOOTH SLIDER MOVEMENT
	if	gkmode=1	then
		kfrq	limit	p4*kfreq*(kmltfreq^p4), 20, sr/2	;LIMIT FREQUENCY OF PARTIAL TO BELOW NYQUIST FREQ.
	elseif	gkmode=2	then
		kfrq	limit	gkfreq*(1+gkmltfreq^(p4-1)), 20, sr/2	;LIMIT FREQUENCY OF PARTIAL TO BELOW NYQUIST FREQ.
	endif
	a1 oscili (1/gkpartials)*(kpow^p4), kfrq, gisine	;GENERATE A PARTIAL
	zawm	a1, 1						;ADD IT TO ZAK VARIABLE
endin

instr 		3	;FILTERING INSTRUMENT
	kSwitch		changed		gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF I-RATE VARIABLE IS CHANGED...
		reinit	UPDATE		;BEGIN A REINITIALISATION PASS IN ORDER TO EFFECT THIS CHANGE. BEGIN THIS PASS AT LABEL ENTITLED 'UPDATE' AND CONTINUE UNTIL rireturn OPCODE 
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;LABEL
	if		gkinput=0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		asig		inch		1		;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
	elseif		gkinput=1 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH    | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig,aR	diskin2		"Songpan.wav",    	1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"loop.wav",         1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	if		gkOnOff!=0	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH. IF ON, SKIP THE NEXT LINE
		turnoff                                         ;TURN THIS INSTRUMENT OFF IMMEDIATELY               
	CONTINUE:                                               ;LABEL                                              
	iFFTsize	table	0, i(gkFFTattributes)+1	;READ FFT SIZE FROM APPROPRIATE TABLE    
	ioverlap	table	1, i(gkFFTattributes)+1	;READ OVERLAP SIZE FROM APPROPRIATE TABLE
	iwinsize	table	2, i(gkFFTattributes)+1	;READ WINDOW SIZE FROM APPROPRIATE TABLE 
	iwintype	table	3, i(gkFFTattributes)+1	;READ WINDOW TYPE FROM APPROPRIATE TABLE
	fsigIn  		pvsanal		asig, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.

	aFiltSig	zar	1	;READ IN FILTER SIGNAL FROM ZAK VARIABLE
	aBalSig		oscili	1,1000,gisine	;SPECIFY A BALANCING SIGNAL REFERENCE
	aFiltSig	balance	aFiltSig, aBalSig	;BALANCE FILTER SIGNAL
	kenv	linseg	0,0.1,1,1,1	;AMP ENVELOPE
	fsigFilt  		pvsanal		aFiltSig*kenv, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE FILTER AUDIO SIGNAL. OUTPUT AN F-SIGNAL.

	fsigOut		pvsfilter		fsigIn, fsigFilt, 1	;PERFORM fsig FILTERING

	aresyn 		pvsynth  	fsigOut                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL

	aout		sum	asig*gkDrySigGain, aFiltSig*gkFiltSigGain, aresyn*gkResSigGain	;MIXER
	
			outs		aout, aout				;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
	zacl	0,1
	rireturn
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR
e
</CsScore>

</CsoundSynthesizer>