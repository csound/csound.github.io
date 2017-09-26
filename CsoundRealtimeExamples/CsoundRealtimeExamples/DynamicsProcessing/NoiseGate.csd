NoiseGate.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -b128 -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		OPCODE | LABEL         | WIDTH | HEIGHT | X | Y
		FLpanel	"Simple Gate",    500,    350,    0,  0

;HANDLE		OPCODE	"LABEL" | WIDTH | HEIGHT | POS_X | POS_Y
idgain		FLvalue	" ",       100,     18,     5,       25
idthresh	FLvalue	" ",       100,     18,     5,       75
idatt		FLvalue	" ",       100,     18,     5,      125
idrel		FLvalue	" ",       100,     18,     5,      175
iddelay 	FLvalue	" ",       100,     18,     5,      225
idatten 	FLvalue	" ",       100,     18,     5,      275

;SLIDERS								MIN  |  MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  |  Y
gkgain, ihgain			FLslider	"Input Gain Control",	0,        5,   0,    23,   idgain,     490,     25,    5,     0
gkthresh, ihthresh		FLslider	"Threshold", 		-90,      0,   0,    23,   idthresh,   490,     25,    5,    50
gkatt, ihatt			FLslider	"Attack Time",		0.0001,   2,   0,    23,   idatt,      490,     25,    5,   100
gkrel, ihrel			FLslider	"Release Time",		0.0001,   2,   0,    23,   idrel,      490,     25,    5,   150
gkdelay, ihdelay		FLslider	"Delay",		0.0001,   2,   0,    23,   iddelay,    490,     25,    5,   200
gkatten, ihatten		FLslider	"Attenuation",		-90,      0,   0,    23,   idatten,    490,     25,    5,   250

gkmeter, gihmeter		FLslider 	"Meter",		-90,      0,   0,     1,   -1,         490,     25,    5,   300
FLsetColor2	0, 255, 0, gihmeter	;COLOURIZE METERS (GREEN)

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
		FLsetVal_i	   	1,      ihgain
		FLsetVal_i	   	-30,  ihthresh
		FLsetVal_i	   	0.01,    ihatt
		FLsetVal_i	   	0.1,     ihrel
		FLsetVal_i	   	0.01,  ihdelay
		FLsetVal_i	   	-40,  ihatten

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     320,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          Noise Gate                         ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"In this example the 'rms' opcode is used to track the        ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"amplitude of audio signal. This amplitude is converted to    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"decibels and compared to a threshold value, if it is below   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"this value the audio signal is attenuated by a defined amount", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"of decibels.                                                 ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Rather than opening and closing instantly (which would create", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"unpleasant discontinuities in the audio signal), an attack   ", 	1,      5,     14,    490,    20,     5, 160        
ih		 	FLbox  	"time defines how quickly the gate opens and a release time   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"how quickly it closes. The attack of percussive instruments  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"can sometimes be lost in the time it takes the gate to open  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"so the audio signal to which the gate is applied can be      ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"delayed by a small amount of time to prevent this. The audio ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"which is scanned in the first place is always the undelayed  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"signal.                                                      ", 	1,      5,     14,    490,    20,     5, 300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 	1
	aL 		inch		1	;READ AUDIO FROM LEFT CHANNEL INPUT
	aL		=		aL * gkgain		;AUDIO SIGNALS ARE SCALED BY THE FLTK GAIN CONTROL
	kRMS		rms		aL			;RMS (ROOT MEAN SQUARE) OF THE AUDIO SIGNAL IS SCANNED
	kdB		=		dbamp(kRMS)		;RMS OF AMPLITUDE IS CONVERTED TO DECIBELS
	ktrig		metro		10			;UPDATE RATE OF THE LEVEL METER
			FLsetVal	ktrig, kdB, gihmeter	;UPDATE AMPLITUDE METER
	kgate		=		(kdB<gkthresh?gkatten:0)	;CREATE A GATE SIGNAL (EITHER 1 OR ZERO DEPENDING UPON COMPARISON WITH THE THRESHOLD VALUE
	ktime		=		(kdB<gkthresh?gkrel:gkatt)	;GATE STATE CHANGE TIME IS DEFINED DEPENDING ON WHETHER THE GATE SHOULD BE CLOSED OR OPEN
	kgate		portk		kgate,ktime		;SMOOTH THE OPENING AND CLOSING OF THE GATE TO PREVENT CLICKS
	aL		vdelay		aL,gkdelay,2		;DELAY THE AUDIO SIGNAL BEFORE SENDING IT TO THE OUTPUT
			out		aL*ampdb(kgate)		;SEND AUDIO TO THE OUTPUT AND APPLY THE GATING SIGNAL (CONVERTED TO AMPLITUDE)
endin
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 IS ACTIVE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>