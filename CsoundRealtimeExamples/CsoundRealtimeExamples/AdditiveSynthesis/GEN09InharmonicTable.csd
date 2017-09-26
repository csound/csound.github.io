;albert clock bell belfast
girtos21	ftgen	0,0,-22,-2, 2.043260,1.482916,1.000000,3.328848,4.761811,1.477056,0.612007,2.661295,1.002793,4.023776,0.254139,2.043916,4.032463,2.659438,4.775560,5.500494,3.331014,0.809697,2.391301, 0.254098,1.901476,2.366563    ;,0.614968,2.046543,1.814887,3.130744,2.484426,0.558874,0.801697,0.070870,3.617036,2.782656
GEN09InharmonicTable.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
;virtual midi device
-odac -M0 -+rtmidi=virtual -dm0

;external midi keyboard (recommended)
;-odac -M0 -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	64	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE==============================================================================================================================================================
FLcolor	255,255,255,255,255,50
;	LABEL                                      | WIDTH | HEIGHT | X | Y
FLpanel	"GEN09 pseudo-inharmonic function tables",    500,    375,    0,  0
	;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
	gksound, gihsound 			FLcount  "Sound", 	1,     21,     1,      1,      2,   100,     25,   25,   5,   0, 3, 0, 0
	;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	gihSoundName	 	FLbox  	"Loading. Please wait...",	1,      1,     12,    150,    20,     0,   45

	;SWITCHES                                			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
	gkChoOnOff,ihChoOnOff	FLbutton	"Chorus On/Off",	1,    0,    22,    120,     25,     2,325,  -1

	;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"", 			3,      5,     14,    490,    120,    5,   65
	ih		 	FLbox  	"Amplitude Envelope", 	1,     10,     14,    480,     20,   10,   70
	ih		 	FLbox  	"", 			3,      5,     14,    490,    120,    5,  190
	ih		 	FLbox  	"Filter Envelope", 	1,     10,     14,    480,     20,   10,  195

	;VALUE DISPLAY BOXES					WIDTH | HEIGHT |  X  |  Y
	idAatt			FLvalue	"",     		40,       17,    10,   160
	idAdec			FLvalue	"",     		40,       17,    60,   160
	idAsus			FLvalue	"",     		40,       17,   110,   160
	idArel			FLvalue	"",     		40,       17,   160,   160

	idFlev1			FLvalue	"",     		40,       17,    10,   285
	idFdec			FLvalue	"",     		40,       17,    60,   285
	idFsus			FLvalue	"",     		40,       17,   110,   285
	idFrel			FLvalue	"",     		40,       17,   160,   285
	idFshp			FLvalue	"",     		40,       17,   210,   285

	FLlabel 11, 1, 3, 0, 0, 0	;REDUCE LABEL SIZE
	;KNOBS									MIN   | MAX | EXP|  TYPE | DISP  | WIDTH | X | Y
	gkAatt, gihAatt		FLknob		"Attack Time",			0.001,  20,   -1,    1,    idAatt,    40,  10,  95             
	gkAdec, gihAdec		FLknob		"Decay Time",			0.01,   20,   -1,    1,    idAdec,    40,  60,  95             
	gkAsus, gihAsus		FLknob		"Sustain",			0,      1,     0,    1,    idAsus,    40, 110,  95             
	gkArel, gihArel		FLknob		"Release",			0.01,   20,   -1,    1,    idArel,    40, 160,  95             

	gkFlev1, gihFlev1	FLknob		"Level 1",			0,        1,   0,    1,    idFlev1,   40,  10, 220             
	gkFdec, gihFdec		FLknob		"Decay",			0.01,    20,  -1,    1,    idFdec,    40,  60, 220             
	gkFsus, gihFsus		FLknob		"Sustain",			0,        1,   0,    1,    idFsus,    40, 110, 220             
	gkFrel, gihFrel		FLknob		"Release",			0.01,    20,  -1,    1,    idFrel,    40, 160, 220             
	gkFshp, gihFshp		FLknob		"Shape",			-50,     50,   0,    1,    idFshp,    40, 210, 220             

	;SLIDERS				            			MIN  | MAX | EXP | TYPE | DISP      | WIDTH | HEIGHT | X | Y
	gkspeed, gihspeed	FLslider 	"Speed",			0.1,     2,  -1,   23,   -1,           120,    25,     125,325
	gkwidth, gihwidth	FLslider 	"Width",			1,       0,   0,   23,   -1,           120,    25,     250,325
	gkchomix, gihchomix	FLslider 	"Mix",				0,       1,   0,   23,   -1,           120,    25,     375,325 
	
	;SET INITIAL VALUES
	FLsetVal_i	4, 	gihsound
	FLsetVal_i	0.002, 	gihAatt
	FLsetVal_i	1.5, 	gihAdec                                                                                                                                 
	FLsetVal_i	0, 	gihAsus
	FLsetVal_i	1.5, 	gihArel
	FLsetVal_i	0.8, 	gihFlev1
	FLsetVal_i	1.5, 	gihFdec
	FLsetVal_i	0, 	gihFsus
	FLsetVal_i	1.5, 	gihFrel
	FLsetVal_i	-20, 	gihFshp
	FLsetVal_i	1, 	ihChoOnOff
	FLsetVal_i	0.5, 	gihspeed
	FLsetVal_i	1, 	gihwidth
	FLsetVal_i	1, 	gihchomix
	                                                     
