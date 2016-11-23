; Arrays.csd
; Written by Iain McCurdy, 2015

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL    | WIDTH | HEIGHT | X | Y
				FLpanel	"Arrays",   500,    600,    0,  0
 
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"gkArr[] fillarray ", 	1,      5,     12,     130,    15,    5,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  165,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  195,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  225,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  255,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  285,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  315,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  345,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  375,  14
ih	 	FLbox  	",", 			1,      5,     12,       5,    15,  405,  14

;TEXT INPUT BOXES			 MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gkI1,  ihI1	FLtext		"0",	 0,      10,     1,      1,      25,     20,   140,   10
gkI2,  ihI2	FLtext		"1",	 0,      10,     1,      1,      25,     20,   170,   10
gkI3,  ihI3	FLtext		"2",	 0,      10,     1,      1,      25,     20,   200,   10
gkI4,  ihI4	FLtext		"3",	 0,      10,     1,      1,      25,     20,   230,   10
gkI5,  ihI5	FLtext		"4",	 0,      10,     1,      1,      25,     20,   260,   10
gkI6,  ihI6	FLtext		"5",	 0,      10,     1,      1,      25,     20,   290,   10
gkI7,  ihI7	FLtext		"6",	 0,      10,     1,      1,      25,     20,   320,   10
gkI8,  ihI8	FLtext		"7",	 0,      10,     1,      1,      25,     20,   350,   10
gkI9,  ihI9	FLtext		"8",	 0,      10,     1,      1,      25,     20,   380,   10
gkI10, ihI10	FLtext		"9",	 0,      10,     1,      1,      25,     20,   410,   10

; summarray
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"sumarray(gkArr) =  ", 	1,      5,     12,     130,    15,   10,  54
;TEXT INPUT BOXES			 MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gksum,  gihsum	FLtext		"Sum",	 0,      10,     1,      1,      25,     20,   140,   50
FLsetColor	200,200,200,gihsum

; lenarray
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"lenarray(gkArr) =  ", 	1,      5,     12,     130,    15,   10,  94
;TEXT INPUT BOXES			 MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gklen,  gihlen	FLtext		"Length",0,      10,     1,      1,      25,     20,   140,   90
FLsetColor	200,200,200,gihlen

; index value
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"gkArr[", 	1,      5,     12,     60,    15,    10, 132
ih	 	FLbox  	"] = ", 	1,      5,     12,     30,    15,    87, 132
;TEXT INPUT BOXES			 MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gkndx,  ihndx	FLtext		"Ndx",	 0,      9,      1,      1,      25,     20,    63,  130
gkval,  gihval	FLtext		"Val",	 0,      10,     1,      1,      25,     20,   115,  130
FLsetColor	200,200,200,gihval

; minarray
;TEXT INPUT BOXES			 	MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gkmin,  gihmin		FLtext		"Min.", 0,      10,     1,      1,      25,     20,    10,  170
FLsetColor	200,200,200,gihmin
gkMinNdx,  gihMinNdx	FLtext		"Ndx",  0,       9,     1,      1,      25,     20,    50,  170
FLsetColor	200,200,200,gihMinNdx
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"minarray  gkArr", 	1,      5,     12,     130,    15,   80, 174
ih	 	FLbox  	",", 			1,      5,     12,      10,    15,   37, 174

; maxarray
;TEXT INPUT BOXES			 	MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gkmax,  gihmax		FLtext		"Max.", 0,      10,     1,      1,      25,     20,    10,  210
FLsetColor	200,200,200,gihmax
gkMaxNdx,  gihMaxNdx	FLtext		"Ndx",  0,       9,     1,      1,      25,     20,    50,  210
FLsetColor	200,200,200,gihMaxNdx
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"maxarray  gkArr", 	1,      5,     12,     130,    15,   80, 214
ih	 	FLbox  	",", 			1,      5,     12,      10,    15,   37, 214


;TEXT BOXES			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"", 	2,      5,     12,    480,      2,   10, 255




