vco2.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400 -M0 -+rtmidi=virtual -d -m0
;-odevaudio -b1000 -d -m0 -M0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	2	
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"vco2",     500,    670,    0,  0

		;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkKPhs,ihKPhs			FLbutton	"k-rate  phase",	16,    0,    2,    130,     30,    5,  50,   -1  
FLsetColor2	255, 255, 0, ihKPhs

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkxy,ihxy			FLbutton	"X-Y Control",	1,    0,    22,    150,     30,   10, 480,   -1
FLsetColor2	 255, 255, 50,ihxy

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFLTK_MIDI, ihFLTK_MIDI	FLbutBank	4,      1,     2,     20,      40,    5,  5,     0,     1,    0, 3600
gkmode, ihmode			FLbutBank	4,      1,     8,     20,     160,  150,  5,    -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI", 	1,      6,     17,     50,     20,   23,   4
ih		 	FLbox  	"FLTK", 	1,      6,     17,     50,     20,   23,  24

ih		 	FLbox  	"Wave:", 	1,      6,     15,     50,     20,  100,   5

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Sawtooth                                  ", 	1,      5,     12,    300,     20,  170,   5
ih		 	FLbox  	"Square / PWM                              ", 	1,      5,     12,    300,     20,  170,  25
ih		 	FLbox  	"Sawtooth / Triangle / Ramp                ", 	1,      5,     12,    300,     20,  170,  45
ih		 	FLbox  	"Pulse                                     ", 	1,      5,     12,    300,     20,  170,  65
ih		 	FLbox  	"4 * x * (1 - x) (i.e. integrated sawtooth)", 	1,      5,     12,    300,     20,  170,  85
ih		 	FLbox  	"Square wave (no PWM, faster)              ", 	1,      5,     12,    300,     20,  170, 105
ih		 	FLbox  	"triangle (no ramp, faster)                ", 	1,      5,     12,    300,     20,  170, 125
ih		 	FLbox  	"user defined waveform                     ", 	1,      5,     12,    300,     20,  170, 145

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X | Y                                          
idamp			FLvalue	" ",      80,     20,    5, 195
idcps			FLvalue	" ",      80,     20,    5, 245
idnyx			FLvalue	" ",      80,     20,    5, 295
idpw			FLvalue	" ",      80,     20,    5, 345
idphs			FLvalue	" ",      80,     20,    5, 395
idphsDep		FLvalue	" ",      60,     20,    5, 445
idphsRte		FLvalue	" ",      60,     20,  255, 445
idx			FLvalue	"wave", 	 120,     20,   50, 535
idy			FLvalue	"pulse width",   120,     20,   50, 575

;SLIDERS				     				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider	"Amplitude",  			0,       1,   0,   23,  idamp,   490,     25,    5, 170
gkcps, ihcps		FLslider	"Frequency (Hertz)",  		2,   10000,  -1,   23,  idcps,   490,     25,    5, 220
gknyx, ihnyx		FLslider	"Number of Harmonics",		0,     0.5,   0,   23,  idnyx,   490,     25,    5, 270
gkpw, gihpw		FLslider	"Pulse Width (CC#1)",    	0,       1,   0,   23,   idpw,   490,     25,    5, 320
gkphs, ihphs		FLslider	"Initial Phase",    		0,       1,   0,   23,  idphs,   490,     25,    5, 370
gkphsDep, ihphsDep	FLslider	"Phase Mod. Depth",    		0,       1,   0,   23,idphsDep,  240,     25,    5, 420
gkphsRte, ihphsRte	FLslider	"Phase Mod. Rate",    		0.001,  50,   0,   23,idphsRte,  240,     25,  255, 420

;XY PANELS									MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X  | Y
gkwave2, gkpw2, ihwave2, ihpw2	FLjoy	"X - wave(1-2-3) Y - Pulse Width",	1,       3,  0.001, 0.999,   0,      0,    idx,    idy,    300,    180,   170, 470

