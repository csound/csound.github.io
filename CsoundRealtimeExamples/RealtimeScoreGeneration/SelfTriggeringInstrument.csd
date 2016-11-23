SelfTriggeringInstrument.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH
zakinit		1,64	;DECLARE ZAK SPACE (ONLY K/I-RATE SPACE WILL BE NEEDED)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 255, 50
;			LABEL                          | WIDTH | HEIGHT | X | Y
		FLpanel	"Self Triggering Instrument",     500,    400,    0,  0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihlims		 	FLbox  	" ", 	6,      9,     15,    496,     98,    2, 150	;NOTE LIMITS SUB-PANEL
FLsetColor	255,205,200, ihlims	;SET COLOUR FOR NOTE LIMITS SUB-PANEL

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Start Arpeggio",	1,    1,    21,    180,     25,    5,  5,    0,      1,      0,      3600
gkOnOff,ihOnOff		FLbutton	"Stop All Arpeggios",	0,    0,    21,    180,     25,  190,  5,    0,      1,      0,      0.01

;VALUE_DISPLAY_BOXES		 	WIDTH | HEIGHT | X | Y
idrate			FLvalue	" ",      80,    20,     5,  75
idinterval		FLvalue	" ",      80,    20,     5, 125
idLimLo			FLvalue	" ",      80,    20,     5, 175
idLimHi			FLvalue	" ",      80,    20,     5, 220
iddur			FLvalue	" ",      80,    20,     5, 275

;SLIDERS					            				MIN   | MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkrate,ihrate			FLslider 	"Notes per Second",			0.1,   1000,  -1,    23,   idrate,       490,     25,    5,  50
gkinterval,ihinterval		FLslider 	"Arpeggio Interval (semitones)",	-12,     12,   0,    23,   idinterval,   490,     25,    5, 100
gkLimLo,ihLimLo			FLslider 	"Lower Note Limit (MIDI note val.)",	0,      127,   0,    23,   idLimLo,      490,     20,    5, 155
gkLimHi,ihLimHi			FLslider 	"Upper Note Limit (MIDI note val.)",	0,      127,   0,    23,   idLimHi,      490,     20,    5, 200
gkdur,ihdur			FLslider 	"Note Duration",			0.05,     8,  -1,    23,   iddur,        490,     25,    5, 250
gkdel,ihdel			FLslider 	"Stereo Width",	        		0,     0.01,   0,    23,   -1,           490,     25,    5, 300
gkgain,ihgain			FLslider 	"Amplitude",				0,        1,   0,    23,   -1,           490,     25,    5, 350

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	5, 	ihrate
		FLsetVal_i	8, 	ihinterval
		FLsetVal_i	48, 	ihLimLo
		FLsetVal_i	91.356,	ihLimHi
		FLsetVal_i	0.1, 	ihdur
		FLsetVal_i	0.01, 	ihdel

		FLsetVal_i	0.5, 	ihgain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 780, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Self Triggering Instrument                   ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"When schedkwhen is used to generate a note event it normally ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"triggers an instrument other than the one that contains it.  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"If it is instructed to trigger its own instrument the        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"consequences can be disastrous as the the number of spawned  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"notes quickly explodes. Some method of control can be used to", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"ensure that only one instance of the triggering instrument   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"exists however. In this example the note generating          ", 	1,      5,     14,    490,    20,     5, 160       
ih		 	FLbox  	"instrument is distinguished from the spawned notes by having ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"an integer p1/instrument number, in this case '1'. Spawned   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"notes will have a p1 of '1.1'. Using this distinguishing     ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"characteristic and a conditional interrogation, a certain    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"block of code will be executed if the instrument instance is ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"for note generating and a different block of code will be    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"executed if the instrument instance has been spawned using   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"schedkwhen.                                                  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"This technique might prove useful in creating encapsulated   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"instruments that don't span several instrument blocks.       ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"In this example each note generating instance triggers       ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"streams of spawned notes that form arpeggios. The rate of    ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"note generation, note durations, interval between steps of   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"the arpeggio, and lower and upper limits of the arpeggios can", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"all be controlled. Multiple note generating instances can be ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"initiated by repeatedly clicking the 'Start Arpeggio' button.", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"All arpeggios are stopped when the 'Stop All Arpeggios'      ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"button is clicked.                                           ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"In order to keep track of note sequences for each arpeggio,  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"each note generating instance is allocated a unique voice    ", 	1,      5,     14,    490,    20,     5, 560          
ih		 	FLbox  	"number which is then passed on to its spawned note using p4. ", 	1,      5,     14,    490,    20,     5, 580          
ih		 	FLbox  	"This voice number is used to refer to a zak channel to which ", 	1,      5,     14,    490,    20,     5, 600          
ih		 	FLbox  	"note values are written and retrieved for that arpeggio.     ", 	1,      5,     14,    490,    20,     5, 620          
ih		 	FLbox  	"A stereo effect is added using short delays on each channel. ", 	1,      5,     14,    490,    20,     5, 640          
ih		 	FLbox  	"Note that the maximum rate of note generation is 1000 notes  ", 	1,      5,     14,    490,    20,     5, 660          
ih		 	FLbox  	"per second. If note duration is long and/or many arpeggios   ", 	1,      5,     14,    490,    20,     5, 680          
ih		 	FLbox  	"are running simultaneously then realtime polyphony           ", 	1,      5,     14,    490,    20,     5, 700          
ih		 	FLbox  	"capabilites can easily be exceeded, resulting in buffer      ", 	1,      5,     14,    490,    20,     5, 720          
ih		 	FLbox  	"underruns. Careful control of these parameters can prevent   ", 	1,      5,     14,    490,    20,     5, 740          
ih		 	FLbox  	"this from happening.                                         ", 	1,      5,     14,    490,    20,     5, 760

				FLpanel_end                                                 
                                                                                        
				FLrun	;RUN THE FLTK WIDGET THREAD                 
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	tables                                                                        
giwave	ftgen	0,0,4097,10,1,0,0,0.1,0,0,0.01,0,0,0,0,0.001	;WAVEFORM USED BY AUDIO OSCILLATOR
givoice	init	0						;VOICE NUMBER INITIALISED (EACH ARPEGGIO IS REFFERED TO AS A 'VOICE')
endin

