granule.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"granule",  500,    840,    0,  0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCloudEnv	 	FLbox  	"", 	6,        9,    15,   496,    70,    2, 770	;GRAIN CLOUD ENVELOPE

;SWITCHES								ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",		1,    0,    22,    110,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp	  	FLvalue   " ",	65,       17,     5,  145
idratio	  	FLvalue   " ",	65,       17,     5,  195
idgap	  	FLvalue   " ",	65,       17,     5,  245
idgapos	  	FLvalue   " ",	65,       17,     5,  295
idsize	  	FLvalue   " ",	65,       17,     5,  345
idsizeos	FLvalue   " ",	65,       17,     5,  395
idatt	  	FLvalue   " ",	65,       17,     5,  445
iddec	  	FLvalue   " ",	65,       17,     5,  495
idpch1	  	FLvalue   " ",	60,       17,     5,  545
idpch2	  	FLvalue   " ",	60,       17,   255,  545
idpch3	  	FLvalue   " ",	60,       17,     5,  595
idpch4	  	FLvalue   " ",	60,       17,   255,  595
idseedL	  	FLvalue   " ",	60,       17,     5,  645
idseedR	  	FLvalue   " ",	60,       17,   255,  645
idskip	  	FLvalue   " ",	65,       17,     5,  695
idskipos	FLvalue   " ",	65,       17,     5,  745
idAtt	  	FLvalue   " ",  60,       20,    5,   815
idRel	  	FLvalue   " ",  60,       20,  255,   815

;SLIDERS					      			MIN   | MAX  | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",    		0,         1,   0,    23,   idamp,     490,     25,     5,  120
gkratio, ihratio	FLslider	"Playback Ratio (i-rate)",   	0.0001,    2,   0,    23,   idratio,   490,     25,     5,  170
gkgap, gihgap		FLslider	"Grain Gap (CC#1)",   		0,         5,   0,    23,   idgap,     490,     25,     5,  220
gkgapos, ihgapos	FLslider	"Grain Gap Offset (i-rate)",	0,       100,   0,    23,   idgapos,   490,     25,     5,  270
gksize, gihsize		FLslider	"Grain Size (CC#2)",		0.0001,    1,   0,    23,   idsize,    490,     25,     5,  320
gksizeos, ihsizeos	FLslider	"Grain Size Offset",		0,       100,   0,    23,   idsizeos,  490,     25,     5,  370
gkatt, ihatt		FLslider	"Attack",     			0,       100,   0,    23,   idatt,     490,     25,     5,  420
gkdec, ihdec		FLslider	"Decay",  			0,       100,   0,    23,   iddec,     490,     25,     5,  470
gkpch1, ihpch1		FLslider	"Pitch1",  			.5,        2,   0,    23,   idpch1,    240,     25,     5,  520
gkpch2, ihpch2		FLslider	"Pitch2",  			.5,        2,   0,    23,   idpch2,    240,     25,   255,  520
gkpch3, ihpch3		FLslider	"Pitch3",  			.5,        2,   0,    23,   idpch3,    240,     25,     5,  570
gkpch4, ihpch4		FLslider	"Pitch4",  			.5,        2,   0,    23,   idpch4,    240,     25,   255,  570
gkseedL, ihseedL	FLslider	"Seed Value (left)",		0,         1,   0,    23,   idseedL,   240,     25,     5,  620
gkseedR, ihseedR	FLslider	"Seed Value (right)",		0,         1,   0,    23,   idseedR,   240,     25,   255,  620
gkskip, ihskip		FLslider	"Inskip",    			0,         1,   0,    23,   idskip,    490,     25,     5,  670
gkskipos, ihskipos	FLslider	"Inskip Offset",		0,         1,   0,    23,   idskipos,  490,     25,     5,  720
gkAtt,ihAtt		FLslider	"Attack Time",			0.05,     10,   0,    23,   idAtt,     240,     25,    5,   790
gkRel,ihRel		FLslider	"Release",			0.05,     10,   0,    23,   idRel,     240,     25,  255,   790

