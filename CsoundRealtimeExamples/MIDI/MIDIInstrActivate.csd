MIDIInstrActivate.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
;USE DEFAULT AUDIO OUTPUT | READ AND MIX MIDI FROM ALL INPUTS | DISABLE DISPLAYS
        -odac                        --midi-device=0                  -dm0 
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,      600,   0,  0  
				FLscroll     515,      600,   0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"   Activating an Instrument Through Realtime MIDI Control    ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Basic activation of Csound instruments through the use of a  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"connected MIDI keyboard can be transparent to the user. The  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"only requirement is that a Csound flag for live MIDI input is", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"given so that Csound knows to start the MIDI device.         ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"The default type is 'Port-Midi' but others are available     ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"depending on your platform. See the Csound Manual, 'Command  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Line Flags' section for details.                             ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"In the code of this example '--midi-device=0' ('-M0' would be", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"a less verbose equilvalent) is included in the <CsOptions>   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"section of the csd to activate realtime MIDI. The number     ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"after the flag selects which of your computer's MIDI input   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"devices to use. If your computer has only one MIDI input     ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"device then a zero (as I have used here) will select it. If  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"your computer has more than one MIDI input device installed  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"(including virtual devices such as MIDI yoke) then you may   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"need to give some other value here. If you are not sure what ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"MIDI input devices your computer has you can overestimate the", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"value given here (e.g. '-M99') in which case an error will be", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"produced and the Csound terminal window will print a list of ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"legal MIDI input devices and their related numbers. Another  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"option is to give the letter 'a' after the MIDI device flag  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"in which case all MIDI devices will be mixed and routed to   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"the Csound orchestra.                                        ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"This example is very basic and merely produces a tone which  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"starts and stops with MIDI note-ons and note-offs.           ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"Csound regards MIDI notes as held notes (p3=-1) so there will", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"be no point in trying to use p3 in envelopes. Instead        ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"envelopes with release stages can be used if note duration   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"needs to be a factor in the envelope's construction.         ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"Polyphony is possible although it is rather difficult to hear", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"in this example as all notes played will have the same pitch.", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"If an orchestra contains more that one instrument, MIDI notes", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"on MIDI channel 1 will be directed to instrument 1, channel 2", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"will be directed to instrument 2 and so on. Modification to  ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"this default arrangement is possible using the 'massign'     ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"opcode.                                                      ", 	1,      5,     14,    490,    20,     5, 740
				FLscroll_end
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1

instr	1	; SIMPLE BEEP INSTRUMENT - CAN BE ACTIVATED VIA A CONNECTED MIDI KEYBOARD
print p3
	;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | FUNCTION_TABLE
	asig	poscil	0.2,           440,         gisine
		out	asig	;SEND AUDIO OUTPUT OF OSCILLATOR TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
f 0 600	; THIS LINE FUNCTIONS AS A DUMMY SCORE EVENT AND ALLOWS REALTIME MIDI PLAYING FOR 10 MINUTES
</CsScore>

</CsoundSynthesizer>