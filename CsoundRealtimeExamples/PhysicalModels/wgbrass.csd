wgbrass
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;COMMENT/UNCOMMENT AS REQUIRED
-odac -dm0	;NO MIDI
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	32
nchnls	=	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"wgbrass",   500,    450,    0,  0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   0,    22,    120,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idamp				FLvalue	" ",     	60,       20,    5,   75
idfreq				FLvalue	" ",     	60,       20,    5,  125
idtens				FLvalue	" ",     	60,       20,    5,  175
idatt				FLvalue	" ",     	60,       20,    5,  225
idMinFrq			FLvalue	" ",     	60,       20,    5,  275
idvibf				FLvalue	" ",     	60,       20,    5,  325
idvamp				FLvalue	" ",     	60,       20,    5,  375
idoutamp			FLvalue	" ",     	60,       20,    5,  425

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider 	"(Opcode) Amplitude",		0.001,    20,  -1,    23,    idamp,   490,    25,     5,  50
gkfreq, gihfreq			FLslider 	"Frequency",			1,     20000,  -1,    23,   idfreq,   490,    25,     5, 100
gktens, ihtens			FLslider 	"Lip Tension",			0.001,     5,  -1,    23,   idtens,   490,    25,     5, 150
gkatt, ihatt			FLslider 	"Attack Time",			0.0001,    2,  -1,    23,    idatt,   490,    25,     5, 200
gkMinFrq, ihMinFrq		FLslider 	"Minimum Frequency (i-rate)",	1,      5000,  -1,    23,   idMinFrq, 490,    25,     5, 250
gkvibf, ihvibf			FLslider 	"Vibrato Frequency (hertz)",	0,        16,   0,    23,   idvibf,   490,    25,     5, 300
gkvamp, gihvamp			FLslider 	"Vibrato Amplitude",		0,       0.1,   0,    23,   idvamp,   490,    25,     5, 350
gkoutamp, ihoutamp		FLslider 	"Output Amplitude",		0.1,     100,  -1,    23,   idoutamp, 490,    25,     5, 400

			FLsetVal_i	0.18, 	ihamp
			FLsetVal_i	400, 	gihfreq
			FLsetVal_i	0.4, 	ihtens
			FLsetVal_i	0.01, 	ihatt
			FLsetVal_i	20, 	ihMinFrq
			FLsetVal_i	5, 	ihvibf
			FLsetVal_i	0.01, 	gihvamp
			FLsetVal_i	1, 	ihoutamp

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 200, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           wgbrass                           ", 	1,      6,     14,    490,    25,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'wgbrass' creates a physical model of a brass instrument.    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"It seems rather unstable. Experimentation with the settings  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"for 'Frequency', 'Lip Tension' and '(Opcode) Amplitude' are  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"sometimes required in order to get the instrument to sound.  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Production of lower tones, for example, will require a       ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"reduction in '(Opcode) Amplitude' - for this situation       ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"an output amplitude control across a wide range is also      ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"provided in order to compensate.                             ", 	1,      5,     14,    490,    20,     5, 180

				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1	;WGBRASS INSTRUMENT
	if	gkOnOff==0	then			; SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
	 turnoff					; TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif						; A LABEL
	givfn	ftgenonce	0, 0, 256, 10, 1	; VIBRATO WAVEFORM (A SINE WAVE)
	iporttime	=	0.03
	kporttime	linseg	0, 0.001, iporttime, 1, iporttime
	kfreq	portk	gkfreq, kporttime
	ktens	portk	gktens, kporttime
	ktrig	changed	gkMinFrq
	if ktrig==1 then
	 reinit UPDATE
	endif
	UPDATE:
	ares	wgbrass gkamp, kfreq, ktens, i(gkatt), gkvibf, gkvamp, givfn, i(gkMinFrq)
	rireturn
		out	ares*gkoutamp
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>