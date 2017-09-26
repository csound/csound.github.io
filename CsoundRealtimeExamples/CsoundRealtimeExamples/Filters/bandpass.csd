;Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b400 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL     | WIDTH | HEIGHT | X | Y
				FLpanel	"Bandpass",  500,    620,    0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
gkslope,ihslope		FLbutton	"Slope: 24dB/48dB",	1,    0,    22,    160,     25,  150,  5,   -1
gkbalance,ihbalance	FLbutton	"Balance On/Off",	1,    0,    22,    140,     25,  320,  5,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	50, 50,255, ihslope		;SET SECONDARY COLOUR TO BLUE
FLsetColor2	255, 50,50, ihbalance		;SET SECONDARY COLOUR TO RED

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idspeed			FLvalue	"",       70,    20,     5,  445
idhp			FLvalue	"",       70,    20,     5,  495
idAtt	  		FLvalue	"",       60,    20,    5,   545
idRel	  		FLvalue	"",       60,    20,  255,   545
idgain			FLvalue	"",       70,    20,     5,  595

;					            			MIN | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X  | Y
gkspeed, gihspeed	FLslider 	"Playback Speed (CC#3)",	0.125,   2, -1,    23,   idspeed,  490,     25,    5,  420
gkhp, ihhp		FLslider 	"Balance Half Point (Hz)",	1,      20, -1,    23,   idhp,     490,     25,    5,  470
gkInGain, ihInGain	FLslider 	"Live Input Gain",		0,       1,  0,    23,   -1,       150,     12,  150,   71
FLsetTextSize 10, ihInGain	;SET SIZE OF LABEL TEXT
gkAtt,ihAtt		FLslider	"Attack Time",			0.05,   10,  0,    23,   idAtt,    240,     25,    5,  520
gkRel,ihRel		FLslider	"Release",			0.05,   10,  0,    23,   idRel,    240,     25,  255,  520
gkgain, ihgain		FLslider 	"Output Amplitude Scaling",	0,       2,  0,    23,   idgain,   490,     25,    5,  570

;NUMBER DISPLAY BOXES			    WIDTH | HEIGHT | X | Y
idfreq			FLvalue	"Frequency", 70,      20,     5,  380
idband			FLvalue	"Bandwidth", 70,      20,   425,  380

;XY PANELS											MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkfreq, gkband, gihfreq, gihband	FLjoy	"X - Frequency (CC#1) Y - Bandwidth (CC#2)",	20,   15000,  0.01,   5,     -1,    -1,  idfreq, idband,   490,    280,    5, 100
FLsetColor2	255, 0, 0, gihfreq	;SET SECONDARY COLOUR TO RED
FLsetColor2	255, 0, 0, gihband	;SET SECONDARY COLOUR TO RED

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255	; NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,  ihinput	FLbutBank	4,      1,     3,     18,      54,    50,36,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input:", 	1,       5,    12,    48,      12,    0,  37
ih		 	FLbox  	"Synth Pad ", 	1,       5,    12,    70,      15,   70,  37
ih		 	FLbox  	"Seashore  ", 	1,       5,    12,    70,      15,   70,  54
ih		 	FLbox  	"Live Input", 	1,       5,    12,    70,      15,   70,  71

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	900, 	gihfreq
				FLsetVal_i	1, 	gihband
				FLsetVal_i	1, 	gihspeed
				FLsetVal_i	0.5, 	ihgain
				FLsetVal_i	1, 	ihslope
				FLsetVal_i	1, 	ihbalance
				FLsetVal_i	4, 	ihhp
				FLsetVal_i	0.5, 	ihInGain
				FLsetVal_i   	0.05, 	ihAtt
				FLsetVal_i   	0.05, 	ihRel

				FLpanel_end
				
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 680, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Bandpass                            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example is an implementation of a bandpass filter using ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Csound's butterworth bandpass filter (butterbp/butbp) but    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"with some extra options added.                               ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Cutoff frequency and bandwidth can be controlled via the on- ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"screen x-y panel. The actual value used for bandwidth is     ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"proportional to the current value of the cutoff frequency,   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"this gives a slightly more musical response.                 ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"The normal cutoff slope for a butterworth bandpass filter is ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"24 decibels per octave (dB/oct). By activating the slope     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"switch the steepness of this slope is doubled to 48dB/oct by ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"engaging another iteration of the butbp opcode.              ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"Activating the 'Balance' switch applies Csound's 'balance'   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"opcode to the output of the filter, this opcode modifies the ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"dynamics of the signal given to it to match those of the     ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"signal pre-filtering. The half-point of the smoothing of its ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"response - effectively the response speed - can be adjusted. ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"This is an i-rate variable so realtime adjustments causes    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"discontinuities in the realtime audio output.                ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"Cutoff frequency, bandwidth and playback speed of the input  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"sound file can also be modulated using MIDI controllers 1, 2 ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"and 3 respectively. MIDI controller modulation is not        ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"reflected in the on screen FLTK sliders as this does not seem", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"to work correctly with the FLjoy widget.                     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"If the instrument is activated by MIDI notes, MIDI pitch is  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"interpretted as cutoff frequency, in this mode the FLTK and  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"MIDI controller assignment for cutoff frequency is ignored.  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"material. A 24 bit sound file called 'BandpassOutput.wav'    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"will be created in the default directory for SFDIR.          ", 	1,      5,     14,    490,    20,     5, 660

				FLpanel_end

