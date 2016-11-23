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
FLcolor	240, 240, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsadsyn",   500,    370,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 230	;BORDER AROUND FFT ATTRIBUTES

;SWITCHES  	                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,       1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idfmod			FLvalue	" ",	 80,      20,    5,  75

;SLIDERS				            		MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkfmod, ihfmod		FLslider 	"Rescale Frequencies",	0.25,    2,   -1,    23,   idfmod,    490,     25,    5,   50

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X |  Y  | OPCODE
gknoscs, ihnoscs		FLcount  "No. Oscs.", 		1,   2048,    1,     10,      1,    156,     25,    5, 105,    -1
gkbinoffset, ihbinoffset	FLcount  "Bin Offset", 		0,   2048,    1,     10,      1,    156,     25,  171, 105,    -1
gkbinincr, ihbinincr		FLcount  "Bin Increment", 	1,   2048,    1,      4,      1,    157,     25,  338, 105,    -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   240,   240,   255		;NUMBERS MADE INVISIBLE
;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkFFTattributes, ihFFTattributes	FLbutBank	14,     1,     4,     18,      78,   120,270,   -1
FLcolor2	255, 255, 50		;SET SECONDARY COLOUR TO YELLOW
gkinput,   ihinput			FLbutBank	12,     1,     3,     30,      75,    0, 152,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       5,    11,    70,      25,   32,  152
ih		 	FLbox  	"Songpan   ", 		1,       5,    11,    70,      25,   32,  177
ih		 	FLbox  	"Drum Loop ", 		1,       5,    11,    70,      25,   32,  202
ih		 	FLbox  	"FFT Attributes",       1,       4,    14,   100,      25,   15,  235
;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  250
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,    340,      20,  140,  268
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,    340,      20,  140,  288
ih		 	FLbox  	" 2048        256        2048            1     ",	1,       5,    11,    340,      20,  140,  308
ih		 	FLbox  	" 4096        256        4096            1     ",	1,       5,    11,    340,      20,  140,  328

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	1, 	ihfmod
			FLsetVal_i	256, 	ihnoscs
			FLsetVal_i	1, 	ihbinoffset
			FLsetVal_i	1, 	ihbinincr
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	1, 	ihFFTattributes

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL               WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,    800,   512, 0
				FLscroll     515,    800,   0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvsadsyn                           ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"pvsadsyn resynthesizes an fsig into an audio signal with some", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"interesting user adjustable parameters that define how that  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"resynthesis is performed.                                    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"pvsadsyn is quite similar the the opcode pvadd. The principle", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"innovation is that pvsadsyn can operate upon a streaming     ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"f-signal and therefore a live stream of audio.               ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Most of pvsadsyn's input parameters must be defined at       ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"initialization time. To allow realtime modulation of these   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"parameters I have designed the instrument to perform a       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"re-initialization pass through the relevant code if any of   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"these parameters are changed in the GUI.                     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'No. Oscs.' (number of oscillators) defines the number of    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"oscillators that will be used in the resynthesis. As this    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"number is reduced the result is simlar to lowering the cutoff", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"frequency of a low-pass filter.                              ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"'Bin Offset' defines the lowest FFT bin which will be read   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"from. As this value is increased the result is similar to    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"raising the cutoff frequency of a high-pass filter.          ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"Setting 'Bin Increment' to values higher than '1' means that ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"pvsadsyn will not read from every consecutive FFT bin but    ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"will instead skip the defined number of bins before reading  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"again for each oscillator.                                   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"If pvsadsyn is forced to read from a bin that doesn't exist  ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"Csound will crash. The highest bin that can be read from     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"is dictated by the number of bins available from the original", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"analysis carried out, in this case, by 'pvsanal'. It will be ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"(FFTsize/2)+1. The highest bin that pvsadsyn will attempt to ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"read from is dependent upon 'No. Oscs.', 'Bin Offset' and    ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"'Bin Increment'. To prevent the annoyance of crashes while   ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"modulating these parameters I have included a line of code   ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"that limits the actual number of oscillators to prevent read ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"attempts from non existant FFT bins. The actual number of    ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"oscillators used by pvsadsyn is output to the terminal each  ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"time it changes.                                             ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"'Rescale Frequencies' modulates the frequencies of all FFT   ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"bins at k-rate.                                              ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"The user can select between a variety of combinations of     ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"parameters for the FFT analysis. Larger values for FFT size  ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"will give better harmonic reproduction but greater time      ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"smearing effects and higher computational cost. Lower values ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"will result in less time smearing but greater harmonic       ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"distortion.                                                  ", 	1,      5,     14,    490,    20,     5, 860
                                                           
				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;TABLES THAT STORE FFT ANALYSIS ATTRIBUTES DATA