;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	0.1, 	ihamp
		FLsetVal_i	100, 	ihcps
		FLsetVal_i	0.25, 	ihnyx
		FLsetVal_i	.5, 	gihpw
		FLsetVal_i	0, 	ihphs
		FLsetVal_i	0, 	ihphsDep
		FLsetVal_i	0.001, 	ihphsRte
		FLsetVal_i	2, 	ihwave2
		FLsetVal_i	0.5, 	ihpw2
		
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 500, 512, 0
				FLscroll     515, 500, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"             vco2 (voltage controlled oscillator)            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"vco2 is similar to vco in that it models a variety of        ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"waveforms based on the integration of band-limited impulses. ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"A key difference with vco2 is that it precalculates the      ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"tables that it will use and therefore requires less realtime ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"computation. It will however require additional RAM for the  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"storage of these precalculated tables. Optional use of the   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"vco2init will allow stored tables to be shared between       ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"instruments and voices therefore saving RAM and computation  ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"of the tables each time the opcode is initialized - this     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"might prove useful where a high level of polyphony and       ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"instrument reiteraction is required.                         ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"vco2 offers more waveforms than vco and higher quality       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"waveforms. vco2 also allows k-rate modulation of phase which ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"vco does not.                                                ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"This example can be manipulated entirely using the FLTK      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"widgets or it can be partially controlled using a MIDI       ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"keyboard in which case it will respond to MIDI note numbers, ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"key velocity and pitch bend. Modulation wheel (controller 1) ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"can be used to manipulate pulse width.                       ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"Some of vco2's waveform options offer improved efficiency by ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"removing options which might not be needed such as pulse     ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"width modulation.                                            ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Waveform options that offer multiple types (such as options 2", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"and 3) can morph between the waveforms offered by modulating ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"'Pulse Width'.                                               ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"Choosing the 'User Defined Opcode' option requires the use of", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"the 'vco2init' opcode. There are additional advantages to    ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"using vco2init, even when using vco2's other waveforms:      ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"* Waveforms are loaded at the beginning of the performance   ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"  as opposed to when the opcode is initialized. This might   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"  offer realtime performance adavantages.                    ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"* Waveforms can be shared between instances of vco2. This    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"  will provide an efficiency advantage if multiple instances ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"  of vco2 are begin used.                                    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"* By using vco2init we can access vco2's internal waveforms  ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"  from other opcodes. The appropriate table numbers can be   ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"  derived by using the vco2ft opcode.                        ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"In this example, as vco2init is not being used, the user     ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"defined waveform option will not work.                       ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"If 'k-rate phase' has been activated, phase is modulated by  ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"a sine wave LFO, the depth and rate of which can be changed  ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"by the user using the two short sliders at the bottom of the ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"GUI. If 'k-rate phase' is not activated, initial phase is    ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"set using the 'Initial Phase' slider.                        ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"It will be heard that phase modulation is heard as a         ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"modulation of pitch.                                         ", 	1,      5,     14,    490,    20,     5, 880

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1

instr	1		;VCO2 INSTRUMENT
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
        ;OUTPUT                 OPCODE          CHANNEL | CC.NUMBER | MIN | MAX
        kpw                     ctrl7           1,            1,      0,    1	;READ IN MIDI CONTROLLER
        ktrig                   changed         kpw    ;IF THE VARIABLE 'kptr' CHANGES FROM ITS PREVIOUS VALUE,
                                                        ;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
        ;                       OPCODE      |   TRIGGER | VALUE | HANDLE
                                FLsetVal        ktrig,     kpw,  gihpw	;UPDATE WIDGET WHEN A TRIGGER IS RECEIVED
        ;======================================================================================================================================================================

	;PITCH BEND===========================================================================================================================================================
	iBendRange	= 	2					;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	kbend		pchbend	0, 2					;PITCH BEND RANGE (-1 TO 1)
	kcps		=	kcps*semitone(kbend*iBendRange)
	;=====================================================================================================================================================================

	kpw		portk	gkpw, kporttime		;APPLY PORTAMENTO SMOOTHING
	kenv	linsegr	0,0.01,1,0.01,0			;ANTI-CLICK ENVELOPE
	if	gkmode=2	then			;IF 'SAWTOOTH/TRIANGLE/RAMP' HAS BEEN SELECTED...
		gkpw	limit	gkpw, 0.001, 0.999	;LIMIT PULSE WIDTH TO BE BETWEEN 0.01 AND 0.99 (INTEGER VALUES OF 0.01 AND 0.99 ARE NOT ALLOWED)
	endif						;END OF CONDITIONAL BRANCH
	kSwitch		changed		gknyx, gkmode, gkKPhs
	if	kSwitch=1	then			;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE				;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	if i(gkKPhs)=0 then
		kphs = gkphs	;INITIAL PHASE SLIDER USED
	else
		kphs	poscil	gkphsDep*0.5,gkphsRte,gisine	;PHASE MODULATION
		kphs	=	kphs + 0.5			;PHASE DEPTH
	endif
	asig	vco2	kenv*kamp, kcps, (i(gkmode)*2)+i(gkKPhs), kpw, kphs, i(gknyx)*sr	;CREATE vco2 OSCILLATOR
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
	 a1	vco2	kenv*kamp, kcps, 0+i(gkKPhs), kpw, kphs, i(gknyx)*sr
	 a2	vco2	kenv*kamp, kcps, 2+i(gkKPhs), kpw, kphs, i(gknyx)*sr
	 a3	vco2	kenv*kamp, kcps, 4+i(gkKPhs), kpw, kphs, i(gknyx)*sr
	 asig	sum	a1*aamp1,a2*aamp2,a3*aamp3
	endif
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs		asig, asig	;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>