FLpanel_end

	;INSTRUCTIONS AND INFO PANEL
	FLpanel	"", 512, 660, 512, 0
	FLscroll    512, 660, 0,   0
	;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"             Pseudo-inharmonic spectra (GEN09)               ", 	1,      5,     14,    490,    20,     5,    0
	ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,   20
	ih		 	FLbox  	"GEN09 is normally used to store single cycles of harmonic    ", 	1,      5,     14,    490,    20,     5,   40
	ih		 	FLbox  	"waveforms but it is possible to create imitations of         ", 	1,      5,     14,    490,    20,     5,   60
	ih		 	FLbox  	"inharmonic spectra by approximating the inharmonic partials  ", 	1,      5,     14,    490,    20,     5,   80
	ih		 	FLbox  	"as selected upper partials of a harmonic waveform and then   ", 	1,      5,     14,    490,    20,     5,  100
	ih		 	FLbox  	"scaling down the frequency of the oscillator that reads the  ", 	1,      5,     14,    490,    20,     5,  120
	ih		 	FLbox  	"table. The principle used here is that higher harmonic       ", 	1,      5,     14,    490,    20,     5,  140
	ih		 	FLbox  	"partials are closer together in terms of cycles per second   ", 	1,      5,     14,    490,    20,     5,  160                                                         
	ih		 	FLbox  	"than lower partials resulting in reduced rounding errors.    ", 	1,      5,     14,    490,    20,     5,  180
	ih		 	FLbox  	"This technique offers significant gains in real-time         ", 	1,      5,     14,    490,    20,     5,  200
	ih		 	FLbox  	"performance over the technique of representing each          ", 	1,      5,     14,    490,    20,     5,  220
	ih		 	FLbox  	"inharmonic partial with its own oscillator as just a single  ", 	1,      5,     14,    490,    20,     5,  240
	ih		 	FLbox  	"oscillator will be required and CPU load will be the same for", 	1,      5,     14,    490,    20,     5,  260
	ih		 	FLbox  	"a tone with many partials as for a tone with few partials.   ", 	1,      5,     14,    490,    20,     5,  280
	ih		 	FLbox  	"This example synthesizes the same sounds as the example      ", 	1,      5,     14,    490,    20,     5,  300
	ih		 	FLbox  	"'ModalAddSyn.csd' and should be compared with it confirm the ", 	1,      5,     14,    490,    20,     5,  320
	ih		 	FLbox  	"above mentioned efficiency savings. The same set of modal    ", 	1,      5,     14,    490,    20,     5,  340
	ih		 	FLbox  	"frequency ratios are used and converted into GEN09 table     ", 	1,      5,     14,    490,    20,     5,  360
	ih		 	FLbox  	"representations. Because partial numbers in the GEN09 table  ", 	1,      5,     14,    490,    20,     5,  380
	ih		 	FLbox  	"should be integers to prevent discontinuites in the waveform ", 	1,      5,     14,    490,    20,     5,  400
	ih		 	FLbox  	"these ratios are rounded to the nearest whole number.        ", 	1,      5,     14,    490,    20,     5,  420
	ih		 	FLbox  	"Normally this would lead to serious distortions of the       ", 	1,      5,     14,    490,    20,     5,  440
	ih		 	FLbox  	"original data but by first multiplying the ratios by some    ", 	1,      5,     14,    490,    20,     5,  460
	ih		 	FLbox  	"value (in this case 1000) before the rounding procedure is   ", 	1,      5,     14,    490,    20,     5,  480             
	ih		 	FLbox  	"applied these errors are minimised. When the GEN 09 table is ", 	1,      5,     14,    490,    20,     5,  500
	ih		 	FLbox  	"read by an oscillator the ratios will be scaled back down by ", 	1,      5,     14,    490,    20,     5,  520
	ih		 	FLbox  	"dividing the desired frequency of the oscillator by the value", 	1,      5,     14,    490,    20,     5,  540
	ih		 	FLbox  	"by which the ratios were multiplied in the first place.      ", 	1,      5,     14,    490,    20,     5,  560
	ih		 	FLbox  	"There are compromises made in this process but if we are     ", 	1,      5,     14,    490,    20,     5,  580
	ih		 	FLbox  	"aware of what they are we can minimise their impact. There   ", 	1,      5,     14,    490,    20,     5,  600
	ih		 	FLbox  	"may still be distortions of ratio values due to the rounding ", 	1,      5,     14,    490,    20,     5,  620
	ih		 	FLbox  	"process. This can be alleviated by multiplying the ratios by ", 	1,      5,     14,    490,    20,     5,  640
	ih		 	FLbox  	"a larger value but as partials are shifted upwards the detail", 	1,      5,     14,    490,    20,     5,  660
	ih		 	FLbox  	"with which they will be represented diminishes. This issue   ", 	1,      5,     14,    490,    20,     5,  680
	ih		 	FLbox  	"can in turn be minimised by increasing the table size but    ", 	1,      5,     14,    490,    20,     5,  700
	ih		 	FLbox  	"larger tables will take much longer to load - you may have   ", 	1,      5,     14,    490,    20,     5,  720
	ih		 	FLbox  	"already noticed that this example takes a moment to calculate", 	1,      5,     14,    490,    20,     5,  740
	ih		 	FLbox  	"and load the tables into RAM. The table sizes used are       ", 	1,      5,     14,    490,    20,     5,  760
	ih		 	FLbox  	"already quite large (131072), reducing this may lead to      ", 	1,      5,     14,    490,    20,     5,  780
	ih		 	FLbox  	"aliasing, particularly when higher notes are played.         ", 	1,      5,     14,    490,    20,     5,  800
	ih		 	FLbox  	"Because the audio oscillator will be reading the GEN09 table ", 	1,      5,     14,    490,    20,     5,  820
	ih		 	FLbox  	"at a very low frequency it may need to employ high quality   ", 	1,      5,     14,    490,    20,     5,  840
	ih		 	FLbox  	"interpolation to account for discontinuities in the waveform ", 	1,      5,     14,    490,    20,     5,  860
	ih		 	FLbox  	"and to ensure accurate tuning. A simple 'oscil' may not be   ", 	1,      5,     14,    490,    20,     5,  880
	ih		 	FLbox  	"adequate. This example uses 'poscil', it is slightly less    ", 	1,      5,     14,    490,    20,     5,  900
	ih		 	FLbox  	"efficient but as we only require one per note played this    ", 	1,      5,     14,    490,    20,     5,  920
	ih		 	FLbox  	"shouldn't be too large a concern.                            ", 	1,      5,     14,    490,    20,     5,  940
	ih		 	FLbox  	"A major drawback with this method of generating inharmonic   ", 	1,      5,     14,    490,    20,     5,  960
	ih		 	FLbox  	"spectra in contrast with the method used in 'ModalAddSyn.csd'", 	1,      5,     14,    490,    20,     5,  980
	ih		 	FLbox  	"is that we are not able to vary the strengths of individual  ", 	1,      5,     14,    490,    20,     5, 1000
	ih		 	FLbox  	"partials while a note is playing, therefore in order to be   ", 	1,      5,     14,    490,    20,     5, 1020
	ih		 	FLbox  	"able to create spectrally dynamic sounds we need to employ   ", 	1,      5,     14,    490,    20,     5, 1040
	ih		 	FLbox  	"techniques of subtractive synthesis. In this example a simple", 	1,      5,     14,    490,    20,     5, 1060
	ih		 	FLbox  	"lowpass filter ('butlp') is used.                            ", 	1,      5,     14,    490,    20,     5, 1080
	ih		 	FLbox  	"The strengths of individual partials can of course be varied ", 	1,      5,     14,    490,    20,     5, 1100
	ih		 	FLbox  	"in the GEN09 function table and this example includes a      ", 	1,      5,     14,    490,    20,     5, 1120
	ih		 	FLbox  	"simple mechanism for automating this based on the assumption ", 	1,      5,     14,    490,    20,     5, 1140
	ih		 	FLbox  	"that higher partials will be weaker in strength. It is also  ", 	1,      5,     14,    490,    20,     5, 1160
	ih		 	FLbox  	"an option to give all partials equal strength and to perform ", 	1,      5,     14,    490,    20,     5, 1180
	ih		 	FLbox  	"all spectral manipulation in real-time using techniques of   ", 	1,      5,     14,    490,    20,     5, 1200
	ih		 	FLbox  	"subtractive synthesis.                                       ", 	1,      5,     14,    490,    20,     5, 1220
	ih		 	FLbox  	"Aliasing may become a problem when higher notes are played.  ", 	1,      5,     14,    490,    20,     5, 1240
	ih		 	FLbox  	"This is caused by the oscillator playing back partials that  ", 	1,      5,     14,    490,    20,     5, 1260
	ih		 	FLbox  	"are beyond the Nyquist frequency. This can be prevented by   ", 	1,      5,     14,    490,    20,     5, 1280
	ih		 	FLbox  	"swapping for tables that omit these higher partials whenever ", 	1,      5,     14,    490,    20,     5, 1300
	ih		 	FLbox  	"higher notes are played. Table selection could be dictated   ", 	1,      5,     14,    490,    20,     5, 1320
	ih		 	FLbox  	"by conditional interrogation of the note number played.      ", 	1,      5,     14,    490,    20,     5, 1340
	ih		 	FLbox  	"This example includes the option to write the GEN09 tables   ", 	1,      5,     14,    490,    20,     5, 1360
	ih		 	FLbox  	"to a text file. These tables could then be used directly with", 	1,      5,     14,    490,    20,     5, 1380
	ih		 	FLbox  	"out the need for them to be calculated each time. The GEN02  ", 	1,      5,     14,    490,    20,     5, 1400
	ih		 	FLbox  	"tables containing the modal frequency ratios could also be   ", 	1,      5,     14,    490,    20,     5, 1420
	ih		 	FLbox  	"omitted then. This is not done in this example to encourage  ", 	1,      5,     14,    490,    20,     5, 1440
	ih		 	FLbox  	"the user to add in their own tables of modal frequency       ", 	1,      5,     14,    490,    20,     5, 1460
	ih		 	FLbox  	"ratios.                                                      ", 	1,      5,     14,    490,    20,     5, 1480
	ih		 	FLbox  	"In this example up to 22 partials are employed in each table.", 	1,      5,     14,    490,    20,     5, 1500
	ih		 	FLbox  	"This limit could easily be extended if required.             ", 	1,      5,     14,    490,    20,     5, 1520
