MIDIInstrActivate.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -dm0 
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;INSTRUCTIONS AND INFO PANEL                WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,    240,    0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"   A Single MIDI controller creates two Csound variables     ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Move controller 1 on MIDI channel 1 or the modulation wheel  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"on a MIDI keyboard set to channel 1.                         ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"There is nothing to prevent you from using several instances ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"of ctrl7 which reference the same MIDI controller.           ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"In this example the frequencies of two different oscillators ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"are both driven by MIDI controller 1 on MIDI channel 1. The  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"ranges of the two ctrl7s outputs are different however. As   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"controller 1 is moved from minimum to maximum the pitch of   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"oscillator 1 moves from C4 up to C5 but the pitch of         ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"oscillator 2 move from C4 down to C3.                        ", 	1,      5,     14,    490,    20,     5, 220
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave	ftgen	0,0,4096,10,1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81	;A RICH WAVEFORM

instr	1	;
	
	;OUTPUT		OPCODE	CHANNEL | CTRLNUMBER | MINIMUM | MAXIMUM
	koct1		ctrl7	1,            1,          8,        9 	;READ CONTROLLER INFORMATION FROM CONTINUOUS CONTROLLER NUMBER 1 ON MIDI CHANNEL 1 AND RESCALE TO BE WITHIN THE RANGE 8 - 9. BOTH CTRL7S REFERENCE THE SAME MIDI CONTROLLER
	koct2		ctrl7	1,            1,          8,        7 	;READ CONTROLLER INFORMATION FROM CONTINUOUS CONTROLLER NUMBER 1 ON MIDI CHANNEL 1 AND RESCALE TO BE WITHIN THE RANGE 8 - 7. BOTH CTRL7S REFERENCE THE SAME MIDI CONTROLLER
	
	;OUTPUT	OPCODE	AMPLITUDE |  FREQUENCY   | F.N.
	asig1	poscil	0.1,      cpsoct(koct1),   giwave	;TWO OSCILLATORS ARE CREATED WITH DIFFERENT FREQUENCIES - FREQUENCY VARIABLES MUST BE CONVERTED INTO CPS FORMAT FROM OCT FORMAT
	asig2	poscil	0.1,      cpsoct(koct2),   giwave	;TWO OSCILLATORS ARE CREATED WITH DIFFERENT FREQUENCIES - FREQUENCY VARIABLES MUST BE CONVERTED INTO CPS FORMAT FROM OCT FORMAT
	
		out	(asig1 + asig2)				;THE TWO OSCILLATORS ARE MIXED AND SENT TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
i 1 0 3600	; INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>