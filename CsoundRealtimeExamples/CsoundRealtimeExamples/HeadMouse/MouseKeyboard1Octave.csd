Written by Iain McCurdy, 2010

Mouse Keyboard (1 octave)
-------------------------
Additional user controls are located within the code! See below.
This csd was originally written for use by someone who only had the use of a head-mouse for music performance.
A graphical keyboard is drawn on the screen. Notes are played by moving the mouse over a particular key. 
As well as activating that note, dynamic control is possible by moving the mouse vertically up the key. 
As the user moves the mouse right to the very top of the key, a modulation effect is also intorduced. 
No clicking is required enabling better timing in performance. The GUI window needs to be in focus for this to work.
The user can change the functioning (or non-functioning) of the left click mouse button using a switch winthin the code - see below.
The user can choose between three different sounds using the radio buttons within the GUI.
Reverb and ping-pong delay effects are provided, the parameters of which the user can change in the code below.
The main opcodes used in sensing mouse position are FLxyin and FLmouse.
Resizing the window by dragging the window edges will upset the functionality of this csd. 
If the window needs to be resized, for example to accomodate use on a netbook, this needs to be done within the code. There are two global variables in the header statement of the orchestra for rescaling the width and the height of the interface easily.
Professional head mouse or iris tracking software can be very expensive and requires practice. 
Camera Mouse is a good free option for Windows users. It can be found at www.cameramouse.org.
iNavigate is a free option for Mac OS 10.5 if the user wants to experiment with this approach.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr		=	44100
ksmps		=	32
nchnls		=	2
0dbfs		=	1		;MAXIMUM AMPLITUDE LEVEL
giXRescaleFactor	init	1	;ADJUST THIS VALUE TO RESCALE THE SIZE AND LOCATION OF WIDGETS. THIS MAY BE USEFUL FOR USERS OF NETBOOKS
giYRescaleFactor	init	1	;ADJUST THIS VALUE TO RESCALE THE SIZE AND LOCATION OF WIDGETS. THIS MAY BE USEFUL FOR USERS OF NETBOOKS

;***OCTAVE BASE NOTE (THE PITCH OF THE LOWEST NOTE IN OCT FORMAT)********************************************
giOctaveBase	=	7
;************************************************************************************************************

;***THIS DEFINES THE TIME IT TAKES TO SLIDE BETWEEN NOTES. TRY VALUES WITHIN THE RANGE 0 - 0.3***************
giportamento	init	0.034
;************************************************************************************************************

;***THIS DEFINES THE AMOUNT OF DELAY EFFECT. TRY VALUES WITHIN THE RANGE 0-1. 0=NO DELAY, 1=LOTS OF DELAY!***
giDelayMix	init	0.02
;************************************************************************************************************

;***THIS DEFINES THE DELAY TIME IN SECONDS*******************************************************************
giDelayTime	init	0.6
;************************************************************************************************************

;***THIS DEFINES THE AMOUNT OF REVERB. TRY VALUES WITHIN THE RANGE 0-1. 0=NO REVERB, 1=LOTS OF REVERB!*******
giReverbMix	init	0.1
;************************************************************************************************************

;***THIS DEFINES THE AMOUNT OF TRANSPOSITION IN OCTAVES.*****************************************************
;***IDEALLY THIS SHOULD BE A WHOLE NUMBER, I.E. '1', '0', '-1' ETC.****************************************** 
giOctaveTranspose	init	0
;************************************************************************************************************

;***'Click' OPTION: THIS IS A THREE-WAY SWITCH. SET THIS TO '0', '1' OR '2' *********************************
;***0 = NO LEFT CLICK IS REQUIRED TO PLAY A NOTE. A NOTE PLAYS CONTINUOUSLY**********************************
;***1 = IT IS REQUIRED TO LEFT CLICK TO PLAY A NOTE**********************************************************
;***2 = LEFT CLICK STOPS A NOTE PLAYING**********************************************************************
giClick	init	0
;************************************************************************************************************

;***THIS DEFINES THE HEIGHT OF THE PANEL. TRY VALUES WITHIN THE RANGE 100 - 800******************************
giheight	init	400 * giYRescaleFactor
;************************************************************************************************************

;SET DEFAULT COLOURS FOR FLTK PANEL AND WIDGETS
FLcolor	200, 200, 255, 0, 0, 0

