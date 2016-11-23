SchedkwhenGranulation.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0	;DISPLAYS CAN BE RATHER DENSE SO ARE SUPPRESSED
</CsOptions>

<CsInstruments>

sr 	= 	44100
ksmps 	= 	32
nchnls 	= 	2
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	FLpanel	"Schedkwhen Granulation", 1000, 750, 0, 0
FLcolor	250, 250, 250, 100, 100, 100

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihmainpanel	 	FLbox  	"", 	6,      9,     15,    500,   190,     0,   1	;MAIN
ihreverbpanel	 	FLbox  	"", 	6,      9,     15,    500,    75,     0, 640	;REVERB
ihpointerpanel	 	FLbox  	"",	6,      9,     15,    500,   230,     0, 200	;POINTER
ihdenssizepanel	 	FLbox  	"",	6,      9,     15,    500,   180,     0, 440	;GRAIN DENSITY AND SIZE
ihenvelopepanel	 	FLbox  	"",	6,      9,     15,    500,   180,   500,   5	;GRAIN ENVELOPE
ihpitchpanel	 	FLbox  	"",	6,      9,     15,    500,   130,   500, 195	;GRAIN PITCH
ihRMpanel	 	FLbox  	"",	6,      9,     15,    500,   135,   500, 335	;GRAIN-BY-GRAIN RING MODULATION
ihBPFpanel	 	FLbox  	"",	6,      9,     15,    500,   125,   500, 480	;GRAIN-BY-GRAIN BAND-PASS FILTERING 
ihfiltpanel	 	FLbox  	"",	6,      9,     15,    500,   135,   500, 610	;GLOBAL FILTER

;TEXT BOXES								TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ihreverblabel	 	FLbox  	"Reverb",				1,       4,    15,    65,      25,    5,  642
ihpointerlabel	 	FLbox  	"Grain Pointer",			1,       4,    15,   105,      25,    5,  202
ihdenssizelabel	 	FLbox  	"Grain Density and Grain Size",		1,       4,    15,   215,      25,    5,  442
ihenvelopelabel	 	FLbox  	"Grain Envelope",			1,       4,    15,   125,      25,  505,    7
ihpitchlabel	 	FLbox  	"Grain Pitch",				1,       4,    15,   105,      25,  505,  197
ihRMlabel	 	FLbox  	"Grain-by-Grain Ring Modulation",	1,       4,    15,   230,      25,  505,  337
ihBPFlabel	 	FLbox  	"Grain-by-Grain Band-pass Filtering",	1,       4,    15,   250,      25,  505,  485
ihfiltlabel	 	FLbox  	"Global Filtering",			1,       4,    15,   110,      25,  505,  613

;COLOURIZE PANELS 	RED | GREEN | BLUE |  HANDLE
FLsetColor 		190,   190,   150,  ihmainpanel
FLsetColor 		230,   150,   150,  ihreverbpanel
FLsetColor 		230,   150,   150,  ihreverblabel
FLsetColor 		230,   230,   100,  ihpointerpanel
FLsetColor 		230,   230,   100,  ihpointerlabel
FLsetColor 		200,   230,   230,  ihdenssizepanel
FLsetColor 		200,   230,   230,  ihdenssizelabel
FLsetColor 		230,   200,   230,  ihenvelopepanel
FLsetColor 		230,   200,   230,  ihenvelopelabel
FLsetColor 		230,   230,   200,  ihpitchpanel
FLsetColor 		230,   230,   200,  ihpitchlabel
FLsetColor 		150,   230,   150,  ihRMpanel
FLsetColor 		150,   230,   150,  ihRMlabel
FLsetColor 		150,   250,   250,  ihBPFpanel
FLsetColor 		150,   250,   250,  ihBPFlabel
FLsetColor 		250,   150,   250,  ihfiltpanel
FLsetColor 		250,   150,   250,  ihfiltlabel