;COUNTERS				     			MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkvoices, ihvoices	FLcount  	"Number of Voices", 	1,    128,    1,     16,     1,     120,     25,   125, 5,   -1 
gkptrmode, ihptrmode	FLcount  	"Pointer Mode",      	-1,   1,      1,      2,     2,     115,     25,   255, 5,   -1 
gknumpchs, ihnumpchs	FLcount  	"No. of Pitches",	0,    4,      1,      5,     2,     115,     25,   380, 5,   -1 
gkinput, ihinput	FLcount  	"Sound File Input", 	1,    3,      1,    100,     2,     150,     25,   175,50,   -1 

;TEXT BOXES              							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "1 - Voice . 2 - Drum Loop . 3 - Classical Guitar",	1,      1,     12,    500,     15,    0,  90
ih		 FLbox	"Grain Cloud Envelope",					1,      3,     12,    130,     15,    5, 771

;INITIALISATION OF SLIDERS
			FLsetVal_i   	0.3, 	ihamp
			FLsetVal_i   	1, 	ihratio
			FLsetVal_i   	.01, 	gihgap
			FLsetVal_i   	50, 	ihgapos
			FLsetVal_i   	.02, 	gihsize
			FLsetVal_i   	30, 	ihsizeos
			FLsetVal_i   	30, 	ihatt
			FLsetVal_i   	30, 	ihdec
			FLsetVal_i   	16, 	ihvoices
			FLsetVal_i   	1, 	ihptrmode
			FLsetVal_i   	1, 	ihnumpchs
			FLsetVal_i   	1, 	ihpch1
			FLsetVal_i   	1, 	ihpch2
			FLsetVal_i   	1, 	ihpch3
			FLsetVal_i   	1, 	ihpch4
			FLsetVal_i   	.4, 	ihseedL
			FLsetVal_i   	.5, 	ihseedR
			FLsetVal_i   	0, 	ihskip
			FLsetVal_i   	0, 	ihskipos
			FLsetVal_i   	0.05, 	ihAtt
			FLsetVal_i   	0.05, 	ihRel
			FLsetVal_i   	1, 	ihinput

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 770, 512, 0
				FLscroll     515, 770, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          granule                            ", 	1,      5,     14,    490,     20,    5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"'Granule' is a complex granular synthesis opcode which is    ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"good at producing dense granular synthesis textures. Many of ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"'granule's' input arguments operate only at i-rate making it ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"slightly less useful for real-time work.                     ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"As a source for granulation 'granule' uses an audio sample   ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"stored in a function table. GEN 1 is well suited for this    ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"purpose.                                                     ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"Instead of using a 'time pointer' to define from where grains", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"will begin playback, 'granule' uses a 'Playback Ratio'       ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"(iratio) parameter which defines the rate of the pointer's   ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"movement through the function table in relation to the       ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"original, unmodified speed. For example a playback ratio of  ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	".5 produces half-speed playback of the file, a ratio of 2    ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"produces double-speed playback and so on. It should also be  ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"noted that if using the 'grain gap' parameter (i.e. giving it", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"a value other than zero) then playback will be further       ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"retarded.                                                    ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"'Granule' produces granular synthesis textures by creating   ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"layers of independent grain streams. The number of grain     ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"streams present is defined by the 'Number of Voices' (ivoice)", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"parameter (range: 1-128). Using a high value for 'Number of  ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"Voices' increases the demand on the CPU considerably.        ", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"The 'Grain Gap' parameter (kgap) is used to define the time  ", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"gap in ms. between grains in a particular grain stream.      ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"'Grain Gap Offset' (igap_os) is used to define the amount of ", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"random variation (as a percentage of the value given for     ", 	1,      5,     14,    490,     20,    5, 540
