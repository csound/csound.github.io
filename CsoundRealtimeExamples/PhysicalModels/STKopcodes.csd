STKopcodes.csd
Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 1
0dbfs = 1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;		LABEL         | WIDTH | HEIGHT | X | Y
	FLpanel	"STK opcodes",   200,    425,    0,  0

;COUNTERS					     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkopcode, ihopcode		FLcount  	"opcode:", 	1,     27,   1,       1,     2,     100,      25,  50, 10,   -1 

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihOpcodeName		 	FLbox  	"", 	1,      1,     14,    100,    12,    50, 55

;VALUE BOXES				MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkv1, gihv1	FLtext		"", 	-1000,1000, 0.01,    1,    160,     20,   20,   75
gkv2, gihv2	FLtext		"", 	-1000,1000, 0.01,    1,    160,     20,   20,  125
gkv3, gihv3	FLtext		"", 	-1000,1000, 0.01,    1,    160,     20,   20,  175
gkv4, gihv4	FLtext		"", 	-1000,1000, 0.01,    1,    160,     20,   20,  225
gkv5, gihv5	FLtext		"", 	-1000,1000, 0.01,    1,    160,     20,   20,  275
gkv6, gihv6	FLtext		"", 	-1000,1000, 0.01,    1,    160,     20,   20,  325
gkv7, gihv7	FLtext		"", 	-1000,1000, 0.01,    1,    160,     20,   20,  375

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	   50, 	gihv1
		FLsetVal_i	   50, 	gihv2
		FLsetVal_i	   50, 	gihv3
		FLsetVal_i	   50, 	gihv4
		FLsetVal_i	   50, 	gihv5
		FLsetVal_i	   50, 	gihv6
		FLsetVal_i	   50, 	gihv7
		FLsetVal_i	   21, 	ihopcode

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,     500,   212, 0
				FLscroll     515,     500,   0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          STK Opcodes                        ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The STK opcodes are a family of 27 opcodes that implement    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Perry Cooks Synthesis Tool Kit. Selecting opcode number from ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"the counter will change the opcode chosen. The opcode name   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"will be displayed beneath the counter.                       ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Different opcodes used a different range of input arguments  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"so the GUI adapts with each choice to reflect this.          ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Further information on these opcodes can be found at:        ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"https://ccrma.stanford.edu/software/stk/classes.html         ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"Further information on individual opcodes:                   ", 	1,      7,     14,    490,    20,     5, 220
