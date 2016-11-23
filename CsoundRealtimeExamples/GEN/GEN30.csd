GEN30.csd
Written by Iain McCurdy, 2014

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN30",  500,    200,    0,  0
 
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,    0,     -1
gkinterp,ihinterp	FLbutton	"Interpolate",	1,    0,    22,    120,     25,  250,  5,   -1
gknorm,ihnorm		FLbutton	"Normalise",	1,   -1,    22,    120,     25,  375,  5,   -1
FLsetColor2		255,255,100,ihOnOff
FLsetColor2		255,255,100,ihinterp
FLsetColor2		255,255,100,ihnorm

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X  | Y
idfrq			FLvalue	" ",       50,     18,   130,  75
idminh			FLvalue	" ",       50,     18,     5, 125
idmaxh			FLvalue	" ",       50,     18,     5, 175

;SLIDERS							MIN  |  MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X   | Y
gkfrq,ihfrq		FLslider 	"Frequency",		1,    5000,   -1,    23,   idfrq,     360,     20,  130,   50
gkminh,ihminh		FLslider 	"Lowest Harmonic",	1,      80,    0,    23,   idminh,    490,     25,    5,  100
gkmaxh,ihmaxh		FLslider 	"Highest Harmonic",	1,      80,    0,    23,   idmaxh,    490,     25,    5,  150

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Source", 	1,      1,     14,    120,     12,    10, 36

;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gksrc, gihsrc		FLcount  	"", 		1,      3,    1,      1,     2,     120,     25,    10, 50,   -1 

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	440, 	ihfrq
				FLsetVal_i	1, 	gihsrc
				FLsetVal_i	1, 	ihminh
				FLsetVal_i	10, 	ihmaxh
				FLsetVal_i	-1, 	ihnorm
			                                                           
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 480, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             GEN30                           ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"GEN30 analyses an existing table (ideally harmonic) and      ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"generates a new table based upon this analysis. Critically   ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"GEN30 allows the user to define the minimum and maximum      ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"harmonic partials to include in this new table facilitating  ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"a spectral remodelling of the original waveform. This aspect ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"can be useful in generating an array of function tables with ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"varying degrees of band limiting which can be used in a synth", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"to avoid aliasing. I recommend incestigating the manual      ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"example for GEN30 to see how this can be done.               ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"This example simply allows the user to manually set the      ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"inputs for minumum and maximum harmonic. If the 'Interpolate'", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"option is activated, fractional values will result in        ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"end-most harmonics to be partially included in the resultant ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"waveform.                                                    ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"If 'Lowest Harmonic' is higher than or equal to 'Highest     ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"Harmonic' then the GEN30 table will contain nothing.         ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"'Normalise' activates and deactivates normalisation of the   ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"new waveform (basically by adding a minus sign before the    ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"GEN routine number). The effect of normalisation is most     ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"apparent if the lowest harmonic is raised.                   ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"Three input waveform options are included: sawtooth, square  ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"and triangle.                                                ", 	1,      5,     14,    490,     20,    5, 460
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisaw	ftgen	0,0,4096,7,1,4096,-1
gisq	ftgen	0,0,4096,7,1,2048,1,0,-1,2048,-1
gitri	ftgen	0,0,4096,7,0,1024,1,2048,-1,1024,0
                                                                               
instr	1
 ktrig	changed	gkminh,gkmaxh,gksrc,gkinterp,gknorm	; If any of the input arguments are changed generate a trigger (momentary '1').
 if ktrig==1 then					; If a trigger has been generated...
  reinit	REBUILD_WAVEFORM			; ...reinitialise from label
 endif
 REBUILD_WAVEFORM:
 ifn	ftgen	1000, 0, 4096, 30*i(gknorm), gisaw+i(gksrc)-1, i(gkminh), i(gkmaxh),sr,i(gkinterp)	; generate a waveform based on chosen source waveform with user-set modifications
 rireturn

 if gkOnOff==1 then					; if 'Play Tone' is activated
  asig	oscili	0.1, gkfrq, ifn				; audio oscillator using GEN30 waveform
 	outs	asig,asig
 endif
 
 
 ktrig	changed	gksrc					; If 'Source' waveform counter is changed generate a trigger
 if ktrig==1 then					; If a trigger has been generated...
  reinit UPDATE_LABEL					; Reinitialise from label.
 endif
 UPDATE_LABEL:
 FLsetText	"                 ",gihsrc		; clear label
 if i(gksrc)==1 then					; if 'Source' counter is '1'...
  FLsetText	"Sawtooth",gihsrc			; rewrite counter label
 elseif i(gksrc)==2 then				; and so on...
  FLsetText	"Square",gihsrc
 elseif i(gksrc)==3 then
  FLsetText	"Triangle",gihsrc
 endif
 rireturn
 
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
