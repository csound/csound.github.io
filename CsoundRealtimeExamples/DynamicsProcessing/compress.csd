compress.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -iadc -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL      | WIDTH | HEIGHT | X | Y
				FLpanel	"compress",   500,    545,    0,  0
;BORDERS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 		6,        9,    15,   490,     40,    5, 500
ih		 	FLbox  	"Presets:", 	1,        4,    16,    60,     20,   20, 510

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    120,     30,    5,   5,     0,     1,      0,      -1
FLsetColor2	255,255,50,ihOnOff
;                                                                                                                                           THRESH | LO-KNEE | HI-KNEE | RATIO | ATT-TIME | REL-TIME | LOOK-TIME | MAKE-UP-GAIN | INPUT | DETECT | IN-GAIN | DET-GAIN
gkpreset1,ihpreset1		FLbutton	"Compressor",	1,    0,    21,     85,     22,  120, 510,     0,     2,      0,      0.01,    0,      48,       60,       5,      0.005,     0.1,       0.1,           7,          1,       1,      0.5,        0
gkpreset2,ihpreset2		FLbutton	"Expander",	1,    0,    21,     85,     22,  210, 510,     0,     2,      0,      0.01,    0,       0,        6,    0.51,      0.001,     0.001,     0.1,      0.00001,          2,       2,      0.5,        0
gkpreset3,ihpreset3		FLbutton	"Noise Gate",	1,    0,    21,     85,     22,  300, 510,     0,     2,      0,      0.01,   80,      48,       60,       1,      0.005,     0.1,       0.1,           1,          0,       0,      0.5,        0
gkpreset4,ihpreset4		FLbutton	"Ducker",	1,    0,    21,     85,     22,  390, 510,     0,     2,      0,      0.01,    0,      48,       60,       5,      0.005,     0.1,       0.1,           1,          3,       0,      1,        0.7
														
;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idthresh			FLvalue	"",        80,    20,     5,125
idloknee			FLvalue	"",        80,    20,     5,175
idhiknee			FLvalue	"",        80,    20,     5,225
idratio				FLvalue	"",        80,    20,     5,275
idatt				FLvalue	"",        80,    20,     5,325
idrel				FLvalue	"",        80,    20,     5,375
idlook				FLvalue	"",        80,    20,     5,425
idgain				FLvalue	"",        80,    20,     5,475

