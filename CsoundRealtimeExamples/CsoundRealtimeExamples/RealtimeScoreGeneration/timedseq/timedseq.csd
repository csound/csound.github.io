timedseq.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	8
nchnls 	= 	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS                                                  
;							WIDTH | HEIGHT | X | Y
				FLpanel	"timedseq", 	500,     440,   0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        scale.txt                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih                      FLbox   " instr   strt    dur     pch                                 ",        1,      5,     14,    490,    15,     5,  40
ih                      FLbox   "   2      1      0.5     8.00                                ",        1,      5,     14,    490,    15,     5,  60
ih                      FLbox   "   2      1.5    0.5     8.02                                ",        1,      5,     14,    490,    15,     5,  80
ih                      FLbox   "   2      2      0.5     8.04                                ",        1,      5,     14,    490,    15,     5, 100
ih                      FLbox   "   2      2.5    0.5     8.05                                ",        1,      5,     14,    490,    15,     5, 120
ih                      FLbox   "   2      3      0.5     8.07                                ",        1,      5,     14,    490,    15,     5, 140
ih                      FLbox   "   2      3.5    0.5     8.09                                ",        1,      5,     14,    490,    15,     5, 160
ih                      FLbox   "   2      4      0.5     8.11                                ",        1,      5,     14,    490,    15,     5, 180
ih                      FLbox   "   2      4.5    0.5     9.00                                ",        1,      5,     14,    490,    15,     5, 200
ih                      FLbox   "  -1      5      -1      -1                                  ",        1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"-Score-------------------------------------------------------", 	1,      5,     14,    490,    15,     5, 320
ih                      FLbox   "--p1 | p2 | p3 | p4(tempo)                                   ",        1,      5,     14,    490,    15,     5, 340
ih                      FLbox   "i 1    0    4    60    -PLAY PHRASE ONCE AT 60BPM            ",        1,      5,     14,    490,    15,     5, 360
ih                      FLbox   "i 1    5    2    120   -PLAY PHRASE ONCE AT 120BPM           ",        1,      5,     14,    490,    15,     5, 380
ih                      FLbox   "i 1    8    4    240   -PLAY PHRASE FOUR TIMES AT 240BPM     ",        1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5, 420
;VALUE DISPLAY BOXES			iwidth iheight ix,  iy
gidtime			FLvalue	"Time",	40,    20,     10,  260

				FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 		WIDTH | HEIGHT | X | Y
				FLpanel	"timedseq", 	500,     480,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         timedseq                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The 'timedseq' opcode used in conjunction with the           ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"'schedkwhen' opcode allows us create and trigger sequences of", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"note events that are stored in either function tables or in  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"separate text files. The advantage of this over using a .sco ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"file is that we can have random access to multiple scores    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"from a single Csound performance, we can warp the tempo of   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"these score fragments in realtime, we can start from any     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"point from within the score fragment, we can loop phrases    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"etc.                                                         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Score fragments are read by timedseq using a pointer which in", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"this example is created using a 'phasor' opcode.             ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"The sequence file used by this example is 'scale.txt'. It is ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"also printed out on the adjacent panel. The Csound score used", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"by this example is also printed out. There is a hierarchy of ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"scores in that the Csound score is triggering the sequence   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"stored as 'scale.txt' which in turn triggers individual      ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"notes. Time warping of the sequence is determined by the     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"p4 value of Csound score events. Looping is determined by    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"the duration of Csound score event with respect to the tempo ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"dictated by that event.                                      ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"An FLTK number box informs the user of the current time/beat ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"location as the Csound score progresses.                     ", 	1,      5,     14,    490,    15,     5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave		ftgen		0,0,4096,10,1,0,0,1/8,0,1/20,0,0,1/40		;A WAVEFORM
giscale		ftgen 		0,0,128,-23,"scale"				;PHRASE FROM EXTERNAL TEXT FILE

instr	1	;NOTE TRIGGERING INSTRUMENT
	itempo	=	p4				;TEMPO VALUE FROM p4
	kBPS	=	itempo/60			;DERIVE BEATS-PER-SECOND 
	ibeats	=	4				;NUMBER OF BEATS IN LOOP
	kphase    phasor  kBPS/ibeats			;DEFINE PHASOR ACCORDING TO BEATS-PER-SECOND AND NUMBER OF BEAT IN PHRASE
	kpointer	=        kphase*ibeats+0.99	;MULTIPLY PHASE VALUE BY NUMBER OF BEATS, OFFSET BY ALMOST 1 (THIS IS TO ENSURE THE FIRST EVENT ON BEAT ONE IS ALWAYS TRIGGERED)
	kp1		init	0			;INITIALISE P-FIELD VARIABLES
	kp2		init	0       		;INITIALISE P-FIELD VARIABLES
	kp3		init	0       		;INITIALISE P-FIELD VARIABLES
	kp4		init	0       		;INITIALISE P-FIELD VARIABLES
	
	ktrigger   timedseq kpointer, giscale, kp1, kp2,kp3, kp4	;READ CURRENT TRIGGER AND P-FIELDS FROM FUNCTION TABLE
	schedkwhen ktrigger, 0, 0, 2, 0, kp3/kBPS, kp4	;p3 VALUES ARE SCALED ACCORDING TO TEMPO (ALTHOUGH THEY COULD BE LEFT UNSCALED
endin

instr	2	;SOUND GENERATING INSTRUMENT
	aenv	line	1,(p3),0	;AMPLITUDE ENVELOPE
	asig	oscili	0.4*aenv, cpspch(p4), giwave	;OSCILLATOR
	klpf	expon	20000,p3,cpspch(p4)
	asig	butlp	asig,klpf
	asig	butlp	asig,klpf
		out	asig				;SEND AUDIO TO OUTPUT
endin

instr	3	;PRINTS TIME
	ktime 		timeinsts
	ktime		=	int(ktime)
	FLprintk2 	ktime, gidtime
endin	          

</CsInstruments>

<CsScore>
; p1 | p2 | p3 | p4(tempo)
i 1    0    4    60	;PLAY PHRASE ONCE AT 60BPM
i 1    5    2    120	;PLAY PHRASE ONCE AT 120BPM
i 1    8    4    240	;PLAY PHRASE FOUR TIMES AT 240BPM
i 3 0 12	;PRINTS TIME
f 0 300
</CsScore>

</CsoundSynthesizer>