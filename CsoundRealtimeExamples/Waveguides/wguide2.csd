wguide2.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
;HARDWARE MIDI
;-iadc -odac -Ma -dm0

;VIRTUAL MIDI DEVICE
-iadc -odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	64	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"wguide2", 500,    465,    0,  0

iinsno	nstrnum	"ImpulseFLTK"
;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",		1,    0,    22,    150,     28,    5,  5,    0,    iinsno,   0,       -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
gkNegFB,ihNegFB			FLbutton	"Negative Feedback",	-1,    1,    22,    95,     75,   400,315,   -1
FLsetColor2	255, 255, 50, ihNegFB	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     4,     18,      60,   250, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y                                
ih		 	FLbox  	"Input:", 		1,       2,    11,     50,      20, 200,   0
ih		 	FLbox  	"Seashore     ", 	1,       5,    11,    100,      15, 265,   1                                                 
ih		 	FLbox  	"Live         ", 	1,       5,    11,    100,      15, 265,  16                                           
ih		 	FLbox  	"Impulses     ", 	1,       5,    11,    100,      15, 265,  31
ih		 	FLbox  	"Soft Impulses", 	1,       5,    11,    100,      15, 265,  46

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq1				FLvalue	" ",       80,     20,    5,  75+15                                        
idfreq2				FLvalue	" ",       80,     20,    5, 125+15
idmult				FLvalue	" ",       80,     20,    5, 175+15                               
idcutoff1			FLvalue	" ",       80,     20,    5, 225+15
idcutoff2			FLvalue	" ",       80,     20,    5, 275+15
idfeedback1			FLvalue	" ",       80,     20,    5, 325+15
idfeedback2			FLvalue	" ",       80,     20,    5, 375+15
idamp				FLvalue	" ",       80,     20,    5, 425+15

;SLIDERS					            			MIN | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X   | Y
gkfreq1,ihfreq1			FLslider 	"Frequency 1",			20,  20000, -1,    23,   idfreq1,     490,      25,   5,    50+15
gkfreq2,ihfreq2			FLslider 	"Frequency 2",			20,  20000, -1,    23,   idfreq2,     490,      25,   5,   100+15  
gkmult,ihmult			FLslider 	"Freq. 1&2 Scaling",		0.125,   4, -1,    23,   idmult,      490,      25,   5,   150+15
gkcutoff1,ihcutoff1		FLslider 	"LPF Cutoff Frequency 1",	20,  20000, -1,    23,   idcutoff1,   490,      25,   5,   200+15
gkcutoff2,ihcutoff2		FLslider 	"LPF Cutoff Frequency 2",	20,  20000, -1,    23,   idcutoff2,   490,      25,   5,   250+15
gkfeedback1,ihfeedback1		FLslider 	"Feedback 1",			0,     0.5,  0,    23,   idfeedback1, 390,      25,   5,   300+15
gkfeedback2,ihfeedback2		FLslider 	"Feedback 2",			0,     0.5,  0,    23,   idfeedback2, 390,      25,   5,   350+15
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,   idamp,       490,      25,   5,   400+15
gkingain,ihingain		FLslider 	"Live Input Gain",		0,       1,  0,    23,   -1,          140,      20, 350,     5+15

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	113, 	ihfreq1
				FLsetVal_i	20000, 	ihcutoff1
				FLsetVal_i	0.27, 	ihfeedback1
				FLsetVal_i	273, 	ihfreq2
				FLsetVal_i	20000, 	ihcutoff2
				FLsetVal_i	1, 	ihmult
				FLsetVal_i	0.23, 	ihfeedback2
				FLsetVal_i	0.7, 	ihamp
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 760, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           wguide2                           ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Wguide2 implements 2 delays and first order lowpass filters  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"with feedback in a single unit opcode. This arrangement is as", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"shown below:                                                 ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"              +-----<-----[FEEDBACK]<-------+                ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"              |                             |                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"              |  +-----+  +--------------+  |                ", 	1,      5,    14,    490,    15,     5, 140
ih		 	FLbox  	"              +->+DELAY+->+LOWPASS FILTER+->+                ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                 +-----+  +--------------+                   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                 |                                           ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"             IN->+------------------------------>OUT         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                 |                                           ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                 +-----+  +--------------+                   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"              +->+DELAY+->+LOWPASS FILTER+->+                ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"              ^  +-----+  +--------------+  |                ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"              |                             |                ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"              +-----<-----[FEEDBACK]<-------+                ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Wguide2 can imbue the resonant characteristics of a metal    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"plate upon an impulse signal.                                ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"In this implementation four options for the impulse (input)  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"signal are provided: (1) Sound file (2) Live input and (3)   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"a stream of click impulses and (4) soft impulses.            ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"As both feedback loops impact upon the feedback of the entire", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"system care should be taken in adjusting them. To prevent out", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"of control resonance, the sum of both feedback parameters    ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"should not exceed 0.5. This example protects against combined", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"feedbacks of more that 0.5 so the user need not worry about  ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"this.                                                        ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"The frequencies of the two waveguides (1/delay_time) can be  ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"controlled independently. 'Freq. 1&2 Scaling' multiplies both", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"waveguide frequencies by its value to demonstrate how the    ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"whole timbre can be transposed up or down.                   ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"This instrument can also be played from a MIDI keyboard in   ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"which case 'Frequency 1' is determined by the note played and", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"'Frequency 2' by the position of controller 1/mod. wheel.    ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"MIDI note velocity determines the amplitude and tone of the  ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"impulse sound.                                               ", 	1,      5,     14,    490,    15,     5, 740

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initc7	1,1,0.5	;SET INITIAL POSITION OF MIDI CONTROLLER

