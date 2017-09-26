moogladder.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -+rtmidi=virtual -M0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 205, 50,255, 50	;SET INTERFACE COLOURS
;					LABEL       | WIDTH | HEIGHT | X | Y
				FLpanel	"moogladder",  500,    180,    0,  0

;CREATE A FLTK VIRTUAL KEYBOARD WITHIN THIS WINDOW
FLvkeybd "", 500,  100, 0, 70

;TEXT BOXES - blank out top part of virtual keyboard
;					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 	1,      5,     14,    500,    40,     0, 70

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",       60,    20,   115,  80
idres				FLvalue	" ",       60,    20,   185,  80
idvol				FLvalue	" ",       60,    20,   415,  80

FLsetColor	255,255,150,idcf
FLsetColor	255,255,150,idres
FLsetColor	255,255,150,idvol

;KNOBS						MIN | MAX | EXP | TYPE |   DISP    | WIDTH | X | Y
gkcf, ihcf	FLknob 		"Cutoff", 	20,  20000, -1,    1,     idcf,        60, 115,  5
gkres, ihres	FLknob 		"Resonance", 	0,       1,  0,    1,     idres,       60, 185,  5
gkvol, ihvol	FLknob 		"Volume", 	0,       1,  0,    1,     idvol,       60, 415,  5

FLsetColor	200,200,200,ihcf
FLsetColor	200,200,200,ihres
FLsetColor	200,200,200,ihvol

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkKybdTrack,ihKybdTrack		FLbutton	"",	1,    0,     2,    30,     20,   255, 25,    -1
FLsetColor	200,200,200,ihKybdTrack
FLsetColor2	 50,255, 50,ihKybdTrack
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Keyboard Tracking", 	1,      1,     13,    115,    20,   285,  25

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 		3,      1,     14,    100,   100,     5,   5
ih		 	FLbox  	"Waveform", 	1,      2,     14,     90,    15,    10,   7
FLsetTextSize	13,ih
ih		 	FLbox  	"Sawtooth", 	1,      1,     14,     60,    20,    40,  30
FLsetTextSize	12,ih
ih		 	FLbox  	"Square", 	1,      1,     14,     50,    20,    40,  50
FLsetTextSize	12,ih
ih		 	FLbox  	"Noise", 	1,      1,     14,     47,    20,    40,  70
FLsetTextSize	12,ih
	
;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,    240		;NUMBERS MADE INVISIBLE

;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkwaveform, ihwaveform		FLbutBank	12,     1,     3,     25,     60,    15, 30,   -1
FLsetColor	255,50,50,ihwaveform

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	500, 	ihcf
				FLsetVal_i	0.5, 	ihres
				FLsetVal_i	0.5, 	ihvol
				FLsetVal_i	1, 	ihKybdTrack
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 300, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         moogladder                          ", 	1,      6,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    15,     5,  20
ih		 	FLbox  	"Moogladder is an emulation of the moog ladder resonant       ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"low-pass filter.                                             ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The opcode's input arguments include cutoff frequency and    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"resonance.                                                   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"The input signal used in this example can be either a        ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"sawtooth waveform, a square waveform or pink noise. The      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"frequency of the oscillator is determined by the notes played", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"on the virtual keyboard widget. If 'keyboard tracking' is    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"active, cutoff is always the same ratio above the frequency  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of the note played (as determined by the setting of the      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"'Cutoff' knob - [ratio = note_freq/20]. This way all notes   ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"across the full range of the keyboard should sound equally   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"bright.                                                      ", 	1,      5,     14,    490,    15,     5, 280

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1                                                       
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	icps	cpsmidi				;read oscillator frequency from midi input
	kcf	portk	gkcf,  kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE	
	if gkwaveform==0 then
	 asig		vco2 		0.5, icps, 0	;GENERATE A SAWTOOTH WAVEFORM
	elseif gkwaveform==1 then
	 asig		vco2 		0.5, icps, 2, 0.5	;GENERATE A SQUARE WAVEFORM
	else
	 asig		pinkish		0.5
	endif	
	
	if gkKybdTrack==1 then				;if keyboard tracking switch is on...
	 kratio	=	kcf/20				;derive cutoff frequency as a ratio with minimum frequency
	 kcf	limit	icps*kratio,20,sr/2	;derive cutoff frequency from this ratio and and note played
	endif
	ares 		moogladder 	asig, kcf, gkres
	aenv		linsegr		-70,0.01,0,0.01,-70
			out		ares*ampdb(aenv)*gkvol	;FILTER OUTPUT IS SENT TO THE AUDIO OUTPUTS AND RESCALED USING gkgain SLIDER VARIABLE
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>