ih		 	FLbox  	"'Grain Gap') that will be applied to the values used for the ", 	1,      5,     14,    490,     20,    5, 560
ih		 	FLbox  	"time gap between grains in the granular synthesis.           ", 	1,      5,     14,    490,     20,    5, 580
ih		 	FLbox  	"The 'Grain Size' parameter (kgsize) is used to define the    ", 	1,      5,     14,    490,     20,    5, 600
ih		 	FLbox  	"size of the grains in ms.                                    ", 	1,      5,     14,    490,     20,    5, 620
ih		 	FLbox  	"'Grain Size Offset' (igsize_os) is used to define the amount ", 	1,      5,     14,    490,     20,    5, 640
ih		 	FLbox  	"of random variation (as a percentage of the value given for  ", 	1,      5,     14,    490,     20,    5, 660
ih		 	FLbox  	"'Grain Size') that will be applied to the values used for the", 	1,      5,     14,    490,     20,    5, 680
ih		 	FLbox  	"the size of the grains in the granular synthesis.            ", 	1,      5,     14,    490,     20,    5, 700
ih		 	FLbox  	"The shape of the amplitude envelope applied to each grain is ", 	1,      5,     14,    490,     20,    5, 720
ih		 	FLbox  	"is created by defining the duration of of the attack, sustain", 	1,      5,     14,    490,     20,    5, 740
ih		 	FLbox  	"and decay portions of the envelope (ASD envelope). 'Attack'  ", 	1,      5,     14,    490,     20,    5, 760
ih		 	FLbox  	"(iatt) and 'Decay' (idec) are defined as percentages of the  ", 	1,      5,     14,    490,     20,    5, 780
ih		 	FLbox  	"entire duration (i.e. 100%) of the grain as defined by 'Grain", 	1,      5,     14,    490,     20,    5, 800
ih		 	FLbox  	"Size' and 'Grain Size Offset'. The sustain portion of the    ", 	1,      5,     14,    490,     20,    5, 820
ih		 	FLbox  	"envelope will be the durational remainder after the attack   ", 	1,      5,     14,    490,     20,    5, 840
ih		 	FLbox  	"and decay portions have been created. The sum of the values  ", 	1,      5,     14,    490,     20,    5, 860
ih		 	FLbox  	"for 'Attack' and 'Decay' must be less than or equal to 100.  ", 	1,      5,     14,    490,     20,    5, 880
ih		 	FLbox  	"The grain envelope can also be created using a stored        ", 	1,      5,     14,    490,     20,    5, 900
ih		 	FLbox  	"function table. In this case the number of this table should ", 	1,      5,     14,    490,     20,    5, 920
ih		 	FLbox  	"be given using the optional input argument 'ifnenv'. Gen 5 or", 	1,      5,     14,    490,     20,    5, 940
ih		 	FLbox  	"Gen 7 would be good choices for creating this envelope.      ", 	1,      5,     14,    490,     20,    5, 960
ih		 	FLbox  	"The 'Pointer Mode' switch is used to define how the pointer  ", 	1,      5,     14,    490,     20,    5, 980
ih		 	FLbox  	"moves through each grain. It can be though of as a 3-way     ", 	1,      5,     14,    490,     20,    5, 1000
ih		 	FLbox  	"switch. A value of 1 means that the pointer will move forward", 	1,      5,     14,    490,     20,    5, 1020
ih		 	FLbox  	"through each grain, a value of -1 means that the pointer will", 	1,      5,     14,    490,     20,    5, 1040
ih		 	FLbox  	"move backwards through each grain and a value of zero means  ", 	1,      5,     14,    490,     20,    5, 1060
ih		 	FLbox  	"that, grain by grain, the pointer will randomly choose to    ", 	1,      5,     14,    490,     20,    5, 1080
ih		 	FLbox  	"move either forwards or backwards. To be able to clearly hear", 	1,      5,     14,    490,     20,    5, 1100
ih		 	FLbox  	"the effect of this function use large grain sizes in a sparse", 	1,      5,     14,    490,     20,    5, 1120
ih		 	FLbox  	"texture.                                                     ", 	1,      5,     14,    490,     20,    5, 1140
ih		 	FLbox  	"'Granule' is capable of rendering 4 independent              ", 	1,      5,     14,    490,     20,    5, 1160
ih		 	FLbox  	"transpositions. How many trasposition are to be utilised is  ", 	1,      5,     14,    490,     20,    5, 1180
ih		 	FLbox  	"defined by the 'No. of Pitches' (ipshift) parameter. This    ", 	1,      5,     14,    490,     20,    5, 1200
ih		 	FLbox  	"value can be either 0,1,2,3, or 4. A value of zero means that", 	1,      5,     14,    490,     20,    5, 1220
ih		 	FLbox  	"each grain will be randomly transposed in the range -1 to +1 ", 	1,      5,     14,    490,     20,    5, 1240
ih		 	FLbox  	"octave. The transpositions that will be rendered are defined ", 	1,      5,     14,    490,     20,    5, 1260
ih		 	FLbox  	"by the 4 'Pitch' (ipitch#) parameters. (ipitch2 to ipitch4   ", 	1,      5,     14,    490,     20,    5, 1280
ih		 	FLbox  	"are optional arguments.) 'Number of Voices' must be equal to ", 	1,      5,     14,    490,     20,    5, 1300
ih		 	FLbox  	"or greater than 'No. of Pitches'. Transpostions are defined  ", 	1,      5,     14,    490,     20,    5, 1320
ih		 	FLbox  	"as ratios of the original pitch, i.e. 1=no tranposition, .5= ", 	1,      5,     14,    490,     20,    5, 1340
ih		 	FLbox  	"down one octave, 2=up one octave and so on.                  ", 	1,      5,     14,    490,     20,    5, 1360
ih		 	FLbox  	"'Granule' uses its own built-in pseudo-random number         ", 	1,      5,     14,    490,     20,    5, 1380
ih		 	FLbox  	"generator. The seed value used by this pseudo-random number  ", 	1,      5,     14,    490,     20,    5, 1400
ih		 	FLbox  	"generator can be defined using the optional argument iseed.  ", 	1,      5,     14,    490,     20,    5, 1420
ih		 	FLbox  	"In this example two independent 'granule opcodes are used for", 	1,      5,     14,    490,     20,    5, 1440
ih		 	FLbox  	"the left and right channels. The seed values for these two   ", 	1,      5,     14,    490,     20,    5, 1460
ih		 	FLbox  	"opcodes can be set independently (all other input values are ", 	1,      5,     14,    490,     20,    5, 1480
ih		 	FLbox  	"shared. By setting different seed values for the left and    ", 	1,      5,     14,    490,     20,    5, 1500
ih		 	FLbox  	"right channels, broad stereo effects can be created.         ", 	1,      5,     14,    490,     20,    5, 1520
ih		 	FLbox  	"'Inskip' is used to define from where the opcode will begin  ", 	1,      5,     14,    490,     20,    5, 1540
ih		 	FLbox  	"reading grains. When addressing the input argument 'igskip'  ", 	1,      5,     14,    490,     20,    5, 1560
ih		 	FLbox  	"directly this is defined in seconds. In this example the code", 	1,      5,     14,    490,     20,    5, 1580
ih		 	FLbox  	"interrogates the source sample's function table for its      ", 	1,      5,     14,    490,     20,    5, 1600
ih		 	FLbox  	"duration and the 'Inskip' slider functions as a 'ratio of the", 	1,      5,     14,    490,     20,    5, 1620
ih		 	FLbox  	"entire source sample' control. Giving 'Inskip' a value of    ", 	1,      5,     14,    490,     20,    5, 1640
ih		 	FLbox  	"zero will result in grains being initially read from the     ", 	1,      5,     14,    490,     20,    5, 1660
ih		 	FLbox  	"beginning of the source sound file, giving 'Inskip' a value  ", 	1,      5,     14,    490,     20,    5, 1680
ih		 	FLbox  	"of 0.5 will cause result in grains being initially read from ", 	1,      5,     14,    490,     20,    5, 1700
ih		 	FLbox  	"the middle of the source sound file.                         ", 	1,      5,     14,    490,     20,    5, 1720
ih		 	FLbox  	"'Inskip' can function like a grain pointer if 'Playback     ", 	1,      5,     14,    490,     20,    5, 1740
ih		 	FLbox  	"Ratio' is first set to its minimum setting. The only problem ", 	1,      5,     14,    490,     20,    5, 1760
ih		 	FLbox  	"is theat 'Inskip' is an i-rate variable so changing it in    ", 	1,      5,     14,    490,     20,    5, 1780
ih		 	FLbox  	"realtime will case discontinuities in the audio output as the", 	1,      5,     14,    490,     20,    5, 1800
ih		 	FLbox  	"instrument is reinitialized.                                 ", 	1,      5,     14,    490,     20,    5, 1820
ih		 	FLbox  	"'Inskip Offset' introduces a random offset into the 'Inskip' ", 	1,      5,     14,    490,     20,    5, 1840
ih		 	FLbox  	"(igskip) parameter. This can be used to prevent an amplitude ", 	1,      5,     14,    490,     20,    5, 1860
ih		 	FLbox  	"spike when 'Number of when Voices' is a high number and all  ", 	1,      5,     14,    490,     20,    5, 1880
ih		 	FLbox  	"of the pitch streams begin at the same time with the         ", 	1,      5,     14,    490,     20,    5, 1900
ih		 	FLbox  	"identical grains.                                            ", 	1,      5,     14,    490,     20,    5, 1920
ih		 	FLbox  	"This example can also be triggered via MIDI. MIDI note values", 	1,      5,     14,    490,     20,    5, 1940
ih		 	FLbox  	"will be mapped as a global transposition of all voices.      ", 	1,      5,     14,    490,     20,    5, 1960
ih		 	FLbox  	"Middle C will be the point of unison.                        ", 	1,      5,     14,    490,     20,    5, 1980
ih		 	FLbox  	"MIDI controller 1 (modulation wheel) can also be used to     ", 	1,      5,     14,    490,     20,    5, 2000
ih		 	FLbox  	"modulate grain gap and controller 2 can be used to modulate  ", 	1,      5,     14,    490,     20,    5, 2020
ih		 	FLbox  	"grain size.                                                  ", 	1,      5,     14,    490,     20,    5, 2040
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,      5,     14,    490,     20,    5, 2060
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,      5,     14,    490,     20,    5, 2080
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,      5,     14,    490,     20,    5, 2100
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,      5,     14,    490,     20,    5, 2120
ih		 	FLbox  	"material. A 24 bit sound file called 'GranuleOutput.wav' will", 	1,      5,     14,    490,     20,    5, 2140
ih		 	FLbox  	"be created in the default directory for SFDIR.               ", 	1,      5,     14,    490,     20,    5, 2160

				FLscrollEnd
				FLpanel_end

