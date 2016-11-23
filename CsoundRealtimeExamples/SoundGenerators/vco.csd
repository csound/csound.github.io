vco.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
;INTERNAL VIRTUAL MIDI
-odac -dm0 -M0 -+rtmidi=virtual

;EXTERNAL MIDI
;-odac -dm0 -Ma
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	1
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255,0,0,0
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"vco",     500,    600,    0,  0
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkxy,ihxy			FLbutton	"X-Y CONTROL",	1,    0,    22,    150,     30,    5, 400,   -1
FLsetColor2	 255, 255, 50,ihxy
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFLTK_MIDI, ihFLTK_MIDI	FLbutBank	4,      1,     2,     20,      40,    5,  5,     0,     1,    0,  -1
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI", 	1,      6,     17,     50,     20,   23,   4
ih		 	FLbox  	"FLTK", 	1,      6,     17,     50,     20,   23,  24

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",    	  80,     20,    5, 125
idcps			FLvalue	" ",    	  80,     20,    5, 175
idleak			FLvalue	" ",    	  80,     20,    5, 225
idnyx			FLvalue	" ",    	  80,     20,    5, 275
idpw			FLvalue	" ",    	  80,     20,    5, 325
idphs			FLvalue	" ",    	  80,     20,    5, 375
idx			FLvalue	"wave", 	 120,     20,   50, 475
idy			FLvalue	"pulse width",   120,     20,   50, 525

;SLIDERS				     				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider	"Amplitude",  			0,       1,   0,   23,  idamp,   490,     25,    5, 100
gkcps, ihcps		FLslider	"Frequency (Hertz)",  		2,   10000,  -1,   23,  idcps,   490,     25,    5, 150
gkleak, ihleak		FLslider	"Integrator Leak",		0,       1,   0,   23, idleak,   490,     25,    5, 200
gknyx, ihnyx		FLslider	"Number of Harmonics",		20,   sr/2,  -1,   23,  idnyx,   490,     25,    5, 250
gkpw, gihpw		FLslider	"Pulse Width (CC#1)",    	0,       1,   0,   23,   idpw,   490,     25,    5, 300
gkphs, ihphs		FLslider	"Initial Phase",    		0,       1,   0,   23,  idphs,   490,     25,    5, 350

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkwave,ihwave 		FLcount  "Waveform", 		1,      3,   1,       1,      2,   150,     25,    175, 5,    -1

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"1=Saw 2=Square/PWM 3=Saw/Triangle/Ramp", 	1,      5,     12,    150,    15,    175, 55

;XY PANELS									MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X  | Y
gkwave2, gkpw2, ihwave2, ihpw2	FLjoy	"X - wave(1-2-3) Y - Pulse Width",	1,       3,    0,      1,     0,     0,    idx,    idy,    300,    180,   170, 400

;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	0.1, 	ihamp
		FLsetVal_i	100, 	ihcps
		FLsetVal_i	2, 	ihwave
		FLsetVal_i	0, 	ihleak
		FLsetVal_i	sr/2, 	ihnyx
		FLsetVal_i	.5, 	gihpw
		FLsetVal_i	0, 	ihphs
		FLsetVal_i	2, 	ihwave2
		FLsetVal_i	0.5, 	ihpw2
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Miscellaneous Waveforms : vco                ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Vco is a digital emulation of a voltage controlled oscillator", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"that one might find on an analogue synthesizer.              ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"The precise method used is the integration of band limited   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"impulses. Vco implements a digital model of the analogue     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"electronics that were used to achieve this.                  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"It has three basic waveform settings: 'Saw', 'Square/PWM' and", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'Saw/Triangle/Ramp'. As you can see, two of these settings   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"are capable of producing more than one wave type. This is    ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"achieved by warping the waveform using the 'Pulse Width' (PW)", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"control.                                                     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"For example when the 'Square/PWM' waveform is selected a     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"square wave is achieved by setting 'Pulse Width' to 0.5. When", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'Saw/Triangle/Ramp' is selected a triangle wave is achieved  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"by setting 'Pulse Width' again to 0.5. Giving 'Pulse Width' a", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"value of zero or 1 achieves silence. PWM or 'Pulse Width     ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"Modulation' was a an effect popular on analogue synthesizers ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"whereby the pulse width of a waveform was modulated by an LFO", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"(Low Frequency Oscillator). In this example this can only be ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"achieved by manually moving the 'Pulse Width' slider back and", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"forth. In the next example featuring vco an LFO has been     ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"implemented to drive the 'Pulse Width' parameter. Note that  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"'Pulse Width' has no effect when 'Saw' waveform is selected. ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"The 'Integrator Leak' control implements a quirk of the      ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"original analogue oscillator upon which this is based which  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"has an effect on the sound produced. For a more in depth     ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"discussion I point you in the direction of the the Csound    ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"Reference Manual in which the opcode's author, Hans Mikelson,", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"gives more technical information about the effect of         ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"integrator leakage.                                          ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"'Number of Harmonics' can be used to limit the number of     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"harmonics that will be present in the waveform. Normally this", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"argument should be in the range close to zero up to 0.5. I   ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"have done some additional mathematics in the code so that the", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"values you see in the interface represent this harmonic limit", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"in hertz. the author suggests that a waveform can be         ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"'fattened up' by reducing this parameter.                    ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"Vco provides a useful source for subtractive synthesis and   ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"could be used as the starting point for a Csound model of an ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"analogue synthesizer.                                        ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"This example can also be played from an external MIDI        ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"keyboard. Pitch, note velocity and pitch bend and represented", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"appropriately. MIDI controller 1 (the modulation wheel) can  ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"be used to modulate 'Pulse Width'.                           ", 	1,      5,     14,    490,    20,     5, 820

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 131072, 10, 1  ; SINE WAVE

