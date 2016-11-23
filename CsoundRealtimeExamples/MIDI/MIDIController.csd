MIDIController.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -dm0 
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;INSTRUCTIONS AND INFO PANEL                 	WIDTH | HEIGHT | X | Y
				FLpanel	"ctrl7", 515,    720,    0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"   ctrl7 - Reading Continuous Controller Data into Csound    ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'ctrl7' is the best opcode to use for reading continuous     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"controller data into csound for use as k-rate variables.     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"'ctrl7' allows the user to specify the MIDI channel (1-16)   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"and the controller number (0-127) associated with the        ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"controller.                                                  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Therefore with 128 controllers on 16 different MIDI channels ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"we have the possibility of using 2048 different MIDI         ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"controls. 7 bit MIDI controllers normally output integers    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"within the range 0-127 but with ctrl7 we can rescale this by ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"specifying a different output range.                         ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"In this example MIDI controller 1 on MIDI channel 1 is used  ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"to implement a volume control on the simple synthesizer that ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"has been built up over last few examples. (The modulation    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"wheel on MIDI keyboards is also MIDI controller 1.)          ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"The first thing that is noticed is that this example is      ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"silent until you move controller 1. This is because a        ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"controller always defaults to its minimum value until the    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"controller is moved. (The next example demonstrates how this ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"can be initialised to a value other than the minimum.)       ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Another thing that you may notice is that when moving the    ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"controller is that a clicking noise (sometimes referred to as", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"'zipper' noise) can be heard, particularly when the          ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"controller is moved quickly. What is happening is that the   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"k-rate output of ctrl7 is changing in large steps rather than", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"in a continuously smooth line. If the control rate (kr) is   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"low then this can aggravate the problem. Another factor is   ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"that the resolution of 7 bit controllers is quite low (128   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"possible values). One solution is to use a 14 bit controller ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"and the 'ctrl14' opcode but there are few MIDI controller    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"devices that provide adequate 14 bit controller support.     ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"Another possibility is to interpolate ctrl7's output up to   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"a-rate (ctrl7 can only output at k-rate). Applying portamento", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"to the output variable can also help - this method is        ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"demonstrated in subsequent examples.                         ", 	1,      5,     14,    490,    20,     5, 700
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave	ftgen	0,0,4096,10,1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81

instr	1	; SIMPLE BEEP INSTRUMENT - CAN BE ACTIVATED VIA A CONNECTED MIDI KEYBOARD
	icps	cpsmidi
	iamp	ampmidi 0.2 
	
	;OUTPUT		OPCODE	CHANNEL | CTRLNUMBER | MINIMUM | MAXIMUM
	kvolume		ctrl7	1,            1,          0,        1 	;READ CONTROLLER INFORMATION FROM CONTINUOUS CONTROLLER NUMBER 1 ON MIDI CHANNEL 1 AND RESCALE TO BE WITHIN THE RANGE 0 - 1 
	
	;               INITIAL_LEVEL | ATTACK_TIME | ATTACK_LEVEL | DECAY_TIME | SUSTAIN_LEVEL |  RELEASE_TIME | RELEASE_LEVEL
	aenv	linsegr	      0,           (.01),          1,           (.1),          .7,            (.05),            0 
	
	asig	poscil	iamp,icps,giwave
		out	asig * aenv * kvolume
endin

</CsInstruments>

<CsScore>
f 0 600	; THIS LINE FUNCTIONS AS A DUMMY SCORE EVENT AND ALLOWS REALTIME MIDI PLAYING FOR 10 MINUTES
</CsScore>

</CsoundSynthesizer>