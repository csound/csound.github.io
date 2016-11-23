GEN10.csd
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
FLcolor	255, 255, 255,0,0,0
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN10",  515,    500,    0,  0
				FLscroll          515,    500,    0,  0

;TEXT BOXES (PAINT PANEL WHITE)		TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 	1,      5,     14,    515,    820,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idfrq			FLvalue	" ",       50,     17,  130,  20
idamp			FLvalue	" ",       50,     17,  130,  55
idamp1			FLvalue	" ",       50,     17,   10,  90                     
idamp2			FLvalue	" ",       50,     17,   10, 125
idamp3			FLvalue	" ",       50,     17,   10, 169
idamp4			FLvalue	" ",       50,     17,   10, 195
idamp5			FLvalue	" ",       50,     17,   10, 230              
idamp6			FLvalue	" ",       50,     17,   10, 265
idamp7			FLvalue	" ",       50,     17,   10, 300              
idamp8			FLvalue	" ",       50,     17,   10, 335              
idamp9			FLvalue	" ",       50,     17,   10, 370              
idamp10			FLvalue	" ",       50,     17,   10, 405              
idamp11			FLvalue	" ",       50,     17,   10, 440                                     
idamp12			FLvalue	" ",       50,     17,   10, 475              
idamp13			FLvalue	" ",       50,     17,   10, 510              
idamp14			FLvalue	" ",       50,     17,   10, 545              

;SLIDERS						MIN  |  MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y
gkfrq,ihfrq		FLslider 	"Frequency",	1,    5000,   -1,    23,   idfrq,     360,     15,  130,    5
gkamp,ihamp		FLslider 	"Global Amp.",	0,       1,    0,    23,   idamp,     360,     15,  130,   40
gkamp1,ihamp1		FLslider 	"Amp.1",	0,       1,    0,    23,   idamp1,    480,     15,   10,   75
gkamp2,ihamp2		FLslider 	"Amp.2",	0,       1,    0,    23,   idamp2,    480,     15,   10,  110
gkamp3,ihamp3		FLslider 	"Amp.3",	0,       1,    0,    23,   idamp3,    480,     15,   10,  145
gkamp4,ihamp4		FLslider 	"Amp.4",	0,       1,    0,    23,   idamp4,    480,     15,   10,  180
gkamp5,ihamp5		FLslider 	"Amp.5",	0,       1,    0,    23,   idamp5,    480,     15,   10,  215
gkamp6,ihamp6		FLslider 	"Amp.6",	0,       1,    0,    23,   idamp6,    480,     15,   10,  250
gkamp7,ihamp7		FLslider 	"Amp.7",	0,       1,    0,    23,   idamp7,    480,     15,   10,  285
gkamp8,ihamp8		FLslider 	"Amp.8",	0,       1,    0,    23,   idamp8,    480,     15,   10,  320
gkamp9,ihamp9		FLslider 	"Amp.9",	0,       1,    0,    23,   idamp9,    480,     15,   10,  355
gkamp10,ihamp10		FLslider 	"Amp.10",	0,       1,    0,    23,   idamp10,   480,     15,   10,  390
gkamp11,ihamp11		FLslider 	"Amp.11",	0,       1,    0,    23,   idamp11,   480,     15,   10,  425
gkamp12,ihamp12		FLslider 	"Amp.12",	0,       1,    0,    23,   idamp12,   480,     15,   10,  460
gkamp13,ihamp13		FLslider 	"Amp.13",	0,       1,    0,    23,   idamp13,   480,     15,   10,  495
gkamp14,ihamp14		FLslider 	"Amp.14",	0,       1,    0,    23,   idamp14,   480,     15,   10,  530

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkftsize, ihftsize		FLbutBank	14,     1,     12,     18,   12*20,  100,580,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Table Size:", 	1,      5,     14,    100,    15,      0,580

