wguide1stack.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL          | WIDTH | HEIGHT | X | Y
				FLpanel	"wguide1stack",   500,    500,    0,  0
 
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",	1,    0,    22,    150,     30,    5,  5,    0,      1,      0,       -1
gkdual,ihdual			FLbutton	"Dual",		1,    0,    22,     60,     16,  385,265,    0,      1,      0,       -1
FLsetTextSize	12,ihdual
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255,  50, 50, ihdual	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     3,     18,      45,   250, 0,   -1
gktype, ihtype			FLbutBank	14,     1,     2,     18,      30,   365,230,  -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      20, 200,   0
ih		 	FLbox  	"Seashore", 		1,       5,    11,     60,      13, 270,   0
ih		 	FLbox  	"Live    ", 		1,       5,    11,     60,      13, 270,  15
ih		 	FLbox  	"Impulses", 		1,       5,    11,     60,      13, 270,  30
ih		 	FLbox  	"Geometric ", 		1,       5,    11,     70,      15, 385,  230
ih		 	FLbox  	"Arithmetic", 		1,       5,    11,     70,      15, 385,  245

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq				FLvalue	"",        70,     20,    5,  75
idcutoff			FLvalue	"",        70,     20,    5, 125
idfeedback			FLvalue	"",        70,     20,    5, 175
idinterval			FLvalue	"",        70,     20,    5, 225
idHPF				FLvalue	"",        70,     20,    5, 325
idLPF				FLvalue	"",        70,     20,    5, 375
idamp				FLvalue	"",        70,     20,    5, 475
idAtt	  			FLvalue "",        60,     20,    5, 425
idRel	  			FLvalue "",        60,     20,  255, 425

;SLIDERS					            			MIN   | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X   | Y
gkfreq,ihfreq			FLslider 	"Frequency",			20,    10000, -1,    23,   idfreq,      490,      25,   5,    50
gkcutoff,ihcutoff		FLslider 	"LPF Cutoff Frequency",		20,    20000, -1,    23,   idcutoff,    490,      25,   5,   100
gkfeedback,ihfeedback		FLslider 	"Feedback",			-0.999,0.999,  0,    23,   idfeedback,  490,      25,   5,   150
gkinterval,ihinterval		FLslider 	"Interval",			-12,      12,  0,    23,   idinterval,  490,      25,   5,   200
gkHPF,ihHPF			FLslider 	"Highpass Filter",		20,     sr/2, -1,    23,   idHPF,       490,      25,   5,   300
gkLPF,ihLPF			FLslider 	"Lowpass Filter",		20,     sr/2, -1,    23,   idLPF,       490,      25,   5,   350
gkAtt,ihAtt			FLslider	"Attack Time",			0.05,     10,  0,    23,   idAtt,       240,     25,    5,   400
gkRel,ihRel			FLslider	"Release Time",			0.05,     10,  0,    23,   idRel,       240,     25,  255,   400
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0.0001,    1, -1,    23,   idamp,       490,      25,   5,   450
gkingain,ihingain		FLslider 	"Live Input Gain",		0,         1,  0,    23,   -1,          140,      20, 350,     5

				FLsetVal_i	0.25, 	ihinterval

;COUNTERS					     			MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X | Y  | OPCODE 
gkmax, ihmax			FLcount  	"Num. wguide1s", 	1,    100,   1,     12,     2,      100,     20,     5, 250,   -1 
gkmin, ihmin			FLcount  	"Lowest", 		1,    100,   1,     12,     2,      100,     20,   125, 250,   -1 
gkinterval, ihinterval		FLcount  	"Interval", 		-24,   24,  0.01,    1,     1,      100,     20,   245, 250,   -1 

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	150, 	ihfreq
				FLsetVal_i	8000, 	ihcutoff
				FLsetVal_i	.99, 	ihfeedback
				FLsetVal_i	0.25, 	ihinterval
				FLsetVal_i	0.05, 	ihamp
				FLsetVal_i   	0.05, 	ihAtt
				FLsetVal_i   	2, 	ihRel
				FLsetVal_i   	14, 	ihmax
				FLsetVal_i   	1, 	ihmin
				FLsetVal_i   	1, 	ihtype
				FLsetVal_i   	20, 	ihHPF
				FLsetVal_i   	sr/2, 	ihLPF
				
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 600, 512, 0
				FLscroll     515, 600, 0,0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           wguide1                           ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example, an eleboration of the example 'wguide1.csd',   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"implements a stack of up to 100 wguide1s the frequencies of  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"which are defined using either a geometric or an arithmetic  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"series. The factor between series elements is defined using  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"'Interval' which can be changed using either a slider or a   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"counter.                                                     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Musically speaking, if 'Geometric' mode is selected,         ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'Interval' is '1' and 'Frequency' is 261Hz (middle C), then  ", 	1,      5,     14,    490,    20,     5, 180 
