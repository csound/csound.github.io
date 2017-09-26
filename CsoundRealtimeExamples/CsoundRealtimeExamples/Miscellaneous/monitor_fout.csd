monitor_fout.csd
Written by Iain McCurdy, 2008 (updated 2011)

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	32
nchnls	=	1
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL                              | WIDTH | HEIGHT | X | Y
	FLpanel	"monitor-fout - rendering realtime output",   500,    275,    0,  0
;BUTTONS								ON | OFF | TYPE | WIDTH | HEIGHT |  X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"Oscillator FLTK/MIDI",	1,   0,    22,     180,     25,     5,  5,    0,      1,      0,       -1
gkPause,gihPause		FLbutton	"",			1,   0,     2,      30,     25,   250, 75,   -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, gihPause	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,   255,    255		;LABELS MADE INVISIBLE
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFunction, gihFunction	FLbutBank	12,     1,     3,     30,     75,    250, 0,    -1;0,      2,   0,  0.01

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,      3,    0,     0,      0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Stop  ", 		1,       5,    12,    50,      30,   280,  0
ih		 	FLbox  	"Record", 		1,       5,    12,    50,      25,   280,  25
ih		 	FLbox  	"Play  ", 		1,       5,    12,    50,      25,   280,  50
ih		 	FLbox  	"Pause ", 		1,       5,    12,    50,      25,   280,  75

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idfreq			FLvalue	" ",     60,      18,    5,   150
idamp			FLvalue	" ",     60,      18,    5,   200
idPBamp			FLvalue	" ",     60,      18,    5,   250

;SLIDERS				            			MIN  |   MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X | Y
gkfreq, ihfreq		FLslider 	"Frequency",			20,    20000,  -1,    23,  idfreq,   490,    25,     5, 125
gkamp, ihamp		FLslider 	"Oscillator Amplitude",		0,         1,   0,    23,  idamp,    490,    25,     5, 175
gkPBamp, ihPBamp	FLslider 	"Playback Amplitude",		0,         1,   0,    23,  idPBamp,  490,    25,     5, 225

;SET INITIAL VALUES
			FLsetVal_i	325,	ihfreq
			FLsetVal_i	0.5,	ihamp
			FLsetVal_i	1,	ihPBamp

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 520, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 	FLbox  	"       monitor and fout : rendering realtime output          ", 	1,      5,    14,    490,     20,    5,    0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,    14,    490,     20,    5,   20
ih		 	FLbox  	"This example illustrates a method of rendering a realtime    ", 	1,      5,    14,    490,     20,    5,   40
ih		 	FLbox  	"performance to the hard disc whilst simultaneously monitoring", 	1,      5,    14,    490,     20,    5,   60
ih		 	FLbox  	"it in the computer's speakers. This is achieved by using the ", 	1,      5,    14,    490,     20,    5,   80
ih		 	FLbox  	"'monitor' and 'fout' opcodes.                                ", 	1,      5,    14,    490,     20,    5,  100
ih		 	FLbox  	"The source signal (a simple sine wave oscillator) is kept    ", 	1,      5,    14,    490,     20,    5,  120
ih		 	FLbox  	"simple to clarify the demonstration. It can be operated      ", 	1,      5,    14,    490,     20,    5,  140
ih		 	FLbox  	"either by using the FLTK sliders or from MIDI. MIDI operation", 	1,      5,    14,    490,     20,    5,  160
ih		 	FLbox  	"confirms that this method of rendering works with polyphonic ", 	1,      5,    14,    490,     20,    5,  180
ih		 	FLbox  	"instruments also.                                            ", 	1,      5,    14,    490,     20,    5,  200
ih	  	 	FLbox  	"Soundfile recording is dealt with in a separate instrument   ", 	1,      5,    14,    490,     20,    5,  220
ih		 	FLbox  	"(instr 3) which is activated using the on-screen record      ", 	1,      5,    14,    490,     20,    5,  240
ih		 	FLbox  	"button.                                                      ", 	1,      5,    14,    490,     20,    5,  260
ih		 	FLbox  	"An output file called 'output.wav' will be created.          ", 	1,      5,    14,    490,     20,    5,  280
ih		 	FLbox  	"The output file can be played back using the on-screen 'play'", 	1,      5,    14,    490,     20,    5,  300
ih		 	FLbox  	"button.                                                      ", 	1,      5,    14,    490,     20,    5,  320
ih		 	FLbox  	"If the user wants to record the output of any of the examples", 	1,      5,    14,    490,     20,    5,  340
ih		 	FLbox  	"in this collection then this is the recommended method. It   ", 	1,      5,    14,    490,     20,    5,  360
ih		 	FLbox  	"should not prove too difficult to copy and paste the required", 	1,      5,    14,    490,     20,    5,  380
ih		 	FLbox  	"code from this example into any of the other examples.       ", 	1,      5,    14,    490,     20,    5,  400
ih		 	FLbox  	"The 'monitor' opcode is used to gather all audio being sent  ", 	1,      5,    14,    490,     20,    5,  420
ih		 	FLbox  	"to the audio output and this mix is then written to a file on", 	1,      5,    14,    490,     20,    5,  440
ih		 	FLbox  	"the hard drive using 'fout'. 'fout' can render audio in a    ", 	1,      5,    14,    490,     20,    5,  460
ih		 	FLbox  	"variety of file formats with from 1 to 64 channels. Sampling ", 	1,      5,    14,    490,     20,    5,  480
ih		 	FLbox  	"rate of the file is determined by Csound's sampling rate.    ", 	1,      5,    14,    490,     20,    5,  500

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen		0, 0, 65536, 10, 1	;A SINE WAVE FUNCTION TABLE

