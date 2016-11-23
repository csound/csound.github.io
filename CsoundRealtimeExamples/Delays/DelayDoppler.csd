DelayDoppler.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL             | WIDTH | HEIGHT | X | Y
		FLpanel	"Doppler Effect",    500,    450, 0, 0

;SWITCHES                                              	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			iwidth iheight ix,  iy
idfreq			FLvalue	" ",	70,    20,   5,  75
idAmpDepth		FLvalue	" ",	70,    20,   5, 125
idAmpPhase		FLvalue	" ",	70,    20,   5, 175
idPanDepth		FLvalue	" ",	70,    20,   5, 225
idDopDep		FLvalue	" ",	70,    20,   5, 275
idRvbScaling		FLvalue	" ",	70,    20,   5, 325
idRvbTime		FLvalue	" ",	50,    20,   5, 375
idRvbFilt		FLvalue	" ",	50,    20, 255, 375
idOutGain		FLvalue	" ",	70,    20,   5, 425

;SLIDERS					     				MIN | MAX | EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkfreq, ihfreq			FLslider	"Frequency of Rotation (Hertz)",-5,    5,    0,    23,   idfreq,       490,     25,    5,  50
gkAmpDepth, ihAmpDepth		FLslider	"Central/Edge",			0,     1,    0,    23,   idAmpDepth,   490,     25,    5, 100
gkAmpPhase, ihAmpPhase		FLslider	"Orientation (radians)",	0,     1,    0,    23,   idAmpPhase,   490,     25,    5, 150
gkPanDepth, ihPanDepth		FLslider	"Panning Width",		0,     1,    0,    23,   idPanDepth,   490,     25,    5, 200
gkDopDep, ihDopDep		FLslider	"Doppler Depth",		0,    .1,    0,    23,   idDopDep,     490,     25,    5, 250
gkRvbScaling, ihRvbScaling	FLslider	"Reverb Scaling",		0,     1,    0,    23,   idRvbScaling, 490,     25,    5, 300
gkRvbTime, ihRvbTime		FLslider	"Reverb Time",			0.3,0.99,    0,    23,   idRvbTime,    240,     25,    5, 350
gkRvbFilt, ihRvbFilt		FLslider	"Reverb Damping",		20,20000,    0,    23,   idRvbFilt, 240,     25,  255, 350

gkOutGain, ihOutGain		FLslider	"Output Gain",			0,     1,    0,    23,   idOutGain,    490,     25,    5, 400
gkInGain, ihInGain		FLslider	"Live Input Gain",		0,     1,    0,    23,   -1,           195,     12,  300,  20

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255	; NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,  ihinput	FLbutBank	4,      1,     2,     18,      36,   200, 1,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input:", 	1,       5,    12,    48,      12,  150,   2
ih		 	FLbox  	"Noisy Tone", 	1,       5,    12,    70,      15,  220,   2
ih		 	FLbox  	"Live Input", 	1,       5,    12,    70,      15,  220,  19

;INITIALISATION
FLsetVal_i	0.2, 	ihfreq
FLsetVal_i	.7, 	ihAmpDepth
FLsetVal_i	0.5, 	ihAmpPhase
FLsetVal_i	1, 	ihPanDepth
FLsetVal_i	.003, 	ihDopDep
FLsetVal_i	0.3, 	ihRvbScaling
FLsetVal_i	0.7, 	ihRvbTime
FLsetVal_i	4000, 	ihRvbFilt
FLsetVal_i	0.7, 	ihOutGain
FLsetVal_i	0.1, 	ihInGain

FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           Circular Motion Doppler Effect (vdelayxw)         ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example uses three LFOs to create the effect of a sound ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"moving in a circle around the listener. The three parameters ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"controlled by these LFOs are amplitude, panning and delay    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"time. The modulation of the delay time also results in a     ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"modulation of pitch which is sometimes referred to as the    ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"Doppler effect.                                              ", 	1,      5,     14,    490,    20,     5, 140
ih	  	 	FLbox  	"Note that in this example the 'vdelayxw' opcode is used to   ", 	1,      5,     14,    490,    20,     5, 160
ih	  	 	FLbox  	"implement the delay and doppler shift. This opcode is unique ", 	1,      5,     14,    490,    20,     5, 180
ih	  	 	FLbox  	"in that the delay time of the write pointer rather than the  ", 	1,      5,     14,    490,    20,     5, 200
ih	  	 	FLbox  	"read pointer is modulated. This is appropriate here as it is ", 	1,      5,     14,    490,    20,     5, 220
ih	  	 	FLbox  	"the sound source that is moving, not the listener.           ", 	1,      5,     14,    490,    20,     5, 240
ih	  	 	FLbox  	"Crucial to this effect is that that all three LFOs share the ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"same frequency value. Negative frequency values are also     ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"allowed - this would represent a change in direction of the  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"source sounds motion around us.                              ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox   "Also of crucial importance is the phase relationship between ", 	1,      5,     14,    490,    20,     5, 340   
ih		 	FLbox  	"the three LFOs as this defines exactly where the sound source", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"is in relation to the listener.                              ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"The panning LFO should be at its points of minimum rate of   ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"change when the sound source is moving parallel to the       ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"direction in which the listener is facing, i.e. directly to  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"the left or to the right of the listener.                    ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"The delay time LFO (pitch modulation/doppler) should be at   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"its points of minimum rate of change when the sound source is", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"moving perpendicular to the direction in which the listener  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"is facing, i.e. directly in front of or behind the listener. ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"The phase difference between these two LFOs is either 90 or  ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"270 degrees, depending on whether the source sound is moving ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"in a clockwise or anticlockwise direction around us.         ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"Amplitude modulation comes into play whenever we are not     ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"listening from the centre of the circle of motion. The closer", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"to the edge of the circle we are the greater the amount of   ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"amplitude modulation we will experience. If the amplitude    ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"modulation is extreme then the circle of the source sound's  ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"motion must be extremely large. The phase of the amplitude   ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"modulation LFO is also adjustable ('Orientation' slider -    ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"this define which edge of the circle we are closest to, e.g. ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"upper, lower, left, right etc. It is probably best to always ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"include at least a small amount of amplitude modulation as we", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"perceive sounds directly to our left or to our right to be   ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"louder, even if they remain equidistant from us. In this case", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"the amplitude LFO phase ('Orientation') should be 0.5        ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"(radians).                                                   ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"The waveform for all three LFOs is a sine wave. This defines ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"The object's motion as being circular. If we were to use a   ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"different waveform this would model non-circular motion.     ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"There is interesting potential in experimentation in this    ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"direction with this example.                                 ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"Finally as the moving signal becomes more distant, i.e. when ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"the amplitude scaling function is at its minimum, a          ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"reverberated version of the signal can become more evident.  ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"The degree to which this is present can be scaled using the  ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"'Reverb Scaling' slider.                                     ", 	1,      5,     14,    490,    20,     5,1080

				FLscrollEnd
				FLpanel_end

FLrun		;RUN THE WIDGET THREAD

gisine	ftgen	0, 0, 4096, 10, 1	;A SINE WAVE FUNCTION TABLE IS DEFINED