FLscroll_end
FLpanel_end

FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE=======================================================================================================================================================
                                              
;FUNCTION TABLES STORING MODAL FREQUENCY RATIOS===================================================================================================================================
;plucked string
girtos1		ftgen	0,0,-20, -2, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;dahina
girtos2		ftgen	0,0,-6,-2, 1, 2.89, 4.95, 6.99, 8.01, 9.02
;banyan
girtos3		ftgen	0,0,-6,-2, 1, 2.0, 3.01, 4.01, 4.69, 5.63
;xylophone
girtos4		ftgen	0,0,-6,-2, 1, 3.932, 9.538, 16.688, 24.566, 31.147
;tibetan bowl (180mm)
girtos5		ftgen	0,0,-7,-2, 1, 2.77828, 5.18099, 8.16289, 11.66063, 15.63801, 19.99
;spinel sphere with diameter of 3.6675mm
girtos6		ftgen	0,0,-24,-2, 1, 1.026513174725, 1.4224916858532, 1.4478690202098, 1.4661959580455, 1.499452545408, 1.7891839345101, 1.8768994627782, 1.9645945254541, 1.9786543873113, 2.0334612432847, 2.1452852391916, 2.1561524686621, 2.2533435661294, 2.2905090816065, 2.3331798413917, 2.4567715528268, 2.4925556408289, 2.5661806088514, 2.6055768738808, 2.6692760296751, 2.7140956766436, 2.7543617293425, 2.7710411870043 
;pot lid
girtos7		ftgen	0,0,-6,-2, 1, 3.2, 6.23, 6.27, 9.92, 14.15
;red cedar wood plate
girtos8		ftgen	0,0,-4,-2, 1, 1.47, 2.09, 2.56
;tubular bell
girtos9		ftgen	0,0,-10,-2, 272/437, 538/437, 874/437, 1281/437, 1755/437, 2264/437, 2813/437, 3389/437, 4822/437, 5255/437
;redwood wood plate
girtos10	ftgen	0,0,-4,-2, 1, 1.47, 2.11, 2.57
;douglas fir wood plate
girtos11	ftgen	0,0,-4,-2, 1, 1.42, 2.11, 2.47
;uniform wooden bar
girtos12	ftgen	0,0,-6,-2, 1, 2.572, 4.644, 6.984, 9.723, 12
;uniform aluminum bar
girtos13	ftgen	0,0,-6,-2, 1, 2.756, 5.423, 8.988, 13.448, 18.680
;vibraphone 1
girtos14	ftgen	0,0,-6,-2, 1, 3.984, 10.668, 17.979, 23.679, 33.642
;vibraphone 2
girtos15	ftgen	0,0,-6,-2, 1, 3.997, 9.469, 15.566, 20.863, 29.440
;Chalandi plates
girtos16	ftgen	0,0,-5,-2, 1, 1.72581, 5.80645, 7.41935, 13.91935
;tibetan bowl (152 mm)
girtos17	ftgen	0,0,-7,-2, 1, 2.66242, 4.83757, 7.51592, 10.64012, 14.21019, 18.14027
;tibetan bowl (140 mm)	
girtos18	ftgen	0,0,-5,-2, 1, 2.76515, 5.12121, 7.80681, 10.78409
;wine glass
girtos19	ftgen	0,0,-5,-2, 1, 2.32, 4.25, 6.63, 9.38
;small handbell
girtos20	ftgen	0,0,-22,-2, 1, 1.0019054878049, 1.7936737804878, 1.8009908536585, 2.5201981707317, 2.5224085365854, 2.9907012195122, 2.9940548780488, 3.7855182926829, 3.8061737804878, 4.5689024390244, 4.5754573170732, 5.0296493902439, 5.0455030487805, 6.0759908536585, 5.9094512195122, 6.4124237804878, 6.4430640243902, 7.0826219512195, 7.0923780487805, 7.3188262195122, 7.5551829268293 
;albert clock bell belfast
girtos21	ftgen	0,0,-22,-2, 2.043260,1.482916,1.000000,3.328848,4.761811,1.477056,0.612007,2.661295,1.002793,4.023776,0.254139,2.043916,4.032463,2.659438,4.775560,5.500494,3.331014,0.809697,2.391301, 0.254098,1.901476,2.366563    ;,0.614968,2.046543,1.814887,3.130744,2.484426,0.558874,0.801697,0.070870,3.617036,2.782656
;=================================================================================================================================================================================

