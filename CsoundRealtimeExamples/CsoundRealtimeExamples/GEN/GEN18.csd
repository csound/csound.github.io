GEN18.csd
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

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN18",  500,    320,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfrq				FLvalue	" ",       50,     17,  200,  20
idampa				FLvalue	" ",       50,     17,    5, 165
idampb				FLvalue	" ",       50,     17,    5, 245

;SLIDERS					            		MIN |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y
gkfrq,ihfrq			FLslider 	"Base Frequency",	1,    5000,  -1,    23,    idfrq,     280,      15, 200,      5
gkampa,ihampa			FLslider 	"Amplitude A",		0,       1,   0,    23,   idampa,     490,      15,   5,    150
gkampb,ihampb			FLslider 	"Amplitude B",		0,       1,   0,    23,   idampb,     490,      15,   5,    230

;COUNTERS					     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkstarta, ihstarta		FLcount  	"Start A", 	0,    4095,   1,      32,     1,     120,      20,  10,190,   -1 
gkfinisha, ihfinisha		FLcount  	"Finish A", 	0,    4095,   1,      32,     1,     120,      20, 140,190,   -1 
gkstartb, ihstartb		FLcount  	"Start B", 	0,    4095,   1,      32,     1,     120,      20,  10,270,   -1 
gkfinishb, ihfinishb		FLcount  	"Finish B", 	0,    4095,   1,      32,     1,     120,      20, 140,270,   -1 

;VALUE INPUT BOXES				 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkpn1, ihpn1		FLtext		"Part. Nr. 1", 	0,    200,  0.01,     1,   100,     20,    110,  50
gkstr1, ihstr1		FLtext		"Strength 1", 	0,    1,    0.01,     1,   100,     20,    215,  50
gkphs1, ihphs1		FLtext		"Phase 1", 	0,    360,  0.01,     1,   100,     20,    320,  50
gkpn2, ihpn2		FLtext		"Part. Nr. 2", 	0,    200,  0.01,     1,   100,     20,    110, 100
gkstr2, ihstr2		FLtext		"Strength 2", 	0,    1,    0.01,     1,   100,     20,    215, 100
gkphs2, ihphs2		FLtext		"Phase 2", 	0,    360,  0.01,     1,   100,     20,    320, 100

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Input Table 1:", 	1,      3,     14,     98,    20,    10,  58
ih		 	FLbox  	"Input Table 2:", 	1,      3,     14,     98,    20,    10, 108

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	300, 	ihfrq
				FLsetVal_i	1, 	ihampa
				FLsetVal_i	0, 	ihstarta
				FLsetVal_i	2047, 	ihfinisha
				FLsetVal_i	1, 	ihampb
				FLsetVal_i	2048, 	ihstartb
				FLsetVal_i	4095, 	ihfinishb
				FLsetVal_i	1, 	ihpn1
				FLsetVal_i	1, 	ihstr1
				FLsetVal_i	0, 	ihphs1
				FLsetVal_i	3, 	ihpn2
				FLsetVal_i	1, 	ihstr2
				FLsetVal_i	0, 	ihphs2
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 480, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN18                          ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"GEN18 combines two or more function tables into a new        ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"function table according to certain user defined parameters  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"concerning the strength, start location and finish location  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"for each contributing function table.                        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"In this implementation two GEN09 contributing function tables", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"are employed. The strength parameters for the two GEN09s are ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"slightly superfluous as the relative strengths of the        ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"contributing waveforms will be controlled within GEN18's own ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"parameters. Experimenting with the GEN09's partial numbers   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"will provide most interest.                                  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"GEN18 will accept a function table created using any GEN     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"routine as input and any number of contributing function     ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"tables can be employed so the number of possible applications", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"for it is quite large. This example is kept rather simple to ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"provide a clear demonstration of its functioning.            ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Visual feedback of the resulting function table will be given", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"provided Csound's displays are enabled by not using the      ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"output display suppressing flag -d. Displays can be          ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"re-enabled using the --displays flag.                        ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"The maximum size allowed for a GEN18 table seems to be 32768.", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"This might need further investigation but if problems are    ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"encountered it may be worth considering whether the table is ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"too large.                                                   ", 	1,      5,     14,    490,    15,     5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD                      
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;
	ktrig	changed	gkampa,gkstarta,gkfinisha,gkampb,gkstartb,gkfinishb,gkpn1,gkstr1,gkphs1,gkpn2,gkstr2,gkphs2	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO RECREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. BEGIN REINITIALISATION FROM HERE.
	  ;CREATE THE FUNCTION TABLES. SPECIFIC FUNCTION TABLE NUMBERS ARE USED (I.E. NOT ZERO) SO THAT THE OLD TABLES WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE. 
	  ;FIRST OF ALL THE TWO GEN09 CONTRIBUTING FUNCTION TABLES 
	  gi1		ftgen	1,0,4096,9,i(gkpn1),i(gkstr1),i(gkphs1)	  
	  gi2		ftgen	2,0,4096,9,i(gkpn2),i(gkstr2),i(gkphs2)
	  ;CREATE THE COMPOSITE WAVEFORM USING GEN18
	  gi3		ftgen 	3,0,4097,18,1,i(gkampa),i(gkstarta),i(gkfinisha),2,i(gkampb),i(gkstartb),i(gkfinishb) 
	  rireturn				;RETURN FROM REINITIALISATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH
	kporttime	linseg	0,0.001,0.01	;CREATE A FUNCTION THAT RISES UP QUICKLY TO A FIXED VALUE THAT WILL BE USED AS PORTAMENTO TIME
	kfrq		portk	gkfrq,kporttime	;APPLY PORTAMENTO TO THE FLTK SLIDER VARIABLE
	kOnOff		portk	gkOnOff,kporttime	;APPLY PORTAMENTO TO THE ON/OFF SWITCH
	asig	poscil	0.2*kOnOff,kfrq,gi3	;AUDIO OSCILLATOR THAT USES TYHE COMPOSITE WAVEFORM
		out	asig			;SEND AUDIO TO OUTPUT
endin                                       
  	
</CsInstruments>                         

<CsScore>
i 1 0 3600	;INSTR 1 PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