opcode	DopplerSpin,aaaa,akkkkki
	asig,kfreq,kAmpDepth,kAmpPhase,kPanDepth,kDopDep,ishape	xin
	
	isine		ftgen	0,0,1024,10,1
	aAmp 		osciliktp kfreq, ishape, kAmpPhase		; AN LFO DEFINES A VARIABLE USED TO MODULATE AMPLITUDE (NOTE: VARIABLE PHASE). THIS MODELS THE LOCATION WITHIN THE CIRCLE FROM WHICH WE ARE LISTENING. NO AMPLITUDE MODULATION REPRESENT REPRESENTS OUR LISTENING POSITION BEING EXACTLY CENTRAL, MAXIMUM MODULATION REPRESENTS US BEING NEAR TO THE EDGE OF A LARGE CIRCLE. THE CONTROL OVER PHASE OF THIS LFO REPRESENTS WHICH EDGE WE ARE CLOSER TO.
	aAmp		=	(aAmp * 0.5 * kAmpDepth) + 0.5		; RESCALE AND OFFSET AMPLITUDE MODULATION LFO
	
	aPan		oscili	(kPanDepth * 0.5), kfreq, ishape, 0.75	; AN LFO DEFINES A VARIABLE FOR PANNING CONTROL - I.E. WHETHER SOUND IS CURRENTLY TO OUT LEFT OR TO OUT RIGHT. NOTE THAT PHASE IS 0.75 AND THEREFORE 0.75 RADIANS (OR 270 DEGREES OUT OF PHASE) WITH THE DELAY MODULATION 
	aPan		=	aPan + 0.5				; OFFSET PANNING LFO

	iMaxDelay	=	1					; DEFINE A VARIABLE THAT WILL BE USE FOR 'MAXIMUM DELAY TIME' (BUFFER LENGTH)
	aDelTim		oscili	kDopDep, kfreq, ishape, 0		; AN LFO DEFINES A VARIABLE FOR DELAY TIME (NOTE PHASE AT ZERO)
	aDelTim		=	aDelTim + kDopDep			; DELAY TIME  VARIABLE 'aDelay' IS OFFSET TO STAY WITHIN THE POSITIVE DOMAIN	
		
	;vdelayxw IS USED FOR THE DELAY READ/WRITE AS IT MODULATES THE WRITE POINTER RATHER THAN THE READ POINTER.
	;THIS IS MORE APPROPRIATE IN THIS EXAMPLE AS THE SOURCE IS MOVING BUT THE POINT OF LISTENING IS STATIONARY
	aDelTap	vdelayxw	asig, aDelTim, iMaxDelay, 16
	
	aL, aR	pan2 	aDelTap, aPan, 1	;APPLY PANNING TO SIGNAL OUTPUT FROM DELAY USING pan2 OPCODE. CREATE A NEW 

	aDryL	=	aL * (aAmp^0.5)	;APPLY AMPLITUDE MODULATION (CREATE A NEW AUDIO SIGNAL - DRY (UN-REVERBERATED) SIGNAL)
	aDryR	=	aR * (aAmp^0.5)	;APPLY AMPLITUDE MODULATION (CREATE A NEW AUDIO SIGNAL - DRY (UN-REVERBERATED) SIGNAL)
		xout	aL,aR,aDryL,aDryR
	
endop



instr     1
	if gkOnOff=0	then		;...IF 'On/Off' BUTTON IS 'OFF'...
		turnoff			;...TURNOFF THIS INSTRUMENT IMMEDIATLEY
	endif				;END OF CONDIIONAL BRANCHING

	kporttime	linseg	0,0.001,0.1			;CREATE 'PORTAMENTO TIME'. A FUNCTION THAT RISES QUICKLY FROM ZERO TO A HELD VALUE.
	kAmpPhase	portk	gkAmpPhase, kporttime		;APPLY PORTAMENTO TO gkAmpPhase. CREATE NEW OUTPUT VARIABLE kAmpPhase (GLOBAL VARIABLES CAN'T BE BOTH INPUT AND OUTPUT)
	kDopDep		portk	gkDopDep, kporttime		;APPLY PORTAMENTO TO gkDopDep. CREATE NEW OUTPUT VARIABLE kDopDep (GLOBAL VARIABLES CAN'T BE BOTH INPUT AND OUTPUT)

	if gkinput=0 then				;IF FIRST INPUT OPTION IS CHOSEN...
		asig		pinkish	10		;DEFINE SOUND SOURCE (PINK NOISE) FOR THIS EXAMPLE
		asig		butbp	asig, 500, 10	;BANDPASS FILTER PINK NOISE TO GIVE asig A 'WHISTLING' CHARACTERISTIC. THIS FILTERING CAUSES A LOSS OF SIGNAL POWER WHICH MUST LATER BE COMPENSATED FOR
	else						;OTHERWISE...
		asig	inch	1			;READ AUDIO FROM INPPUT CHANNEL 1
		asig	=	asig * gkInGain		;SCALE INPUT USING INPUT GAIN SLIDER
	endif						;END OF THIS CONDITIONAL BRANCH

	; CALL UDO CREATED ABOVE
	aL,aR,aDryL,aDryR	DopplerSpin	asig,gkfreq,gkAmpDepth,kAmpPhase,gkPanDepth,kDopDep,gisine
		
	aRvbL, aRvbR	reverbsc	aL, aR, gkRvbTime, gkRvbFilt	;REVERB (UNAFFECTED BY AMPLITUDE MODULATION)
	
	outs	aDryL+(aRvbL*gkRvbScaling), aDryR+(aRvbL*gkRvbScaling)	;SEND AUDIO TO OUTPUTS. MIX DRY AND REVERBERATED SIGNALS.
endin
          
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>