instr 	1	;CREATE AN AUDIO TONE WITH AMPLITUDE AND FREQUENCY CONTROL
	kporttime	linseg	0,0.01,0.01		;CREATE A FUNCTION THAT RAMPS UP QUICKLY FROM ZERO TO A HELD VALUE (0.05) THAT WILL BE USED FOR PORTAMENTO TIME
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED kMIDIflag WILL TAKE THIS VALUE
	iMIDIflag		=	0		;IF FLTK ACTIVATED WILL RETAIN THIS VALUE
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi					;READ MIDI PITCH VALUES
	iamp	ampmidi	1				;READ MIDI VELOCITY VALUES
	if	gkOnOff=0&&iMIDIflag=0	then 		;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
	  turnoff					;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif						;END OF THIS CONDITIONAL BRANCH
	if iMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
	  kfreq	=	icps				;MAP MIDI NOTE VALUE TO kfreq
	  kamp	=	iamp				;MAP MIDI VELOCITY VALUES TO kamp
	else						;OTHERWISE...
	  kfreq	portk	gkfreq, kporttime		;USE FLTK VALUE FOR FREQUENCY
	  kamp	portk	gkamp, kporttime		;USE FLTK VALUE FOR AMPLITUDE
	endif						;END OF THIS CONDITIONAL BRANCH
	aenv	linsegr	0,0.01,1,0.01,0			;ANTI CLICK ENVELOPE
	;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | FUNCTION_TABLE
	asig	poscil	kamp*aenv,   kfreq,         gisine		;CREATE AN OSCILLATOR BASED ON THE SINE WAVE CREATED IN FUNCTION TABLE gisine
		out	asig						;OUTPUT OSCILLATOR SIGNAL TO THE OUTPUT
endin

instr	2	;SENSE STOP/RECORD FUNCTION WHENEVER A BUTTON-BANK BUTTON IS PRESSED
	ktrig	changed	gkFunction
	if ktrig==1 then
	 reinit	UPDATE
	endif
	UPDATE:
	if	i(gkFunction)=1	then		;IF 'RECORD' IS SELECTED...
		event_i	"i", 3, 0, 3600		;...TRIGGER INSTRUMENT 3
	elseif	i(gkFunction)=2	then		;OR IF 'PLAY' IS SELECTED...
		event_i	"i", 4, 0, 0.01		;TRIGGER 'PLAY' INSTRUMENT
	elseif	i(gkFunction)=0	then		;OR IF 'STOP' IS SELECTED...
		FLsetVal	1,0,gihPause	;DEACTIVATE PAUSE BUTTON
	endif
endin

instr	3	;RECORD SOUND USING fout
	if	gkFunction!=1	then		;SENSE IF FLTK 'Record' SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
	  turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH
	asig	monitor				;MONITOR ALL OF CSOUNDS AUDIO OUTPUT ON THE FIRST (ONLY) AUDIO CHANNEL
	if	gkPause!=1 then			;IF PAUSE IS NOT ACTIVE... 
	;	OPCODE	FILENAME     | FORMAT | OUT1  | OUT2 etc...
		fout	"output.wav",    8,     asig	;FORMAT '4' CREATES A 24 BIT WAV FILE (MONO). SEE THE CSOUND MANUAL FOR INFORMATION REGARDING OTHER FORMATS AVAILABLE. 
	endif					;END OF THIS CONDITIONAL BRANCH
endin

instr	4	;PLAYBACK
	if	gkFunction!=2	then		;SENSE IF FLTK 'Function' SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
	  turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	ifilelen	filelen	"output.wav"	;DERIVE ifilelen FROM RECORDED FILE
	p3	=	ifilelen		;p3 (NOTE DURATION) WILL BE EQUAL TO DURATION OF RECORDED FILE
	asig	soundin	"output.wav", 0		;READ SOUND FROM STORED FILE USING soundin
		out	asig * gkPBamp		;SEND AUDIO TO OUTPUT
	event_i "i", 5, p3, 0.001		;TRIGGER INSTRUMENT TO DEACTIVATE PLAY BUTTON WHEN PLAYBACK HAS BEEN COMPLETED
endin
	
instr	5	;DEACTIVATE PLAY BUTTON
	FLsetVal_i	0, gihFunction
endin

</CsInstruments>

<CsScore>
i 2 0 3600
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>