;RECORD OUTPUT PANEL
		FLlabel		13,      1,      1,     0,     0,     0			;FORMAT LABELS
		FLpanel	"Record",   300,    35, 0,675
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS
garecL		init		0	;INITIALIZE RECORD SIGNAL AUDIO VARIABLE LEFT CHANNEL (TO ZERO / SILENCE)
garecR		init		0	;INITIALIZE RECORD SIGNAL AUDIO VARIABLE LEFT CHANNEL (TO ZERO / SILENCE)

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giconcave	ftgen	0, 0, 1024, 16, 0, 1024, 4, 1	;CONCAVE CURVE USED TO RESCALE MIDI CONTROLLER VALUES

instr	1
        kporttime	linseg	0,0.001,0.05	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	if	gkOnOff=0&&iMIDIflag=0	then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff		;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		kfreq	=	icps			;MAP TO MIDI NOTE VALUE TO CUTOFF FREQUENCY
	else						;OTHERWISE...
		kfreq	portk	gkfreq, kporttime	;CUTOFF FREQ. IS A SMOOTHED VERSION OF FLTK SLIDER FOR CUTOFF FREQUENCY
	endif						;END OF THIS CONDITIONAL BRANCH

	kband	portk	gkband, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	kspeed	portk	gkspeed, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	kband	limit	kband*kfreq, 0, 10000	;SCALE BANDWIDTH ACCORDING TO CUTOFF FREQUENCY VALUE - LIMIT VALUE TO PREVENT FILTER 'EXPLOSION'
	kactive	active	p1	;SCAN THE NUMBER OF INSTANCES OF THIS INSTRUMENT
	if gkinput=0 then
		;OUTPUTS	OPCODE	FILE                   | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
		asigL, asigR	diskin2	"SynthPad.wav", kspeed,    0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)	
	elseif gkinput=1 then
		;OUTPUTS	OPCODE	FILE                  | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
		asigL, asigR	diskin2	"Seashore.wav",        kspeed,    0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)	
	else
		asigL,asigR	ins
		asigL	=	asigL * gkInGain
		asigR	=	asigR * gkInGain
	endif
	aresL 		butbp 	asigL, kfreq, kband, 0	;FILTER EACH CHANNEL SEPARATELY
	aresR 		butbp 	asigR, kfreq, kband, 0	;FILTER EACH CHANNEL SEPARATELY
	if gkslope=1 then				;IF SLOPE SWITCH IS ON 48dB PER OCTAVE
		aresL 		butbp 	aresL, kfreq, kband, 0	;FILTER EACH CHANNEL SEPARATELY
		aresR 		butbp 	aresR, kfreq, kband, 0	;FILTER EACH CHANNEL SEPARATELY
	endif						;END OF THIS CONDITIONAL BRANCH
	if gkbalance=1 then				;IF BALANCVE SWITCH IS ON
		ktrig	changed	gkhp
		if ktrig=1 then
			reinit	UPDATE
		endif
		UPDATE:
		aresL		balance	aresL, asigL, i(gkhp)	;APPLY 'BALANCE' DYNAMICS PROCESSING
		aresR		balance	aresR, asigR, i(gkhp);APPLY 'BALANCE' DYNAMICS PROCESSING
		rireturn
	endif						;END OF THIS CONDITIONAL BRANCH
	aenv	expsegr	0.0001,i(gkAtt),1,i(gkRel),0.0001	;CLOUD AMPLITUDE ENVELOPE
	aresL	=	aresL * gkgain * aenv		;SCALE AUDIO SIGNAL WITH FLTK GAIN SLIDER AND ENVELOPE
	aresR	=	aresR * gkgain * aenv		;SCALE AUDIO SIGNAL WITH FLTK GAIN SLIDER AND ENVELOPE
	garecL	=		garecL + aresL	;ADD LOCAL AUDIO TO GLOBAL RECORD AUDIO VARIABLE
	garecR	=		garecR + aresR	;ADD LOCAL AUDIO TO GLOBAL RECORD AUDIO VARIABLE
		outs 	aresL, aresR			;SEND AUDIO TO OUTPUTS
endin

instr	2	;MIDI CONTROLLER SYNCHRONISATION
;A MACRO IS DEFINE TO PREVENT CODE REPETITION
#define CONTROLLER(NAME'NUMBER'MIN'MAX'CURVE)
        #						;START OF MACRO
        k$NAME          ctrl7           1,$NUMBER,0,1,$CURVE    ;READ MIDI CONTROLLER
        ktrig$NAME      changed         k$NAME                  ;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
        if ktrig$NAME=1	then				;IF MIDI SLIDER HAS BEEN MOVED
        	gk$NAME	scale	k$NAME, $MAX, $MIN      ;VARIBALE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
        endif						;END OF THIS CONDITIONAL BRANCH			
        #						;END OF MACRO
        ;           NAME  NUM  MIN    MAX    CURVE
        $CONTROLLER(freq'  1 '20   ' 15000 'giconcave)	;EXPAND MACRO
        $CONTROLLER(band'  2 '0.01 ' 5     'giconcave)	;EXPAND MACRO
        $CONTROLLER(speed' 3 '0.125' 2     'giconcave)	;EXPAND MACRO
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	;	OPCODE	FILENAME               | FORMAT | OUT1  | OUT2 etc...
		fout	"BandpassOutput.wav",     8,    garecL, garecR; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
	clear	garecL, garecR	;CLEAR GLOBAL AUDIO RECORD VARIABLES
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;MIDI/FLTK SYNCHRONIZATION
</CsScore>

</CsoundSynthesizer>