;=================================================================================================================================================================================
;GEN09 FUNCTION TABLE VERSIONS OF THE MODAL FREQUENCY TABLES
;THESE AREN'T ACTUALLY NEEDED AS THE TABLES ARE CALCULATED IN INSTRUMENT 2 BUT IF INSTRUMENT 2 IS OMITTED THESE TABLES WILL BE NEEDED
;NOTE THAT PARTIAL NUMBER HAVE BEEN MULTIPLIED BY giRtosScale AND THAT THE FREQUENCY OF ANY OSCILLATOR THAT USES THESE TABLES WILL HAVE TO BE DIVIDED BY THE SAME NUMBER 
giwave1		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2000,1.000,0,	 3000,1.000,0,	 4000,1.000,0,	 5000,1.000,0,	 6000,1.000,0,	 7000,1.000,0,	 8000,1.000,0,	 9000,1.000,0,	 10000,1.000,0,	 11000,1.000,0,	 12000,1.000,0,	 13000,1.000,0,	 14000,1.000,0,	 15000,1.000,0,	 16000,1.000,0,	 17000,1.000,0,	 18000,1.000,0,	 19000,1.000,0,	 20000,1.000,0
giwave2		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2890,1.000,0,	 4950,1.000,0,	 6990,1.000,0,	 8010,1.000,0,	 9020,1.000,0
giwave3		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2000,1.000,0,	 3010,1.000,0,	 4010,1.000,0,	 4690,1.000,0,	 5630,1.000,0	 
giwave4		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 3932,1.000,0,	 9538,1.000,0,	 16688,1.000,0,	 24566,1.000,0,	 31147,1.000,0
giwave5		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2778,0.500,0,	 5180,0.250,0,	 8162,0.125,0,	 11660,0.062,0,	 15638,0.031,0,	 19990,0.016,0
giwave6		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 1026,1.000,0,	 1422,1.000,0,	 1447,1.000,0,	 1466,1.000,0,	 1499,1.000,0,	 1789,1.000,0,	 1876,1.000,0,	 1964,1.000,0,	 1978,1.000,0,	 2033,1.000,0,	 2145,1.000,0,	 2156,1.000,0,	 2253,1.000,0,	 2290,1.000,0,	 2333,1.000,0,	 2456,1.000,0,	 2492,1.000,0,	 2566,1.000,0,	 2605,1.000,0,	 2669,1.000,0,	 2714,1.000,0
giwave7		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 3200,1.000,0,	 6230,1.000,0,	 6270,1.000,0,	 9920,1.000,0,	 14150,1.000,0
giwave8		ftgen	0, 0, 262144, 9, 1000,1.000,0,	 1470,1.000,0,	 2090,1.000,0,	 2560,1.000,0
giwave9		ftgen	0, 0, 262144, 9, 622,1.000,0,	 1231,1.000,0,	 2000,1.000,0,	 2931,1.000,0,	 4016,1.000,0,	 5180,1.000,0,	 6437,1.000,0,	 7755,1.000,0,	 11034,1.000,0,	 12025,1.000,0
giwave10	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 1470,1.000,0,	 2110,1.000,0,	 2570,1.000,0
giwave11	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 1420,1.000,0,	 2110,1.000,0,	 2470,1.000,0
giwave12	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2572,1.000,0,	 4644,1.000,0,	 6984,1.000,0,	 9723,1.000,0,	 12000,1.000,0
giwave13	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2756,1.000,0,	 5423,1.000,0,	 8988,1.000,0,	 13448,1.000,0,	 18680,1.000,0
giwave14	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 3984,1.000,0,	 10668,1.000,0,	 17979,1.000,0,	 23679,1.000,0,	 33642,1.000,0
giwave15	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 3997,1.000,0,	 9469,1.000,0,	 15566,1.000,0,	 20863,1.000,0,	 29440,1.000,0
giwave16	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 1725,1.000,0,	 5806,1.000,0,	 7419,1.000,0,	 13919,1.000,0
giwave17	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2662,1.000,0,	 4837,1.000,0,	 7515,1.000,0,	 10640,1.000,0,	 14210,1.000,0,	 18140,1.000,0
giwave18	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2765,1.000,0,	 5121,1.000,0,	 7806,1.000,0,	 10784,1.000,0
giwave19	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 2320,1.000,0,	 4250,1.000,0,	 6630,1.000,0,	 9380,1.000,0
giwave20	ftgen	0, 0, 262144, 9, 1000,1.000,0,	 1001,0.833,0,	 1793,0.694,0,	 1800,0.579,0,	 2520,0.482,0,	 2522,0.402,0,	 2990,0.335,0,	 2994,0.279,0,	 3785,0.233,0,	 3806,0.194,0,	 4568,0.162,0,	 4575,0.135,0,	 5029,0.112,0,	 5045,0.093,0,	 6075,0.078,0,	 5909,0.065,0,	 6412,0.054,0,	 6443,0.045,0,	 7082,0.038,0,	 7092,0.031,0,	 7318,0.026,0,	 7555,0.022,0
;=================================================================================================================================================================================

