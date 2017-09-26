buzz.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	2	
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL     | WIDTH | HEIGHT | X | Y
		FLpanel	"buzz",      500,    170,    0,  0

;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFLTK_MIDI, ihFLTK_MIDI	FLbutBank	4,      1,     2,     20,      40,    5,  5,     0,     1,    0,  -1
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI", 	1,      6,     17,     50,     20,   23,   4
ih		 	FLbox  	"FLTK", 	1,      6,     17,     50,     20,   23,  24

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",	80,       20,    5,   95
idfreq			FLvalue	" ",	80,       20,    5,  145

;SLIDERS				     			MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider	"Amplitude",  		0,       1,  0,    23,  idamp,   490,     25,    5,   70
gkfreq, ihfreq		FLslider	"Oscillator Frequency",	1,    5000, -1,    23,  idfreq,  490,     25,    5,  120

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkharm,  gihharm 	FLcount  "No. of Harmonics CC#1",	-1,   80,    1,      2,      2,   120,       25,   375, 5,    -1

;SET INITIAL VALUES		VALUE | HANDLE
		FLsetVal_i	0.2, 	ihamp
		FLsetVal_i	30, 	gihharm
		FLsetVal_i	100, 	ihfreq

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Miscellaneous Waveforms : buzz               ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Buzz creates a composite tone of harmonically related sine   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"wave partials.                                               ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The user is given control of the number of partials required ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"(from the fundemental upwards) and of the the amplitude and  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the fundemental frequency of the tone.                       ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"Buzz requires the user to first supply it with a sine        ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"waveform via a function table (probably GEN 10). This table  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"should not be too small, sizes of 8192 and upwards are       ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"recommended.                                                 ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Buzz provides a useful source for subtractive synthesis.     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"This example can also be played from an external MIDI        ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"keyboard. Pitch, note velocity and pitch bend and represented", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"appropriately. MIDI controller 1 (the modulation wheel) can  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"be used to modulate 'Number of Harmonics'.                   ", 	1,      5,     14,    490,    15,     5, 300
                                                            
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen 0, 0, 4096, 10, 1		;FUNCTION TABLE THAT STORES A SINGLE CYCLE OF A SINE WAVE

instr	1		;BUZZ INSTRUMENT
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
		kfreq	=	icps				;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		iamp	veloc	0,1				;READ IN MIDI NOTE VELOCITY
		kamp	portk	gkamp*iamp,kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	else							;OTHERWISE...
		kfreq		portk	gkfreq,kporttime	;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp		portk	gkamp,kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	endif							;END OF THIS CONDITIONAL BRANCH

	;MIDI INPUT============================================================================================================================================================
        ;OUTPUT                 OPCODE          CHANNEL | CC.NUMBER | MIN | MAX
        kharm                    ctrl7           1,            1,      0,    1	;READ IN MIDI CONTROLLER
        ktrig                   changed         kharm    ;IF THE VARIABLE 'kptr' CHANGES FROM ITS PREVIOUS VALUE,
	kharm			scale		kharm, 80, -1	;RESCALE kharm FROM 0 - 1 TO -1 - 80
                                                        ;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
        ;                       OPCODE      |   TRIGGER | VALUE | HANDLE
                                FLsetVal        ktrig,     kharm,  gihharm	;UPDATE kharm (NUMBER OF HARMONICS) WIDGET WHEN A TRIGGER IS RECEIVED
        ;======================================================================================================================================================================
	
	;PITCH BEND===========================================================================================================================================================
	iSemitoneBendRange = 2			;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	kbend	pchbend	0, iSemitoneBendRange*2	;PITCH BEND VARIABLE (IN oct FORMAT)
	kfreq	=	kfreq*semitone(kbend)
	;=====================================================================================================================================================================
	
	;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | NO.OF HARMONICS | FUNCTION_TABLE
	asig	buzz	kamp,        kfreq,    int(gkharm),           gisine
	aenv	linsegr	0,0.01,1,0.01,0		;ANTI-CLICK ENVELOPE
	outs	asig * aenv, asig * aenv	;SEND AUDIO OUTPUT TO THE SPEAKERS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOW REALTIME PERFORMANCE FOR UP TO 1 HOUR 
</CsScore>

</CsoundSynthesizer>