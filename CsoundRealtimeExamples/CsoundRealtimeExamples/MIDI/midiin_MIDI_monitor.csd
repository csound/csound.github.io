midiin_MIDI_monitor.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
;activate all midi devices
-Ma -dm0

;activate virtual midi device
;-M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

ksmps 	= 	32

 ;using massign with these arguments disables Csound's default instrument triggering
massign 0,0

;FLTK INTERFACE CODE==============================================================================================================================================================
FLcolor	255,255,255,255,255,50
;	LABEL                    | WIDTH | HEIGHT | X | Y
FLpanel	"midiin - MIDI Monitor",    425,    100,    0,  0

;						 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT |  X  | Y
gk1, gihstatus		FLtext		"Status", 	0,   2000,    0,     1,   100,     20,      5,   5
gk1, gihchan		FLtext		"Channel", 	1,     16,    0,     1,   100,     20,    110,   5
gk1, gihdata1		FLtext		"Data 1", 	0,   2000,    0,     1,   100,     20,    215,   5
gk1, gihdata2		FLtext		"Data 2", 	0,   2000,    0,     1,   100,     20,    320,   5

FLpanel_end

;INSTRUCTIONS AND INFO PANEL                      WIDTH | HEIGHT | X | Y
				FLpanel	"pchbend", 515,    360,  440,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                    midiin - MIDI Monitor                    ", 	1,      6,     14,    490,    25,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The 'midiin' opcode can be used to monitor raw midi          ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"data in the form of a status byte (which describes the type  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"of the midi message), the MIDI channel number and the two    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"data bytes.                                                  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"This example implements a MIDI monitor that will print MIDI  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"messages to the terminal and to the FLTK value boxes.        ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Each time midiin reads a message it follows it in the next   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"kcycle with a similar message but with a status byte of zero.", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"In displaying MIDI messages this example filters out these   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"messages so that the user can clearly see the status byte of ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"each message received.                                       ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"Some example status bytes are:                               ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"144 - note on                                                ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"128 - note off                                               ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"176 - continuous controller                                  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"192 - program change                                         ", 	1,      5,     14,    490,    20,     5, 340
				FLpanel_end
FLrun

instr 1
	kstatus, kchan, kdata1, kdata2  midiin			;READ IN MIDI
	ktrigger  changed  kstatus, kchan, kdata1, kdata2	;GENERATE A MOMENTARY '1' VALUE IF MIDI DATA CHANGES
	if      ktrigger=1&&kstatus!=0 then			;CONDITIONALLY BRANCH WHEN TRIGGER IS RECEIVED AND WHEN STATUS BYTE IS SOMETHING OTHER THAN ZERO
		printks "status:%d%tchannel:%d%tdata1:%d%tdata2:%d%n", 0, kstatus, kchan, kdata1, kdata2	;PRINT MIDI DATA TO THE TERMINAL WITH FORMATTING
		FLsetVal	ktrigger,kstatus,gihstatus	;WRITE VALUE TO FLTK VALUE BOX
		FLsetVal	ktrigger,kchan,gihchan		;WRITE VALUE TO FLTK VALUE BOX
		FLsetVal	ktrigger,kdata1,gihdata1	;WRITE VALUE TO FLTK VALUE BOX
		FLsetVal	ktrigger,kdata2,gihdata2	;WRITE VALUE TO FLTK VALUE BOX
	endif
endin

</CsInstruments>

<CsScore>
i 1 0 3600; run midi scanning for 1 hour
</CsScore>

</CsoundSynthesizer>