gisine		ftgen	0,0,4096,10,1				;A SINE WAVE
giRtosScale	=	100					;SCALING FACTOR APPLIED TO RATIOS WRITTEN TO GEN09 FUNCTION TABLE
								;FREQUENCY OF AUDIO OSCILLATOR WILL BE DIVIDED BY THIS VALUE
								;TOO LOW A VALUE HERE WILL RESULT IN QUANTISATION OF PARTIAL FREQUENCIES
								;TOO HIGH A VALUE WILL RESULT IN HIGHER PARTIALS BEING POORLY REPRESENTED IN THE TABLE, LEADING TO ALIASING 
gilfoshape	ftgen	0, 0, 4096, 19, 0.5, 1, 180, 1	;U-SHAPE PARABOLA (USED BY THE CHORUS EFFECT)
gidurscal	ftgen	0, 0, 128, -16, 10, 128, -4, 0.1	;A FUNCTION USED TO RESCALE ENVELOPE DURATIONS ACCORDING TO NOTE PLAYED
givelscal	ftgen	0, 0, 128, -16, 0, 128, -4, 1		;A FUNCTION USED TO REMAP MIDI VELOCITY VALUES - THE CURVATURE OF THIS FUNCTION CAN BE CHANGED TO TAKE ACCOUNT OF THE VARYING VELOCITY RESPONSE OF DIFFERENT MIDI KEYBOARDS