;BUTTONS                                               	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | DUR | p4 | p5
gkOnOff,ihOnOff		FLbutton	"On/Off(MIDI)",	1,    0,    22,    150,    25,     5,  5,     0,     1,     0,     -1
gkRvbOnOff,ihRvbOnOff	FLbutton	"On/Off",	1,    0,    22,     80,    20,   410,650,    -1
gkRMOnOff,ihRMOnOff	FLbutton	"On/Off",	1,    0,    22,     80,    20,   910,342,    -1
gkBPFOnOff,ihBPFOnOff	FLbutton	"On/Off",	1,    0,    22,     80,    20,   910,487,    -1
gkFiltOnOff,ihFiltOnOff	FLbutton	"On/Off",	1,    0,    22,     80,    20,   910,618,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihRvbOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihRMOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihBPFOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihFiltOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUATOR OUTPUT DISPLAY BOXES				WIDTH | HEIGHT |  X   | Y
idgain			FLvalue	" ",     	70,       17,     5,    65
idampdepth		FLvalue	" ",     	70,       17,     5,   115
idwidth			FLvalue	" ",     	70,       17,     5,   165
idptr			FLvalue	" ",     	70,       17,     5,   255
idptr_OS		FLvalue	" ",     	70,       17,     5,   305 
idLFOamp		FLvalue	" ",     	70,       17,     5,   355 
idLFOfrq		FLvalue	" ",     	70,       17,     5,   405
idGPS			FLvalue	" ",     	70,       17,     5,   495
idgap_OS		FLvalue	" ",     	70,       17,     5,   545
iddurMin		FLvalue	" ",     	70,       17,     5,   595
iddurMax		FLvalue	" ",     	70,       17,   405,   595
idatt			FLvalue	" ",     	70,       18,    505,   60
iddec			FLvalue	" ",     	70,       18,    505,  110
idEnvType		FLvalue	" ",     	70,       18,    505,  160
idoct			FLvalue	" ",     	70,       18,    505,  250
idrndoctavemin		FLvalue	" ",     	50,       18,    750,  250
idrndoctavemax		FLvalue	" ",     	50,       18,    945,  250                                           
idpchosrange		FLvalue	" ",     	70,       18,    505,  300
idRMmix			FLvalue	" ",     	70,       18,    505,  395
idRMfreqmin		FLvalue	" ",     	70,       18,    505,  445
idRMfreqmax		FLvalue	" ",     	70,       18,    905,  445
idHPFcf			FLvalue	" ",     	70,       18,    505,  670
idLPFcf			FLvalue	" ",     	70,       18,    505,  720