giFFTattributes0	ftgen	1, 0, 4, -2,  512, 256, 1024, 1
giFFTattributes1	ftgen	2, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes2	ftgen	3, 0, 4, -2, 2048, 256, 2048, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 4096, 256, 4096, 1

instr 		1	;
	if		gkOnOff!=0	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH. IF ON, SKIP THE NEXT LINE 
		turnoff                                         ;TURN THIS INSTRUMENT OFF IMMEDIATELY
	CONTINUE:                                               ;LABEL
	if		gkinput=0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		asig		inch		1		;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
	elseif		gkinput=1 	then			;IF 'INPUT' SWITCH IS SET TO 'Songpan' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig, aR		diskin2		"Songpan.wav",      1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"loop.wav",         1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	iFFTsize	table	0, i(gkFFTattributes)+1	;READ FFT SIZE FROM APPROPRIATE TABLE    
	kSwitch		changed		gkFFTattributes, gknoscs, gkbinoffset, gkbinincr	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF I-RATE VARIABLE IS CHANGED...
		reinit	UPDATE		;BEGIN A REINITIALISATION PASS IN ORDER TO EFFECT THIS CHANGE. BEGIN THIS PASS AT LABEL ENTITLED 'UPDATE' AND CONTINUE UNTIL rireturn OPCODE 
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;LABEL - BEGIN RE-INITIALIZATION PASS FROM HERE
	iFFTsize	table	0, i(gkFFTattributes)+1	;READ FFT SIZE FROM APPROPRIATE TABLE    
	ioverlap	table	1, i(gkFFTattributes)+1	;READ OVERLAP SIZE FROM APPROPRIATE TABLE
	iwinsize	table	2, i(gkFFTattributes)+1	;READ WINDOW SIZE FROM APPROPRIATE TABLE 
	iwintype	table	3, i(gkFFTattributes)+1	;READ WINDOW TYPE FROM APPROPRIATE TABLE 	
	fsig1  		pvsanal		asig, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.
	;THE limit OPCODE IS USED TO LIMIT THE VALUE USED FOR NUMBER OF OSCILLATORS (inoscs) AS IF THIS EXCEEDS THE NUMBER OF BINS USED IN THE ORIGINAL ANALYSIS CSOUND WILL CRASH
	;THE NUMBER OF BINS IS FFTsize DIVIDED BY 2, + 1
	;BIN OFFSET (binoffset) AND BIN INCREMENT (binincr) MUST ALSO BE TAKEN INTO ACCOUNT AS THEY WILL INFLUENCE TO WHAT HIGHEST FFT BIN pvsadsyn ATTEMPTS TO READ FROM
	inoscs	limit	i(gknoscs), 0, (((iFFTsize*0.5)+1)-i(gkbinoffset))/i(gkbinincr)
	print	inoscs	;FOR THE USERS INFORMATION THE ACTUAL NUMBER OF OSCILLATORS
	aresyn 		pvsadsyn fsig1, inoscs, gkfmod , i(gkbinoffset), i(gkbinincr)	;RESYNTHESIZE FROM THE fsig USING pvsadsyn
	;OUTPUT		OPCODE		INPUT
			outs		aresyn, aresyn				;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
	rireturn	;RETURN TO NORMAL PERFORMANCE TIME AFTER A RE-INITIALIZATION PASS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>