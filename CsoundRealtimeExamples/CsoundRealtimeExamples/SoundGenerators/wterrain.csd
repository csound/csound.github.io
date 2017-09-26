wterrain.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
;VIRTUAL MIDI DEVICE
-odac -dm0 -M0 -+rtmidi=virtual

;EXTERNAL MIDI
;-odac -dm0 -Ma
</CsOptions>

<CsInstruments>
sr 	= 	44100
ksmps 	= 	16
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE------------------------------------------------------------------------------------------------------------------------
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"wterrain",   500,     680,   0,  0

;SWITCHES								ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
gkMIDItoFLTK,ihMIDItoFLTK	FLbutton	"Update FLTK from MIDI",1,    0,    22,    200,     25,  295,  5,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihMIDItoFLTK	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idfreq		FLvalue	"",     100,    20,    5,   75
idcx		FLvalue	"",     100,    20,    5,  125
idcy		FLvalue	"",     100,    20,    5,  175
idrx		FLvalue	"",     100,    20,    5,  225
idry		FLvalue	"",     100,    20,    5,  275
idAtt	  	FLvalue	"",	 60,    20,    5,  375
idRel	  	FLvalue	"",	 60,    20,  255,  375

;SLIDERS				     			MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X | Y
gkfreq, gihfreq		FLslider	"Freq",			1,   8000,  -1,    23,  idfreq,   490,     25,    5,  50
gkcx, gihcx		FLslider	"X Centre (CC#1)",	0,      1,   0,    23,    idcx,   490,     25,    5, 100
gkcy, gihcy		FLslider	"Y Centre (CC#2)",	0,      1,   0,    23,    idcy,   490,     25,    5, 150
gkrx, gihrx		FLslider	"X Radius (CC#3)",	0,      5,   0,    23,    idrx,   490,     25,    5, 200
gkry, gihry		FLslider	"Y Radius (CC#4)",	0,      5,   0,    23,    idry,   490,     25,    5, 250
gkamp, ihamp		FLslider	"Amplitude",		0,      1,   0,    23,      -1,   490,     25,    5, 300
gkAtt,ihAtt		FLslider	"Attack Time",		0.01,  10,   0,    23,    idAtt,  240,     25,    5, 350
gkRel,ihRel		FLslider	"Release",		0.01,  10,   0,    23,    idRel,  240,     25,  255, 350
gkRvbSnd,ihRvbSnd	FLslider	"Reverb Amount",	0,      1,   0,    23,       -1,  490,     25,    5, 570
gkJitX,ihJitX		FLslider	"X Radius Jitter Amount",0,  0.5,   0,    23,        -1,  240,     25,    5, 630
gkJitY,ihJitY		FLslider	"Y Radius Jitter Amount",0,  0.5,   0,    23,        -1,  240,     25,  255, 630
gk1_1,ih1_1		FLslider	"1",			0,      1,   0,    24,       -1,   15,     60,   70, 400
gk1_2,ih1_2		FLslider	"2",			0,      1,   0,    24,       -1,   15,     60,   90, 400
gk1_3,ih1_3		FLslider	"3",			0,      1,   0,    24,       -1,   15,     60,  110, 400
gk1_4,ih1_4		FLslider	"4",			0,      1,   0,    24,       -1,   15,     60,  130, 400
gk1_5,ih1_5		FLslider	"5",			0,      1,   0,    24,       -1,   15,     60,  150, 400
gk1_6,ih1_6		FLslider	"6",			0,      1,   0,    24,       -1,   15,     60,  170, 400
gk1_7,ih1_7		FLslider	"7",			0,      1,   0,    24,       -1,   15,     60,  190, 400
gk1_8,ih1_8		FLslider	"8",			0,      1,   0,    24,       -1,   15,     60,  210, 400
gk1_9,ih1_9		FLslider	"9",			0,      1,   0,    24,       -1,   15,     60,  230, 400
gk1_10,ih1_10		FLslider	"10",			0,      1,   0,    24,       -1,   15,     60,  250, 400
gk1_11,ih1_11		FLslider	"11",			0,      1,   0,    24,       -1,   15,     60,  270, 400
gk1_12,ih1_12		FLslider	"12",			0,      1,   0,    24,       -1,   15,     60,  290, 400

