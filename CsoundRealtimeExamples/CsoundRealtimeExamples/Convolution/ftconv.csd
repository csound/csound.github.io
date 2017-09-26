ftconv.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	32
nchnls	=	2
0dbfs	=	1	;MAXIMUM AMPLITUDE

; IMPULSE RESPONSES STORED AS STEREO GEN01 FUNCTION TABLES
giStairwell     ftgen   1, 0, 131072, 1, "Stairwell.wav", 0, 0, 0
giDish          ftgen   2, 0, 131072, 1, "dish.wav", 0, 0, 0
giWood          ftgen   3, 0, 131072, 1, "Wood.wav", 0, 0, 0

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor		255,255,255
FLcolor2	  0,  0,  0

;		LABEL    | WIDTH | HEIGHT | X | Y
	FLpanel	"ftconv",   500,    550,    0,  0

;                                            	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    -1;0,      1,      0,      -1	;WINDOWS BUG WORKAROUND
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
gkDelay2Zero,ih	FLbutton	"To Zero",	1,    0,    21,     70,     18,  425,425,    0,     99,      0,       0

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idGain			FLvalue	" ",    60,       20,    5,    75
idMix			FLvalue	" ",    60,       20,    5,   125
idirlen			FLvalue	" ",    60,       20,    5,   325
idskipsamples		FLvalue	" ",    60,       20,    5,   375
idDelayOS		FLvalue	" ",    60,       20,    5,   425
idCompRat		FLvalue	" ",    60,       20,    5,   475
idCurve			FLvalue	" ",    60,       20,    5,   525

;					            				MIN  | MAX | EXP | TYPE |      DISP     | WIDTH | HEIGHT | X | Y
gkGain,ihGain			FLslider 	"Gain",				0.01,  50,    0,    23,         idGain,     490,    25,     5,  50
gkMix,ihMix			FLslider 	"Dry/Wet Mix",			0,      1,    0,    23,          idMix,     490,    25,     5, 100
gkirlen,ihirlen			FLslider 	"Impulse Response Length",	0.001,  1,    0,    23,        idirlen,     490,    25,     5, 300
gkskipsamples,ihskipsamples	FLslider 	"Skip Samples",			0,      1,    0,    23,  idskipsamples,     490,    25,     5, 350
gkDelayOS,gihDelayOS		FLslider 	"Dry Signal Delay Offset",	-0.5, 0.5,    0,    23,  idDelayOS,         490,    25,     5, 400
gkCompRat,ihCompRat		FLslider 	"Table Compression Ratio",	0.1,    1,    0,    23,  idCompRat,         490,    25,     5, 450
gkCurve,ihCurve			FLslider 	"Amp. Env. Curve",		-8,     8,    0,    23,  idCurve,           490,    25,     5, 500

;COUNTERS					     				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkiplenpwr, ihiplenpwr	FLcount  	"Partition Length (Power of 2)",	1,     15,    1,     10,     2,     120,     22,    5, 240,   -1 

;VALUE BOXES					 				MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkiplen, gihiplen	FLtext		"Partition Length (display only)", 	0, 1048576,  0,     1,    110,     22,    130, 240

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    160,     60,    5, 170	;BORDER AROUND INPUT SELECTOR
ih		 	FLbox  	" ", 	6,      9,     15,    300,     60,  170, 170	;BORDER AROUND CONVOLUTION FILE SELECTOR

;LABELS MADE INVISIBLE
FLlabel    13, 1, 1, 255,255,255
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	12,      1,     2,     25,     50,   55,175,   -1
gkfile,   ihfile			FLbutBank	12,      1,     3,     25,     50,  320,175,   -1
gkFwdBwd,   ihFwdBwd			FLbutBank	12,      1,     4,     25,   13*4,  250,240,   -1

