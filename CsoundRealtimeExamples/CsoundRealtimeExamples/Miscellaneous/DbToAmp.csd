DbToAmp.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	8                                                                                                       
nchnls 		= 	2
0dbfs		=	1        ;MAXIMUM AMPLITUDE VALUE USED BY CSOUND WILL BE '1' 

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		FLcolor		255, 255, 255, 0, 0, 0
	FLpanel	"Convert decibels to amplitude", 500, 120, 0, 0

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X | Y
iddb		FLvalue	" ",	100,      18,    5,  45
idamp		FLvalue	" ",	100,      18,    5,  95

;SLIDERS				     		MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkdb, gihdb		FLslider	"Decibels",	-90,   0,    0,    23,   iddb,   490,     25,    5,  20
gkamp, gihamp		FLslider	"Amplitude",	0,     1,    0,    23,   idamp,  490,     25,    5,  70

;SET INITIAL VALUES FOR SLIDERS
		FLsetVal_i	-90, 	gihdb
		FLsetVal_i	0, 	gihamp
                                                                                                              
		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 600, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          convert decibels to amplitude values               ", 	1,       5,    14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    15,     5,  20
ih		 	FLbox  	"This example converts between amplitude and decibel (db)     ", 	1,       5,    14,    490,    15,     5,  40
ih		 	FLbox  	"and allows the user to observe the relationship by           ", 	1,       5,    14,    490,    15,     5,  60
ih		 	FLbox  	"synchronising the two sliders. Either slider can be moved and", 	1,       5,    14,    490,    15,     5,  80
ih		 	FLbox  	"the other will move in sympathy.                             ", 	1,       5,    14,    490,    15,     5, 100
ih		 	FLbox  	"A positive value measurement of decibels is really only      ", 	1,       5,    14,    490,    15,     5, 120
ih	  	 	FLbox  	"relevant if we are measuring the level of the sound emanating", 	1,       5,    14,    490,    15,     5, 140
ih		 	FLbox  	"from the loudspeakers and this is dependent upon the setting ", 	1,       5,    14,    490,    15,     5, 160
ih		 	FLbox  	"made on the amplifier - a value Csound is unaware of. For    ", 	1,       5,    14,    490,    15,     5, 180
ih		 	FLbox  	"this reason it is common to adopt the convention of defining ", 	1,       5,    14,    490,    15,     5, 200
ih		 	FLbox  	"decibels within Csound as negative value below 0db, 0db      ", 	1,       5,    14,    490,    15,     5, 220
ih		 	FLbox  	"representing maximum amplitude (or unaltered amplitude in the", 	1,       5,    14,    490,    15,     5, 240
ih		 	FLbox  	"case of the playback of sound files). We cannot really       ", 	1,       5,    14,    490,    15,     5, 260
ih		 	FLbox  	"achieve zero amplitude by reducing the decibels value as all ", 	1,       5,    14,    490,    15,     5, 280
ih		 	FLbox  	"we are dioing is reducing amplitude exponentially smaller and", 	1,       5,    14,    490,    15,     5, 300
ih		 	FLbox  	"smaller. In practice, perceived silence is achieved somewhere", 	1,       5,    14,    490,    15,     5, 320
ih		 	FLbox  	"between -70 and -100 db depending on how loud the speakers   ", 	1,       5,    14,    490,    15,     5, 340
ih		 	FLbox  	"are.                                                         ", 	1,       5,    14,    490,    15,     5, 360
ih		 	FLbox  	"To convert decibels to amplitude we are using the 'ampdbfs'  ", 	1,       5,    14,    490,    15,     5, 380
ih		 	FLbox  	"opcode ('fs' stands for full scale) and to convert from      ", 	1,       5,    14,    490,    15,     5, 400
ih		 	FLbox  	"amplitude to decibels we are using 'dbfsamp'.                ", 	1,       5,    14,    490,    15,     5, 420
ih		 	FLbox  	"By using the 'full scale' reference we can alter the value   ", 	1,       5,    14,    490,    15,     5, 440
ih		 	FLbox  	"Csound uses for its full scale amplitude using the '0dbfs'   ", 	1,       5,    14,    490,    15,     5, 460
ih		 	FLbox  	"opcode from the default 32768 to anything else (probably '1')", 	1,       5,    14,    490,    15,     5, 480
ih		 	FLbox  	"and Csound will still convert between amplitude and decibels ", 	1,       5,    14,    490,    15,     5, 500
ih		 	FLbox  	"appropriately. It is becoming the convention to set 0db to   ", 	1,       5,    14,    490,    15,     5, 520
ih		 	FLbox  	"'1' when using Csound so it is advisable to use this method. ", 	1,       5,    14,    490,    15,     5, 540
ih		 	FLbox  	"This example uses this amplitude/decibel setting to scale the", 	1,       5,    14,    490,    15,     5, 560
ih		 	FLbox  	"playback amplitude of a sound file.                          ", 	1,       5,    14,    490,    15,     5, 580

				FLpanel_end                                                            
		FLrun
                 
instr	1                                                    	
	kdbold	init	-90					;INITIALISE OLD VALUE FOR DECIBELS FOR FIRST PASS
	kampold	init	i(gkamp)				;INITIALISE OLD VALUE OF AMPLITUDE FOR FIRST PASS
	if kdbold!=gkdb then					;IF OLD VALUE FOR DECIBELS IS NOT THE SAME AS THE NEW VALUE...
	  gkamp	=	ampdbfs(gkdb)				;...DERIVE A NEW VALUE FOR AMPLITUDE AS FROM NEW VALUE FOR DECIBELS 
		FLsetVal	1,gkamp,gihamp			;SET AMPLITUDE SLIDER BASED ON DECIBELS NEW VALUE
	elseif kampold!=gkamp then				;IF OLD VALUE FOR AMPLITUDE IS NOT THE SAME AS THE NEW VALUE...
	  gkdb	=	dbfsamp(gkamp)				;...DERIVE A NEW VALUE FOR DECIBELS FROM NEW VALUE FOR AMPLITUDE
		FLsetVal	1,gkdb,gihdb			;SET DECIBELS SLIDER BASED ON THE NEW VALUE FOR AMPLITUDE
	endif
	kdbold	=	gkdb					;SET DECIBELS 'OLD VALUE' FOR NEXT PASS
	kampold	=	gkamp					;SET AMPLITUDE 'OLD VALUE' FOR NEXT PASS
	
	aL,aR		diskin2	"Songpan.wav",1,0,1          	;READ A SOUND FILE FROM DISK        
	outs		aL*gkamp, aR*gkamp			;SEND READ AUDIO TO OUTPUTS AND SCALE USING AMPLITUDE (OR DECIBELS VIA CONVERSION) VALUE
endin                                                                                                                  

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
