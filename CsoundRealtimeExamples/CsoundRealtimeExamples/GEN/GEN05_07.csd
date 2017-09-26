GEN05_07.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

/*///////////////////////////////////////////////////////// FLTK INTERFACE CODE ///////////////////////////////////////////////////////*/
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL      | WIDTH | HEIGHT | X | Y
		FLpanel	"GEN05_07",   500,     790,   0,  0

/*//////////////////////////////////////////////////////////// MAIN CONTROL ///////////////////////////////////////////////////////////*/
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    21,    150,     25,    5,  5,   -1; 0,      2,      0,      0.01
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
iddur			FLvalue	" ",	80,      20,     5,  75

;SLIDERS					      			MIN |  MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkdur, ihdur		FLslider	"Duration",  			0.1,    8,   -1,    23,   iddur,     490,     25,    5,   50

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	2, 	ihdur
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

/*///////////////////////////////////////////////////////// AMPLITUDE ENVELOPE ///////////////////////////////////////////////////////*/
;BORDERS AND TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 			6,      9,     15,    496,     322,   2, 118	;BORDER AROUND AMPLITUDE ENVELOPE
ih		 	FLbox  	"Amplitude Envelope", 	0,     11,     14,    130,      20,   5, 120	;BORDER AROUND AMPLITUDE ENVELOPE

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkamptype, ihamptype	FLbutBank	14,     1,     2,     18,      30,    10,400,  -1   
                                                                                                   
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN   
;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"GEN05",			1,       6,    11,     50,     15,   25, 400
ih		 	FLbox  	"GEN07",			1,       6,    11,     50,     15,   25, 415

;NUMBER DISPLAY BOXES				WIDTH | HEIGHT | X | Y
idampval1		FLvalue	"val 1",	60,      20,    90, 400
idampdur1		FLvalue	"dur 1",	60,      20,   155, 400
idampval2		FLvalue	"val 2",	60,      20,   220, 400
idampdur2		FLvalue	"dur 2",	60,      20,   285, 400
idampval3		FLvalue	"val 3",	60,      20,   350, 400

;SLIDERS					      			MIN    |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkampval1, ihampval1	FLslider	"Amplitude Val. 1",  		0.001,      1,   0,    23,  idampval1,   490,     25,    5,  150
gkampdur1, ihampdur1	FLslider	"Amplitude Dur. 1",  		1,       4096,   0,    23,  idampdur1,   490,     25,    5,  200
gkampval2, ihampval2	FLslider	"Amplitude Val. 2",  		0.001,      1,   0,    23,  idampval2,   490,     25,    5,  250
gkampdur2, ihampdur2	FLslider	"Amplitude Dur. 2",  		1,       4096,   0,    23,  idampdur2,   490,     25,    5,  300
gkampval3, ihampval3	FLslider	"Amplitude Val. 3",  		0.001,      1,   0,    23,  idampval3,   490,     25,    5,  350

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0.001, 	ihampval1
		FLsetVal_i	2048, 	ihampdur1
		FLsetVal_i	1, 	ihampval2
		FLsetVal_i	2048, 	ihampdur2
		FLsetVal_i	0.001, 	ihampval3
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

/*/////////////////////////////////////////////////////////// PITCH ENVELOPE /////////////////////////////////////////////////////////*/
;BORDERS AND TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 			6,      9,     15,    496,     322,   2, 448	;BORDER AROUND PITCH ENVELOPE
ih		 	FLbox  	"Pitch Envelope", 	0,     11,     14,    130,      20,   5, 450	;BORDER AROUND PITCH ENVELOPE

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkpchtype, ihpchtype	FLbutBank	14,     1,     2,     18,      30,    10,730,  -1   
                                                                                                   
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN   
;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"GEN05",			1,       6,    11,     50,     15,   25, 730
ih		 	FLbox  	"GEN07",			1,       6,    11,     50,     15,   25, 745

;NUMBER DISPLAY BOXES				WIDTH | HEIGHT | X | Y
idpchval1		FLvalue	"val 1",	60,      20,    90, 730
idpchdur1		FLvalue	"dur 1",	60,      20,   155, 730
idpchval2		FLvalue	"val 2",	60,      20,   220, 730
idpchdur2		FLvalue	"dur 2",	60,      20,   285, 730
idpchval3		FLvalue	"val 3",	60,      20,   350, 730

