;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b4096
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	256
nchnls	= 	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsmorph",   500,    480,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 340	;BORDER AROUND FFT ATTRIBUTES
ih		 	FLbox  	" ", 	6,      9,     15,    490,    95,     5, 160	;BORDER AROUND SIGNAL 1 INPUT
ih		 	FLbox  	" ", 	6,      9,     15,    490,    70,     5, 265	;BORDER AROUND SIGNAL 2 TRANSPOSE ATTRIBUTES

;SWITCHES  	                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    120,     25,    5,  5,    0,       1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL | WIDTH | HEIGHT | X | Y
idampint			FLvalue	" ",	 80,      20,    5,  75
idfrqint			FLvalue	" ",	 80,      20,    5, 125

;SLIDERS				            				MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkampint, ihampint	FLslider 	"Amplitude Interpolation Point",	0,       1,    0,    23,  idampint,   490,     25,    5,   50
gkfrqint, ihfrqint	FLslider 	"Frequency Interpolation Point",	0,       1,    0,    23,  idfrqint,   490,     25,    5,  100

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkoct, ihoct		FLcount  "Octaves", 	-2,    2,     1,      1,      2,    100,     20,   150,285,   -1
gksemi, ihsemi		FLcount  "Semitones", 	-12,  12,     1,      1,      2,    100,     20,   260,285,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	4,      1,     3,     18,      75,   150,172,   -1
gkFFTattributes, ihFFTattributes	FLbutBank	4,      1,     4,     18,      78,   120,380,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       5,    13,    80,      25,   173,  172
ih		 	FLbox  	"Songpan   ", 		1,       5,    13,    80,      25,   173,  197
ih		 	FLbox  	"Drum Loop ", 		1,       5,    13,    80,      25,   173,  222
ih		 	FLbox  	"fsig1 Input",    	1,       4,    14,   120,      25,   15,  180
ih		 	FLbox  	"fsig2 Transpose",     	1,       4,    14,   120,      25,   15,  285
; 											TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Attributes",       				1,       4,    14,    100,      25,   15,  345
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  360
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,    340,      20,  140,  378
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,    340,      20,  140,  398
ih		 	FLbox  	" 2048        256        2048            1     ",	1,       5,    11,    340,      20,  140,  418
ih		 	FLbox  	" 4096        256        4096            1     ",	1,       5,    11,    340,      20,  140,  438

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	1, 	ihampint
			FLsetVal_i	0, 	ihfrqint
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	1, 	ihFFTattributes

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     500,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvsmorph                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvsmorph allows the user to continuously and separately morph", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"between the amplitude and the frequency characteristics of   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"two f-signals (streaming phase vocoding analysis signals).   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Typically one of the signals is harmonic or resonant and     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"dynamically steady, such as a synthesizer pad sound or a     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"held organ chord, and the other is dynamically active and    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"possibly noise based, such as a drum loop or speech.         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The 'Amplitude Interpolation Point' and 'Frequency           ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Interpolation Point' sliders crossfade between the amplitude ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"and frequency influence upon the output sound of the two     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"source signals. Typically these are set to opposite points - ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"when F.I.P. is low, A.I.P. is high and vice versa.           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"In this example the first source signal is selectable between", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"the computer's live input, a busy town soundscape and a drum ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"loop.                                                        ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"The second signal is a synthesizer pad sequence which can be ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"transposed in octaves and semitones.                         ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"The user can select between a variety of combinations of     ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"parameters for the FFT analysis. Larger values for FFT size  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"will give better harmonic reproduction but greater time      ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"smearing effects and higher computational cost. Lower values ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"will result in less time smearing but greater harmonic       ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"distortion.                                                  ", 	1,      5,     14,    490,    15,     5, 480
                                                           
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;TABLES THAT STORE FFT ANALYSIS ATTRIBUTES DATA
giFFTattributes0	ftgen	1, 0, 4, -2,  512, 256, 1024, 1
giFFTattributes1	ftgen	2, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes2	ftgen	3, 0, 4, -2, 2048, 256, 2048, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 4096, 256, 4096, 1

instr 		1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kSwitch		changed		gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF I-RATE VARIABLE IS CHANGED...
		reinit	UPDATE		;BEGIN A REINITIALISATION PASS IN ORDER TO EFFECT THIS CHANGE. BEGIN THIS PASS AT LABEL ENTITLED 'UPDATE' AND CONTINUE UNTIL rireturn OPCODE 
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;LABEL
	kmlt	=	cpsoct(8+gkoct+(gksemi/12))/cpsoct(8)	;DERIVE A PLAYBACK SPEED RATIO FROM TRANSPOSE SETTING
	a1L, a1R	diskin2		"synthpad.wav",     kmlt,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	if	gkinput=0	then	;IF 'INPUT' SELECTOR IS ON 'Live Input'
		a2L	inch	1	;READ AUDIO FROM COMPUTER'S FIRST (LEFT) INPUT CHANNEL
		a2R	=	a2L	;SOURCE IS MONO SO JUST SET RIGHT CHANNEL TO BE THE SAME AS THE LEFT CHANNEL
	elseif	gkinput=1	then	;IF 'INPUT' SELECTOR IS ON 'Songpan'
		a2L, a2R	diskin2		"Songpan.wav",      1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	elseif	gkinput=2	then	;IF 'INPUT' SELECTOR IS ON 'Drum Loop'
		a2L		diskin2		"loop.wav",      1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
		a2R	=	a2L	;SOURCE IS MONO SO JUST SET RIGHT CHANNEL TO BE THE SAME AS THE LEFT CHANNEL
	endif				;END OF CONDITIONAL BRANCHING
	iFFTsize	table	0, i(gkFFTattributes)+1	;READ FFT SIZE FROM APPROPRIATE TABLE
	ioverlap	table	1, i(gkFFTattributes)+1	;READ OVERLAP SIZE FROM APPROPRIATE TABLE
	iwinsize	table	2, i(gkFFTattributes)+1	;READ WINDOW SIZE FROM APPROPRIATE TABLE
	iwintype	table	3, i(gkFFTattributes)+1	;READ WINDOW TYPE FROM APPROPRIATE TABLE
	f1L  		pvsanal		a1L, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.
	f1R  		pvsanal		a1R, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.
	f2L  		pvsanal		a2L, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.
	f2R  		pvsanal		a2L, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.

	f3L 	pvsmorph f1L, f2L, gkampint, gkfrqint	;IMPLEMENT fsig MORPHING
	f3R 	pvsmorph f1R, f2R, gkampint, gkfrqint	;IMPLEMENT fsig MORPHING

	;OUTPUT		OPCODE		INPUT
	aresynL		pvsynth  	f3L                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	aresynR		pvsynth  	f3R                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
			outs		aresynL, aresynR			;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
	rireturn	;DENOTES THE END OF A REINITIALISATION PASS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>