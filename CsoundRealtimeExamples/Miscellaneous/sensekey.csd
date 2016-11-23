sensekey.csd
WRITTEN BY IAIN MCCURDY, 2011

This example demonstrates the 'sensekey' opcode which senses key presses on the computer's keyboard and outputs 
the decimal value.
To be able to use key presses we will need to know their decimal values. 
These can be found online in an ascii table (http://www.asciitable.com/)
or they can be output to the terminal by uncommenting a line in instr 1.
Note that the ascii codes of certain keys (for example the cursor keys) differ from platform to platform.
Using 'or' ('||') enquiries in the conditional interrogations can accomodate cross-platform compatibility.

Note that the terminal window will need to be in focus for key presses to be sensed, for this reason no fltk is used in this example.
to sense key presses when an FLTK window is in focus use the 'FLkeyin' opcode.

'sensekey' does behave slightly differently to 'FLkeyin' however. 
'sensekey' follows each key press value with a '-1', but keypress values are reiterated according to repeat-key 
settings made in the computer's operating system.
Each subsequent iteraction is again followed immediately with a '-1'.
'FLkeyin' reiterates each value upon each k-cycle.

sensekey is case sensitive.

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
gkamp		init	0.2
giwave		ftgen	0,0,4096,10,1, 1/2, 0, 1/4, 0, 0, 1/8

instr	1	;SENSE KEYBOARD ACTIVITY AND START RECORD OR PLAYBACK INSTRUMENTS ACCORDINGLY
		prints  "See .csd for a full explanation...\\n"
		prints  "Press 'p' to play, 's' to stop, '+' to raise pitch, '-' to lower pitch, 'cursor up' to raise volume and 'cursor down' to lower volume.\\n"
	kKey	sensekey	;SENSE ACTIVITY ON THE COMPUTER KEYBOARD

	;UNCOMMENT THE FOLLOWING LINE IF YOU WANT ALL KEY PRESS VALUES OUTPUT TO THE TERMINAL     
		printk2	kKey
	;;

	if kKey=112 then				;IF ASCCI VALUE OF 112 IS OUTPUT, I.E. 'p' HAS BEEN PRESSED...
	  event	"i", 2, 0, -1				;START INSTRUMENT 2
	elseif kKey=115 then				;IF ASCII VALUE OF 115 IS OUTPUT, I.E. 's' HAS BEEN PRESSED...
	  turnoff2	2,0,1				;STOP INSTRUMENT 2
	elseif kKey=43 then				;IF ASCII VALUE OF 43 IS OUTPUT, I.E. '+' HAS BEEN PRESSED...
	  gkMIDInote limit gkMIDInote + 1, 0, 127	;INCREMENT MIDI NOTE NUMBER UP ONE STEP (LIMIT RANGE TO BE BETWEEN ZERO AND 127)
	elseif kKey=95 then				;IF ASCII VALUE OF 43 IS OUTPUT, I.E. '-' HAS BEEN PRESSED...
	  gkMIDInote limit gkMIDInote - 1, 0, 127	;DECREMENT MIDI NOTE NUMBER DOWN ONE STEP (LIMIT RANGE TO BE BETWEEN ZERO AND 127)
	;CROSS-PLATFORM COMPATIBILITY WHEN USING CURSOR KEY ASCII CODES DEMANDS THAT WE INCLUDE ASCII CODES FOR ALL PLATFORMS.
	elseif kKey=65||kKey=72 then			;IF ASCII VALUE OF 65 (MAC & LINUX) OR 72 (WINDOWS) IS OUTPUT, I.E. '-' HAS BEEN PRESSED...
	  gkamp limit gkamp + 0.01, 0, 1		;INCREMENT AMPLITUDE UP ONE STEP (LIMIT RANGE TO BE BETWEEN ZERO AND 1)
	elseif kKey=66||kKey=80 then			;IF ASCII VALUE OF 66 (MAC & LINUX) OR 80 (WINDOWS) IS OUTPUT, I.E. '-' HAS BEEN PRESSED...
	  gkamp limit gkamp - 0.01, 0, 1		;DECREMENT AMPLITUDE DOWN ONE STEP (LIMIT RANGE TO BE BETWEEN ZERO AND 1)
	elseif kKey=105 then				;IF ASCII VALUE IS 105 ('i' key), REPEAT PRINT INSTRUCTIONS
	 printks  "Press 'p' to play, 's' to stop, '+' to raise pitch, '-' to lower pitch, 'cursor up' to raise volume and 'cursor down' to lower volume.\\n",0
	endif						;END OF CONDITIONAL BRANCH
endin

instr 2	;PLAYS A TONE
	aenv	linsegr	0,0.01,1,0.01,0
	a1	oscili	gkamp*aenv, cpsmidinn(gkMIDInote), giwave
	out	a1
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;SENSES KEYBOARD ACTIVITY INSTRUMENT
</CsScore>

</CsoundSynthesizer>