;SLIDERS				            				MIN   |   MAX   |   EXP | TYPE |   DISP     | WIDTH | HEIGHT |  X  | Y
gkgain,ihgain			FLslider 	"Output Amplitude",		0,	    1,       0,   23,   idgain,        490,     25,     5,   40
gkampdepth,ihampdepth		FLslider 	"Amplitude Random Offset", 	0,          1,       0,   23,   idampdepth,    490,     25,     5,   90
gkwidth,ihwidth			FLslider 	"Random Panning Amount", 	0,    	   .5,       0,   23,   idwidth,       490,     25,     5,  140
gkptr,ihptr			FLslider 	"Pointer",		 	0,          1,       0,   23,   idptr,         490,     25,     5,  230
gkptr_OS,ihptr_OS		FLslider 	"Grain Pointer Offset", 	0,         .5,       0,   23,   idptr_OS,      490,     25,     5,  280
gkLFOamp,ihLFOamp		FLslider 	"Pointer LFO Amplitude",	0,          1,       0,   23,   idLFOamp,      490,     25,     5,  330                                                                                                                                             
gkLFOfrq,ihLFOfrq		FLslider 	"Pointer LFO Frequency",	.00001,     1,      -1,   23,   idLFOfrq,      490,     25,     5,  380
gkGPS,ihGPS			FLslider 	"Grains per Second",	 	0.5,	 1000,      -1,   23,   idGPS,         490,     25,     5,  470
gkgap_OS,ihgap_OS		FLslider 	"Grain Gap Jitter",		0,	    2,       0,   23,   idgap_OS,      490,     25,     5,  520
gkdurMin,ihdurMin		FLslider 	" ",	 			.003,	    1,      -1,   23,   iddurMin,      490,     13,     5,  570
gkdurMax,ihdurMax		FLslider 	"Grain Duration",	 	.003,	    1,      -1,   23,   iddurMax,      490,     13,     5,  583
gkatt,ihatt			FLslider 	"Attack",		 	.0001,	0.999,       0,   23,   idatt,         490,     25,   505,   35
gkdec,ihdec			FLslider 	"Decay",		 	.0001,  0.999,       0,   23,   iddec,         490,     25,   505,   85
gkEnvType,ihEnvType		FLslider 	"Envelope Lin:Exp",	 	0,	    1,       0,   23,   idEnvType,     490,     25,   505,  135
gkoct,ihoct			FLslider 	"Pitch (oct)", 			-3,         3,       0,   23,   idoct,         245,     25,   505,  225
gkrndoctavemin,ihrndoctavemin	FLslider 	" ", 		 		-3,         3,       0,   23,   idrndoctavemin,245,     13,   750,  225
gkrndoctavemax,ihrndoctavemax	FLslider 	"Random Octave",	 	-3,         3,       0,   23,   idrndoctavemax,245,     13,   750,  238
gkpchosrange,ihpchosrange	FLslider 	"Pitch Offset Range (Octaves)",	0,	    3,       0,   23,   idpchosrange,  490,     25,   505,  275
gkRMmix,gihRMmix		FLslider 	"Mix",		 		0,	    1,       0,   23,   idRMmix,       490,     25,   505,  370
gkRMfreqmin,gihRMfreqmin	FLslider 	" ",				1,      10000,       0,   23,   idRMfreqmin,   490,     13,   505,  420
gkRMfreqmax,gihRMfreqmax	FLslider 	"Random RM Frequency",		1,      10000,       0,   23,   idRMfreqmax,   490,     13,   505,  433
gkBPFmix,ihBPFmix		FLslider 	"Mix",				0,          1,       0,   23,   -1,            150,     25,   510,  513
gkBPFcutmin,ihBPFcutmin		FLslider 	"",				4,         14,       0,   23,   -1,            150,     13,   670,  513
gkBPFcutmax,ihBPFcutmax		FLslider 	"Cutoff",			4,         14,       0,   23,   -1,            150,     13,   670,  526
gkBPFbwmin,ihBPFbwmin		FLslider 	"",				0.001,     10,      -1,   23,   -1,            150,     13,   830,  513
gkBPFbwmax,ihBPFbwmax		FLslider 	"Bandwidth",			0.001,     30,      -1,   23,   -1,            150,     13,   830,  526
gkBPFgain,ihBPFgain		FLslider 	"Gain",				0,         30,       0,   23,   -1,            150,     25,   510,  553
gkHPFcf,gihHPFcf		FLslider 	"HPF Cutoff",			20,     20000,      -1,   23,   idHPFcf,       490,     25,   505,  645
gkLPFcf,gihLPFcf		FLslider 	"LPF Cutoff",			20,     20000,      -1,   23,   idLPFcf,       490,     25,   505,  695
gkRvbDryWet,ihRvbDryWet		FLslider 	"Mix",				0,          1,       0,   23,   -1,            150,     20,    10,  675
gkfblvl,ihfblvl			FLslider 	"Size",				0,          1,       0,   23,   -1,            150,     20,   170,  675
gkfco,ihfco			FLslider 	"Cutoff",			20,     20000,       0,   23,   -1,            150,     20,   330,  675

