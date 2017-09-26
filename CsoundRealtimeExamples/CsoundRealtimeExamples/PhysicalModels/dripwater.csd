;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y                                          
		FLpanel	"dripwater",   500,     500,   0,  0
                                              
;BUTTONS                       	                              	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM |  DUR
gk1Drip, ih1Drip	FLbutton	"Single Drip",		1,    0,    21,    200,     30,    20, 10,    0,     2,      0,       -1
gkOnOff, ihOnOff	FLbutton	"Turn the Tap On/Off",	1,    0,    22,    200,     30,   280, 10,    0,     1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp		FLvalue	" ",    80,       18,    5,  75
iddettack	FLvalue	" ",    80,       18,    5, 125
idnum		FLvalue	" ",    80,       18,    5, 175
iddamp		FLvalue	" ",    80,       18,    5, 225
idmaxshake	FLvalue	" ",    80,       18,    5, 275
idfreq		FLvalue	" ",    80,       18,    5, 325
idfreq1		FLvalue	" ",    80,       18,    5, 375
idfreq2		FLvalue	" ",    80,       18,    5, 425
idtimedelta	FLvalue	" ",    80,       18,    5, 475

;SLIDERS				     						MIN  |  MAX  |  EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider	"Amplitude",				0,       1,      0,    23,   idamp,        490,     25,    5,  50
gkdettack, ihdettack		FLslider	"idettack (i-rate)",			.001,      1,  -1,     23,   iddettack,    490,     25,    5, 100
gknum, ihnum			FLslider	"Number of Drips (i-rate)",		.0001,   100,   0,     23,   idnum,        490,     25,    5, 150
gkdamp, ihdamp			FLslider	"Damping (i-rate)",			0,         2,   0,     23,   iddamp,       490,     25,    5, 200
gkmaxshake,ihmaxshake		FLslider 	"Energy Feedback (i-rate)",		0,         1,   0,     23,   idmaxshake,   490,     25,    5, 250
gkfreq,ihfreq			FLslider 	"Main Resonant Frequency (i-rate)",  	200,    8000,  -1,     23,   idfreq,       490,     25,    5, 300
gkfreq1,ihfreq1			FLslider 	"1st Resonant Frequency (i-rate)",  	200,    8000,  -1,     23,   idfreq1,      490,     25,    5, 350
gkfreq2,ihfreq2			FLslider 	"2nd Resonant Frequency (i-rate)",  	200,    8000,  -1,     23,   idfreq2,      490,     25,    5, 400
gktimedelta,ihtimedelta		FLslider 	"Drip Speed (i-rate)",  		2,        .1,   0,     23,   idtimedelta,  490,     25,    5, 450

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.2, 	ihamp
		FLsetVal_i	.01, 	ihdettack
		FLsetVal_i	10, 	ihnum
		FLsetVal_i	0, 	ihdamp
		FLsetVal_i	0, 	ihmaxshake
		FLsetVal_i	450, 	ihfreq
		FLsetVal_i	600, 	ihfreq1
		FLsetVal_i	750, 	ihfreq2
		FLsetVal_i	.5, 	ihtimedelta

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        dripwater                            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"dripwater is a semi-physical model of dripping water.        ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"It is one of the PhISEM percussion opcodes. PhISEM           ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"(Physically Informed Stochastic Event Modeling) is an        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"independent sound producing objects.                         ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Sustained textures are possible if internal damping is set   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"at maximum (i.e. internal damping is insufficient to         ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"eventually stop the movement of the beads).                  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"In this example two methods of triggering the opcode are     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"offered. The first is triggered using the button labelled    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'single drip' and triggers a single cluster of drips. The    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"second is triggered with the on/off switch labelled 'Turn the", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"Tap On/Off' and triggers (through the use of the schedkwhen  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"opcode) a continuous sequence of rhythmically spaced clusters", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"of drips. The time gap between drip clusters is controlled   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"using the 'Drip Speed' slider.                               ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"This opcode produces quite erratic amplitude levels so it is ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"advisable to set the amplitude slider quite low to allow some", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"headroom.                                                    ", 	1,      5,     14,    490,    20,     5, 400

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;TRIGGERS RECURRENT DRIPPING
	; SENSE FLTK ON/OFF SWITCH
	if		gkOnOff=0	then
		turnoff
	endif
	;	 			ktrigger, kmintim,    kmaxnum, kinsnum, kwhen, kdur
			schedkwhen 	    1,   gktimedelta,    0,       2,      0,    -1
endin

instr	2	;DRIPWATER INSTRUMENT
	adripwater 	dripwater 	gkamp, i(gkdettack) , i(gknum), i(gkdamp) , i(gkmaxshake), i(gkfreq) , i(gkfreq1), i(gkfreq2)
		outs 		adripwater, adripwater
endin

</CsInstruments>

<CsScore>
f 0 3600	; ALLOWS REALTIME MIDI PLAYING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>