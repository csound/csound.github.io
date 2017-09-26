MIDI&FLTK_Combined.csd
Written by Iain McCurdy, 2009

This example creates an fltk slider (controlling the frequency of an oscillator) which can also be controlled by midi controller 1 (modulation wheel).
The appearance of the fltk slider will also be updated through the use of the FLsetVal opcode.

<CsoundSynthesizer>

<CsOptions>
-odac -d -M0 -+rtmidi=virtual 
;REMOVE -+rtmidi=virtual IN ORDER TO USE AN EXTERNAL MIDI DEVICE
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	16
nchnls	=	1
0dbfs	=	1

FLcolor	255,255,245,0,0,0	;SET COLOUR SCHEME
;       		OPCODE |    "LABEL"            | WIDTH | HEIGHT | X | Y
			FLpanel	"MIDI & FLTK Combined",   1000,    200,   0,  0

;FLTK SLIDER
;NOTE THAT THE OUTPUT HANDLE VARIABLE  (gihoct) NEEDS TO BE A GLOBAL VARIABLE SO THAT IT IS ACCESSIBLE IN INSTRUMENT 1
;					            	MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X   | Y
gkoct, gihoct		FLslider 	"Pitch",	6,    12,    0,    5,     -1,    750,     30,   125,  50

;TEXT BOXES
;                                         			                                                     | ITYPE | IFONT | ISIZE | IWIDTH | IHEIGHT | IX | IY
ihCC	 FLbox  "MOVE THE ON SCREEN SLIDER OR MOVE CONTINUOUS CONTROLLER 1 (MODULATION WHEEL) ON YOUR MIDI DEVICE.",     1,      6,      14,    1000,      20,     0,  150
			FLpanel_end
			FLrun

gisine	ftgen 0, 0, 65536, 10, 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE

instr 1
	;OUTPUT		OPCODE		CHANNEL | CC.NUMBER | MIN | MAX
	koct		ctrl7		1,            1,       6,    12
	kmetro		metro		20
	if kmetro==1 then			;LIMIT REATE OF UPDATE
	  ktrig		changed		koct	;IF THE VARIABLE 'koct' CHANGES FROM ITS PREVIOUS VALUE,
						;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
	;		OPCODE      |   TRIGGER | VALUE | HANDLE
			FLsetVal	ktrig,    koct,   gihoct
	endif
	kporttime	linseg		0,0.001,0.02			;RAMPING UP PORTAMENTO TIME FUNCTION
	kcps		=		cpsoct(gkoct)			;CONVERT OCT-FORMAT PITCH (FROM FLTK SLIDER) TO CPS FORMAT
	kcps		portk		kcps, kporttime			;APPLY PORTAMENTO SMOOTHING TO K-RATE VARIABLE
	acps		interp		kcps				;CONVERT K-RATE VARIABLE TO A-RATE EQUIVALENT WITH INTERPOLATION SMOOTHING
	;OUTPUT		OPCODE		AMPLITUDE |   FREQUENCY   | FUNCTION_TABLE
	asig		oscil		0.1,            acps,       gisine		;CREATE AN OSCILLATOR
			out		asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600     	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>