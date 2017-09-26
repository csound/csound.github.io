STEREO TO MONO CONVERSION (ONLINE/REAL_TIME)
Written by Iain McCurdy, 2010

This example takes a stereo file input and writes a 2 mono files, one for each channel, to disk.
The advantage of this method over the offline method is that both channels can be output to separate files in one go.
The disadvantage is that it must be done in real-time.

This example could easily be adapted to merge two mono files to a single stereo output.
Conversion of files with more than two channels are also possible.

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS

;INSTRUCTIONS AND INFO PANEL                 		WIDTH | HEIGHT | X | Y
				FLpanel	"timedseq", 	500,     200,    0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"     CONVERT A STEREO FILE TO TWO MONO FILES IN REALTIME     ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example takes a stereo file input and writes a 2 mono   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"files, one for each channel, to disk.                        ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"The advantage of this method over the offline method is that ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"both channels can be output to separate files in one go. The ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"disadvantage is that it must be done in real-time.           ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"This example could easily be adapted to merge two mono files ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"to a single stereo output. Conversion of files with more than", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"two channels are also possible.                              ", 	1,      5,     14,    490,    20,     5, 180

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;REPLACE THIS FILE NAME WITH THE NAME OF YOUR DESIRED STEREO INPUT SOUND FILE
#define	FILE	#"StereoInputSoundfile.wav"#

instr	1
	ilen	filelen	$FILE		;DERIVE LENGTH OF INPUT SOUND FILE
	event_i	"i", 2, 0, ilen		;TRIGGER INSTRUMENT 2
endin
	
instr	2
	asigL, asigR	diskin2	$FILE,    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	fout	"LeftChannel.wav", 8, asigL	;LEFT CHANNEL IS OUTPUT TO FILE
	fout	"RighChannel.wav", 8, asigR	;RIGHT CHANNEL IS OUTPUT TO FILE
		outs	asigL, asigR	;REAL TIME AUDIO OUTPUT - USEFUL FOR MONITORING THE PROGRESS OF THE CONVERSION PROCESS
endin
  	
</CsInstruments>

<CsScore>
i1 0 0.01	;SHORT SCORE EVENT - DURATION REQUIRED FOR OUTPUT FILE WILL BE DERIVED FROM DURATION OF INPUT FILE
</CsScore>

</CsoundSynthesizer>