gk2_1, ih2_1		FLslider	"1",			0,      1,   0,    24,       -1,   15,     60,   70, 480
gk2_2, ih2_2		FLslider	"2",			0,      1,   0,    24,       -1,   15,     60,   90, 480
gk2_3, ih2_3		FLslider	"3",			0,      1,   0,    24,       -1,   15,     60,  110, 480
gk2_4, ih2_4		FLslider	"4",			0,      1,   0,    24,       -1,   15,     60,  130, 480
gk2_5, ih2_5		FLslider	"5",			0,      1,   0,    24,       -1,   15,     60,  150, 480
gk2_6, ih2_6		FLslider	"6",			0,      1,   0,    24,       -1,   15,     60,  170, 480
gk2_7, ih2_7		FLslider	"7",			0,      1,   0,    24,       -1,   15,     60,  190, 480
gk2_8, ih2_8		FLslider	"8",			0,      1,   0,    24,       -1,   15,     60,  210, 480
gk2_9, ih2_9		FLslider	"9",			0,      1,   0,    24,       -1,   15,     60,  230, 480
gk2_10,ih2_10		FLslider	"10",			0,      1,   0,    24,       -1,   15,     60,  250, 480
gk2_11,ih2_11		FLslider	"11",			0,      1,   0,    24,       -1,   15,     60,  270, 480
gk2_12,ih2_12		FLslider	"12",			0,      1,   0,    24,       -1,   15,     60,  290, 480

;TEXT BOXES					TYPE | FONT | SIZE |  WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"X Wave", 	1,       2,    13,      70,     20,    0, 420
ih		 	FLbox  	"Y Wave", 	1,       2,    13,      70,     20,    0, 500

;INITIAL VALUES OF SLIDERS
;	OPCODE		VALUE | HANDLE
	FLsetVal_i	400,	gihfreq
	FLsetVal_i	0.2,	gihcx
	FLsetVal_i	0.7,	gihcy
	FLsetVal_i	0.3,	gihrx
	FLsetVal_i	0.3,	gihry
	FLsetVal_i	0.4,	ihamp
	FLsetVal_i   	1.2,	ihAtt
	FLsetVal_i   	5,	ihRel
	FLsetVal_i   	0.5,	ihRvbSnd
	FLsetVal_i   	0.05,	ihJitX
	FLsetVal_i   	0.05,	ihJitY
;VALUES FOR PARTIAL WILL BE INVERTED. I.E. 1 WILL BE MINUMUM AMP. 0 WILL BE MAXIMUM AMP. - THIS IS DONE ON ACCOUNT OF A LIMITATION OF VERTICAL FLTK SLIDERS
	FLsetVal_i   	1-1,	ih1_1
	FLsetVal_i   	1-0,	ih1_2
	FLsetVal_i   	1-0.33,	ih1_3
	FLsetVal_i   	1-0,	ih1_4
	FLsetVal_i   	1-0.2,	ih1_5
	FLsetVal_i   	1-0,	ih1_6
	FLsetVal_i   	1-0.14,	ih1_7
	FLsetVal_i   	1-0,	ih1_8
	FLsetVal_i   	1-0.11,	ih1_9
	FLsetVal_i   	1,	ih1_10
	FLsetVal_i   	1,	ih1_11
	FLsetVal_i   	1,	ih1_12
	FLsetVal_i   	0,	ih2_1
	FLsetVal_i   	1,	ih2_2
	FLsetVal_i   	1,	ih2_3
	FLsetVal_i   	1,	ih2_4
	FLsetVal_i   	1,	ih2_5
	FLsetVal_i   	1,	ih2_6
	FLsetVal_i   	1,	ih2_7
	FLsetVal_i   	1,	ih2_8
	FLsetVal_i   	1,	ih2_9
	FLsetVal_i   	1,	ih2_10
	FLsetVal_i   	1,	ih2_11
	FLsetVal_i   	1,	ih2_12
	FLsetVal_i   	1,	ihMIDItoFLTK
	FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 700, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         wterrain                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"wterrain is an implementation of wave terrain synthesis.     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"In wave terrain synthesis two single cycle waveforms are     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"defined and a 3-dimensional 'wave terrain' is constructed by ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"setting these at 90 degrees to wach other.                   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"In this implemention elliptical movement through this wave   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"terrain is defined by first defining the frequency of this   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"movement, then the centre and amplitude (radius) of movement ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"in the x axis and the centre and amplitude (radius) of       ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"movement in the y axis.                                      ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"The two wave forms (shown below) can be modified using the   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"banks of mini sliders. The 12 sliders represent the relative ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"amplitudes of the first 12 partials of a harmonic waveform.  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"The first function table (x axis) is rich in higher          ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"harmonics, the second is a sine wave.                        ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"A simple ASR envelope also modulates the radius values. The  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"user can adjust the attack and release times of this         ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"envelope.                                                    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"A user definable amount of jitter can be applied to the two  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"paramters. This can be useful in preventing static sounding  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"timbres. Some reverb can also be added in this example to    ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"further warm up the sound.                                   ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"This example can also be played from a MIDI keyboard. In this", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"mode MIDI pitch is translated to frequency of the elliptical ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"movement. (FLTK defined frequency will be ignored.)          ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"MIDI note velocity will also modulate the two radii          ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"parameters ised in forming the ellipse. Aurally this equates ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"to 'brightness'.                                             ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"Some keyboard scaling is used in MIDI actuated notes. This is", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"done in order to prevent excessive shrillness in the upper   ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"register with respect to how notes sound in the lower        ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"register.                                                    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"The two 'centre' and 'radius' paramters can also be modulated", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"using MIDI controllers 1-4 as indicated in the GUI.          ", 	1,      5,     14,    490,    20,     5, 680

			FLpanel_end

			FLrun		;RUN THE WIDGET THREAD
