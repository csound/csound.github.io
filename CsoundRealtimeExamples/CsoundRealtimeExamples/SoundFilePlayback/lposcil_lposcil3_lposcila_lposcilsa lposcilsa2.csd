lposcil_lposcil3_lposcila_lposcilsa_lposcilsa2.csd
Written by Iain McCurdy, 2009. Updated 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	256	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					 LABEL                                           | WIDTH | HEIGHT | X | Y
				FLpanel	"lposcil lposcil3 lposcila lposcilsa lposcilsa2",   500,    420,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    150,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idamp				FLvalue	" ",       70,    20,     5,  75
idfreqratio			FLvalue	" ",       70,    20,     5, 125
idloop				FLvalue	" ",       70,    20,     5, 175
idend				FLvalue	" ",       70,    20,     5, 225
idphs				FLvalue	" ",       70,    20,     5, 275

;SLIDERS					            				MIN | MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider 	"Amplitude",				0,      1,   0,    23,        idamp,   490,     25,    5,  50
gkfreqratio, ihfreqratio	FLslider 	"Frequency Ratio",			-2,     2,   0,    23,  idfreqratio,   490,     25,    5, 100
gkloop, ihloop			FLslider 	"Loop Begin Point",			0,      1,   0,    23,       idloop,   490,     25,    5, 150
gkend, ihend			FLslider 	"Loop End Point",			0,      1,   0,    23,        idend,   490,     25,    5, 200
gkphs, ihphs			FLslider 	"Initial Phase (i-rate)",		0,      1,   0,    23,        idphs,   490,     25,    5, 250

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  |  Y | OPCODE | INS | STARTTIM | DUR
gkfn, ihfn			FLbutBank	14,     1,     2,     18,      40,    65, 310,   -1
gkopcode, ihopcode		FLbutBank	14,     1,     5,     18,     100,   300, 310,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input:", 		1,       5,    14,     50,      16,  15, 310
ih		 	FLbox  	"Songpan (stereo)",	1,       5,    14,    130,      16,  85, 310
ih		 	FLbox  	"AndItsAll (mono)", 	1,       5,    14,    130,      16,  85, 330
ih		 	FLbox  	"Opcode:", 		1,       5,    14,     40,      16, 250, 310
ih		 	FLbox  	"lposcil   ", 		1,       5,    14,     75,      16, 320, 310
ih		 	FLbox  	"lposcil3  ", 		1,       5,    14,     75,      16, 320, 330
ih		 	FLbox  	"lposcila  ", 		1,       5,    14,     75,      16, 320, 350
ih		 	FLbox  	"lposcilsa ", 		1,       5,    14,     75,      16, 320, 370
ih		 	FLbox  	"lposcilsa2", 		1,       5,    14,     75,      16, 320, 390

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.3, 	ihamp
				FLsetVal_i	1, 	ihfreqratio
				FLsetVal_i	0, 	ihloop
				FLsetVal_i	1, 	ihend
				FLsetVal_i	0, 	ihphs
				FLsetVal_i	3, 	ihopcode
   
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 500, 512, 0
				FLscroll     515, 500,   0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"        lposcil lposcil3 lposcila lposcilsa lposcilsa2       ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"This example demonstrates a group of opcodes intended for    ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"looped playback of sound files stored in GEN01 function      ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"tables.                                                      ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"'lposcil' is for reading mono function tables with linear    ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"interpolation when playback is modulated.                    ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"'lposcil3' reads mono files with cubic interpolation. This   ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"will produces superior results to 'lposcil' when the sound   ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"file is transposed significantly as a small cost in CPU      ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"cycles.                                                      ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"'lposcila' allows the amplitude parameter to be modulated at ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"a-rate, this can prove beneficial with fast moving amplitude ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"envelopes which, at k-rate, can produce quantisation noise.  ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"In this example moving the amplitude slider when using       ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"'lposcil' or 'lposcil3' can produces artefacts that are not  ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"present when doing the same with 'lposcila'.                 ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"'lposcilsa' reads from stereo function tables.               ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"'lposcilsa2' also reads from stereo function tables but does ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"not employ any interpolation so it suitable only when no     ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"transposition is required. In fact the opcode will only allow", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"transposition in integer values when interpolation is not    ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"required. 'lposcilsa2' is much faster than the other opcodes ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"which employ interpolation.                                  ", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"All of these opcodes are capable of reading from function    ", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"tables with deferred table sizes (sizes given as zero).      ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"It will be important to choose the correct opcode according  ", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"to whether the sound file used is mono or stereo. It is      ", 	1,      5,     14,    490,     20,    5, 540