ih		 	FLbox  	"8    ", 	1,      5,     12,     40,    15,    120,580
ih		 	FLbox  	"16   ", 	1,      5,     12,     40,    15,    120,600
ih		 	FLbox  	"32   ", 	1,      5,     12,     40,    15,    120,620
ih		 	FLbox  	"64   ", 	1,      5,     12,     40,    15,    120,640
ih		 	FLbox  	"128  ", 	1,      5,     12,     40,    15,    120,660
ih		 	FLbox  	"256  ", 	1,      5,     12,     40,    15,    120,680
ih		 	FLbox  	"512  ", 	1,      5,     12,     40,    15,    120,700
ih		 	FLbox  	"1024 ", 	1,      5,     12,     40,    15,    120,720
ih		 	FLbox  	"2048 ", 	1,      5,     12,     40,    15,    120,740
ih		 	FLbox  	"4096 ", 	1,      5,     12,     40,    15,    120,760
ih		 	FLbox  	"8192 ", 	1,      5,     12,     40,    15,    120,780
ih		 	FLbox  	"16384", 	1,      5,     12,     40,    15,    120,800

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	440, 	ihfrq
				FLsetVal_i	0.3, 	ihamp                            
				FLsetVal_i	1, 	ihamp1
				FLsetVal_i	0,	ihamp2
				FLsetVal_i	0,      ihamp3
				FLsetVal_i	0,      ihamp4
				FLsetVal_i	0,      ihamp5
				FLsetVal_i	0,      ihamp6
				FLsetVal_i	0,      ihamp7
				FLsetVal_i	0,      ihamp8
				FLsetVal_i	0,      ihamp9
				FLsetVal_i	0,      ihamp10
				FLsetVal_i	0,      ihamp11
				FLsetVal_i	0,      ihamp12
				FLsetVal_i	0,      ihamp13
				FLsetVal_i	0,      ihamp14
				FLsetVal_i	7,      ihftsize
			        FLscroll_end                                            
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 660, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              GEN10                          ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"GEN10 allows us to define a waveform made up of harmonically ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"related sine waves of different strength in the manner of    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"additive synthesis.                                          ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The nature of the waveform is defined by providing a series  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"of values which correspond the ascending partials of the     ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"harmonic series. The number of partials employed is chosen by", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"the user in how many values they specify. In this example the", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"first 14 partials are used. The actual values used do not    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"specify an actual amplitude but instead define a strength    ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"relative to the strongest partial in the table. It is usual  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"decide upon a scale zero to 1 but this is entirely arbitary. ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"In this example the waveform created by defining the 14      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"partial strengths can be played by an 'oscil' oscillator.    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"The disadvantage of performing harmonic additive synthesis   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"using this method is that the waveform cannot be modified in ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"realtime without discontinuities in the audio. In order to   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"create dynamic spectra subtractive synthesis could be used   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"with the resulting waveform being filtered.                  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"If you enable Csound displays (i.e. if you don't use the -d  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"flag) you can observe changes visually as well as aurally.   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"At the bottom of the GUI panel opposite is a button bank that", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"allows the user to modify the number of points in the table -", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"table size. If the table size is reduced dramatically the    ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"audible (and visible) results are clear as the table becomes ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"unable to accurately represent the waveform demanded. The    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"audible artefacts produced by using very small tables are    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"reduced by using an interpolating oscillator such as 'oscili'", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"or 'poscil'. In the past when computer RAM was at more of a  ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"premium it was more important to efficiently select table    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"sizes but these days over-estimation can be done, generally  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"without serious consequences.                                ", 	1,      5,     14,    490,    20,     5, 640
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giindex	init	0	;SET INITIAL VALUE OF THE INDEX WHICH WILL BE USED AS A POINTER TO READ VALUES FROM THE FUCNTION TABLE
                                                                               
instr	1	;UPDATES FUNCTION TABLE
	ktrig	changed	gkamp1,gkamp2,gkamp3,gkamp4,gkamp5,gkamp6,gkamp7,gkamp8,gkamp9,gkamp10,gkamp11,gkamp12,gkamp13,gkamp14,gkftsize	;SENSE IF ONE OF THE PARAMETERS FOR CREATING THE AMPLITUDE ENVELOPE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE AMPLITUDE ENVELOPE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO CREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL
	  ;CREATE THE GEN10 FUNCTION TABLE. 
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE
	  iftsize	=	2^(3+i(gkftsize))
	  print	iftsize
	  giwave	ftgen	1,0,iftsize,10,i(gkamp1),i(gkamp2),i(gkamp3),i(gkamp4),i(gkamp5),i(gkamp6),i(gkamp7),i(gkamp8),i(gkamp9),i(gkamp10),i(gkamp11),i(gkamp12),i(gkamp13),i(gkamp14)
	endif					;END OF THIS CONDITIONAL BRANCH

	;CREATE A TONE
	if gkOnOff==1 then
	 kporttime	linseg	0,0.001,0.01
	 kfrq	portk	gkfrq,kporttime
	 kamp	portk	gkamp,kporttime
	 a1	oscil	kamp,kfrq,1
		out	a1
	endif
endin
                                                                                                    	
</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>
