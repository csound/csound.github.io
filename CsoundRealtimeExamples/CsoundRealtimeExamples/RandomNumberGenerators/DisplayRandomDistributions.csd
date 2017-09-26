DisplayRandomDistributions.csd
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
;					LABEL                          | WIDTH | HEIGHT | X | Y
				FLpanel	"Display Random Distributions",   962,    550,    0,  0

iwidth	=	15
ix	=	0
#define	SLIDER(N)#                                                                           
;SLIDERS					   	MIN |  MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X  | Y
gkval,gih$N			FLslider 	"",	0,      1,   0,     4,    -1,   iwidth,     350,    ix,   0
ix	=	ix+iwidth#
$SLIDER(1)	
$SLIDER(2)	
$SLIDER(3)	
$SLIDER(4)	
$SLIDER(5)	
$SLIDER(6)	
$SLIDER(7)	
$SLIDER(8)	
$SLIDER(9)	
$SLIDER(10)	
$SLIDER(11)	
$SLIDER(12)	
$SLIDER(13)	
$SLIDER(14)	
$SLIDER(15)	
$SLIDER(16)	
$SLIDER(17)	
$SLIDER(18)	
$SLIDER(19)	
$SLIDER(20)	
$SLIDER(21)	
$SLIDER(22)	
$SLIDER(23)	
$SLIDER(24)	
$SLIDER(25)	
$SLIDER(26)	
$SLIDER(27)	
$SLIDER(28)	
$SLIDER(29)	
$SLIDER(30)	
$SLIDER(31)	
$SLIDER(32)	
$SLIDER(33)	
$SLIDER(34)	
$SLIDER(35)	
$SLIDER(36)	
$SLIDER(37)	
$SLIDER(38)	
$SLIDER(39)	
$SLIDER(40)	
$SLIDER(41)	
$SLIDER(42)	
$SLIDER(43)	
$SLIDER(44)	
$SLIDER(45)	
$SLIDER(46)	
$SLIDER(47)	
$SLIDER(48)	
$SLIDER(49)	
$SLIDER(50)	
$SLIDER(51)	
$SLIDER(52)	
$SLIDER(53)	
$SLIDER(54)	
$SLIDER(55)	
$SLIDER(56)	
$SLIDER(57)	
$SLIDER(58)	
$SLIDER(59)	
$SLIDER(60)	
$SLIDER(61)	
$SLIDER(62)	
$SLIDER(63)	
$SLIDER(64)

;SWITCHES                                		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkrecalc,gihrecalc	FLbutton	"Recalculate",	1,    1,     1,    120,     30,   740,355,   -1
FLsetTextSize	18,gihrecalc
FLsetColor	100,255,100,gihrecalc
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkopcode, ihopcode	FLbutBank	1,      11,    1,    60*11,    15,   75, 355,    -1;0,      1,   0,  -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"OPCODE:", 	1,      2,     12,     70,     17,    5, 355
ih		 	FLbox  	"gauss", 	1,      1,     13,     60,     15,   75, 370
ih		 	FLbox  	"poisson", 	1,      1,     13,     60,     15,  135, 370
ih		 	FLbox  	"exprand", 	1,      1,     13,     60,     15,  195, 370
ih		 	FLbox  	"bexprand", 	1,      1,     13,     60,     15,  255, 370
ih		 	FLbox  	"cauchy", 	1,      1,     13,     60,     15,  315, 370
ih		 	FLbox  	"pcauchy", 	1,      1,     13,     60,     15,  375, 370
ih		 	FLbox  	"betarand", 	1,      1,     13,     60,     15,  435, 370
ih		 	FLbox  	"trirand", 	1,      1,     13,     60,     15,  495, 370
ih		 	FLbox  	"unirand", 	1,      1,     13,     60,     15,  555, 370
ih		 	FLbox  	"linrand", 	1,      1,     13,     60,     15,  615, 370
ih		 	FLbox  	"weibull", 	1,      1,     13,     60,     15,  675, 370

;VALUE BOXES					 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gklambda, ihlambda	FLtext		"lambda", 	-1000,1000, 0.01,    1,    60,     20,    135,  390
gklambda2, ihlambda2	FLtext		"lambda", 	-1000,1000, 0.01,    1,    60,     20,    195,  390
gkrangebex, ihrangebex	FLtext		"range", 	-1000,1000, 0.01,    1,    60,     20,    255,  390
gkalpha, ihalpha	FLtext		"alpha", 	-1000,1000, 0.01,    1,    60,     20,    315,  390
gkalphap, ihalphap	FLtext		"alpha", 	-1000,1000, 0.01,    1,    60,     20,    375,  390
gkalpha2, ihalpha2	FLtext		"alpha", 	-1000,1000, 0.01,    1,    60,     20,    435,  390
gkbeta, ihbeta		FLtext		"beta", 	-1000,1000, 0.01,    1,    60,     20,    435,  430
gksigma, ihsigma	FLtext		"sigma", 	-1000,1000, 0.01,    1,    60,     20,    675,  390
gktau, ihtau		FLtext		"tau", 		-1000,1000, 0.01,    1,    60,     20,    675,  430
gkNVals, ihNVals	FLtext		"Number of Values",1,10000000, 1,    1,   120,     20,    740,  390

