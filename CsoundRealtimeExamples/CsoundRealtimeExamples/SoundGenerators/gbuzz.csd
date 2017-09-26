gbuzz.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
;VIRTUAL MIDI
-odac -dm0 -M0 -+rtmidi=virtual
;--displays forces display of function tables. To disable replace with -d.

;EXTERNAL MIDI
;-odac -dm0 -M8
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	2	
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL     | WIDTH | HEIGHT | X | Y
		FLpanel	"gbuzz",     500,    710,    0,  0

;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFLTK_MIDI, ihFLTK_MIDI	FLbutBank	4,      1,     2,     20,      40,    5,  5,    -1	;0,     1,    0,  3600
gkwave, ihwave			FLbutBank	4,      1,     2,     20,      40,   75,  5,    -1

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI", 	1,      6,     17,     50,     20,   23,   4
ih		 	FLbox  	"FLTK", 	1,      6,     17,     50,     20,   23,  24
ih		 	FLbox  	"cosine", 	1,      6,     14,     50,     20,   93,   4
ih		 	FLbox  	"user  ", 	1,      6,     14,     50,     20,   93,  24

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",       80,    20,    5,  75
idmul			FLvalue	" ",       80,    20,    5, 125
idfreq			FLvalue	" ",       80,    20,    5, 175
idharm2			FLvalue	"N.Harms.",       80,    20,    5, 400
idlh2			FLvalue	"Lowest Harm.",       80,    20,   95, 400

;SLIDERS				     				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider	"Amplitude",  			0.0001,1,   -1,    23,   idamp,  490,    25,     5,  50
gkmul, gihmul		FLslider	"Amplitude Multiplier CC#1",	-1,      2,   0,   23,   idmul,  490,    25,     5, 100
gkfreq, ihfreq		FLslider	"Osc. Frequency",    		1,    2000,  -1,   23,  idfreq,  490,    25,     5, 150

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkharm, gihharm 	FLcount  "No. of Harmonics",	1,   1000,    1,      1,      2,   120,      25,   380, 5,    -1
gklh, gihlh 		FLcount  "Lowest Harmonic",	1,   1000,    1,      1,      2,   120,      25,   210, 5,    -1

;SWITCHES							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkdisplay,ihdisplay	FLbutton	"Update Counters",	1,    0,    22,   150,     25,    330,400,    -1
FLsetColor2	255, 255, 50, ihdisplay	;SET SECONDARY COLOUR TO YELLOW

;XY PANELS									MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X  | Y
gkharm2, gklh2, ihharm2, ihlh2	FLjoy	"X - Num.Harms. Y - Lowest Harm.",	1,     1000,  1,     1000,   -1,    -1,   idharm2,  idlh2,    490,    180,     5, 200

;TEXT BOXES								TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 					7,      1,     14,    300,    118,     5,  460
FLsetColor	150,255,200,ih
ih		 	FLbox  	"User waveform partial strengths", 	7,      1,     14,     90,    118,     5,  460
FLsetColor	150,255,200,ih
ih		 	FLbox  	"", 					7,      1,     14,    185,    118,   310,  460
FLsetColor	255,255,200,ih
ih		 	FLbox  	"Amp. Multipler Envelope",		1,      1,     14,    175,     20,   315,  462
FLsetColor	255,255,200,ih
ih		 	FLbox  	"", 					7,      1,     14,    495,    120,     5,  585		;box
FLsetColor	255,230,255,ih
ih		 	FLbox  	"Amplitude Envelope",			1,      1,     14,    200,     20,   150,  590		;label
FLsetColor	255,230,255,ih

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkEnvOnOff,ihEnvOnOff	FLbutton	"On/Off",	1,    0,    22,   100,     20,    355,490,    -1
FLsetColor2	255, 255, 50, ihEnvOnOff	;SET SECONDARY COLOUR TO YELLOW

;SLIDERS				     				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkEnvDur, ihEnvDur		FLslider	"Duration",  		0.01,    5,   0,   23,   -1,     170,    15,    315, 515
gkEnvCurve, ihEnvCurve		FLslider	"Curve",  		-8,      8,   0,   23,   -1,     170,    15,    315, 545
;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	1, 	ihEnvDur
		FLsetVal_i	-2, 	ihEnvCurve

