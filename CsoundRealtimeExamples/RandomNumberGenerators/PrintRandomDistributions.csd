PrintRandomDistributions.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	8
nchnls 		= 	1
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL                        | WIDTH | HEIGHT | X | Y
				FLpanel	"Print Random Distributions",   760,    220,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihresults	 	FLbox  	" ", 	6,        9,    15,    754,    56,    3, 160	;
FLsetColor	200,255,255,ihresults
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkopcode, ihopcode	FLbutBank	1,      11,    1,    60*11,    15,   75,  5,    -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"OPCODE:", 	1,      2,     12,     60,     15,    5,   4
ih		 	FLbox  	"gauss", 	1,      1,     13,     60,     12,   75,  20
ih		 	FLbox  	"poisson", 	1,      1,     13,     60,     12,  135,  20
ih		 	FLbox  	"exprand", 	1,      1,     13,     60,     12,  195,  20
ih		 	FLbox  	"bexprand", 	1,      1,     13,     60,     12,  255,  20
ih		 	FLbox  	"cauchy", 	1,      1,     13,     60,     12,  315,  20
ih		 	FLbox  	"pcauchy", 	1,      1,     13,     60,     12,  375,  20
ih		 	FLbox  	"betarand", 	1,      1,     13,     60,     12,  435,  20
ih		 	FLbox  	"trirand", 	1,      1,     13,     60,     12,  495,  20
ih		 	FLbox  	"unirand", 	1,      1,     13,     60,     12,  555,  20
ih		 	FLbox  	"linrand", 	1,      1,     13,     60,     12,  615,  20
ih		 	FLbox  	"weibull", 	1,      1,     13,     60,     12,  675,  20

;VALUE BOXES					 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkrangeg, ihrangeg	FLtext		"range", 	-1000,1000, 0.01,    1,     60,     20,    75,  35
gklambdap, ihlambdap	FLtext		"lambda", 	-1000,1000, 0.01,    1,     60,     20,   135,  35
gklambdae, ihlambdae	FLtext		"lambda", 	-1000,1000, 0.01,    1,     60,     20,   195,  35
gkrangeb, ihrangeb	FLtext		"range", 	-1000,1000, 0.01,    1,     60,     20,   255,  35
gkalphac, ihalphac	FLtext		"alpha", 	-1000,1000, 0.01,    1,     60,     20,   315,  35
gkalphap, ihalphap	FLtext		"alpha", 	-1000,1000, 0.01,    1,     60,     20,   375,  35
gkrangeb, ihrangeb	FLtext		"range", 	-1000,1000, 0.01,    1,     60,     20,   435,  35
gkalphab, ihalphab	FLtext		"alpha", 	-1000,1000, 0.01,    1,     60,     20,   435,  75
gkbetab, ihbetab	FLtext		"beta", 	-1000,1000, 0.01,    1,     60,     20,   435, 115
gkranget, ihranget	FLtext		"range", 	-1000,1000, 0.01,    1,     60,     20,   495,  35
gkrangeu, ihrangeu	FLtext		"range", 	-1000,1000, 0.01,    1,     60,     20,   555,  35
gkrangel, ihrangel	FLtext		"range", 	-1000,1000, 0.01,    1,     60,     20,   615,  35
gksigmaw, ihsigmaw	FLtext		"sigma", 	-1000,1000, 0.01,    1,     60,     20,   675,  35
gktauw, ihtauw		FLtext		"tau", 		-1000,1000, 0.01,    1,     60,     20,   675,  75
gkval, gihval		FLtext		"Value",    -10000000,10000000,0,    1,     90,     20,   165, 170
gkNVals, gihNVals	FLtext	"N. Vals. in Test",         0,10000000,0,    1,     90,     20,   260, 170
gkaverage, gihaverage	FLtext	"Average",         -10000000,10000000, 0,    1,     90,     20,   355, 170
gkmin, gihmin		FLtext	"Minimum",         -10000000,10000000, 0,    1,     90,     20,   450, 170
gkmax, gihmax		FLtext	"Maximum",         -10000000,10000000, 0,    1,     90,     20,   545, 170

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idrate				FLvalue	" ",     50,      18,   10, 190

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;SLIDERS			            	MIN | MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X | Y
gkrate, ihrate		FLslider 	"Rate",	0.1, 1000,  -1,    23,   idrate,     150,     20,   10, 170

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;SWITCHES                              		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkreset,ihreset	FLbutton	"RESET",	1,    1,    21,    80,     20,   650,170,   -1

