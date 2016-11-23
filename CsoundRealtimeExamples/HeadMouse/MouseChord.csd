WRITTEN BY IAIN MCCURDY, 2010

Mouse Chord
-----------
This csd was originally written for use by someone who only had the use of a head-mouse for music performance.
If the mouse enters one of the coloured boxes the chord indicated by the Roman numeral is played. 
Continuous dynamic control is possible by moving the mouse within the box: the dynamic is lowest at the edges of each box and highest at the centre of each box.
Dynamics are implemented with a changing tone (low-pass filter) as well as changing amplitude.
The user can choose between three different sounds using the radio buttons within the GUI.
Key and tonality (major/minor) can also be selected from within the GUI.
No clicking is required enabling better timing in performance. The GUI window needs to be in focus for this to work.
The main opcode used in sensing mouse position is FLxyin.
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

sr	= 	44100
ksmps	= 	16
nchnls	= 	2
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH
giXRescaleFactor	init	0.7	;ADJUST THIS VALUE TO RESCALE THE SIZE AND LOCATION OF WIDGETS. THIS MAY BE USEFUL FOR USERS OF NETBOOKS
giYRescaleFactor	init	0.7	;ADJUST THIS VALUE TO RESCALE THE SIZE AND LOCATION OF WIDGETS. THIS MAY BE USEFUL FOR USERS OF NETBOOKS
zakinit	4,10
gkRvbSze	init	0.85
gkRvbSnd	init	0.2

FLcolor	255, 255, 255, 0, 0, 0	;SET DEFAULT COLOURS OF PANEL AND WIDGETS
;	LABEL         | WIDTH | HEIGHT | X | Y
FLpanel	"Mouse Chord",  1100*giXRescaleFactor,    800*giYRescaleFactor,    0,  0

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkoct, ihoct 			FLcount  "Octave", 	-2,     2,     1,      1,      2,   100,     25,   600,  5,   -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS		FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkkey, ihkey		FLbutBank	14,    12,     1,    360,      20,   100, 5,    -1
gkton, ihton		FLbutBank	14,     1,     2,     20,      40,   500, 5,    -1
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
gksound, ihsound	FLbutBank	12,     1,     3,     30,      60,    0,  5,    -1

;SET INITIAL VALUES OF VALUATORS
FLsetVal_i	-1, ihoct
FLsetVal_i	1, ihsound

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Strings", 		1,       5,    12,    50,    20,     40,  5
ih		 	FLbox  	"Choir  ", 		1,       5,    12,    50,    20,     40, 25
ih		 	FLbox  	"Flute  ", 		1,       5,    12,    50,    20,     40, 45
ih		 	FLbox  	"C", 			1,       5,    12,    20,    10,    100, 30
ih		 	FLbox  	"C#", 			1,       5,    12,    20,    10,    130, 30
ih		 	FLbox  	"D", 			1,       5,    12,    20,    10,    160, 30
ih		 	FLbox  	"D#", 			1,       5,    12,    20,    10,    190, 30
ih		 	FLbox  	"E", 			1,       5,    12,    20,    10,    220, 30
ih		 	FLbox  	"F", 			1,       5,    12,    20,    10,    250, 30
ih		 	FLbox  	"F#", 			1,       5,    12,    20,    10,    280, 30
ih		 	FLbox  	"G", 			1,       5,    12,    20,    10,    310, 30
ih		 	FLbox  	"G#", 			1,       5,    12,    20,    10,    340, 30
ih		 	FLbox  	"A", 			1,       5,    12,    20,    10,    370, 30
ih		 	FLbox  	"A#", 			1,       5,    12,    20,    10,    400, 30
ih		 	FLbox  	"B", 			1,       5,    12,    20,    10,    430, 30
ih		 	FLbox  	"major", 		1,       5,    12,    40,    20,    520,  5
ih		 	FLbox  	"minor", 		1,       5,    12,    40,    20,    520, 25

