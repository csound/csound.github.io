;24pvswarp.csd
;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	100
nchnls	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"pvswarp",   500,    510,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    170,    5, 334	;BORDER AROUND FFT ATTRIBUTES

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idscal			FLvalue	" ",	 80,      20,    5,  75
idshift			FLvalue	" ",	 80,      20,    5, 125
idlowest		FLvalue	" ",	 80,      20,    5, 175
idgain			FLvalue	" ",	 80,      20,    5, 305

;SLIDERS								MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkscal, ihscal			FLslider 	"Scale",		0.01,  10,   0,    23,    idscal,      490,     25,    5,   50
gkshift, ihshift		FLslider 	"Shift",		0,   5000,   0,    23,    idshift,     490,     25,    5,  100
gklowest, ihlowest		FLslider 	"Lowest Frequency",	1,  20000,  -1,    23,    idlowest,    490,     25,    5,  150
gkgain, ihgain			FLslider 	"Gain",			0,      2,   0,    23,    idgain,      490,     25,    5,  280

;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkcoefs, ihcoefs	FLcount  	"Num. Coefs.", 	1,    200,    1,     10,     1,     120,     25,   350,200,   -1 

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;					FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,  ihinput			FLbutBank	4,      1,     4,     18,      80,     5,198,   -1
gkmeth, ihmeth				FLbutBank	4,      1,     2,     18,      40,   150,198,   -1
gkFFTattributes, ihFFTattributes	FLbutBank	4,      1,     6,     18,     118,   120,374,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 			1,       5,    12,    70,      20,   23, 197
ih		 	FLbox  	"Voice     ", 			1,       5,    12,    70,      20,   23, 217
ih		 	FLbox  	"Drum Loop ", 			1,       5,    12,    70,      20,   23, 237
ih		 	FLbox  	"Synth Pad ", 			1,       5,    12,    70,      20,   23, 257
ih		 	FLbox  	"Liftered Cepstrum Method",	1,       5,    12,   170,      20,  168, 197
ih		 	FLbox  	"True Envelope Method    ",	1,       5,    12,   170,      20,  168, 217
ih		 	FLbox  	"FFT Attributes",       	1,       4,    14,   100,      25,   15, 339
;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  374
ih		 	FLbox  	"   256       128         256            1     ",	1,       5,    11,    340,      20,  140,  372
ih		 	FLbox  	"   256       128         256            1     ",	1,       5,    11,    340,      20,  140,  392
ih		 	FLbox  	"   512       128         512            1     ",	1,       5,    11,    340,      20,  140,  412
ih		 	FLbox  	"  1024       128        1024            1     ",	1,       5,    11,    340,      20,  140,  432
ih		 	FLbox  	"  2048       256        2048            1     ",	1,       5,    11,    340,      20,  140,  452
ih		 	FLbox  	"  4096       512        4096            1     ",	1,       5,    11,    340,      20,  140,  472

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	1, 	ihscal
			FLsetVal_i	0, 	ihshift
			FLsetVal_i	1, 	ihlowest
			FLsetVal_i	0.5, 	ihgain
			FLsetVal_i	80, 	ihcoefs
			FLsetVal_i	3, 	ihFFTattributes

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     480,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            pvswarp                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvswarp performs modulation of the spectral envelope of an   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"audio signal (in the form of an fsig) in two ways:           ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"'Scale' stretches or compresses the envelope through         ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"multiplication. A value of '1' will leave the spectral       ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"envelope unchanged.                                          ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"'Shift' moves the spectral envelope up or down through       ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"addition. A value of zero will leave the spectrum unshifted. ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Two methods of spectral envelope extraction are offered and  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the number of cepstrum coefficients used in spectral         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"preservation can be modulated.                               ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"The 'Lowest Frequency' parameter sets the lowest frequency to", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"which frequency shifting will be applied. This setting has no", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"affect on 'scaling' modifications.                           ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"A variety of combinations of FFT analysis attributes are     ", 	1,      5,     14,    490,    15,     5, 300  
ih		 	FLbox  	"selectable using radio button selectors. It can be observed  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"that smaller FFT size and window sizes results in less time  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"smearing but greater harmonic distortion whereas larger FFT  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"sizes and window sizes results in greater time smearing but  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"less harmonic distortion.                                    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Changing FFT attributes while a note is playing can have     ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"unexpected results. If this happens just cycle the 'On/Off'  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"switch.                                                      ", 	1,      5,     14,    490,    15,     5, 460

			FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giFFTattributes0	ftgen	1, 0, 4, -2,  256, 128,  256, 1
