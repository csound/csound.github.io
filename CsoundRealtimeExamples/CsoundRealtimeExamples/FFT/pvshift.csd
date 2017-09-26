pvshift.csd
requires Csound version 5.14 or above
Written by Iain McCurdy 2009

<CsoundSynthesizer>

<CsOptions>
-iadc -odac
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	64
nchnls	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"pvshift",   500,    770,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 380	;BORDER AROUND FFT ATTRIBUTES

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    120,     25,    5,    5,    0,     1,      0,      -1
gkzeroC,ih		FLbutton	"zero",		1,    0,    21,     70,     20,  425,   75,    0,     4,      0,       0
gkzeroF,ih		FLbutton	"zero",		1,    0,    21,     70,     20,  425,  125,    0,     5,      0,       0
gkto1,ih		FLbutton	"to 1",		1,    0,    21,     70,     20,  425,  745,    0,     6,      0,       0
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
                                              
;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idshiftC		FLvalue	" ",	 80,      20,    5,  75
idshiftF		FLvalue	" ",	 80,      20,    5, 125
idgain			FLvalue	" ",	 80,      20,    5, 175
idlowest		FLvalue	" ",	 80,      20,    5, 225
idOutGain		FLvalue	" ",	 80,      20,    5, 275
idfeedback		FLvalue	" ",	 80,      20,    5, 545
idDiskinSpeed		FLvalue	" ",	 80,      20,    5, 745

;SLIDERS				            				MIN   |  MAX | EXP | TYPE |    DISP     | WIDTH | HEIGHT | X  | Y
gkshiftC, gihshiftC		FLslider 	"Frequency Shift Coarse",	-5000,  5000,   0,    23,      idshiftC,   490,     25,    5,   50
gkshiftF, gihshiftF		FLslider 	"Frequency Shift Fine",		-10,      10,   0,    23,      idshiftF,   490,     25,    5,  100
gkgain, ihgain			FLslider 	"Gain Rescale",			0,         4,   0,    23,        idgain,   490,     25,    5,  150
gklowest, ihlowest		FLslider 	"Lowest Frequency",		1,     20000,  -1,    23,      idlowest,   490,     25,    5,  200
gkOutGain, ihOutGain		FLslider 	"Output Gain",			0,         1,   0,    23,     idOutGain,   490,     25,    5,  250
gkfeedback, ihfeedback		FLslider 	"Feedback",			0,         1,   0,    23,    idfeedback,   490,     25,    5,  520
gkDryWetMix, ihDryWetMix	FLslider 	"Dry/Wet Mix",			0,         1,   0,    23,            -1,   490,     25,    5,  620
gkInputGain, ihInputGain	FLslider 	"Input Gain",			0,         1,   0,    23,            -1,   490,     25,    5,  670
gkDiskinSpeed, gihDiskinSpeed	FLslider 	"Diskin Speed",			0.125,     2,  -1,    23, idDiskinSpeed,   490,     25,    5,  720

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS				 		TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  | Y  | OPCODE
gkkeepform,   ihkeepform		FLbutBank	14,     1,     3,     18,      50,   200,   0,   -1
gkinput,   ihinput			FLbutBank	14,     1,     3,     30,      75,     5, 302,   -1
gkFFTattributes, ihFFTattributes	FLbutBank	14,     1,     4,     18,      78,   120, 420,   -1
gkFBmethod, ihFBmethod			FLbutBank	14,     1,     2,     18,      30,   120, 570,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 						1,       5,    11,    70,      25,    32,  302
ih		 	FLbox  	"Voice     ", 						1,       5,    11,    70,      25,    32,  327
ih		 	FLbox  	"Drum Loop ", 						1,       5,    11,    70,      25,    32,  352
ih		 	FLbox  	"FFT Attributes",       				1,       4,    14,   100,      25,    15,  385
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  400
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,    340,      20,  140,  418
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,    340,      20,  140,  438
ih		 	FLbox  	" 2048        128        2048            1     ",	1,       5,    11,    340,      20,  140,  458
ih		 	FLbox  	" 4096        128        4096            1     ",	1,       5,    11,    340,      20,  140,  478
ih		 	FLbox  	"Do not preserve formants       ",			1,       5,    12,    230,      16,  220,    0
ih		 	FLbox  	"Impose original amplitudes     ",			1,       5,    12,    230,      16,  220,   16
ih		 	FLbox  	"Keep original spectral envelope",			1,       5,    12,    230,      16,  220,   32
ih		 	FLbox  	"Feedback Method:", 					1,       6,    11,   120,      15,     0,  570
ih		 	FLbox  	"Audio   ", 						1,       5,    11,    70,      15,   140,  570
ih		 	FLbox  	"F-signal", 						1,       5,    11,    70,      15,   140,  585

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	0, 	gihshiftC
			FLsetVal_i	0, 	gihshiftF
			FLsetVal_i	1, 	ihgain
			FLsetVal_i	0, 	ihkeepform
			FLsetVal_i	10, 	ihlowest
			FLsetVal_i	0.7, 	ihOutGain
			FLsetVal_i	1, 	ihFFTattributes
			FLsetVal_i	0, 	ihfeedback
			FLsetVal_i	1, 	ihFBmethod
			FLsetVal_i	1, 	ihDryWetMix
			FLsetVal_i	1, 	ihInputGain
			FLsetVal_i	1, 	gihDiskinSpeed

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     620,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvshift                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Pvshift shifts all frequency values of an fsig by a constant ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"cycles-per-second value. As frequency values are shifted     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"upwards the spectrum of the sound is also compressed as,     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"relatively speaking, higher frequencies will be transposed by", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"less than lower frequencies.                                 ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"The next example appends the pvscale opcode in the fsig      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"processing chain to allow the user to allow the user to      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"compensate for this overall raising of frequencies and to    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"restore the fundemental to its original value by giving      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"the frequency rescale parameter a value less than 1.         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"(See example 'pvscale.csd' for info on pvscale opcode.)      ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Pvshift also includes three modes of dealing with formants of", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the original signal in the frequency shift. These modes are  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"the same as those used by the pvscale opcode - see the       ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"'pvscale.csd' example (or the Csound Reference Manual) for   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"further information about these modes.                       ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"The parameter controlled by the 'Lowest Frequency' slider    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"defines a frequency beneath which frequencies of the fsig    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"will be unaffected by pvshift.                               ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"A variety of combinations of FFT analysis attributes are     ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"selectable using radio button selectors. It can be observed  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"that smaller FFT size and window sizes result in less time   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"smearing but greater harmonic distortion whereas larger FFT  ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"sizes and window sizes result in greater time smearing but   ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"less harmonic distortion.                                    ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"A feedback control allows the user the control the amount of ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"the output signal that is fed back into the input. The signal", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"that is fed back can be either the fsig or the resynthesized ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"audio signal.                                                ", 	1,      5,     14,    490,    15,     5, 600

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gasig		init		0

