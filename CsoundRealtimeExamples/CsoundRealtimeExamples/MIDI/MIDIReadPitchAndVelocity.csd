MIDIReadPitchAndVelocity.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -dm0 
</CsOptions>    

<CsInstruments>
                                                                                                         
sr 		= 	44100
ksmps 		= 	8
nchnls 		= 	1	;MONO
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0                      
;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      420,   0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"   Converting MIDI Pitch and Velocity into Csound Variables  ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The opcode 'cpsmidi' is used to convert a received MIDI pitch", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"into an i-rate variable usable in Csound orchestra code.     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"A variety of other pitch format are available:               ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'octmidi' provides a value in the 'oct' format.              ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"'pchmidi' provides a value in the 'pch' format.              ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'notnum' provides the actual note MIDI note number (range 0 -", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"127).                                                        ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'cpstmidi' reads in MIDI notes and converts according to a   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"tuning table in order to facilitate the employment of        ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"alternative tunings.                                         ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"The opcode 'ampmidi' converts a received MIDI velocity value ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"into an i-rate variable usable in Csound orchestra code.     ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"MIDI velocity values are normally within the range 0 to 127  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"but the maximum limit for ampmidi's output can be modified   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"using using the opcode's only input argument.                ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"An alternative opcode for scanning MIDI velocity is 'veloc'. ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"This example uses ampmidi's output for raw amplitude values  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"but it might be found that using its output for decibel      ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"values produces a more natural velocity response.            ", 	1,      5,     14,    490,    20,     5, 400
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave	ftgen	0,0,4096,10,1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81	;A RICH WAVEFORM

instr	1	; THIS INSTRUMENT WILL BE ACTIVATED BY NOTES PLAYED ON A MIDI KEYBOARD
	icps	cpsmidi	; THE OPCODE 'CPSMIDI' OUTPUTS A CYCLES-PER-SECOND REPRESENTATION OF A RECEIVED MIDI NOTE.
			; IN THIS EXAMPLE I HAVE CALLED THE OUTPUT VARIABLE 'ICPS'.
			; 'CPSMIDI' TAKES NO INPUT ARGUMENTS.
			; E.G. IF A4 IS STRUCK ICPS WILL EQUAL 440
			; SEE ALSO THE OPCODES: octmidi, pchmidi, notnum and cpstmidi
			
	iscale 	= 	0.2	;MAXIMUM RANGE LIMIT
	iamp	ampmidi	iscale	;READ IN MIDI VELOCITY. RE-RANGE FOR OUTPUT.
			; THE OPCODE 'AMPMIDI' OUTPUTS A VALUE (IN THIS CASE CALLED IAMP) CORRESPONDING TO THE KEY VELOCITY OF A RECEIVED NOTE ON MESSAGE.
			; THE FIRST ,AND ONLY OBLIGATORY ARGUMENT RESCALES THE RECEIVED VELOCITY VALUE (WHICH WOULD NORMALLY BE IN THE RANGE 0-127) TO THE RANGE 0 - iscale.
			; IN THIS CASE MEANS THAT THE VARIABLE IAMP WILL BE WITHIN THE RANGE 0 - 0.2 DEPENDING ON HOW HARD THE KEY WAS STRUCK
	;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | FUNCTION_TABLE
	asig	poscil	iamp,         icps,        giwave
		out	asig	;SEND AUDIO OUTPUT OF OSCILLATOR TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
f 0 600	; THIS LINE FUNCTIONS AS A DUMMY SCORE EVENT AND ALLOWS REALTIME MIDI PLAYING FOR 10 MINUTES
</CsScore>

</CsoundSynthesizer>