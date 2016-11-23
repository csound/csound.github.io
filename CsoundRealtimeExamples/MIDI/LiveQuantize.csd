LiveQuantize.csd
Written by Iain McCurdy 2008. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -d -m0 -Ma
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	100
nchnls 	= 	1
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 50, 0, 0
		FLpanel	"Live Quantize", 300, 250, 0, 0

;BUTTONS                                     			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR
gkLiveQuantize,ihLiveQuantize	FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,   0,      2,     0,      3600                             
FLsetColor2	255, 255, 50, ihLiveQuantize	;SET SECONDARY COLOUR TO YELLOW

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE
gkTempo,ihTempo 	FLcount		"Tempo",	1,    999,    1,     10,     21,   100,     20,      10,     50,      -1
gkSubDiv,ihSubDiv 	FLcount		"Beat Subdiv.",	1,      4,    1,     10,      2,   100,     20,     120,     50,      -1

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X |  Y
idDelay			FLvalue	" ",     	60,       18,    5,  170

;SLIDERS								MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkMetroGain, ihMetroGain	FLslider	"Metronone Vol.",	0,     1,  0,       5,     -1,       280,     20,    10,   100
gkDelay, ihDelay		FLslider	"Delay",		0,   0.2,  0,       5,   idDelay,    280,     20,    10,   150
gkFlash, gihFlash		FLslider	"",			0,     1,  0,       2,     -1,        80,     40,   110,   200

		FLsetVal_i	60, 	ihTempo
		FLsetVal_i	 1, 	ihSubDiv
		FLsetVal_i	0.5, 	ihMetroGain
		FLsetVal_i	0.05, 	ihDelay

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 400, 312, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       Live Quantize                         ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example quantizes an incoming stream of MIDI notes      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"in relation to an internal metronone and quantizing division.", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"If a MIDI note-on is received the orchestra calculates how   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"much time will elapse until the next quantize division and   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"delays the sounding of that note until then.                 ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"As well as providing an audio metronome, a visual metronome  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"is provided for when the audio metronome must be muted.      ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"This technique might also be useful in creating a setup where", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"loop players wait until the next bar-line to start playing as", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"is implemented in the programme 'Ableton Live'.              ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'Beat Subdiv.' defines the subdivision of the beat to which  ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"notes played will be quantized. For example, assuming a beat ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"is a crotchet, 1=crotchets 2=quavers 3=triplet_quavers       ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"4=semiquavers.                                               ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"'Delay' is like a tolerance factor which allows the player to", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"play a little after the quantize division without that note  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"being delayed until the next division boundary. This feature ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"may prove helpful with certain playing styles.               ", 	1,      5,     14,    490,    20,     5, 380
				FLpanel_end
		FLrun		;RUN THE WIDGET THREAD!

gisine		ftgen	0,0,4096,10,1	;A SINE WAVE
gkTimer		init	0		;BEAT TIMER

instr	2	;TURNS ON THE QUANTIZER
	gkTempoClock	init	0	;INITIALISE VARIABLE FOR MAIN CLOCK	
	if gkLiveQuantize=0 then	;IF QUANTIZER IS OFF
	  turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF
	kTrigger	metro		gkTempo/60
	kBeatDur		=	60/gkTempo
			schedkwhen	kTrigger,0,0,"timer",gkDelay,kBeatDur	;TURN ON TIMER INSTRUMENT
			schedkwhen	kTrigger,0,0,"click",0,0.005		;METRONOME AUDIO 'CLICK'
			schedkwhen	kTrigger,0,0,"flash",0,0.05		;METRONOME VISUAL 'FLASH'
endin

instr	timer	;TIMER INSTRUMENT RUNS FOR 1 BEAT
	gkTimer	line	0,p3,1	;TIMER RUNS FROM 0 TO 1 FOR 1 BEAT
endin

instr	click	;METRONOME SOUND GENERATOR
	aenv	linseg	0,0.001,1,p3-0.001,0	;PERCUSSIVE ENVELOPE
	afreq	expon	4000,p3,20		;PITCH OF TONE (VERY FAST GLISS)
	asig	oscili	gkMetroGain*aenv,afreq,gisine	;CREATE AUDIO FOR METRONOME 'CLICK'
		out	asig			;SEND AUDIO TO OUPUT
endin

instr	flash	;VISUAL METRONOME
	krelease	release			;SENSE THE END OF THE NOTE
	FLsetVal_i	1,gihFlash		;TURN FLASH INDICATOR ON
	FLsetVal	krelease,0,gihFlash	;SWITCH OFF THE FLASH INDICATOR WHEN THE NOTE ENDS 
endin

instr	1	;MIDI TRIGGERED INSTRUMENT
	;CALCULATE THE REQUIRED DELAY TIME SO THAT THE NOTE WILL BEGIN SOUNDING ON THE NEXT QUANTIZE UNIT DIVISION
	iTime		init	frac(i(gkTimer)*i(gkSubDiv))		;DURATION (AS A FRACTION OF A UNIT) THROUGH THE CURRENT QUANTIZE UNIT
	iDelay		=	((1-iTime)*(60/i(gkTempo)))/i(gkSubDiv)	;REQUIRED DELAY TO SHIFT ONTO NEXT QUANTIZE POINT
	iDelay		limit	iDelay-i(gkDelay),0,iDelay		;REMOVE PERFORMANCE TRACKING DELAY (AND DISALLOW VALUES LESS THAN ZERO)
			timout 0, iDelay*i(gkLiveQuantize), PAUSE	;THIS LINE WILL DELAY THE SOUND PRODUCING PART OF THE INSTRUMENT BY JUMPING TO LABEL 'PAUSE' - 
									;-FOR THE DELAY TIME SO THAT THE NOTE BEGINS TO SOUND AT THE NEXT QUANTIZE UNIT DIVISION.
									;WHEN QUANTIZER BUTTON IS OFF (gkLiveQuantize=0) THIS WILL EFFECTIVELY DISABLE THIS MECHANISM.

	;THE SOUND PRODUCING PART OF THE INSTRUMENT
	icps		cpsmidi						;READ IN NOTE PITCH
	ivel		veloc	0,1					;READ IN KEY VELOCITY
	aenv	expsegr	0.0001, 0.01, 1, p3-0.01, 0.0001		;SIMPLE ENVELOPE WITH A RELEASE SEGMENT	
	a1	vco2	ivel/3, icps, 4, (ivel/2)+0.5			;VCO WAVEFORM GENERATOR. VELOCITY->PULSE WIDTH
		out	a1*aenv						;SEND AUDIO TO OUTPUT.
	PAUSE:
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>