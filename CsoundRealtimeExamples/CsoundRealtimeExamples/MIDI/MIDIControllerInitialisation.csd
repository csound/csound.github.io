MIDIControllerInitialisation.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -dm0 
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;INSTRUCTIONS AND INFO PANEL                     WIDTH | HEIGHT | X | Y                                                              
				FLpanel	"initc7", 535,    600,    0,  0
				FLscroll          535,    600,    0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"initc7 - Setting an Initial Value for a Continuous Controller", 	1,      5,     14,    510,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    510,    20,     5,  20
ih		 	FLbox  	"This example builds upon the previous example in that it     ", 	1,      5,     14,    510,    20,     5,  40
ih		 	FLbox  	"demonstrates how to set the initial value of a continuous    ", 	1,      5,     14,    510,    20,     5,  60
ih		 	FLbox  	"controller used in a csound orchestra.                       ", 	1,      5,     14,    510,    20,     5,  80
ih		 	FLbox  	"If no initial value is defined then then a ctrl7's output    ", 	1,      5,     14,    510,    20,     5, 100
ih		 	FLbox  	"defaults to its minimum value.                               ", 	1,      5,     14,    510,    20,     5, 120
ih		 	FLbox  	"The opcode initc7 is used to set an initial value for ctrl7. ", 	1,      5,     14,    510,    20,     5, 140
ih		 	FLbox  	"initc7 is normally placed in the instrument 0 part of the    ", 	1,      5,     14,    510,    20,     5, 160
ih		 	FLbox  	"orchestra (after the orchestra header and before the first   ", 	1,      5,     14,    510,    20,     5, 180
ih		 	FLbox  	"instrument) so that the controller is initialised only when  ", 	1,      5,     14,    510,    20,     5, 200
ih		 	FLbox  	"the orchestra is started. If it is placed within an          ", 	1,      5,     14,    510,    20,     5, 220
ih		 	FLbox  	"instrument then it will be initialised each time that        ", 	1,      5,     14,    510,    20,     5, 240
ih		 	FLbox  	"instrument is activated - it is unlikely that this will be   ", 	1,      5,     14,    510,    20,     5, 260
ih		 	FLbox  	"the desired behaviour.                                       ", 	1,      5,     14,    510,    20,     5, 280
ih		 	FLbox  	"Giving initc7 an intialisation value is not entirely         ", 	1,      5,     14,    510,    20,     5, 300
ih		 	FLbox  	"straightforward. We cannot give initc7 the actual value we   ", 	1,      5,     14,    510,    20,     5, 320
ih		 	FLbox  	"desire as because initc7 appears before ctrl7 Csound does not", 	1,      5,     14,    510,    20,     5, 340
ih		 	FLbox  	"yet know the range of the controller. Instead, initc7 expects", 	1,      5,     14,    510,    20,     5, 360
ih		 	FLbox  	"a value within the range 0 - 1, with a value of zero         ", 	1,      5,     14,    510,    20,     5, 380
ih		 	FLbox  	"representing the controller's minimum setting and a value of ", 	1,      5,     14,    510,    20,     5, 400
ih		 	FLbox  	"1 representing the controller's maximum setting. Csound will ", 	1,      5,     14,    510,    20,     5, 420
ih		 	FLbox  	"subsequently adjust this value when it encounters the ctrl7  ", 	1,      5,     14,    510,    20,     5, 440
ih		 	FLbox  	"line of code. Normally we are more concerned with the precise", 	1,      5,     14,    510,    20,     5, 460
ih		 	FLbox  	"value of ctrl7's output therefore it is useful to use the    ", 	1,      5,     14,    510,    20,     5, 480
ih		 	FLbox  	"formula given below to calculate the corresponding value to  ", 	1,      5,     14,    510,    20,     5, 500
ih		 	FLbox  	"give initc7.                                                 ", 	1,      5,     14,    510,    20,     5, 520
ih		 	FLbox  	"*************************************************************", 	1,      5,     14,    510,    20,     5, 540
ih		 	FLbox  	"                Desired_Controller_Value - Controller_Minimum", 	1,      5,     14,    510,    20,     5, 560
ih		 	FLbox  	"Initial__Value =_____________________________________________", 	1,      5,     14,    510,    20,     5, 580
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    510,    20,     5, 600
ih		 	FLbox  	"                Controller_Maximum       - Controller_Minimum", 	1,      5,     14,    510,    20,     5, 620
ih		 	FLbox  	"*************************************************************", 	1,      5,     14,    510,    20,     5, 640
ih		 	FLbox  	"Note that this formula will not work if the midi controller  ", 	1,      5,     14,    510,    20,     5, 660
ih		 	FLbox  	"is rescaled using a non-linear function table when it is     ", 	1,      5,     14,    510,    20,     5, 680
ih		 	FLbox  	"declared using ctrl7.                                        ", 	1,      5,     14,    510,    20,     5, 700
ih		 	FLbox  	"In this example the volume controller is initialised to its  ", 	1,      5,     14,    510,    20,     5, 720
ih		 	FLbox  	"maximum setting and initc7 is therefore given the value '1'  ", 	1,      5,     14,    510,    20,     5, 740
ih		 	FLbox  	"for an initial state.                                        ", 	1,      5,     14,    510,    20,     5, 760
				FLscroll_end
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;The opcode 'initc7' initialises a continuous controller to a specified location between
;its minimum and maximum value.