;DEFINE WIDTH AND HEIGHT OF EACH BOX...
giwidth	=	200*giXRescaleFactor
giheight=	200*giYRescaleFactor
;DEFINE A MACRO TO CREATE EACH BOX. INPUT ARGUMENTS FOR X-POSITION, Y-POSITION, NUMBER ANN COLOUR (RED, GREEN, BLUE)
#define	CHORD_BOX(LABEL'X'Y'N'R'G'B)	
#

gix$N	=	$X*giXRescaleFactor	;GLOBAL VARIABLE FOR X-LOCATION OF THIS BOX (WILL BE USED WITH MOUSE DETECTION IN INSTR 1)
giy$N	=	$Y*giYRescaleFactor	;GLOBAL VARIABLE FOR Y-LOCATION OF THIS BOX (WILL BE USED WITH MOUSE DETECTION IN INSTR 1)
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH  | HEIGHT  | X   | Y
ih$N		FLbox  	"$LABEL", 	4,      10,   100*giYRescaleFactor,  giwidth, giheight, gix$N,giy$N

FLsetColor	$R,$G,$B,ih$N	;SET BOX COLOUR
#
;EXECUTE MACROS:
;          L    X   Y  N  R   G   B
$CHORD_BOX(I'   50'200'1'100'255'255)
$CHORD_BOX(II' 300'200'2'255'100'255)
$CHORD_BOX(III'550'200'3'255'255'100)
$CHORD_BOX(IV' 800'200'4'100'100'255)
$CHORD_BOX(V'  150'550'5'255'100'100)
$CHORD_BOX(VI' 400'550'6'100'255'100)
$CHORD_BOX(VII'650'550'7'0'100'255)

FLpanel_end

FLrun

;FUNCTION TABLES STORING LEFT CHANNELS OF SOUNDS
gisound1L	ftgen	0,0,0,1,"violins.wav",0,0,1
gisound2L	ftgen	0,0,0,1,"choir.wav",0,0,1
gisound3L	ftgen	0,0,0,1,"flute.wav",0,0,1

;FUNCTION TABLES STORING RIGHT CHANNELS OF SOUNDS
gisound1R	ftgen	0,0,0,1,"violins.wav",0,0,2
gisound2R	ftgen	0,0,0,1,"choir.wav",0,0,2
gisound3R	ftgen	0,0,0,1,"flute.wav",0,0,2

;DEFINE CHORDS I-VII IN PCH FORMAT FOR MAJOR KEY
gichord1	ftgen	0,0,4,-2,8.00,8.04,8.07,9.00
gichord2	ftgen	0,0,4,-2,8.02,8.05,8.09,9.02
gichord3	ftgen	0,0,4,-2,8.04,8.07,8.11,9.04
gichord4	ftgen	0,0,4,-2,8.00,8.05,8.09,9.00
gichord5	ftgen	0,0,4,-2,7.11,8.02,8.07,8.11
gichord6	ftgen	0,0,4,-2,8.00,8.04,8.09,9.00
gichord7	ftgen	0,0,4,-2,8.02,8.05,8.11,9.02

;DEFINE CHORDS I-VII IN PCH FORMAT FOR MINOR KEY
gichord1m	ftgen	0,0,4,-2,8.00,8.03,8.07,9.00
gichord2m	ftgen	0,0,4,-2,8.02,8.05,8.08,9.02
gichord3m	ftgen	0,0,4,-2,8.03,8.07,8.11,9.03
gichord4m	ftgen	0,0,4,-2,8.05,8.08,8.00,9.05
gichord5m	ftgen	0,0,4,-2,8.07,8.11,8.02,9.07
gichord6m	ftgen	0,0,4,-2,8.08,8.00,8.03,9.08
gichord7m	ftgen	0,0,4,-2,8.02,8.05,8.11,9.02