;		OPCODE	LABEL              | WIDTH | HEIGHT   | X | Y
		FLpanel	"Mouse Keyboard",    1260 * giXRescaleFactor,   giheight, 10, 10

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   200,  200,   255		;NUMBERS MADE INVISIBLE

FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y          | IOPCODE | P1 | P2 | P3
gksound, ihsound	FLbutBank	12,     1,     3,     30,      60,    0, giheight-60,     -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;SET INITIAL VALUES
FLsetVal_i	2,ihsound			
			
;TEXT BOXES						ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Strings", 		1,       5,    12,    50,    20,     40, giheight-60
ih		 	FLbox  	"Choir  ", 		1,       5,    12,    50,    20,     40, giheight-40
ih		 	FLbox  	"Flute  ", 		1,       5,    12,    50,    20,     40, giheight-20

;SET COLOURS FOR WHITE NOTES...
;		FLcolor ired, igreen, iblue
		FLcolor 255,   255,    255

;MAKE SETTINGS FOR NOTE WIDTH, HEIGHT AND LOCATION
iwidth	=	(1260/13) * giXRescaleFactor
ix	=	2
iheight	=	giheight-60
isize	=	25 * giYRescaleFactor

;DRAW WHITE NOTES...
;BORDERS				TYPE | FONT |  SIZE  |  WIDTH  | HEIGHT |  X  | Y
ih		 	FLbox  	"C ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"D ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"E ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0
ix	=	ix+iwidth
ih		 	FLbox  	"F ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"G ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"A ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"B ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0
ix	=	ix+iwidth
ih		 	FLbox  	"C ", 	6,       9,   isize,   iwidth,  iheight,   ix,  0

;SET COLOURS FOR BLACK NOTES...
;		FLcolor ired, igreen, iblue
		FLcolor 0,      0,      0

;DRAW BLACK NOTES...
ix	=	1+iwidth
ih		 	FLbox  	"C#", 	6,       9,   isize,   iwidth,     iheight,  ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"D#", 	6,       9,   isize,   iwidth,     iheight,  ix,  0
ix	=	ix+(iwidth*3)
ih		 	FLbox  	"F#", 	6,       9,   isize,   iwidth,     iheight,  ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"G#", 	6,       9,   isize,   iwidth,     iheight,  ix,  0
ix	=	ix+(iwidth*2)
ih		 	FLbox  	"A#", 	6,       9,   isize,   iwidth,     iheight,  ix,  0

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD!


;SOUND FILES (LEFT CHANNELS)
gisound1L	ftgen	0,0,0,1,"violins.wav",0,0,1
gisound2L	ftgen	0,0,0,1,"choir.wav",0,0,1
gisound3L	ftgen	0,0,0,1,"flute.wav",0,0,1

;SOUND FILES (RIGHT CHANNELS)
gisound1R	ftgen	0,0,0,1,"violins.wav",0,0,2
gisound2R	ftgen	0,0,0,1,"choir.wav",0,0,2
gisound3R	ftgen	0,0,0,1,"flute.wav",0,0,2

gisine	ftgen	0,0,4096,10,1	;A SINE WAVE	

;TABLE TO MAP MOUSE LOCATION ALONG THE Y-AXIS TO VARIOUS CONTROL PARAMETERS
giampscale	ftgen	0,0,1024,7,0,240,1,1024-240,1
gimodscale	ftgen	0,0,1024,7,0,600,0,1024-600,1
giLPFscale	ftgen	0,0,1024,7,0,800,1,224,1

;INITIALISE ZAK SPACE FOR VARIABLE STORAGE
		zakinit	2,1