; 2 dimensional array
;TEXT INPUT BOXES			 MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gk1a,  ih1a	FLtext		"",	 0,      10,     1,      1,      25,     20,   200,  280
gk1b,  ih1b	FLtext		"",	 0,      10,     1,      1,      25,     20,   200,  310
gk1c,  ih1c	FLtext		"",	 0,      10,     1,      1,      25,     20,   200,  340
gk2a,  ih2a	FLtext		"",	 0,      10,     1,      1,      25,     20,   230,  280
gk2b,  ih2b	FLtext		"",	 0,      10,     1,      1,      25,     20,   230,  310
gk2c,  ih2c	FLtext		"",	 0,      10,     1,      1,      25,     20,   230,  340
gk3a,  ih3a	FLtext		"",	 0,      10,     1,      1,      25,     20,   260,  280
gk3b,  ih3b	FLtext		"",	 0,      10,     1,      1,      25,     20,   260,  310
gk3c,  ih3c	FLtext		"",	 0,      10,     1,      1,      25,     20,   260,  340

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"gkArr2[][]  init  9,9", 	1,      5,     12,    150,    15,     10,270
ih	 	FLbox  	"c0", 				1,      5,     12,     25,    15,    200,265
ih	 	FLbox  	"c1", 				1,      5,     12,     25,    15,    230,265
ih	 	FLbox  	"c2", 				1,      5,     12,     25,    15,    260,265
ih	 	FLbox  	"r0", 				1,      5,     12,     10,    15,    186,283
ih	 	FLbox  	"r1", 				1,      5,     12,     10,    15,    186,313
ih	 	FLbox  	"r2", 				1,      5,     12,     10,    15,    186,343

; sumarray
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"sumarray(gkArr2) =  ", 1,      5,     12,     130,    15,   10, 384
;TEXT INPUT BOXES			 	MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gksum2,  gihsum2	FLtext		"Sum",	 0,      10,     1,      1,      25,     20,   140,  380
FLsetColor	200,200,200,gihsum2

; lenarray
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"lenarray(gkArr2) =  ", 1,      5,     12,     130,    15,    10,  424
;TEXT INPUT BOXES			 MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gklen2,  gihlen2	FLtext	"Length",0,      10,     1,      1,      25,     20,   140,  420
FLsetColor	200,200,200,gihlen2

; index value
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"gkArr2[", 	1,      5,     12,     60,    15,     5, 462
ih	 	FLbox  	"][", 		1,      5,     12,     5,     15,    89, 462
ih	 	FLbox  	"] = ", 	1,      5,     12,     25,    15,   125, 462
;TEXT INPUT BOXES			 	MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gkndx1,  ihndx1		FLtext		"r",	0,      2,      1,      1,      25,     20,    60,  460
gkndx2,  ihndx2		FLtext		"c",	0,      2,      1,      1,      25,     20,   100,  460
gkval2,  gihval2	FLtext		"Val",	0,      10,     1,      1,      25,     20,   150,  460
FLsetColor	200,200,200,gihval2

; minarray
;TEXT INPUT BOXES			 	MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gkmin2,  gihmin2	FLtext		"Min.", 0,      10,     1,      1,      25,     20,    10,  500
FLsetColor	200,200,200,gihmin2
gkMinNdx2,  gihMinNdx2	FLtext		"Ndx",  0,       9,     1,      1,      25,     20,    50,  500
FLsetColor	200,200,200,gihMinNdx2	
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"minarray  gkArr2", 	1,      5,     12,     130,    15,   80, 504
ih	 	FLbox  	",", 			1,      5,     12,      10,    15,   37, 504

; maxarray
;TEXT INPUT BOXES			 	MIN   | MAX  | STEP  | TYPE | WIDTH | HEIGHT | X   | Y
gkmax2,  gihmax2	FLtext		"Max.", 0,      10,     1,      1,      25,     20,    10,  540
FLsetColor	200,200,200,gihmax2	
gkMaxNdx2,  gihMaxNdx2	FLtext		"Ndx",  0,       9,     1,      1,      25,     20,    50,  540
FLsetColor	200,200,200,gihMaxNdx2	
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 	FLbox  	"maxarray  gkArr2", 	1,      5,     12,     130,    15,   80, 544
ih	 	FLbox  	",", 			1,      5,     12,      10,    15,   37, 544


