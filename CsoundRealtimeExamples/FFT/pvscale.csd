pvscale.csd
requires Csound version 5.14 or above
Written by Iain McCurdy, 2007

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -M0 -+rtmidi=virtual
;DISABLE VIRTUAL MIDI FOR EXTERNAL MIDI CONTROL
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	128
nchnls	= 	2
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"pvscale",   500,    620,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 230	;BORDER AROUND FFT ATTRIBUTES

;SWITCHES                                            			ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13	p14	p15	p16	p17	p18	p19	p20	p21	p22	p23	p24	p25	p26	p27	p28	p29	p30	p31	p32	p33
gkFLTK_MIDI,ihFLTK_MIDI		FLbutton	"FLTK/MIDI",		1,    0,    22,    120,     25,    5,    5,    0,     2,      0,      -1
FLsetColor2	255, 255, 50, ihFLTK_MIDI	;SET SECONDARY COLOUR TO YELLOW
gk,ih				FLbutton	"To Zero",		1,    0,    21,     80,     20,  415,   95,    0,     3,      0,       0
gk,ih				FLbutton	"To Zero",		1,    0,    21,     80,     20,  415,  145,    0,     4,      0,       0

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idtrnsC			FLvalue	" ",	 80,      20,    5,  95
idtrnsF			FLvalue	" ",	 80,      20,    5, 145
idfeedback		FLvalue	" ",	 80,      20,    5, 395
idoutgain		FLvalue	" ",	 80,      20,    5, 495

;SLIDERS					            		MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gktrnsC, gihtrnsC		FLslider 	"Transpose (Coarse)",	-24,    24,    0,    23,   idtrnsC,   490,     25,    5,   70
gktrnsF, gihtrnsF		FLslider 	"Transpose (Fine)",	 -1,     1,    0,    23,   idtrnsF,   490,     25,    5,  120
gkfeedback, ihfeedback		FLslider 	"Feedback",		0,       1,    0,    23,   idfeedback,490,     25,    5,  370
gkoutgain, ihoutgain		FLslider 	"Output Gain",		0,       1,    0,    23,   idoutgain, 490,     25,    5,  470
gkDryWetMix, ihDryWetMix	FLslider 	"Dry/Wet Mix",		0,       1,    0,    23,          -1, 490,     25,    5,  520
gkInputGain, ihInputGain	FLslider 	"Input Gain",		0,       1,    0,    23,          -1, 490,     25,    5,  570

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gktrnsC, ihtrnsC2 	FLcount  "Transpose",	-48,  48,     1,      12,     1,   120,      22,   355, 180,    -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  | Y | OPCODE
gkinput,   ihinput			FLbutBank	14,     1,     3,     18,      45,    45, 180,   -1
gkkeepform,   ihkeepform		FLbutBank	14,     1,     3,     18,      60,   200,   0,   -1
gkFFTattributes, ihFFTattributes	FLbutBank	14,     1,     4,     18,      78,   120, 270,   -1
gkFBmethod, ihFBmethod			FLbutBank	14,     1,     2,     18,      30,   120, 420,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input:", 						1,       6,    11,    40,      15,    5,  180
ih		 	FLbox  	"Live Input", 						1,       5,    11,    70,      15,   65,  180
ih		 	FLbox  	"Voice     ", 						1,       5,    11,    70,      15,   65,  195
ih		 	FLbox  	"Drum Loop ", 						1,       5,    11,    70,      15,   65,  210
ih		 	FLbox  	"FFT Attributes",       				1,       4,    14,   100,      25,   15,  285
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,   340,      20,  140,  250
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,   340,      20,  140,  268
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,   340,      20,  140,  288
ih		 	FLbox  	" 2048        128        2048            1     ",	1,       5,    11,   340,      20,  140,  308
ih		 	FLbox  	" 4096        128        4096            1     ",	1,       5,    11,   340,      20,  140,  328
ih		 	FLbox  	"Do not preserve formants       ",			1,       5,    12,   230,      20,  220,    0
ih		 	FLbox  	"Impose original amplitudes     ",			1,       5,    12,   230,      20,  220,   20
ih		 	FLbox  	"Keep original spectral envelope",			1,       5,    12,   230,      20,  220,   40
ih		 	FLbox  	"Feedback Method:", 					1,       6,    11,   120,      15,    0,  420
ih		 	FLbox  	"Audio   ", 						1,       5,    11,    70,      15,  140,  420
ih		 	FLbox  	"F-signal", 						1,       5,    11,    70,      15,  140,  435

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	gihtrnsC
			FLsetVal_i	0, 	ihtrnsC2
			FLsetVal_i	0, 	gihtrnsF
			FLsetVal_i	0, 	ihkeepform
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	2, 	ihFFTattributes
			FLsetVal_i	0, 	ihfeedback
			FLsetVal_i	0.5, 	ihoutgain
			FLsetVal_i	1, 	ihFBmethod
			FLsetVal_i	1, 	ihDryWetMix
			FLsetVal_i	1, 	ihInputGain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,     520,   512, 0
				FLscroll     515,     520,   0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           pvscale                           ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The opcode pvscale performs rescaling of the frequency values", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"of an f-signal. The degree to which frequencies should be    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"rescaled is passed to the opcode as a multiple value, i.e.   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"a value of '1' would mean that frequencies would be left     ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"unaltered, a value of '2' would mean that frequencies would  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"be shifted up an octave, a value of '0.5' would mean that    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"frequencies would be shifted down an octave and so on. In    ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"this example this interaction with the opcode has been       ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"abstracted slightly (using the 'semitone' function) so that  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"frequency modulations can be expressed as transpositions     ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"defined in semitones. There are three controls provided for  ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"this: a coarse transposition slider, a fine transposition    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"slider and a counter (for specifying precise musical         ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"intervals).                                                  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Pvscale also offers three transposition modes of dealing with", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"formants of the original spectrum. This is an optional       ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"argument and it defaults to 0. In mode 0 no attempt is made  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"to retain the original formants. In mode 1 formants are      ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"retained by imposing the original amplitude values. In mode 2", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"formants are retained through filtering the output according ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"to the spectral envelope of the original signal.             ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"A variety of combination of FFT analysis attributes are      ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"selectable using radio button selectors. It can be observed  ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"that smaller FFT size and window sizes results in less time  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"smearing but greater harmonic distortion whereas larger FFT  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"sizes and window sizes results in greater time smearing but  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"less harmonic distortion.                                    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"This example can also be activated from a MIDI keyboard (if  ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"the 'FLTK/MIDI' switch is set to off (MIDI). In this mode    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"frequency rescaling values are derived from notes played on  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"the keyboard. Each MIDI note pressed begins another          ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"frequency rescaling voice thus permitting polyphony.         ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"A feedback control allows the user the control the amount of ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"the output signal that is fed back into the input. The signal", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"can be fed back as either an audio signal, in which case it  ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"will be resynthesized and then re-analysed during each pass, ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"or it can be fed back as an f-signal thereby bypassing the   ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"resynthesis and re-analysis stages. If the 'f-signal' method ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"is chosen, the 'pvsinit', 'pvsgain' and 'pvsmix' opcodes are ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"additionally employed to achieve this.                       ", 	1,      5,     14,    490,    20,     5, 820
				FLscroll_end
				FLpanel_end                                                                                                       

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giFFTattributes0	ftgen	1, 0, 4, -2,  512, 256, 1024, 1
giFFTattributes1	ftgen	2, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes2	ftgen	3, 0, 4, -2, 2048, 128, 2048, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 4096, 128, 4096, 1

