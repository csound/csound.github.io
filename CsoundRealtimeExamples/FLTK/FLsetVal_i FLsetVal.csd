FLsetVal_i FLsetVal.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

;USING THE FLsetVal_i OPCODE TO DEFINE THE INITIAL OUTPUT VALUE AND GRAPHIC POSITION OF AN FL-SLIDER 

sr		=	44100                                                                                                               
ksmps		=	4
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

FLcolor	255,255,255,0,0,0	;SET COLOUR SCHEME
;		OPCODE	 LABEL                | WIDTH | HEIGHT | X | Y
		FLpanel	"FLsetVal_i FLsetVal",   800,    620,   50, 50

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq				FLvalue	" ",       80,    20,    10,  80

gkfreq,gihandle	FLslider	"Frequency", 50, 5000, -1, 3, idfreq, 780, 30, 10, 50	;IN THIS CASE THE HANDLE NEEDS TO BE A GLOBAL VARIABLE AS IT WILL BE REFERENCED WITHIN INSTRUMENT 2
                                                          
initval	=		500	;INITIAL VALUE FOR SLIDER
		FLsetVal_i	initval, gihandle

		                                                                                                               
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	3,        9,    15,   800-6,   125,   3, 147
ih		 	FLbox  	" ", 	3,        9,    15,   800-6,   120,   3, 290-3
ih		 	FLbox  	" ", 	3,        9,    15,   800-6,   185,   3, 420-3
                                                                       
;TEXT BOXES																TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 FLbox  	"FLsetVal_i csn be used to set an valuator to an initial value. Left uninitialised, the variable", 	1,      5,     14,    790,    20,     5, 150
ih		 FLbox  	"it outputs defaults to zero.                                                                   ", 	1,      5,     14,    790,    20,     5, 170
ih		 FLbox  	"The following line:                                                                            ", 	1,      5,     14,    790,    20,     5, 190
ih1		 FLbox  	"  FLsetVal_i 500, ihandle                  ", 	            						1,      5,     14,    400,    20,   200, 210
ih		 FLbox  	"instructs it to adopt the value 500. As the slider uses exponential scaling a small inaccuracy ", 	1,      5,     14,    790,    20,     5, 230
ih		 FLbox  	"occurs.                                                                                        ", 	1,      5,     14,    790,    20,     5, 250

ih		 FLbox  	"A valuator can be instructed to adopt a new value while performance is underway by using       ", 	1,      5,     14,    790,    20,     5, 290
ih		 FLbox  	"FLsetVal_i within an instrument. The buttons below trigger note event which initialialize the  ", 	1,      5,     14,    790,    20,     5, 310
ih		 FLbox  	"slider the the values written on them.                                                         ", 	1,      5,     14,    790,    20,     5, 330

ih		 FLbox  	"A slider can also be instructed to set itself to a particular value at k-rate using 'FLsetVal'.", 	1,      5,     14,    790,    20,     5, 420
ih		 FLbox  	" Normally in the interests of efficiency, the rate at which this is done is somewhat slower    ", 	1,      5,     14,    790,    20,     5, 440
ih		 FLbox  	"than full k-rate. FLsetVal has a trigger input to make it easier for us to control the rate at ", 	1,      5,     14,    790,    20,     5, 460
ih		 FLbox  	"which it updates. In this example a 'metro' is used to generate triggers 50 times a second.    ", 	1,      5,     14,    790,    20,     5, 480
ih		 FLbox  	"The slider will be updated at this rate to values defined by a random function.                ", 	1,      5,     14,    790,    20,     5, 500
ih		 FLbox  	"Click the button below to activate this function.                                              ", 	1,      5,     14,    790,    20,     5, 520
                                                                                                                                            
FLsetColor	255,255,200,ih1
                                                                                                                                                  
;SWITCHES                               ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR | p4
gk,ih		FLbutton	"50",	1,    0,    21,    50,      35,    5+5,355,   0,      2,      0,        0,    50	;NOTE DURATION CAN BE ZERO AS ONLY I-TIME EVENTS ARE NEEDED
gk,ih		FLbutton	"100",	1,    0,    21,    50,      35,   60+5,355,   0,      2,      0,        0,   100
gk,ih		FLbutton	"200",	1,    0,    21,    50,      35,  115+5,355,   0,      2,      0,        0,   200                       
gk,ih		FLbutton	"300",	1,    0,    21,    50,      35,  170+5,355,   0,      2,      0,        0,   300
gk,ih		FLbutton	"400",	1,    0,    21,    50,      35,  225+5,355,   0,      2,      0,        0,   400                    
gk,ih		FLbutton	"500",	1,    0,    21,    50,      35,  280+5,355,   0,      2,      0,        0,   500
gk,ih		FLbutton	"600",	1,    0,    21,    50,      35,  335+5,355,   0,      2,      0,        0,   600
gk,ih		FLbutton	"700",	1,    0,    21,    50,      35,  390+5,355,   0,      2,      0,        0,   700
gk,ih		FLbutton	"800",	1,    0,    21,    50,      35,  445+5,355,   0,      2,      0,        0,   800
gk,ih		FLbutton	"900",	1,    0,    21,    50,      35,  500+5,355,   0,      2,      0,        0,   900
gk,ih		FLbutton	"1000",	1,    0,    21,    50,      35,  555+5,355,   0,      2,      0,        0,  1000
gk,ih		FLbutton	"1100",	1,    0,    21,    50,      35,  610+5,355,   0,      2,      0,        0,  1100
gk,ih		FLbutton	"1200",	1,    0,    21,    50,      35,  665+5,355,   0,      2,      0,        0,  1200
gk,ih		FLbutton	"1300",	1,    0,    21,    50,      35,  720+5,355,   0,      2,      0,        0,  1300

gkRandSlid,ih	FLbutton	"Click this button to activate this function.",\
                                        1,    0,    22,    360,     50,  220,  540,   0,      3,      0,       -1
FLsetColor	190,190,190,ih
FLsetColor2	255,255,100,ih

		FLpanel_end	;END OF PANEL CONTENTS                                                                   
		FLrun		;RUN THE WIDGET THREAD                                                            

instr 1
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE
	kfreq		portk	gkfreq, kporttime	;SMOOTH SLIDER VARIABLE
	kpwL		rspline	0.1,0.9,2,8		;RANDOMLY DRIFTING PULSE WIDTH. A DIFFERENT FUNCTION FOR THEW LEFT AND RIGHT CHANNELS
	kpwR		rspline	0.1,0.9,2,8		;
	aL		vco2	0.1,kfreq,4,kpwL	;LEFT CHANNEL OSCILLATOR. A TRIANGLE WAVE WITH RANDOMLY DRIFTING PULSE WIDTH
	aR		vco2	0.1,kfreq,4,kpwR	;LEFT CHANNEL OSCILLATOR. A TRIANGLE WAVE WITH RANDOMLY DRIFTING PULSE WIDTH
			outs	aL,aR
endin

instr	2	;RESET FREQUENCY SLIDER TO THE VALUE GIVEN TO THE INSTRUMENT VIA p4
	FLsetVal_i	p4,gihandle
endin

instr	3	;RANDOMLY DRIVE FREQUENCY SLIDER
	if gkRandSlid==0 then
	  turnoff
	endif
	ifn	ftgentmp	0,0,4096,-16,50,4096,4,5000
	kndx	rspline		0,1,0.4,2
	kcps	table		kndx,ifn,1
	kmetro	metro		40
		FLsetVal	kmetro,kcps,gihandle
endin

</CsInstruments>

<CsScore>
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>