;SET INITIAL VALUES FOR VALUATORS
				FLsetVal_i	.5,		ihptr
				FLsetVal_i	.4, 		ihatt
				FLsetVal_i	.5, 		ihdec
				FLsetVal_i	0.3, 		ihgain
				FLsetVal_i	.25, 		ihwidth
				FLsetVal_i	0, 		ihampdepth
				FLsetVal_i	20, 		gihHPFcf
				FLsetVal_i	20000, 		gihLPFcf
				FLsetVal_i	.00263, 	ihptr_OS
				FLsetVal_i	0, 		ihoct
				FLsetVal_i	-2,    		ihrndoctavemin
				FLsetVal_i	0,    		ihrndoctavemax
				FLsetVal_i	100, 		ihGPS
				FLsetVal_i	0.838, 		ihgap_OS
				FLsetVal_i	.6, 		ihdurMin
				FLsetVal_i	.6, 		ihdurMax
				FLsetVal_i	0, 		ihpchosrange
				FLsetVal_i	0, 		gihRMmix
				FLsetVal_i	500, 		gihRMfreqmin
				FLsetVal_i	8000, 		gihRMfreqmax
				FLsetVal_i	1, 		ihLFOamp
				FLsetVal_i	.0025, 		ihLFOfrq
				FLsetVal_i	.4,    		ihRvbDryWet
				FLsetVal_i	.9,    		ihfblvl
				FLsetVal_i	10000, 		ihfco
				FLsetVal_i	0,    		ihEnvType
				FLsetVal_i	1,    		ihRvbOnOff
				FLsetVal_i	1,    		ihRMOnOff
				FLsetVal_i	1,    		ihBPFOnOff
				FLsetVal_i	1,    		ihFiltOnOff
				FLsetVal_i	0,    		ihBPFmix
				FLsetVal_i	6,   		ihBPFcutmin
				FLsetVal_i	14,  		ihBPFcutmax
				FLsetVal_i	0.005, 		ihBPFbwmin
				FLsetVal_i	0.01,  		ihBPFbwmax
				FLsetVal_i	19,  		ihBPFgain
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 720, 612, 10
				FLscroll     515, 720, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   Schedkwhen Granulation                    ", 	1,       5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example implements granular synthesis by using          ", 	1,       5,     14,    490,    20,     5,  40
ih		 	FLbox  	"schedkwhen to create note events from within the orchestra in", 	1,       5,     14,    490,    20,     5,  60
ih		 	FLbox  	"realtime. None of Csound's built-in opcodes for granular     ", 	1,       5,     14,    490,    20,     5,  80
ih		 	FLbox  	"synthesis are used.                                          ", 	1,       5,     14,    490,    20,     5, 100
ih		 	FLbox  	"The advantage of this approach is that the method of grain   ", 	1,       5,     14,    490,    20,     5, 120
ih		 	FLbox  	"generation is not defined by the opcode and that further     ", 	1,       5,     14,    490,    20,     5, 140
ih		 	FLbox  	"processing can be applied to individual grains rather than   ", 	1,       5,     14,    490,    20,     5, 160
ih		 	FLbox  	"just to the accumulated output of grains. The downside is    ", 	1,       5,     14,    490,    20,     5, 180
ih		 	FLbox  	"that there is likely to be greater CPU strain for dense      ", 	1,       5,     14,    490,    20,     5, 200
ih		 	FLbox  	"granulations.                                                ", 	1,       5,     14,    490,    20,     5, 220
ih		 	FLbox  	"In this implemenation grain-by-grain procedures are          ", 	1,       5,     14,    490,    20,     5, 240
ih		 	FLbox  	"represented through ring modulation and band-pass filtering. ", 	1,       5,     14,    490,    20,     5, 260
ih		 	FLbox  	"Processes upon the accumlated output of the granular         ", 	1,       5,     14,    490,    20,     5, 280
ih		 	FLbox  	"synthesizer are represented by global filtering (low-pass and", 	1,       5,     14,    490,    20,     5, 300
ih		 	FLbox  	"high-pass) and by reverb. Grain-by-grain processes are       ", 	1,       5,     14,    490,    20,     5, 320
ih		 	FLbox  	"carried out in the instrument that actually renders the audio", 	1,       5,     14,    490,    20,     5, 340
ih		 	FLbox  	"for grains whereas global procedures are carried out in a    ", 	1,       5,     14,    490,    20,     5, 360
ih		 	FLbox  	"separate, always on, instrument.                             ", 	1,       5,     14,    490,    20,     5, 380
ih		 	FLbox  	"The pointer which defines the location within the sound file ", 	1,       5,     14,    490,    20,     5, 400
ih		 	FLbox  	"from which grains are read is defined by the FLTK slider     ", 	1,       5,     14,    490,    20,     5, 420
ih		 	FLbox  	"'Pointer'. The pointer can also be modulated by an LFO. To   ", 	1,       5,     14,    490,    20,     5, 440
ih		 	FLbox  	"deactivate the LFO reduce its amplitude to zero.             ", 	1,       5,     14,    490,    20,     5, 460
ih		 	FLbox  	"Certain paramaters of the ring modulator and the band-pass   ", 	1,       5,     14,    490,    20,     5, 480
ih		 	FLbox  	"filter can be randomized from grain to grain. The range from ", 	1,       5,     14,    490,    20,     5, 500
ih		 	FLbox  	"which random values are chosen are represented by two mini   ", 	1,       5,     14,    490,    20,     5, 520
ih		 	FLbox  	"sliders stacked one upon the other.                          ", 	1,       5,     14,    490,    20,     5, 540
ih		 	FLbox  	"The pitch of grains can me modulated in a variety of ways.   ", 	1,       5,     14,    490,    20,     5, 560
ih		 	FLbox  	"'Pitch (oct)' modulates the pitch of all grains by the same  ", 	1,       5,     14,    490,    20,     5, 580
ih		 	FLbox  	"constant number of octaves. 'Random Octave' defines a range  ", 	1,       5,     14,    490,    20,     5, 600
ih		 	FLbox  	"from which random modulations on a grain-by-grain basis are  ", 	1,       5,     14,    490,    20,     5, 620
ih		 	FLbox  	"applied. 'Pitch Offset Range (Octaves)' define the range from", 	1,       5,     14,    490,    20,     5, 640
ih		 	FLbox  	"which transpositions by octave intervals are applied.        ", 	1,       5,     14,    490,    20,     5, 640
ih		 	FLbox  	"The attack and the decay portions of each grain envelope are ", 	1,       5,     14,    490,    20,     5, 660
ih		 	FLbox  	"defined as well as a continuous morph between straight and   ", 	1,       5,     14,    490,    20,     5, 680
ih		 	FLbox  	"exponential envelope segements.                              ", 	1,       5,     14,    490,    20,     5, 700
ih		 	FLbox  	"This example can also be triggered via a MIDI ketboard. MIDI ", 	1,       5,     14,    490,    20,     5, 720
ih		 	FLbox  	"note values will modulate any transposition set in the FLTK  ", 	1,       5,     14,    490,    20,     5, 740
ih		 	FLbox  	"interface about a unison point corresponding to middle C.    ", 	1,       5,     14,    490,    20,     5, 740
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,       5,     14,    490,    20,     5, 760
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,       5,     14,    490,    20,     5, 780
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,       5,     14,    490,    20,     5, 800
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,       5,     14,    490,    20,     5, 820
ih		 	FLbox  	"material. A 24 bit sound file called                         ", 	1,       5,     14,    490,    20,     5, 840
ih		 	FLbox  	"'SchedkwhenGranulationOutput.wav' will be created in the     ", 	1,       5,     14,    490,    20,     5, 860
ih		 	FLbox  	"default directory for SFDIR.                                 ", 	1,       5,     14,    490,    20,     5, 880

				FLscroll_end
				FLpanel_end