FLsetVal_i	10,ihlambda
FLsetVal_i	9.5,ihlambda2
FLsetVal_i	5,ihrangebex
FLsetVal_i	1000,ihalpha
FLsetVal_i	1000,ihalphap
FLsetVal_i	1,ihalpha2
FLsetVal_i	10,ihbeta
FLsetVal_i	20,ihsigma
FLsetVal_i	2,ihtau
FLsetVal_i	1000000,ihNVals

FLscroll     960, 100, 0, 470 
FLcolor	255,200,150
;TEXT BOXES																			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"---------------------------------------------------------------------------------------------------------------------", 	1,      6,     14,    940,    20,     5, 470
ih		 	FLbox  	"                                              Display Random Distributions                                           ", 	1,      6,     14,    940,    20,     5, 490
ih		 	FLbox  	"---------------------------------------------------------------------------------------------------------------------", 	1,      6,     14,    940,    20,     5, 510
ih		 	FLbox  	"Csound includes a number of opcodes for generating i,k or a-rate values according to a variety of random number      ", 	1,      5,     14,    940,    20,     5, 530
ih		 	FLbox  	"distributions. This example creates displays of these distributions and allows the user to modify their input        ", 	1,      5,     14,    940,    20,     5, 550
ih		 	FLbox  	"arguments. These representations are built by first creating a function table containing values generated by the     ", 	1,      5,     14,    940,    20,     5, 570
ih		 	FLbox  	"chosen opcode. The 64 point table is then used to set the values of 64 sliders. The number of values used to generate", 	1,      5,     14,    940,    20,     5, 590
ih		 	FLbox  	"each table can be set by the user. Using large numbers of values will produce a better defined distribution but will ", 	1,      5,     14,    940,    20,     5, 610
ih		 	FLbox  	"take longer to calculate. Parameters unique to each opcode are changed by modifying the values in the text boxes     ", 	1,      5,     14,    940,    20,     5, 630
ih		 	FLbox  	"below its button. Choosing a different opcode from the button bank array will cause the table to be recalculated. If ", 	1,      5,     14,    940,    20,     5, 650
ih		 	FLbox  	"changes are made to opcode parameters recalculation should be trigered manually. Some opcodes output positive values ", 	1,      5,     14,    940,    20,     5, 670
ih		 	FLbox  	"only and some output both positive and negative values (details below) but values output are rescaled to fit within  ", 	1,      5,     14,    940,    20,     5, 690
ih		 	FLbox  	"the range covered by the bank of sliders. This example is intended to provide an impression of the shape of          ", 	1,      5,     14,    940,    20,     5, 710
ih		 	FLbox  	"distributions - to investigate precise values output, look into the example: 'PrintDistribution.csd'.                ", 	1,      5,     14,    940,    20,     5, 730
ih		 	FLbox  	"'linrand', 'unirand', 'exprand', 'betarand' and 'pcauchy' produce positive values only, 'trirand', 'gauss', 'poisson'", 	1,      5,     14,    940,    20,     5, 750
ih		 	FLbox  	"'bexprnd', 'cauchy' and 'weibull' produce both positive and negative values.                                         ", 	1,      5,     14,    940,    20,     5, 770
ih		 	FLbox  	"Further investigation of these opcodes should begin with the Csound Reference Manual and continue with D. Lorrain's  ", 	1,      5,     14,    940,    20,     5, 790
ih		 	FLbox  	"'A Panoply of Stochastic Cannons'.                                                                                   ", 	1,      5,     14,    940,    20,     5, 810