ih		 	FLbox  	"possible to design an instrument that interrogates the       ", 	1,      5,     14,    490,     20,    5, 560
ih		 	FLbox  	"function table regarding how many channels it contains using ", 	1,      5,     14,    490,     20,    5, 580
ih		 	FLbox  	"the 'ftchnls()' opcode and to then employ the correct opcode ", 	1,      5,     14,    490,     20,    5, 600
ih		 	FLbox  	"using conditionals. In this example no such mechanism is     ", 	1,      5,     14,    490,     20,    5, 620
ih		 	FLbox  	"employed so that the user can hear the implications of using ", 	1,      5,     14,    490,     20,    5, 640
ih		 	FLbox  	"the wrong opcode. Two sound files are used: one stereo, one  ", 	1,      5,     14,    490,     20,    5, 660
ih		 	FLbox  	"mono.                                                        ", 	1,      5,     14,    490,     20,    5, 680
ih		 	FLbox  	"Normally loop points are defined in samples - in this example", 	1,      5,     14,    490,     20,    5, 700
ih		 	FLbox  	"the sliders define loop points as a fraction of the entire   ", 	1,      5,     14,    490,     20,    5, 720
ih		 	FLbox  	"sound file. This is to enable switching to use different     ", 	1,      5,     14,    490,     20,    5, 740
ih		 	FLbox  	"files. If the loop end points is before the begin point no   ", 	1,      5,     14,    490,     20,    5, 760
ih		 	FLbox  	"sound will be produced.                                      ", 	1,      5,     14,    490,     20,    5, 780
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

0dbfs	=	1	;SET MAXIMUM AMPLITUDE VALUE AND INDEPENDENCE FROM BIT-DEPTH

gift1	ftgen	0, 0, 0, 1, "Songpan.wav",   0, 0, 0	;STORED STEREO SOUND FILE. TABLE SIZE IS DEFERRED - CSOUND CALCULATES THE SIZE OF TABLE NEEDED.
gift2	ftgen	0, 0, 0, 1, "AndItsAll.wav", 0, 0, 0	;STORED MONO SOUND FILE. TABLE SIZE IS DEFERRED - CSOUND CALCULATES THE SIZE OF TABLE NEEDED.

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
	turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING

	kSwitch		changed	gkphs,gkfn	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:

	ift	=	gift1+i(gkfn)
	aamp	interp	gkamp			;CREATE A-RATE VERSION OF AMPLITUDE SLIDER VALUE (THIS IS DEMANDED BY lposcilsa)
	ifilelen	=	nsamp(ift)	;DERIVE SOUNDFILE LENGTH (IN SAMPLES)
	
	;CREATE AUDIO SIGNALS FOR ALL 5 OPCODES
	aM1		lposcil		gkamp, gkfreqratio, gkloop*ifilelen, gkend*ifilelen, ift , i(gkphs)*ifilelen 
	aM2		lposcil3	gkamp, gkfreqratio, gkloop*ifilelen, gkend*ifilelen, ift , i(gkphs)*ifilelen 
	aM3		lposcila	aamp, gkfreqratio, gkloop*ifilelen, gkend*ifilelen, ift , i(gkphs)*ifilelen 
	aL4,aR4		lposcilsa	aamp, gkfreqratio, gkloop*ifilelen, gkend*ifilelen, ift , i(gkphs)*ifilelen 
	aL5,aR5		lposcilsa2	aamp, gkfreqratio, gkloop*ifilelen, gkend*ifilelen, ift , i(gkphs)*ifilelen 
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	;SEND THE APPROPRIATE AUDIO TO THE OUTPUTS ACCORDING TO THE 'Opcode' CHOICE MADE 
	if gkopcode==0 then
		outs	aM1,aM1
	elseif gkopcode==1 then
		outs	aM2,aM2
	elseif gkopcode==2 then
		outs	aM3,aM3
	elseif gkopcode==3 then
		outs	aL4,aR4	
	else
		outs	aL5,aR5	
	endif
endin

</CsInstruments>                         
                                         
<CsScore>
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>                               
                                         
</CsoundSynthesizer>