;SLIDERS					      		MIN    |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkpchval1, ihpchval1	FLslider	"Pitch Val. 1",  	6,          9,   0,    23,  idpchval1,   490,     25,    5,  480
gkpchdur1, ihpchdur1	FLslider	"Pitch Dur. 1",  	1,       4096,   0,    23,  idpchdur1,   490,     25,    5,  530
gkpchval2, ihpchval2	FLslider	"Pitch Val. 2",  	6,          9,   0,    23,  idpchval2,   490,     25,    5,  580
gkpchdur2, ihpchdur2	FLslider	"Pitch Dur. 2",  	1,       4096,   0,    23,  idpchdur2,   490,     25,    5,  630
gkpchval3, ihpchval3	FLslider	"Pitch Val. 3",  	6,          9,   0,    23,  idpchval3,   490,     25,    5,  680

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	8, 	ihpchval1
		FLsetVal_i	2048, 	ihpchdur1
		FLsetVal_i	8, 	ihpchval2
		FLsetVal_i	2048, 	ihpchdur2
		FLsetVal_i	8, 	ihpchval3
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

		FLpanel_end	;END OF PANEL CONTENTS

/*//////////////////////////////////////////////// INSTRUCTIONS AND INFO PANEL ///////////////////////////////////////////////////////*/

				FLpanel	" ", 515, 740, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        GEN05 GEN07                          ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"GEN05 and GEN07 are used to create function tables in break- ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"point fashion. In the case of GEN05 segments are             ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"exponentially shaped whereas in the case of GEN07 segments   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"are linear. These tables can contain an arbitrary number of  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"segments but must always begin and end with a value. In this ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"example two function tables are created, each consisting of  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"two segments. Segment lengths are defined in terms of table  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"storage points and therefore relate to the size of the table ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"as defined by its p3 parameter. In this example both tables  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"are of size 4096.                                            ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"If a segment exceeds the end of the table, that part of the  ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"segment that proposes to go beyond the end of the table is   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"ignored. If only part of the table's total storage capacity  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"is explicitly filled with segments, the unused section of the", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"table is filled with zeroes.                                 ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"There are two rules by which we must abide when defining     ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"values for GEN05 tables. Values cannot be zero and must be   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"alike in sign. If we require a zero we can instead use a     ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"very small value close to zero. If we require a GEN05        ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"derived envelope to touch zero we can subtract this offset in", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"the orchestra. GEN07 does not have these restrictions.       ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"In this example amplitude and pitch envelopes can be defined ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"and edited by the user. Pitch is defined in the 'oct' format.", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"These function tables are read in the orchestra using oscils.", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"The function tables themselves are created in the orchestra  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"and are updated each time a change is made. If you enable    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"displays for Csound (i.e. don't use the -d flag) you can     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"examine the updated displays of these function tables.       ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"Even though segment lengths are defined here using sliders   ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"which output fractional values, the values as used by GEN05  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"for segment lengths will ignore the fractional part.         ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"The user can switch between GEN05 and GEN07 to observe, both ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"visually and aurally, the difference.                        ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"If you require greater control of segment curvature on a     ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"segment by segment basis you might like to look into GEN16.  ", 	1,      5,     14,    490,    20,     5, 720

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD

/*////////////////////////////////////////////// END OF FLTK INTERFACE CODE ///////////////////////////////////////////////////////////*/

