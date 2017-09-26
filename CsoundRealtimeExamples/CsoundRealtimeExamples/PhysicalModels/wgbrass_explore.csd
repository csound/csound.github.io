wgbrass
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;COMMENT/UNCOMMENT AS REQUIRED
-odac -dm0
; --displays	;NO MIDI
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	32
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"wgbrass",  1000,    500,    0,  0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   0,    22,    120,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
gktone,ihtone	FLbutton	"Tone",			1,   0,    22,    120,     25,  205,  5,    0,      5,      0,       -1
FLsetColor2	255, 255, 50, ihtone		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idamp				FLvalue	" ",     	60,       20,    5,   75
idnum				FLvalue	" ",     	60,       20,    5,  125
idtens				FLvalue	" ",     	60,       20,    5,  175
idatt				FLvalue	" ",     	60,       20,    5,  225
idvibf				FLvalue	" ",     	60,       20,    5,  275
idvamp				FLvalue	" ",     	60,       20,    5,  325
idoutamp			FLvalue	" ",     	60,       20,    5,  375
idMinFrq			FLvalue	" ",     	60,       20,    5,  425
idTRndDep			FLvalue	" ",     	60,       20,    5,  475
idTRndRte			FLvalue	" ",     	60,       20,  255,  475
idNRndDep			FLvalue	" ",     	60,       20,  505,   25
idNRndRte			FLvalue	" ",     	60,       20,  755,   25
idARndDep			FLvalue	" ",     	60,       20,  505,   75
idARndRte			FLvalue	" ",     	60,       20,  755,   75

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider 	"(Opcode) Amplitude",		0.001,    20,  -1,    23,    idamp,   490,    25,     5,  50
gknum, gihnum			FLslider 	"Note Number",			0,       127,   0,    23,    idnum,   490,    25,     5, 100
gktens, ihtens			FLslider 	"Lip Tension",			0,         5,   0,    23,   idtens,   490,    25,     5, 150
gkatt, ihatt			FLslider 	"Attack Time",			0.0001,    2,  -1,    23,    idatt,   490,    25,     5, 200
gkvibf, ihvibf			FLslider 	"Vibrato Frequency (hertz)",	0,        16,   0,    23,   idvibf,   490,    25,     5, 250
gkvamp, gihvamp			FLslider 	"Vibrato Amplitude",		0,       0.1,   0,    23,   idvamp,   490,    25,     5, 300
gkoutamp, ihoutamp		FLslider 	"Output Amplitude",		0.1,     100,  -1,    23,   idoutamp, 490,    25,     5, 350
gkMinFrq, ihMinFrq		FLslider 	"Minimum Frequency",		0,       127,   0,    23,   idMinFrq, 490,    25,     5, 400
gkTRndDep, ihTRndDep		FLslider 	"Tens Rnd Dep",			0,       0.8,   0,    23,   idTRndDep,240,    25,     5, 450
gkTRndRte, ihTRndRte		FLslider 	"Tens Rnd Rate",		0.1,     100,  -1,    23,   idTRndRte,240,    25,   255, 450
gkNRndDep, ihNRndDep		FLslider 	"Note Rnd Dep",			0,       1,     0,    23,   idNRndDep,240,    25,   505,   0
gkNRndRte, ihNRndRte		FLslider 	"Note Rnd Rate",		0.1,     100,  -1,    23,   idNRndRte,240,    25,   755,   0
gkARndDep, ihARndDep		FLslider 	"Amp Rnd Dep",			0,       1,     0,    23,   idARndDep,240,    25,   505,  50
gkARndRte, ihARndRte		FLslider 	"Amp Rnd Rate",			0.1,     100,  -1,    23,   idARndRte,240,    25,   755,  50

			FLsetVal_i	0.18, 	ihamp
			FLsetVal_i	60, 	gihnum
			FLsetVal_i	0.75, 	ihtens
			FLsetVal_i	0.01, 	ihatt
			FLsetVal_i	5, 	ihvibf
			FLsetVal_i	0, 	gihvamp
			FLsetVal_i	1, 	ihoutamp
			FLsetVal_i	1, 	ihMinFrq
			FLsetVal_i	0.1, 	ihTRndDep
			FLsetVal_i	0.5, 	ihTRndRte
			FLsetVal_i	0, 	ihNRndDep
			FLsetVal_i	10, 	ihNRndRte
			FLsetVal_i	0.13, 	ihARndDep
			FLsetVal_i	0.54, 	ihARndRte

			FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giamp	ftgen	0,0,128,-27, 0,0.18,  12,0.18,  24,0.18,  36,0.18,  48,0.18,  60,0.18,  72,0.18,  84,0.18,  96,0.26,  108,1.3,  120,6,    127,10