instr	2	;DERIVE GEN09 FUNCTION TABLE WAVEFORMS FROM THE GEN02 FUNCTION TABLES OF MODAL FREQUENCY RATIOS
;A MACRO IS DEFINED THAT READS A SINGLE MODAL FERQUENCY RATIO FROM A TABLE 
#define	PARTIAL(PartNum)
	#
	if $PartNum<=inratios then				;IF COUNTER IS WITHIN THE LIMITS OF THE NUMBER OF DEFINED MODAL FREQUENCY RATIOS...
	 irto$PartNum	table	$PartNum-1,girtos$WaveNum	;...READ A VALUE FROM THE TABLE
;	 irto$PartNum	=	round(irto$PartNum*giRtosScale)	;MULTIPLY RATIO BY giRtosScale THEN INTEGERISE BYT ROUND TO THE NEAREST WHOLE NUMBER
;	 iamp$PartNum	=	iamp/(iampscal^($PartNum-1))	;DERIVE AMPLITUDE VALUE FOR THIS PARTIAL
;	else							;IF COUNTER IS BEYOND THE LIMITS OF THE NUMBER OF DEFINED MODAL FREQUENCY RATIOS...
;	 irto$PartNum	=	0				;SET RATIO TO ZERO
;	 iamp$PartNum	=	0				;SET PARTIAL STRENGTH TO ZERO
	endif
	#

;A MACRO IS DEFINED THAT CREATES A GEN09 TABLE FROM MODAL FREQUENCY DATA 
#define	WAVEFORM(WaveNum'AmpScal)
	#
	inratios	=	ftlen(girtos$WaveNum)
	iampscal	=	$AmpScal			;AMPLITUDE SCALING 
	iamp		=	1				;PARTIAL STRENGTH OF FIRST PARTIAL
	$PARTIAL(1)						;MACRO EXPANDED FOR EACH PARTIAL...
	$PARTIAL(2)
	$PARTIAL(3)
	$PARTIAL(4)
	$PARTIAL(5)
	$PARTIAL(6)
	$PARTIAL(7)
	$PARTIAL(8)
	$PARTIAL(9)
	$PARTIAL(10)
	$PARTIAL(11)
	$PARTIAL(12)                          
	$PARTIAL(13)
	$PARTIAL(14)
	$PARTIAL(15)
	$PARTIAL(16)
	$PARTIAL(17)
	$PARTIAL(18)                                                                                                                                                         
	$PARTIAL(19)
	$PARTIAL(20)
	$PARTIAL(21)
	$PARTIAL(22)                                                                                                                                                            
	;GENERATE A GEN09 FUNCTION TABLE (ALL PHASES ARE SET TO ZERO)
	giwave$WaveNum	ftgen	0,0,131072,9, irto1,iamp1,0, irto2,iamp2,0, irto3,iamp3,0, irto4,iamp4,0, irto5,iamp5,0, irto6,iamp6,0, irto7,iamp7,0, irto8,iamp8,0, irto9,iamp9,0, irto10,iamp10,0, irto11,iamp11,0, irto12,iamp12,0, irto13,iamp13,0, irto14,iamp14,0, irto15,iamp15,0, irto16,iamp16,0, irto17,iamp17,0, irto18,iamp18,0, irto19,iamp19,0, irto20,iamp20,0, irto21,iamp21,0, irto22,iamp22,0 	

	;UNCOMMENT THE FOLLOWING LINE IF YOU WISH TO WRITE GENERATED TABLES TO A TEXT FILE FOR LATER USE
	fprints "GEN09InharmonicTables.txt", "giwave$WaveNum.%tftgen%t0, 0, 131072s, 9, %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0,%t %d,%5.3f,0%n", irto1,iamp1, irto2,iamp2, irto3,iamp3, irto4,iamp4, irto5,iamp5, irto6,iamp6, irto7,iamp7, irto8,iamp8, irto9,iamp9, irto10,iamp10, irto11,iamp11, irto12,iamp12, irto13,iamp13, irto14,iamp14, irto15,iamp15, irto16,iamp16, irto17,iamp17, irto18,iamp18, irto19,iamp19, irto20,iamp20, irto21,iamp21, irto22,iamp22
	#	
	;EXPAND MACRO FOR EACH WAVEFORM TO BE CREATED
	;ARG1 = A COUNTER, SHOULD CORRESPOND TO NUMBER APPENDED TO 'girtos' FOR THE TABLE HANDLE OF THE REQUIRED MODAL FREQUENCIES TABLE
	;ARG2 = PARTIAL STRENGTHS SCALING: 1=FLAT >1=HIGHER PARTIALS ARE INCREASINGLY ATTENUATED
