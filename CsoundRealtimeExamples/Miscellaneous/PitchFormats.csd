;Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;				LABEL           | WIDTH | HEIGHT | X | Y
			FLpanel	"Pitch Formats",   500,    260,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,   490,   115,    5, 100	;CONVERSION
;TEXT BOXES							TYPE | FONT | SIZE |  WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI INPUT & CONVERSIONS", 	1,       2,    14,     200,    20,   150, 105

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idcpsIP			FLvalue	"cps",     105,     20,   10,  50
gidoct			FLvalue	"oct",     105,     20,  135,  50
gidpch			FLvalue	"pch",     105,     20,  260,  50
gidnum			FLvalue	"MIDI",    105,     20,  385,  50

;VALUE INPUT BOXES				MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkcps, gihcps		FLtext		"cps", 	0,   20000,   0,     1,    105,     20,    10, 135
gkoct, gihoct		FLtext		"oct", 	0,      20,   0,     1,    105,     20,   135, 135
gkpch, gihpch		FLtext		"pch", 	0,      20,   0,     1,    105,     20,   260, 135
gknum, gihnum		FLtext		"MIDI", 0,     127,   0,     1,    105,     20,   385, 135

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkconvcps,ihconvcps	FLbutton	"convert",	1,    0,    21,    105,     25,    10, 175,    0,     3,      0,      0.01
gkconvoct,ihconvoct	FLbutton	"convert",	1,    0,    21,    105,     25,   135, 175,    0,     4,      0,      0.01
gkconvpch,ihconvpch	FLbutton	"convert",	1,    0,    21,    105,     25,   260, 175,    0,     5,      0,      0.01
gkconvnum,ihconvnum	FLbutton	"convert",	1,    0,    21,    105,     25,   385, 175,    0,     6,      0,      0.01

gktone, ihtone		FLbutton	"Tone On/Off",	1,    0,    22,    105,     25,    10, 225,   -1
FLsetColor2	255, 255, 50, ihtone	;SET SECONDARY COLOUR TO YELLOW