giFFTattributes1	ftgen	2, 0, 4, -2,  256, 128,  256, 1
giFFTattributes2	ftgen	3, 0, 4, -2,  512, 128,  512, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 1024, 128, 1024, 1
giFFTattributes4	ftgen	5, 0, 4, -2, 2048, 256, 2048, 1
giFFTattributes5	ftgen	6, 0, 4, -2, 4096, 512, 4096, 1
                                                     
instr	1
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if		gkinput==0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		aL	inch		1		;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
		aR	=		aL		;SET RIGHT CHANNEL TO BE THE SAME AS THE LEFT CHANNEL AS WE ARE USING A MONO INPUT
	elseif		gkinput==1 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		aL		diskin2		"AndItsAll.wav",    1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
		aR	=		aL		;SET RIGHT CHANNEL TO BE THE SAME AS THE LEFT CHANNEL AS WE ARE USING A MONO INPUT
	elseif		gkinput==2 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		aL,aR		diskin2		"808loop.wav",     1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	else							;OTHERWISE...
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		aL,aR		diskin2		"SynthPad.wav",     1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	kSwitch		changed		gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif					;END OF CONDITIONAL BRANCHING
	START:					;LABEL
	iFFTsize	table	0, i(gkFFTattributes)+1       ;READ FFT ATTRIBUTE FROM THE APPROPRIATE FUNCTION TABLE
	ioverlap	table	1, i(gkFFTattributes)+1       ;READ FFT ATTRIBUTE FROM THE APPROPRIATE FUNCTION TABLE
	iwinsize	table	2, i(gkFFTattributes)+1       ;READ FFT ATTRIBUTE FROM THE APPROPRIATE FUNCTION TABLE
	iwintype	table	3, i(gkFFTattributes)+1	       ;READ FFT ATTRIBUTE FROM THE APPROPRIATE FUNCTION TABLE
	fsig1L 		pvsanal		aL, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL
	fsig1R 		pvsanal		aR, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL
	imaxdel		=		4				;VARIBALE THAT WILL BE USED TO DEFINE MAXIMUM DELAY TIME FOR pvsblur PROCESSING. THIS INFORMATION IS NEEDED FOR MEMORY ALLOCATION.
	kporttime	linseg	0,0.01,0.05          		;CREATE A FUNCTION THAT RAMPS UP QUICKLY FROM ZERO TO A HELD VALUE OF 0.05 THAT WILL BE USED TO DEFINE PORTAMENTO TIME
	kscal		portk		gkscal, kporttime	;APPLY PORTAMENTO SMOOTHING TO THE SLIDER VARIABLE
	kshift		portk		gkshift, kporttime	;APPLY PORTAMENTO SMOOTHING TO THE SLIDER VARIABLE
	klowest		portk		gklowest, kporttime	;APPLY PORTAMENTO SMOOTHING TO THE SLIDER VARIABLE
	kgain		portk		gkgain, kporttime	;APPLY PORTAMENTO SMOOTHING TO THE SLIDER VARIABLE
	fsig2L		pvswarp		fsig1L, kscal, kshift, klowest-1, gkmeth+1, kgain, gkcoefs	;PERFORM SPECTRAL ENVELOPE WARPING ON THE FSIG
	fsig2R		pvswarp		fsig1R, kscal, kshift, klowest-1, gkmeth+1, kgain, gkcoefs	;PERFORM SPECTRAL ENVELOPE WARPING ON THE FSIG
	;OUTPUT		OPCODE		INPUT    	
	aresynL		pvsynth  	fsig2L         	;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	aresynR		pvsynth  	fsig2R         	;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	outs		aresynL, aresynR		;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
			rireturn			;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>