instr	1		;GBUZZ INSTRUMENT
	kporttime	linseg	0,0.01,0.01			;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE
	iMIDIActiveValue	=	1			;IF MIDI ACTIVATED
	iMIDIflag		=	0			;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag		;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi						;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	kMIDIflag	init	iMIDIflag
	if	gkFLTK_MIDI=0&&kMIDIflag=0	then 		;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
		turnoff						;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif							;END OF THIS CONDITIONAL BRANCH
	if kMIDIflag=1 then					;IF THIS IS A MIDI ACTIVATED NOTE...
		kcps	=	icps				;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		iamp	veloc	0,1				;READ IN MIDI NOTE VELOCITY
		kamp	portk	gkamp*iamp,kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	else							;OTHERWISE...
		kcps		portk	gkcps,kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp		portk	gkamp,kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	endif							;END OF THIS CONDITIONAL BRANCH

	;MIDI INPUT============================================================================================================================================================
        kpw	ctrl7		1,1,0,1				;READ IN MIDI CONTROLLER
	ktrig	changed		kpw    				;IF THE VARIABLE 'kpw' CHANGES FROM ITS PREVIOUS VALUE GENERATE A MOMENTARY '1' TRIGGER
		FLsetVal        ktrig,kpw,gihpw			;UPDATE WIDGET WHEN A TRIGGER IS RECEIVED
	;======================================================================================================================================================================
	
	;PITCH BEND===========================================================================================================================================================
	iSemitoneBendRange = 2					;PITCH BEND RANGE IN SEMITONES
	imin = 0						;EQUILIBRIUM POSITION
	kbend	pchbend	imin, iSemitoneBendRange*2		;PITCH BEND VARIABLE (IN SEMITONES)
	kcps	=	kcps * semitone(kbend)			;APPLY PITCH BEND TO kcps
	;=====================================================================================================================================================================

	kpw		portk	gkpw, kporttime			;APPLY PORTAMENTO SMOOTHING
	imaxd		=		1			;
	kSwitch		changed		gkleak,gknyx,gkwave,gkphs	;IF ANY OF THE INPUT ARG CHANGES GENERATE A MOMETARY '1' TRIGGER
	if	kSwitch=1	then				;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE					;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif							;END OF CONDITIONAL BRANCH
	UPDATE:							;A LABLE - REINITILIASATION BEGINS FORM HERE
	aenv	linsegr	0,0.01,1,0.01,0				;ANTI-CLICK ENVELOPE
	asig		vco 		aenv*kamp, kcps, i(gkwave), kpw, gisine, imaxd, i(gkleak), i(gknyx)/sr, i(gkphs)
	if gkxy==1 then
	 kpw	portk	gkpw2,kporttime
	 ifadecurve	ftgenonce	0,0,1024,20,2		;HANNING WINDOW USED FOR THE CROSSFADING CURVES
	 kwave	=	(gkwave2-1)/2
	 kamp1	table	kwave+0.5,ifadecurve,1			;
	 kamp2	table	kwave,ifadecurve,1			;
	 kamp3	table	kwave-0.5,ifadecurve,1			;
	 aamp1	interp	kamp1
	 aamp2	interp	kamp2
	 aamp3	interp	kamp3
	 a1	vco	kamp, kcps, 1, kpw, gisine, imaxd, i(gkleak), i(gknyx)/sr, i(gkphs)
	 a2	vco	kamp, kcps, 2, kpw, gisine, imaxd, i(gkleak), i(gknyx)/sr, i(gkphs)
	 a3	vco	kamp, kcps, 3, kpw, gisine, imaxd, i(gkleak), i(gknyx)/sr, i(gkphs)
	 asig	sum	a1*aamp1,a2*aamp2,a3*aamp3
	endif
	rireturn						;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
			out		asig
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>