PolyphonyControl.csd
Written by Iain McCurdy 2008, Rewritten 2012 (originally entitled 'MonoOverlaps.csd').

<CsoundSynthesizer>

<CsOptions>
;UNCOMMENT THE FOLLOWING LINE OF CODE IF YOU DO NOT HAVE A MIDI KEYBOARD CONNECTED
-odac -dm0 -M0 -+rtmidi=virtual
;UNCOMMENT THE FOLLOWING LINE OF CODE IF YOU HAVE A MIDI KEYBOARD CONNECTED
;-odac -dm0 -Ma
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	8
nchnls 	= 	1
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

FLcolor	255, 255, 255, 100, 200, 200
		FLpanel	"Polyphony Control", 500, 250, 0, 0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkExit,ihExit	FLbutton	"Exit Example",		1,   0,    21,    120,     25,  375, 200,    0,    999,      0,    0.001

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X |  Y
idatt			FLvalue	" ",     	60,       20,    5,   25
iddec			FLvalue	" ",     	60,       20,    5,   75
idsus			FLvalue	" ",     	60,       20,    5,  125
idrel			FLvalue	" ",     	60,       20,    5,  175

;				            			MIN  | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gkatt, ihatt		FLslider 	"Attack Time",		0.01,  12,   -1,    23,   idatt,    490,    25,     5,   0
gkdec, ihdec		FLslider 	"Decay Time",		0.01,   8,   -1,    23,   iddec,    490,    25,     5,  50
gksus, ihsus		FLslider 	"Sustain Level",	0,      1,    0,    23,   idsus,    490,    25,     5, 100	;SUSTAIN LEVEL CANNOT BE ZERO FOR mxadsr OPCODE
gkrel, ihrel		FLslider 	"Release Time",		0.01,  12,   -1,    23,   idrel,    490,    25,     5, 150

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT  | X | Y | OPCODE
gkPolyLimit, ihPolyLimit 	FLcount  "Polyphony Limit", 	1,    127,     1,      1,      2,   120,      25,    5, 200,   -1

			FLsetVal_i	0.01, 	ihatt
			FLsetVal_i	4, 	ihdec
			FLsetVal_i	0.6, 	ihsus
			FLsetVal_i	1, 	ihrel
			FLsetVal_i	1, 	ihPolyLimit

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	"Info.", 500, 440, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"      Polyphony Controlled Instrument with Note Releases     ", 	1,      6,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates how to design an instrument in     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"which polyphony is controlled. If the polyphony limit is     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"exceeded the oldest note will be removed but its release     ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"stage will be allowed to complete in thus preventing clicks  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"that might otherwise occur using a more basic polyphony      ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"control mechanism.                                           ", 	1,      5,     14,    490,    20,     5, 140
ih	  	 	FLbox  	"The instrument uses a mechanism for counting the number of   ", 	1,      5,     14,    490,    20,     5, 160
ih	  	 	FLbox  	"notes being held. The 'active' opcode is *not* used as it    ", 	1,      5,     14,    490,    20,     5, 180
ih	  	 	FLbox  	"regards notes in their release stage as still active. We need", 	1,      5,     14,    490,    20,     5, 200
ih	  	 	FLbox  	"a mechanism which regards notes in their release stage as    ", 	1,      5,     14,    490,    20,     5, 220
ih	  	 	FLbox  	"inactive. To achieve this, a counter is incremented each time", 	1,      5,     14,    490,    20,     5, 240
ih	  	 	FLbox  	"note is added and decremented (through the use of the        ", 	1,      5,     14,    490,    20,     5, 260
ih	  	 	FLbox  	"'release' and 'trigger' opcodes) each time a note is         ", 	1,      5,     14,    490,    20,     5, 280
ih	  	 	FLbox  	"released. The number of held notes is interogated each       ", 	1,      5,     14,    490,    20,     5, 300
ih	  	 	FLbox  	"k-cycle and if this exceed the polyphony limit a note is     ", 	1,      5,     14,    490,    20,     5, 320
ih	  	 	FLbox  	"removed through the use of the 'turnoff' opcode. The oldest  ", 	1,      5,     14,    490,    20,     5, 340
ih	  	 	FLbox  	"note will always be removed first as it will be the first one", 	1,      5,     14,    490,    20,     5, 360
ih	  	 	FLbox  	"intergated in the note stack. Once it is removed the note    ", 	1,      5,     14,    490,    20,     5, 380
ih	  	 	FLbox  	"count will be within the polyphony limit again and all other ", 	1,      5,     14,    490,    20,     5, 400
ih	  	 	FLbox  	"held notes will remain untouched.                            ", 	1,      5,     14,    490,    20,     5, 420

				FLpanel_end

		FLrun		;RUN THE WIDGET THREAD!

;NUMBER OF ACTIVE NOTES
;(NOTES IN RELEASE STAGE REGARDED AS INACTIVE)
gkactive init 0

instr	1	; NOTE TRIGGERING INSTRUMENT
	gkactive init i(gkactive) + 1	;INCREMENT NOTE COUNTER
	
	if gkactive>i(gkPolyLimit) then	;IF POLYPHONY IS EXCEEDED (THROUGH THE ADDITION OF NEW NOTE)
	 turnoff			;REMOVE THIS NOTE
	endif

	krel release			;IF NOTE HELD = 0, IF NOTE RELEASED = 1
	ktrig trigger krel,0.5,0	;WHEN RELEASE FLAG CROSSES 0.5 UPWARDS, I.E. NOTE HAS BEEN RELEASED...	
	if ktrig==1 then		
	 gkactive = gkactive - 1	;...DECREMENT ACTIVE NOTES COUNTER
	endif

	icps	cpsmidi			;READ CYCLES PER SECOND VALUES FROM MIDI KEYBOARD INPUT
	iamp	ampmidi	1
	;                ATT      |  DEC    |  SUS    |   REL
	aenv 	madsr 	i(gkatt),  i(gkdec), i(gksus),  i(gkrel)	;MIDI SENSING ADSR ENVELOPE WITH LINEAR SEGMENTS
	kfco 	madsr 	i(gkatt),  i(gkdec), i(gksus),  i(gkrel)	;MIDI SENSING ADSR ENVELOPE WITH LINEAR SEGMENTS
	;OUTPUT OPCODE   AMP      CPS FUNCTION_TABLE
	asig	vco2	0.3*iamp, icps, 0				;AUDIO OSCILLATOR
	asig	moogvcf2	asig,icps*kfco*6*iamp,0.6
		out	asig*aenv						;SEND AUDIO BACK TO INSTR 1
endin

instr	999	;QUIT
	exitnow		;EXIT CSOUND IMMEDIATELY
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REAL-TIME PLAYING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>