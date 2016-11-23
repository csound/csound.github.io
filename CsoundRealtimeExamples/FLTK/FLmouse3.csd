;WRITTEN BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b2048 -B4096
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	1
nchnls	= 	2
0dbfs	=	1

;       LABEL     | WIDTH | HEIGHT | X | Y
FLpanel	"FLmouse",   500,    500,    50, 50

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	FLbox  	"                         FLmouse 3                           ", 	1,      5,     14,    490,    15,     5,  0
ih	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih	FLbox  	"This is a practical demonstration of the FLmouse opcode.     ", 	1,      5,     14,    490,    15,     5,  40
ih	FLbox  	"A sound loop is played back using the granular synthesis     ", 	1,      5,     14,    490,    15,     5,  60
ih	FLbox  	"opcode 'sndwarp'. Movement of the mouse pointer across the   ", 	1,      5,     14,    490,    15,     5,  80
ih	FLbox  	"x-axis of this FLTK window slows the rate of playback.       ", 	1,      5,     14,    490,    15,     5, 100
ih	FLbox  	"Movement of the mouse pointer along the y-axis varies the    ", 	1,      5,     14,    490,    15,     5, 120
ih	FLbox  	"pitch of the grains. Holding down the left-click introduces a", 	1,      5,     14,    490,    15,     5, 140
ih	FLbox  	"delay effect. Holding down the right click introduces a      ", 	1,      5,     14,    490,    15,     5, 160
ih	FLbox  	"reverb effect.                                               ", 	1,      5,     14,    490,    15,     5, 180
FLpanel_end
FLrun

gihalfsine	ftgen	0,0,131072,9,.5,1,0 				;HALF SINE
gisound		ftgen	0,0,262144,1,"loop.wav",0,0,1			;SOUND FILE

instr	1		;READ CONTROLLERS, SCAN FOR THRESHOLD CROSSING, OUTPUT CONTROLLER VALUES TO DISPLAY
	iporttime	=	0.05				;PORTAMENTO TIME	
	imode	=	2	;MODE 0 (SCREEN DISPLAY NORMALISED 0-1)
				;MODE 1 (RAW SCREEN PIXEL VALUE)
				;MODE 2 (PIXEL VALUE RELATIVE TO FLTK PANEL)
	kx, ky, kb1, kb2, kb3 FLmouse	imode

	kmlt		=	(1-(ky/500))*2		;DERIVE PITCH MULTIPLIER FROM Y-AXIS POSITION OF MOUSE OVER FLTK WINDOW
	kmlt		portk	kmlt, iporttime		;SMOOTH VARIABLE WITH PORTAMENTO

	krate		=	1 - (kx/500)		;DERIVE RATE OF GRAIN PLAYBACK FROM MOUSE POSITION ALONG THE x-axis OF THE FLTK WINDOW
	ilen		=	nsamp(gisound)/sr	;DERIVE DURATION OF SOUND SAMPLE IN SECONDS
	kptr		phasor	krate/ilen		;CREATE A CYCLING POINTER THAT WILL BE USED FOR PLAYBACK IN sndwarp
	kptr		=	kptr * ilen		;MULTIPLY POINTER BY SAMPLE DURATION
	
	a1 		sndwarp 0.2, kptr, kmlt, gisound, 0, 4000, 50, 16, gihalfsine, 1	;CREATE A GRANULAR SYNTHESIS TONE

	outs	a1,a1	;SEND AUDIO TO OUTPUTS
	kDelaySendAmount	port	kb1, iporttime	;DERIVE DELAY SEND AMOUNT VARIABLE FROM MOUSE 1 STATUS. APPLY PORTAMENTO
	gaDelaySend	=	a1 * kDelaySendAmount	;CREATE DELAY SEND AUDIO SIGNAL

	kRvbSendAmount	port	kb3, iporttime		;DERIVE DELAY SEND AMOUNT VARIABLE FROM MOUSE 1 STATUS. APPLY PORTAMENTO
	gaRvbSend	=	a1 * kRvbSendAmount     ;CREATE DELAY SEND AUDIO SIGNAL                                         
endin

instr	2	;DELAY
	aBuffer	delayr	1				;ESTABLISH DELAY BUFFER
	aDlySig	deltapi	0.3				;TAP DELAY BUFFER
		delayw	gaDelaySend+(aDlySig*0.3)	;WRITE INTO DELAY BUFFER. INCLUDE A FEEDBACK SIGNAL INTO THE INPUT.
	outs	aDlySig, aDlySig			;SEND AUDIO TO THE OUTPUTS
endin

instr	3	;REVERB
	aL, aR	reverbsc	gaRvbSend, gaRvbSend, 0.9, 10000	;CREATE REVERB SIGNAL USING reverbsc OPCODE
	outs	aL, aR							;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;SOUND PRODUCING INSTRUMENT
i 2 0 3600	;DELAY EFFECT
i 3 0 3600	;REVERB EFFECT
</CsScore>

</CsoundSynthesizer>
