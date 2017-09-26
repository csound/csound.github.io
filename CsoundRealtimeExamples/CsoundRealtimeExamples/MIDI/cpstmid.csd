cpstmid.csd
Written by Iain McCurdy 2006, updated 2011.     

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100                                                                                                                                                          
ksmps 	= 	16
nchnls 	= 	1	
0dbfs	=	1	;MAXIMUM AMPLITUDE
massign	1,101
;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                                | WIDTH | HEIGHT | X | Y
	FLpanel	"cpstmid - alternative tunings for MIDI driven instruments",    500,    730,    0,  0

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X |  Y  | OPCODE
gktable, ihtable 			FLcount  "Tuning Table", 	1,    10,     1,      1,     2,     150,     25,   175,  5,    -1

;TEXT BOXES                                                                                                
;HANDLE	OPCODE  "LABEL",                                                                                                       																	TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	FLbox  	"  1 - Standard . 2 - Quarter Tones . 3 - Standard Reversed . 4 - Quarter Tones Reversed . 5 - Decatonic . 6 - Third Tones . 7 - Just Intonation . 8 - User . 9 - User (Equally Tempered Divisions) . 10 - User (Ratios Defined as Fractions)",	1,       9,    15,    500,      40,   0,  50
ih 	FLbox  	"", 																														6,       9,    15,    492,     270,   4, 110	;BORDER
ih 	FLbox  	"", 																														6,       9,    15,    492,     100,   4, 390	;BORDER
ih 	FLbox  	"", 																														6,       9,    15,    492,     220,   4, 500	;BORDER
ih	FLbox  	"User Defined Tuning Table (table 8)", 																										1,      12,    15,    240,      20,   5, 115
ih	FLbox  	"Equally Tempered Divisions (table 9)", 																									1,      12,    15,    260,      20,   5, 395
ih	FLbox  	"Ratios as Fractions (table 10)", 																										1,      12,    15,    200,      20,   5, 505
ih	FLbox  	"Ratios:", 																													1,      12,    15,     60,      20,   5, 200

