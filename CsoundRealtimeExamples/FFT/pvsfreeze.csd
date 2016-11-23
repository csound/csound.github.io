;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b400
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	100
nchnls	= 	2
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL       | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsfreeze",   500,    300,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 160	;BORDER AROUND FFT ATTRIBUTES

;SWITCHES  	                         					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff, ihOnOff	FLbutton	"On/Off",				1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
gkfreeza, gihfreeza	FLbutton	"Freeze Amplitudes",			1,    0,    22,    150,     25,  175,  5,   -1
gkfreezf, gihfreezf	FLbutton	"Freeze Frequencies",			1,    0,    22,    150,     25,  345,  5,   -1
gkfreezall, gihfreezall	FLbutton	"Freeze Amplitudes and Frequencies",	1,    0,    22,    320,     25,  175, 50,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, gihfreeza		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, gihfreezf		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, gihfreezall	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idOutGain		FLvalue	" ",	 80,      20,    5, 125

;SLIDERS				            		MIN   |  MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X  | Y
gkOutGain, ihOutGain	FLslider 	"Output Gain",		0,         1,   0,   23,   idOutGain,   490,     25,    5,  100

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0.7, 	ihOutGain

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS			 			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	14,     1,     3,     18,      60,     5, 33,   -1
FLsetColor2	255, 255, 50, ihinput	;SET SECONDARY COLOUR TO YELLOW
gkFFTattributes, ihFFTattributes	FLbutBank	14,     1,     4,     18,      78,   120,200,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       5,    11,    70,      20,   22,  32
ih		 	FLbox  	"Voice     ", 		1,       5,    11,    70,      20,   22,  52
ih		 	FLbox  	"Drum Loop ", 		1,       5,    11,    70,      20,   22,  72
ih		 	FLbox  	"FFT Attributes",       1,       4,    14,   100,      25,   15,  165
;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  180
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,    340,      20,  140,  198
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,    340,      20,  140,  218
ih		 	FLbox  	" 2048        128        2048            1     ",	1,       5,    11,    340,      20,  140,  238
ih		 	FLbox  	" 4096        128        4096            1     ",	1,       5,    11,    340,      20,  140,  258

;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	1, 	ihFFTattributes

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     340,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           pvsfreeze                         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The pvsfreeze opcode allows us to instantly freeze the       ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"streaming progress of frequency or amplitude components      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"(or both) of a streamed fsig.                                ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"This example also implements a switch that triggers both     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"freeze switches simultaneously to create a complete 'freeze  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"frame' of the audio input.                                   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"A variety of combinations of FFT analysis attributes are     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"selectable using radio button selectors. It can be observed  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"that smaller FFT size and window sizes results in less time  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"smearing but greater harmonic distortion whereas larger FFT  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"sizes and window sizes results in greater time smearing but  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"less harmonic distortion.                                    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Changing FFT attributes while a note is playing can have     ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"unexpected results. If this happens just cycle the 'On/Off'  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"switch.                                                      ", 	1,      5,     14,    490,    15,     5, 320

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giFFTattributes0	ftgen	1, 0, 4, -2,  512, 256, 1024, 1
giFFTattributes1	ftgen	2, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes2	ftgen	3, 0, 4, -2, 2048, 128, 2048, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 4096, 128, 4096, 1

instr	1	;
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if		gkinput=0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		asig		inch		1				;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
	elseif		gkinput=1&&gkfreezall!=1 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' AND FREEZE ALL IS NOT ACTIVATED THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"AndItsAll.wav",    1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	elseif	gkinput=2	then				;IF 'INPUT' SWITCH IS SET TO 'Drum Loop' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		asig		diskin2		"loop.wav",         1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	kSwitch		changed		gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif					;END OF CONDITIONAL BRANCHING
	START:					;LABEL
	iFFTsize	table	0, i(gkFFTattributes)+1	;READ FFT ATTRIBUT FROM TABLE
	ioverlap	table	1, i(gkFFTattributes)+1	;READ FFT ATTRIBUT FROM TABLE
	iwinsize	table	2, i(gkFFTattributes)+1 ;READ FFT ATTRIBUT FROM TABLE
	iwintype	table	3, i(gkFFTattributes)+1	;READ FFT ATTRIBUT FROM TABLE
	fsig1  		pvsanal		asig, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.
	;OUTPUT	OPCODE		INPUT | FREEZE_AMPLITUDES | FREEZE_FREQUECIES
	fsig2 	pvsfreeze 	fsig1,       gkfreeza,          gkfreezf	;FREEZE AMPLITUDES OR FREQUENCIES (OR NEITHER) ACCORDING TO THE SWITCHES gkfreeza AND gkfreezf
	;OUTPUT	OPCODE		INPUT
	aresyn 	pvsynth  	fsig2                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
		outs		aresyn * gkOutGain, aresyn * gkOutGain	;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
endin

instr	2	;THIS INSTRUMENT SENSES THE 'Freeze Amplitudes and Frequencies' SWITCH AND DEALS WITH THE SUBSEQUENT APPROPRIATE SETTING FOR THE 'Freeze Amplitudes' AND 'Freeze Frequencies' SWITCHES  
	if	gkfreezall!=0	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		FLsetVal	1, 	0, gihfreeza	;RESET THESE SWITCHES TO 'OFF' JUST BEFORE THE 'Freeze Amplitudes and Frequencies' SWITCH IS TURNED OFF
		FLsetVal	1, 	0, gihfreezf	;RESET THESE SWITCHES TO 'OFF' JUST BEFORE THE 'Freeze Amplitudes and Frequencies' SWITCH IS TURNED OFF
	turnoff						;TURN THIS INSTRUMENT OFF IMMEDIATELY
	CONTINUE:                                       ;LABEL (JUMP TO THIS LABEL IF 'Freeze Amplitudes and Frequencies' SWITCH IS TURNED ON)
		FLsetVal_i	1, 	gihfreeza	;TURN 'Freeze Amplitudes' SWITCH ON WHEN THE 'Freeze Amplitudes and Frequencies' SWITCH IS TURNED ON
		FLsetVal_i	1, 	gihfreezf	;TURN 'Freeze Frequencies' SWITCH ON WHEN THE 'Freeze Amplitudes and Frequencies' SWITCH IS TURNED ON
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>