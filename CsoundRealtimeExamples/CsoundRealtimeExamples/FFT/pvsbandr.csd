pvsbandr.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	256
nchnls	= 	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsbandr",   500,    520,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 380	;BORDER AROUND FFT ATTRIBUTES

;SWITCHES  	                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    150,     30,    5,  5,    0,       1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idlowcut			FLvalue	" ",	 80,      20,    5,  75
idlowfull			FLvalue	" ",	 80,      20,    5, 125
idhighcut			FLvalue	" ",	 80,      20,    5, 175
idhighfull			FLvalue	" ",	 80,      20,    5, 225
idtype				FLvalue	" ",	 80,      20,    5, 275

;SLIDERS				            		MIN   | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X  | Y
gklowcut, ihlowcut	FLslider 	"Low Cut",		20,    20000, -1,    23,   idlowcut,    490,     25,    5,   50
gklowfull, ihlowfull	FLslider 	"Low Full",		20,    20000, -1,    23,   idlowfull,   490,     25,    5,  100
gkhighcut, ihhighcut	FLslider 	"High Cut",		20,    20000, -1,    23,   idhighcut,   490,     25,    5,  150
gkhighfull, ihhighfull	FLslider 	"High Full",		20,    20000, -1,    23,   idhighfull,  490,     25,    5,  200
gktype, ihtype		FLslider 	"Curve Type",		-5,        5,  0,    23,   idtype,      490,     25,    5,  250

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	4,      1,     3,     18,      75,    5, 302,   -1
gkFFTattributes, ihFFTattributes	FLbutBank	4,      1,     4,     18,      78,   120,420,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       5,    12,    70,      25,   23,  301
ih		 	FLbox  	"Songpan   ", 		1,       5,    12,    70,      25,   23,  326
ih		 	FLbox  	"Drum Loop ", 		1,       5,    12,    70,      25,   23,  351
ih		 	FLbox  	"FFT Attributes",       1,       4,    14,   100,      25,   15,  385
;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  400
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,    340,      20,  140,  418
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,    340,      20,  140,  438
ih		 	FLbox  	" 2048        256        2048            1     ",	1,       5,    11,    340,      20,  140,  458
ih		 	FLbox  	" 4096        256        4096            1     ",	1,       5,    11,    340,      20,  140,  478

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	100, 	ihlowcut
			FLsetVal_i	150, 	ihlowfull
			FLsetVal_i	2800, 	ihhighcut
			FLsetVal_i	2900, 	ihhighfull
			FLsetVal_i	0, 	ihtype
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	1, 	ihFFTattributes

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     600,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvsbandr                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvsbandr is an implementation of a band reject filter using  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"phase vocoder analysis.                                      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The shape of the filter is defined by specifying the nodes   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"of maximum and minimum attenuation for the low cut and high  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"cut aspects of the filter. The diagram below, taken from the ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Csound Manual, helps to illustrate this.                     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"         klowcut                       khighcut              ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	" ________                                      ______________", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"         \\                                    /              ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"          \\                                  /               ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"           \\                                /                ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"            \\                              /                 ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"             \\                            /                  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"      klowfull\\__________________________/ khighfull         ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Using this system the user can continuously vary the cutoff  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"slope of the filter.                                         ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"The input parameter 'type' define the shape of the cutoff    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"slope. A value of zero will give a linear shape, positive    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"values will result in an exponential shape and negative      ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"values will give a logarithmic shape.                        ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"The user can select between a variety of combinations of     ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"parameters for the FFT analysis. Larger values for FFT size  ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"will give better harmonic reproduction but greater time      ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"smearing effects and higher computational cost. Lower values ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"will result in less time smearing but greater harmonic       ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"distortion.                                                  ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"The user can choose between different input sources which    ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"includes the computer's live input.                          ", 	1,      5,     14,    490,    15,     5, 580

                                                           
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 		1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kSwitch		changed		gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF I-RATE VARIABLE IS CHANGED...
		reinit	UPDATE		;BEGIN A REINITIALISATION PASS IN ORDER TO EFFECT THIS CHANGE. BEGIN THIS PASS AT LABEL ENTITLED 'UPDATE' AND CONTINUE UNTIL rireturn OPCODE 
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;LABEL
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
	ioverlap	table	1, i(gkFFTattributes)+1	;READ OVERLAP SIZE FROM APPROPRIATE TABLE
	iwinsize	table	2, i(gkFFTattributes)+1	;READ WINDOW SIZE FROM APPROPRIATE TABLE 
	iwintype	table	3, i(gkFFTattributes)+1	;READ WINDOW TYPE FROM APPROPRIATE TABLE 	
	fsig1  		pvsanal		asig, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.
	fsig2 	pvsbandr fsig1, gklowcut, gklowfull, gkhighfull, gkhighcut, gktype	  	;PERFORM fsig BAND REJECT FILTERING
	;OUTPUT		OPCODE		INPUT
	aresyn 		pvsynth  	fsig2                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
			outs		aresyn, aresyn				;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
	rireturn
endin

</CsInstruments>

<CsScore>
f 1 0 4 -2  512 256 1024 1
f 2 0 4 -2 1024 256 1024 1
f 3 0 4 -2 2048 256 2048 1
f 4 0 4 -2 4096 256 4096 1

f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>