instr	1	;MIDI INSTRUMENT
	iporttime	=	0.1				;I-RATE VARIABLE DEFINITION OF PORTAMENTO TIME
	kporttime	linseg	0,0.01,iporttime,1,iporttime	;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE
	ifreq1		cpsmidi					;FREQUENCY 1 DETERMINED BY THE NOTE PLAYED
	afreq1		=	ifreq1				;CREATE A-RATE FREQ. VARIABLE BASED ON THE VALUE OF I-RATE VARIABLE FOR FREQ.
	koct2		ctrl7	1,1,octcps(20),octcps(10000)	;READ IN MIDI CONTROLLER ONE TO DETERMINE FREQUENCY 2 (INITIALLY IN OCT FORMAT)
	kfreq2		portk	cpsoct(koct2), kporttime	;APPLY PORTAMENTO TO CHANGES OF FREQUENCY 2
	afreq2		interp	kfreq2				;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE
	iamp		ampmidi	1				;READ IN NOTE VELOCITY
	krelease	release
	
	if	gkinput==0	then	;IF INPUT 'Seashore' IS SELECTED...
	 aImpulseL, aImpulseR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	 aImpulseL	butlp	aImpulseL*(1-krelease),cpsoct(5+(iamp*8))		;LOWPASS FILTER IMPULSE SIGNAL. CUTOFF FREQUENCY DEPENDENT UPON KEY VELOCITY. IF KEY IS RELEASED IMPULSE SOUND IS ABBREVIATED (USING krelease).
	 aImpulseR	butlp	aImpulseR*(1-krelease),cpsoct(5+(iamp*8))
	elseif	gkinput==1	then							;IF INPUT 'Live' IS SELECTED...
	 aImpulseL, aImpulseR	ins							;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
	 aImpulseL	butlp	aImpulseL * gkingain * (1-krelease), cpsoct(5+(iamp*8))	;LOWPASS FILTER IMPULSE SIGNAL. CUTOFF FREQUENCY DEPENDENT UPON KEY VELOCITY. IF KEY IS RELEASED IMPULSE SOUND IS ABBREVIATED (USING krelease). ALSO SCALED BY LIVE INPUT GAIN SLIDER.
	 aImpulseR	butlp	aImpulseR * gkingain * (1-krelease), cpsoct(5+(iamp*8))
	elseif	gkinput==2	then	;IF INPUT 'Live' IS SELECTED...
	 aImpulseL	mpulse	iamp,0							;A SINGLE IMPULSE IS GENERATED WITH AN AMPLITUDE DEPENDENT UPON THE NOTE VELOCITY
	 aImpulseL	butlp	aImpulseL,cpsoct((9*iamp)+4)				;LOWPASS FILTER THE IMPULSE SOUND. CUTOFF DETERMINED BY NOTE VELOCITY.
	 aImpulseR	=	aImpulseL						;RIGHT CHANNEL IMPULSE THE SAME AS THE LEFT CHANNEL IMPULSE SIGNAL
	else
	 aenv	expseg	0.0001,0.02,       1, 0.2,        0.0001,1,0.0001		;ENVELOPE FOR SOFT IMPULSE SIGNAL
	 aImpulseL	pinkish	aenv							;GENERATE PINK NOISE
	 aImpulseL	butlp	aImpulseL*(1-krelease), cpsoct(5+(iamp*8))		;LOWPASS FILTER THE IMPULSE SOUND. CUTOFF DETERMINED BY NOTE VELOCITY. IF KEY IS RELEASED IMPULSE SOUND IS ABBREVIATED (USING krelease). ALSO SCALED BY LIVE INPUT GAIN SLIDER.
	 aImpulseR	=	aImpulseL						;RIGHT CHANNEL IMPULSE THE SAME AS THE LEFT CHANNEL IMPULSE SIGNAL
	endif
	 
 	kFBtot	=	gkfeedback1 + gkfeedback2		; protect against combined feedbacks greater than 0.5
 	if kFBtot>0.5 then
 	 kfeedback1	=	gkfeedback1 / (kFBtot*2)
 	 kfeedback2	=	gkfeedback2 / (kFBtot*2)
 	else
 	 kfeedback1	=	gkfeedback1
 	 kfeedback2	=	gkfeedback2
 	endif

	;OUTPUT	OPCODE |  INPUT   | FREQ1&2         | LPF_CUTOFF_FREQ 1&2 | FEEDBACK_RATIO 1&2
	aresL	wguide2 aImpulseL,   afreq1, afreq2, gkcutoff1, gkcutoff2, kfeedback1*gkNegFB, kfeedback2*gkNegFB	;APPLY WGUIDE 2 FILTERING
	aresR	wguide2 aImpulseR,   afreq1, afreq2, gkcutoff1, gkcutoff2, kfeedback1*gkNegFB, kfeedback2*gkNegFB	;APPLY WGUIDE 2 FILTERING
	aresL	dcblock2	aresL									;BLOCK DC OFFSET	
	aresR	dcblock2	aresR									;BLOCK DC OFFSET	
	aenv	linsegr	1,2,0										;ENVELOPE WITH MIDI SENSING RELEASE STAGE. (ACTUALLY THE ENTIRE ENVELOPE IS THE RELEASE STAGE)
	aresL	=	aresL * aenv									;APPLY ENVELOPE TO WGUIDE2 SIGNAL
	aresR	=	aresR * aenv									;APPLY ENVELOPE TO WGUIDE2 SIGNAL
		outs	aresL * gkamp, aresR * gkamp							;SEND wguide2 OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin

instr	ImpulseFLTK
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	if	gkinput==0	then	;IF INPUT 'Seashore' IS SELECTED...
		gasigL, gasigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	elseif	gkinput==1	then	;IF INPUT 'Live' IS SELECTED...
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER						;END OF CONDITIONAL BRANCHING
	elseif	gkinput==2	then	;IF INPUT 'Live' IS SELECTED...		;OTHERWISE...
		kint	random	0.1,0.4	;INTERVAL BETWEEN IMPULSES IS RANDOMISED SLIGHTLY
		a1	mpulse	4,kint	;GENERATE IMPULSES
		kcfoct	randomi	6,12,2	;GENERATE RANDOM VALUES FOR FILTER CUTOFF FREQUENCY (OCT FORMAT)
		gasigL	butlp	a1, cpsoct(kcfoct)	;LOWPASS FILTER STREAM OF CLICKS
		gasigR	=	gasigL			;SET RIGHT CHANNEL SIGNAL TO THE SAME AS THE LEFT CHANNEL SIGNAL
	else	;OTHERWISE NOISE IMPULSE
		kporttime	linseg	0,0.001,0.05
		krelease	release
		krate	rspline	1,15,0.25,1
		ktrig	metro	krate
		if ktrig=1 then
		reinit update
		endif	
		update:
		;		       ATTACK_TIME    DECAY_TIME
		aenv	expseg	0.0001,0.02,       1, 0.2,        0.0001,1,0.0001
		asig	pinkish	aenv
		rireturn	
		koct	randomi	6,11,2
		asig	butlp	asig,cpsoct(koct)
		krelease	portk	krelease,kporttime	
		asig	=	asig*(1-krelease)
		gasigL	=	asig
		gasigR	=	asig
	endif
