RingModulationAmplitudeModulation.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	128	;CONTROL RATE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL                                    | WIDTH | HEIGHT | X | Y
	FLpanel	"Amplitude Modulation / Ring Modulation",   500,    360,    0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,   498,   108,     1,  1	;CARRIER
ih		 	FLbox  	" ", 	6,        9,    15,   498,   108,     1,123	;MODULATOR
ih		 	FLbox  	" ", 	6,        9,    15,   498,   108,     1,244	;OUTPUT

;TEXT BOXES						ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"INPUT SIGNAL",		1,        2,    12,     90,    20,     5,  4
ih		 	FLbox  	"(CARRIER)",		1,        2,    12,     90,    20,     5, 24
ih		 	FLbox  	"MODULATOR",		1,        2,    12,     90,    20,     5,130
ih		 	FLbox  	"OUTPUT",		1,        2,    12,     90,    20,     5,250

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idOscFrq		FLvalue	" ",	 50,      16,  210,  40
idModFrq		FLvalue	" ",	 70,      20,  100, 205
idDryWet		FLvalue	" ",	 70,      20,  100, 275
idOutGain		FLvalue	" ",	 70,      20,  100, 325

;SLIDERS				            		MIN   |  MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X  | Y
gkInGain, ihInGain	FLslider 	"Input Gain",		0,         1,   0,    5,         -1,    250,     10,   210,  5
gkOscFrq, ihOscFrq	FLslider 	"Sine Tone Frequency",	1,     10000,  -1,    5,   idOscFrq,    250,     10,   210, 30
gkModFrq, ihModFrq	FLslider 	"Modulation Frequency",	1,     15000,  -1,   25,   idModFrq,    390,     25,   100,180
gkDryWet, ihDryWet	FLslider 	"Dry/Wet Mix",		0,         1,   0,   25,   idDryWet,    390,     25,   100,250
gkOutGain, ihOutGain	FLslider 	"Output Gain",		0,         1,   0,   25,   idOutGain,   390,     25,   100,300

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE
FLcolor2	255, 255, 50		;SET SECONDARY COLOUR TO YELLOW
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput	FLbutBank	12,     1,     4,     30,    100,   100,  5,   -1
gkAM_RM,   ihAM_RM	FLbutBank	12,     1,     2,     30,     50,   100,125,   -1
gkwave,   ihwave	FLbutBank	12,     1,     2,     30,     50,   300,125,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	477, 	ihOscFrq
			FLsetVal_i	350, 	ihModFrq
			FLsetVal_i	  1, 	ihDryWet
			FLsetVal_i	0.7, 	ihOutGain
			FLsetVal_i	  1, 	ihAM_RM

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       5,    12,    70,      25,  132,   5
ih		 	FLbox  	"Sine Tone ", 		1,       5,    12,    70,      25,  132,  30
ih		 	FLbox  	"Drum Loop ", 		1,       5,    12,    70,      25,  132,  55
ih		 	FLbox  	"Songpan   ", 		1,       5,    12,    70,      25,  132,  80
ih		 	FLbox  	"Amplitude Modulation",	1,       5,    12,   150,      25,  130, 125
ih		 	FLbox  	"Ring Modulation     ", 1,       5,    12,   150,      25,  130, 150
ih		 	FLbox  	"Sine    ",		1,       5,    12,    70,      25,  330, 125
ih		 	FLbox  	"Triangle", 		1,       5,    12,    70,      25,  330, 150

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           Amplitude Modulation / Ring Modulation            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"When the frequency of amplitude modulation of an audio signal", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"enters the domain of audible frequecies we cease to perceive ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"a rising and falling amplitude but instead perceive the      ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"emergence of sideband tones. The frequencies of these tones  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"will be determined by the frequencies of the two input       ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"signals and by the waveform used for modulation. These       ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"sideband tones will be most clearly discernible when the     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"source sound (carrier) and modulating waveforms are both sine", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"tones.                                                       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"Ring modulation is a variation of amplitude modulation in    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"which the modulating signal is bipolar as opposed to         ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"unipolar. In ring modulation the amplitude of the input      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"signal is effectively being modulated by a rectified sine    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"wave (the perceived modulations in amplitude therefore being ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"twice the frequency of those from a unipolar modulating      ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"signal) - but the signal also becomes inverted when the      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"modulating signal enters the negative domain.                ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"Ring modulation derives its name from the 'ring' formation of", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"four diodes in its original analog implementation, not from  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"its ability to imbue a source signal with a 'ringing'        ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"characteristic.                                              ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"In amplitude modulation between sine waves the frequency of  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"the carrier wave is present at the output and just a single  ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"sideband is created equivalent to the sum of the input       ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"frequencies.                                                 ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"In ring modulation the frequency of the carrier wave is not  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"present at the output and two sidebands are created          ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"equivalent to the sum and difference of the input            ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"frequencies.                                                 ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"In amplitude modulation and ring modulation synthesis and    ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"signal processing, the source signal is referred to as the   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"'carrier' and the modulation waveform as the 'modulator'.    ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"In this example the user can choose between an amplitude     ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"modulation effect and a ring modulation effect. The user can ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"also choose between one of four source signals.              ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"As well as modulating the source signal with a sine wave,    ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"which is the more common practice, the user can also choose a", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"triangle wave as the modulating waveform.                    ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"Ring modulation is a classic electronic effect employed in   ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"the past by some of the giants of electronic music such as   ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"Karlheinz Stockhausen and the Daleks.                        ", 	1,      5,     14,    490,    20,     5, 840

				FLscrollEnd

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	1,0,4097,10,1				;A SINE WAVE
gicos	ftgen	1,0,4097,11,1				;A SINE WAVE
gitri	ftgen	2,0,4097,7,0,1024,-1,2048,1,1024,0	;A TRIANGLE WAVE

