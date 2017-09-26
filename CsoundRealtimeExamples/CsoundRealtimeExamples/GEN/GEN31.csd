GEN31.csd
Written by Iain McCurdy, 2014

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
; --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN31",  500,    550,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,    0,     -1
gkSclFrq,ihSclFrq	FLbutton	"Rescale Frq.",	1,    0,    22,    120,     25,    5, 35,    0,     -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihSclFrq		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idfrq			FLvalue	" ",       50,     17,  130,  20
idamp			FLvalue	" ",       50,     17,  130,  55

;SLIDERS						MIN  |  MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y
gkfrq,ihfrq		FLslider 	"Frequency",	0.1,  5000,   -1,    23,   idfrq,     360,     15,  130,    5
gkamp,ihamp		FLslider 	"Global Amp.",	0,       1,    0,    23,   idamp,     360,     15,  130,   40

;VALUE INPUT BOXES				 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkpna, ihpna		FLtext		"Part. Nr. a", 	0,    200,  0.01,     1,   100,     20,     10,  80
gkstra, ihstra		FLtext		"Strength a", 	0,    1,    0.01,     1,   100,     20,    115,  80
gkphsa, ihphsa		FLtext		"Phase a", 	0,    360,  0.01,     1,   100,     20,    220,  80
gkpnb, ihpnb		FLtext		"Part. Nr. b", 	0,    200,  0.01,     1,   100,     20,     10, 120
gkstrb, ihstrb		FLtext		"Strength b", 	0,    1,    0.01,     1,   100,     20,    115, 120
gkphsb, ihphsb		FLtext		"Phase b", 	0,    360,  0.01,     1,   100,     20,    220, 120
gkpnc, ihpnc		FLtext		"Part. Nr. c", 	0,    200,  0.01,     1,   100,     20,     10, 160
gkstrc, ihstrc		FLtext		"Strength c", 	0,    1,    0.01,     1,   100,     20,    115, 160
gkphsc, ihphsc		FLtext		"Phase c", 	0,    360,  0.01,     1,   100,     20,    220, 160
gkpnd, ihpnd		FLtext		"Part. Nr. d", 	0,    200,  0.01,     1,   100,     20,     10, 200
gkstrd, ihstrd		FLtext		"Strength d", 	0,    1,    0.01,     1,   100,     20,    115, 200
gkphsd, ihphsd		FLtext		"Phase d", 	0,    360,  0.01,     1,   100,     20,    220, 200
gkpne, ihpne		FLtext		"Part. Nr. e", 	0,    200,  0.01,     1,   100,     20,     10, 240
gkstre, ihstre		FLtext		"Strength e", 	0,    1,    0.01,     1,   100,     20,    115, 240
gkphse, ihphse		FLtext		"Phase e", 	0,    360,  0.01,     1,   100,     20,    220, 240
gkpnf, ihpnf		FLtext		"Part. Nr. f", 	0,    200,  0.01,     1,   100,     20,     10, 280
gkstrf, ihstrf		FLtext		"Strength f", 	0,    1,    0.01,     1,   100,     20,    115, 280
gkphsf, ihphsf		FLtext		"Phase f", 	0,    360,  0.01,     1,   100,     20,    220, 280
gkpng, ihpng		FLtext		"Part. Nr. g", 	0,    200,  0.01,     1,   100,     20,     10, 320
gkstrg, ihstrg		FLtext		"Strength g", 	0,    1,    0.01,     1,   100,     20,    115, 320
gkphsg, ihphsg		FLtext		"Phase g", 	0,    360,  0.01,     1,   100,     20,    220, 320
gkpnh, ihpnh		FLtext		"Part. Nr. h", 	0,    200,  0.01,     1,   100,     20,     10, 360
gkstrh, ihstrh		FLtext		"Strength h", 	0,    1,    0.01,     1,   100,     20,    115, 360
gkphsh, ihphsh		FLtext		"Phase h", 	0,    360,  0.01,     1,   100,     20,    220, 360
gkpni, ihpni		FLtext		"Part. Nr. i", 	0,    200,  0.01,     1,   100,     20,     10, 400
gkstri, ihstri		FLtext		"Strength i", 	0,    1,    0.01,     1,   100,     20,    115, 400
gkphsi, ihphsi		FLtext		"Phase i", 	0,    360,  0.01,     1,   100,     20,    220, 400
gkpnj, ihpnj		FLtext		"Part. Nr. j", 	0,    200,  0.01,     1,   100,     20,     10, 440
gkstrj, ihstrj		FLtext		"Strength j", 	0,    1,    0.01,     1,   100,     20,    115, 440
gkphsj, ihphsj		FLtext		"Phase j", 	0,    360,  0.01,     1,   100,     20,    220, 440


;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,       9,    15,    490,    70,    5, 480	;SOURCE

FLsetColor	200,220,200,ih

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Source (GEN11)",	1,      2,    15,    150,     12,    175, 485

FLsetColor	200,220,200,ih
	
;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gknh, ihnh		FLcount  	"N.Harms.", 	1,     80,    1,     10,      1,    110,     25,    10,505,   -1 
gklh, ihlh		FLcount  	"Lowest Harm.", 1,     80,    1,     10,      1,    110,     25,   125,505,   -1 

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X  | Y
idr			FLvalue	" ",       50,     18,   240, 520