;LABELS MADE VISIBLE AGAIN
FLlabel    13, 5, 4, 0, 0, 0

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih     		FLbox  	"Sound File", 		1,      5,     12,    74,      25,    80, 175
ih     		FLbox  	"Live Input", 		1,      5,     12,    74,      25,    80, 200
ih     		FLbox  	"Stairwell", 		1,      5,     12,    70,      50/3, 350, 175
ih     		FLbox  	"Dish     ", 		1,      5,     12,    70,      50/3, 350, 175+50/3
ih     		FLbox  	"Wood     ", 		1,      5,     12,    70,      50/3, 350, 175+100/3
ih		FLbox	"Input",       		1,      4,     14,    30,      20,    15, 175
ih		FLbox	"Convolution File",	1,      4,     14,   130,      20,   180, 175
ih     		FLbox  	"Forwards            ", 1,      5,     12,   140,      12,   277, 240
FLsetTextSize	11,ih
ih     		FLbox  	"Backwards           ", 1,      5,     12,   140,      12,   277, 253
FLsetTextSize	11,ih
ih     		FLbox  	"Forwards Compressed ", 1,      5,     12,   140,      12,   277, 266
FLsetTextSize	11,ih
ih     		FLbox  	"Backwards Compressed", 1,      5,     12,   140,      12,   277, 279
FLsetTextSize	11,ih

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0.7, 	ihGain
			FLsetVal_i	0.17, 	ihMix
			FLsetVal_i	0, 	ihinput
			FLsetVal_i	1, 	ihirlen
			FLsetVal_i	10, 	ihiplenpwr
			FLsetVal_i	0, 	ihskipsamples
			FLsetVal_i	0, 	gihDelayOS
			FLsetVal_i	1, 	ihCompRat
			FLsetVal_i	0, 	ihCurve

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,     500,   512, 0
				FLscroll     515,     500,0,0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           ftconv                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"ftconv implements efficient low latency multichannel         ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"convolution using GEN01 function tables as input (deferred   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"table size not permitted). This example uses stereo impulse  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"files but files of up to 8 channels can be used.             ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Convolution is calculated in chunks called 'partitions'. The ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"latency induced by the opcode is related to the partition    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"size (but not ksmps as with some other convolution opcodes). ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"Latency in seconds will be partition size (in sample frames) ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"divided by the sample rate. If the dry signal is to be mixed ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"with the convoluted signal, the dry signal shoulod be delayed", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"according to this latency value. As partition size must      ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"always be a power of two, in this GUI the user specifies the ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"index. The resulting partition size is displayed for the     ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"user. Smaller partition sizes (and therefore lower latencies)", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"demand more from the CPU and can result in buffer underruns. ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"By default ftconv uses the entire function table for the     ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"impulse file but the user can specify a value shorter value, ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"in which case the reverb effect will be abbreviated. In this ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"example Impulse Response Length is specified as a fraction of", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"the entire file. This feature can be used to remove silence  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"from the end of the impulse file (and therefore improve      ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"efficiency) or to produce special effects like gated         ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"reverbs.                                                     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"Reversed versions of all the function tables are also created", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"which can be accessed by choosing 'Backwards Reverb' from the", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"button bank. When this mode is chosen the dry signal is      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"delayed to coincide with the end od the impulse file thereby ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"creating a classic backwards reverb sound.                   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"Compressed versions of the forwards and backwards versions of", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"the impulse files are also created. The effect produced is   ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"similar to reducing the 'Impulse Response Length' except that", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"the Impulse file is enveloped, the curve of which can be     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"adjusted. Envelope curves are created using GEN16.           ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"'Delay Offset' allows the user to fine tune the delay that is", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"used to synchronise ther dry signal with the convoluted      ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"signal. Normally this should be zero.                        ", 	1,      5,     14,    490,    20,     5, 740
                                FLscroll_end                                                                                                  
				FLpanel_end                                                                                                       

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; reverse function table UDO
opcode	tab_reverse,i,i
ifn             xin
iTabLen         =               nsamp(ifn)
iTableRev       ftgen           ifn+100,0,-iTabLen,-2, 0
icount          =               0
loop:
ival            table           iTabLen-icount-1, ifn
                tableiw         ival,icount,iTableRev
                loop_lt         icount,1,iTabLen,loop
                xout   	        iTableRev
