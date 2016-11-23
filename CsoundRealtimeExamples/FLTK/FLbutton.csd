FLbutton.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

;USING FL-BUTTONS TO CREATE ON SCRENN CONTROLS FOR PLAY, STOP, FAST FORWARD AND FAST REWIND OF A SOUND FILE
;THIS EXAMPLE ALSO MAKE USE OF THE PRESET GRAPHIC FOR BUTTONS

sr		=	44100
ksmps		=	16
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH
maxalloc	1,1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		OPCODE	 LABEL    | WIDTH | HEIGHT | X  | Y
		FLpanel	"Buttons",   320,    360,   100, 100
ion		=	1
ioff		=	0
itype		=	1
iwidth		=	50
iheight		=	50
ix		=	50
iy		=	35
iopcode		=	0
istarttim	=	0
idur		=	-1	;MEANS A 'HELD' NOTE
;FLlabel 	isize, ifont, ialign, ired, igreen, iblue
FLlabel		25,      10,     1,    40,     40,   40
;                                                                                                               p4 ;PLAYBACK SPEED
gkspd,ihb1	FLbutton  "@>",      1,  ioff, itype, iwidth, iheight, ix,     iy, iopcode, 1, istarttim, idur,  1 ;NORMAL SPEED FORWARDS
gkstop,ihb2	FLbutton  "@square", ion,ioff, itype, iwidth, iheight, ix+55,  iy, iopcode,-1, istarttim, idur,  0 ;STATIONARY
gkspd,ihb2	FLbutton  "@<<",     -2, ioff, itype, iwidth, iheight, ix+110, iy, iopcode, 1, istarttim, idur, -2 ;DOUBLE SPEED BACKWARDS
gkspd,ihb2	FLbutton  "@>>",     2,  ioff, itype, iwidth, iheight, ix+165, iy, iopcode, 1, istarttim, idur,  2 ;DOUBLE SPEED FORWARDS
gklpf,ihlpf	FLbutton  "LPF",     ion,ioff, 2,     150,    40,      85,    100, -1	;OPCODE=-1 MEANS DO NOT CREATE ANY SCORE EVENTS
gkhpf,ihhpf	FLbutton  "HPF",     ion,ioff, 3,     150,    40,      85,    150, -1	;OPCODE=-1 MEANS DO NOT CREATE ANY SCORE EVENTS
gkrvb,ihrvb	FLbutton  "Reverb",  ion,ioff, 4,     150,    40,      85,    200, -1	;OPCODE=-1 MEANS DO NOT CREATE ANY SCORE EVENTS
gklpf2,ihlpf2	FLbutton  "Ping",    ion,ioff, 21,    150,    40,      85,    250, iopcode, 2, istarttim, 1	;THIS BUTTON ALSO GENERATES A NOTE EVENT
FLsetColor2	255,255,50,ihlpf	;SET SECONDARY COLOUR TO YELLOW
FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 100
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        FLbutton                             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Single buttons are available in a variety of styles using the", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"FLbutton opcode. Buttons can output a value. Toggle buttons  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"toggle between two values referred to the 'on' value and the ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"'off' value'. FL buttons can also generate real-time score   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"events such as a note events.                                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"A number of built in graphics can be accessed using special  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"code label. Four of these are displayed in the four uppermost", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"buttons in the other panel. See the Csound Reference Manual  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"for a complete list of these variables.                      ", 	1,      5,     14,    490,    15,     5, 200

				FLpanel_end
	FLrun

gisine	ftgen 0, 0, 65536, 10, 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
gasendL	init	0
gasendR	init	0

instr	1
	kspd	limit	p4*gkspd,-2,2
	aL, aR	diskin2	"808loop.wav", kspd, 0, gisine
	gasendL	=	gasendL + aL
	gasendR	=	gasendR + aR
endin

instr	2	;PING
	icps	random	200,1000
	acps	line	icps, p3, icps*0.5
	aenv	expseg	0.001,0.005,1,p3-0.005,0.001
	a1	poscil	aenv*0.1, acps, gisine
	gasendL	=	gasendL + a1
	gasendR	=	gasendR + a1
endin

instr	3	;EFFECTS AND SEND AUDIO TO OUTPUT
	aL	=	gasendL
	aR	=	gasendR
	if	gklpf=1	then
		aL	butlp	aL, 1000
		aR	butlp	aR, 1000
	endif
	if	gkhpf=1	then
		aL	buthp	aL, 3000
		aR	buthp	aR, 3000
	endif
	aRvbL, aRvbR	reverbsc	aL*gkrvb, aR*gkrvb, 0.9, 10000
	outs	aL+aRvbL, aR+aRvbR
		clear	gasendL,gasendR
endin

</CsInstruments>

<CsScore>
i 3 0 3600		; RT. PERF. FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>