;SLIDERS					            			MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkInGain,gihInGain		FLslider 	"Live Input Gain",		0,      1,   0,    23,   -1,         180,     12,    5,  40
gkDetGain,gihDetGain		FLslider 	"Detect Sig. Gain",		0,      1,   0,    23,   -1,         180,     12,    5,  68
gkthresh,gihthresh		FLslider 	"Noise Gate Threshold (dB)",	0,    120,   0,    23,   idthresh,   490,     25,    5, 100
gkloknee,gihloknee		FLslider 	"Low Knee Break Point (dB)",	0,    100,   0,    23,   idloknee,   490,     25,    5, 150
gkhiknee,gihhiknee		FLslider 	"High Knee Break Point (dB)",	0,    100,   0,    23,   idhiknee,   490,     25,    5, 200
gkratio,gihratio		FLslider 	"Ratio",			0.125,100,  -1,    23,   idratio,    490,     25,    5, 250
gkatt,gihatt			FLslider 	"Attack Time (secs.)",		0.001,  1,  -1,    23,   idatt,      490,     25,    5, 300
gkrel,gihrel			FLslider 	"Release Time (secs.)",		0.001,  1,  -1,    23,   idrel,      490,     25,    5, 350
gklook,gihlook			FLslider 	"Look Ahead Time (secs.)",	0,      1,   0,    23,   idlook,     490,     25,    5, 400
gkgain,gihgain			FLslider 	"Make Up Gain",			0.00001,10000,-1,    23,   idgain,     490,     25,    5, 450

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, gihinput		FLbutBank	14,     1,     4,     18,      80,   200, 0,   -1
gkdetect, gihdetect		FLbutBank	14,     1,     4,     18,      80,   400, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input:", 	1,       5,    14,     50,      20, 150,   0
ih		 	FLbox  	"Live     ", 	1,       5,    14,     75,      20, 220,   0
ih		 	FLbox  	"Drum Loop", 	1,       5,    14,     75,      20, 220,  20
ih		 	FLbox  	"Vocal    ", 	1,       5,    14,     75,      20, 220,  40
ih		 	FLbox  	"Synth Pad", 	1,       5,    14,     75,      20, 220,  60
ih		 	FLbox  	"Detect:", 	1,       5,    14,     50,      20, 350,   0
ih		 	FLbox  	"Live     ", 	1,       5,    14,     75,      20, 420,   0
ih		 	FLbox  	"Drum Loop", 	1,       5,    14,     75,      20, 420,  20
ih		 	FLbox  	"Vocal    ", 	1,       5,    14,     75,      20, 420,  40
ih		 	FLbox  	"Synth Pad", 	1,       5,    14,     75,      20, 420,  60

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.5, 	gihInGain
				FLsetVal_i	0, 	gihthresh
				FLsetVal_i	48, 	gihloknee
				FLsetVal_i	60, 	gihhiknee
				FLsetVal_i	1, 	gihratio
				FLsetVal_i	0.005, 	gihatt
				FLsetVal_i	0.1, 	gihrel
				FLsetVal_i	0.1, 	gihlook
				FLsetVal_i	1, 	gihgain
				FLsetVal_i	1, 	gihinput
				FLsetVal_i	1, 	gihdetect
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 500, 512, 0
				FLscroll     515, 500, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         compress                            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'compress' is an opcode for dynamic processing of an audio   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"signal. The signal used by the detector does not have to be  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"the same as the signal to which dynamics processing is       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"applied thus enabling the effect 'ducking' heard commonly in ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"radio where the DJ cutting in with an announcement causes a  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"dynamic dip in the music sound-bed.                          ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"'compress' incorporates a noise gate, the threshold of which ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"is controlled with the 'Noise Gate Threshold' slider. The    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"'Attack Time' and 'Release Time' sliders control the attack  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"and release times of both the noise gate and the compressor. ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'Ratio' controls the amount of compression or expansion that ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"will be applied. Values greater than 1 will apply higher     ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"degrees of compression, values less than 1 will dynamically  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"expand the signal increasingly, a ratio of 1 will leave the  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"signal unaltered.                                            ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"'Look Ahead Time' defines how far ahead the detector scans in", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"order to pre-empt dynamic changes. What actually happens is  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"that the signal to which dynamics processing is applied is   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"delayed with respect to the detection signal but the result  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"is the same.                                                 ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"In this implementation the user can independently select the ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"audio signal from which dynamics will be detected and the    ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"signal to which dynamics processing will be applied.         ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"The 'Detect Sig. Gain' slider allows the user to mix the     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"detected signal into the output along with the compressed    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"signal.                                                      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"A number of presets are provided to demonstrate some basic   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"applications of this opcode.                                 ", 	1,      5,     14,    490,    20,     5, 580
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1
	if gkOnOff=0 then
		turnoff
	endif

	if gkinput=0 then
		aasigL, aasigR	ins
		aasigL	=	aasigL*gkInGain
		aasigR	=	aasigR*gkInGain
	elseif gkinput=1 then
		aasigL, aasigR	diskin2	"808loop.wav",1,0,1
	elseif gkinput=2 then
		aasigL		diskin2	"AndItsAll.wav",1,0,1
		aasigR	=	aasigL
	elseif gkinput=3 then
		aasigL, aasigR	diskin2	"SynthPad.wav",1,0,1
	endif
	
	if gkdetect=0 then
		acsigL, acsigR	ins
		acsigL	=	acsigL*gkInGain
		acsigR	=	acsigR*gkInGain
	elseif gkdetect=1 then
		acsigL, acsigR	diskin2	"808loop.wav",1,0,1
	elseif gkdetect=2 then
		acsigL		diskin2	"AndItsAll.wav",1,0,1
		acsigR	=	acsigL
	elseif gkdetect=3 then
		acsigL, acsigR	diskin2	"SynthPad.wav",1,0,1
	endif
	
	ktrig	changed	gklook
	if ktrig=1 then
		reinit	UPDATE
	endif
	UPDATE:
	;ar 	compress 	aasig, acsig,  kthresh,  kloknee,  khiknee,  kratio,  katt,  krel, ilook
	aCompL	compress	aasigL, acsigL, gkthresh, gkloknee, gkhiknee, gkratio, gkatt, gkrel, i(gklook)
	aCompR	compress	aasigR, acsigR, gkthresh, gkloknee, gkhiknee, gkratio, gkatt, gkrel, i(gklook)
	rireturn
		outs	(aCompL*gkgain)+(acsigL*gkDetGain), (aCompR*gkgain)+(acsigR*gkDetGain)
endin

instr	2	;PRESETS
	FLsetVal_i	p4, 	gihthresh
	FLsetVal_i	p5, 	gihloknee
	FLsetVal_i	p6, 	gihhiknee
	FLsetVal_i	p7, 	gihratio
	FLsetVal_i	p8, 	gihatt
	FLsetVal_i	p9, 	gihrel
	FLsetVal_i	p10, 	gihlook
	FLsetVal_i	p11, 	gihgain
	FLsetVal_i	p12, 	gihinput
	FLsetVal_i	p13, 	gihdetect
	FLsetVal_i	p14, 	gihInGain
	FLsetVal_i	p15, 	gihDetGain
endin
  	
</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>