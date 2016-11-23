DoubleDelayCrossedFeedback.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                           | WIDTH | HEIGHT | X | Y
		FLpanel	"Double Delay Crossed Feedback",   500,    550,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gktrig,ihtrig		FLbutton	"Trigger Impulse",	1,    0,    21,    120,     20,    5,  5,    0,      1,      0,      0.01
gkloop,ihloop		FLbutton	"Drum Loop",		1,    0,    22,    120,     20,  130,  5,    0,      2,      0,      -1
gkprot,ihprot		FLbutton	"Feedback Protection",	1,    0,    22,    160,     25,  120,500,   -1
FLsetColor2	255,255,0,ihprot
FLsetColor2	255,255,0,ihloop
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkalg, ihalg		FLbutBank	1,     1,     2,     18,      30,    70, 500,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X  |  Y
ih		 	FLbox  	"Algorithm:", 	1,       1,    14,     70,      16,    0, 500
ih		 	FLbox  	"1", 		1,       1,    14,     10,      16,   90, 500
ih		 	FLbox  	"2", 		1,       1,    14,     10,      16,   90, 515

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt1				FLvalue	" ",      80,    20,     5,  75
iddlt2				FLvalue	" ",      80,    20,     5, 125
idfb1				FLvalue	" ",      80,    20,     5, 175
idfb2				FLvalue	" ",      80,    20,     5, 225
idlpf				FLvalue	" ",      80,    20,     5, 275
idhpf				FLvalue	" ",      80,    20,     5, 325
idmix				FLvalue	" ",      80,    20,     5, 375
idamp				FLvalue	" ",      80,    20,     5, 425
idporttime			FLvalue	" ",      80,    20,     5, 475

;SLIDERS					            			MIN |  MAX | EXP | TYPE |      DISP    | WIDTH | HEIGHT | X | Y
gkdlt1,ihdlt1			FLslider 	"Delay Time 1 (sec)",		0.001,  5,   -1,    23,         iddlt1,   490,     25,    5,  50
gkdlt2,ihdlt2			FLslider 	"Delay Time 2 (sec)",		0.001,  5,   -1,    23,         iddlt2,   490,     25,    5, 100
gkfb1,ihfb1			FLslider 	"Feedback Ratio 1",		-1,     1,    0,    23,          idfb1,   490,     25,    5, 150
gkfb2,ihfb2			FLslider 	"Feedback Ratio 2",		-1,     1,    0,    23,          idfb2,   490,     25,    5, 200
gklpf,ihlpf			FLslider 	"Lowpass Filter",		4,     14,    0,    23,          idlpf,   490,     25,    5, 250
gkhpf,ihhpf			FLslider 	"Highpass Filter",		4,     14,    0,    23,          idhpf,   490,     25,    5, 300
gkmix,ihmix			FLslider 	"Dry / Wet Mix",		0,      1,    0,    23,          idmix,   490,     25,    5, 350
gkamp,ihamp			FLslider 	"Output Amplitude Rescaling",	0,      1,    0,    23,          idamp,   490,     25,    5, 400
gkporttime,ihporttime		FLslider 	"Portamento Time",		0,      2,    0,    23,     idporttime,   490,     25,    5, 450
gkllev,ihllev			FLslider 	"Level",			0,      1,    0,     3,             -1,   120,     10,  130,  25


gkingain,ihingain		FLslider 	"Live Input Gain",		0,      1,    0,    23,             -1,   140,     20,  350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0.33, 	ihdlt1
		FLsetVal_i	0.5, 	ihdlt2
		FLsetVal_i	0.4, 	ihfb1
		FLsetVal_i	0.4, 	ihfb2
		FLsetVal_i	14, 	ihlpf
		FLsetVal_i	4, 	ihhpf
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	.7, 	ihamp
		FLsetVal_i	0.3, 	ihporttime
		FLsetVal_i	1, 	ihllev

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 660, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"              Double Delay with Crossed Feedback             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"ALGORITHM 1:                                                 ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"      +-+--Del.1--+-+                                        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"      |  \___ ___/  |                                        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	" ->IN-+   __ X___   +-OUT->                                  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"      |  /       \  |                                        ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"      +-+--Del.2--+-+                                        ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"ALGORITHM 2:                                                 ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"      +-+--Del.1--+-+                                        ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"      |  \       /  |                                        ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	" ->IN-+   +-----+   +-OUT->                                  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"      |  /       \  |                                        ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"      +-+--Del.2--+-+                                        ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"This example implements a double delay effect with a double  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"feedback loop created in two different ways. In the first    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"method the output of the first delay is fed into the input of", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"the second and the output of the second is fed back into the ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"input of the first. In the second method both outputs are    ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"mixed and fed back into both inputs.                         ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"Both alogorithms incorporate a lowpass and a highpass filter ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"within the feedback loop.                                    ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"The second algorithm has a danger of overloading if the sum  ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"of both feedbacks exceeds '1'. For this reason feedback level", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"protection can be activated which limits the sum of both     ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"feedbacks to be no greater than '1'. In any event the output ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"is clipped to prevent out of range values and instead distort", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"the signal.                                                  ", 	1,      5,     14,    490,    15,     5, 640

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gicos	ftgen	0, 0, 65536, 11, 1
gasend	init	0

