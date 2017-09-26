GEN25_27.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

/*///////////////////////////////////////////////////////// FLTK INTERFACE CODE ///////////////////////////////////////////////////////*/
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL      | WIDTH | HEIGHT | X | Y
		FLpanel	"GEN25_27",   500,     790,   0,  0

/*//////////////////////////////////////////////////////////// MAIN CONTROL ///////////////////////////////////////////////////////////*/
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    21,    150,     25,    5,  5,    -1;0,      2,      0,      0.01
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
iddur			FLvalue	" ",	80,      20,     5,  75

;SLIDERS					      		MIN |  MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkdur, ihdur		FLslider	"Total Duration",	0.1,    8,   -1,    23,   iddur,     490,     25,    5,   50

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
ih		 	FLbox  	"GEN25",			1,       6,    11,     50,     15,   25, 400
ih		 	FLbox  	"GEN27",			1,       6,    11,     50,     15,   25, 415

;NUMBER DISPLAY BOXES				WIDTH | HEIGHT | X | Y
idamploc1		FLvalue	"loc 1",	60,      17,    90, 400                                  
idampval1		FLvalue	"val 1",	60,      17,   145, 400
idamploc2		FLvalue	"loc 2",	60,      17,   200, 400
idampval2		FLvalue	"val 2",	60,      17,   255, 400
idamploc3		FLvalue	"loc 3",	60,      17,   310, 400
idampval3		FLvalue	"val 2",	60,      17,   365, 400
                                                      
;SLIDERS					      			MIN    |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkamploc1, ihamploc1	FLslider	"Amplitude Loc. 1",  		0,       4096,   0,    23,  idamploc1,   490,     15,    5,  150
gkampval1, ihampval1	FLslider	"Amplitude Val. 1",  		0.001,      1,   0,    23,  idampval1,   490,     15,    5,  190
gkamploc2, ihamploc2	FLslider	"Amplitude Loc. 2",  		0,       4096,   0,    23,  idamploc2,   490,     15,    5,  230
gkampval2, ihampval2	FLslider	"Amplitude Val. 2",  		0.001,      1,   0,    23,  idampval2,   490,     15,    5,  270
gkamploc3, ihamploc3	FLslider	"Amplitude Loc. 3",  		0,       4096,   0,    23,  idamploc3,   490,     15,    5,  310
gkampval3, ihampval3	FLslider	"Amplitude Val. 3",  		0.001,      1,   0,    23,  idampval3,   490,     15,    5,  350

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0, 	ihamploc1
		FLsetVal_i	0.001, 	ihampval1                                                       
		FLsetVal_i	2048, 	ihamploc2
		FLsetVal_i	1, 	ihampval2
		FLsetVal_i	4096, 	ihamploc3
		FLsetVal_i	0, 	ihampval3
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
ih		 	FLbox  	"GEN25",			1,       6,    11,     50,     15,   25, 730
ih		 	FLbox  	"GEN27",			1,       6,    11,     50,     15,   25, 745

;NUMBER DISPLAY BOXES				WIDTH | HEIGHT | X | Y
idpchloc1		FLvalue	"loc 1",	60,      20,    90, 730
idpchval1		FLvalue	"val 1",	60,      20,   145, 730
idpchloc2		FLvalue	"loc 2",	60,      20,   200, 730
idpchval2		FLvalue	"val 2",	60,      20,   255, 730
idpchloc3		FLvalue	"loc 3",	60,      20,   310, 730
idpchval3		FLvalue	"val 2",	60,      20,   365, 730

;SLIDERS					      		MIN    |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkpchloc1, ihpchloc1	FLslider	"Pitch Loc. 1",  	0,       4096,   0,    23,  idpchloc1,   490,     15,    5,  480
gkpchval1, ihpchval1	FLslider	"Pitch Val. 1",  	6,          9,   0,    23,  idpchval1,   490,     15,    5,  520
gkpchloc2, ihpchloc2	FLslider	"Pitch Loc. 2",  	0,       4096,   0,    23,  idpchloc2,   490,     15,    5,  560
gkpchval2, ihpchval2	FLslider	"Pitch Val. 2",  	6,          9,   0,    23,  idpchval2,   490,     15,    5,  600
gkpchloc3, ihpchloc3	FLslider	"Pitch Loc. 3",  	0,       4096,   0,    23,  idpchloc3,   490,     15,    5,  640
gkpchval3, ihpchval3	FLslider	"Pitch Val. 3",  	6,          9,   0,    23,  idpchval3,   490,     15,    5,  680

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0, 	ihpchloc1
		FLsetVal_i	6, 	ihpchval1
		FLsetVal_i	2048, 	ihpchloc2
		FLsetVal_i	8, 	ihpchval2
		FLsetVal_i	4096, 	ihpchloc3
		FLsetVal_i	8, 	ihpchval3
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

		FLpanel_end	;END OF PANEL CONTENTS

