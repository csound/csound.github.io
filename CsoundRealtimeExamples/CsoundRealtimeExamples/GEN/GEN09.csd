GEN09.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN09",  500,    490,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,    0,     -1
gkSclFrq,ihSclFrq	FLbutton	"Rescale Frq.",	1,    0,    22,    120,     25,    5, 35,    0,     -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihSclFrq		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idfrq			FLvalue	" ",       50,     17,  130,  20
idamp			FLvalue	" ",       50,     17,  130,  55

;SLIDERS						MIN  |  MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y
gkfrq,ihfrq		FLslider 	"Frequency",	1,    5000,   -1,    23,   idfrq,     360,     15,  130,    5
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

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	440, 	ihfrq
				FLsetVal_i	0.3, 	ihamp
				FLsetVal_i	1, 	ihpna
				FLsetVal_i	1, 	ihstra
				FLsetVal_i	0, 	ihphsa
				FLsetVal_i	2, 	ihpnb
				FLsetVal_i	0.5, 	ihstrb
				FLsetVal_i	0, 	ihphsb
				FLsetVal_i	3, 	ihpnc
				FLsetVal_i	0, 	ihstrc
				FLsetVal_i	0, 	ihphsc
				FLsetVal_i	4, 	ihpnd
				FLsetVal_i	0, 	ihstrd
				FLsetVal_i	0, 	ihphsd
				FLsetVal_i	5, 	ihpne
				FLsetVal_i	0, 	ihstre
				FLsetVal_i	0, 	ihphse
				FLsetVal_i	6, 	ihpnf
				FLsetVal_i	0, 	ihstrf
				FLsetVal_i	0, 	ihphsf
				FLsetVal_i	7, 	ihpng
				FLsetVal_i	0, 	ihstrg
				FLsetVal_i	0, 	ihphsg
				FLsetVal_i	8, 	ihpnh
				FLsetVal_i	0, 	ihstrh
				FLsetVal_i	0, 	ihphsh
				FLsetVal_i	9, 	ihpni
				FLsetVal_i	0, 	ihstri
				FLsetVal_i	0, 	ihphsi
				FLsetVal_i	10, 	ihpnj
				FLsetVal_i	0, 	ihstrj
				FLsetVal_i	0, 	ihphsj
			                                                           
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 600, 512, 0
				FLscroll     515, 600, 0,0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN09                          ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"GEN09 facilitates the construction of waveforms composed of  ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"sine waves. Whereas GEN10 permits construction of waveforms  ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"only from harmonically stacked sine waves, with GEN09 we can ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"specify the precise partial number (which can also be        ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"fractional) as well as the initial phase (in degrees) and    ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"strength of each partial.                                    ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"The number boxes used in this example can by changed by      ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"either typing directly into them or by clicking and dragging ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"them.                                                        ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"If partial numbers follow the rising sequence of integers    ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"from '1' (i.e. 1,2,3,4,5 etc.) and phases are left at zero   ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"then manipulation of GEN09's strength parameters will be     ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"identical to that of GEN10.                                  ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"As with GEN10, partial strengths are normalized with respect ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"to the highest strength partial in the table, therefore      ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"strength values are arbitrary rather than specifying any     ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"specific amplitude so we can choose our own range within     ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"which to work. It is typical to operate within the range zero", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"(partial absent) to 1 (maximum strength partial).            ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"Changes made to the function table can be observed in        ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"Csound's display window if displays are enabled (i.e. if the ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"-d flag is not used).                                        ", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"It will be observed (both visually and aurally) that when    ", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"fractional partial numbers are used, discontinuities in the  ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"waveform result. Aurally this will manifest as buzzing.      ", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"Inharmonic sounding waveforms can be created if higher       ", 	1,      5,     14,    490,     20,    5, 540
ih		 	FLbox  	"integer partial numbers are chosen and the frequency of the  ", 	1,      5,     14,    490,     20,    5, 560
ih		 	FLbox  	"oscillator tone is rescaled downwards according to the       ", 	1,      5,     14,    490,     20,    5, 580
ih		 	FLbox  	"recipricol of the lowest partial number. This procedure      ", 	1,      5,     14,    490,     20,    5, 600
ih		 	FLbox  	"assumes that the first partial in the table is the lowest and", 	1,      5,     14,    490,     20,    5, 620
ih		 	FLbox  	"can be initiated by activating the on-screen button.         ", 	1,      5,     14,    490,     20,    5, 640
ih		 	FLbox  	"In this example provision for ten partials is made but this  ", 	1,      5,     14,    490,     20,    5, 660
ih		 	FLbox  	"number could be increased by the user.                       ", 	1,      5,     14,    490,     20,    5, 680
                                FLscroll_end       
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                               
instr	1	;UPDATES FUNCTION TABLE                    
	ktrig	changed	gkpna,gkstra,gkphsa,gkpnb,gkstrb,gkphsb,gkpnc,gkstrc,gkphsc,gkpnd,gkstrd,gkphsd,gkpne,gkstre,gkphse,gkpnf,gkstrf,gkphsf,gkpng,gkstrg,gkphsg,gkpnh,gkstrh,gkphsh,gkpni,gkstri,gkphsi,gkpnj,gkstrj,gkphsj	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE' IN ORDER TO RECREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. BEGIN REINITIALIZATION FROM HERE.
	  ;CREATE THE GEN09 FUNCTION TABLE. 
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE
	  giwave	ftgen	1,0,4096,9,i(gkpna),i(gkstra),i(gkphsa),i(gkpnb),i(gkstrb),i(gkphsb),i(gkpnc),i(gkstrc),i(gkphsc),i(gkpnd),i(gkstrd),i(gkphsd),i(gkpne),i(gkstre),i(gkphse),i(gkpnf),i(gkstrf),i(gkphsf),i(gkpng),i(gkstrg),i(gkphsg),i(gkpnh),i(gkstrh),i(gkphsh),i(gkpni),i(gkstri),i(gkphsi),i(gkpnj),i(gkstrj),i(gkphsj)
	endif					;END OF THIS CONDITIONAL BRANCH

	if gkOnOff=1 then			;IF ON/OFF BUTTON IS ON...
	 kporttime	linseg	0,0.001,0.01	;CREATE A FUNCTION THAT RISES QUICKLY TO A HELD VALUE THAT WILL BE USED FOR PORTAMENTO TIME
	 kfrq	portk	gkfrq,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
 	 kamp	portk	gkamp,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	 if	gkSclFrq==1 then		;IF RESCALING FREQUENCY BUTTON IS ACTIVATED...
	   kfrq=kfrq/gkpna			;DIVIDE BASE FREQUENCY BY THE PARTIAL NUMBER OF THE FIRST PARTIAL
 	 endif					;END OF THIS CONDITIONAL BRANCH
	 a1	oscili	kamp,kfrq,giwave	;CREATE AN AUDIO OSCILLATOR THAT WILL USE THE GEN09 DESIGNED WAVEFORM
	 	out	a1			;SEND THE AUDIO TO THE OUTPUT. APPLY THE AMPLITUDE ENVELOPE
	endif
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