ih		 	FLbox  	"STKBandedWG                                                  ", 	1,      6,     14,    490,    20,     5, 240
ih		 	FLbox  	"This opcode uses banded waveguide techniques to model a      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"variety of sounds, including bowed bars, glasses, and bowls. ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"Instrument presets:                                          ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"0=uniform bar 1=tuned bar 2=glass harmonica 3=Tibetan bowl   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"STKBeeThree                                                  ", 	1,      6,     14,    490,    20,     5, 360
ih		 	FLbox  	"This opcode a simple 4 operator topology, also referred to as", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"algorithm 8 of the TX81Z. It simulates the sound of a        ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Hammond-oid organ, and some related sounds.                  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"STKBlowBotl                                                  ", 	1,      6,     14,    490,    20,     5, 460
ih		 	FLbox  	"This opcode implements a helmholtz resonator (biquad filter) ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"with a polynomial jet excitation (a la Cook).                ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"STKBlowBotl                                                  ", 	1,      6,     14,    490,    20,     5, 540
ih		 	FLbox  	"This opcode is based on the clarinet model, with the addition", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"of a two-port register hole and a three-port dynamic tonehole", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"implementation.                                              ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"In this implementation, the distances between the            ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"reed/register hole and tonehole/bell are fixed. As a result, ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"both the tonehole and register hole will have variable       ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"influence on the playing frequency, which is dependent on the", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"length of the air column. In addition, the highest playing   ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"frequency is limited by these fixed lengths.                 ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"STKBowed                                                     ", 	1,      6,     14,    490,    20,     5, 760
ih		 	FLbox  	"STKBowed is a bowed string instrument, using a waveguide     ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"model.                                                       ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"STKBrass                                                     ", 	1,      6,     14,    490,    20,     5, 840
ih		 	FLbox  	"STKBrass uses a simple brass instrument waveguide model, a la", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"Cook.                                                        ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"STKClarinet                                                  ", 	1,      6,     14,    490,    20,     5, 920
ih		 	FLbox  	"STKClarinet uses a simple clarinet physical model.           ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"STKDrummer                                                   ", 	1,      6,     14,    490,    20,     5, 980
ih		 	FLbox  	"STKDrummer is a drum sampling synthesizer using raw waves and", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"one-pole filters, The drum rawwave files are sampled at      ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"22050 Hz, but will be appropriately interpolated for other   ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"sample rates.                                                ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"STKFlute                                                     ", 	1,      6,     14,    490,    20,     5,1100
ih		 	FLbox  	"STKFlute uses a simple flute physical model. The jet model   ", 	1,      5,     14,    490,    20,     5,1120
ih		 	FLbox  	"uses a polynomial, a la Cook.                                ", 	1,      5,     14,    490,    20,     5,1140
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1160
ih		 	FLbox  	"STKFMVoices                                                  ", 	1,      6,     14,    490,    20,     5,1180
ih		 	FLbox  	"STKFMVoices is a singing FM synthesis instrument. It has 3   ", 	1,      5,     14,    490,    20,     5,1200
ih		 	FLbox  	"carriers and a common modulator, also referred to as         ", 	1,      5,     14,    490,    20,     5,1220
ih		 	FLbox  	"algorithm 6 of the TX81Z.                                    ", 	1,      5,     14,    490,    20,     5,1240
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1260
ih		 	FLbox  	"STKHevyMetl                                                  ", 	1,      6,     14,    490,    20,     5,1280
ih		 	FLbox  	"STKHevyMetl produces metal sounds, using FM synthesis. It    ", 	1,      5,     14,    490,    20,     5,1300
ih		 	FLbox  	"uses 3 cascade operators with feedback modulation, also      ", 	1,      5,     14,    490,    20,     5,1320
ih		 	FLbox  	"referred to as algorithm 3 of the TX81Z.                     ", 	1,      5,     14,    490,    20,     5,1340
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1360
ih		 	FLbox  	"STKMandolin                                                  ", 	1,      6,     14,    490,    20,     5,1380
ih		 	FLbox  	"STKMandolin produces mandolin-like sounds, using 'commuted   ", 	1,      5,     14,    490,    20,     5,1400
ih		 	FLbox  	"synthesis' techniques to model a mandolin instrument.        ", 	1,      5,     14,    490,    20,     5,1420
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1440
ih		 	FLbox  	"STKModalBar                                                  ", 	1,      6,     14,    490,    20,     5,1460
ih		 	FLbox  	"This opcode is a resonant bar instrument.It has a number of  ", 	1,      5,     14,    490,    20,     5,1480
ih		 	FLbox  	"different struck bar instruments.                            ", 	1,      5,     14,    490,    20,     5,1500
ih		 	FLbox  	"Instrument presets:                                          ", 	1,      5,     14,    490,    20,     5,1520
ih		 	FLbox  	"0=marimba 1=vibraphone 2=agogo 3=wood1 4=reso 5=wood2        ", 	1,      5,     14,    490,    20,     5,1540
ih		 	FLbox  	"6=beats 7=two fixed 8=clump                                  ", 	1,      5,     14,    490,    20,     5,1560
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1580
ih		 	FLbox  	"STKMoog                                                      ", 	1,      6,     14,    490,    20,     5,1600
ih		 	FLbox  	"STKMoog produces moog-like swept filter sounds, using one    ", 	1,      5,     14,    490,    20,     5,1620
ih		 	FLbox  	"attack wave, one looped wave, and an ADSR envelope and adds  ", 	1,      5,     14,    490,    20,     5,1640
ih		 	FLbox  	"two sweepable formant filters.                               ", 	1,      5,     14,    490,    20,     5,1660
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1680
ih		 	FLbox  	"STKPercFlut                                                  ", 	1,      6,     14,    490,    20,     5,1700
ih		 	FLbox  	"STKPercFlut is a percussive flute FM synthesis instrument.   ", 	1,      5,     14,    490,    20,     5,1720
ih		 	FLbox  	"The instrument uses an algorithm like the algorithm 4 of the ", 	1,      5,     14,    490,    20,     5,1740
ih		 	FLbox  	"TX81Z.                                                       ", 	1,      5,     14,    490,    20,     5,1760
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1780
ih		 	FLbox  	"STKPlucked                                                   ", 	1,      6,     14,    490,    20,     5,1800
ih		 	FLbox  	"STKPlucked uses a plucked string physical model based on the ", 	1,      5,     14,    490,    20,     5,1820
ih		 	FLbox  	"Karplus-Strong algorithm.                                    ", 	1,      5,     14,    490,    20,     5,1840
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1860
ih		 	FLbox  	"STKResonate                                                  ", 	1,      6,     14,    490,    20,     5,1880
ih		 	FLbox  	"STKResonate is a noise driven formant filter. This instrument", 	1,      5,     14,    490,    20,     5,1900
ih		 	FLbox  	"contains a noise source, which excites a biquad resonance    ", 	1,      5,     14,    490,    20,     5,1920
ih		 	FLbox  	"filter, with volume controlled by an ADSR.                   ", 	1,      5,     14,    490,    20,     5,1940
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1960
ih		 	FLbox  	"STKRhodey                                                    ", 	1,      6,     14,    490,    20,     5,1980
ih		 	FLbox  	"STKRhodey is a Fender Rhodes-like electric piano FM synthesis", 	1,      5,     14,    490,    20,     5,2000
ih		 	FLbox  	"instrument. This opcode implements an instrument based on two", 	1,      5,     14,    490,    20,     5,2020
ih		 	FLbox  	"simple FM Pairs summed together, also referred to as         ", 	1,      5,     14,    490,    20,     5,2040
ih		 	FLbox  	"algorithm 5 of the Yamaha TX81Z. It simulates the sound of a ", 	1,      5,     14,    490,    20,     5,2060
ih		 	FLbox  	"Rhodes electric piano, and some related sounds.              ", 	1,      5,     14,    490,    20,     5,2080
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,2100
ih		 	FLbox  	"STKSaxofony                                                  ", 	1,      6,     14,    490,    20,     5,2120
ih		 	FLbox  	"STKSaxofony is a faux conical bore reed instrument. This     ", 	1,      5,     14,    490,    20,     5,2140
ih		 	FLbox  	"opcode uses a 'hybrid' digital waveguide instrument that can ", 	1,      5,     14,    490,    20,     5,2160
ih		 	FLbox  	"generate a variety of wind-like sounds. It has also been     ", 	1,      5,     14,    490,    20,     5,2180
ih		 	FLbox  	"referred to as the 'blowed string' model. The waveguide      ", 	1,      5,     14,    490,    20,     5,2200
ih		 	FLbox  	"section is essentially that of a string, with one rigid and  ", 	1,      5,     14,    490,    20,     5,2220
ih		 	FLbox  	"one lossy termination. The non-linear function is a reed     ", 	1,      5,     14,    490,    20,     5,2240
ih		 	FLbox  	"table. The string can be 'blown' at any point between the    ", 	1,      5,     14,    490,    20,     5,2260
ih		 	FLbox  	"terminations, though just as with strings, it is impossible  ", 	1,      5,     14,    490,    20,     5,2280
ih		 	FLbox  	"to excite the system at either end. If the excitation is     ", 	1,      5,     14,    490,    20,     5,2300
ih		 	FLbox  	"placed at the string mid-point, the sound is that of a       ", 	1,      5,     14,    490,    20,     5,2320
ih		 	FLbox  	"clarinet. At points closer to the 'bridge', the sound is     ", 	1,      5,     14,    490,    20,     5,2340
ih		 	FLbox  	"closer to that of a saxophone.                               ", 	1,      5,     14,    490,    20,     5,2360
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,2380
ih		 	FLbox  	"STKShakers                                                   ", 	1,      6,     14,    490,    20,     5,2400
ih		 	FLbox  	"STKShakers are a set of PhISEM and PhOLIES instruments:      ", 	1,      5,     14,    490,    20,     5,2420
ih		 	FLbox  	"PhISEM (Physically Informed Stochastic Event Modeling) is an ", 	1,      5,     14,    490,    20,     5,2440
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,      5,     14,    490,    20,     5,2460
ih		 	FLbox  	"independent sound producing objects. It can simulate a       ", 	1,      5,     14,    490,    20,     5,2480
ih		 	FLbox  	"Maraca, Sekere, Cabasa, Bamboo Wind Chimes, Water Drops,     ", 	1,      5,     14,    490,    20,     5,2500
ih		 	FLbox  	"Tambourine, Sleighbells, and a Guiro. On:                    ", 	1,      5,     14,    490,    20,     5,2520
ih		 	FLbox  	"http://soundlab.cs.princeton.edu/research/controllers/shakers/", 	1,      5,     14,    490,    20,     5,2540
ih		 	FLbox  	"PhOLIES (Physically-Oriented Library of Imitated             ", 	1,      5,     14,    490,    20,     5,2560
ih		 	FLbox  	"Environmental Sounds) there is a similar approach for the    ", 	1,      5,     14,    490,    20,     5,2580
ih		 	FLbox  	"synthesis of environmental sounds. It simulates of breaking  ", 	1,      5,     14,    490,    20,     5,2600
ih		 	FLbox  	"sticks, crunchy snow (or not), a wrench, sandpaper, and more.", 	1,      5,     14,    490,    20,     5,2620
ih		 	FLbox  	"Instrument selection:                                        ", 	1,      5,     14,    490,    20,     5,2640
ih		 	FLbox  	"Maraca=0 Cabasa=1 Sekere=2 Guiro=3 Water Drops=4             ", 	1,      5,     14,    490,    20,     5,2660
ih		 	FLbox  	"Bamboo Chimes=5 Tambourine=6 Sleigh Bells=7 Sticks=8,        ", 	1,      5,     14,    490,    20,     5,2680
ih		 	FLbox  	"Crunch=9 Wrench=10, Sand Paper=11 Coke Can=12 Next Mug=13    ", 	1,      5,     14,    490,    20,     5,2700
ih		 	FLbox  	"Penny+Mug=14 Nickle+Mug=15 Dime+Mug=16 Quarter+Mug=17        ", 	1,      5,     14,    490,    20,     5,2720
ih		 	FLbox  	"Franc+Mug=18 Peso+Mug=19 Big Rocks=20 Little Rocks=21        ", 	1,      5,     14,    490,    20,     5,2740
ih		 	FLbox  	"Tuned Bamboo Chimes=22                                       ", 	1,      5,     14,    490,    20,     5,2760
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,2780
ih		 	FLbox  	"STKSimple                                                    ", 	1,      6,     14,    490,    20,     5,2800
ih		 	FLbox  	"STKSimple is a wavetable/noise instrument. It combines a     ", 	1,      5,     14,    490,    20,     5,2820
ih		 	FLbox  	"looped wave, a noise source, a biquad resonance filter, a    ", 	1,      5,     14,    490,    20,     5,2840
ih		 	FLbox  	"one-pole filter, and an ADSR envelope to create some         ", 	1,      5,     14,    490,    20,     5,2860
ih		 	FLbox  	"interesting sounds.                                          ", 	1,      5,     14,    490,    20,     5,2880
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,2900
ih		 	FLbox  	"STKSitar                                                     ", 	1,      6,     14,    490,    20,     5,2920
ih		 	FLbox  	"STKSitar uses a plucked string physical model based on the   ", 	1,      5,     14,    490,    20,     5,2940
ih		 	FLbox  	"Karplus-Strong algorithm.                                    ", 	1,      5,     14,    490,    20,     5,2960
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,2980
ih		 	FLbox  	"STKStifKarp                                                  ", 	1,      6,     14,    490,    20,     5,3000
ih		 	FLbox  	"STKStifKarp is a plucked stiff string instrument. It a simple", 	1,      5,     14,    490,    20,     5,3020
ih		 	FLbox  	"plucked string algorithm (Karplus Strong) with enhancements, ", 	1,      5,     14,    490,    20,     5,3040
ih		 	FLbox  	"including string stiffness and pluck position controls. The  ", 	1,      5,     14,    490,    20,     5,3060
ih		 	FLbox  	"stiffness is modeled with allpass filters.                   ", 	1,      5,     14,    490,    20,     5,3080
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,3100
ih		 	FLbox  	"STKTubeBell                                                  ", 	1,      6,     14,    490,    20,     5,3120
ih		 	FLbox  	"STKTubeBell is a tubular bell (orchestral chime) FM synthesis", 	1,      5,     14,    490,    20,     5,3140
ih		 	FLbox  	"instrument. It uses two simple FM Pairs summed together, also", 	1,      5,     14,    490,    20,     5,3160
ih		 	FLbox  	"referred to as algorithm 5 of the TX81Z.                     ", 	1,      5,     14,    490,    20,     5,3180
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,3200
ih		 	FLbox  	"STKVoicForm                                                  ", 	1,      6,     14,    490,    20,     5,3220
ih		 	FLbox  	"STKVoicForm is a four formant synthesis instrument. This     ", 	1,      5,     14,    490,    20,     5,3240
ih		 	FLbox  	"instrument contains an excitation singing wavetable (looping ", 	1,      5,     14,    490,    20,     5,3260
ih		 	FLbox  	"wave with random and periodic vibrato, smoothing on          ", 	1,      5,     14,    490,    20,     5,3280
ih		 	FLbox  	"frequency, etc.), excitation noise, and four sweepable       ", 	1,      5,     14,    490,    20,     5,3300
ih		 	FLbox  	"complex resonances. Measured formant data is included, and   ", 	1,      5,     14,    490,    20,     5,3320
ih		 	FLbox  	"enough data is there to support either parallel or cascade   ", 	1,      5,     14,    490,    20,     5,3340
ih		 	FLbox  	"synthesis. In the floating point case cascade synthesis is   ", 	1,      5,     14,    490,    20,     5,3360
ih		 	FLbox  	"the most natural so that's what you'll find here.            ", 	1,      5,     14,    490,    20,     5,3380
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,3400
ih		 	FLbox  	"STKWhistle                                                   ", 	1,      6,     14,    490,    20,     5,3420
ih		 	FLbox  	"STKWhistle produces (police) whistle sounds. It uses a hybrid", 	1,      5,     14,    490,    20,     5,3440
ih		 	FLbox  	"physical/spectral model of a police whistle (a la Cook).     ", 	1,      5,     14,    490,    20,     5,3460
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,3480
ih		 	FLbox  	"STKWurley                                                    ", 	1,      6,     14,    490,    20,     5,3500
ih		 	FLbox  	"STKWurley simulates a Wurlitzer electric piano FM synthesis  ", 	1,      5,     14,    490,    20,     5,3520
ih		 	FLbox  	"instrument. It uses two simple FM Pairs summed together, also", 	1,      5,     14,    490,    20,     5,3540
ih		 	FLbox  	"referred to as algorithm 5 of the TX81Z.                     ", 	1,      5,     14,    490,    20,     5,3560
				FLscroll_end                                                                                                      
				FLpanel_end                                                                                                       
                                                                                                                                                  
				FLrun	;RUN THE FLTK WIDGET THREAD                                                                               
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                      
                                                                                                                                                  