/*//////////////////////////////////////////////// INSTRUCTIONS AND INFO PANEL ///////////////////////////////////////////////////////*/

				FLpanel	" ", 515, 500, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        GEN25 GEN27                          ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"GEN25 and GEN27 are very similar to GEN05 and GEN07 which are", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"used in the creation of break-point envelopes.               ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"The difference with GEN25 and GEN27 is that instead of       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"defining the duration of each segment a location is defined  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"for each break point in terms if its number of table location", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"points from the beginning of the table.                      ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"GEN27 creates linear segments, GEN25 creates exponential     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"segments. As with GEN05 break-point values must be alike in  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"sign and non-zero.                                           ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"In this example amplitude and pitch envelopes can be defined ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"and edited by the user. Pitch is defined in the 'oct' format.", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"These function tables are read in the orchestra using oscil. ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"The function tables themselves are created in the orchestra  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"and are updated each time a change is made. If you enable    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"displays for Csound (don't use -d flag) you can examine the  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"updated displays of these function tables.                   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"Even though segment lengths are defined here using sliders   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"which output fractional values, the values as used by GEN05  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"for segment lengths will ignore the fractional part.         ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"The user can switch between GEN25 and GEN27 to observe, both ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"visually and aurally, the difference.                        ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"If you require greater control of segment curvature on a     ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"segment by segment basis you might like to look into GEN16.  ", 	1,      5,     14,    490,    20,     5, 480

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD

/*////////////////////////////////////////////// END OF FLTK INTERFACE CODE ///////////////////////////////////////////////////////////*/

instr	1
	ktrig1	changed	       gkamploc1,gkampval1,gkamploc2,gkampval2,gkamploc3,gkampval3,gkamptype
	ktrig2	changed	       gkpchloc1,gkpchval1,gkpchloc2,gkpchval2,gkpchloc3,gkpchval3,gkpchtype
	if ktrig1=1 then
	  reinit UPDATE1
	  UPDATE1:
	  if i(gkamptype)=0 then
	    giampenv	ftgentmp	1,0,4096,-25,i(gkamploc1),i(gkampval1),i(gkamploc2),i(gkampval2),i(gkamploc3),i(gkampval3)	;CREATE AMPLITUDE ENVELOPE USING GEN05
	  else
	    giampenv	ftgentmp	1,0,4096,-27,i(gkamploc1),i(gkampval1),i(gkamploc2),i(gkampval2),i(gkamploc3),i(gkampval3)	;CREATE AMPLITUDE ENVELOPE USING GEN07
	  endif
	  rireturn
	endif
	if ktrig2=1 then	
	  reinit UPDATE2
	  UPDATE2:
	  if i(gkpchtype)=0 then	
	    gipchenv	ftgentmp	2,0,4096,-25,i(gkpchloc1),i(gkpchval1),i(gkpchloc2),i(gkpchval2),i(gkpchloc3),i(gkpchval3)	;CREATE PITCH ENVELOPE USING GEN05
	  else
	    gipchenv	ftgentmp	2,0,4096,-27,i(gkpchloc1),i(gkpchval1),i(gkpchloc2),i(gkpchval2),i(gkpchloc3),i(gkpchval3)	;CREATE PITCH ENVELOPE USING GEN07
	  endif
	  rireturn
	endif
endin                                                                                                     

instr	2
	ktrig	changed	gkOnOff
	if ktrig==1 then
	 event	"i",3,0,i(gkdur)
	 gkOnOff=0
	endif
endin

instr	3
	p3	init	i(gkdur)		;SET UP NOTE DURATION (FLTK DERIVED DURATION WILL BE OVER-RIDDEN)
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