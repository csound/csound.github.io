; mediank.csd
; Written by Iain McCurdy, 2014.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	48000	;SAMPLE RATE
ksmps 		= 	6000	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"mediank",    500,    240,    0,  0




;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	3,      9,     15,    490,    90,    5,  10	;
FLsetColor	20,205,205,ih

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"User Input", 	1,      10,    14,    100,    15,    200, 16
FLsetColor	20,205,205,ih

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkSampSize, ihSampSize	FLcount  "Sample Window",	1,     41,    1,      1,     2,     115,     25,   10,  40,   -1

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
iddeviation		FLvalue	"",       60,     17,    130, 65

;SLIDERS					            		MIN | MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X   | Y
gkdeviation,ihdeviation		FLslider 	"Noise Level",		0,     1,    0,    23, iddeviation,    360,     25,  130,   40




;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	3,      9,     15,    490,    125,    5, 105	;
FLsetColor	200,255,150,ih

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Data Monitor", 	1,      10,    14,    100,    15,    200, 111
FLsetColor	200,255,150,ih

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idinput			FLvalue	"",       60,     17,    10, 160
idoutput		FLvalue	"",       60,     17,    10, 210

;SLIDERS					            		MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkinput,gihinput		FLslider 	"Noisy Input",		-1,    1,    0,    23,  idinput,    480,     25,   10,   135
gkoutput,gihoutput		FLslider 	"Filtered Output",	-1,    1,    0,    23,  idoutput,   480,     25,   10,   185




;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	0, 	gihinput
				FLsetVal_i	0, 	gihoutput
				FLsetVal_i	9, 	ihSampSize
				FLsetVal_i	0.3, 	ihdeviation
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 780, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          mediank                            ", 	1,      6,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"'median' and 'mediank' apply median filtering to an input    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"signal. (a-rate signal with 'median' and k-rate signals with ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"'mediank'.)                                                  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Median filtering takes a range of sequential values -        ", 	1,      5,     14,    490,    20,     5, 100
ih		  	FLbox  	"referred to as a window - arranges them in order of size and ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"outputs the middle value. This can be a useful method of     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"filtering noise from a signal and smoothing data changes by  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"dumping irrational values - values that would skew the output", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"of normal averaging (or lowpass filtering / portamento       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"filtering).                                                  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"Median filtering is used a lot in digital image processing to", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"remove noise created by electrical interference. It is also  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"useful for smoothing data received by electronic sensors and ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"for 'debouncing'.                                            ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"In this example a noisy signal of zeros is created (i.e.     ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"occasional '1's and '-1's will occur) at a rate of 8 values  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"per second. The likelihood of wrong values is governed by the", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"'noise' level slider. Rate of generation of these values is  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"governed by the control rate and can be changed by the user  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"by changing the value of ksmps.                              ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"'Sample Window' defines the number of values in each         ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"filtering interrogation. Noisier signals will demand a larger", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"sample window but excessively large sample windows will      ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"demand more from the CPU and slow response of the output     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"signal in response to changes in the input signal.           ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"If sample window is size '1' then the median filter simply   ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"outputs the input. If window size is an even number then     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"is no central value, in this situation the output value is   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"the mean between the two central values. For this reason it  ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"is normal to use an odd number for the window size.          ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"In practice, when deciding upon what value to use for sample ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"window size it is best to devise some method of monitoring   ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"the input and the output and to monitor what the minimum size", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"required is to remove the noise. It is also an option to     ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"chain median filters in series, the second one using a much  ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"smaller sample window size (e.g. '3') to filter out rogue    ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"values.                                                      ", 	1,      5,     14,    490,    20,     5, 760
                                                                                                                                                  


				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1	; Instrument 1 always on

instr	1
 kval	random		-1-gkdeviation, 1+gkdeviation	; Random value. New one each k-cycle.
 kval	=		int(kval)			; Turn it into an integer. Remove fractional part.
 ktrig	changed		kval				; If it has changed from last last k-cycle value, generate a trigger.
 	FLsetVal	ktrig,kval,gihinput		; Send changes in the random value to the 'Input' slider.
 kfilt	mediank		kval, gkSampSize, 41		; Median filter the stream of random values.
 ktrig	changed		kfilt				; If median filtered values has changed generate a trigger.
 	FLsetVal	ktrig,kfilt,gihoutput		; Send changes in the filtered values to the 'Output' slider.
endin
  	
</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>