instr 		1	;THIS INSTRUMENT GENERATES AN AUDIO STREAM FROM A SOUND FILE AND THE LIVE INPUT, CONVERTS THE CHOSEN STREAM INTO AN FSIG, APPLIES THE pvsfreeze OPCODE, RESYNTHESIZES ITS OUTPUT AS AN AUDIO SIGNAL AND SENDS THE OUTPUT TO THE SPEAKERS
	if gkinput=0	then					;IF FLTK INPUT BUTTON 1 IS SELECTED (LIVE AUDIO IN)
		asig	inch	1				;READ AUDIO FROM INPUT CHANNEL 1 (LEFT)
		asig	=	asig * gkInGain			;RESCALE LIVE AUDIO INPUT AUDIO	WITH FLTK 'InGain' SLIDER
	elseif	gkinput=1	then				;IF FLTK INPUT BUTTON 2 IS SELECTED (SINE TONE)
		asig	oscili	10000,gkOscFrq,gisine		;CREATE A SINE TONE OSCILLATOR
	elseif	gkinput=2	then				;IF FLTK INPUT BUTTON 3 IS SELECTED (DRUM LOOP)
		asig,aR	diskin2 "808loop.wav",1,0,1		;READ '808Loop.wav' FROM DISK
	else							;ONLY OTHER OPTION IS IF FLTK BUTTON 4 IS SELECTED (SONPAN)
		asig,aR	diskin2 "Songpan.wav",1,0,1		;READ 'Songpan.wav' FROM DISK
	endif							;END OF CONDITIONAL BRANCHING
	
	if	gkAM_RM=0	then				;IF 'Amplitude Modulation' IS SELECTED

		amod	oscilikt	0.5,gkModFrq,gkwave+1	;CREATE 'Amplitude Modulation' WAVEFORM
		amod	=	amod + 0.5			;OFFSET 'Amplitude Modulation' WAVEFORM
	else							;ONLY OTHER OPTION IS IF 'Ring Modulation' IS SELECTED
		;amod	oscilikt	1,gkModFrq,gkwave+1	;CREATE RING MODULATION OSCILLATOR
		kpow	randomi		0,0.9,0.3,1
		amod	gbuzz		1,gkModFrq,40,1,kpow,gicos

	endif							;END OF CONDITIONAL BRANCHING
	
	aModSig	=	asig*amod				;MULTIPLY INPUT SIGNAL BY MODULATION SIGNAL
	amix	ntrpol	asig, aModSig, gkDryWet			;CREATE DRY/WET MIXED SIGNAL
	outs	amix * gkOutGain, amix * gkOutGain		;SEND DRY/WET MIXED AUDIO SIGNAL TO OUTPUTS AND RESCALE USING 'gkOutGain' ON-SCREEN FLTK SLIDER
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTR 1 PLAYS FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>