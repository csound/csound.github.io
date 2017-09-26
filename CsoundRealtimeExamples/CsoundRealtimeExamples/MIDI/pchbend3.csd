pchbend3.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
;START REALTIME AUDIO OUT USING THE DEFAULT DEVICE AND OPEN ALL AVAILABLE MIDI INPUT DEVICES
-odac -M8 -dm0
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE
massign	0,0	;DISABLE CSOUNDS DEFAULT MIDI TO INSTRUMENT TRIGGERING

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 255, 50
		FLpanel	"pchbend using midiin", 110,100, 0, 0                   

;SWITCHES                                		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,       1,     0,      -1

;FLTK-COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkBendRange, ihBendRange 	FLcount  "Bend Range (semitones)",	-48,   48,    1,      1,      2,     100,     25,   5, 35,   -1

;INITIALISE VALUATORS		VALUE | HANDLE
		FLsetVal_i	2, 	ihBendRange
                                                                                                                                                   
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                      WIDTH | HEIGHT | X | Y
				FLpanel	"pchbend", 515,    400,  120,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"              Pitch Bend Using the midiin Opcode             ", 	1,      6,     14,    490,    25,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"One caveat of using the 'pchbend' opcode is that the         ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"instrument that contains it must have been triggered from a  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"MIDI note event. To read pitch bend information in           ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"instruments that have not been triggered via MIDI we must use", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"the midiin opcode. In this example Csound's default MIDI     ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"triggering mechanism (notes on channel 1 trigger instr 1,    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"notes on channel 2 trigger instr 2 etc.) is disabled using   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'massign 0,0' in the orchestra header. Instrument 1 is       ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"triggered using the FLTK button. Pitch bend wheel will       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"modulate the pitch of the tone produced by the maximum number", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"of semitones up or down defined by the FLTK counter.         ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"This example has been designed for a Behringer UMA25S, other ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"keyboards may employ different formats for pitch bend        ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"information, in which case you will have to first carry out  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"your own investigations using either a MIDI monitor program  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"or the midiin.csd example also in this section.              ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"You will need to use as external MIDI keyboard with this     ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"example as the virtual device has no pitch bend controller.  ", 	1,      5,     14,    490,    20,     5, 380
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave	ftgen	0,0,4096,10,1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81	;A RICH WAVEFORM

instr	1	; SIMPLE SYNTHESIZER WITH PITCH BEND
	kstatus, kchan, kdata1, kdata2  midiin; read in midi
	if      kstatus=224 then	; conditionally branch when trigger is received and when status byte is something other than zero
	kval	=	(kdata2-64)/32
	endif
	
	kbend	=	kval*gkBendRange	;kbend RESCALED TO COVER SEMITONE RANGE DEMANDED BY FLTK COUNTER
	kbend	=	semitone(kbend)		;CONVERTED TO A RATIO OF TRANSPOSITION
	
	kporttime	linseg	0,0.01,0.01	;A FUNCTION THAT QUICKLY RAMPS UP FROM ZERO TO A HELD VALUE THAT WILL BE USED AS PORTAMENTO TIME
	kbend	portk	kbend,kporttime		;APPLY PORTAMENTO SMOOTHING TO PITCH BEND VARIABLE
		
	;OUTPUT	OPCODE	AMPLITUDE |  FREQUENCY   | FUNCTION_TABLE
	asig	poscil	0.2,      440*kbend,       giwave		;CREATE AUDIO OSCILLATOR
		out	asig			;SEND AUDIO OUTPUT OF OSCILLATOR TO THE OUTPUT
		
	if gkOnOff==0 then
	 turnoff
	endif
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>