endin
		
instr	Wguide2FLTK	;WGUIDE2 INSTRUMENT (ALWAYS ON)
	iporttime	=	0.1				;I-RATE VARIABLE DEFINITION OF PORTAMENTO TIME
	kporttime	linseg	0,0.01,iporttime,1,iporttime	;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE
	kfreq1		portk	gkfreq1*gkmult, kporttime	;SMOOTH VARIABLE CHANGES WITH PORTK
	afreq1		interp	kfreq1				;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE
	kfreq2		portk	gkfreq2*gkmult, kporttime	;SMOOTH VARIABLE CHANGES WITH PORTK
	afreq2		interp	kfreq2				;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE
	
 	kFBtot	=	gkfeedback1 + gkfeedback2		; protect against combined feedbacks greater than 0.5
 	if kFBtot>0.5 then
 	 kfeedback1	=	gkfeedback1 / (kFBtot*2)
 	 kfeedback2	=	gkfeedback2 / (kFBtot*2)
 	else
 	 kfeedback1	=	gkfeedback1
 	 kfeedback2	=	gkfeedback2
 	endif
	
	
	;OUTPUT	OPCODE | INPUT | FREQ1&2       | LPF_CUTOFF_FREQ 1&2 | FEEDBACK_RATIO 1&2
	aresL	wguide2 gasigL, afreq1, afreq2, gkcutoff1, gkcutoff2, kfeedback1*gkNegFB, kfeedback2*gkNegFB
	aresR	wguide2 gasigR, afreq1, afreq2, gkcutoff1, gkcutoff2, kfeedback1*gkNegFB, kfeedback2*gkNegFB
	aresL	dcblock2	aresL	;BLOCK DC OFFSET
	aresR	dcblock2	aresR	;BLOCK DC OFFSET
		outs	aresL * gkamp, aresR * gkamp	;SEND wguide2 OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
	clear	gasigL, gasigR	;CLEAR GLOBAL AUDIO VARIABLES
endin

instr	InitMIDI	;INITIALISE MIDI. ONLY REQUIRED WHEN USING VIRTUAL MIDI DEVICE
	initc7	1,1,0.5	;SET MIDI CONTROLLER INITIAL POSITION TO MIDWAY POINT OF CONTROLLER
endin

</CsInstruments>

<CsScore>
;INSTR             | START | DURATION
i  "Wguide2FLTK"       0       3600	;INSTRUMENT 2 PLAYS FOR 1 HOUR (AND KEEPS REALTIME PERFORMANCE GOING)
i "InitMIDI" 0.01 0			;INITIALISE MIDI. ONLY REQUIRED WHEN USING VIRTUAL MIDI DEVICE

</CsScore>

</CsoundSynthesizer>