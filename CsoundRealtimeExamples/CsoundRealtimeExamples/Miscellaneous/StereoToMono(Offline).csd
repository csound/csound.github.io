STEREO TO MONO CONVERSION (OFFLINE)
Written by Iain McCurdy, 2010

This example takes a stereo file input and writes a mono file to disk.
Three methods of conversion are available by uncommenting the relevant section of code:
1) Left channel
2) Right channel
3) Mix both channels
Left channel is output by default.

Because this task is performed offline without realtime performance it is suitable for quick conversion of long sound files.
The disadvantage is that the process must be repeated for each channel.

This example could easily be adapted to convert a mono file to stereo

<CsoundSynthesizer>

<CsOptions>
;OUTPUT FLAGS ARE FOR 24BIT WAV
-oStereoToMonoRender.wav -W  -3
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)

;REPLACE THIS FILE NAME WITH THE NAME OF YOUR DESIRED STEREO INPUT SOUND FILE
#define	FILE	#"StereoInputSoundfile.wav"#

instr	1
	ilen	filelen	$FILE		;DERIVE LENGTH OF INPUT SOUND FILE
	event_i	"i", 2, 0, ilen		;TRIGGER INSTRUMENT 2
endin
	
instr	2
	asigL, asigR	diskin2	$FILE,    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)

	;LEFT CHANNEL------------------------------------------------------------------------
			out	asigL	;LEFT CHANNEL IS OUTPUT TO FILE
	;------------------------------------------------------------------------------------

	;RIGHT CHANNEL-----------------------------------------------------------------------
	;		out	asigR	;RIGHT CHANNEL IS OUTPUT TO FILE
	;------------------------------------------------------------------------------------
	
	;MIX CHANNELS------------------------------------------------------------------------
	;		out	(asigL+asigR)*0.5	;MIX OF CHANNELS IS OUTPUT TO FILE
	;------------------------------------------------------------------------------------
endin
  	
</CsInstruments>

<CsScore>
i1 0 0.01	;SHORT SCORE EVENT - DURATION REQUIRED FOR OUTPUT FILE WILL BE DERIVED FROM DURATION OF INPUT FILE
</CsScore>

</CsoundSynthesizer>