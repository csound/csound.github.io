; Exciter.csd
; Written by Iain McCurdy, 2015

<CsoundSynthesizer>

<CsOptions>
-odac -iadc -dm0
</CsOptions>

<CsInstruments>

sr=44100
ksmps=32
nchnls=2
0dbfs =1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 250, 250, 50
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"Exciter",     500,    360,    0,  0

;BUTTONS                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,     2,    150,     30,    5,  5,    0,      1,      0,       -1      

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkInput, ihInput	FLbutBank	1,      1,     2,     20,      40,  200,  5,    -1; 0,     2,    0, 3600
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Sound File", 	1,      5,     14,    80,     20,   225, 5
ih		 	FLbox  	"Live      ", 	1,      5,     14,    80,     20,   225,25

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idFreq				FLvalue	"",     50,     18,     5,  80
idCeil				FLvalue	"",     50,     18,     5, 130
idHarmonics			FLvalue	"",     50,     18,     5, 180
idBlend				FLvalue	"",     50,     18,     5, 230
idMix				FLvalue	"",     50,     18,     5, 280
idGain				FLvalue	"",     50,     18,     5, 330

;SLIDERS					            			MIN | MAX  | EXP | TYPE | DISP     | WIDTH | HEIGHT | X | Y
gkFreq, ihFreq			FLslider 	"Frequency Minimum",		20,   20000, -1,    23,  idFreq,      490,     20,    5, 60
gkCeil, ihCeil			FLslider 	"Frequency Maximum",		20,   20000, -1,    23,  idCeil,      490,     20,    5,110
gkHarmonics, ihHarmonics	FLslider 	"Harmonics Amount",		0.1,     10,  0,    23,  idHarmonics, 490,     20,    5,160
gkBlend, ihBlend		FLslider 	"2nd/3rd Order Harm. Blend",	-10,     10,  0,    23,  idBlend,     490,     20,    5,210
gkMix, ihMix			FLslider 	"Dry/Wet Mix",			0,        1,  0,    23,  idMix,       490,     20,    5,260
gkGain, ihGain			FLslider 	"Gain",				0,        5,  0,    23,  idGain,      490,     20,    5,310

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	3000,   ihFreq
		FLsetVal_i	20000,  ihCeil
		FLsetVal_i	10,     ihHarmonics
		FLsetVal_i	10,     ihBlend
		FLsetVal_i	0.5,    ihMix
		FLsetVal_i	1,    ihGain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 280, 525, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          Exciter                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"An exciter is a device that uses harmonic distortion to add a", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"high frequency shimmer to a signal. It is a common tool in   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"mastering.                                                   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Csound includes an opcode called 'exciter' which is an       ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"implementation of the 'Calf' exciter plugin.                 ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"'Frequency Minimum' and 'Frequency Maximum' define the       ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"frequency range across which harmonics will be created.      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"We also have control over the amount of harmonics created and", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the blend between the 2nd and 3rd order harmonics. The effect", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of these parameters is subtle and the user might find it     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"useful to at first set 'Dry/Wet Mix' to maximum (100% wet)   ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"in order to hear the effect more clearly.                    ", 	1,      5,     14,    490,    15,     5, 260
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1

 /* SELECT INPUT */
 if gkOnOff==0 then
  turnoff
 endif
 if gkInput==0 then
  aInL,aInR 	diskin2 	"ClassicalGuitar.wav", 1,0,1	; SOUND FILE
 else
  aInL,aInR 	ins						; LIVE INPUT
 endif

 /* SMOOTH PARAMETER CHANGES */
 kPortTime	linseg		0,0.001,0.02			; A FUNCTION THAT RAMPS UP QUICKLY TO A HELD VALUE
 kFreq		portk	gkFreq, kPortTime			; APPLY PORTAMENTO SMOOTHING
 kCeil		portk	gkCeil, kPortTime			; APPLY PORTAMENTO SMOOTHING
 kHarmonics	portk	gkHarmonics, kPortTime			; APPLY PORTAMENTO SMOOTHING
 kBlend		portk	gkBlend, kPortTime			; APPLY PORTAMENTO SMOOTHING
 kMix		portk	gkMix, kPortTime			; APPLY PORTAMENTO SMOOTHING
 kGain		portk	gkGain, kPortTime			; APPLY PORTAMENTO SMOOTHING                  	

 aExL 		exciter 	aInL, kFreq, kCeil, kHarmonics, kBlend	; 'EXCITE' EACH CHANNEL
 aExR 		exciter 	aInR, kFreq, kCeil, kHarmonics, kBlend
 aL		ntrpol		aInL, aExL, kMix		; CREATE A DRY WET MIX OF EACH CHANNEL
 aR		ntrpol		aInR, aExR, kMix
 		outs 		aL*kGain, aR*kGain		; SEND TO OUTPUTS. APPLY GAIN.
endin


</CsInstruments>

<CsScore>
f 0 [3600+24+7]
e
</CsScore>

</CsoundSynthesizer>