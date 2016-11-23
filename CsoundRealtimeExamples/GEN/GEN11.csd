GEN11.csd
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
				FLpanel	"GEN11",  500,    170,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,   -1
gkSclFrq,ihSclFrq	FLbutton	"Rescale Frq.",	1,    0,    22,    120,     25,    5, 35,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihSclFrq		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idfrq			FLvalue	" ",       50,     17,  130,  20
idamp			FLvalue	" ",       50,     17,  130,  55
idr			FLvalue	" ",       50,     17,    5, 145

;SLIDERS						MIN  |  MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y
gkfrq,ihfrq		FLslider 	"Frequency",	1,    5000,   -1,    23,   idfrq,     360,     15,  130,    5
gkamp,ihamp		FLslider 	"Global Amp.",	0,       1,    0,    23,   idamp,     360,     15,  130,   40
gkr,ihr			FLslider 	"Amp.Power",	0,       4,    0,    23,   idr,       490,     25,    5,  120

;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gknh, ihnh		FLcount  	"Num.Harms.", 	1,    500,    1,     10,     1,     120,     25,    10, 75,   -1 
gklh, ihlh		FLcount  	"Lowest Harm.",	1,    500,    1,     10,     1,     120,     25,   135, 75,   -1 

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	440, 	ihfrq
				FLsetVal_i	0.3, 	ihamp
				FLsetVal_i	1, 	ihr
				FLsetVal_i	8, 	ihnh
				FLsetVal_i	1, 	ihlh
			                                                           
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 600, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN11                          ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"GEN11 is a function table version of the 'gbuzz' opcode.     ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"The waveform GEN11 creates is a composite of harmonically    ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"related cosine waves. The user can specify the number of     ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"cosine waves in the stack and the partial number of the      ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"lowest cosine in the stack. Finally, just as with gbuzz, a   ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"multipler in an amplitude coefficient series is provided.    ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"Varying this parameter will shift the spectral predominence  ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"up or down the stack of partials.                            ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"An efficiency advantage of using GEN11 over gbuzz is that    ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"calculation of the waveform can be done at the start of      ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"Csound performance once only as opposed to with every note,  ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"as would be the case when using gbuzz. In this implementation", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"because the function table is being forced to reintialise    ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"whenever changes are made, the table has to be recalculated  ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"anyway. The advantage to using gbuzz over GEN11 is that its  ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"parameters can be modulated at k-rate. The parameter         ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"modulation implemented in this example is not k-rate         ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"modulation and may produce discontinuities in the output.    ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"Changes made to the function table can be viewed in the      ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"output waveform if displays are enabled (i.e. if the -d flag ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"is not used).                                                ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"If the 'Rescale Frq.' button is activated then the           ", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"fundemental of the audio generating oscillator is rescaled   ", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"by the reciprocal of the lowest harmonic - the frequency of  ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"the lowest harmonic will in this case correspond to the      ", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"frequency defined by the 'Frequency' slider. For example: if ", 	1,      5,     14,    490,     20,    5, 540
ih		 	FLbox  	"'Lowest Harm' is '1', no rescaling is applied, if it is '2', ", 	1,      5,     14,    490,     20,    5, 560
ih		 	FLbox  	"frequency of the oscillator is divided by 2.                 ", 	1,      5,     14,    490,     20,    5, 580
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                               
instr	1	;UPDATES FUNCTION TABLE                    
	ktrig	changed	gknh,gklh,gkr		;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO CREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. BEGIN REINITIALIZATION FROM HERE.
	  ;CREATE THE GEN09 FUNCTION TABLE. 
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE
	  giwave	ftgen	1,0,4096,11,i(gknh),i(gklh),i(gkr)
	  rireturn				;RETURN FROM REINITIALIZATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH

	if gkOnOff=1 then			;IF ON/OFF BUTTON IS ON...
	 kporttime	linseg	0,0.001,0.01	;CREATE A FUNCTION THAT RISES QUICKLY TO A HELD VALUE THAT WILL BE USED FOR PORTAMENTO TIME
	 kfrq	portk	gkfrq,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	 kamp	portk	gkamp,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	 if	gkSclFrq==1 then		;IF RESCALING FREQUENCY BUTTON IS ACTIVATED...
	   kfrq=kfrq/gklh			;DIVIDE BASE FREQUENCY BY THE PARTIAL NUMBER OF THE LOWEST PARTIAL
	 endif					;END OF THIS CONDITIONAL BRANCH
	 a1	oscili	kamp,kfrq,giwave	;CREATE AN LINEARLY INTERPOLATING AUDIO OSCILLATOR THAT WILL USE THE GEN09 DESIGNED WAVEFORM
		out	a1			;SEND THE AUDIO TO THE OUTPUT. APPLY THE AMPLITUDE ENVELOPE
	endif
endin

instr	2	;PLAYS A TONE
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