;SLIDERS						MIN  |  MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y
gkr,ihr			FLslider 	"Power",	0,       2,    0,    23,     idr,    250,     15,  240,   505

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	50, 	ihfrq
				FLsetVal_i	0.3, 	ihamp
				FLsetVal_i	1, 	ihpna
				FLsetVal_i	1, 	ihstra
				FLsetVal_i	0, 	ihphsa
				FLsetVal_i	2, 	ihpnb
				FLsetVal_i	0.5, 	ihstrb
				FLsetVal_i	0, 	ihphsb
				FLsetVal_i	3, 	ihpnc
				FLsetVal_i	0.6, 	ihstrc
				FLsetVal_i	0, 	ihphsc
				FLsetVal_i	4, 	ihpnd
				FLsetVal_i	0.4, 	ihstrd
				FLsetVal_i	0, 	ihphsd
				FLsetVal_i	5, 	ihpne
				FLsetVal_i	0.18,	ihstre
				FLsetVal_i	0, 	ihphse
				FLsetVal_i	6, 	ihpnf
				FLsetVal_i	0.15, 	ihstrf
				FLsetVal_i	0, 	ihphsf
				FLsetVal_i	7, 	ihpng
				FLsetVal_i	0.14, 	ihstrg
				FLsetVal_i	0, 	ihphsg
				FLsetVal_i	8, 	ihpnh
				FLsetVal_i	0.13, 	ihstrh
				FLsetVal_i	0, 	ihphsh
				FLsetVal_i	9, 	ihpni
				FLsetVal_i	0.12, 	ihstri
				FLsetVal_i	0, 	ihphsi
				FLsetVal_i	10, 	ihpnj
				FLsetVal_i	0.1, 	ihstrj
				FLsetVal_i	0, 	ihphsj
				FLsetVal_i	60, 	ihnh
				FLsetVal_i	1, 	ihlh
				FLsetVal_i	0.5, 	ihr
			                                                           
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            GEN31                            ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"GEN31 creates function tables made up of harmonically related", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"stacks of partials in the manner of GEN09. Whereas with GEN09", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"these partials are sinusoids, with GEN31 the partials can be ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"any other function table. In this example I am using a GEN11 ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"function table which generates buzzy sounding spectrally rich", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"harmonically rich waveforms with just a few user input       ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"parameters.                                                  ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"For information on GEN09 (which is quite similar to GEN31)   ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"and GEN11 (used as a source function in this example) please ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"refer to their relevant examples.                            ", 	1,      5,     14,    490,     20,    5, 220
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;UPDATES FUNCTION TABLE                    

	ktrig	changed	gkpna,gkstra,gkphsa,gkpnb,gkstrb,gkphsb,gkpnc,gkstrc,gkphsc,gkpnd,gkstrd,gkphsd,gkpne,gkstre,gkphse,gkpnf,gkstrf,gkphsf,gkpng,gkstrg,gkphsg,gkpnh,gkstrh,gkphsh,gkpni,gkstri,gkphsi,gkpnj,gkstrj,gkphsj,  gknh,gklh,gkr		;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO RECREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. BEGIN REINITIALIZATION FROM HERE.
	  ;CREATE THE GEN31 FUNCTION TABLE. 
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE
	  isrc	ftgen	2,0,4096,11,i(gknh),i(gklh),i(gkr)
	  iwave	ftgen	1,0,4096,-31,isrc,i(gkpna),i(gkstra),i(gkphsa),i(gkpnb),i(gkstrb),i(gkphsb),i(gkpnc),i(gkstrc),i(gkphsc),i(gkpnd),i(gkstrd),i(gkphsd),i(gkpne),i(gkstre),i(gkphse),i(gkpnf),i(gkstrf),i(gkphsf),i(gkpng),i(gkstrg),i(gkphsg),i(gkpnh),i(gkstrh),i(gkphsh),i(gkpni),i(gkstri),i(gkphsi),i(gkpnj),i(gkstrj),i(gkphsj)
	endif					;END OF THIS CONDITIONAL BRANCH

	if gkOnOff=1 then			;IF ON/OFF BUTTON IS ON...
	 kporttime	linseg	0,0.001,0.01	;CREATE A FUNCTION THAT RISES QUICKLY TO A HELD VALUE THAT WILL BE USED FOR PORTAMENTO TIME
	 kfrq	portk	gkfrq,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
 	 kamp	portk	gkamp,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	 if	gkSclFrq==1 then		;IF RESCALING FREQUENCY BUTTON IS ACTIVATED...
	   kfrq=kfrq/gkpna			;DIVIDE BASE FREQUENCY BY THE PARTIAL NUMBER OF THE FIRST PARTIAL
 	 endif					;END OF THIS CONDITIONAL BRANCH
	 a1	oscili	kamp,kfrq,iwave		;CREATE AN AUDIO OSCILLATOR THAT WILL USE THE GEN31 DESIGNED WAVEFORM
	 	out	a1			;SEND THE AUDIO TO THE OUTPUT. APPLY THE AMPLITUDE ENVELOPE
	endif
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