instr 	1	;SOUND PRODUCING INSTRUMENT                                                                                                      
	icps	cpsmidi		;READ IN MIDI NOTE IN CYCLES PER SECOND                                                                          
	iamp	ampmidi	1	;READ IN MIDI VELOCITY (RANGE 0 - 1)                                                                             
	ktrig	changed	gkopcode;IF OPCODE COUNTER IS CHANGED GENERATE A '1'                                                                     
	if ktrig==1 then	;IF TRIGGER IS RECEIVED...                                                                                       
	 reinit UPDATE		;.. REINITIALISE FROM LABEL 'UPDATE'                                                                             
	endif			;END OF CONDITIONAL BEANCH                                                                                       
	UPDATE:			;LABEL CALLED 'UPDATE'. REINITIALISATION BEGINS FROM HERE                                                        
	;CHOOSE OPCODE ACCORDING TO CHOICE OF OPCODE COUNTER                                                                                     
	if gkopcode==1 then                                                                                                                      
	 asig	STKBandedWG 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 64, gkv5, 128, gkv5, 16, gkv7                               
	elseif gkopcode==2 then                                                                                                                  
	 asig	STKBeeThree	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5                                                   
	elseif gkopcode==3 then                                                                                                                  
	 asig	STKBlowBotl 	icps, iamp,     4, gkv1, 11, gkv2, 1, gkv3, 128, gkv4                                                            
	elseif gkopcode==4 then                                                                                                                  
	 asig	STKBlowHole	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5                                                   
	elseif gkopcode==5 then                                                                                                                  
	 asig	STKBowed 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5                                                   
	elseif gkopcode==6 then                                                                                                                  
	 asig	STKBrass 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==7 then
	 asig	STKClarinet 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==8 then
	 asig	STKDrummer 	icps, iamp
	elseif gkopcode==9 then
	 asig	STKFlute 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==10 then
	 asig	STKFMVoices 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==11 then
	 asig	STKHevyMetl 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==12 then
	 asig	STKMandolin 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==13 then
	 asig	STKModalBar 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 8, gkv5, 16, gkv6
	elseif gkopcode==14 then
	 asig	STKMoog 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==15 then
	 asig	STKPercFlut 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==16 then
	 asig	STKPlucked 	icps, iamp
	elseif gkopcode==17 then
	 asig	STKResonate 	icps, iamp,     2, gkv1, 4, gkv2, 1, gkv3, 11, gkv4, 128, gkv5
	elseif gkopcode==18 then
	 asig	STKRhodey	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==19 then
	 asig	STKSaxofony	icps, iamp,     2, gkv1, 4, gkv2, 26, gkv3, 11, gkv4, 1, gkv5, 29, gkv6
	elseif gkopcode==20 then
	 asig	STKShakers 	icps, iamp,     2, gkv1, 4, gkv2, 128, gkv3, 11, gkv4, 1, gkv5, 1071, gkv6
	elseif gkopcode==21 then
	 asig	STKSimple	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 128, gkv4
	elseif gkopcode==22 then
	 asig	STKSitar 	icps, iamp
	elseif gkopcode==23 then
	 asig	STKStifKarp 	icps, iamp,     4, gkv1, 11, gkv2, 1, gkv3
	elseif gkopcode==24 then
	 asig	STKTubeBell 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	elseif gkopcode==25 then
	 asig	STKVoicForm 	icps, iamp,     2, gkv1, 4, gkv2, 128, gkv3, 1, gkv4, 11, gkv5
	elseif gkopcode==26 then
	 asig	STKWhistle 	icps, iamp,     4, gkv1, 11, gkv2, 1, gkv3, 2, gkv4, 128, gkv5
	elseif gkopcode==27 then
	 asig	STKWurley 	icps, iamp,     2, gkv1, 4, gkv2, 11, gkv3, 1, gkv4, 128, gkv5
	endif
		out	asig
