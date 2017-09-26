TapTempoAudio.csd
Written by Iain McCurdy 2012.

<CsoundSynthesizer>

<CsOptions>
-odac -iadc -dm0                                          
</CsOptions>
                                                       
<CsInstruments>

sr	= 	44100
ksmps	= 	8
nchnls	= 	1	;MONO
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FLcolor		255,255,255
FLcolor2	  0,  0,  0

;		LABEL                | WIDTH | HEIGHT | X | Y
	FLpanel	"Tap Tempo (Audio)",    500,    210,    0,  0

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idthreshold		FLvalue	" ",    60,       20,    5,    35
idInGain		FLvalue	" ",    60,       20,    5,   135
idMetroGain		FLvalue	" ",    60,       20,    5,   185

;					            			MIN  | MAX | EXP | TYPE |     DISP     | WIDTH | HEIGHT | X | Y
gkthreshold,ihthreshold		FLslider 	"Threshold",		0,      1,    0,    23,   idthreshold,    490,    25,     5,  10
gkInGain,ihInGain		FLslider 	"Audio Input Gain",	0,      1,    0,    23,   idInGain,       490,    25,     5, 110
gkMetroGain,ihMetroGain		FLslider 	"Metronome Gain",	0,      1,    0,    23,   idMetroGain,    490,    25,     5, 160

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gktempo, gihtempo			FLtext		"Tempo",	0,   2000,    0,    1,     100,     20,    5,  60
gkbeatduration, gihbeatduration		FLtext		"Beat Duration",0,   2000,    0,    1,     100,     20,   110, 60


