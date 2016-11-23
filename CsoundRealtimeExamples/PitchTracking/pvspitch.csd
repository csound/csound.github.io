; pvspitch.csd
; Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>


<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	1
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvspitch",   500,    380,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
gkmeters, ihmeters	FLbutton	"Meters On/Off",1,    0,    22,    120,     20,   10,260,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihmeters		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idInGain		FLvalue	"",	 80,      20,    5,  75
idthresh		FLvalue	"",	 80,      20,    5, 125
idOutGain		FLvalue	"",	 80,      20,    5, 225
idrms			FLvalue	"",	 80,      20,   10, 305
idcps			FLvalue	"",	 80,      20,   10, 355

;SLIDERS							MIN   | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkInGain, ihInGain	FLslider 	"Input Gain",		0,       3,    0,    23,    idInGain,    490,     25,    5,   50
gkthresh, ihthresh	FLslider 	"Threshold",		0.001,   1,    0,    23,    idthresh,    490,     25,    5,  100
gkOutGain, ihOutGain	FLslider 	"Output Gain",		0,       1,    0,    23,    idOutGain,   490,     25,    5,  200

gkrms, gihrms		FLslider 	"rms",			0,         1,  0,    21,    idrms,       480,     25,   10,  280
gkcps, gihcps		FLslider 	"cps",			20,    10000, -1,    21,    idcps,       480,     25,   10,  330

;COUNTERS					     				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkFFTsize, gihFFTsize	FLcount  	"FFT Size", 				64,   4096,   1,       1,     2,     120,     25,  190,150,   -1 

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	1, 	ihInGain
			FLsetVal_i	0.1, 	ihthresh
			FLsetVal_i	0.7, 	ihOutGain
			FLsetVal_i	4, 	gihFFTsize

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     240,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvspitch                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'pvspitch' analyses an fsig and generates k-rate estimates of", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"fundemental frequency and amplitude. In this example the live", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"audio input is analysed and the analysed data is used to     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"define the frequency and amplitude of a synthesized tone.    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Threshold can be used to define a threshold beneath which    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"sound components will be ignored. This can be used to filter ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"out ambient noise between notes from the analysis.           ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Larger FFT sizes can improve the accuracy of the tracker at  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"expense of some response speed. After making changes to the  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"FFT size cycle 'On/Off' to hear the results.                 ", 	1,      5,     14,    490,    15,     5, 220
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giWave	ftgen	0, 0, 1024, 10, 1, 0.2, 0.15, 0.1, 0.2, 0.1, 0.05, 0.02, .01	;A RICH TONE - USED BY THE PITCH TRACKING SYNTHESIZER

instr	FFTsizes
	ivals	ftgentmp	0,0,-7,-2, 64,128,256,512,1024,2048,4096,8192	;TABLE THAT STORES THE NON-SEQUENTIAL VALUES
	indx	init	i(gkFFTsize)					;INDEX USED TO REFERENCE VALUES IN THE ABOVE TABLE
	ival	table	indx,ivals					;INITIAL VALUE FOR THE COUNTER AT START-UP
	
	kup	trigger	gkFFTsize,ival,0				;TRIGGER GENERATED WHEN COUNTER IS INCREASED
	kdn	trigger	gkFFTsize,ival,1				;TRIGGER GENERATED WHEN COUNTER IS DECREASED
	
	if kup==1 then							; IF STEPPING UP...
	 reinit UPDATE1							; REINITIALISE STARTING FROM THE NEXT LINE
	 UPDATE1:							
	 indx = indx + 1						; INCREMENT INDEX
	 ival	table	indx,ivals					; READ NEW VALUE FROM NON SEQUENTIAL LIST TABLE
	 FLsetVal_i	ival,gihFFTsize					; WRITE VALUE TO COUNTER
	 rireturn							; RETURN FROM REINITIALISATION
	elseif kdn==1 then						; SIMILAR PROCEDURE FOR WHENEVER COUNTER IS STEPPING DOWN
	 reinit UPDATE2
	 UPDATE2:
	 indx = indx - 1
	 ival	table	indx,ivals
	 FLsetVal_i	ival,gihFFTsize	
	 rireturn
	endif
endin

instr	1	;
	if	gkOnOff=0	then				; IF On/Off SWITCH IS SET TO 'Off'
		turnoff						; TURN THIS INSTRUMENT
	endif							; END OF CONDITIONAL BRANCHING
	asig	inch	1					; READ LIVE AUDIO FROM COMPUTER'S 1ST INPUT CHANNEL
	fsig  		pvsanal		asig*gkInGain, i(gkFFTsize), i(gkFFTsize)/4, i(gkFFTsize), 1	;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.      	
	kfr, kamp	pvspitch	fsig, gkthresh		; ANALYSE THE FSIG AND OUTPUT ESTIMATIONS OF FUNDEMENTAL FREQUENCY AND AMPLITUDE 
	kporttime	linseg	0,0.001,0.02

	/* METERS */
	if gkmeters==1 then
	 ktrigger	metro		ksmps			; UPDATE RATE FOR METERS
			FLsetVal	ktrigger, kamp, gihrms	; UPDATE FLTK METERS
			FLsetVal	ktrigger, kfr,  gihcps  ; UPDATE FLTK METERS
	endif

	/* SONIFICATION */
	kamp		portk		kamp,kporttime
	kfr		portk		kfr,kporttime/50
	aout		poscil		kamp,kfr,giWave
			out		aout * gkOutGain	; SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS

endin

</CsInstruments>

<CsScore>
i "FFTsizes" 0 3600	; DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>