instr	1
	if	gkOnOff=0 then
	  turnoff2	1,0,0	;(ON WINDOWS turnoff DOESN'T SEEM TO WORK PROPERLY IN THIS CONTEXT AT THE MOMENT) 
	endif
	
	;IF THIS IS A NOTE GENERATING INSTANCE (I.E. TRIGGERED BY THE FLTK BUTTON)...
	if round(frac(p1)*10)=0 then						;IF p1 FRACTIONAL PART IS ZERO THIS CAN'T BE A SPAWNED NOTE 
	  ktrig		metro	gkrate						;NOTE GENERATOR METRONOME
	  ivoice	wrap	givoice,0,65					;LIMIT VOICE NUMBER ACCORDING TO ALLOCATED ZAK SPACE (K-SPACE IS USED FOR I-RATE VARIABLE) USING WRAPAROUND IF OUT OF RANGE. 65 VOICES ARE POSSIBLE WHICH SHOULD BE PLENTY
	  schedkwhen	ktrig,0,0,p1+0.1,0,gkdur,ivoice				;SPAWN A NOTE WITH p1 = p1 + 0.1. THIS WILL DISTINGUISH NOTE GENERATING INSTANCES FROM SPAWNED INSTANCES
	  givoice	=	givoice + 1					;INCREMENT VOICE
	  		ziw	i(gkLimLo),ivoice				;WRITE ARPEGGIO STARTING NOTE (LOWER NOTE LIMIT) INTO ZAK CHANNEL FOR THAT VOICE
	endif									;END OF THIS CONDITIONAL BRANCH
	                                                                                              
	;IF THIS IS A SPAWNED NOTE (I.E. TRIGGERED BY SCHEDKWHEN)...
	if round(frac(p1)*10)=1 then						;IF p1 FRACTIONAL PART IS NON-ZERO THIS MUST BE A SPAWNED NOTE
	  inote		zir	p4						;READ NOTE FROM ZAK SPACE
	  aenv		expsega	0.001,0.005,1,p3,0.01,0.001			;PERCUSSIVE AMPLITUDE ENVELOPE
	  asig		poscil	aenv*0.15*i(gkgain),cpsmidinn(inote),giwave	;AUDIO OSCILLATOR
	  aL		delay	asig,rnd(i(gkdel))+0.00002			;SLIGHTLY DELAY AUDIO BY A RANDOM AMOUNT FOR LEFT CHANNEL
	  aR		delay	asig,rnd(i(gkdel))+0.00002			;SLIGHTLY DELAY AUDIO BY A RANDOM AMOUNT FOR RIGHT CHANNEL
	  		outs	aL,aR						;SEND AUDIO TO OUTPUTS
	  inote		=	inote+i(gkinterval)				;INCREMENT NOTE FOR NEXT STEP IN THE ARPEGGIO
	  inote		wrap	inote,i(gkLimLo),i(gkLimHi)			;WRAP NEXT NOTE VALUE AROUND IF IT WOULD OTHERWISE EXCEED THE DEFINED NOTE LIMITS 
	  		ziw	inote,p4					;WRITE VALUE FOR NEXT NOTE IN THE ARPEGGIO INTO ZAK CHANNEL FOR THIS VOICE
	endif									;END OF THIS CONDITIONAL BRANCH
endin

</CsInstruments>

<CsScore>
i "tables" 0 3600
f 0 3600	;DUMMY SCORE EVENT. FACILITATES REALTIME PERFORMANCE FOR UP TO 1 HOUR.
</CsScore>

</CsoundSynthesizer>