FLscrollEnd
FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;TRIGGER DISTRIBUTION CREATION
	ktrig	changed	gkopcode	;GENERATE A TRIGGER IF OPCODE BUTTON BANK IS CHANGED
	;, gklambda,gklambda2, gkrangebex, gkalpha, gkalphap, gkalpha2, gkbeta, gksigma, gktau, gkNVals	;ADD THESE TO THE ABOVE LIST TO RECALCULATE WITHOUT HAVING TO PRESS RESET

	ktrig2	trigger	gkrecalc,0.5,0	;GENERATE A TRIGGER IF RECALCULATE BUTTON CHANGES FROM ZERO TO 1
	if ktrig==1||ktrig2==1 then	;IF EITHER OPCODE BUTTON BANK OF RESET BUTTON HAS CHANGED... 
	 reinit UPDATE			;REINITIALISE FROM LABEL 'UPDATE' 
	endif
	UPDATE:
	gkrecalc	init	0	;RESET RECALCUALTE BUTTON TO ZERO
	FLsetText	"Calculating...",gihrecalc	;CHANGE LABEL ON RESET BUTTON
	FLsetColor	255,50,50,gihrecalc	;RED
	event_i	"i",2,0.01,0		;TRIGGER INSTRUMENT THAT RECALCULATES THE TABLE AND DISPLAY
endin

instr	2
	idist	ftgen	1,0,64,2,0		;CREATE EMPTY TABLE
	iiterations	=	i(gkNVals)	;NUMBER OF VALUES/ITERATIONS FROM FL VALUE BOX
	;WE WILL KEEP TRACK OF THE MAXIMUM VALUE IN THE DISTRIBUTION FOR RESCALING THE SLIDERS
	imax	init	0			;INITIALISE MAXIMUM VALUE TO ZERO
	itabsize	=	ftlen(idist)	;TABLE SIZE
	icount	=	1			;COUNTER TO COUNT THE NUMBER OF VALUES CALCULATED SO FAR
	loop:					;LOOP FOR CALCULATING VALUES AND WRITING TO TABLES BEGINS HERE
	;GENERATE A RANDOM VALUE ACCORDING TO THE CHOSEN DISTRIBUTION TYPE (OPCODE). IN SOME CASES THIS VALUE WILL BE RESCALE TO FIT BETTER WITHIN THE TABLE.
	if i(gkopcode)==0 then
	 indx	gauss	itabsize/2		;RANGE = HALF TABLE SIZE (32). VALUES OUTPUT WILL BE WITHIN THE RANGE -32 AND 32
	 indx	=	indx+(itabsize/2)	;SHIFT THE DISTRIBUTION INTO THE POSITIVE DOMAIN 0 TO 64
	elseif i(gkopcode)==1 then
	 indx	poisson i(gklambda)
	elseif i(gkopcode)==2 then
	 indx	exprand i(gklambda2)
	elseif i(gkopcode)==3 then
	 indx	bexprnd i(gkrangebex)
	 indx	=	indx+(itabsize/2)
	elseif i(gkopcode)==4 then
	 indx	cauchy	i(gkalpha)
	 indx	=	indx+32	
	elseif i(gkopcode)==5 then
	 indx	pcauchy	i(gkalphap)
	elseif i(gkopcode)==6 then
	 kalpha	init	1
	 kbeta	init	1
	 indx	betarand 64, i(gkalpha2), i(gkbeta)
	elseif i(gkopcode)==7 then
	 indx	trirand	itabsize/2
	 indx	=	indx+(itabsize/2)
	elseif i(gkopcode)==8 then
	 indx	unirand	itabsize
	elseif i(gkopcode)==9 then
	 indx	linrand	itabsize
	elseif i(gkopcode)==10 then
	 indx	weibull	i(gksigma), i(gktau)
	endif
	;IF VALUE IS IN RANGE WRITE TO THE TABLE BY ADDIING A '1' TO THE VALUE CURRENTLY IN THAT LOCATION
	if indx>=0&&indx<itabsize then
	 ival	table	indx,idist	;READ FROM TABLE
	 ival	=	ival+1		;INCREMENT THE VALUE FOUND UP '1'
	 imax	=	(ival>imax?ival:imax)	;CHECK IF THIS IS THE MAXIMUM VALUE
	 	tableiw	ival,indx,idist		;WRITE NEW VALUE OVER THE OLD VALUE
	endif
	loop_le	icount,1,iiterations,loop	;LOOP BACK AND REPEAT CALCULATION PROCESS IF TOTAL NUMBER OF ITERATIONS HAS NOT YET BEEN REACHED

	;WRITE VALUES FROM TABLE TO SLIDERS
	icount	=	0				;COUNTER FOR WRITING VALUE
	loop2:						;LOOP BEGINS HERE
	ival	table	icount,idist			;READ VALUE
	FLsetVal_i	1-(ival/imax),gih1+icount	;INVERT VALUE, RESCALE BETWEEN ZERO AND 1 AND WRITE TO RELEVANT SLIDER
	loop_lt	icount,1,64,loop2			;LOOP BACK AND INREMENT COUNTER. N.B. COUNTER POINTS TO TABLE LOCATION AND FL SLIDER 

	FLsetText	"Recalculate",gihrecalc		;RESET LABEL ON RECALCULATE BUTTON
FLsetColor	100,255,100,gihrecalc
endin

</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>