;SLIDERS					MIN       |   MAX    | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkcpsIP, gihcpsIP	FLslider 	"",	cpsoct(3), 12543.85,   -1,    23,   idcpsIP,     490,     25,    5,    5

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE      | HANDLE
				FLsetVal_i	cpsoct(8),   gihcpsIP
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 600, 512, 0
				FLscroll     515, 600, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      Pitch Formats                          ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Csound accepts expressions of pitch in a variety of formats. ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Accordingly there are a number of opcodes for conversion     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"between these different formats.                             ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The four formats explored in this example are 'cps' (cycles- ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"per-second), 'oct' (octave-point-decimal), 'pch' (octave-    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"point-pitch-class) and MIDI note number.                     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"Cycles-per-second is the standard measure of frequency and   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"defines the number of completed cycles of a waveform         ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"expressed per second. The unit of measurement of CPS is      ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'hertz'.                                                     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'Oct' expresses pitch as the octave registration followed by ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"a decimal which expresses the additional interval as a       ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"fractional part of an octave. Therefore F# above middle C    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"will be 8.5 (octave=8 + 1/2 an octave).                      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"'Pch' again begins by expressing the octave registration.    ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"Semitones steps this octave are expressed in steps of 0.01.  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"A chromatic scale above middle C in 'pch' format goes:       ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"8.00 8.01 8.02 8.03 8.04 8.05 and so on. The B above middle C", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"will be 8.11, the next semitone step above that (C5) will be ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"9.00.                                                        ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"MIDI note numbers express pitch as integers in the range     ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"0-127 corresponding to note of a chromatic MIDI keyboard.    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"MIDI keyboards rarely contain 128 keys so the note numbers   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"available at any one time will be an inner subset of this    ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"range. Middle C will be represented by a MIDI note number of ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"60, the C above that by 72. Fractional MIDI note numbers are ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"allowed and define fractional parts of a semitone but are    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"only useful within Csound as keyboards neither transmit nor  ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"recognize fractional MIDI note numbers.                      ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"In this example the user can move the slider at the top of   ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"the interface and observe how pitch is expressed in the four ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"formats discussed above. Activating the 'Tone On/Off' button ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"will allow the user to hear the pitch described as a sine    ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"tone.                                                        ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"In the lower panel values can be typed directly in and       ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"converted into the other formats. Notes played on a MIDI     ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"keyboard will also be expressed in all 4 formats in these    ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"boxes.                                                       ", 	1,      5,     14,    490,    20,     5, 880
				FLscrollEnd
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1

instr	1		;MIDI INPUT CONVERTED INTO FOUR FORMATS
	icps	cpsmidi	;READ IN MIDI AS CPS 
	ioct	octmidi	;READ IN MIDI AS OCT FORMAT
	inum	notnum	;READ IN MIDI AS NOTE NUMBER 
	ipch	pchmidi	;READ IN MIDI AS PCH FORMAT
	FLsetVal_i	icps, gihcps	;SEND CPS VALUE TO CPS TEXT BOX
	FLsetVal_i	ioct, gihoct	;SEND OCT VALUE TO CPS TEXT BOX
	FLsetVal_i	ipch, gihpch	;SEND PCH VALUE TO CPS TEXT BOX
	FLsetVal_i	inum, gihnum	;SEND NOTE NUMBER VALUE TO CPS TEXT BOX
	krelease	release			;sense note release 0=note_on 1=note_off
	gkMIDIflag	=	(1-krelease)	;invert note on/release flag: 1=note_on 2=note_off
endin

instr	2	;PRINT SLIDER CHANGES TO VALUE BOXES
	koct	=		octcps(gkcpsIP)		;CONVERT SLIDER VALUE FROM CPS TO OCT
		FLprintk2 	koct, gidoct		;PRINT OCT TO OCT VALUE BOX WHENEVER CHANGED
		FLprintk2 	pchoct(koct), gidpch	;PRINT PCH TO PCH VALUE BOX WHENEVER CHANGED
		FLprintk2 	(koct-3)*12, gidnum	;CONVERT OCT TO MIDI NUMBER USING MATHS AND SEND TO MIDI NOTE NUMBER VALUE BOX
endin

instr	3	;SEND CPS BOX VALUE TO THE OTHER 3 BOXES
	ioct	init	octcps(i(gkcps))	;DERIVE OCT FORMAT VALUE FROM CPS
	FLsetVal_i	ioct, gihoct		;SEND OCT VALUE TO OCT BOX
	FLsetVal_i	pchoct(ioct), gihpch	;CONVERT OCT TO PCH AND SEND TO PCH BOX
	FLsetVal_i	(ioct-3)*12, gihnum	;DERIVE MIDI NOTE NUMBER FROM OCT VALUE AND SEND TO MIDI NOTE NUMBER BOX
endin

instr	4	;SEND OCT BOX VALUE TO THE OTHER 3 BOXES
	FLsetVal_i	cpsoct(i(gkoct)), gihcps	;CONVERT OCT VALUE TO CPS AND SEND TO CPS BOX
	FLsetVal_i	pchoct(i(gkoct)), gihpch	;CONVERT OCT VALUE TO PCH AND SEND TO PCH BOX
	FLsetVal_i	(i(gkoct)-3)*12, gihnum		;DERIVE MIDI NOTE NUMBER FROM OCT VALUE AND SEND TO MIDI NOTE NUMBER BOX
endin

instr	5	;SEND PCH BOX VALUE TO THE OTHER 3 BOXES
	FLsetVal_i	cpspch(i(gkpch)), gihcps	;CONVERT PCH VALUE TO CPS FORMAT AND SEND TO CPS BOX
	ipch	init	i(gkpch)			;CONVERT PCH VALUE TO I-RATE LOCAL PCH VALUE
	ioct	=	octpch(ipch)			;CONVERT PCH VALUE TO OCT FORMAT VALUE
	FLsetVal_i	ioct, gihoct			;SEND OCT VALUE TO OCT BOX 
	FLsetVal_i	(ioct-3)*12, gihnum		;DERIVE MIDI NOTE NUMBER FROM OCT VALUE AND SEND TO MIDI BOTE NUMBER BOX
endin

instr	6	;SEND MIDI NOTE NUMBER BOX VALUE TO THE OTHER 3 BOXES
	FLsetVal_i	cpsmidinn(i(gknum)), gihcps	;CONVERT MIDI NOTE NUMBER TO CPS FORMAT AND SEND TO CPS BOX
	FLsetVal_i	octmidinn(i(gknum)), gihoct	;CONVERT MIDI NOTE NUMBER TO OCT FORMAT AND SEND TO OCT BOX
	FLsetVal_i	pchmidinn(i(gknum)), gihpch	;CONVERT MIDI NOTE NUMBER TO PCH FORMAT AND SEND TO PCH BOX
endin

instr	10	;GENERATE A TONE
	ktrig1	changed	gkcpsIP	;IF SLIDER IS CHANGED GENERATE A MOMENTARY '1' (BANG)
	ktrig2	changed	gkcps	;IF CPS BOX IS CHANGED GENERATE A MOMENTARY '1' (BANG)
	if ktrig1=1 then	;IF SLIDER HAS BEEN CHANGED...
		kcps=gkcpsIP	;TAKE LOCAL CPS VALUE FROM SLIDER
	elseif ktrig2=1 then	;IF CPS TEXT BOX HAS BEEN CHANGED...
		kcps=gkcps	;TAKE LOCAL CPS VALUE FROM CPS TEXT BOX
	endif			;END OF THIS CONDITIONAL BRANCH
	kamp	limit	gktone+gkMIDIflag,0,1	;limit amplitude value (sum of tone switch and midi active flag) to within the range 0 and 1
	aamp	interp	kamp
	asig	poscil	0.1*aamp, kcps, gisine	;GENERATE A TONE
		outs	asig, asig	;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;SCAN FOR CHANGES TO SLIDER - UPDATE DISPLAY BOXES
i 10 0 3600	;PLAY A TONE
</CsScore>

</CsoundSynthesizer>