instr	1	;MIDI INPUT INSTRUMENT
	if	gkFLTK_MIDI=1	then	;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	icps	cpsmidi			;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	iscal	=	icps/cpsoct(8)	;CREATE FREQUENCY SCALING VARIABLE
	iamp	ampmidi	1		;READ IN A NOTE VELOCITY VALUE FROM THE MIDI INPUT
	;				P1 | P4  | P5
	aoutL, aoutR	subinstr	2,  iscal, iamp	;ACTIVATE A SUB-INSTRUMENT
		outs	aoutL, aoutR	;SEND AUDIO TO SPEAKERS
endin

instr	2	;SOUND PRODUCING AND TRANSFORMING INSTRUMENT
	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	aenv		linsegr		0,0.01,1,0.02,0					;ANTI CLICK ENVELOPE WITH A MIDI SENSING RELEASE SEGMENT
	if	gkFLTK_MIDI=0&&kactive1=0	then	;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if	gkFLTK_MIDI = 1	then			;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kgain = 1				;SET kamp TO FLTK SLIDER VALUE gkamp
		kscal = semitone(gktrnsC+gktrnsF)	;SET FUNDEMENTAL TO FLTK SLIDER gkfund
	else						;OTHERWISE...
		kscal = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kgain = p5				;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
	endif						;END OF CONDITIONAL BRANCHING
	
	if		gkinput=0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		asig		inch		1				;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
	elseif		gkinput=1 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"AndItsAll.wav",    1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"loop.wav",         1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	asig	=	asig*gkInputGain	;SCALE INPUT SIGNAL BY GAIN CONTROL SLIDER
	kSwitch		changed		gkkeepform, gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
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
	 fsig2 		pvscale 	fsig1,      kscal,     i(gkkeepform),     1	;RESCALE THE FREQUENCY VALUES ACCORDING TO THE INPUT ARGUMENT gkscal.
	 rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	 ;OUTPUT		OPCODE		INPUT
	 aresyn 		pvsynth  	fsig2                      			;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	else	;NEW F-SIG FEEDBACK METHOD - REQUIRES CSOUND VERSION 5.14
	 fsig1L  	pvsanal	asig, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE AUDIO INPUT SIGNAL AND OUTPUT AN FSIG
	 fsig2L		pvsinit iFFTsize,ioverlap,iwinsize,iwintype, 0			;INITIALISE FEEDBACK FSIG
	 fsig3L		pvsmix	fsig1L, fsig2L						;MIX AUDIO INPUT WITH FEEDBACK SIGNAL
	 fsig4L 	pvscale fsig3L, kscal, i(gkkeepform), 1				;RESCALE FREQUENCIES
	 fsig2L		pvsgain fsig4L, gkfeedback 					;CREATE FEEDBACK F-SIGNAL FOR NEXT PASS
			rireturn							;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	 aresyn		pvsynth fsig4L                      				;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	endif
	amix		ntrpol		asig, aresyn, gkDryWetMix			;CREATE DRY/WET MIX

			outs		amix*aenv*gkoutgain*kgain, amix*aenv*gkoutgain*kgain	;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS AND RESCALE AMPLITUDE WITH ENVELOPE aenv
endin

instr	3	;RESET COARSE TRANSPOSE TO ZERO
	FLsetVal_i	0,gihtrnsC
endin

instr	4	;RESET FINE TRANSPOSE TO ZERO
	FLsetVal_i	0,gihtrnsF
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>