endin

instr	2	;CHANGE GUI OPCODE NAME LABEL AND PRESET VALUES
	ktrig	changed	gkopcode	;IF OPCODE COUNTER IS CHANGED GENERATE A '1'             
	if ktrig==1 then                ;IF TRIGGER IS RECEIVED...                               
	 reinit	UPDATE                  ;.. REINITIALISE FROM LABEL 'UPDATE'                     
	endif                           ;END OF CONDITIONAL BEANCH                               
	UPDATE:                         ;LABEL CALLED 'UPDATE'. REINITIALISATION BEGINS FROM HERE
	;SET OPCODE NAME LABEL AND PARAMETER VALUE PRESETS ACCORDING TO OPCODE COUNTER SETTING
	if i(gkopcode)==1 then
	 ;SET OPCODE NAME
	 FLsetText "STKBandedWQ", gihOpcodeName
	 ;SHOW VALUE INPUT BOXES...
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLshow	gihv6
	 FLshow	gihv7
	 ;SET INITIAL VALUES...
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	100, 	gihv3
	 FLsetVal_i	100, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetVal_i	100, 	gihv6
	 FLsetVal_i	100, 	gihv7
	 ;SET VALUE INPUT BOX LABELS...
	 FLsetText 	"Bow Pressure",	gihv1
	 FLsetText 	"Bow Motion",	gihv2
	 FLsetText 	"LFO Speed",	gihv3
	 FLsetText 	"LFO Depth",	gihv4
	 FLsetText 	"Bow Velocity",	gihv5
	 FLsetText 	"Bow Strike",	gihv6
	 FLsetText 	"Instrument",	gihv7
	elseif i(gkopcode)==2 then
	 FLsetText "STKBeeThree", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	10, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Feedback Gain Operator 4",	gihv1
	 FLsetText 	"Gain Operator 3",		gihv2
	 FLsetText 	"LFO Speed",	gihv3
	 FLsetText 	"LFO Depth",	gihv4
	 FLsetText 	"ADSR 2 & 4",	gihv5
	elseif i(gkopcode)==3 then
	 FLsetText "STKBlowBotl", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLhide	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	10, 	gihv1
	 FLsetVal_i	0, 	gihv2
	 FLsetVal_i	0, 	gihv3
	 FLsetVal_i	75, 	gihv4
	 FLsetText 	"Noise Gain",	gihv1
	 FLsetText 	"LFO Speed",	gihv2
	 FLsetText 	"LFO Depth",	gihv3
	 FLsetText 	"Volume",	gihv4
	elseif i(gkopcode)==4 then
	 FLsetText "STKBlowHole", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	10, 	gihv3
	 FLsetVal_i	1, 	gihv4
	 FLsetVal_i	90, 	gihv5
	 FLsetText 	"Reed Stiffness",	gihv1
	 FLsetText 	"Noise Gain",		gihv2
	 FLsetText 	"State of Tonehole",	gihv3
	 FLsetText 	"State of Register",	gihv4
	 FLsetText 	"Breath Pressure",	gihv5
	elseif i(gkopcode)==5 then
	 FLsetText "STKBowed", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	10, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	1, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Bow Pressure",	gihv1
	 FLsetText 	"Bow Pressure",	gihv2
	 FLsetText 	"LFO Speed",	gihv3
	 FLsetText 	"LFO Depth",	gihv4
	 FLsetText 	"Volume",	gihv5
	elseif i(gkopcode)==6 then
	 FLsetText "STKBrass", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	80, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	10, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Lip Tension",	gihv1
	 FLsetText 	"Slide Length",	gihv2
	 FLsetText 	"LFO Speed",	gihv3
	 FLsetText 	"LFO Depth",	gihv4
	 FLsetText 	"Volume",	gihv5
	elseif i(gkopcode)==7 then
	 FLsetText "STKClarinet", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	10, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	30, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Reed Stiffness",	gihv1
	 FLsetText 	"Noise Gain",	gihv2
	 FLsetText 	"LFO Speed",	gihv3
	 FLsetText 	"LFO Depth",	gihv4
	 FLsetText 	"Breath Pressure",	gihv5
	elseif i(gkopcode)==8 then
	 FLsetText "STKDrummer", gihOpcodeName
	 FLhide	gihv1
	 FLhide	gihv2
	 FLhide	gihv3
	 FLhide	gihv4
	 FLhide	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	elseif i(gkopcode)==9 then
	 FLsetText "STKFlute", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	50, 	gihv1
	 FLsetVal_i	20, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Jet Delay",	gihv1
	 FLsetText 	"Noise Gain",	gihv2
	 FLsetText 	"LFO Speed",	gihv3
	 FLsetText 	"LFO Depth",	gihv4
	 FLsetText 	"Breath Pressure",	gihv5
	elseif i(gkopcode)==10 then
	 FLsetText "STKFMVoices", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	50, 	gihv1
	 FLsetVal_i	10, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Vowel",	gihv1
	 FLsetText 	"Spectral Tilt",	gihv2
	 FLsetText 	"LFO Speed",	gihv3
	 FLsetText 	"LFO Depth",	gihv4
	 FLsetText 	"ADSR 2 and 4 Target",	gihv5
	elseif i(gkopcode)==11 then
	 FLsetText "STKHevyMetl", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	80, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	80, 	gihv5
	 FLsetText 	"Total Modulator Index",gihv1
	 FLsetText 	"Crossfade of Modulator",gihv2
	 FLsetText 	"LFO Speed",		gihv3
	 FLsetText 	"LFO Depth",		gihv4
	 FLsetText 	"ADSR 2 and 4 Target",	gihv5
	elseif i(gkopcode)==12 then
	 FLsetText "STKMandolin", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	80, 	gihv1
	 FLsetVal_i	10, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	90, 	gihv5
	 FLsetText 	"Size of Body",gihv1
	 FLsetText 	"Pluck Position",gihv2
	 FLsetText 	"String Sustain",		gihv3
	 FLsetText 	"String Detuning",		gihv4
	 FLsetText 	"Position of Microphone",	gihv5	 
	elseif i(gkopcode)==13 then
	 FLsetText "STKModalBar", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLshow	gihv6
	 FLshow	gihv7
	 FLsetVal_i	50, 	gihv1
	 FLsetVal_i	10, 	gihv2
	 FLsetVal_i	30, 	gihv3
	 FLsetVal_i	0, 	gihv4
	 FLsetVal_i	0, 	gihv5
	 FLsetVal_i	100, 	gihv6
	 FLsetVal_i	3, 	gihv7
	 FLsetText 	"Hardness of the Stick",			gihv1
	 FLsetText 	"Stick Position",		gihv2
	 FLsetText 	"Speed of LFO",		gihv3
	 FLsetText 	"Depth of LFO",		gihv4
	 FLsetText 	"Direct Stck Mix",	gihv5	 
	 FLsetText 	"Volume",	gihv6	 
	 FLsetText 	"Instrument Presets",	gihv7
	elseif i(gkopcode)==14 then
	 FLsetText "STKMoog", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	40, 	gihv3
	 FLsetVal_i	1, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Q Filter",		gihv1
	 FLsetText 	"Rate of Filter Sweep",	gihv2
	 FLsetText 	"Speed of LFO",		gihv3
	 FLsetText 	"Depth of LFO",		gihv4
	 FLsetText 	"Volume",		gihv5
	elseif i(gkopcode)==15 then
	 FLsetText "STKPercFlut", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	30, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Total Modulator Index",	gihv1
	 FLsetText 	"Crossfade of Modulator",	gihv2
	 FLsetText 	"Speed of LFO",			gihv3
	 FLsetText 	"Depth of LFO",			gihv4
	 FLsetText 	"ADSR 2 and 4 Target",		gihv5
	elseif i(gkopcode)==16 then
	 FLsetText "STKPlucked", gihOpcodeName
	 FLhide	gihv1
	 FLhide	gihv2
	 FLhide	gihv3
	 FLhide	gihv4
	 FLhide	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	elseif i(gkopcode)==17 then
	 FLsetText "STKResonate", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	1, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	11, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	90, 	gihv5
	 FLsetText 	"Frequency of Resonance",	gihv1
	 FLsetText 	"Pole Radii",			gihv2
	 FLsetText 	"Notch Frequency",		gihv3
	 FLsetText 	"Zero Radii",			gihv4
	 FLsetText 	"Gain of Envelope",		gihv5
	elseif i(gkopcode)==18 then
	 FLsetText "STKRhodey", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	10, 	gihv1
	 FLsetVal_i	50, 	gihv2
	 FLsetVal_i	30, 	gihv3
	 FLsetVal_i	50, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Modulator Index 1",	gihv1
	 FLsetText 	"Crossfade of Outputs",	gihv2
	 FLsetText 	"LFO Speed",		gihv3
	 FLsetText 	"LFO Depth",		gihv4
	 FLsetText 	"ADSR 2 and 4 Target",	gihv5
	elseif i(gkopcode)==19 then
	 FLsetText "STKSaxofony", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLshow	gihv6
	 FLshow	gihv7
	 FLsetVal_i	10, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	100, 	gihv3
	 FLsetVal_i	50, 	gihv4
	 FLsetVal_i	20, 	gihv5
	 FLsetVal_i	10, 	gihv6
	 FLsetVal_i	100, 	gihv7
	 FLsetText 	"Stiffness of Reed",	gihv1
	 FLsetText 	"Reed Aperture",	gihv2
	 FLsetText 	"Blow Position",	gihv3
	 FLsetText 	"Noise Gain",		gihv4
	 FLsetText 	"LFO Speed",		gihv5
	 FLsetText 	"LFO Depth",		gihv6
	 FLsetText 	"Breath Pressure",	gihv7
	elseif i(gkopcode)==20 then
	 FLsetText "STKShakers", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLshow	gihv6
	 FLhide	gihv7
	 FLsetVal_i	10, 	gihv1
	 FLsetVal_i	10, 	gihv2
	 FLsetVal_i	80, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	112, 	gihv5
	 FLsetVal_i	1, 	gihv6
	 FLsetText 	"Shake Energy",		gihv1
	 FLsetText 	"System Decay",		gihv2
	 FLsetText 	"Shake Energy",		gihv3
	 FLsetText 	"Number of Objects",	gihv4
	 FLsetText 	"Resonance Frequency",	gihv5
	 FLsetText 	"instrument selection",		gihv6
	elseif i(gkopcode)==21 then
	 FLsetText "STKSimple", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLhide	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	100, 	gihv3
	 FLsetVal_i	100, 	gihv4
	 FLsetText 	"Position of Filter Pole",	gihv1
	 FLsetText 	"Noise/Pitched Crossfade",	gihv2
	 FLsetText 	"Rate of Envelope",	gihv3
	 FLsetText 	"Gain",		gihv4
	elseif i(gkopcode)==22 then
	 FLsetText "STKSitar", gihOpcodeName
	 FLhide	gihv1
	 FLhide	gihv2
	 FLhide	gihv3
	 FLhide	gihv4
	 FLhide	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	elseif i(gkopcode)==23 then
	 FLsetText "STKStifKarp", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLhide	gihv4
	 FLhide	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	100, 	gihv2
	 FLsetVal_i	100, 	gihv3
	 FLsetText 	"Pickup Position",	gihv1
	 FLsetText 	"String Sustain",	gihv2
	 FLsetText 	"String Stretch",	gihv3
	elseif i(gkopcode)==24 then
	 FLsetText "STKTubeBell", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	50, 	gihv1
	 FLsetVal_i	10, 	gihv2
	 FLsetVal_i	50, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Modulator Index 1",	gihv1
	 FLsetText 	"Crossfade of Outputs",	gihv2
	 FLsetText 	"LFO Speed",		gihv3
	 FLsetText 	"LFO Depth",		gihv4
	 FLsetText 	"ADSR 2 and 4 Target",	gihv5
	elseif i(gkopcode)==25 then
	 FLsetText "STKVoicForm", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	10, 	gihv1
	 FLsetVal_i	1, 	gihv2
	 FLsetVal_i	100, 	gihv3
	 FLsetVal_i	1, 	gihv4
	 FLsetVal_i	1, 	gihv5
	 FLsetText 	"Voiced/Unvoiced Mix",		gihv1
	 FLsetText 	"Vowel/Phoneme Selection",	gihv2
	 FLsetText 	"LFO Speed",			gihv3
	 FLsetText 	"LFO Depth",			gihv4
	 FLsetText 	"Loudness (Spectral Tilt)",	gihv5
	elseif i(gkopcode)==26 then
	 FLsetText "STKWhistle", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	0, 	gihv2
	 FLsetVal_i	40, 	gihv3
	 FLsetVal_i	10, 	gihv4
	 FLsetVal_i	100, 	gihv5
	 FLsetText 	"Blowing Frequency Modulation",	gihv1
	 FLsetText 	"Noise Gain",			gihv2
	 FLsetText 	"Fipple Modulation Frequency",	gihv3
	 FLsetText 	"Fipple Modulation Gain",	gihv4
	 FLsetText 	"Volume",			gihv5
	else
	 FLsetText "STKWurley", gihOpcodeName
	 FLshow	gihv1
	 FLshow	gihv2
	 FLshow	gihv3
	 FLshow	gihv4
	 FLshow	gihv5
	 FLhide	gihv6
	 FLhide	gihv7
	 FLsetVal_i	100, 	gihv1
	 FLsetVal_i	10, 	gihv2
	 FLsetVal_i	30, 	gihv3
	 FLsetVal_i	100, 	gihv4
	 FLsetVal_i	90, 	gihv5
	 FLsetText 	"Modulation Index 1",	gihv1
	 FLsetText 	"Crossfade of Outputs",	gihv2
	 FLsetText 	"LFO Speed",		gihv3
	 FLsetText 	"LFO Depth",		gihv4
	 FLsetText 	"ADSR 2 and 4 Target",	gihv5
	endif
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;UPDATE OPCODE NAME LABEL AND VALUE PRESETS
e
</CsScore>

</CsoundSynthesizer>