instr 	1	;SENSES MOUSE POSITION AND PLAYS SOUND (ALWAYS ON)
	ktrigger	changed	gksound	;IF SOUND SWITCH IS CHANGED GENERATE A MOMENTARY '1'
	if	ktrigger=1	then	;IF TRIGGER IS '1'
		reinit	START		;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif				;END OF CONDITIONAL BRANCHING
	START:				;LABEL 'START'
	giampport	init	0.02	;DEFINE AMPLITUDE PORTAMENTO TIME (SMOOTHING)
	gkmodfrq	init	5	;DEFINE MODULATION FREQUENCY (VIBRATO/TREMOLO)
	gkvibdep	init	0.02	;DEFINE MAXIMUM VIBRATO DEPTH (PITCH MODULATION)
	gktrmdep	init	0.2	;DEFINE MAXIMUM TREMOLO DEPTH (AMPLITUDE MODULATION)
	
	;SENSE MOUSE POSITION...
	ioffset	=	0.0005	;USE THIS FOR FINE TUNING THE SWITCH POINTS BETWEEN NOTES SO THAT GRAPHICAL POSITION OF THE MOUSE OVER THE KEYBOARD CORRESPONDS WITH NOTE SWITCHING
	;koutx, kouty, kinside	FLxyin  ioutx_min,            ioutx_max,                    iouty_min, iouty_max,   iwindx_min,  iwindx_max,                 iwindy_min,               iwindy_max [, iexpx, iexpy, ioutx, iouty] 
	kx,      ky,    kinside	FLxyin  giOctaveBase+ioffset, giOctaveBase+1+ioffset+(1/12),  0,         1,          0,        1259*giXRescaleFactor,       10,         giheight-60; [, iexpx, iexpy, ioutx, iouty] 
	kx2,     ky2,   kgate	FLxyin  giOctaveBase+ioffset, giOctaveBase+1+ioffset+(1/12),  0,         1,         10,        1250*giXRescaleFactor,        3,         giheight-60; [, iexpx, iexpy, ioutx, iouty] 

	;CHECK TO SEE WHICH LEFT CLICK BUTTON MODE HAS BEEN SELECTED AND IMPLEMENT THE APPROPRIATE BEHAVIOUR
	if	giClick=1	then			;IF 'LEFT CLICK ACTIVATES NOTE' MODE HAS BEEN SELECTED...
		kx3, ky3, kb1, kb2, kb3 FLmouse	2
		ky	=	ky * kb1
	elseif	giClick=2	then			;IF 'LEFT CLICK DE-ACTIVATES NOTE' MODE HAS BEEN SELECTED...
		kx3, ky3, kb1, kb2, kb3 FLmouse	2
		ky	=	ky * (1-kb1)
	endif						;END OF CONDITIONAL BRANCHING
	
	kamp		table	ky, giampscale,1	;CREATE AN AMPLITUDE VALUE ACCORDING TO Y POSITION (ky) ON KEY AND AMPLITUDE SCALING TABLE (giampscale)
	kamp		port	kamp*kgate, giampport	;SMOOTH AMPLITUDE VARIABLE USING port OPCODE (A KIND OF LOW PASS FILTER FOR K-RATE SIGNALS)
	koctave		=	int(kx)			;DERIVE OCTAVE FROM MOUSE 'X' LOCATION
	kfrac		=	frac(kx)		;REDUCE FRACTIONAL PART OF MOUSE 'X' LOCATION
	ksemis		=	int(kfrac*12)/12	;CONVERT TO A SEMITONES VALUE (OCT FORMAT)
	
	koct		port	koctave+ksemis+giOctaveTranspose, giportamento	;COMBINE OCTAVE, SEMITONES AND TRANSPOSE VALUES AND APPLY PORTAMENTO SMOOTHING
	kmoddepth	table	ky, gimodscale,1		;CREATE AN MODULATION DEPTH VALUE ACCORDING TO Y POSITION (ky) ON KEY AND MODULATION DEPTH SCALING TABLE (gimodscale)				;
	kmoddepth	port	kmoddepth, giampport		;APPLY PORTAMENTO SMOOTHING
	kmod		oscili	kmoddepth, gkmodfrq, gisine	;CREATE AN LFO FOR MODULATION
	koct		=	koct + (kmod*gkvibdep)		;APPLY VIBRATO
	
	ktrm		oscili	gktrmdep*.5*kmoddepth, gkmodfrq, gisine	;CREATE TREMOLO LFO
	ktrm		=	ktrm+.5					;ADD OFFSET

	kmlt		=	cpsoct(koct)/cpsoct(8)		;CONVERT PITCH IN OCT FORMAT TO A PLAYBACK RATIO (BASE KEY/FREQUENCY A.440)
	ifnL		=	gisound1L + i(gksound)		;DEFINE FUNCTION TABLE TO USE FOR LEFT CHANNEL SAMPLE
	ifnR		=	gisound1R + i(gksound)		;DEFINE FUNCTION TABLE TO USE FOR RIGHT CHANNEL SAMPLE
	ilen		=	nsamp(ifnL)/sr			;DERIVE FUNCTION TABLE (SAMPLE) LENGTH (IN SECONDS)
	aL		flooper kamp*ktrm, kmlt, 0, ilen-2, 1, ifnL	;CREATE AUDIO SIGNAL (LEFT CHANNEL) USING flooper SAMPLE LOOPING OPCODE
	aR		flooper kamp*ktrm, kmlt, 0, ilen-2, 1, ifnR	;CREATE AUDIO SIGNAL (RIGHT CHANNEL) USING flooper SAMPLE LOOPING OPCODE
	rireturn						;RETURN FROM REINITIALISATION PASS

	kcfoct		table	ky, giLPFscale, 1		;CREATE AN FILTER CUTOFF VALUE (OCT FORMAT) ACCORDING TO Y POSITION (ky) ON KEY AND FILTER CUTOFF SCALING TABLE (giLPFscale)				;
	kcfoct		=	(kcfoct*7)+7			;RE-RANGE AND OFFSET FILTER CUTOFF VALUE
	kcf		=	cpsoct(kcfoct)			;CONVERT FROM OCT TO CPS FORMAT
	kcf		port	kcf, giampport			;APPLY PORTAMENTO SMOOTHING
	aL		clfilt	aL, kcf, 0, 2
	aR		clfilt	aR, kcf, 0, 2

			zawm	aL, 1				;WRITE TO ZAK VARIABLE WITH MIXING (LEFT CHANNEL)
			zawm	aR, 2				;WRITE TO ZAK VARIABLE WITH MIXING (RIGHT CHANNEL)
