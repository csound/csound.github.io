; peak.csd
; Written by Iain McCurdy, 2014.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"peak",    500,    185,    0,  0
 
;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idinput			FLvalue	"",       60,     17,     5,  35
idpeak			FLvalue	"",       60,     17,     5,  85
idrms_peak		FLvalue	"",       60,     17,     5, 150

;SLIDERS					            	MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkinput,ihinput			FLslider 	"Input",	-5,    5,    0,    23,  idinput,    490,     25,    5,    10
gkpeak,gihpeak			FLslider 	"peak",	        -5,    5,    0,    23,  idpeak,     490,     25,    5,    60
gkrms,gihrms			FLslider 	"",		0,     1,    0,     1,  -1,         490,     10,    5,   125
gkrms_peak,gihrms_peak		FLslider 	"RMS Peak",	0,     1,    0,     1,  idrms_peak, 490,     15,    5,   135

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkreset,ihreset		FLbutton	"RESET",	1,    1,     1,     55,     17,   440, 85,   -1
gkreset2,ihreset2	FLbutton	"RESET",	1,    1,     1,     55,     17,   440,150,   -1

FLsetColor	255,0,0,ihinput
FLsetColor2	255,0,0,gihrms
FLsetColor2	255,255,0,gihrms_peak


;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	0, 	ihinput
				FLsetVal_i	0, 	gihpeak
				FLsetVal_i	0, 	gihrms
				FLsetVal_i	0, 	gihrms_peak
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 280, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            peak                             ", 	1,      6,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"'peak' outputs the maximum absolute value held so far by an a", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"or k-rate variable.                                          ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"In this example the input is the 'input' slider and the peak ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"value recorded is sent to the slider 'peak'.                 ", 	1,      5,     14,    490,    20,     5, 100
ih		  	FLbox  	"As an additional example the peak amplitude rms value        ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"received at the computer's input is displayed.               ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Both of these uses of the peak opcode can be reset with their", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'RESET' buttons. This resetting is implemented using         ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"reinitialisation via the 'reinit' opcode. Note that the      ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"output of 'peak' also needs to be reintialised to zero when  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"this is done as it is simulatensously both an input and an   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"output.                                                      ", 	1,      5,     14,    490,    20,     5, 260
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1

instr	1
 ktrig		changed		gkreset				; sense if RESET button has been pressed
 if ktrig==1 then						; if RESET button has been pressed ...
  reinit RESET_PEAK						; ... begin a reinitialisation pass from the given label
 endif								; end of conditional branch
 RESET_PEAK:							; a label. Reinitialisation begins from here.
 kpeak		init		0				; initialise peak output (which is also an input used in comparison)
 kpeak		peak		gkinput				; scan for peak absolute value
 rireturn							; return from reinitialisation pass
 ktrig		changed		kpeak				; generate a trigger if peak value changes 
 		FLsetVal	ktrig, kpeak, gihpeak		; send new peak values to display slider
 gkreset	=		0				; reset button set to zero each k-rate pass
 
 
 aInput		inch		1				; read input channel 1
 krms		rms		aInput				; scan rms values of audio stream

 kmetro		metro		15
 		FLsetVal	kmetro,krms,gihrms

 ktrig		changed		gkreset2			; sense if RESET button has been pressed
 if ktrig==1 then						; if RESET button has been pressed ...
  reinit RESET_PEAK2						; ... begin a reinitialisation pass from the given label            
 endif								; end of conditional branch                                         
 RESET_PEAK2:							; a label. Reinitialisation begins from here.                       
 krms_peak	init		0				; initialise peak output (which is also an input used in comparison)
 krms_peak	peak		krms				; scan for peak absolute value                                      
 rireturn							; return from reinitialisation pass                                 
 ktrig		changed		krms_peak			; generate a trigger if peak value changes                          
 		FLsetVal	ktrig, krms_peak, gihrms_peak	; send new peak values to display slider
 gkreset2	=		0				; reset button set to zero each k-rate pass
endin
  	
</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>