instr	1	;GENERATES FILTERED NOISE IMPULSES
	p3	random	0.05,0.2				;P3 IS A RANDOM DURATION
	ioct	random	5,13					;FILTER CUTOFF (OCT FORMAT) IS A RANDOM NUMBER
	aamp	expsega	0.001,0.001,1,p3-0.001,0.001		;PERCUSSIVE AMPLITUDE ENVELOPE
	anse	pinkish	1					;PINK NOISE
	gasend	reson	anse,cpsoct(ioct),cpsoct(ioct),1	;RESON FILTER NOISE
	gasend	=	gasend*aamp				;APPLY AMPLITUDE ENVELOPE
endin

instr	2	;MIX IN DRUM LOOP FROM FILE
	if gkloop==0 then					;IF LOOP IS OFF...
	 turnoff						;TURN THIS INSTRUMENT OFF
	endif					
	a1	diskin2	"loop.wav",1,0,1			;READ AUDIO FROM DISK
	gasend	=	gasend+a1*gkllev			;ADD AUDIO TO GLOBAL SEND VARIABLE
endin

instr 	3	;DELAY INSTRUMENT
	alive	inch	1
	gasend	=	gasend + (alive*gkingain) 
	
	kporttime	linseg		0, .001, 1, 1, 1 	;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERO TO 1. THIS PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED.
	kporttime	=	kporttime * gkporttime		;SCALE PORTAMENTO FUNCTION WITH FLTK SLIDER VALUE
	kdlt1		portk		gkdlt1, kporttime 	;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
	adlt1		interp		kdlt1			;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	kdlt2		portk		gkdlt2, kporttime 	;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
	adlt2		interp		kdlt2			;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	
	atap1,atap2	init		0

	if gkalg==0 then
	 abuffer1	delayr		5			;CREATE A DELAY BUFFER OF 1 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	 atap1 		deltap3		adlt1			;TAP THE DELAY LINE AT gkdlt SECONDS
	 atap1		tone		atap1,cpsoct(gklpf)	;LOWPASS FILTER THE SIGNAL
	 atap1		atone		atap1,cpsoct(gkhpf)	;HIGHPASS FILTER THE SIGNAL
			delayw		gasend + (atap2*gkfb1)	;WRITE INTO THE DELAY BUFFER
			
	 abuffer2	delayr		5			;CREATE A DELAY BUFFER OF 1 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	 atap2 		deltap3		adlt2			;TAP THE DELAY LINE AT gkdlt SECONDS
	 atap2		tone		atap2,cpsoct(gklpf)	;LOWPASS FILTER THE SIGNAL
	 atap2		atone		atap2,cpsoct(gkhpf)     ;HIGHPASS FILTER THE SIGNAL
			delayw		gasend + (atap1*gkfb2)	;WRITE INTO THE DELAY BUFFER
	elseif gkalg==1 then					;IF ALGORITHM 2 HAS BEEN CHOSEN...
	 if gkprot=1 then					;IF 'FEEDBACK PROTECTION' IS ACTIVE...
	  if (gkfb1+gkfb2)>0.5 then				;IF SUM OF THE TWO FEEDBACKS IS GREATER THAN '1'
	   gkfb1	=		gkfb1/(gkfb1+gkfb2)	;LIMIT gkfb1 ACCORDING TO THE SUM OF BOTH
	   gkfb2	=		gkfb2/(gkfb1+gkfb2)	;LIMIT gkfb2 ACCORDING TO THE SUM OF BOTH
	  endif
	 endif
	 abuffer1	delayr		5			;CREATE A DELAY BUFFER OF 1 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	 atap1 		deltap3		adlt1			;TAP THE DELAY LINE AT gkdlt SECONDS
	 atap2 		deltap3		adlt2			;TAP THE DELAY LINE AT gkdlt SECONDS
	 atap1		tone		atap1,cpsoct(gklpf)	;LOWPASS FILTER THE SIGNAL
	 atap2		tone		atap2,cpsoct(gklpf)	;LOWPASS FILTER THE SIGNAL
	 atap1		atone		atap1,cpsoct(gkhpf)	;HIGHPASS FILTER THE SIGNAL
	 atap2		atone		atap2,cpsoct(gkhpf)	;HIGHPASS FILTER THE SIGNAL
			delayw		gasend + (atap1*gkfb1) + (atap2*gkfb2);WRITE INTO THE DELAY BUFFER - MIX IN AUDIO FROM BOTH TAPS
	endif
	 atapmix	sum		atap1,atap2		;MIX THE AUDIO OUTPUTS OF THE TWO TAPS
	atapmix		clip		atapmix,1,0dbfs		;CLIP THE SIGNAL AT MAXIMUM AMPLITUDE
	amix		ntrpol		gasend,atapmix,gkmix	;CREATE A DRY / WET MIX
	
			out		amix*gkamp		;SEND AUDIO TO OUTPUTS
			clear		gasend			;CLEAR GLOBAL AUDIO SEND VARIABLE
endin

</CsInstruments>

<CsScore>
i 3 0 3600	;DOUBLE DELAY INSTRUMENT
e
</CsScore>

</CsoundSynthesizer>