endop

; compress function table UDO
opcode	tab_compress,i,iii
ifn,iCompRat,iCurve    xin
iTabLen         =               nsamp(ifn)
iTabLenComp     =               int(nsamp(ifn)*iCompRat)
iTableComp      ftgen           ifn+200,0,-iTabLenComp,-2, 0
iAmpScaleTab	ftgen		ifn+300,0,-iTabLenComp,-16, 1,iTabLenComp,iCurve,0
icount          =               0
loop:
ival            table           icount, ifn
iAmpScale	table		icount, iAmpScaleTab
                tableiw         ival*iAmpScale,icount,iTableComp
                loop_lt         icount,1,iTabLenComp,loop
                xout   	        iTableComp
endop

; compress reverse function table UDO
opcode	tab_compress_rev,i,iii
ifn,iCompRat,iCurve    xin
iTabLen         =               nsamp(ifn)
iTabLenComp     =               int(nsamp(ifn)*iCompRat)
iTableComp      ftgen           ifn+400,0,-iTabLenComp,-2, 0
iAmpScaleTab	ftgen		ifn+500,0,-iTabLenComp,-16, 1,iTabLenComp,iCurve,0
icount          =               0
loop:
ival            table           icount, ifn
iAmpScale	table		icount, iAmpScaleTab
                tableiw         ival*iAmpScale, iTabLenComp-icount-1,iTableComp
                loop_lt         icount,1,iTabLenComp,loop
                xout   	        iTableComp
endop


instr	OnOff
	ktrigOn		trigger	gkOnOff,0.5,0
	ktrigOff	trigger	gkOnOff,0.5,1
	if ktrigOn==1 then
	 event	"i",1,0,-1
	elseif ktrigOff==1 then
	 turnoff2	1,0,0
	endif
endin

instr 1	;GENERATE INPUT AUDIO INDEPENDENTLY OF REVERBERATING INSTRUMENT
	;if	gkOnOff==0	then	;IF ON/OFF SWITCH IS OFF...		;WINDOWS BUG WORKAROUND
	;	turnoff			;TURN THIS INSTRUMENT OFF		;WINDOWS BUG WORKAROUND
	;endif				;END OF CONDITIONAL BRANCHING		;WINDOWS BUG WORKAROUND
	if	gkinput=0	then			;IF 'Sound File' IS SELECTED...
		gasig	diskin2	"808LoopMono.wav", 1, 0, 1	;READ AUDIO FROM SOUND FILE ON HARD DISC
	elseif	gkinput=1	then			;IF 'Live Input' IS SELECTED
		gasig	inch	1	;READ AUDIO FROM SOUND CARD'S FIRST (LEFT) INPUT
	endif
	gasig	=	gasig*gkGain	;SCALE AUDIO SIGNAL WITH GAIN CONTROL
endin