;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35,  0, 805
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS
		FLrun

gasendL		init		0	;INITIALIZE GLOBAL AUDIO VARIABLES USED TO SEND AUDIO FROM GRAIN RENDERING INSTRUMENT
gasendR		init		0       ;INITIALIZE GLOBAL AUDIO VARIABLES USED TO SEND AUDIO FROM GRAIN RENDERING INSTRUMENT
gifn		=		1	;THE FUNCTION TABLE NUMBER OF THE SOURCE SOUND FILE FOR GRANULATION

instr		1	;GRAIN TRIGGERING INSTRUMENT (ALWAYS ON)
		iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
		iMIDIflag		=	0		;IF FLTK ACTIVATED
		mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

		icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

		if	gkOnOff=0&&iMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
		endif				;ENDI OF THIS CONDITIONAL BRANCH

		if iMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
			iPitchRatio	=	icps/cpsoct(8)	;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
		else						;OTHERWISE...
			iPitchRatio	=	1		;PITCH RATIO IS JUST 1
		endif						;END OF THIS CONDITIONAL BRANCH

		iporttime	=		0.05				;PORTAMENTO TIME
		gkporttime	linseg		0,.01,iporttime,1,iporttime	;gkporttime WILL RAMP UP AND HOLD THE VALUE iporttime
		kGPS		portk		gkGPS, gkporttime		;APPLY PORTAMENTO TO GRAINS-PER-SECOND VARIABLE
		ktrigger	metro		gkGPS				;CREATE A METRICAL TRIGGER (MOMENTARY 1s) USING GRAINS-PER-SECOND AS A FREQUENCY CONTROL
		kptr		portk		gkptr, gkporttime		;APPLY PORTAMENTO TO POINTER VARIABLE
		kLFO		lfo		(gkLFOamp * 0.5), gkLFOfrq, 1	;TRIANGLE WAVEFORM LFO TO CREATE AN LFO POINTER
		kptr		=		kptr + (kLFO + 0.5)		;ADD POINTER VARIABLE TO POINTER LFO
		kptr		wrap		kptr, 0, 1			;WRAP OUT OF RANGE VALUE FOR POINTER BETWEEN ZERO AND 1
		giSampleLen 	= 		(nsamp(gifn))/sr		;DERIVE SAMPLE LENGTH IN SECONDS
		kptr		=		kptr * giSampleLen		;RESCALE POINTER ACCORDING TO SAMPLE LENGTH
		;               OPCODE	 	KTRIGGER, KMINTIME, KMAXNUM, KINSNUM, KWHEN, KDUR,  P4     P5
				schedkwhen	ktrigger,    0,        0,       2,      0,     0,  kptr, iPitchRatio	;TRIGGER INSTR 2 ACCORDING TO TRIGGER. SEND POINTER VALUE VIA P-FIELD 4, SEND MIDI PITCH RATIO VIA P5