;VALUE INPUT BOXES				 		MIN | MAX |  STEP  | TYPE | WIDTH | HEIGHT | X  | Y
gkRptRatio, ihRptRatio		FLtext		"Repeat Ratio",	-100, 100,  0.01,     1,      80,     20,  105,  150
gkBasePitch, ihBasePitch	FLtext		"Base Pitch", 	0,    127,  0.01,     1,      80,     20,  190,  150
gkRptRatioET, ihRptRatioET	FLtext		"Repeat Ratio",	-100, 100,  0.01,     1,      80,     20,  105,  430
gkBasePitchET, ihBasePitchET	FLtext		"Base Pitch", 	0,    127,  0.01,     1,      80,     20,  190,  430
gkRptRatioF, ihRptRatioF	FLtext		"Repeat Ratio",	-100, 100,  0.01,     1,      80,     20,  105,  530
gkBasePitchF, ihBasePitchF	FLtext		"Base Pitch", 	0,    127,  0.01,     1,      80,     20,  190,  530
gkratio1,  ihratio1		FLtext		"0", 		-100, 100,  0.0001,   1,      55,     25,   10,  225
gkratio2,  ihratio2		FLtext		"1", 		-100, 100,  0.0001,   1,      55,     25,   70,  225
gkratio3,  ihratio3		FLtext		"2", 		-100, 100,  0.0001,   1,      55,     25,  130,  225                                                         
gkratio4,  ihratio4		FLtext		"3", 		-100, 100,  0.0001,   1,      55,     25,  190,  225
gkratio5,  ihratio5		FLtext		"4", 		-100, 100,  0.0001,   1,      55,     25,  250,  225
gkratio6,  ihratio6		FLtext		"5", 		-100, 100,  0.0001,   1,      55,     25,  310,  225
gkratio7,  ihratio7		FLtext		"6", 		-100, 100,  0.0001,   1,      55,     25,  370,  225
gkratio8,  ihratio8		FLtext		"7", 		-100, 100,  0.0001,   1,      55,     25,  430,  225
gkratio9,  ihratio9		FLtext		"8", 		-100, 100,  0.0001,   1,      55,     25,   10,  275
gkratio10, ihratio10		FLtext		"9", 		-100, 100,  0.0001,   1,      55,     25,   70,  275
gkratio11, ihratio11		FLtext		"10", 		-100, 100,  0.0001,   1,      55,     25,  130,  275
gkratio12, ihratio12		FLtext		"11", 		-100, 100,  0.0001,   1,      55,     25,  190,  275
gkratio13, ihratio13		FLtext		"12", 		-100, 100,  0.0001,   1,      55,     25,  250,  275
gkratio14, ihratio14		FLtext		"13", 		-100, 100,  0.0001,   1,      55,     25,  310,  275
gkratio15, ihratio15		FLtext		"14", 		-100, 100,  0.0001,   1,      55,     25,  370,  275
gkratio16, ihratio16		FLtext		"15", 		-100, 100,  0.0001,   1,      55,     25,  430,  275
gkratio17, ihratio17		FLtext		"16", 		-100, 100,  0.0001,   1,      55,     25,   10,  325
gkratio18, ihratio18		FLtext		"17", 		-100, 100,  0.0001,   1,      55,     25,   70,  325
gkratio19, ihratio19		FLtext		"18", 		-100, 100,  0.0001,   1,      55,     25,  130,  325
gkratio20, ihratio20		FLtext		"19", 		-100, 100,  0.0001,   1,      55,     25,  190,  325
gkratio21, ihratio21		FLtext		"20", 		-100, 100,  0.0001,   1,      55,     25,  250,  325
gkratio22, ihratio22		FLtext		"21", 		-100, 100,  0.0001,   1,      55,     25,  310,  325                
gkratio23, ihratio23		FLtext		"22", 		-100, 100,  0.0001,   1,      55,     25,  370,  325
gkratio24, ihratio24		FLtext		"23", 		-100, 100,  0.0001,   1,      55,     25,  430,  325
  
;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkN1, ihN1			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,    15,530+60,   -1
gkN2, ihN2			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,    95,530+60,   -1
gkN3, ihN3			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   175,530+60,   -1
gkN4, ihN4			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   255,530+60,   -1
gkN5, ihN5			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   335,530+60,   -1
gkN6, ihN6			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   415,530+60,   -1

gkD1, ihD1			FLcount  	"0", 	1,   9999,    1,     10,     2,      70,     20,    15,550+60,   -1
gkD2, ihD2			FLcount  	"1", 	1,   9999,    1,     10,     2,      70,     20,    95,550+60,   -1
gkD3, ihD3			FLcount  	"2", 	1,   9999,    1,     10,     2,      70,     20,   175,550+60,   -1
gkD4, ihD4			FLcount  	"3", 	1,   9999,    1,     10,     2,      70,     20,   255,550+60,   -1
gkD5, ihD5			FLcount  	"4", 	1,   9999,    1,     10,     2,      70,     20,   335,550+60,   -1
gkD6, ihD6			FLcount  	"5", 	1,   9999,    1,     10,     2,      70,     20,   415,550+60,   -1

gkN7,  ihN7			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,    15,530+120,   -1
gkN8,  ihN8			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,    95,530+120,   -1
gkN9,  ihN9			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   175,530+120,   -1
gkN10, ihN10			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   255,530+120,   -1
gkN11, ihN11			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   335,530+120,   -1
gkN12, ihN12			FLcount  	"", 	1,   9999,    1,     10,     2,      70,     20,   415,530+120,   -1
                                                                                                                        
