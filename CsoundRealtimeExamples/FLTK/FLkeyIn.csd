FLkeyIn.csd
WRITTEN BY IAIN MCCURDY, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>
sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	1	
0dbfs	=	1	;MAXIMUM AMPLITUDE

gkMIDInote	init	60
giwave		ftgen	0,0,4096,10,1, 1/2, 0, 1/4, 0, 0, 1/8

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;**NOTE THAT FLpanel's OPTIONAL ikybdcapture INPUT ARGUMENT IS USED AND SET TO '1'**
;			LABEL | WIDTH | HEIGHT | X | Y | BORDER | KBDCAPTURE
		FLpanel	"",      515,    560,    0,  0,    0,         1

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         FLkeyIn                             ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Press 'p' to play note                                       ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"      's' to stop note                                       ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"      '+' to increment pitch (in semitone steps)             ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"      '-' to decrement pitch (in semitone steps)             ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"This example demonstrates the FLkeyIn opcode which can be    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"used to sense key presses on the computer's keyboard when an ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"FLTK window is in focus.                                     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"In order to use this opcode the FLpanel's optional           ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"ikybdcpature input argument must be used and set to '1'. This", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"can be used to define which FLTK panel will be used to sense ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"key presses when in focus.                                   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"FLkeyIn has a similar function to sensekey but has some      ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"subtle differences in behaviour. FLkeyIn senses when a key   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"has been released (by outputting a negative version of that  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"key's decimal value), sensekey does not. FLkeyIn continues to", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"output the ASCII decimal output of a held key on every       ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"k-cycle, sensekey outputs key repeats according to settings  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"made in the operating system (each value iteration being     ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"followed immediately by a '-1' value iteration). FLkeyIn also", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"outputs values for 'shift', 'alt', 'caps-lock' etc. presses. ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"FLkeyIn is therefore not case sensitive and instead outputs  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"the same value for lower and upper case key presses. The     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"Csound Manual documentation is currently incorrect in how it ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"describes the interpretation of 'shift+key' etc.             ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"Key press values are output to the terminal.                 ", 	1,      5,     14,    490,    20,     5, 540
                                                                                           
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;SENSE KEYBOARD ACTIVITY AND START RECORD OR PLAYBACK INSTRUMENTS ACCORDINGLY
	kKey	FLkeyIn	;SENSE ALPHANUMERIC KEYBOARD INPUT

	;UNCOMMENT THE FOLLOWING LINE IF YOU WANT ALL KEY PRESS VALUES OUTPUT TO THE TERMINAL
		printk2	kKey
	;
	
	kChanged	changed	kKey			;SENSE WHEN A KEY HAS BEEN PRESSED FOR T
	if kKey=112&&kChanged=1 then			;IF ASCCI VALUE OF 112 IS OUTPUT, I.E. 'p' HAS BEEN PRESSED...
	  event	"i", 2, 0, -1				;START INSTRUMENT 2
	elseif kKey=115&&kChanged=1 then		;IF ASCII VALUE OF 115 IS OUTPUT, I.E. 's' HAS BEEN PRESSED...
	  turnoff2	2,0,0				;STOP INSTRUMENT 2
	elseif kKey=61&&kChanged=1 then			;IF ASCII VALUE OF 43 IS OUTPUT, I.E. '+' HAS BEEN PRESSED...
	  gkMIDInote limit gkMIDInote + 1, 0, 127	;INCREMENT MIDI NOTE NUMBER UP ONE STEP
	elseif kKey=45&&kChanged=1 then			;IF ASCII VALUE OF 43 IS OUTPUT, I.E. '-' HAS BEEN PRESSED...
	  gkMIDInote limit gkMIDInote - 1, 0, 127	;DECREMENT MIDI NOTE NUMBER DOWN ONE STEP
	endif						;END OF CONDITIONAL BRANCH
endin

instr 2	;PLAYS A TONE
	aenv	linsegr	0,0.01,1,0.01,0
	a1	oscili	0.2*aenv, cpsmidinn(gkMIDInote), giwave
	out	a1
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;SENSES KEYBOARD ACTIVITY INSTRUMENT
</CsScore>

</CsoundSynthesizer>