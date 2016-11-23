<CsoundSynthesizer>

<CsOptions>
-iadc -odac
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;	LABEL                   | WIDTH | HEIGHT | X | Y
FLpanel	"pvsbuffer pvsbufread",    500,    705,    0,  0
;SWITCHES								ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",		1,    0,    22,    150,     30,    5,  5,    0,      1,      0,      -1
gkWriteEnable,ihWriteEnable	FLbutton	"Write To Buffer",	1,    0,    22,    150,     30,  345,  5,    0,     -1
gkFreeze,ihFreeze		FLbutton	"Freeze",		1,    0,    21,     80,     20,   90,220,    0,      2,      0,      0.001
gkSyncToWrite,ihSyncToWrite	FLbutton	"Sync to Write",	1,    0,    22,    150,     20,  345,220,   -1
gkPhaseOSzero,ihPhaseOSzero	FLbutton	"Set To Zero",		1,    0,    21,    150,     20,  345,270,    0,      3,      0,      0.001
gkZeroPch,ihZeroPch		FLbutton	"Set To Zero",		1,    0,    21,    150,     20,  345,320,    0,      4,      0,      0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihWriteEnable	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihSyncToWrite	;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idInGain	FLvalue	" ",      90,     20,    5,  70
idbuflen	FLvalue	" ",      90,     20,    5, 120
idphrange	FLvalue	" ",      90,     20,    5, 170
idspeed		FLvalue	" ",      90,     20,    5, 220
idPhOffset	FLvalue	" ",      90,     20,    5, 270
idscal		FLvalue	" ",      90,     20,    5, 320
idfbratio	FLvalue	" ",      90,     20,    5, 370
iddirect	FLvalue	" ",      90,     20,    5, 420
idOutGain	FLvalue	" ",      90,     20,    5, 470

;SLIDERS					      			MIN     | MAX | EXP | TYPE |     DISP    | WIDTH | HEIGHT | X   | Y
gkInGain, ihInGain	FLslider	"Input Gain",			0,         1,    0,    23,      idInGain,   490,     20,    5,    50
gkbuflen, ihbuflen	FLslider	"Buffer Length (i-rate)",	0.02,     20,    0,    23,      idbuflen,   490,     20,    5,   100
gkphrange, ihphrange	FLslider	"Read Phasor Range",		0,         1,    0,    23,      idphrange,  490,     20,    5,   150
gkspeed, gihspeed	FLslider	"Read Phasor Speed",  		-5,        5,    0,    23,      idspeed,    490,     20,    5,   200
gkPhOffset, gihPhOffset	FLslider	"Read Phasor Offset",		-1,        1,    0,    23,      idPhOffset, 490,     20,    5,   250
gkscal, gihscal		FLslider	"Pitch Rescale (octaves)", 	-2,        2,    0,    23,      idscal,     490,     20,    5,   300
gkfbratio, ihfbratio	FLslider	"Feedback Ratio",  		0,         1.5,  0,    23,      idfbratio,  490,     20,    5,   350
gkdirect, ihdirect	FLslider	"Direct", 	 		0,         1,    0,    23,      iddirect,   490,     20,    5,   400
gkOutGain, ihOutGain	FLslider	"Output Gain",			0,         1,    0,    23,      idOutGain,  490,     20,    5,   450
gkwrite, gihwrite	FLslider 	"Write Pointer",		0,        20,    0,     1,             -1,  490,     12,    5,   500
gkread, gihread		FLslider 	"Read Pointer",			0,        20,    0,     1,             -1,  490,     12,    5,   530
FLsetColor2	255,0,0,gihwrite	;RED
FLsetColor2	0,255,0,gihread		;GREEN