gitens	ftgen	0,0,128,-27, 0,1.8,   12,1.7,   24,1.7,   36,1.04,  48,0.84,  60,0.6,   72,0.4,   84,0.18,  96,0.22,  108,0.16, 120,0.06, 127,0.02

giamp	ftgen	0,0,128,-16, 0.18, 128, 10, 10
gitens	ftgen	0,0,128,-16, 1.8,  128, -1, 0.02
giOutAmp	ftgen	0,0,128,-16,1,128,10,0.2

gasendL,gasendR	init	0

instr	1	;WGBRASS INSTRUMENT
	if	gkOnOff!=0	kgoto	CONTINUE	; SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
		turnoff					; TURN THIS INSTRUMENT OFF IMMEDIATELY
	CONTINUE:					; A LABEL
	kMinFrq	init	0
	givfn	ftgenonce	0, 0, 256, 10, 1	; VIBRATO WAVEFORM (A SINE WAVE)
	iporttime	=	0.03
	kporttime	linseg	0, 0.001, iporttime, 1, iporttime
	knum	portk	gknum, kporttime
	ktens	portk	gktens, kporttime

	;ktensrnd	randi	gkTRndDep, gkTRndRte	
	ktensrnd	rspline	-gkTRndDep, gkTRndDep, gkTRndRte, gkTRndRte*2
	;knoternd	randi	gkNRndDep, gkNRndRte	
	knoternd	rspline	-gkNRndDep, gkNRndDep, gkNRndRte, gkNRndRte*2
	;kamprnd	randi	gkARndDep, gkARndRte	
	kamprnd		rspline	-gkARndDep, gkARndDep, gkARndRte, gkARndRte*2

	ktrig	changed	kMinFrq
	if ktrig==1 then
	 reinit UPDATE
	endif
	UPDATE:
	asig	wgbrass gkamp+kamprnd, cpsmidinn(knum+knoternd), ktens+ktensrnd, i(gkatt), gkvibf, gkvamp, givfn, i(cpsmidinn(kMinFrq))
	rireturn
	asig		=	asig * gkoutamp
	kMinFrq		=	gkMinFrq
 	gkwidth		=		1
 	kRndDelL		rspline		0, 0.04*gkwidth, 0.1, 0.2
 	kRndDelR		rspline		0, 0.04*gkwidth, 0.1, 0.2
 	kRndDelL		limit		kRndDelL, 0, 0.04
 	kRndDelR		limit		kRndDelR, 0, 0.04
 	aRndDelL		interp		kRndDelL
 	aRndDelR		interp		kRndDelR
 	aL			vdelay		asig, 0.1+(aRndDelL*1000), 0.1 + 40
 	aR			vdelay		asig, 0.1+(aRndDelR*1000), 0.1 + 40

 	outs	aL, aR
	gasendL	=	gasendL + aL*0.5
	gasendR	=	gasendR + aR*0.5
endin

giwave	ftgen	0,0,4096,10,1,0.1,0.05,0.03,0.01

instr	5
 if gktone==0 then
  turnoff
 endif
 asig	oscili	0.1,cpsmidinn(gknum),giwave
 	outs	asig,asig
endin


instr	99
 aL,aR	reverbsc	gasendL,gasendR,0.8,3000
 	outs	aL,aR
 	clear	gasendL,gasendR
endin


</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
i 99 0 3600
</CsScore>

</CsoundSynthesizer>