;SLIDERS				     			MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkAtt, ihAtt		FLslider	"Attack",  		0.01,   15,  -1,   23,   -1,     230,    20,     10, 615
gkDec, ihDec		FLslider	"Decay",  		0.01,   15,  -1,   23,   -1,     230,    20,    260, 615
gkSus, ihSus		FLslider	"Sustain",  		0,       1,   0,   23,   -1,     230,    20,     10, 665
gkRel, ihRel		FLslider	"Release",  		0.01,   15,  -1,   23,   -1,     230,    20,    260, 665
;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	0.1, 	ihAtt
		FLsetVal_i	1, 	ihDec
		FLsetVal_i	1, 	ihSus
		FLsetVal_i	0.1, 	ihRel

#define SLIDER(N)
#
gk$N, ih$N		FLslider	"$N",    			0,       1,   0,   24,      -1,   15,    90,    ix, 469
ix = ix +20
FLsetVal_i	1,ih$N
#
ix=100
$SLIDER(1)
$SLIDER(2)
$SLIDER(3)
$SLIDER(4)
$SLIDER(5)
$SLIDER(6)
$SLIDER(7)
$SLIDER(8)
$SLIDER(9)
$SLIDER(10)
FLsetVal_i	0,ih1

;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	0.2, 	ihamp
		FLsetVal_i	30, 	gihharm
		FLsetVal_i	1, 	gihlh
		FLsetVal_i	30, 	ihharm2
		FLsetVal_i	1, 	ihlh2
		FLsetVal_i	0.4, 	gihmul
		FLsetVal_i	100, 	ihfreq

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 740, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Miscellaneous Waveforms : gbuzz              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Gbuzz creates similar sounds to the buzz opcode by stacking  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"harmonically relates cosine waves but gbuzz offers some      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"additional possibilities.                                    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"In addition to allowing us to choose the number partials     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"above the fundemental that will be present gbuzz allows us to", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"choose what the lowest partial present will be.              ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"The 'Amplitude Multiplier' control allows us to scale the    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"amplitudes of the sequence of partials. With a value of 1 all", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"amplitudes are equal, with values less than one the          ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"amplitudes of higher partials are increasingly attenuated,   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"and with values greater than 1 the lower partials are        ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"increasingly attenuated.                                     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Gbuzz requires us to supply it with a cosine wave function   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"table. This is created using GEN09 or GEN11.                 ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Gbuzz provides a useful source for subtractive synthesis.    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"This example can also be played from an external MIDI        ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"keyboard. Pitch, note velocity and pitch bend and represented", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"appropriately. MIDI controller 1 (the modulation wheel) can  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"be used to modulate 'Amplitude Multiplier'.                  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Normally the waveform supplied to gbuzz should be a cosine   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"but this example allows the user to experiment with using a  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"GEN10 generated composite of harmonically related sine waves.", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"When using this waveform unusual tones are possible but care ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"should be taken as unpleasant sounds may result if 'Amplitude", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"Multiplier' is high.                                         ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"The amplitude multipler parameter can be further modulated by", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"a simple single segment decay envelope, the duration and     ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"curve of which can be changed. This feature is best explored ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"when using MIDI triggering.                                  ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"Although 'Lowest Harmonic' and 'No. of Harmonics' can be     ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"changed at k-rate, doing so will cause discontinuities in the", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"audio signal; for this reason a mechanism has been           ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"implemented that turns the instrument on and off before      ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"changes to these parameters are registered. This should      ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"prevent clicks.                                              ", 	1,      5,     14,    490,    15,     5, 720
                                                           
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gicos	ftgen 1, 0, 65536, 9, 1, 1, 90		;FUNCTION TABLE THAT STORES A SINGLE CYCLE OF A COSINE WAVE
;gicos	ftgen 1, 0, 65536, 11, 2, 1, 1		;ALTERNATIVE WAVE TO CREATE A SINGLE CYCLE COSINE WAVE
giuser	ftgen 2, 0, 65536, 10, 1		;DEFINES ONLY THE INITIAL STATE OF THE USER DEFINED WAVE

instr	StartInstr
	ktrig	trigger	gkFLTK_MIDI,0.5,0
	schedkwhen	ktrig,0,0,1,0,-1
endin