instr	1
	ktrig1	changed	       gkampval1,gkampdur1,gkampval2,gkampdur2,gkampval3,gkamptype	;IF ANY OF THE PARAMETERS FOR THE CREATION OF THE AMPLITUDE ENVELOPE HAVE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT IN VARIABLE ktrig1
	ktrig2	changed	       gkpchval1,gkpchdur1,gkpchval2,gkpchdur2,gkpchval3,gkpchtype	;IF ANY OF THE PARAMETERS FOR THE CREATION OF THE PITCH ENVELOPE HAVE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT IN VARIABLE ktrig2
	if ktrig1=1 then	;IF A VARIABLE USED FOR THE CREATION OF AMPLITUDE ENVELOPE HAS BEEN CHANGED...
	  reinit UPDATE1	;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE1'
	  UPDATE1:		;LABEL CALLED 'UPDATE1'. REINITIALISATION OF AMPLITUDE ENVELOPE BEGINS HERE
	  if i(gkamptype)=0 then	;IF FUNCTION TABLE GEN TYPE '5' HAS BEEN CHOSEN FOR AMPLITUDE ENVELOPE...
	    ;CREATE A FUNCTION TABLE USING GEN05 THAT WILL BE USED FOR THE AMPLITUDE ENVELOPE
	    ;THE USE OF A MINUS SIGN BEFORE THE GEN NUMBER ENSURES THAT THE FUNCTION TABLE WILL NOT BE POST NORMALISED
	    ;USE OF A SPECIFIC NUMBER FOR FUNCTION TABLE NUMBER (P1) - I.E. NOT ZERO - ENSURES THAT THE OLD TABLE WILL BE OVERWRITTEN WHENEVER IT IS OVERWRITTEN EACH TIME ONE OF ITS PARAMETERS HAS BEEN CHANGED
	    giampenv	ftgentmp	1,0,4096,-5,i(gkampval1),i(gkampdur1),i(gkampval2),i(gkampdur2),i(gkampval3)	;CREATE AMPLITUDE ENVELOPE USING GEN05
	  else		;OTHERWISE...
	    		;...CREATE A FUNCTION TABLE USING GEN07 THAT WILL BE USED FOR THE AMPLITUDE ENVELOPE
	    giampenv	ftgentmp	1,0,4096,-7,i(gkampval1),i(gkampdur1),i(gkampval2),i(gkampdur2),i(gkampval3)	;CREATE AMPLITUDE ENVELOPE USING GEN07
	  endif		;END OF THIS CONDITIONAL BRANCH
	  rireturn	;RETURN FROM REINITIALISATION PASS
	endif		;END OF CONDITIONAL BRANCH
	if ktrig2=1 then	;IF A VARIABLE USED FOR THE CREATION OF PITCH ENVELOPE HAS BEEN CHANGED...
	  reinit UPDATE2	;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE2'
	  UPDATE2:		;LABEL CALLED 'UPDATE2'. REINITIALISATION OF AMPLITUDE ENVELOPE BEGINS HERE
	  if i(gkpchtype)=0 then	;IF FUNCTION TABLE GEN TYPE '5' HAS BEEN CHOSEN FOR PITCH ENVELOPE...
	    ;CREATE A FUNCTION TABLE USING GEN05 THAT WILL BE USED FOR THE PITCH ENVELOPE
	    ;THE USE OF A MINUS SIGN BEFORE THE GEN NUMBER ENSURES THAT THE FUNCTION TABLE WILL NOT BE POST NORMALISED
	    ;USE OF A SPECIFIC NUMBER FOR FUNCTION TABLE NUMBER (P1) - I.E. NOT ZERO - ENSURES THAT THE OLD TABLE WILL BE OVERWRITTEN WHENEVER IT IS OVERWRITTEN EACH TIME ONE OF ITS PARAMETERS HAS BEEN CHANGED
	    gipchenv	ftgentmp	2,0,4096,-5,i(gkpchval1),i(gkpchdur1),i(gkpchval2),i(gkpchdur2),i(gkpchval3)	;CREATE PITCH ENVELOPE USING GEN05
	  else		;OTHERWISE...
	    		;...CREATE A FUNCTION TABLE USING GEN07 THAT WILL BE USED FOR THE AMPLITUDE ENVELOPE
	    gipchenv	ftgentmp	2,0,4096,-7,i(gkpchval1),i(gkpchdur1),i(gkpchval2),i(gkpchdur2),i(gkpchval3)	;CREATE PITCH ENVELOPE USING GEN07
	  endif		;END OF THIS CONDITIONAL BRANCH
	  rireturn	;RETURN FROM REINITIALISATION PASS
	endif		;END OF THIS CONDITIONAL BRANCH
endin

instr	2
	ktrig	changed	gkOnOff
	if ktrig==1 then
	 event	"i",3,0,i(gkdur)
	 gkOnOff=0
	endif
endin

instr	3
	p3	=	i(gkdur)		;SET UP NOTE DURATION (FLTK DERIVED DURATION WILL BE OVER-RIDDEN)
	kline	line	0,1,1
	if kline>=p3 then
	 turnoff
	endif
	kenv	oscil	1, 1/p3, giampenv	;READ AMPLITUDE ENVELOPE
	kpch	oscil	1, 1/p3, gipchenv	;READ PITCH ENVELOPE (OCT FORMAT)
	a1	vco2	(0.4*kenv)-0.001,cpsoct(kpch),4,0.5	;CREATE AUDIO OSCILLATOR (TRIANGLE WAVE), AMPLITUDE AND PITCH DEFINED USING GEN05 FUNCTION TABLE DERIVED ENVELOPES. NOTE THE OFFSETTING OF AMPLITUDE SO THAT ZERO VALUES ARE PERMITTED
		out	a1					;SEND AUDIO TO OUTPUT
endin


</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS REALTIME PERFORMANCE GOING)
i 2 0 3600	;INSTRUMENT 2 PLAYS A NOTE FOR 1 HOUR (AND KEEPS REALTIME PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>