CsoundIsListening.csd
WRITTEN BY IAIN MCCURDY, 2011

This example exemplifies the technique of opcode iteration using UDOs to create a mass of oscillators using a small amount of code.
This technique is introduced and explained in detail by Steven Yi in his article 'Control Flow - Part II' in the summer 2006 issue of the Csound Journal (http://www.csounds.com/journal/2006summer/controlFlow_part2.html).

In this example 100 vco2 oscillators are created but you can change this number in instrument 1 if you like, increasing it if your system permits it in realtime.
Each oscillator exhibits its own unique behaviour in terms of its pitch, pulse width and panning.
The entire mass morphs from a state in which the oscillator pitches slowly glide about randomly to a state in which they hold a fixed pitch across a range of octaves.

Some commercial synthesizers offer oscillators called 'mega-saws' or something similar. These are normally just clusters of detuned sawtooth waveforms so this is the way in which this could be emulated in Csound.

The example emulates a familiar sound ident.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
;-oCsoundIsListening.wav -d
</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1	;MAXIMUM AMPLITUDE


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                 | WIDTH | HEIGHT | X | Y
	FLpanel	"Csound is Listening",   500,    175,    0,  0
;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,gihOnOff	FLbutton	"Start/Stop",		1,   0,    22,    490,     80,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, gihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetTextSize 40, gihOnOff
;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X   | Y | OPCODE
gkNVoices, ihNVoices 		FLcount  "Number of Voices (i-time)", 	2,    200,    1,     10,     1,    150,     25,     5,   90,   -1
gkRange, ihRange 		FLcount  "Range (i-time)", 		1,     12,    1,      1,     2,    100,     25,   290,   90,   -1
; KNOBS				FLknob 			   		MIN  | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkRvb, ihRvb 			FLknob 		"Reverb",  		0,      1,    0,    1,     -1,    50,   170, 90
gkEndOct, ihEndOct		FLknob 		"Final Pitch",  	0,     10,    0,    1,     -1,    50,   230, 90

FLsetVal_i	100,ihNVoices
FLsetVal_i	0.5,ihRvb
FLsetVal_i	3,ihEndOct
FLsetVal_i	8,ihRange
			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 60, 523, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                     Csound is Listening                     ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Imitation of a familiar sound ident.                         ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 200

			FLpanel_end

			FLrun	;RUN THE FLTK WIDGET THREAD


;INITIALISE REVERB SEND VARIABLES
gasendL	init	0
gasendR	init	0
giCos		ftgen	1, 0, 131072, 11, 1								;COSINE

;DEFINE A UDO FOR AN OSCILLATOR VOICE
opcode	vcomodule, aa, ii										;DEFINE OPCODE FORMAT
	icount,inum  xin										;DEFINE NAMES FOR INPUT ARGUMENTS
	kvar	jspline	15,0.1,0.2									;RANDOM JITTERING OF PITCH
	imorphtime	random	5.5,6.5									;TIME TO MORPH FROM GLIDING PITCHES TO STATIC PITCHES WILL DIFFER SLIGHTLY FROM VOICE TO VOICE
	kxfade	linseg	0,7, 0,imorphtime, 0.999,2, 0.999						;FUNCTION DEFINING MORPH FROM GLIDING TO STATIC VOICES IS CREATED				
	ioct	wrap	icount,0,i(gkRange)									;BASIC OCTAVE FOR EACH VOICE IS DERIVED FROM VOICE COUNT NUMBER (WRAPPED BETWEEN 0 AND 8 TO PREVENT RIDICULOUSLY HIGH TONES)
	iinitoct	random	0,2									;DEFINES THE SPREAD OF VOICES DURING THE GLIDING VOICES SECTION
	kcps	ntrpol	200*semitone(kvar)*octave(iinitoct),cpsoct(gkEndOct+ioct+octpch(0.025)),kxfade		;PITCH (IN CPS) OF EACH VOICE - MORPHING BETWEEN A RANDOMLY GLIDING STAGE AND A STATIC STAGE
	koct	=	octcps(kcps)									;PITCH CONVERTED TO OCT FORMAT
	kdb	=	(5-koct)*4									;DECIBEL VALUE DERIVED FROM OCT VALUE - THIS WILL BE USED FOR 'AMPLITUDE SCALING' TO PREVENT EMPHASIS OF HIGHER PITCHED TONES

	/* SIMPLE VCO */
	kpw	rspline	0.05,0.5,0.4,0.8								;RANDOM MOVEMENT OF PULSE WIDTH FOR vco2
	a1	vco2	ampdb(kdb)*(1/(inum^0.5))*1.2,kcps,4,kpw,0						;THE OSCILLATOR IS CREATED

	/* PHASE DISTORTED COSINE */
;	ibipolar	=	0		;UNIPOLAR/BIPOLAR SWITCH (0=UNIPOLAR 1=BIPOLAR)
;	ifullscale	=	1		;FULLSCALE VALUE
;	aPhs        	phasor	kcps		;DEFINE A PHASOR
;	kShapeAmount	=	-0.7		;VALUES CLOSER TO -1 (OR 1) WILL PRODUCE MORE OF A SAWTOOTH, VALUES CLOSER TO ZERO PRODUCE MORE OF A SINE WAVE
;    	aPD         	pdhalf	aPhs, kShapeAmount, ibipolar, ifullscale	;PHASE DISTORT THE PHASOR (aosc) CREATED 4 LINES ABOVE
;	a1		tablei	aPD, giCos, 1
;	a1		*=	ampdb(kdb)*(1/(inum^0.5)) * 0.7

	kPanDep	linseg	0,5,0,6,0.5								; RANDOM PANNING DEPTH WILL MOVE FROM ZERO (MONOPHONIC) TO FULL STEREO AT THE END OF THE NOTE
	kpan	rspline 0.5+kPanDep,0.5-kPanDep,0.3,0.5						; RANDOM PANNING FUNCTION

	;aL,aR	pan2	a1,kpan		; kpan2 seems a bit CPU expensive...			; MONO OSCILLATOR IS RANDOMLY PANNED IN A SMOOTH GLIDING MANNER
	aL	=	a1*kpan
	aR	=	a1*(1-kpan)

	amixL, amixR	init	0                                                                 

	if	icount <= inum	then								; IF TOTAL VOICE LIMIT HAS NOT YET BEEN REACHED...
		amixL,amixR	vcomodule	icount+1, inum					; ...CALL THE UDO AGAIN (WITH THE INCREMENTED COUNTER)
	endif											; END OF THIS CONDITIONAL BRANCH
		xout	amixL+aL,amixR+aR
endop

instr	1
	ckgoto gkOnOff==1, SKIP
	 turnoff
	SKIP:
	p3 	= 	20
;	prints	"See .csd for explanation..."
	inum		=	50								; NUMBER OF VOICES
	icount	init		0								; INITIALISE VOICE COUNTER
	aoutL,aoutR	vcomodule	icount, i(gkNVoices)	;inum						; CALL vcomodule UDO (SUBSEQUENT CALLS WILL BE MADE WITHIN THE UDO ITSELF)
	aoutL		tone	aoutL, 12000							; SOFTEN HIGH FREQUENCY
	aoutR		tone	aoutR, 12000                                                       
	aoutL		dcblock	aoutL								; REMOVE DC OFFSET FROM AUDIO (LEFT CHANNEL)
	aoutR		dcblock	aoutR								; REMOVE DC OFFSET FROM AUDIO (RIGHT CHANNEL)
	kenv		linsegr	-90,(1), -50,(6), -20,(6), 0,(p3-16),  0,(3), -90, (0.2), -90	; AMPLITUDE ENVELOPE THAT WILL BE APPLIED TO THE MIX OF ALL VOICES
	aoutL	=	aoutL*ampdb(kenv)							; APPLY ENVELOPE (LEFT CHANNEL)
	aoutR	=	aoutR*ampdb(kenv)							; APPLY ENVELOPE (RIGHT CHANNEL)
	outs		aoutL,aoutR								; SEND AUDIO TO OUTPUTS
	gasendL	=	gasendL+(aoutL*gkRvb)							; MIX SOME AUDIO INTO THE REVERB SEND VARIABLE (LEFT CHANNEL)
	gasendR	=	gasendR+(aoutR*gkRvb)							; MIX SOME AUDIO INTO THE REVERB SEND VARIABLE (RIGHT CHANNEL)
;	if release()==1 then
;	 FLsetVal	1,0,gihOnOff
;	endif
endin

instr	2	;REVERB INSTRUMENT
	aRvbL,aRvbR	reverbsc	gasendL,gasendR,0.82,10000
	outs	aRvbL,aRvbR
	clear	gasendL,gasendR
endin
</CsInstruments>

<CsScore>
;i 1 0 20	;SYNTH VOICES GENERATING INSTRUMENT
i 2 0 2500	;REVERB INSTRUMENT
e
</CsScore>

</CsoundSynthesizer>