instr	1		;GBUZZ INSTRUMENT
	kporttime	linseg	0,0.01,0.05			;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE
	iMIDIActiveValue	=	1			;IF MIDI ACTIVATED
	iMIDIflag		=	0			;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag		;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi						;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	kMIDIflag	init	iMIDIflag
	if	gkFLTK_MIDI=0&&kMIDIflag=0	then 		;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE. IF A MIDI NOTE, FLTK BUTTON STATUS WILL BE IGNORED
		turnoff						;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif							;END OF THIS CONDITIONAL BRANCH
	if kMIDIflag=1 then					;IF THIS IS A MIDI ACTIVATED NOTE...
		kfreq	=	icps				;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		iamp	veloc	0,1				;READ IN MIDI NOTE VELOCITY
		kamp	portk	gkamp*iamp,kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	else							;OTHERWISE...
		kfreq		portk	gkfreq,kporttime	;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp		portk	gkamp,kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	endif							;END OF THIS CONDITIONAL BRANCH

	;MIDI INPUT============================================================================================================================================================
        ;OUTPUT                 OPCODE          CHANNEL | CC.NUMBER | MIN | MAX
        kmul                    ctrl7           1,            1,      0,    1	;READ IN MIDI CONTROLLER
        ktrig                   changed         kmul    ;IF THE VARIABLE 'kptr' CHANGES FROM ITS PREVIOUS VALUE,
	kmul			scale		kmul, 2, 0	;RESCALE VARIABLE
                                                        ;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
        ;                       OPCODE      |   TRIGGER | VALUE | HANDLE
                                FLsetVal        ktrig,     kmul,  gihmul	;UPDATE WIDGET WHEN A TRIGGER IS RECEIVED
        ;======================================================================================================================================================================

	;PITCH BEND===========================================================================================================================================================
	iSemitoneBendRange = 2			;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	kbend	pchbend	0, iSemitoneBendRange*2	;PITCH BEND VARIABLE
	kfreq	=	kfreq*semitone(kbend)	;COMBINE PITCH BEND AND FREQUENCY
	;=====================================================================================================================================================================

	kmul		portk	gkmul, kporttime		;APPLY PORTAMENTO SMOOTHING

	if gkEnvOnOff==1 then
	 kMulEnv	transeg	1,i(gkEnvDur),i(gkEnvCurve),0
	 kmul		=	kmul	* kMulEnv
	endif
	
	ktrig	changed	gkwave	;IF WAVEFORM TYPE IS CHANGED GENERATE A TRIGGER
	if ktrig==1 then	;IF A TRIGGER IS RECEIVED...
	 reinit	RestartGbuzz	;REINITIALISE THE GUZZ OPCODE WITH THE NEW WAVEWFORM
	endif
	RestartGbuzz:

	if changed(gkharm+gklh)==1&&timeinstk:k()>1&&release:k()=0 then		; if 'Lowest Harmonic' or 'No. of Harmonics' change, turn instrument off and on
	 turnoff
	 event	"i",1,0,3600
	endif
	
	
	;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | NO.OF_HARMONICS | LOWEST_HARMONIC | POWER | FUNCTION_TABLE
	asig	gbuzz 	gkamp,        kfreq,        i(gkharm),            i(gklh),       kmul,    gicos+i(gkwave)
	rireturn

	;aenv	cossegr	0,i(gkAtt),1,i(gkDec),i(gkSus),i(gkRel),0		;AMPLITUDE ENVELOPE
	aenv	linsegr	0,i(gkAtt),1,i(gkDec),i(gkSus),i(gkRel),0		;AMPLITUDE ENVELOPE

	outs	asig*aenv, asig*aenv					;SEND AUDIO OUTPUT TO THE SPEAKERS
endin

instr	2; UPDATE FLTK TEXT BOXES
	ktrig0 changed	int(gkharm2),int(gklh2)
	if ktrig0==1 then
	 if gkdisplay==0 then
	  gklh	=	int(gklh2)
	  gkharm	=	int(gkharm2)
	 else
	  klh	=	int(gklh2)
	  kharm	=	int(gkharm2)
	  ktrig	changed	klh
		FLsetVal	ktrig,klh,gihlh
	 ktrig	changed	kharm
		FLsetVal	ktrig,kharm,gihharm
	 endif
	endif
endin

instr	3	;REDEFINE THE USER WAVEFORM WHENEVER A CHANGE IS MADE
	ktrig	changed	gk1,gk2,gk3,gk4,gk5,gk6,gk7,gk8,gk9,gk10
	if ktrig==1 then
	 reinit	UPDATE_USER_WAVE
	endif
	UPDATE_USER_WAVE:
	giuser	ftgen 2, 0, 65536, 10, 1-i(gk1),1-i(gk2),1-i(gk3),1-i(gk4),1-i(gk5),1-i(gk6),1-i(gk7),1-i(gk8),1-i(gk9),1-i(gk10)
	rireturn
endin

</CsInstruments>

<CsScore>
f 0 3600		;DUMMY SCORE EVENT - ALLOW REALTIME PERFORMANCE FOR UP TO 1 HOUR 
i "StartInstr" 0 3600
i 2 1 3600		;UPDATE FLTK COUNTERS FROM FLTK X-Y PANEL
i 3 0 3600
</CsScore>

</CsoundSynthesizer>