;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	1, 	ihI1	
				FLsetVal_i	2, 	ihI2	
				FLsetVal_i	3, 	ihI3	
				FLsetVal_i	4, 	ihI4	
				FLsetVal_i	5, 	ihI5	
				FLsetVal_i	6, 	ihI6	
				FLsetVal_i	7, 	ihI7	
				FLsetVal_i	8, 	ihI8	
				FLsetVal_i	9, 	ihI9	
				FLsetVal_i	10, 	ihI10
				FLsetVal_i	1, 	ih1a	
				FLsetVal_i	2, 	ih1b
				FLsetVal_i	3, 	ih1c	
				FLsetVal_i	4, 	ih2a
				FLsetVal_i	5, 	ih2b
				FLsetVal_i	6, 	ih2c
				FLsetVal_i	7, 	ih3a
				FLsetVal_i	8, 	ih3b
				FLsetVal_i	9, 	ih3c

				FLpanel_end


;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     400,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           Arrays                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This interactive example demonstrates some of Csound's new   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"techniques for working with arrays.                          ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The white boxes are intended for user modification, the grey ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"boxes are intended for the feedback of results.              ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Two arrays are used in this example: a 1-dimensional array,  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"gkArr[] and a 2-dimensional array gkArr2[][]. GUI interaction", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"with the two arrays is separated by the horizonatal line.    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"'fillarray' is used to fill an array with values.            ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"'sumarray' returns the sum of all array elements.            ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"'lenarray' returns the length of the array.                  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"gkArr[kndx] = is used to derive of the value of an array     ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"element at the location kndx.                                ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"'minarray' return the lowest value held within an array along", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"with its location (Ndx).                                     ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"gkArr2[kR][kC] is used to derive a value from a 2-dimensional", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"array. kR = row, kC = column.                                ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Some of the functions do not appear to currently work with   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"multidimensional arrays.                                     ", 	1,      5,     14,    490,    15,     5, 380
                                                             
				FLpanel_end                                                   
                                                             
				FLrun	;RUN THE FLTK WIDGET THREAD                          
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                



gkArr[]	fillarray	1,2,3,4,5,6,7,8,9,10
gkArr2[][]	init	3,3

instr	1
gkArr[0]	=	gkI1
gkArr[1]	=	gkI2
gkArr[2]	=	gkI3
gkArr[3]	=	gkI4
gkArr[4]	=	gkI5
gkArr[5]	=	gkI6
gkArr[6]	=	gkI7
gkArr[7]	=	gkI8
gkArr[8]	=	gkI9
gkArr[9]	=	gkI10

gkArr2[0][0]	=	gk1a
gkArr2[1][0]	=	gk1b
gkArr2[2][0]	=	gk1c
gkArr2[0][1]	=	gk2a
gkArr2[1][1]	=	gk2b
gkArr2[2][1]	=	gk2c
gkArr2[0][2]	=	gk3a
gkArr2[1][2]	=	gk3b
gkArr2[2][2]	=	gk3c

; i dimensional array gkArr
	FLsetVal	changed(sumarray(gkArr)),sumarray(gkArr),gihsum
	FLsetVal	changed(lenarray(gkArr)),lenarray(gkArr),gihlen
	FLsetVal	changed(gkndx),gkArr[gkndx],gihval
kmin,kMinNdx	minarray	gkArr
	FLsetVal	changed(kmin),kmin,gihmin
	FLsetVal	changed(kMinNdx),kMinNdx,gihMinNdx
kmax,kMaxNdx	maxarray	gkArr
	FLsetVal	changed(kmax),kmax,gihmax
	FLsetVal	changed(kMaxNdx),kMaxNdx,gihMaxNdx

; 2 dimensional array gkArr2
;ksum	sumarray	gkArr2
;	FLsetVal	changed(ksum),ksum,gihsum2
	FLsetVal	changed(lenarray(gkArr2)),lenarray(gkArr2),gihlen2
ktrig	changed		gkndx1,gkndx2
kval	=		gkArr2[gkndx1][gkndx2]
	FLsetVal	ktrig,kval,gihval2
kmin2,kMinNdx2	minarray	gkArr2
	FLsetVal	changed(kmin2),kmin2,gihmin2
	FLsetVal	changed(kMinNdx2),kMinNdx2,gihMinNdx2
kmax2,kMaxNdx2	maxarray	gkArr2
	FLsetVal	changed(kmax2),kmax2,gihmax2
	FLsetVal	changed(kMaxNdx2),kMaxNdx2,gihMaxNdx2

endin



  	
</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>