;INITIALISATION OF SLIDERS
FLsetVal_i   	1,	ihInGain
FLsetVal_i   	1,	ihbuflen
FLsetVal_i   	1,	ihphrange
FLsetVal_i   	1,	gihspeed
FLsetVal_i   	0,	gihPhOffset
FLsetVal_i   	0,	gihscal
FLsetVal_i   	0,	ihfbratio
FLsetVal_i   	1,	ihOutGain
FLsetVal_i   	0,	ihdirect
FLsetVal_i   	1,	ihWriteEnable

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    490,   135,     5, 568	;BORDER AROUND FFT ATTRIBUTES

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   190,   190,   190		;NUMBERS MADE INVISIBLE

;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkFFTattributes, ihFFTattributes	FLbutBank	14,     1,     5,     18,      98,   120,600,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Attributes",       1,       4,    14,   100,      18,   15,  570

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size - Overlap - Window Size - Window Type",	1,       5,    11,    340,      20,  140,  580
ih		 	FLbox  	"  512        256        1024            1     ",	1,       5,    11,    340,      20,  140,  598
ih		 	FLbox  	" 1024        256        1024            1     ",	1,       5,    11,    340,      20,  140,  618
ih		 	FLbox  	" 2048        256        2048            1     ",	1,       5,    11,    340,      20,  140,  638
ih		 	FLbox  	" 2048        128        2048            1     ",	1,       5,    11,    340,      20,  140,  658
ih		 	FLbox  	" 4096        128        4096            1     ",	1,       5,    11,    340,      20,  140,  678

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	1, 	ihFFTattributes

FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 740, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   pvsbuffer / pvsbufread                    ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvsbuffer writes an fsig into a circular buffer (of user     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"definable duration using the 'Buffer Length' slider).        ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Progress of writing into the buffer is displayed by the      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"moving red bar. pvsbufread reads the fsig from this buffer   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"using a k-rate pointer. This pointer can be moved freely so  ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"playback can be slower, faster, frozen or backwards. In this ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"example a moving phase pointer has been created using the    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"oscilktp opcode to read from the buffer. The user can vary   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the range, speed and offset of the pointer. The progress of  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"the read pointer is displayed by the moving green bar.       ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"Clicking the 'Freeze' button is simply an easy way of setting", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'Read Phasor Speed' to zero.                                 ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Selecting 'Sync To Write' will synchronise the read pointer  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"to the write pointer. Adjusting 'Read Phasor Offset' will    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"shift the read pointer's location with respect to the write  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"pointer. 'Read Phasor Speed' and 'Read Phasor Range' will    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"have no effect when this mode is active.                     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"De-selecting the 'Write To Buffer' button will deactivate    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"writing to the buffer. This will therefore prevent           ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"overwriting of the buffer allowing the user to manipulate a  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"fixed chunk of sound. This switch needs to initially be      ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"active in order to first fill the buffer.                    ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"The output fsig from the pvsbufread is passed through a      ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"pvscale opcode which allows the pitch to be rescaled before  ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"being resynthesized and sent to the outputs. Additionally a  ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"feedback loop permits some or all of the output signal to be ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"fed back into the input.                                     ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"The user can select between a variety of combinations of     ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"parameters for the FFT analysis. Larger values for FFT size  ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"will give better harmonic reproduction but greater time      ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"smearing effects and higher computational cost. Lower values ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"will result in less time smearing but greater harmonic       ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"distortion.                                                  ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"This example uses the computer's live input (channel 1/left) ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"as input.                                                    ", 	1,      5,     14,    490,    15,     5, 720

FLpanel_end

FLrun	;RUN THE FLTK WIDGET THREAD

giFFTattributes0	ftgen	1, 0, 4, -2,  512, 256, 1024, 1
giFFTattributes1	ftgen	2, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes2	ftgen	3, 0, 4, -2, 2048, 256, 2048, 1
giFFTattributes3	ftgen	4, 0, 4, -2, 2048, 128, 2048, 1
giFFTattributes4	ftgen	5, 0, 4, -2, 4096, 128, 4096, 1

;	fsig1		pvsanal	ain,     2048,      256,      2048,      1	;CREATE fsig FROM AUDIO INPUT

giphasor		ftgen	0, 0, 65536, 7, 0, 65536, 1	;WAVE SHAPE FOR A MOVING PHASE POINTER

instr	1
	if	gkOnOff=0	then	;IF ON/OFF SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kSwitch		changed		gkFFTattributes, gkbuflen	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then
		reinit	UPDATE
	endif
	UPDATE:
	afeedback	init	0		;INITIALISE FEEDBACK SIGNAL (FOR FIRST PASS)
	;ain		inch	1		;READ AUDIO FROM 1ST INPUT CHANNEL (LEFT)
	ain,aR		diskin	"ClassicalGuitar.wav",1,0,1
	ain		=	ain*gkInGain	;SCALE INPUT WITH 'Input Gain' SLIDER
	ain		=	ain + afeedback	;ADD FEEDBACK SIGNAL TO INPUT SIGNAL
	ibuflen	=	i(gkbuflen)					;CREATE I-RATE VERSION OF BUFFER LENGTH


	iFFTsize	table	0, i(gkFFTattributes)+1
	ioverlap	table	1, i(gkFFTattributes)+1
	iwinsize	table	2, i(gkFFTattributes)+1
	iwintype	table	3, i(gkFFTattributes)+1	
	fsig1  		pvsanal		ain, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.

	if	gkWriteEnable=1	then
		ibuffer,ktime  	pvsbuffer   fsig1, ibuflen		;BUFFER FSIG
	endif
	khandle		init 	ibuffer		;INITIALISE HANDLE TO BUFFER
	if	gkSyncToWrite=0	then
		aread 		osciliktp gkspeed/ibuflen, giphasor, gkPhOffset	;CREATE MOVING POINTER TO READ FROM BUFFER
		kread		downsamp	aread				;DOWNSAMPLE BUFFER TO K-RATE, pvsbufread ONLY ACCEPTS A K-RATE POINTER
		kread		=		kread * gkphrange * ibuflen	;RESCALE READ POINTER WITH PHASOR RANGE SLIDER
	elseif	gkSyncToWrite=1	then
		kread	=	ktime	;SYNC TO WRITE POINTER
		kread	=	kread + (gkPhOffset * ibuflen)	;ADD PHASE OFFSET AND SCALE ACCORDING TO BUFFER LENGTH
		kread	wrap	kread, 0, ibuflen		;WRAP-AROUND READ POINTER VALUE TO PREVENT OUT OF RANGE VALUES 
	endif
	fsig2  		pvsbufread  	kread , khandle			;READ BUFFER
	kscal		=		cpsoct(gkscal+8)/cpsoct(8)		;CREATE PITCH RESCALING VARIABLE
	;OUTPUT		OPCODE		INPUT | RESCALE_VALUE | FORMANT_MODE |   GAIN
	fsig3 		pvscale 	fsig2,      kscal				;RESCALE THE FREQUENCY VALUES ACCORDING TO THE INPUT ARGUMENT gkscal.	
	aresyn 		pvsynth  	fsig3                   	;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL	
	afeedback	dcblock2	aresyn * gkfbratio		;CREATE FEEDBACK SIGNAL FOR NEXT PASS THROUGH THE CODE (AND BLOCK DC OFFSET)
	aout		=		(aresyn*gkOutGain*2)+(ain*gkdirect)		;CREATE OUTPUT SIGNAL
			outs	aout, aout
	ktrigger	metro	20
	FLsetVal	ktrigger, ktime, gihwrite
	FLsetVal	ktrigger, kread, gihread
	rireturn
endin

instr	2	;FREEZE POINTER
	;THIS INSTRUMENT FREEZES POINTER MOVEMENT BY SIMPLY SETTING READ POINTER FREQUENCY TO ZERO 
	FLsetVal_i	0, gihspeed
endin

instr	3	;SET READ POINTER PHASE OFFSET TO ZERO
	FLsetVal_i	0, gihPhOffset
endin

instr	4	;SET PITCH RESCALE TO ZERO
	FLsetVal_i	0, gihscal
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>