gkD7, ihD7			FLcount  	"6", 	1,   9999,    1,     10,     2,      70,     20,    15,550+120,   -1
gkD8, ihD8			FLcount  	"7", 	1,   9999,    1,     10,     2,      70,     20,    95,550+120,   -1
gkD9, ihD9			FLcount  	"8", 	1,   9999,    1,     10,     2,      70,     20,   175,550+120,   -1
gkD10, ihD10     		FLcount  	"9", 	1,   9999,    1,     10,     2,      70,     20,   255,550+120,   -1
gkD11, ihD11     		FLcount  	"10", 	1,   9999,    1,     10,     2,      70,     20,   335,550+120,   -1
gkD12, ihD12     		FLcount  	"11", 	1,   9999,    1,     10,     2,      70,     20,   415,550+120,   -1

;COUNTERS					     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkNGrades, ihNGrades		FLcount  	"Num.Grades", 	1,     24,    1,     12,     2,      90,     20,    10,150,   -1
gkBaseKey, ihBaseKey		FLcount  	"Base Key", 	0,    127,    1,     12,     2,      90,     20,   275,150,   -1 
gkNGradesET, ihNGradesET	FLcount  	"Num.Grades", 	1,    128,    1,     12,     2,      90,     20,    10,430,    0,3,0,0  
gkBaseKeyET, ihBaseKeyET	FLcount  	"Base Key", 	0,    127,    1,     12,     2,      90,     20,   275,430,   -1 
gkNGradesF, ihNGradesF		FLcount  	"Num.Grades", 	1,     12,    1,     12,     2,      90,     20,    10,530,   -1 
gkBaseKeyF, ihBaseKeyF		FLcount  	"Base Key", 	0,    127,    1,     12,     2,      90,     20,   275,530,   -1 