instr	2	;CONVOLUTION REVERB INSTRUMENT
	;CREATE REVERSED TABLES
	irev1	tab_reverse	giStairwell
	irev2	tab_reverse	giStairwell+1
	irev3	tab_reverse	giStairwell+2	
	
	kSwitch	changed		gkfile,gkirlen,gkskipsamples,gkiplenpwr,gkFwdBwd,gkDelayOS,gkCompRat,gkCurve	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then			;IF I-RATE VARIABLE IS CHANGED...
		reinit	UPDATE				;BEGIN A REINITIALISATION PASS IN ORDER TO EFFECT THIS CHANGE. BEGIN THIS PASS AT LABEL ENTITLED 'UPDATE' AND CONTINUE UNTIL rireturn OPCODE 
	endif						;END OF CONDITIONAL BRANCHING
	UPDATE:						;LABEL
	;CREATE COMPRESSED TABLES
	icomp1	tab_compress	giStairwell,i(gkCompRat),i(gkCurve)
	icomp2	tab_compress	giStairwell+1,i(gkCompRat),i(gkCurve)
	icomp3	tab_compress	giStairwell+2,i(gkCompRat),i(gkCurve)

	;CREATE COMPRESSED REVERSED TABLES
	icomprev1	tab_compress_rev	giStairwell,i(gkCompRat),i(gkCurve)
	icomprev2	tab_compress_rev	giStairwell+1,i(gkCompRat),i(gkCurve)
	icomprev3	tab_compress_rev	giStairwell+2,i(gkCompRat),i(gkCurve)

	iplen   =       2^i(gkiplenpwr)			;BUFFER LENGTH
	FLsetVal_i	iplen,gihiplen			;WRITE ACTUAL BUFFER SIZE TO THE TEXT BOX
	itab	=	giStairwell+i(gkfile)		;DERIVE FUNCTION TABLE NUMBER OF CHOSEN TABLE FOR IMPULSE FILE
	iirlen  =       nsamp(itab)*0.5*i(gkirlen)	;DERIVE THE LENGTH OF THE IMPULSE RESPONSE IN SAMPLES. DIVIDE BY 2 AS TABLE IS STEREO.
	iskipsamples	=	nsamp(itab)*0.5*i(gkskipsamples)	;DERIVE INSKIP INTO IMPULSE FILE. DIVIDE BY 2 (MULTIPLY BY 0.5) AS ALL IMPULSE FILES ARE STEREO
	
	;FORWARDS REVERB
	if gkFwdBwd==0 then
	 aL,aR ftconv  gasig, itab, iplen,iskipsamples, iirlen		;CONVOLUTE INPUT SOUND
	 adel            delay     gasig, abs((iplen/sr)+i(gkDelayOS)) 	;DELAY THE INPUT SOUND ACCORDING TO THE BUFFER SIZE
        
        ;BACKWARDS REVERB
        elseif gkFwdBwd==1 then
	 aL,aR ftconv  gasig, irev1+i(gkfile), iplen, iskipsamples, iirlen				;CONVOLUTE INPUT SOUND
	 adel            delay     gasig,abs((iplen/sr)+(iirlen/sr)-(iskipsamples/sr)+i(gkDelayOS))	;DELAY THE INPUT SOUND ACCORDING TO THE BUFFER SIZE AND THE DURATION OF THE IMPULSE FILE

	elseif gkFwdBwd==2 then
	 aL,aR ftconv  gasig, icomp1+i(gkfile), iplen,iskipsamples, iirlen*i(gkCompRat)		;CONVOLUTE INPUT SOUND
	 adel            delay     gasig, abs((iplen/sr)+i(gkDelayOS)) 				;DELAY THE INPUT SOUND ACCORDING TO THE BUFFER SIZE

	else
	 aL,aR ftconv  gasig, icomprev1+i(gkfile), iplen, iskipsamples, iirlen*i(gkCompRat)		;CONVOLUTE INPUT SOUND
	 adel            delay     gasig,abs((iplen/sr)+((iirlen*i(gkCompRat))/sr)-(iskipsamples/sr)+i(gkDelayOS))	;DELAY THE INPUT SOUND ACCORDING TO THE BUFFER SIZE AND THE DURATION OF THE IMPULSE FILE
	endif

	; CREATE A DRY/WET MIX
	aMixL   ntrpol    adel,aL*0.1,gkMix
	aMixR   ntrpol    adel,aR*0.1,gkMix
        outs      aMixL,aMixR
	gasig	=	0				;CLEAR GLOBAL AUDIO SIGNAL FROM INSTR 1 (LEFT CHANNEL) 
endin

instr	99
	FLsetVal_i	0,gihDelayOS
endin

</CsInstruments>

<CsScore>
i "OnOff" 0 3600	;SENSE ON/OFF SWITCH (WORKAROUND FOR WINDOWS BUG
i 2 0 3600		;INSTRUMENT 2 (CONVOLUTION INSTRUMENT) RUNS FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING) 
e
</CsScore>

</CsoundSynthesizer>