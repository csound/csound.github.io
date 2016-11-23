dam.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -iadc -dm0
</CsOptions>

<CsInstruments>

sr 	=	44100	;SAMPLE RATE
ksmps 	=	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	=	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL | WIDTH | HEIGHT | X | Y
				FLpanel	"dam",   500,    400,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    120,     30,    5,  5,     0,     1,      0,      -1
FLsetColor2	255,255,50,ihOnOff

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idthreshold			FLvalue	"",        80,    20,     5, 125
idcomp1				FLvalue	"",        80,    20,     5, 175
idcomp2				FLvalue	"",        80,    20,     5, 225
idrtime				FLvalue	"",        80,    20,     5, 275
idftime				FLvalue	"",        80,    20,     5, 325
idgain				FLvalue	"",        80,    20,     5, 375

;SLIDERS					            				MIN |  MAX  | EXP | TYPE |    DISP    | WIDTH | HEIGHT | X | Y
gkthreshold,ihthreshold		FLslider 	"Threshold (amp. val.)",		1,    32768,  -1,    23,   idthreshold,  490,     25,    5, 100
gkcomp1,ihcomp1			FLslider 	"Compression Upper Zone (i-rate)",	0.01,   100,  -1,    23,   idcomp1,      490,     25,    5, 150
gkcomp2,ihcomp2			FLslider 	"Compression Lower Zone (i-rate)",	0.01,   100,  -1,    23,   idcomp2,      490,     25,    5, 200
gkrtime,ihrtime			FLslider 	"Gain Rise Time",			0.001,    1,  -1,    23,   idrtime,      490,     25,    5, 250
gkftime,ihftime			FLslider 	"Gain Fall Time",			0.001,    1,  -1,    23,   idftime,      490,     25,    5, 300
gkgain,ihgain			FLslider 	"Make Up Gain",				0.5,    100,  -1,    23,   idgain,       490,     25,    5, 350
gkInGain,ihInGain		FLslider 	"Live Input Gain",			0,        1,   0,    23,   -1,           190,     12,  300,   2

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, gihinput		FLbutBank	14,     1,     4,     18,      80,   200, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input:", 	1,       5,    14,     50,      20, 150,   0
ih		 	FLbox  	"Live     ", 	1,       5,    14,     75,      20, 220,   0
ih		 	FLbox  	"Drum Loop", 	1,       5,    14,     75,      20, 220,  20
ih		 	FLbox  	"Vocal    ", 	1,       5,    14,     75,      20, 220,  40
ih		 	FLbox  	"Synth Pad", 	1,       5,    14,     75,      20, 220,  60

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	200, 	ihthreshold
				FLsetVal_i	1, 	ihcomp1
				FLsetVal_i	1, 	ihcomp2
				FLsetVal_i	0.001, 	ihrtime
				FLsetVal_i	0.1, 	ihftime
				FLsetVal_i	1, 	ihgain
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            dam                              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The 'dam' opcode provides dynamic processing to an input     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"audio signal.                                                ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"A threshold amplitude value is defined and then the          ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"compression or expansion ratio for each zone, upper and      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"lower, are defined. Ratio values less than one will compress ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"audio signals within that zone, values greater than one will ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"expand the signal, a value of one will leave the signal      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"unchanged. The rise and fall response times of the compresser", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"can be modified individually.                                ", 	1,      5,     14,    490,    15,     5, 200

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1
	if gkOnOff=0 then
		turnoff
	endif

	if gkinput=0 then
		aSigL, aSigR	ins
		aSigL	=	aSigL*gkInGain
		aSigR	=	aSigR*gkInGain
	elseif gkinput=1 then
		aSigL, aSigR	diskin2	"808loop.wav",1,0,1
	elseif gkinput=2 then
		aSigL		diskin2	"AndItsAll.wav",1,0,1
		aSigR	=	aSigL
	elseif gkinput=3 then
		aSigL, aSigR	diskin2	"SynthPad.wav",1,0,1
	endif
	
	ktrig	changed	gkcomp1, gkcomp2, gkrtime, gkftime
	if ktrig=1 then
		reinit	UPDATE
	endif
	UPDATE:
	
	aCompL	dam 		aSigL, gkthreshold, i(gkcomp1), i(gkcomp2), i(gkrtime), i(gkftime)
	aCompR	dam 		aSigR, gkthreshold, i(gkcomp1), i(gkcomp2), i(gkrtime), i(gkftime)
	
	rireturn
		outs	aCompL*gkgain, aCompR*gkgain
endin
  	
</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>