endin
	
instr		2	;SCHEDKWHEN TRIGGERED INSTRUMENT. ON FOR JUST AN INSTANCE. THIS INSTRUMENT DEFINES GRAIN DURATION, ADDS GRAIN GAP OFFSET, AND TRIGGERS THE GRAIN SOUNDING INSTRUMENT
		idur		random		i(gkdurMin), i(gkdurMax)	;DERIVE A GRAIN DURATION ACCORDING TO DURATION RANGE SETTINGS 
		igap_OS		random		0, i(gkgap_OS)			;DERIVE A GRAIN GAP OFFSET ACCORDING TO FLTK VARIABLE "Grain Gap Offset"
				event_i		"i", 3, igap_OS, idur, p4, p5	;TRIGGER INSTRUMENT 3 (GRAIN SOUNDING INSTRUMENT). PASS POINTER VALUE VIA P-FIELD 4. GRAIN GAP OFFSET IS IMPLEMENTED USING P2/'WHEN' PARAMETER FIELD. SEND MIDI PITCH RATIO VIA P5
endin
		
instr		3	;GRAIN SOUNDING INSTRUMENT
		iwidth 		=	i(gkwidth)						;DERIVE AN I-RATE VERSION OF gkwidth
		iampdepth 	=	i(gkampdepth)						;DERIVE AN I-RATE VERSION OF gkampdepth
		iptr_OS		=	i(gkptr_OS)						;DERIVE AN I-RATE VERSION OF gkptr_OS (POINTER OFFSET)
		ioct_OS		random	-i(gkpchosrange), i(gkpchosrange)			;DERIVE CONTINUOUS TRANSPOSITION CONSTANT
		irndoctave	random	i(gkrndoctavemin), i(gkrndoctavemax)                    ;DERIVE OCTAVE INTERVAL TRANSPOSITION CONSTANT
		ipchrto		=	cpsoct(8+int(irndoctave)+i(gkoct)+ioct_OS)/cpsoct(8)    ;CREATE A PITCH RATIO (TO UNISON) CONSTANT COMBINING ALL TRANSPOSITION CONSTANTS
		ipchrto		=	ipchrto * p5						;SCALE PITCH RATIO WITH P5 WHICH, TRACED BACK THROUGH INSTR 2 TO INSTR 1, IS MIDI PITCH RATIO
		iskip		=	p4 + rnd(iptr_OS)					;DEFINE 'IN-SKIP' INTO THE SOUND FILE (IN SECONDS) FROM POINTER VALUE PASSED FROM CALLER INSTRUMENT AND RANDOM POINTER OFFSET	
		iatt		=	i(gkatt)						;DERIVE AN I-RATE VERSION OF gkatt (ATTACK TIME)
		idec		=	i(gkdec)                                                ;DERIVE AN I-RATE VERSION OF gkdec (DECAY TIME)
		if		iatt+idec>1	then		;IF ATTACK TIME AND DECAY TIME ARE GREATER THAN 1 THEN THE VALUES SHOULD BE RESCALED SO THAT THE SUM IS EQUAL TO 1
			iatt	=	iatt/(iatt+idec)	;RESCALE iatt
			idec	=	idec/(iatt+idec)	;RESCALE idec
		endif						;END OF CONDITIONAL BRANCHING
		aenvL		linseg	0,	(iatt * p3),	1,	((1 - iatt - idec) * p3),	1,	(idec * p3),	0	;DEFINE GRAIN AMPLITUDE ENVELOPE (STRAIGHT SEGMENTS)
		aenvE		expsega	.0001,	(iatt * p3),	1,	((1 - iatt - idec) * p3),	1,	(idec * p3),	.0001	;DEFINE GRAIN AMPLITUDE ENVELOPE (EXPONENTIAL SEGMENTS)	
		aenv		ntrpol	aenvL, aenvE, gkEnvType										;CREATE A RESULTANT ENVELOPE THAT IS A CONTINUOUS MORPH BETWEEN THE STRAIGHT AND EXPONENTIAL VERSIONS ABOVE
		iamp 		= 	(1 - rnd(iampdepth))*i(gkgain)	;DERIVE AMPLITUDE FROM 'Gain' SLIDER AND FROM 'Random Amplitude Depth' SLIDER
		ipan		random	-iwidth, iwidth			;DERIVE A PANNING POSITION FOR THIS GRAIN FROM 'Random Panning Amount' SLIDER
		ipan 		= 	ipan + .5			;OFFSET ipan by +0.5
		aptr		line	iskip,   p3 / ipchrto,   iskip+p3	;DEFINE A MOVING POINTER FUNCTION TO READ GRAIN FROM FUNCTION TABLE CONTAINING SOURCE AUDIO
		asig  		tablei	aptr * sr, gifn				;READ AUDIO FROM SOURCE SOUND FUNCTION TABLE. I.E. CREATE GRAIN
		;GRAIN-BY-GRAIN RING MODULATION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		if	gkRMOnOff=1	then						;IF BAND-PASS FILTERING ON/OFF SWITCH IS ON...
			iRMfreq		random	i(gkRMfreqmin), i(gkRMfreqmax)		;DEFINE RANDOM RING MODULATION FREQUENCY
			anoRM		=	1					;A-RATE CONSTANT VALUE OF '1'
			amod		oscil	1, iRMfreq, 11				;CREATE RING MODULATING OSCILATOR
			amod		ntrpol	anoRM, amod, gkRMmix			;CREATE A MIX BETWEEN RING MODULATING OSCILATOR AND CONSTANT VALUE '1'
			asig		=	asig * amod				;RING MODULATE AUDIO SIGNAL
		endif									;END OF CONDITIONAL BRANCHING
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;GRAIN-BY-GRAIN BAND-PASS FILTERING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		if	gkBPFOnOff=1	then						;IF BAND-PASS FILTERING ON/OFF SWITCH IS ON...
			iBPFcut		random	i(gkBPFcutmin), i(gkBPFcutmax)		;DEFINE RANDOM FILTER CUTOFF VALUE (IN OCT FORMAT)
			iBPFfrq		=	cpsoct(iBPFcut)				;CONVERT TO CPS FORMAT
			iBPFbw		random	i(gkBPFbwmin), i(gkBPFbwmax)		;DEFINE RANDOM BANDWIDTH VALUE
			aBPF 		reson 	asig, iBPFfrq, iBPFbw*iBPFfrq, 1	;FILTER AUDIO USING reson OPCODE
			asig		ntrpol	asig, aBPF*i(gkBPFgain), gkBPFmix	;CREATE MIX BETWEEN THE FILTERED SOUND AND THE DRY SOUND
		endif									;END OF CONDITIONAL BRANCHING
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		asig 		= 	asig * aenv * iamp				;APPLY AMPLITUDE CONSTANT AND GRAIN ENVELOPE
		gasendL		=	gasendL + (asig * ipan)				;APPLY PANNING VARIABLE AND CREATE LEFT CHANNEL ACCUMULATED OUTPUT 
		gasendR		=	gasendR + (asig * (1 - ipan))			;APPLY PANNING VARIABLE AND CREATE RIGHT CHANNEL ACCUMULATED OUTPUT