endin	

instr	2	; PING PONG DELAY
	idlyFB	init	0.3		;DELAY FEEDBACK AMOUNT (0 - 1)
	iRoomSize	init	0.9	;REVERB ROOM SIZE (0 - 1)
	iHFDamp	init	0.5		;REVERB HIGH FREQUENCY DAMPING (0 - 1)
		
	ainL		zar	1	;READ ZAK AUDIO VARIABLE LEFT CHANNEL (WRITTEN BY INSTR 1)
	ainR		zar	2	;READ ZAK AUDIO VARIABLE RIGHT CHANNEL (WRITTEN BY INSTR 1)
	
	;LEFT CHANNEL OFFSETTING DELAY (NO FEEDBACK!)
	aBuffer		delayr	giDelayTime * 0.5	;INITIALISE DELAY BUFFER
	aLeftOffset	deltap3	giDelayTime * 0.5	;READ AUDIO FROM DELAY TAP 
			delayw	ainL			;WRITE AUDIO INTO BUFFER
			
	;LEFT CHANNEL DELAY WITH FEEDBACK
	aBuffer		delayr	giDelayTime			;INITIALISE DELAY BUFFER
	aDlySigL	deltap3	giDelayTime			;READ AUDIO FROM DELAY TAP
			delayw	aLeftOffset+(aDlySigL*idlyFB)	;WRITE AUDIO INTO BUFFER
	
	;RIGHT CHANNEL DELAY WITH FEEDBACK
	aBuffer		delayr	giDelayTime			;INITIALISE DELAY BUFFER
	aDlySigR	deltap3	giDelayTime			;READ AUDIO FROM DELAY TAP
			delayw	ainR+(aDlySigR * idlyFB)	;WRITE AUDIO INTO BUFFER
	
	amixL		ntrpol	ainL, aDlySigL+aLeftOffset, giDelayMix	;CREATE DRY/WET MIX FOR PING-PONG DELAY (LEFT CHANNEL)
	amixR		ntrpol	ainR, aDlySigR, giDelayMix		;CREATE DRY/WET MIX FOR PING-PONG DELAY (RIGHT CHANNEL)
	
			denorm		amixL, amixR	;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
	arvbL, arvbR 	freeverb 	amixL, amixR, iRoomSize, iHFDamp , sr	;CREATE REVERB SIGNAL USING freeverb OPCODE
	amixL		ntrpol		amixL, arvbL, giReverbMix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
	amixR		ntrpol		amixR, arvbR, giReverbMix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
			outs	amixL, amixR	;SEND DELAY OUTPUT SIGNALS TO THE SPEAKERS
			zacl	1,2	;CLEAR ZAK VARIABLES
endin

</CsInstruments>

<CsScore>
i 1 0 3600		;SOUND PRODUCING INSTRUMENT
i 2 0 3600		;PING-PONG DELAY AND REVERB
</CsScore>

</CsoundSynthesizer>
