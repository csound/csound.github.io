;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b4000
</CsOptions>


<CsInstruments>

sr	= 	44100
ksmps	= 	100
nchnls	= 	2
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;				LABEL               | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsblur (and pvsanal and pvsynth)",   500,    350,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    130,    5, 214	;BORDER AROUND FFT ATTRIBUTES

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idblurtime		FLvalue	" ",	 80,      20,    5,  75
idOutGain		FLvalue	" ",	 80,      20,    5, 185

;SLIDERS							MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkblurtime, ihblurtime	FLslider 	"Blur Time (seconds)",	0,     4,    0,    23,    idblurtime,  490,     25,    5,   50
gkOutGain, ihOutGain	FLslider 	"Output Gain",		0,     1,    0,    23,    idOutGain,   490,     25,    5,  160

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;					FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,  ihinput			FLbutBank	4,      1,     3,     18,      60,     5, 98,   -1
gkFFTattributes, ihFFTattributes	FLbutBank	4,      1,     4,     18,      78,   120,254,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       5,    12,    70,      20,   23,  97
ih		 	FLbox  	"Voice     ", 		1,       5,    12,    70,      20,   23, 117
ih		 	FLbox  	"Drum Loop ", 		1,       5,    11,    70,      20,   23, 137
ih		 	FLbox  	"FFT Attributes",       1,       4,    14,   100,      25,   15, 219
;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  234
ih		 	FLbox  	"   256       128         256            1     ",	1,       5,    11,    340,      20,  140,  252
ih		 	FLbox  	"   256       128         256            1     ",	1,       5,    11,    340,      20,  140,  272
ih		 	FLbox  	"   512       128         512            1     ",	1,       5,    11,    340,      20,  140,  292
ih		 	FLbox  	"  1024       128        1024            1     ",	1,       5,    11,    340,      20,  140,  312

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	.2, 	ihblurtime
			FLsetVal_i	0.7, 	ihOutGain
			FLsetVal_i	1, 	ihFFTattributes

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     300,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           pvsblur                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Pvsblur averages streamed frequency and amplitude data over  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"a time defined by 'Blur Time'. The effect is of the sound    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"being blurred. The opcode requires the user to specify the   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"longest blur time to expect. Giving this parameter high      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"values can create very high CPU demands.                     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"A side effect of pvsblur processing is that the input signal ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"will be delayed by the setting given to 'Blur Time'.         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"A variety of combinations of FFT analysis attributes are     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"selectable using radio button selectors. It can be observed  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"that smaller FFT size and window sizes results in less time  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"smearing but greater harmonic distortion whereas larger FFT  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"sizes and window sizes results in greater time smearing but  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"less harmonic distortion.                                    ", 	1,      5,     14,    490,    15,     5, 280
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giFFTattributes0	ftgen	1, 0, 4, -2,  256, 128,  256, 1
giFFTattributes1	ftgen	2, 0, 4, -2,  256, 128,  256, 1
giFFTattributes2	ftgen	3, 0, 4, -2,  512, 128,  512, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 1024, 128, 1024, 1

instr	1	;
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if		gkinput=0	then			;IF 'INPUT' SWITCH IS SET TO 'Live Input' THEN IMPLEMENT THE NEXT LINE OF CODE
		gasig		inch		1				;READ AUDIO FROM THE COMPUTER'S LIVE INPUT CHANNEL 1 (LEFT)
	elseif		gkinput=1 	then			;IF 'INPUT' SWITCH IS SET TO 'Voice' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		gasig		diskin2		"AndItsAll.wav",    1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	else						;IF 'INPUT' SWITCH IS NOT SET TO 'STORED FILE' THEN IMPLEMENT THE NEXT LINE OF CODE
		;OUTPUT		OPCODE		FILE_PATH       | SPEED | INSKIP | WRAPAROUND (1=ON)
		gasig		diskin2		"loop.wav",         1,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif						;END OF 'IF'...'THEN' BRANCHING
	kSwitch		changed		gkFFTattributes	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif					;END OF CONDITIONAL BRANCHING
	START:					;LABEL
	iFFTsize	table	0, i(gkFFTattributes)+1
	ioverlap	table	1, i(gkFFTattributes)+1
	iwinsize	table	2, i(gkFFTattributes)+1
	iwintype	table	3, i(gkFFTattributes)+1	
	fsig1  		pvsanal		gasig, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.      	
	imaxdel		=		4				;VARIBALE THAT WILL BE USED TO DEFINE MAXIMUM DELAY TIME FOR pvsblur PROCESSING. THIS INFORMATION IS NEEDED FOR MEMORY ALLOCATION.
	fsig2		pvsblur		fsig1, gkblurtime, imaxdel	;BLUR AMPLITUDE AND FREQUENCY VALUES OF AN F-SIGNAL
	;OUTPUT		OPCODE		INPUT    	
	aresyn 		pvsynth  	fsig2                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	outs		aresyn * gkOutGain, aresyn * gkOutGain	;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>