endin
		
instr		4	;GLOBAL PROCESSING OF GRANULAR OUTPUT & REVERB INSTRUMENT
		asigL	=	gasendL					;READ ACCUMULATED AUDIO SENT BY GRAIN RENDERING INSTRUMENT AND CREATE A LOCAL AUDIO VARIABLE OUTPUT (THIS IS TO ALLOW REDEFINITION OF THE VARIABLE WITHIN THE SAME LINE OF CODE - NOT POSSIBLE WITH GLOBAL VARIABLES)
		asigR	=	gasendR					;READ ACCUMULATED AUDIO SENT BY GRAIN RENDERING INSTRUMENT AND CREATE A LOCAL AUDIO VARIABLE OUTPUT (THIS IS TO ALLOW REDEFINITION OF THE VARIABLE WITHIN THE SAME LINE OF CODE - NOT POSSIBLE WITH GLOBAL VARIABLES)
		if		gkFiltOnOff=1	then			;IF GLOBAL FILTERING ON/OFF SWITCH IS ON...
			kHPFcf		portk	gkHPFcf, gkporttime	;APPLY PORTAMENTO TO HIGH-PASS FILTER CUTOFF VARIABLE
			kLPFcf		portk	gkLPFcf, gkporttime     ;APPLY PORTAMENTO TO LOW-PASS FILTER CUTOFF VARIABLE
			asigL		buthp	asigL, kHPFcf		;APPLY HIGH-PASS FILTER TO LEFT CHANNEL AUDIO...
			asigL		buthp	asigL, kHPFcf		;...AND AGAIN TO SHARPEN CUTOFF SLOPE
			asigR		buthp	asigR, kHPFcf           ;APPLY HIGH-PASS FILTER TO LEFT CHANNEL AUDIO...
			asigR		buthp	asigR, kHPFcf		;...AND AGAIN TO SHARPEN CUTOFF SLOPE           	
			asigL		butlp	asigL, kLPFcf		;APPLY LOW-PASS FILTER TO LEFT CHANNEL AUDIO...
			asigL		butlp	asigL, kLPFcf           ;...AND AGAIN TO SHARPEN CUTOFF SLOPE           
			asigR		butlp	asigR, kLPFcf           ;APPLY LOW-PASS FILTER TO RIGHT CHANNEL AUDIO...
			asigR		butlp	asigR, kLPFcf           ;...AND AGAIN TO SHARPEN CUTOFF SLOPE           
                endif							;END OF CONDITIONAL BRANCHING

		aSigL	=	asigL * (1 - gkRvbDryWet)		;SCALE AUDIO SIGNAL WITH FLTK AMPLITUDE SLIDER AND GRAIN CLOUD ENVELOPE
		aSigR	=	asigR * (1 - gkRvbDryWet)		;SCALE AUDIO SIGNAL WITH FLTK AMPLITUDE SLIDER AND GRAIN CLOUD ENVELOPE
		outs 	aSigL, aSigR					;SEND AUDIO TO OUTPUTS

		if		gkRvbOnOff=1	then			;IF REVERB ON/OFF SWITCH IS ON...
			denorm		asigL, asigR			;...DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
			arvbL, arvbR 	reverbsc 	asigL  * gkRvbDryWet, asigR  * gkRvbDryWet, gkfblvl, gkfco	;CREATE REVERBERATED SIGNAL (USING UDO DEFINED ABOVE)
				outs	arvbL, arvbR			;SEND REVERBERATED SIGNAL TO AUDIO OUTPUTS
		endif							;END OF CONDITIONAL BRANCHING
		clear	gasendL, gasendR	;ZERO GLOBAL AUDIO VARIABLES USED TO SEND ACCUMULATED GRAINS
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	aL,aR	monitor
	;	OPCODE	FILENAME                          | FORMAT | OUT1  | OUT2 etc...
		fout	"SchedkwhenGranulationOutput.wav",     8,     aL,     aR	; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
endin
	
</CsInstruments>

<CsScore>
f 1 0 1048576 1 "ClassicalGuitar.wav" 0 4 1	;THE SOUND FILE
f 11 0 512 10 1					;SINE WAVE
i 4 0 3600	;GLOBAL PROCESSING OF GRANULAR OUTPUT & REVERB
</CsScore>

</CsoundSynthesizer>