giFFTattributes0	ftgen	1, 0, 4, -2,  512, 256, 1024, 1
giFFTattributes1	ftgen	2, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes2	ftgen	3, 0, 4, -2, 2048, 128, 2048, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 4096, 128, 4096, 1

instr	1	;SOUND PRODUCING AND TRANSFORMING INSTRUMENT
	aresyn		init	0	;FEEDBACK SIGNAL INITIALISED TO ZERO FOR FIRST PASS
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING

	if		gkinput=0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		asig		inch		1				;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
	elseif		gkinput=1 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED        | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"AndItsAll.wav", gkDiskinSpeed,     0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH  |     SPEED     | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"loop.wav", gkDiskinSpeed,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	asig	=	asig*gkInputGain	;SCALE INPUT SIGNAL BY GAIN CONTROL SLIDER
	kSwitch		changed		gkgain, gkkeepform, gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	iFFTsize	table	0, i(gkFFTattributes)+1
	ioverlap	table	1, i(gkFFTattributes)+1
	iwinsize	table	2, i(gkFFTattributes)+1
	iwintype	table	3, i(gkFFTattributes)+1	

	;OLD FEEDBACK METHOD WHICH FEEDS BACK AN AUDIO SIGNAL
	if gkFBmethod==0 then
	 aresyn		init	0	;FEEDBACK SIGNAL INITIALISED TO ZERO FOR FIRST PASS
	 fsig1  		pvsanal		asig+(aresyn*gkfeedback), iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.
	 ;OUTPUT		OPCODE		INPUT | RESCALE_VALUE | FORMANT_MODE |   GAIN
	 fsig2 		pvshift fsig1,gkshiftC+gkshiftF, gklowest, i(gkkeepform), i(gkgain)	;SHIFT FREQUENCIES OF THE INPUT F-SIGNAL
	 rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	 ;OUTPUT		OPCODE		INPUT
	 aresyn 		pvsynth  	fsig2                      			;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	else	;NEW F-SIG FEEDBACK METHOD - REQUIRES CSOUND VERSION 5.14
	 fsig1L  	pvsanal	asig, iFFTsize, ioverlap, iwinsize, iwintype			;ANALYSE AUDIO INPUT SIGNAL AND OUTPUT AN FSIG
	 fsig2L		pvsinit iFFTsize,ioverlap,iwinsize,iwintype, 0				;INITIALISE FEEDBACK FSIG
	 fsig3L		pvsmix	fsig1L, fsig2L							;MIX AUDIO INPUT WITH FEEDBACK SIGNAL
	 fsig4L 	pvshift fsig3L, gkshiftC+gkshiftF, gklowest, i(gkkeepform), i(gkgain)	;SHIFT FREQUENCIES OF THE INPUT F-SIGNAL
	 fsig2L		pvsgain fsig4L, gkfeedback 						;CREATE FEEDBACK F-SIGNAL FOR NEXT PASS
			rireturn								;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	 aresyn		pvsynth fsig4L                      					;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	endif

	amix		ntrpol		asig, aresyn, gkDryWetMix				;CREATE DRY/WET MIX
			outs		amix * gkOutGain, amix * gkOutGain			;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

instr	4
	FLsetVal_i	0,gihshiftC
endin

instr	5
	FLsetVal_i	0,gihshiftF
endin

instr	6
	FLsetVal_i	1,gihDiskinSpeed
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>