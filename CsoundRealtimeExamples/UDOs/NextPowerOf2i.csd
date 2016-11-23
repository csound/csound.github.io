; NextPowerOf2i.csd
; Written by Iain McCurdy, 2014

<CsoundSynthesizer>

<CsOptions>
-n -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL              | WIDTH | HEIGHT | X | Y
				FLpanel	"Next Power of 2",    255,    190,    0,  0
 
;VALUE INPUT BOXES						MIN |     MAX     | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkinput, gihinput	FLtext		"Raw Value", 		0,   2000000000000,   1,     1,     120,     25,     5,   5
gkdur, gihdur		FLtext		"Duration", 		0,   2000000000000,0.001,    1,     120,     25,     5,  55
gkPO2, gihPO2		FLtext		"Next Power of two", 	0,   2000000000000,   1,     1,     120,     25,   130,   5
 
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkchannels, ihchannels		FLbutBank	14,     1,     2,     18,      40,    5, 105,   -1
gksr, ihsr			FLbutBank	14,     1,     4,     18,      80,  135, 105,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"mono  ", 		1,       5,    14,     45,     20,  27,   103
ih		 	FLbox  	"stereo", 		1,       5,    14,     45,     20,  27,   123
ih		 	FLbox  	"22050", 		1,       5,    14,     45,     20, 157,   103
ih		 	FLbox  	"44100", 		1,       5,    14,     45,     20, 157,   123
ih		 	FLbox  	"48000", 		1,       5,    14,     45,     20, 157,   143
ih		 	FLbox  	"96000", 		1,       5,    14,     45,     20, 157,   163


;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	0, 	gihinput
				FLsetVal_i	0, 	gihdur
				FLsetVal_i	0, 	gihPO2
				FLsetVal_i	0, 	ihchannels
				FLsetVal_i	1, 	ihsr
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 180, 265, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        Next power of 2                      ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Demonstration of the UDO NextPowerOf2.udo which calculates   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"the next power of two higher than an raw input value.        ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"In addition an input for duration can be used which will     ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"prompt the minimum power of 2 sized function table that will ", 	1,      5,     14,    490,    20,     5, 100
ih		  	FLbox  	"store a sample of the given duration. The user can also      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"select whether the sound to be stored is mono or stereo and  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"from a selection of sample rates.                            ", 	1,      5,     14,    490,    20,     5, 160

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


opcode	NextPowerOf2i,i,i
 iInVal	xin
 icount	=	1
 LOOP:
 if 2^icount>iInVal then
  goto DONE
 else
  icount	=	icount + 1
  goto LOOP
 endif
 DONE:
 	xout	2^icount
endop

alwayson 	1

gisrs	ftgen	0,0,4,-2,22050,44100,48000,96000

instr	1
 kinput	=	int(gkinput)
 ktrig	changed	kinput
 if ktrig==1 then
  reinit UPDATE
 endif
 UPDATE:
 iPO2	NextPowerOf2i	i(kinput)
 	FLsetVal_i	iPO2,gihPO2
 rireturn
 ktrig	changed	gkdur,gkchannels,gksr
 ksr	table	gksr,gisrs
 FLsetVal	ktrig,gkdur*ksr*(gkchannels+1),gihinput
endin

  	
</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>