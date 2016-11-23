WRITTEN BY IAIN MCCURDY, 2010

Mouse Bass
----------
This csd was originally written for use by someone who only had the use of a head-mouse for music performance.
The notes of the chromatic scale are arranged in coloured boxes according to the circle of fifths as this is perhaps the arrangement that is most useful to a bass guitarist.
If the mouse enters one of the boxes the note indicated by its label is played. If the mouse leaves the box the note is stopped (with a short release segment).
No clicking is required enabling better timing in performance. The GUI window needs to be in focus for this to work.
The main opcode used in sensing mouse position is FLxyin.
Resizing the window by dragging the window edges will upset the functionality of this csd. 
If the window needs to be resized, for example to accomodate use on a netbook, this needs to be done within the code.
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
giXRescaleFactor	init	1	;ADJUST THIS VALUE TO RESCALE THE SIZE AND LOCATION OF WIDGETS. THIS MAY BE USEFUL FOR USERS OF NETBOOKS OR TABLETS
giYRescaleFactor	init	1	;ADJUST THIS VALUE TO RESCALE THE SIZE AND LOCATION OF WIDGETS. THIS MAY BE USEFUL FOR USERS OF NETBOOKS OR TABLETS

FLcolor	255, 255, 255, 0, 0, 0
;	LABEL         | WIDTH | HEIGHT | X | Y
FLpanel	"Mouse Bass",    800*giXRescaleFactor,    800*giYRescaleFactor,    0,  0
;DEFINE WIDTH AND HEIGHT FOR BOXES
giwidth	=	100*giXRescaleFactor
giheight=	100*giYRescaleFactor
;DEFINE A MACRO FOR NOTE BOX WITH VARIABLES FOR LABEL, X-LOCATION, Y-LOCATION, NUMBER AND COLOUR (RED/GREEN/BLUE)
#define	NOTE_BOX(LABEL'X'Y'N'R'G'B)	
#
gix$N	=	$X*giXRescaleFactor	;GLOBAL VARIABLE FOR X-LOCATION OF THIS BOX (WILL BE USED WITH MOUSE DETECTION IN INSTR 1)
giy$N	=	$Y*giYRescaleFactor	;GLOBAL VARIABLE FOR Y-LOCATION OF THIS BOX (WILL BE USED WITH MOUSE DETECTION IN INSTR 1)
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH  | HEIGHT  | X   | Y
ih$N		FLbox  	"$LABEL", 	1,       1,    30,  giwidth, giheight, gix$N,giy$N	;BOX LABEL (NOTE NAME)

FLsetColor	$R,$G,$B,ih$N	;SET BOX COLOUR
#
;EXECUTE MACROS:
;         L  X   Y  N  R   G   B
$NOTE_BOX(C'350' 50 '1'100'255'255)
$NOTE_BOX(G'490'110 '2'255'200'55)
$NOTE_BOX(D'610'220 '3'200'255'200)


$NOTE_BOX(A'650'350 '4'100'100'255)
$NOTE_BOX(E'610'480 '5'105'200'55)
$NOTE_BOX(B'490'600 '6'255'50'50)

$NOTE_BOX(Gb'350'650'7'255'100'255)
$NOTE_BOX(Db'220'600'8'55'200'255)
$NOTE_BOX(Ab' 90'480'9'255'200'55)

$NOTE_BOX(Eb'50'350'10'255'100'100)
$NOTE_BOX(Bb'90'220'11'0'200'100)
$NOTE_BOX(F'220'110'12'150'0'255)
FLpanel_end

FLrun

;FUNCTION TABLE STORING A SAMPLE OF A BASS GUITAR PLAYING A 'C'
giBassGuitarC	ftgen	0,0,0,-1,"BassGuitarC.wav",0,0,0

instr	1
	iporttime	=	0.05				;PORTAMENTO ITME
	kporttime	linseg	0,0.001,iporttime,1,iporttime	;FUNCTION THAT QUICKLY RAMPS UP TO PORTAMENTO TIME FROM ZERO 

;DEFINE A MACRO FOR DETECTION OF MOUSE WITHIN EACH BOX (THIS CODE WILL BE REPEATED FOR EACH BOX PRESENT) - INPUTS FOR NUMBER AND PITCH (PCH FORMAT)
#define	NOTE_BOX_DETECT(N'PCH)
	#
	;SENSE IF MOUSE IS WITHIN THIS BOX AND MOUSE LOCATION WITHIN THIS BOX 
	;koutx, kouty, kinside   FLxyin ioutx_min, ioutx_max, iouty_min, iouty_max, iwindx_min, iwindx_max, iwindy_min,  iwindy_max 	[, iexpx, iexpy, ioutx, iouty] 
	kx$N,   ky$N,  kinside$N FLxyin     0,         1,          0,         1,       gix$N,   gix$N+giwidth,   giy$N,    giy$N+giheight	; [, iexpx, iexpy, ioutx, iouty] 
		
	ktrig$N	changed	kinside$N	;CREATE A TRIGGER (MOMENTARY '1') IF MOUSE ENTERS OR LEAVES THIS BOX
	if	ktrig$N=1	then		;IF MOUSE HAS JUST ENTERED OR LEFT THIS BOX...
		if	kinside$N=1	then	;IF MOUSE HAS JUST ENTERED THIS BOX...
			event	"i", 2, 0, 5, $PCH	;CREATE A 5 SECOND NOTE EVENT FOR INSTR 2. PASS PITCH VIA p4
		elseif	kinside$N=0	then		;OR ELSE IF MOUSE HAS JUST LEFT THIS BOX 
			turnoff2	2, 0, 1		;TURNOFF INSTRUMENT 2
		endif					;END OF CONDITIONAL BRANCHING
	endif					;END OF CONDITIONAL BRANCHING
	#
	;EXECUTE MACRO FOR EACH BOX...
	$NOTE_BOX_DETECT(1'8.00)
	$NOTE_BOX_DETECT(2'7.07)
	$NOTE_BOX_DETECT(3'8.02)
	$NOTE_BOX_DETECT(4'7.09)
	$NOTE_BOX_DETECT(5'8.04)
	$NOTE_BOX_DETECT(6'7.11)
	$NOTE_BOX_DETECT(7'8.06)
	$NOTE_BOX_DETECT(8'8.01)
	$NOTE_BOX_DETECT(9'7.08)
	$NOTE_BOX_DETECT(10'8.03)
	$NOTE_BOX_DETECT(11'7.10)
	$NOTE_BOX_DETECT(12'7.05)
endin

instr	2	;SOUNDING INSTRUMENT
	aenv	linsegr	1,0.05,0	;AMPLITUDE ENVELOPE (BASICALLY JUST THE RELEASE STAGE)
	a1	loscil	0.5*aenv, cpspch(p4), giBassGuitarC, cpspch(8.00)	;PLAY SAMPLE WITH APPROPRIATE PITCH
	outs	a1, a1			;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 (MOUSE POSITION DETECTION) PLAYS A NOTE FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