$WAVEFORM(1'1.5)
	$WAVEFORM(2'2)                                                                                  
	$WAVEFORM(3' 1.5)
	$WAVEFORM(4' 2)
	$WAVEFORM(5' 2)
	$WAVEFORM(6' 1)
	$WAVEFORM(7' 1.2)
	$WAVEFORM(8' 1.5)
	$WAVEFORM(9' 1)          
	$WAVEFORM(10' 1)
	$WAVEFORM(11' 1)
	$WAVEFORM(12' 1.5)                                       
	$WAVEFORM(13' 1)
	$WAVEFORM(14' 2)
	$WAVEFORM(15' 2)    
	$WAVEFORM(16' 1.5)
	$WAVEFORM(17' 2)
	$WAVEFORM(18' 2)
	$WAVEFORM(19' 1)
	$WAVEFORM(20' 1.2)
	$WAVEFORM(21' 1.1)
endin

instr	1	;SOUND GENERATING INSTRUMENT
	icps	cpsmidi						;READ CPS VALUE IN FROM MIDI KEYBOARD
	inum	notnum						;READ MIDI NOTE NUMBER
	ivel	veloc	0,1					;READ MIDI VELOCITY
	ivel	table	ivel,givelscal,1			;REMAP MIDI VELOCITY - SEE TABLE givelscal ABOVE
	iscale	table	inum,gidurscal				;DURATIONAL RESCALING ACCORDING TO NOTE PLAYED - HIGHER NOTE WILL DECAY QUICKER IN REFLECTION OF REAL-WORLD CHARACTERISTICS

	aenv	expsegr		0.001,i(gkAatt),1,i(gkAdec)*iscale,i(gkAsus)+0.0001,i(gkArel)*iscale,0.0001	;AMPLITUDE ENVELOPE WITH MIDI SENSING RELEASE SEGEMENT
	asig	poscil		0.1*aenv*ivel,icps/giRtosScale,giwave1+i(gksound)-1				;AUDIO OSCILLATOR poscil3 USED FOR IMPROVED FIDELITY OVER OTHER OSCILLATORS. FREQUENCY IS SCALED DOWN ACCORIND TO THE VALUE OF giRtosScale DEFINED IN THE HEADER
	
	;UNFORTUNATELY transegr DOESN'T SEEM TO WORK SO IN THE MEANTIME THIS RATHER PROTRACTED ALTERNATIVE WILL ACT AS A SUBSTITUTE 
	iFlev1	limit		cpsoct((i(gkFlev1)*10*ivel)+4),icps,sr/2	;DERIVE STARTING FILTER VALUE IN CPS FROM FLTK KNOB (RANGE 0 TO 1). LIMIT IT BETWEEN FUNDEMENTAL FREQ. AND NYQUIST.
	iFsus	=		icps+cpsoct((i(gkFsus)*10)+4)			;DERIVE FILTER SUSTAIN VALUE IN CPS FROM FLTK KNOB VALUE (RANGE 0 - 1)
	iFend	=		icps						;FINAL FILTER ENVELOPE VALUE IS ALWAYS FUNDEMENTAL FREQUENCY
	
	krel	release						;SENSE WHEN A NOTE HAS BEEN RELEASED. 1=NOTE_RELEAESD 0=NOTE_BEING_HELD
	if krel==0 then						;IF NOTE IS BEGIN HELD...
	  kcf	transeg		iFlev1,i(gkFdec)*iscale,i(gkFshp),iFsus	;CREATE ADS (ATTACK-DECAY-SUSTAIN) PART OF ENVELOPE
	else							;OTHERWISE (WE ARE IN THE RELEASE STAGE)
	  ktrig	changed		krel				;INSTIGATE A SHORT REINITIALISATION TO DERIVE AN I-TIME VALUE OF THE CURRENT AMPLITUDE VALUE FOR THE STARTING POINT OF THE RELEASE ENVELOPE 
	  if	ktrig==1 then					;
	    reinit	StartRel
	  endif
	  StartRel:
	  kcf	transeg		i(kcf),i(gkFrel)*iscale,i(gkFshp),iFend		;RELEASE STAGE OF THE ENVELOPE. 'i(kcf)' AS THE STARTING VALUE ENSURES THAT IT ALWAYS PICKS UP FROM WHERE THE 'ADS' PART OF THE ENVELOPE LEFT OFF.
	  rireturn
	endif
	
	asig	butlp		asig, kcf					;LOW PASS FILTER THE SOUND (SUBTRACTIVE SYNTHESIS)
	
	;STEREO CHORUS----------------------------------------------------------
	if gkChoOnOff==1 then
	  adly1		oscili	1,gkspeed,gilfoshape				;CHORUS DELAY TIME LFO 1
	  adly2		oscili	1,gkspeed,gilfoshape,0.5			;CHORUS DELAY TIME LFO 2
	  acho1		vdelay	asig,adly1+0.1,2				;CHORUS SIGNAL 1 (MODULATING DELAY TIME AND THEREFORE MODULATING PITCH ALSO)
	  acho2		vdelay	asig,adly2+0.1,2				;CHORUS SIGNAL 2
	  aL		sum	asig, acho1*gkchomix, acho2*gkchomix*gkwidth 	;CREATE LEFT CHANNEL MIX
	  aR		sum	asig, acho1*gkchomix*gkwidth, acho2*gkchomix 	;CREATE RIGHT CHANNEL MIX
	  ;SEND STEREO AUDIO TO OUTPUTS
	  		outs	acho1*gkchomix + acho2*gkchomix*gkwidth, acho1*gkchomix*gkwidth + acho2*gkchomix
	endif
	;-----------------------------------------------------------------------

		outs		asig, asig	;SEND UN-CHORUSSED AUDIO TO THE OUTPUTS
endin

instr	3	;UPDATES 'Sound' FLTK COUNTER LABEL AND SETS PRESET VALUES
;A MACRO IS DEFINED THAT WHEN IMPLEMENTED WILL SET VARIOUS PRESET VALUES ACOORDING TO THE VALUES OF THE MACRO'S ARGUMENTS
#define	SetValues(Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp)
	#
	FLsetVal_i	$Aatt, 	gihAatt
	FLsetVal_i	$Adec, 	gihAdec                                                                                                                                 
	FLsetVal_i	$Asus, 	gihAsus
	FLsetVal_i	$Arel, 	gihArel
	FLsetVal_i	$Flev1, gihFlev1
	FLsetVal_i	$Fdec, 	gihFdec
	FLsetVal_i	$Fsus, 	gihFsus
	FLsetVal_i	$Frel, 	gihFrel
	FLsetVal_i	$Fshp, 	gihFshp
	#
	ktrig	changed	gksound							;IF 'SOUND' TYPE SELECTER IS CHANGED GENERATE A TRIGGER IMPULSE
	if ktrig==1 then							;IF 'SOUND' TYPE SELECTER HAS BEEN CHANGED...
	  reinit update								;...BEGIN A REINITIALISATION PASS FROM LABEL 'update'
	endif									;END OF CONDITIONAL BRANCH
	update:									;LABEL - REINITIALISATION BEGINS FROM HERE
		FLhide	gihSoundName						;HIDE SOUND TYPE DESCRIPTION
	if	i(gksound)==1	then						;IF SOUND TYPE 1...
	  Sname	=	"Plucked String"					;CREATE A STRING FOR THE NAME OF THIS ALGORITHM.
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.002'9   '0   '0.2 '0.6  '8   '0   '0.2 '-5)		;EXPAND MACRO TO SET VARIOUS AMPLITUDE AND FILTER ENVELOPE VALUES
	elseif	i(gksound)==2	then						;...AND SO ON...
	  Sname	=	"Dahina"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'1   '0   '1   '0.65 '1   '0   '1   '-10)
	elseif	i(gksound)==3	then
	  Sname	=	"Banyan"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'1.5 '0   '1.5 '0.8 '1   '0   '1   '-10)
	elseif	i(gksound)==4	then
	  Sname	=	"Xylophone"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.002'1.5' 0'   1.5' 0.8'  1.5' 0'   1.5' -20)
	elseif	i(gksound)==5	then	
	  Sname	=	"Tibetan Bowl (180mm)"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'15  '0   '15  '0.7  '15  '0   '15  '-30)
	elseif	i(gksound)==6	then
	  Sname	=	"Spinel Sphere"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'0.5 '0   '0.5 '1    '0.2 '0   '0.2  '-50)
	elseif	i(gksound)==7	then
	  Sname	=	"Pot Lid"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'7   '0   '7   '0.75 '5   '0   '5   '-10)
	elseif	i(gksound)==8	then
	  Sname	=	"Red Cedar Wood Plate"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'0.5 '0   '0.5 '0.75 '0.5 '0   '0.5 '-30)
	elseif	i(gksound)==9	then
	  Sname	=	"Tubular Bell"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'13  '0   '13  '0.8  '10  '0   '10  '-20)
	elseif	i(gksound)==10	then
	  Sname	=	"Redwood Wood Plate"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'0.7 '0   '0.7 '0.8  '0.63'0   '0.67'-30)
	elseif	i(gksound)==11	then
	  Sname	=	"Douglas Fir Wood Plate"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'0.7 '0   '0.7 '0.8  '0.63'0   '0.67'-30)
	elseif	i(gksound)==12	then                                              
	  Sname	=	"Uniform Wooden Bar"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'2   '0   '2   '0.8  '0.8 '0   '0.8 '-30)
	elseif	i(gksound)==13	then
	  Sname	=	"Uniform Aluminium Bar"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'10  '0   '10  '0.8  '10  '0   '10  '-15)
	elseif	i(gksound)==14	then
	  Sname	=	"Vibraphone 1"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'16  '0   '0.5 '0.8  '6   '0   '2   '-30)
	elseif	i(gksound)==15	then
	  Sname	=	"Vibraphone 2"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'16  '0   '0.5 '0.8  '6   '0   '2   '-30)
	elseif	i(gksound)==16	then
	  Sname	=	"Chalandi Plates"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'7   '0   '8   '0.8  '8   '0   '8   '-41)
	elseif	i(gksound)==17	then
	  Sname	=	"Tibetan Bowl (152mm)"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'15  '0   '15  '1    '15  '0   '15  '-30)
	elseif	i(gksound)==18	then
	  Sname	=	"Tibetan Bowl (140mm)"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'15  '0   '15  '1    '15  '0   '15  '-30)
	elseif	i(gksound)==19	then
	  Sname	=	"Wine Glass"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'5   '0   '5   '0.8  '5   '0   '5   '-1)
	elseif	i(gksound)==20	then
	  Sname	=	"Small Hand Bell"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'20  '0   '20  '0.8  '10  '0   '10  '-16)
	elseif	i(gksound)==21	then
	  Sname	=	"Albert Clock Bell"
	;             Aatt'Adec'Asus'Arel'Flev1'Fdec'Fsus'Frel'Fshp
	  $SetValues(0.001'20  '0   '20  '0.8  '10  '0   '10  '-20)
	endif
		FLsetText	Sname,gihSoundName				;SET NEW SOUND TYPE DESCRITION TO FL WIDGET
		FLshow	gihSoundName						;REVEAL THE WIDGET (AND THEREFORE THE LABEL)
		rireturn							;RETURN FROM REINITIALISATION PASS

endin


</CsInstruments>

<CsScore>
i 2 0 0		;CREATE GEN09 FUNCTION TABLES
f 0 3600	;DUMMY SCORE EVENT TO SUSTAIN REAL-TIME PERFORMANCE
</CsScore>

</CsoundSynthesizer>