;SET INITIAL VALUES			VALUE | HANDLE                                                                                    
			FLsetVal_i	1,	ihtable
			FLsetVal_i	2,	ihRptRatio
			FLsetVal_i	60,	ihBasePitch                          
			FLsetVal_i	60,	ihBaseKey
			FLsetVal_i	12,	ihNGrades
			FLsetVal_i	2,	ihRptRatioET
			FLsetVal_i	60,	ihBasePitchET
			FLsetVal_i	60,	ihBaseKeyET
			FLsetVal_i	12,	ihNGradesET
			FLsetVal_i	2,	ihRptRatioF
			FLsetVal_i	60,	ihBasePitchF
			FLsetVal_i	60,	ihBaseKeyF
			FLsetVal_i	12,	ihNGradesF
			FLsetVal_i	1,		ihratio1
			FLsetVal_i	(2^(1/12)),	ihratio2
			FLsetVal_i	(2^(2/12)),	ihratio3
			FLsetVal_i	(2^(3/12)),	ihratio4
			FLsetVal_i	(2^(4/12)),	ihratio5
			FLsetVal_i	(2^(5/12)),	ihratio6
			FLsetVal_i	(2^(6/12)),	ihratio7
			FLsetVal_i	(2^(7/12)),	ihratio8
			FLsetVal_i	(2^(8/12)),	ihratio9
			FLsetVal_i	(2^(9/12)),	ihratio10
			FLsetVal_i	(2^(10/12)),	ihratio11
			FLsetVal_i	(2^(11/12)),	ihratio12
			FLsetVal_i	(2^(12/12)),	ihratio13
			FLsetVal_i	(2^(12/12)),	ihratio14                                                      
			FLsetVal_i	(2^(12/12)),	ihratio15
			FLsetVal_i	(2^(12/12)),	ihratio16
			FLsetVal_i	(2^(12/12)),	ihratio17
			FLsetVal_i	(2^(12/12)),	ihratio18
			FLsetVal_i	(2^(12/12)),	ihratio19
			FLsetVal_i	(2^(12/12)),	ihratio20
			FLsetVal_i	(2^(12/12)),	ihratio21
			FLsetVal_i	(2^(12/12)),	ihratio22
			FLsetVal_i	(2^(12/12)),	ihratio23                           
			FLsetVal_i	(2^(12/12)),	ihratio24                                           
			FLsetVal_i	1,	ihN1
			FLsetVal_i	1,	ihD1
			FLsetVal_i	16,	ihN2
			FLsetVal_i	15,	ihD2
			FLsetVal_i	9,	ihN3
			FLsetVal_i	8,	ihD3
			FLsetVal_i	6,	ihN4
			FLsetVal_i	5,	ihD4
			FLsetVal_i	5,	ihN5
			FLsetVal_i	4,	ihD5
			FLsetVal_i	4,	ihN6
			FLsetVal_i	3,	ihD6
			FLsetVal_i	45,	ihN7
			FLsetVal_i	32,	ihD7
			FLsetVal_i	3,	ihN8
			FLsetVal_i	2,	ihD8
			FLsetVal_i	8,	ihN9
			FLsetVal_i	5,	ihD9
			FLsetVal_i	5,	ihN10
			FLsetVal_i	3,	ihD10
			FLsetVal_i	9,	ihN11
			FLsetVal_i	5,	ihD11
			FLsetVal_i	15,	ihN12
			FLsetVal_i	8,	ihD12

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 840, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" cpstmid  - alternative tunings for MIDI driven instruments  ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The opcode 'cpstmid' is used, in place of the usual opcode   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"that would be used for MIDI pitch scanning, 'cpsmid' to      ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"derive alternative tunings.                                  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'cpstmid' references tuning data stored in a GEN02 function  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"tables to derive pitches. In this function table the user    ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"must supply information about the number of grades in the    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"scale (i.e. '12' for equal temperament), the ratio at which  ", 	1,      5,     14,    490,    20,     5, 160                           
ih		 	FLbox  	"the scale repeats (i.e. '2' for equal temperament), base     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"frequency of the scale in hertz (261.626 for middle C) and   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"then the ratios from grade to grade. For example in an       ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"equally tempered system each subsequent grade is the product ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"of the previous grade and the 1/12 root of 2 (about 1.05946).", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"This example offers 8 different tuning systems.              ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"1  - equal temperament                                       ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"2  - quarter tone scale                                      ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"3  - equal temperament upside-down                           ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"4  - quarter tones upside-down                               ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"5  - an octave divided into 10 equal intervals               ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"6  - third tones scale                                       ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"7  - just intonation                                         ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"8  - user defined                                            ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"9  - user defined equally tempered divisions                 ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"10 - user defined ratios defined as fractions                ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"The user defined tables allows the user to explore the       ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"interaction of the various parameters comprising the tuning  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"table a little further.                                      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"In the first user defined table (table 8) 'Base Pitch' is    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"expressed as a MIDI note number (fractions are allowed).  Up ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"to 24 ratios corresponding to each degree of a scale are     ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"allowed. If 'Num Grades' is less than 24, unused ratios are  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"simply ignored.                                              ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"Table 9 simply divides the interval of the entire scale (the ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"'Repeat Ratio' into a number of equal divisions corresponding", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"to the 'Num.Grades'.                                         ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"Table 10 allows interval ratios to be defined as fractions.  ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"'Just' intonations can be explored using this table. Up to   ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"12 grades can be employed. Unused ratios are simply ignored. ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"If you wish to convert MIDI note numbers via these table     ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"without the need for instrtuments to be MIDI activated you   ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"can replace 'cpstmid' with the 'cpstuni' opcode.             ", 	1,      5,     14,    490,    20,     5, 820

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;TUNING TABLES:
;			FN_NUM | INIT_TIME | SIZE | GEN_ROUTINE | NUM_GRADES | REPEAT |  BASE_FREQ     | BASE_KEY_MIDI | TUNING_RATIOS:-0-|----1----|---2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|----10-----|---11----|---12---|---13----|----14---|----15---|---16----|----17---|---18----|---19---|----20----|---21----|---22----|---23---|----24----|----25----|----26----|----27----|----28----|----29----|----30----|----31----|----32----|----33----|----34----|----35----|----36----|
giTTable1	ftgen     1,         0,       64,        -2,         12,         2,     cpsmidinn(60),        60,                       1, 1.059463,1.1224619,1.1892069,1.2599207,1.33483924,1.414213,1.4983063,1.5874001,1.6817917,1.7817962, 1.8877471,     2	;STANDARD
giTTable2	ftgen     2,         0,       64,        -2,         24,         2,     cpsmidinn(60),        60,                       1, 1.0293022,1.059463,1.0905076,1.1224619,1.1553525,1.1892069,1.2240532,1.2599207,1.2968391,1.33483924,1.3739531,1.414213,1.4556525,1.4983063, 1.54221, 1.5874001, 1.6339145,1.6817917,1.73107,  1.7817962,1.8340067,1.8877471,1.9430623,    2	;QUARTER TONES
giTTable3	ftgen     3,         0,       64,        -2,         12,       0.5,     cpsmidinn(60),        60,                       2, 1.8877471,1.7817962,1.6817917,1.5874001,1.4983063,1.414213,1.33483924,1.2599207,1.1892069,1.1224619,1.059463,      1	;STANDARD REVERSED
giTTable4	ftgen     4,         0,       64,        -2,         24,       0.5,     cpsmidinn(60),        60,                       2, 1.9430623,1.8877471,1.8340067,1.7817962,1.73107, 1.6817917,1.6339145,1.5874001,1.54221,  1.4983063, 1.4556525,1.414213,1.3739531,1.33483924,1.2968391,1.2599207,1.2240532,1.1892069,1.1553525,1.1224619,1.0905076,1.059463, 1.0293022,    1	;QUARTER TONES REVERSED
giTTable5	ftgen     5,         0,       64,        -2,         10,         2,     cpsmidinn(60),        60,                       1, 1.0717734,1.148698,1.2311444,1.3195079, 1.4142135,1.5157165,1.6245047,1.7411011,1.8660659,     2	;DECATONIC
giTTable6	ftgen     6,         0,       64,        -2,         36,         2,     cpsmidinn(60),        60,                       1, 1.0194406,1.0392591,1.059463,1.0800596, 1.1010566,1.1224618,1.1442831,1.1665286,1.1892067,1.2123255,1.2358939,1.2599204,1.284414,1.3093838, 1.334839, 1.3607891,1.3872436,1.4142125,1.4417056,1.4697332,1.4983057,1.5274337,1.5571279,1.5873994, 1.6182594,1.6497193, 1.6817909, 1.7144859, 1.7478165, 1.7817951, 1.8164343, 1.8517469, 1.8877459, 1.9244448, 1.9618572,      2	;THIRD TONES
giTTable7	ftgen     7,         0,       64,        -2,         12,         2,     cpsmidinn(60),        60,                       1,   16/15,     9/8,     6/5,      5/4,       4/3,     45/32,     3/2,     8/5,      5/3,      9/5,       15/8,    2	;JUST INTONATION                                                                                                                                                                                                                                   

gicos		ftgen 	0,0,16384,11,1	;A COSINE WAVE - USED BY THE gbuzz OPCODE		


instr	2	;CREATES USER TUNING TABLE 8 AND SCANS FOR CHANGES IN THE PARAMETERS THAT FORM THIS TABLE
	;CREATE A TRIGGER WHICH INFORMS WHENEVER ANY OF THE PARAMETERS FOR USER DEFINED TABLE 8 ARE CHANGED
	ktrig	changed	gkNGrades,gkRptRatio,gkBasePitch,gkBaseKey,gkratio1,gkratio2,gkratio3,gkratio4,gkratio5,gkratio6,gkratio7,gkratio8,gkratio9,gkratio10,gkratio11,gkratio12,gkratio13,gkratio14,gkratio15,gkratio16,gkratio17,gkratio18,gkratio19,gkratio20,gkratio21,gkratio22,gkratio23,gkratio24
	if ktrig=1 then			;IF A PARAMETER WHICH FORMS USER DEFINED TABLE 8 IS CHANGED... 
	  reinit	UPDATE_TABLE	;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE_TABLE' 
	endif				;END OF CONDITIONAL BRANCH
	UPDATE_TABLE:			;LABEL CALLED 'UPDATE_TABLE'. REINITIALISATION PASS BEGINS FROM HERE.
	;CREATE THE USER DEFINED TUNING TABLE (AT I-TIME AND ALSO DURING REINITIALISATION PASSES)
	giTTable8	ftgen     8,0,64,-2,i(gkNGrades),i(gkRptRatio),cpsmidinn(i(gkBasePitch)),i(gkBaseKey),i(gkratio1),i(gkratio2),i(gkratio3),i(gkratio4),i(gkratio5),i(gkratio6),i(gkratio7),i(gkratio8),i(gkratio9),i(gkratio10),i(gkratio11),i(gkratio12),i(gkratio13),i(gkratio14),i(gkratio15),i(gkratio16),i(gkratio17),i(gkratio18),i(gkratio19),i(gkratio20),i(gkratio21),i(gkratio22),i(gkratio23),i(gkratio24)
endin

instr	3	;CREATES EQUALLY TEMPERED USER DEFINED TABLE
	;CREATE A TRIGGER WHICH INFORMS WHENEVER ANY OF THE PARAMETERS FOR THE USER DEFINED E.T. TABLE ARE CHANGED
	ktrig	changed	gkNGradesET,gkRptRatioET,gkBasePitchET,gkBaseKeyET
	if ktrig=1 then							;IF A PARAMETER WHICH FORMS THE USER DEFINED E.T. TABLE IS CHANGED... 
	  reinit	UPDATE_TABLE					;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE_TABLE' 
	endif								;END OF CONDITIONAL BRANCH
	UPDATE_TABLE:							;LABEL CALLED 'UPDATE_TABLE'. REINITIALISATION PASS BEGINS FROM HERE.
	;CREATE THE USER DEFINED EQUALLY TEMPERED TABLE
	giTTable9	ftgen     9,         0,      128,        -2,i(gkNGradesET),i(gkRptRatioET),cpsmidinn(i(gkBasePitchET)),i(gkBaseKeyET)
	icount	=	0						;LOOP COUNTER / TABLE LOCATION
	iratio	=	1						;FIRST RATIO
		tableiw	iratio,4,giTTable9				;WRITE FIRST RATIO TO TABLE
	icount	=	1                                               ;LOOP COUNTER / TABLE LOCATION
	loop:								;LOOP BEGINNING
	iratio	=	iratio*(i(gkRptRatioET)^(1/i(gkNGradesET)))	;DERIVE RATIO FOR THIS TABLE LOCATION
		tableiw	iratio,icount+4,giTTable9			;WRITE RATIO VALUE TO TABLE
		loop_le	icount,1,i(gkNGradesET),loop			;CONDITIONALLY LOOP BACK TO LABEL 'loop' UNTIL ALL RATIOS (AS DEFINED BY 'Num.Grades') ARE COMPLETED
endin

instr	4	;CREATES USER TUNING TABLE OF FRACTIONS AND SCANS FOR CHANGES
	;CREATE A TRIGGER WHICH INFORMS WHENEVER ANY OF THE PARAMETERS FOR THE USER DEFINED TABLE ARE CHANGED
	ktrig	changed	gkNGradesF,gkRptRatioF,gkBasePitchF,gkBaseKeyF,gkN1,gkD1,gkN2,gkD2,gkN3,gkD3,gkN4,gkD4,gkN5,gkD5,gkN6,gkD6,gkN7,gkD7,gkN8,gkD8,gkN9,gkD9,gkN10,gkD10,gkN11,gkD11,gkN12,gkD12
	if ktrig=1 then					;IF A PARAMETER WHICH FORMS THE USER DEFINED TABLE IS CHANGED... 
	  reinit	UPDATE_TABLE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE_TABLE' 
	endif						;END OF CONDITIONAL BRANCH
	UPDATE_TABLE:					;LABEL CALLED 'UPDATE_TABLE'. REINITIALISATION PASS BEGINS FROM HERE.
	;CREATE THE USER DEFINED TUNING TABLE (AT I-TIME AND ALSO DURING REINITIALISATION PASSES)
	giTTable10	ftgen     10,0,64,-2,i(gkNGradesF),i(gkRptRatioF),cpsmidinn(i(gkBasePitchF)),i(gkBaseKeyF),i(gkN1)/i(gkD1),i(gkN2)/i(gkD2),i(gkN3)/i(gkD3),i(gkN4)/i(gkD4),i(gkN5)/i(gkD5),i(gkN6)/i(gkD6),i(gkN7)/i(gkD7),i(gkN8)/i(gkD8),i(gkN9)/i(gkD9),i(gkN10)/i(gkD10),i(gkN11)/i(gkD11),i(gkN12)/i(gkD12)
endin

instr		101                                                                                                                                                            
	ktrig1	changed	gktable	;IF TUNING TABLE COUNTER IS CHANGED GENERATE A TRIGGER IMPULSE
	;IF ANY OF THE USER DEFINED TABLE PARAMETERS ARE CHANGED GENERATE A DIFFERENT TRIGGER IMPULSE 
	ktrig2	changed	gkNGrades,gkRptRatio,gkBasePitch,gkBaseKey,gkratio1,gkratio2,gkratio3,gkratio4,gkratio5,gkratio6,gkratio7,gkratio8,gkratio9,gkratio10,gkratio11,gkratio12,gkratio13,gkratio14,gkratio15,gkratio16,gkratio17,gkratio18,gkratio19,gkratio20,gkratio21,gkratio22,gkratio23,gkratio24,gkNGradesET,gkRptRatioET,gkBasePitchET,gkBaseKeyET,gkNGradesF,gkRptRatioF,gkBasePitchF,gkBaseKeyF,gkN1,gkD1,gkN2,gkD2,gkN3,gkD3,gkN4,gkD4,gkN5,gkD5,gkN6,gkD6,gkN7,gkD7,gkN8,gkD8,gkN9,gkD9,gkN10,gkD10,gkN11,gkD11,gkN12,gkD12
	if ktrig1=1||(ktrig2=1&&(gktable=8||gktable=9||gktable=10)) then			;IF A PARAMETER WHICH FORMS ONE OF THE USER DEFINED TABLES IS CHANGED... 
	  reinit	REINITIALISE	;...BEGIN A REINITIALISATION PASS FROM LABEL 'REINITIALISE' 
	endif				;END OF CONDITIONAL BRANCH
	REINITIALISE:
	icps	cpstmid		i(gktable)			;PITCH VALUES ARE READ IN FROM THE MIDI KEYBOARD BUT ARE THEN TRANFORMED ACCORDING TO THE ALGORITHM IN THE SELECTED TUNING TABLE	
	ivel	veloc	0,1					;MIDI VELOCITY. RESCALED TO BE WITHIN THE RANGE 0 - 1. 
	rigoto	SKIP						;DON'T REINITIALISE THE gbuzz's kmul PARAMETER ON A REINITIALISATION PASS, JUMP TO LABEL 'skip'
	  kmul	linsegr	0,0.05,ivel*0.9,0.1,0			;PARTIAL STRENGTHS MULTIPLIER FOR GBUZZ - LIKE A TONE CONTROL
	  kwobble	jspline	0.02,8,40			;A LITTLE BIT OF WOBBLE WHICH WILL BE ADDED TO THE TONE CONTROL TO MAKE IT SOUND A LITTLE MORE NATURAL
	SKIP:							;LABEL
	aenv	linsegr	0,0.01,ivel*0.3,0.1,0			;AMPLITUDE ENVELOPE
	asig	gbuzz	aenv,icps,40,1,kmul-kwobble,gicos	;A GBUZZ RICH HARMONIC TONE GENERATOR
		out	asig					;SEND THE AUDIO SIGNAL CREATED BY THE OSCILLATOR TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;INSTRUMENT 2 (CREATES USER TUNING TABLE AND SCANS FOR CHANGES)
i 3 0 3600	;INSTRUMENT 3 (CREATES USER TUNING TABLE AND SCANS FOR CHANGES)
i 4 0 3600	;INSTRUMENT 4 (CREATES USER TUNING TABLE AND SCANS FOR CHANGES)
</CsScore>

</CsoundSynthesizer>