;UDOS-(USER DEFINED OPCODES)------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
opcode	reverbsr, aa, aakk						;REVERB UDO (USE OF A UDO FOR REVERB IS TO ALLOW THE SETTING OF A K-RATE INDEPENDENT OF THE GLOBAL K-RATE
	setksmps	1						;CONTROL RATE WITHIN UDO IS 1
	ainsigL, ainsigR, kfblvl, kfco	xin				;NAME INPUT VARIABLES
	arvbL, arvbR 	reverbsc 	ainsigL, ainsigR, kfblvl, kfco	;USE reverbsc OPCODE
	xout	arvbL, arvbR						;SEND AUDIO TO CALLER INSTRUMENT
endop									;END OF UDO
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

instr	1
	iporttime	=	0.05				;PORTAMENTO TIME
	kporttime	linseg	0,0.001,iporttime,1,iporttime	;FUNCTION THAT QUICKLY RAMPS UP TO PORTAMENTO TIME

#define	CHORD_BOX_DETECT(N)
	#
	;SENSE IF MOUSE IS WITHIN THIS BOX AND MOUSE LOCATION WITHIN THIS BOX 
	;KOUTX, KOUTY, KINSIDE   FLXYIN   IOUTX_MIN,   IOUTX_MAX,    IOUTY_MIN,   IOUTY_MAX,    IWINDX_MIN,   IWINDX_MAX,   IWINDY_MIN,   IWINDY_MAX 	 [, IEXPX, IEXPY, IOUTX, IOUTY] 
	kx$N,   ky$N,  kinside$N FLxyin -0.707106781, 0.707106781, -0.707106781, 0.707106781,      gix$N,    gix$N+giwidth,    giy$N,    giy$N+giheight	; [, iexpx, iexpy, ioutx, iouty] 
	
	;MOUSE LOCATION IS DEFINED AS A VALUE THAT WILL BE ZERO IF OUTSIDE OR ON THE EDGE OF THE BOX, AND RISE EXPONENTIALLY TO A VALUE OF 1 AT THE CENTRE OF THE BOX
	gk$N	=	1 - (((kx$N^2) + (ky$N^2))^0.5)	
	zkw	gk$N^3, $N-1	;WRITE LOCATION VALUE TO ZAK VARIABLE
	
	ktrig$N	changed	kinside$N	;OUTPUT A MOMENTARY '1' VIA ktrig$N IF kinside$N CHANGES, I.E. IF THE MOUSE ENTERS OR LEAVES THIS CHORD BOX
	if	ktrig$N=1	then	;IF MOUSE HAS ENTERED OR LEFT THIS CHORD BOX (I.E. IF ktrig$N has taken a value of 1)...
		if	kinside$N=1	then	;IF MOUSE IS IN THE BOX...
			event	"i", 2, 0, 3600, $N	;PLAY A LONG NOTE INSTRUMENT $N
		elseif	kinside$N=0	then	;IF MOUSE HAS JUST LEFT THE BOX...
			turnoff2	2, 0, 1	;TURNOFF INSTRMENT $N ALLOWING RELEASE STAGES TO BE COMPLETED
		endif				;END OF CONDITIONAL BRANCHING
	endif
	#
	;EXECUTE MACRO FOR EACH BOX...
	$CHORD_BOX_DETECT(1)
	$CHORD_BOX_DETECT(2)
	$CHORD_BOX_DETECT(3)
	$CHORD_BOX_DETECT(4)
	$CHORD_BOX_DETECT(5)
	$CHORD_BOX_DETECT(6)
	$CHORD_BOX_DETECT(7)
endin

instr	2
	;ipch2	table	1, gichord1 + p4 - 1	;PITCH OF FIRST NOTE OF CHORD
	;ipch3	table	2, gichord1 + p4 - 1	;PITCH OF SECOND NOTE OF CHORD
	;ipch4	table	3, gichord1 + p4 - 1	;PITCH OF THIRD NOTE OF CHORD
	aenv	expsegr	0.001,0.2,1,1,0.001	;AMPLITUDE ENVELOPE
	
	;DEFINE MACRO OF CODE TO PRODUCE EACH NOTE OF THE CHORD
#define	NOTE(N)
	#
	;DEFINE FUNCTION TABLE NUMBER BASED ON THE SOUND CHOSEN VIA THE FLTK RADIO BUTTONS
	ifnL	=	gisound1L + i(gksound)	;LEFT CHANNEL
	ifnR	=	gisound1R + i(gksound)	;RIGHT CHANNEL
	
	if	i(gkton)=0	then	;IF TONALITY IS 'MAJOR'...
		ipch$N	table	$N-1, gichord1 + p4 - 1	;DEFINE PITCH (PCH FORMAT) FOR THIS NOTE (MAJOR)
	else				;OTHERWISE TONALITY MUST BE MINOR...
		ipch$N	table	$N-1, gichord1m + p4 - 1;DEFINE PITCH (PCH FORMAT) FOR THIS NOTE (MINOR)
	endif				;ENDO OF CONDITIONAL BRANCHING
	imlt$N		=	cpspch(ipch$N + (i(gkkey)*0.01) + i(gkoct))/cpsoct(8.00)	;CONVERT PCH TO A RATIO
	ilen		=	nsamp(ifnL)/sr							;DERIVE LENGTH OF THE SAMPLE
	aL$N		flooper 0.3, imlt$N, 0, ilen-2, 1, ifnL			;CREATE AUDIO SIGNAL USING FLOOPER2 OPCODE (LEFT CHANNEL)
	aR$N		flooper 0.3, imlt$N, 0, ilen-2, 1, ifnR			;CREATE AUDIO SIGNAL USING FLOOPER2 OPCODE (RIGHT CHANNEL)
	#
	;EXECUTE MACRO FOR EACH NOTE
	$NOTE(1)
	$NOTE(2)
	$NOTE(3)
	$NOTE(4)
	
	;SUM (MIX) THE FOUR NOTES
	aL	sum	aL1, aL2, aL3, aL4
	aR	sum	aR1, aR2, aR3, aR4
	
	kamp	zkr	p4 - 1		;READ AMPLITUDE FROM ZAK VARIABLE
	kamp	port	kamp, 0.05	;APPLY PORTAMENTO (TO PREVENT QUANTISATION / ZIPPER NOISE)
	aamp	interp	kamp		;INTERPOLATE TO CREATE AN AUDIO RATE VERSION OF THIS VARIABLE
	
	kcfoct	=	(8*kamp)+6	;DEFINE A FILTER CUTOFF FREQUENCY WHICH IS RELATED TO DISTANCE FROM THE CENTRE OF THE BOX
	
	aL	tone	aL, cpsoct(kcfoct)	;APPLY LOW PASS FILTERING (TONE CONTROL)
	aR	tone	aR, cpsoct(kcfoct)	;APPLY LOW PASS FILTERING (TONE CONTROL)
	
	aL	=	aL * aenv * aamp	;SCALE AUDIO SIGNAL WITH AMPLITIUDE ENVELOPE AND
	aR	=	aR * aenv * aamp
	outs	aL, aR
		zawm	aL * gkRvbSnd, 0                      ;SEND SOME OF THE AUDIO TO THE REVERB VIA ZAK PATCHING (LEFT CHANNEL) 
		zawm	aR * gkRvbSnd, 1                      ;SEND SOME OF THE AUDIO TO THE REVERB VIA ZAK PATCHING (RIGHT CHANNEL)

endin

instr	1000	;REVERB
	ainL	zar	0	;READ IN AUDIO FROM ZAK CHANNELS
	ainR	zar	1	;READ IN AUDIO FROM ZAK CHANNELS
	denorm		ainL, ainR		;...DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
		arvbL, arvbR 	reverbsr 	ainL, ainR, gkRvbSze, 10000	;CREATE REVERBERATED SIGNAL (USING UDO DEFINED ABOVE)
	outs	arvbL, arvbR					;SEND AUDIO TO OUTPUTS
	zacl	0,3						;CLEAR ZAK AUDIO CHANNELS
endin


</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING)
i 1000 0 3600
</CsScore>

</CsoundSynthesizer>