FLsetVal_i	1, ihrangeg
FLsetVal_i	1,ihlambdap
FLsetVal_i	1,ihlambdae
FLsetVal_i	1,ihrangeb
FLsetVal_i	1,ihalphac
FLsetVal_i	1000,ihalphap
FLsetVal_i	1,ihrangeb
FLsetVal_i	1,ihalphab
FLsetVal_i	1,ihbetab
FLsetVal_i	1,ihranget
FLsetVal_i	1,ihrangeu
FLsetVal_i	1,ihrangel
FLsetVal_i	1,ihsigmaw
FLsetVal_i	1,ihtauw
FLsetVal_i	1, ihrate

FLpanel_end

;	LABEL           | WIDTH | HEIGHT | X | Y
	FLpanel	"Info.",   760,    150,    0, 270
	FLscroll           760,    150,    0, 0
;TEXT BOXES																TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"--------------------------------------------------------------------------------------------", 	1,      6,     14,    740,    20,     0,   0
ih		 	FLbox  	"                                   Print Random Distributions                               ", 	1,      6,     14,    740,    20,     0,  20
ih		 	FLbox  	"--------------------------------------------------------------------------------------------", 	1,      6,     14,    740,    20,     0,  40
ih		 	FLbox  	"This example prints values output by Csound's various opcodes for the generation of random  ", 	1,      5,     14,    740,    20,     0,  60
ih		 	FLbox  	"numbers to the terminal and to an FL value box. Additional data for the average value so    ", 	1,      5,     14,    740,    20,     0,  80
ih		 	FLbox  	"far, the total number of values generated, minimum and maximum are also printed to the      ", 	1,      5,     14,    740,    20,     0, 100
ih		 	FLbox  	"terminal and FLTK GUI. This additional data gathering is automatically reset each time a new", 	1,      5,     14,    740,    20,     0, 120
ih		 	FLbox  	"opcode is chosen. Manual reset is also available. Parameters relating to each of the opcodes", 	1,      5,     14,    740,    20,     0, 140
ih		 	FLbox  	"can be changed using the FL value boxes listed under the relevant buttons.                  ", 	1,      5,     14,    740,    20,     0, 160
ih		 	FLbox  	"Further investigation of these opcodes should begin with the Csound Reference Manual and    ", 	1,      5,     14,    740,    20,     0, 180
ih		 	FLbox  	"continue with D. Lorrain's 'A Panoply of Stochastic Cannons'.                               ", 	1,      5,     14,    740,    20,     0, 200