ih		 	FLbox  	"the first wave guide will be C, the second C#, the third D   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"and so on.                                                   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"In 'Arithmetic' mode 'Interval' defines the interval between ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"consecutive wguide1s in semitones.                           ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"If 'Arithmetic' mode is chosen, 'Interval' is '1' and        ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"'Frequency' is 200Hz then the frequency of the first wave    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"guide will be 200Hz, the second 400Hz, the third 600Hz and   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"so on. You might have noticed that in this example the       ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"frequencies follow the harmonic series.                      ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"The number of wguide1s in the stack can be modified in real- ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"-time using the 'Num.Wguide1s' counter.                      ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"The value in the series from which to begin reading values   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"does not need to be the first and can be offset using the    ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"'Lowest' counter.                                            ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"If 'Dual' is activated wguide1s will be created both above   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"and below the fundamental frequency 'Frequency'. In this case", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"the actual number of wguide1s created will be double the     ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"number demanded by 'Num.wguide1s'.                           ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"If the frequency of a particular waveguide will be beyond a  ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"sensible limit then that waveguide will be removed from the  ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"stack. Therefore, depending on the setting used, the full    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"compliment of wguide1s as defined by 'Num wguide1s' may not  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"sound.                                                       ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"To facilitate further spectral manipulation, the input sound ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"is passed through a highpass filter and a lowpass filter in  ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"in series before is is passed through the waveguides.        ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"For further information on 'wguide1' and on the other aspects", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"of this example please study the example 'wguide1.csd'.      ", 	1,      5,     14,    490,    20,     5, 740
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;A RECURSIVE UDO IS USED TO CREATE THE STACK OF WGUIDE1S
opcode	wguide1stack, a, akkkkkii					;OPCODE DEFINITION
ain,kfreq,kcutoff,kfeedback,kint,ktype,icount,imax	xin		;INPUT ARG NAMES
	amix	=	0
	if ktype==0 then						;IF GEOMETRIC MODE HAS BEEN CHOSEN...
	 kfreq2	=	kfreq*semitone(kint*(icount-1))			;DEFINE FREQUENCY FOR THIS WGUIDE1 ACCORDING TO THE BASE FREQUENCY, INTERVAL AND THE COUNTER (LOCATION IN SERIES)
	else								;OTHERWISE MUST BE ARITHMETIC MODE
	 kfreq2	=	kfreq+(kfreq*(icount-1)*kint)			;DEFINE FREQUENCY FOR THIS WGUIDE1 ACCORDING TO THE BASE FREQUENCY, INTERVAL AND THE COUNTER (LOCATION IN SERIES)
	endif								;END OF CONDITIONAL
	if abs(kfreq2)>sr/3||abs(kfreq2)<20 then					;IF FREQUENCY IS OUTSIDE OF A SENSIBLE RANGE JUMP THE CREATION OF THE WGUIDE1 ALTOGETHER
	 asig	=	0
	else
	 asig	wguide1 ain, kfreq2, kcutoff, kfeedback			;CREATE THE WGUIDE1 SIGNAL
	endif
	if icount<imax then						;IF THERE ARE STILL MORE WGUIDES TO CREATE IN THE STACK...
	  icount	=		icount + 1			;INCREMENT COUNTER THEN....
	  amix		wguide1stack	ain,kfreq,kcutoff,kfeedback,kint,ktype,icount,imax	;CALL THE UDO AGAIN
	endif								;END OF CONDITIONAL
	skip:								;LABEL - SKIP TO HERE IF THE FREQUENCY WAS OUT OF RANGE
			xout		asig + amix			;SEND MIX OF ALL AUDIO BACK TO CALLER INSTRUMENT
endop									;END OF UDO

