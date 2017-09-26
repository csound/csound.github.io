pchbend1.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -M8 -dm0
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"pchbend", 110, 90, 0, 0                   

;FLTK-COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkBendRange, ihBendRange 	FLcount  "Bend Range (semitones)",	-48,   48,    1,      1,      2,     100,     25,    5,  5,   -1

;INITIALISE VALUATORS		VALUE | HANDLE
		FLsetVal_i	2, 	ihBendRange
                                                                                                                                                   
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                      WIDTH | HEIGHT | X | Y
				FLpanel	"pchbend", 515,    620,  120,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"              pchbend - Scanning MIDI Pitch Bend             ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates how to scan the MIDI pitch bend    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"wheel/joystick of a connected MIDI keyboard and to use the   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"incoming data to implement the traditional pitch bend        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"functionality.                                               ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Building upon the simple synthesizer of previous examples the", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"opcode 'pchbend' is employed to read in pitch-bend data from ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"the MIDI keyboard. N.B. The instrument containing the        ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'pchbend' opcode will have to have been triggered from MIDI  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"in order for the opcode to read pitch-bend data properly.    ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"Pitch bend is a 14-bit controller and therefore has the      ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"potential of outputting high resolution data with up to 16384", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"discrete steps. In reality MIDI hardware rarely uses this    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"full resolution and will instead quantize this resolution and", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"change in steps greater than 1. The pitch bend wheels on very", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"cheap MIDI keyboards are often basically 7-bit controllers   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"moving in steps of 128. These issues are transparent to us   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"when using 'pchbend' but they may become a concern in this   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"example when 'Bend Range' is high in which case individual   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"steps in pitch may be audible. Portamento on the pitch-bend  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"variable can reduce this effect.                             ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"Giving 'Bend Range' a negative value will invert the pitch   ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"bending effect.                                              ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"There is nothing to say that the pitch bend wheel needs to be", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"used to bend the pitch of something in Csound - it could     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"also be used to control panning, sample playback speed or    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"anything really. The crucial element in the design of the    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"pitch bend wheel is in its use of a central spring loaded    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"equilibrium position and ideally this feature should be      ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"capitalised upon when pitch-bend is used in Csound.          ", 	1,      5,     14,    490,    20,     5, 600
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave	ftgen	0,0,4096,10,1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81	;A RICH WAVEFORM

instr	1	; SIMPLE SYNTHESIZER WITH PITCH BEND
	icps	cpsmidi		;READ IN PITCH (IN CYCLES PER SECOND) FROM MIDI KEYBOARD
	iamp	ampmidi	0.2	;READ IN MIDI VELOCITY. WILL OUTPUT IN THE RANGE 0 - 0.2
	
	;PITCH BEND INFORMATION IS READ
	imin	=	0			;VALUE THAT PITCH-BEND WILL OUTPUT AT ITS EQUILIBRIUM POSITION
	imax	=	2			;RANGE OF PITCH-BEND FROM PULLED MINIMUM TO PUSHED MAXIMUM
	kbend	pchbend	imin,imax		;THIS WILL OUTPUT A RANGE FROM -1 TO +1 WITH ZERO AT THE EQUILIBRIUM POSITION. 
	kbend	=	kbend*gkBendRange	;kbend RESCALED TO COVER SEMITONE RANGE DEMANDED BY FLTK COUNTER
	kbend	=	semitone(kbend)		;CONVERTED TO A RATIO OF TRANSPOSITION
	
	kporttime	linseg	0,0.01,0.01	;A FUNCTION THAT QUICKLY RAMPS UP FROM ZERO TO A HELD VALUE THAT WILL BE USED AS PORTAMENTO TIME
	kbend	portk	kbend,kporttime		;APPLY PORTAMENTO SMOOTHING TO PITCH BEND VARIABLE
	
	;SIMPLE ANTI-CLICK AMPLITUDE ENVELOPE WITH RELEASE SENSING 
	;               INITIAL_LEVEL | ATTACK_TIME | ATTACK_LEVEL | DECAY_TIME | SUSTAIN_LEVEL |  RELEASE_TIME | RELEASE_LEVEL
	aenv	linsegr	      0,           (.01),          1,           (.1),          .5,            (.2),            0 
	
	;OUTPUT	OPCODE	AMPLITUDE |  FREQUENCY   | FUNCTION_TABLE
	asig	poscil	iamp*aenv,  icps*kbend,       giwave		;CREATE AUDIO OSCILLATOR
		out	asig			;SEND AUDIO OUTPUT OF OSCILLATOR TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
f 0 600	; THIS LINE FUNCTIONS AS A DUMMY SCORE EVENT AND ALLOWS REALTIME MIDI PLAYING FOR 10 MINUTES
</CsScore>

</CsoundSynthesizer>