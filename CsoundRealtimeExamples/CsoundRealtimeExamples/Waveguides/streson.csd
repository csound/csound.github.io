streson.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b400 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"streson", 500,    250,    0,  0
 
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",	1,    0,    22,    120,     25,    5,  5,    0,      1,     0,        -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     3,     18,      45,   250, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      20, 200,   0
ih		 	FLbox  	"Seashore", 		1,       5,    11,     60,      13, 270,   0
ih		 	FLbox  	"Live    ", 		1,       5,    11,     60,      13, 270,  15
ih		 	FLbox  	"Impulses", 		1,       5,    11,     60,      13, 270,  30

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfr				FLvalue	" ",      100,     20,    5,  75
idfdbgain			FLvalue	" ",      100,     20,    5, 125
idamp				FLvalue	" ",      100,     20,    5, 225
idAtt	  			FLvalue "",        60,     20,    5, 175
idRel	  			FLvalue "",        60,     20,  255, 175

;SLIDERS					            			MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkfr,ihfr			FLslider 	"Frequency",			20,  10000, -1,    23,      idfr,       490,     25,    5,    50
gkfdbgain,ihfdbgain		FLslider 	"Feedback Gain (i-rate)",	-0.999,0.999,0,    23,      idfdbgain,   490,     25,    5,   100
gkAtt,ihAtt			FLslider	"Attack Time",			0.05,   10,  0,    23,     idAtt,       240,     25,    5,   150
gkRel,ihRel			FLslider	"Release Time",			0.05,   10,  0,    23,     idRel,       240,     25,  255,   150
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,      idamp,      490,     25,    5,   200
gkingain,ihingain		FLslider 	"Live Input Gain",		0,       1,  0,    23,      -1,         140,     20,  350,     5

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	400, 	ihfr
				FLsetVal_i	.9, 	ihfdbgain
				FLsetVal_i	.7, 	ihamp
				FLsetVal_i   	0.05, 	ihAtt
				FLsetVal_i   	2, 	ihRel
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 540, 512, 0
				FLscroll     515, 540, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           streson                           ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Streson implements a sympathetic string resonating-type      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"filter using comb, lowpass and allpass filter in an algorithm", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"similar to that of the Karplus-Strong plucked string model.  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Streson's audible output is similar to that of the 'wguide1' ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"opcode. One difference is that 'Feedback' is variable only   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"at i-rate in streson.                                        ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"'Feedback' is expressed as a ratio of the entire signal. A   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"value of 0 means that none of the signal will be fed back    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"into the system, a value of 1 means that all of the signal   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"will be fed back into the system.                            ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"The use of feedback can create dramatic rises in output      ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"amplitude, therefore in this example I have included a slider", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"that controls output amplitude.                              ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"Note that tuning inaccuracies are increasingly exhibited as  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"'Frequency' is increased. If precise tuning is required then ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"it will probably not be suffucient to rely on the value given", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"for 'Frequency' and instead this should be checked by ear.   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"input, the computer's live input or a stream of click        ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"impulses. The risk of feedback is greatly increased through  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"the use of streson processing so for this reason a gain      ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"control on the live input, which is initially zero, is       ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"included. Use with caution! It might actually be better to   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"monitor through headphones to further reduce the risk of     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"feedback when using the live input.                          ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"This example can also be activated via MIDI. In this mode the", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"frequency at which wguide1 resonates is determined by the    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"pitch of the MIDI note played - the frequency FLTK slider    ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"will be ignored. Polyphony is be possible in the mode.       ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"'Attack Time' controls the amplitude rise time of the impulse", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"sound. 'Release Time' controls the forced decay time of any  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"residual ringing of wguide1 after a MIDI note (or the FLTK   ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"switch) is released. Upon note release the impulse sound is  ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"stopped almost immediately. In order for longer release times", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"to become apparent 'Feedback' and 'LPF Cutoff Frequency' will", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"need to be high.                                             ", 	1,      5,     14,    490,    20,     5, 740
				FLscrollEnd

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	2
	if	gkinput==0	then	;IF INPUT 'Seashore' IS SELECTED...
		gasigL, gasigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	elseif	gkinput==1	then	;IF INPUT 'Live' IS SELECTED...
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER						;END OF CONDITIONAL BRANCHING
	else	;OTHERWISE...
		kint	random	0.02,0.4;INTERVAL BETWEEN IMPULSES IS RANDOMISED
		a1	mpulse	4,kint	;GENERATE IMPULSES
		kcfoct	randomi	6,12,2	;GENERATE RANDOM VALUES FOR FILTER CUTOFF FREQUENCY (OCT FORMAT)
		a1	butlp	a1, cpsoct(kcfoct)	;LOWPASS FILTER STREAM OF CLICKS
		kpan	randomi	0, 1, 10		;RANDOM PANNING FUNCTION
		gasigL, gasigR	pan2	a1, kpan	;PAN THE MONO SIGNAL TO CREATE 2 STEREO CHANNELS
	endif
endin

instr	1
	iporttime	=	0.01				;I-RATE VARIABLE DEFINITION OF PORTAMENTO TIME
	kporttime	linseg	0,0.01,iporttime,1,iporttime	;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	kMIDIflag	init	iMIDIflag

	if	gkOnOff=0&&kMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
		turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif				;ENDI OF THIS CONDITIONAL BRANCH


	if kMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		kfr	=	icps			;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
	else						;OTHERWISE...
		kfr		portk	gkfr, kporttime	;SMOOTH VARIABLE CHANGES WITH PORTK
	endif						;END OF THIS CONDITIONAL BRANCH

	aAttack		expsega	0.001,i(gkAtt),1,1,1
	krelease	release				;SENSE IF WE ARE IN A RELEASE STAGE - THIS WILL BE USED TO MUTE THE INPUT TO ALLOW THE SOUND TO DIE AWAY NATURALLY
	krelease	portk	krelease, kporttime
	aRelease	interp	(1-krelease)
	aInputEnv	=	aAttack*aRelease
	kSwitch		changed	gkfdbgain	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	aresL 		streson gasigL*aInputEnv, kfr, i(gkfdbgain)
	aresR 		streson gasigR*aInputEnv, kfr, i(gkfdbgain)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	aenv		expsegr	1,i(gkRel),0.0001
			outs	aresL * gkamp * aenv, aresR * gkamp * aenv	;SEND streson OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin
  	
</CsInstruments>

<CsScore>
i 2 0 3600	;INPUT SOUND (ALWAYS ON)
</CsScore>

</CsoundSynthesizer>