;This initialisation value is expressed as a propotion of how far along its path from 
;minimum to maximum it should begin and is therefore always a number in the range 0-1.
;A value of 0 would imply that the slider begins at its lowest setting.
;A value of 1 would imply that the slider begins at its highest setting.
;A value of .5 would imply that the slider begins halfway along its track.

;If you require a midi controlled variable to begin at a specific value the required
;initialisation value can be calculated using the formula shown below.

;Initialisation defaults to 0 so if you require a controller to begin at minimum it is 
;not necessary to initialise it.

;NOTE THAT ONCE A SLIDER IS PHYSICALLY MOVED ITS CORRESPONDING CSOUND VARIABLE IMMEDIATELY
;JUMPS TO THAT NEW VALUE

;NOTE ALSO THAT THIS INITIALISATION STATEMENT IS PLACED BETWEEN THE HEADER STATEMENTS AND THE
;FIRST INSTRUMENT DEFINITION (known as the instr 0 definition) - THIS MEANS THAT THE CONTROLLER
;WILL BE INITIALISED UPON BEGINNING THE CSOUND SESSION *ONLY*
;IF THE INITIALISATION STATEMENT IS PLACED WITHIN THE INSTRUMENT CODE ITSELF IT WILL REINITIALISE
;EACH TIME A NEW NOTE IS PLAYED

;      		MIDICHANNEL | CTRLNUMBER | VALUE(0-1)
	initc7	     1,          1,          1

;**************************************************************************************
;*                                                                                    *
;*                              Desired_Controller_Value    -    Controller_Minimum   *
;*      Initial__Value    =    _____________________________________________________  *
;*                                                                                    *
;*                              Controller_Maximum          -    Controller_Minimum   *
;*                                                                                    *
;**************************************************************************************

giwave	ftgen	0,0,4096,10,1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81

instr	1	; SIMPLE BEEP INSTRUMENT - CAN BE ACTIVATED VIA A CONNECTED MIDI KEYBOARD
	icps	cpsmidi
	iamp	ampmidi 0.2 
	
	;OUTPUT		OPCODE	CHANNEL | CTRLNUMBER | MINIMUM | MAXIMUM
	kvolume		ctrl7	1,            1,          0,        1 	;READ CONTROLLER INFORMATION FROM CONTINUOUS CONTROLLER NUMBER 1 ON MIDI CHANNEL 1 AND RESCALE TO BE WITHIN THE RANGE 0 - 1 
	
	kporttime	linseg	0, .001, .01, 1, .01	;CREATE A RAMPING UP FUNCTION THAT WILL BE USED FOR PORTAMENTO TIME - THIS WILL PREVENT PORTAMENTO-ED VARIABLES FROM GLIDING UP TO THEIR DESIRED VALUES AT NOTE ONSETS 
	kvolume		portk	kvolume, kporttime	;APPLY PORTAMENTO TO kvolume TO SMOOTH ITS MOVEMENT
	
	;               INITIAL_LEVEL | ATTACK_TIME | ATTACK_LEVEL | DECAY_TIME | SUSTAIN_LEVEL |  RELEASE_TIME | RELEASE_LEVEL
	aenv	linsegr	      0,           (.01),          1,           (.1),          .7,            (.05),            0 
	
	asig	poscil	iamp,icps,giwave
		out	asig * aenv * kvolume
endin

</CsInstruments>

<CsScore>
f 0 600	; THIS LINE FUNCTIONS AS A DUMMY SCORE EVENT AND ALLOWS REALTIME MIDI PLAYING FOR 10 MINUTES
</CsScore>

</CsoundSynthesizer>