;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35, 510,825
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; THE SOUND FILES USED IN THE GRANULATION
;              NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH          | IN_SKIP | FORMAT | CHANNEL
gifile1L ftgen 0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 
gifile2L ftgen 0,        0,     524288,       1,    "loop.wav",               0,        4,        1 
gifile3L ftgen 0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        1 

gifile1R ftgen 0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile2R ftgen 0,        0,     524288,       1,    "loop.wav",               0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile3R ftgen 0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        2 ;STEREO FILE SO USE RIGHT CHANNEL

;INITIALIZE MIDI CONTROLLERS
initc7	1,1,0.01/5
initc7	1,2,(0.02-0.0001)/(1-0.0001)

instr	1
	kporttime	linseg	0, 0.001, 0.1	;A RAMPING UP FUNCTION IS CREATED THAT WILL BE USED AS PORTAMENTO TIME

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	if	gkOnOff=0&&iMIDIflag=0	then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff		;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		iPitchRatio	=	icps/cpsoct(8)	;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
	else						;OTHERWISE...
		iPitchRatio	=	1		;PITCH RATIO IS JUST 1
	endif						;END OF THIS CONDITIONAL BRANCH

	ksize		portk	gksize, kporttime	;PORTAMENTO SMOOTHING IS APPLIED TO ksize PARAMETER
	kgap		portk	gkgap, kporttime	;PORTAMENTO SMOOTHING IS APPLIED TO kgap PARAMETER

	kSwitch		changed	gkvoices, gkptrmode, gknumpchs, gkskip, gkskipos, gkpch1, gkpch2, gkpch3, gkpch4, gkatt, gkdec, gkratio, gkgapos, gksizeos, gkseedL, gkseedR, gkinput	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif					;END OF CONDITIONAL BRANCHING
	START:					;LABEL

	ivoices 	= 	i(gkvoices)
	iratio 		= 	i(gkratio)
	iptrmode 	= 	i(gkptrmode)
	ithd 		= 	0
	ifnL 		= 	gifile1L + i(gkinput) - 1
	ifnR 		= 	gifile1R + i(gkinput) - 1
	inumpchs 	= 	i(gknumpchs)
	ilen		=	nsamp(ifnL)/sr
	iskip 		= 	i(gkskip)*ilen
	kskipos 	= 	gkskipos*ilen
	iskipos 	= 	i(kskipos)
	igapos 		= 	i(gkgapos)
	isizeos 	= 	i(gksizeos)
	iatt 		= 	i(gkatt)
	idec 		= 	i(gkdec)
	iseedL 		= 	i(gkseedL)
	iseedR 		= 	i(gkseedR)
	ipch1 		= 	i(gkpch1) * iPitchRatio	;DERIVE THE PITCH RATIOS OF THE 4 POSSIBLE VOICES FROM THE FLTK SLIDER VALUES MULIPLIED BY MIDI RATIO VALUE (IN THE CASE OF AN FLTK TRIGGERED NOTE THIS WILL BE JUST 1
	ipch2 		= 	i(gkpch2) * iPitchRatio	;DERIVE THE PITCH RATIOS OF THE 4 POSSIBLE VOICES FROM THE FLTK SLIDER VALUES MULIPLIED BY MIDI RATIO VALUE (IN THE CASE OF AN FLTK TRIGGERED NOTE THIS WILL BE JUST 1
	ipch3 		= 	i(gkpch3) * iPitchRatio	;DERIVE THE PITCH RATIOS OF THE 4 POSSIBLE VOICES FROM THE FLTK SLIDER VALUES MULIPLIED BY MIDI RATIO VALUE (IN THE CASE OF AN FLTK TRIGGERED NOTE THIS WILL BE JUST 1
	ipch4 		= 	i(gkpch4) * iPitchRatio	;DERIVE THE PITCH RATIOS OF THE 4 POSSIBLE VOICES FROM THE FLTK SLIDER VALUES MULIPLIED BY MIDI RATIO VALUE (IN THE CASE OF AN FLTK TRIGGERED NOTE THIS WILL BE JUST 1
	aSigL      	granule    	gkamp, ivoices, iratio, iptrmode, ithd, ifnL, inumpchs, iskip, iskipos, ilen, kgap, igapos, ksize, isizeos, iatt, idec, iseedL, ipch1, ipch2, ipch3, ipch4
	aSigR      	granule    	gkamp, ivoices, iratio, iptrmode, ithd, ifnR, inumpchs, iskip, iskipos, ilen, kgap, igapos, ksize, isizeos, iatt, idec, iseedR, ipch1, ipch2, ipch3, ipch4
	rireturn							;RETURN FROM REINITIALIZATION PASS
	aenv	expsegr	0.0001,i(gkAtt),1,i(gkRel),0.0001		;CLOUD AMPLITUDE ENVELOPE
			outs 	aSigL*gkamp*aenv, aSigR*gkamp*aenv	;SEND AUDIO TO OUTPUTS
endin

instr	2	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
        ;MIDI CONTROLLER SYNCHRONISATION
#define CONTROLLER(NAME'NUMBER'MIN'MAX)
        #
        k$NAME          ctrl7           1,$NUMBER,0,1           ;READ MIDI CONTROLLER
        ktrig$NAME      changed         k$NAME                  ;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
        k$NAME          scale           k$NAME, $MAX, $MIN      ;VARIBALE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
        FLsetVal        ktrig$NAME,     k$NAME, gih$NAME                ;UPDATE FLTK VALUATOR IF MIDI CONTROLLER HAS BEEN MOVED
        #
        ;           NAME    NUM    MIN MAX
        $CONTROLLER(gap'     1 '     0' 5)
        $CONTROLLER(size'    2 '0.0001' 1)
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	aL,aR	monitor
	;	OPCODE	FILENAME               | FORMAT | OUT1  | OUT2 etc...
		fout	"GranuleOutput.wav",     8,        aL,     aR	; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
</CsScore>

</CsoundSynthesizer>