instr	2
	if	gkinput==0	then			;IF INPUT 'Seashore' IS SELECTED...
		gasigL, gasigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	elseif	gkinput==1	then			;IF INPUT 'Live' IS SELECTED...
		asigL, asigR	ins			;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER						;END OF CONDITIONAL BRANCHING
	else	;OTHERWISE...
		kint	random	0.02,0.4		;INTERVAL BETWEEN IMPULSES IS RANDOMISED
		a1	mpulse	4,kint			;GENERATE IMPULSES
		kcfoct	randomi	6,12,2			;GENERATE RANDOM VALUES FOR FILTER CUTOFF FREQUENCY (OCT FORMAT)
		a1	butlp	a1, cpsoct(kcfoct)	;LOWPASS FILTER STREAM OF CLICKS
		kdlyL	randomh	1,10,4			;RANDOM DELAY TIMES FOR LEFT AND RIGHT CHANNELS
		kdlyR	randomh	1,10,4			;
		gasigL	vdelay	a1,kdlyL,10		;DELAY IMPULSE TO CREATE LEFT CHANNEL AUDIO
		gasigR	vdelay	a1,kdlyR,10		;DELAY IMPULSE TO CREATE RIGHT CHANNEL AUDIO
	endif

	kporttime	linseg	0,0.01,0.1		;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE

	kHPF		portk		gkHPF, kporttime
	gasigL		buthp		gasigL, kHPF
	gasigR		buthp		gasigR, kHPF
	
	kLPF		portk		gkLPF, kporttime
	gasigL		butlp		gasigL, kLPF
	gasigR		butlp		gasigR, kLPF
endin
		
instr	1
	kporttime	linseg	0,0.01,0.1		;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	kMIDIflag	init	iMIDIflag

	if	gkOnOff=0&&kMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
		turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif				;ENDI OF THIS CONDITIONAL BRANCH


	if kMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		kfreq	=	icps			;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
	else						;OTHERWISE...
		kfreq		portk	gkfreq, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	endif						;END OF THIS CONDITIONAL BRANCH

	aAttack		expsega	0.001,i(gkAtt),1,1,1
	krelease	release				;SENSE IF WE ARE IN A RELEASE STAGE - THIS WILL BE USED TO MUTE THE INPUT TO ALLOW THE SOUND TO DIE AWAY NATURALLY
	krelease	portk	krelease, kporttime
	aRelease	interp	(1-krelease)
	aInputEnv	=	aAttack*aRelease

	kinterval	portk		gkinterval, kporttime
	kchange		changed		gkmax,gkmin		;IF VALUATORS THAT DEFINE THE NUMBER OF WGUIDE1S NEEDED OR THE START POINT IN THE SERIES CHANGE GENERATE A MOMENTARY IMPULSE
	if kchange==1 then					;IF NUMBER OF WGUIDE1S NEEDED OR THE START POINT IN THE SERIES HAS CHANGED...
	  reinit	update					;REINITIALISE THE STACK CREATION
	endif			
	update:							;REINIT FROM HERE
	;CALL THE UDO. (ONCE FOR EACH CHANNEL.)
	aresL		wguide1stack	gasigL*aInputEnv, kfreq, gkcutoff, gkfeedback, kinterval, gktype, i(gkmin), i(gkmax)+i(gkmin)-1
	aresR		wguide1stack	gasigR*aInputEnv, kfreq, gkcutoff, gkfeedback, kinterval, gktype, i(gkmin), i(gkmax)+i(gkmin)-1
	if gkdual==1 then	;DUAL DIRECTION WGUIDE1S SELECTED (NOTE NEGATIVE 'kinterval'
			if i(gkmin)==1 then	;DON'T DOUBLE UP FUNDEMENTAL IF 'Lowest' IS '1'
			 imin	=	i(gkmin)+1
			 imax	=	 i(gkmax)+i(gkmin)-2
			else
			 imin	=	i(gkmin)
			 imax	=	 i(gkmax)+i(gkmin)-1
			endif
			if gkmin==1&&gkmax==1 kgoto skip	;IF 'Num.wguides' AND 'Lowest' ARE BOTH '1', DON'T CREATE ANY REFLECTED WGUIDE1S AT ALL 	
			aresL	wguide1stack	gasigL*aInputEnv, kfreq, gkcutoff, gkfeedback, -kinterval, gktype, imin, imax
			aresR	wguide1stack	gasigR*aInputEnv, kfreq, gkcutoff, gkfeedback, -kinterval, gktype, imin, imax
			skip:
	endif
	rireturn						;RETURN FROM REINIT
	
	aenv		expsegr	1,i(gkRel),0.0001		;CREATE AMPLITUDE ENVELOPE
			outs	aresL * gkamp*aenv, aresR * gkamp*aenv	;SEND wguide OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;INPUT SOUND (ALWAYS ON)
</CsScore>

</CsoundSynthesizer>