;END OF FLTK INTERFACE CODE--------------------------------------------------------------------------------------------------------------------------

garvbL,garvbR	init	0	;INITIALIZE GLOBAL AUDIO REVERB SEND SIGNALS
giKybdScaling	ftgen	0,0,128,5,1,32,1,96,0.4	;KEYBOARD SCALING WHICH WILL BE USED TO PREVENT EXCESSIVE SHRILLNESS IN THE UPPER REGISTER FOR MIDI TRIGGERED NOTES

instr	2	;UPDATE WAVEFORMS
	ktrig	changed	gk1_1, gk1_2, gk1_3, gk1_4, gk1_5, gk1_6, gk1_7, gk1_8, gk1_9, gk1_10, gk1_11, gk1_12, gk2_1, gk2_2, gk2_3, gk2_4, gk2_5, gk2_6, gk2_7, gk2_8, gk2_9, gk2_10, gk2_11, gk2_12	;IF ANY OF THE INPUT VARIABLES CHANGE OUTPUT A MOMENTARY '1' (BANG)
	if ktrig=1 then		;IF ANY OF THE TABLE PARTIAL AMPLITUDE SLIDERS HAS BEEN CHANGED...
		reinit	UPDATE	;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif			;END OPF THIS CONDITIONAL BRANCH
	UPDATE:			;A LABEL CALLED 'UPDATE'
	;DEFINE THE TWO GEN 10 FUNCTION TABLES THAT WILL BE USED ON THE WAVE TERRAIN SYNTHESIS (NOTE THAT PARTIAL AMPLITUDE VALUES ARE INVERTED WITH RESPECT TO THE VALUES DEFINED BY THE ON SCREEN SLIDERS, THIS IS DUE TO A LIMITATION OF VERTICAL SLIDERS)
	giwave1		ftgen	1,0,8192,10,1-i(gk1_1),1-i(gk1_2),1-i(gk1_3),1-i(gk1_4),1-i(gk1_5),1-i(gk1_6),1-i(gk1_7),1-i(gk1_8),1-i(gk1_9),1-i(gk1_10),1-i(gk1_11),1-i(gk1_12)
	giwave2		ftgen	2,0,8192,10,1-i(gk2_1),1-i(gk2_2),1-i(gk2_3),1-i(gk2_4),1-i(gk2_5),1-i(gk2_6),1-i(gk2_7),1-i(gk2_8),1-i(gk2_9),1-i(gk2_10),1-i(gk2_11),1-i(gk2_12)
	rireturn		;RETURN FROM REINITIALIZATION PASS
endin