FLscroll_end
FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;TRIGGER VALUE GENERATION AND SENSE FOR RESETTING OF DATA
	ktrig	metro	gkrate			;RATE OF RANDOM VALUE GENERATION 
	schedkwhen	ktrig,0,0,2,0,0		;TRIGGER INSTRUMENT THAT WILL GENERATE A RANDOM VALUE
	kchanged	changed	gkopcode	;SENSE OF OPCODE BUTTON BANK HAS CHANGED
	kresettrig	trigger	gkreset,0.5,0	;SENSE IF RESET BUTTON HAS BEEN PRESSED
	if kchanged==1||kresettrig==1 then	;IF OPCODE HAS CHANGED OR RESET BUTTON HAS BEEN PRESSED...
	 reinit	RESET				;BEGIN A REINITIALISATION PASS FROM LABEL 'RESET'
	endif					
	RESET:					;LABEL
	;INITIALISE DATA TO ZERO
	gkreset		init	0
	gival		init	0
	giNVals		init	0
	gitotal		init	0
	giaverage	init	0
	gimin		init	0
	gimax		init	0	
	;PRINT INITIAL DATA TO FL BOXES
	FLsetVal_i	giNVals,	gihNVals	
	FLsetVal_i	giaverage,	gihaverage	
	FLsetVal_i	gimin,	        gihmin	        
	FLsetVal_i	gimax,		gihmax
	FLsetVal_i	0,		gihval
	;PRINT OPCODE NAME TO TERMINAL
	if i(gkopcode)==0 then
	 prints	"\n--GAUSS--\n"
	elseif i(gkopcode)==1 then
	 prints	"\n--POISSON--\n"
	elseif i(gkopcode)==2 then
	 prints	"\n--EXPRAND--\n"
	elseif i(gkopcode)==3 then
	 prints	"\n--BEXPRAND--\n"
	elseif i(gkopcode)==4 then
	 prints	"\n--CAUCHY--\n"
	elseif i(gkopcode)==5 then
	 prints	"\n--PCAUCHY--\n"
	elseif i(gkopcode)==6 then
	 prints	"\n--BETARAND--\n"
	elseif i(gkopcode)==7 then
	 prints	"\n--TRIRAND--\n"
	elseif i(gkopcode)==8 then
	 prints	"\n--UNIRAND--\n"
	elseif i(gkopcode)==9 then
	 prints	"\n--LINRAND--\n"
	elseif i(gkopcode)==10 then
	 prints	"\n--WEIBULL--\n"
	endif		
endin

instr	2	;GENERATE A RANDOM VALUE
	giNVals	=	giNVals+1		;INCREMENT NUMBER OF VALUES GENERATED IN THIS SET
	FLsetVal_i	giNVals,gihNVals	;PRINT NUMBER OF VALUES TO FL VALUE BOX
	;GENERATE A RANDOM NUMBER (ival) ACCORDING TO THE CHOSEN DISTRIBUTION TYPE (OPCODE)
	if i(gkopcode)==0 then
	 ival	gauss	i(gkrangeg)
	elseif i(gkopcode)==1 then
	 ival	poisson	i(gklambdap)
	elseif i(gkopcode)==2 then
	 ival	exprand i(gklambdae)
	elseif i(gkopcode)==3 then
	 ival	bexprnd i(gkrangeb)
	elseif i(gkopcode)==4 then
	 ival	cauchy	i(gkalphac)
	elseif i(gkopcode)==5 then
	 ival	pcauchy	i(gkalphap)
	elseif i(gkopcode)==6 then
	 ival	betarand i(gkrangeb), i(gkalphab), i(gkbetab)
	elseif i(gkopcode)==7 then
	 ival	trirand	i(gkranget)
	elseif i(gkopcode)==8 then
	 ival	unirand	i(gkrangeu)
	elseif i(gkopcode)==9 then
	 ival	linrand	i(gkrangel)
	elseif i(gkopcode)==10 then
	 ival	weibull	i(gksigmaw), i(gktauw)
	endif
	;PRINT DATA TO FL VALUE BOXES
	FLsetVal_i	ival, gihval
	gitotal	=	gitotal+ival
	FLsetVal_i	gitotal/giNVals, gihaverage
	gimin	=	(ival<gimin?ival:gimin)
	FLsetVal_i	gimin, gihmin
	gimax	=	(ival>gimax?ival:gimax)
	FLsetVal_i	gimax, gihmax
	;PRINT DATA TO TERMINAL
	prints	"Val: %f%tN.Vals.: %d%tAv.: %f%tMin.: %f%tMax.: %f%n",ival,giNVals,gitotal/giNVals,gimin,gimax
endin

</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>
