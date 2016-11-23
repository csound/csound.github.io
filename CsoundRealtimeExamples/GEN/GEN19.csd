GEN19.csd
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
				FLpanel	"GEN19",  500,    520,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,    -1
gkSclFrq,ihSclFrq	FLbutton	"Rescale Frq.",	1,    0,    22,    120,     25,    5, 35,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihSclFrq		;SET SECONDARY COLOUR TO RED

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
gkdcoa, ihdcoa		FLtext		"D.C. Offset a",-1,     1,  0.01,     1,   100,     20,    325,  80
gkpnb, ihpnb		FLtext		"Part. Nr. b", 	0,    200,  0.01,     1,   100,     20,     10, 120
gkstrb, ihstrb		FLtext		"Strength b", 	0,    1,    0.01,     1,   100,     20,    115, 120
gkphsb, ihphsb		FLtext		"Phase b", 	0,    360,  0.01,     1,   100,     20,    220, 120
gkdcob, ihdcob		FLtext		"D.C. Offset b",-1,     1,  0.01,     1,   100,     20,    325, 120
gkpnc, ihpnc		FLtext		"Part. Nr. c", 	0,    200,  0.01,     1,   100,     20,     10, 160
gkstrc, ihstrc		FLtext		"Strength c", 	0,    1,    0.01,     1,   100,     20,    115, 160
gkphsc, ihphsc		FLtext		"Phase c", 	0,    360,  0.01,     1,   100,     20,    220, 160
gkdcoc, ihdcoc		FLtext		"D.C. Offset c",-1,     1,  0.01,     1,   100,     20,    325, 160
gkpnd, ihpnd		FLtext		"Part. Nr. d", 	0,    200,  0.01,     1,   100,     20,     10, 200
gkstrd, ihstrd		FLtext		"Strength d", 	0,    1,    0.01,     1,   100,     20,    115, 200
gkphsd, ihphsd		FLtext		"Phase d", 	0,    360,  0.01,     1,   100,     20,    220, 200
gkdcod, ihdcod		FLtext		"D.C. Offset d",-1,     1,  0.01,     1,   100,     20,    325, 200
gkpne, ihpne		FLtext		"Part. Nr. e", 	0,    200,  0.01,     1,   100,     20,     10, 240
gkstre, ihstre		FLtext		"Strength e", 	0,    1,    0.01,     1,   100,     20,    115, 240
gkphse, ihphse		FLtext		"Phase e", 	0,    360,  0.01,     1,   100,     20,    220, 240
gkdcoe, ihdcoe		FLtext		"D.C. Offset e",-1,     1,  0.01,     1,   100,     20,    325, 240
gkpnf, ihpnf		FLtext		"Part. Nr. f", 	0,    200,  0.01,     1,   100,     20,     10, 280
gkstrf, ihstrf		FLtext		"Strength f", 	0,    1,    0.01,     1,   100,     20,    115, 280
gkphsf, ihphsf		FLtext		"Phase f", 	0,    360,  0.01,     1,   100,     20,    220, 280
gkdcof, ihdcof		FLtext		"D.C. Offset f",-1,     1,  0.01,     1,   100,     20,    325, 280
gkpng, ihpng		FLtext		"Part. Nr. g", 	0,    200,  0.01,     1,   100,     20,     10, 320
gkstrg, ihstrg		FLtext		"Strength g", 	0,    1,    0.01,     1,   100,     20,    115, 320
gkphsg, ihphsg		FLtext		"Phase g", 	0,    360,  0.01,     1,   100,     20,    220, 320
gkdcog, ihdcog		FLtext		"D.C. Offset g",-1,     1,  0.01,     1,   100,     20,    325, 320
gkpnh, ihpnh		FLtext		"Part. Nr. h", 	0,    200,  0.01,     1,   100,     20,     10, 360
gkstrh, ihstrh		FLtext		"Strength h", 	0,    1,    0.01,     1,   100,     20,    115, 360
gkphsh, ihphsh		FLtext		"Phase h", 	0,    360,  0.01,     1,   100,     20,    220, 360
gkdcoh, ihdcoh		FLtext		"D.C. Offset h",-1,     1,  0.01,     1,   100,     20,    325, 360
gkpni, ihpni		FLtext		"Part. Nr. i", 	0,    200,  0.01,     1,   100,     20,     10, 400
gkstri, ihstri		FLtext		"Strength i", 	0,    1,    0.01,     1,   100,     20,    115, 400
gkphsi, ihphsi		FLtext		"Phase i", 	0,    360,  0.01,     1,   100,     20,    220, 400
gkdcoi, ihdcoi		FLtext		"D.C. Offset i",-1,     1,  0.01,     1,   100,     20,    325, 400
gkpnj, ihpnj		FLtext		"Part. Nr. j", 	0,    200,  0.01,     1,   100,     20,     10, 440
gkstrj, ihstrj		FLtext		"Strength j", 	0,    1,    0.01,     1,   100,     20,    115, 440
gkphsj, ihphsj		FLtext		"Phase j", 	0,    360,  0.01,     1,   100,     20,    220, 440
gkdcoj, ihdcoj		FLtext		"D.C. Offset j",-1,     1,  0.01,     1,   100,     20,    325, 440
gkpnk, ihpnk		FLtext		"Part. Nr. k", 	0,    200,  0.01,     1,   100,     20,     10, 480
gkstrk, ihstrk		FLtext		"Strength k", 	0,    1,    0.01,     1,   100,     20,    115, 480
gkphsk, ihphsk		FLtext		"Phase k", 	0,    360,  0.01,     1,   100,     20,    220, 480
gkdcok, ihdcok		FLtext		"D.C. Offset k",-1,     1,  0.01,     1,   100,     20,    325, 480

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	440, 	ihfrq
				FLsetVal_i	0.3, 	ihamp
				FLsetVal_i	1, 	ihpna
				FLsetVal_i	1, 	ihstra
				FLsetVal_i	0, 	ihphsa
				FLsetVal_i	0, 	ihdcoa
				FLsetVal_i	2, 	ihpnb
				FLsetVal_i	0.5, 	ihstrb
				FLsetVal_i	0, 	ihphsb
				FLsetVal_i	0, 	ihdcob
				FLsetVal_i	3, 	ihpnc
				FLsetVal_i	0, 	ihstrc
				FLsetVal_i	0, 	ihphsc
				FLsetVal_i	0, 	ihdcoc
				FLsetVal_i	4, 	ihpnd
				FLsetVal_i	0, 	ihstrd
				FLsetVal_i	0, 	ihphsd
				FLsetVal_i	0, 	ihdcod
				FLsetVal_i	5, 	ihpne
				FLsetVal_i	0, 	ihstre
				FLsetVal_i	0, 	ihphse
				FLsetVal_i	0, 	ihdcoe
				FLsetVal_i	6, 	ihpnf
				FLsetVal_i	0, 	ihstrf
				FLsetVal_i	0, 	ihphsf
				FLsetVal_i	0, 	ihdcof
				FLsetVal_i	7, 	ihpng
				FLsetVal_i	0, 	ihstrg
				FLsetVal_i	0, 	ihphsg
				FLsetVal_i	0, 	ihdcog
				FLsetVal_i	8, 	ihpnh
				FLsetVal_i	0, 	ihstrh
				FLsetVal_i	0, 	ihphsh
				FLsetVal_i	0, 	ihdcoh
				FLsetVal_i	9, 	ihpni
				FLsetVal_i	0, 	ihstri
				FLsetVal_i	0, 	ihphsi
				FLsetVal_i	0, 	ihdcoi
				FLsetVal_i	10, 	ihpnj
				FLsetVal_i	0, 	ihstrj
				FLsetVal_i	0, 	ihphsj
			        FLsetVal_i	0, 	ihdcoj
				FLsetVal_i	11, 	ihpnk
				FLsetVal_i	0, 	ihstrk
				FLsetVal_i	0, 	ihphsk
			        FLsetVal_i	0, 	ihdcok
				                     
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 180, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             GEN19                           ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"GEN19 offers a further elaboration of GEN10 and GEN09 in that", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"in addition to specifying the partial number,strength and    ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"phase of each contributing sine wave the user can specify the", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"DC offset for each component - an amount by which the        ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"waveform can be shifted up or down the y axis.               ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"For a fuller description of the other functions of this      ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"example I refer you to the description for the GEN09 example.", 	1,      5,     14,    490,     20,    5, 160
                                            
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                               
instr	1	;UPDATES FUNCTION TABLE                    
	ktrig	changed	gkpna,gkstra,gkphsa,gkdcoa,gkpnb,gkstrb,gkphsb,gkdcob,gkpnc,gkstrc,gkphsc,gkdcoc,gkpnd,gkstrd,gkphsd,gkdcod,gkpne,gkstre,gkphse,gkdcoe,gkpnf,gkstrf,gkphsf,gkdcof,gkpng,gkstrg,gkphsg,gkdcog,gkpnh,gkstrh,gkphsh,gkdcoh,gkpni,gkstri,gkphsi,gkdcoi,gkpnj,gkstrj,gkphsj,gkdcoj,gkpnk,gkstrk,gkphsk,gkdcok	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO RECREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. BEGIN REINITIALISATION FROM HERE.
	  ;CREATE THE GEN19 FUNCTION TABLE. 
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE
	  giwave	ftgen	1,0,4096,19,i(gkpna),i(gkstra),i(gkphsa),i(gkdcoa),i(gkpnb),i(gkstrb),i(gkphsb),i(gkdcob),i(gkpnc),i(gkstrc),i(gkphsc),i(gkdcoc),i(gkpnd),i(gkstrd),i(gkphsd),i(gkdcod),i(gkpne),i(gkstre),i(gkphse),i(gkdcoe),i(gkpnf),i(gkstrf),i(gkphsf),i(gkdcof),i(gkpng),i(gkstrg),i(gkphsg),i(gkdcog),i(gkpnh),i(gkstrh),i(gkphsh),i(gkdcoh),i(gkpni),i(gkstri),i(gkphsi),i(gkdcoi),i(gkpnj),i(gkstrj),i(gkphsj),i(gkdcoj),i(gkpnk),i(gkstrk),i(gkphsk),i(gkdcok)
	endif					;END OF THIS CONDITIONAL BRANCH

	if gkOnOff=1 then			;IF ON/OFF BUTTON IS OFF...
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