;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0.2, 	ihthreshold
			FLsetVal_i	1, 	ihInGain
			FLsetVal_i	1, 	ihMetroGain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     340,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      Tap Tempo (Audio)                      ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example uses tapping of a microphone to derive a tempo. ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"The tempo deduced and beat duration are printed to the       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"relevant FLTK widgets each time the microphone is struck. An ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"audio metronome provides audible confirmation of the current ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"tempo value. Tempo is calculated by measuring the time gap   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"between successive tappings of the microphone and by then    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"regarding this measurement as a beat duration. Beat duration ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"is actually calculated by averaging the previous two time    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"gaps. It is necessary to tap the microphone at least four    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"times at a particular tempo to arrive at an accurate         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"calculation of that tempo. Tempo and beat duration are       ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"provided as global variables so that the code for this       ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"instrument could easily be transplanted into another         ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"orchestra. Encapsulating all code within a single instrument ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"block also assists in achieving this.                        ", 	1,      5,     14,    490,    15,     5, 320

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	taptempo
			prints		"Tap the microphone bar repeatedly...%n" ;PRINT INSTRUCTION TO THE TERMINAL
	;SET SOME INITIAL VALUES AND CREATE FUNCTION TABLES                  
	kTimer		init		1			;TIMER THAT MEASURES THE TIME GAP BETWEEN ADJACENT NOTES
	gkBeatDur	init		1			;AVERAGE OF ALL TIME GAPS STORED IN TABLE
	gkTempo		init		60			;CURRENT TEMPO
	iTabLoc		init		0			;TABLE LOCATION COUNTER
	iTimes		ftgentmp	0,0,-2,-2,1,1		;TABLE TO STORE TIME GAPS
	isine		ftgentmp	0,0,4096,10,1		;A SINE WAVE
	
	;SENSE TEMPO
	a1	inch	1							;READ LIVE AUDIO INPUT FROM INPUT CHANNEL 1 
	krms	rms	a1*gkInGain							;DERIVE RMS VALUE FROM AUDIO STREAM
	ktrig	trigger	krms,gkthreshold,0					;IF RMS THRESHOLD HAS BEEN CROSS (IN THE UPWARDS DIRECTION) ktrig EQUALS '1' FOR ONE 'K' CYCLE
 	if ktrig=1 then								;IF THERE HAS BEEN A RMS THRESHOLD CROSSING... 
 	  		reinit		TAP					;BEGIN A REINITIALISATION PAS FROM LABEL 'TAP'
 	endif									;END OF CONDITIONAL BRANCH
 	TAP:									;LABEL CALLED 'TAP'. REINITIALISATION BEGINS FROM HERE AFTER AN RMS THRESHOLD CROSSING HAS BEEN DETECTED.
	kNoteOnFlag	init		1					;NOTE ON FLAG IS SET TO ON (WILL BE RESET TO ZERO IN INSTR 3)
 	iTimeGap	init		i(kTimer)				;READ TIME GAP BETWEEN PREVIOUS NOTE AND THIS ONE
	iTimeGap	=		(iTimeGap>2?i(gkBeatDur):iTimeGap)	;DON'T ALLOW EXCESSIVELY LONG TIME GAPS - I.E. AFTER A LONG WAIT WHICH IS PROBABLY NOT INTENDED AS AN INDICATION OF TEMPO - INSTEAD REPLACE READING WITH THE CURRENT TEMPO
			tablew		iTimeGap,iTabLoc,iTimes			;WRITE TIME GAP READING TO FUNCTION TABLE
	iNumVals	=		ftlen(iTimes)				;DEDUCE NUMBER OF TIMER READING LOCATIONS IN THE TABLE
	iTabLoc		wrap		iTabLoc+1,0,iNumVals			;INCREMENT THE TABLE LOCATION COUNTER. WRAP AROUND BACK TO ZERO IF REQUIRED
	iSumVals	init		0					;INITIALISE AND CLEAR SUM OF ALL TIME GAP READINGS STORED IN giTimes TABLE
	iLoopCount	init		0					;INITIALISE LOOP COUNTER
	LOOP_BEGIN:								;LABEL. LOOP BEGINS HERE
	ival		table		iLoopCount,iTimes			;READ TIME GAP READING FROM TABLE
	iSumVals	=		iSumVals+ival				;ADD TIME GAP READING FROM TABLE TO THE ACCUMULATING VARIABLE iSumVals
			loop_lt  	iLoopCount,1,iNumVals,LOOP_BEGIN	;LOOP BACK TO THE BEGINNING OF THE LOOP IF THERE ARE STILL MORE TIME GAP READINGS TO BE READ
	gkBeatDur	init		iSumVals/iNumVals			;FIND THE AVERAGE OF THE TABLE
	gkTempo		init		60/i(gkBeatDur)				;DEDUCE TEMPO
			prints 		"tempo:%5.2f%tbeat duration:%5.3f%n",gkTempo,gkBeatDur	;PRINT TEMPO AND BEAT DURATION TO THE TERMINAL
			FLsetVal_i	i(gkTempo), gihtempo
			FLsetVal_i	i(gkBeatDur), gihbeatduration
	kTimer		timeinsts						;TIMER READS THE TIME SINCE THIS NOTE BEGAN
			rireturn
	;AUDIO METRONOME
	kmetro		metro		gkTempo/60			;CREATE A TRAIN OF METRONOME TRIGGER ACCORDING TO CURRENT TEMPO
	if kmetro=1 then						;IF A METRONOME BEAT HAS BEEN RECEIVED
	  		  reinit	RESTART_CLICK			;REINITIALISE THE METRONOME
	endif								;END OF CONDITIONAL BRANCH
	RESTART_CLICK:							;A LABEL. REINTIALISATION OF THE METRONOME ENVELOPES (AMPLITUDE AND PITCH) BEGINS HERE.
	aenv		linseg		0,0.001,1,0.005-0.001,0		;PERCUSSIVE AMPLITUDE ENVELOPE
	afreq		expseg		4000,0.005,200,1,200		;PITCH OF TONE (VERY FAST GLISS DOWN TO A HELD VALUE)
			rireturn					;RETURN FROM REINITIALISATION PASS
	asig		oscili		0.5*aenv*gkMetroGain,afreq,isine;CREATE AUDIO FOR METRONOME 'CLICK'
			out		asig				;SEND AUDIO TO OUPUT
endin

</CsInstruments>

<CsScore>
i "taptempo" 0 3600 
</CsScore>

</CsoundSynthesizer>