instr 	1
	iporttime	=	0.05			;CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
	kporttime	linseg	0, 0.01, iporttime	;CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	if	gkOnOff=0&&iMIDIflag=0	then 		;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
		turnoff					;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif						;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON...
		iPBrange	=	2		;PITCH BEND RANGE
		kbend	pchbend	0,iPBrange*2		;PITCH BEND
		icps	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
		inum	notnum				;READ IN MIDI NOTE NUMBER (0-127) - WILL BE USED IN KEYBOARD SCALING
		iamp	ampmidi	1			;READ MIDI AMPLITUDE VALUES
		kfreq	=	icps*semitone(kbend)	;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
		iKybdScale	table	inum, giKybdScaling	;READ IN KEYBOARD SCALING VALUE FROM FUNCTION TABLE - INDEX IS DERIVED FROM MIDI NOTE NUMBER
		iamp	=	iamp * iKybdScale	;APPLY KEYBOARD SCALING TO AMPLITUDE VALUE - THIS IS DONE TO PREVERN EXCESSIVE SHRILLNESS IN THE UPPER REGISTER
	else						;OTHERWISE...
		kfreq	portk	gkfreq, kporttime	;USE THE FLTK SLIDER VALUE
		iamp	=	1			;AS THERE IS NO MIDI AMPLITUDE IN AN FLTK ACTUATED NOTE IT WILL IN THIS CASE BE JUST GIVEN A VALUE OF '1'
	endif						;END OF THIS CONDITIONAL BRANCH

	kRadEnv	linsegr	0, i(gkAtt), iamp, i(gkRel), 0	;RADIUS ENVELOPE
	
	kcx	portk	gkcx, kporttime			;APPLY PORTAMENTO SMOOTHING TO FLTK SLIDER VARIABLE
	kcy	portk	gkcy, kporttime			;APPLY PORTAMENTO SMOOTHING TO FLTK SLIDER VARIABLE
	krx	portk	gkrx, kporttime	;APPLY PORTAMENTO SMOOTHING TO FLTK SLIDER VARIABLE
	kry	portk	gkry, kporttime	;APPLY PORTAMENTO SMOOTHING TO FLTK SLIDER VARIABLE

	krxJit	jspline	gkJitX,1,10	;JITTER SIGNAL
	kryJit	jspline	gkJitY,1,10	;JITTER SIGNAL
	
	asigL	wterrain	gkamp,  kfreq, kcx, kcy, krx*kRadEnv*(1+krxJit), kry*kRadEnv*(1+kryJit), giwave1, giwave2
	asigR	wterrain	gkamp, -kfreq, kcx, kcy, krx*kRadEnv*(1+krxJit), kry*kRadEnv*(1+kryJit), giwave1, giwave2	;RIGHT CHANNEL FREQUENCY IS INVERTED TO CREAT A STEREO EFFECT
	asigL	dcblock		asigL							;BLOCK DC OFFSETS
	asigR	dcblock		asigR							;BLOCK DC OFFSETS

	aenv	expseg	0.001, 0.01, 1,1,1	;DECLICKING AMPLITUDE ENVELOPE
	asigL	=	asigL * aenv		;SCALE AUDIO SIGNAL WITH AMPLITUDE ENVELOPE
	asigR	=	asigR * aenv		;SCALE AUDIO SIGNAL WITH AMPLITUDE ENVELOPE
		outs	asigL, asigR		;SEND AUDIO TO OUTPUTS
	garvbL	=	garvbL + (asigL * gkRvbSnd)	;ADD TO GLOBAL AUDIO REVERB CHANNEL (LEFT)
	garvbR	=	garvbR + (asigR * gkRvbSnd)	;ADD TO GLOBAL AUDIO REVERB CHANNEL (RIGHT)
endin

instr	3	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
        ;MIDI CONTROLLER SYNCHRONISATION
#define CONTROLLER(NAME'NUMBER'MIN'MAX)
        #
        k$NAME          ctrl7           1,$NUMBER,0,1           ;READ MIDI CONTROLLER
	ktrig$NAME      changed         k$NAME                  ;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
        k$NAME          scale           k$NAME, $MAX, $MIN      ;VARIBALE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
        FLsetVal        ktrig$NAME*gkMIDItoFLTK,     k$NAME, gih$NAME                ;UPDATE FLTK VALUATOR IF MIDI CONTROLLER HAS BEEN MOVED
        if ktrig$NAME==1 then
         gk$NAME		=		k$NAME
	endif
	#
        ;           NAME NUM MIN MAX
        $CONTROLLER(cx'   1 ' 0 ' 1)
        $CONTROLLER(cy'   2 ' 0 ' 1)
        $CONTROLLER(rx'   3 ' 0 ' 5)
        $CONTROLLER(ry'   4 ' 0 ' 5)
endin

instr	4	;REVERB
	asigL,asigR	reverbsc	garvbL, garvbR, 0.8, 7000
	outs	asigL,asigR
	clear	garvbL, garvbR	;C;EAR GLOBAL AUDIO VARIABLES
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;UPDATE FUNCTION TABLES
i 3 0 3600	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
i 4 0 3600	;REVERB
</CsScore>

</CsoundSynthesizer>