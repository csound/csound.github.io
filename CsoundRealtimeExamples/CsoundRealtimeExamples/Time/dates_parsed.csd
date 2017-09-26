dates_parsed.csd
Written by Iain McCurdy, 2011

The string output by the dates opcode is parsed so that each individual attribute is available as a value and, where applicable, a string.
Additionally the name of the day of the week, which is not part of the original string, is derived.
The day of the week is also expressed as a number (as a value not a string). Monday being equal to '1', Tuesday '2' and so on.
The month number is derived from the month name.
All the data derived is printed to the terminal.

Based and inspired by the example from the Csound Reference Manual.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 4
nchnls = 1
0dbfs = 1

gimonthcode	ftgen	0,0,-12,-2,	6,2,2,5,0,3,5,1,4,6,2,4	;A TABLE OF CODE VALUES USED IN CALCULATION OF THE DAY OF THE WEEK

instr	1
	
	/*TO PERIODICALLY UPDATE DATE DATA AND PRINTING*/
	/*
	kReinitTrig	metro	1	;TRIGGER TO UPDATE DATE STRING - ONCE A SECOND
	if kReinitTrig==1 then		;IF AN UPDATE TRIGGER IS RECEIVED...
	  reinit	UPDATE		;... BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif				;END OF CONDITIONAL BRANCH
	UPDATE:				;LABEL CALLED 'UPDATE'. REINITIALISATION BEGINS FROM HERE.
	*/
	
	;CREATE STRING VARIABLES FOR EACH MONTH
	Sjan		=	"Jan"  
	Sfeb		=	"Feb"
	Smar		=	"Mar"
	Sapr		=	"Apr"
	Smay		=	"May"
	Sjun		=	"Jun"
	Sjul		=	"Jul"
	Saug		=	"Aug"
	Ssep		=	"Sep"
	Soct		=	"Oct"
	Snov		=	"Nov"
	Sdec		=	"Dec"
	
	Sdatestring	dates				;READ DATE AS A STRING
	Syear		strsub	Sdatestring,20,24	;EXTRACT YEAR AS A STRING
	iyear		strtod	Syear			;CREATE A VARIABLE FROM YEAR STRING
	Smonth		strsub	Sdatestring,4,7		;EXTRACT MONTH AS A STRING
	Sday		strsub	Sdatestring,8,10	;EXTRACT DAY AS A STRING
	iday		strtod	Sday			;CREATE A VARIABLE FROM DAY STRING
	Shor		strsub	Sdatestring,11,13	;EXTRACT HOUR AS A STRING
	ihor		strtod	Shor			;CREATE A VARIABLE FROM HOUR STRING
	Smin		strsub	Sdatestring,14,16	;EXTRACT MINUTES AS A STRING
	imin		strtod	Smin			;CREATE A VARIABLE FROM MINUTES STRING
	Ssec		strsub	Sdatestring,17,19	;EXTRACT SECONDS AS A STRING
	isec		strtod	Ssec			;CREATE A VARIABLE FROM SECONDS STRING

	;COMPARE CURRENT MONTH STRING STRINGS OF EACH MONTH IN TURN. 0 if A MATCH IS FOUND
	ijan		strcmp	Smonth,Sjan
	ifeb		strcmp	Smonth,Sfeb                                                                          
	imar		strcmp	Smonth,Smar
	iapr		strcmp	Smonth,Sapr
	imay		strcmp	Smonth,Smay
	ijun		strcmp	Smonth,Sjun
	ijul		strcmp	Smonth,Sjul
	iaug		strcmp	Smonth,Saug
	isep		strcmp	Smonth,Ssep
	ioct		strcmp	Smonth,Soct
	inov		strcmp	Smonth,Snov
	idec		strcmp	Smonth,Sdec

	;DERIVE A VALUE FOR MONTH NUMBER ACCORDING TO THE CURRENT MONTH. JANUARY=1 FEBRUARY=2 ETC.
	if ijan=0 then
	  imon	=	1
	elseif ifeb=0 then
	  imon	=	2
	elseif imar=0 then
	  imon	=	3
	elseif iapr=0 then
	  imon	=	4
	elseif imay=0 then
	  imon	=	5
	elseif ijun=0 then
	  imon	=	6
	elseif ijul=0 then
	  imon	=	7
	elseif iaug=0 then
	  imon	=	8
	elseif isep=0 then
	  imon	=	9
	elseif ioct=0 then
	  imon	=	10
	elseif inov=0 then
	  imon	=	11
	elseif idec=0 then
	  imon	=	12
	endif
	
	;DERIVE DAY OF THE WEEK NUMBER. MONDAY=1 TUESDAY=2 ETC.
	imonthval	table	imon-1,gimonthcode
	idaynum	=	((iyear-2000) + int((iyear-2000)/4)) + imonthval + iday
	idaynum	wrap	idaynum,1,8
	
	;CREATE A STRING FOR THE DAY OF THE WEEK ACCORDING TO THE DAY OF THE WEEK NUMBER
	if idaynum=1 then
	  Sdayname = "Monday"
	elseif idaynum=2 then
	  Sdayname = "Tuesday"
	elseif idaynum=3 then
	  Sdayname = "Wednesday"
	elseif idaynum=4 then
	  Sdayname = "Thursday"
	elseif idaynum=5 then
	  Sdayname = "Friday"
	elseif idaynum=6 then
	  Sdayname = "Saturday"
	elseif idaynum=7 then
	  Sdayname = "Sunday"
	endif
	
	/*PRINT AS ONE LONG LINE IN THE TERMINAL*/
	/*
	;PRINT DATE FROM PARSED DATA. (TO CHECK INTEGRITY OF DATA)
	printf_i	"%d:%d:%d %s(%d) %d %s(%d) %d\n",1,ihor,imin,isec,Sdayname,idaynum,iday,Smonth,imon,iyear
	*/
	
	/*PRINT INIDIVIDUAL DATA ELEMENTS IN SEPERATE ROWS*/
	printf_i	"Hours: %d\n",1,ihor
	printf_i	"Minutes: %d\n",1,imin
	printf_i	"Seconds: %d\n",1,isec
	printf_i	"Day Name: %s\n",1,Sdayname
	printf_i	"Day Number: %d\n",1,idaynum
	printf_i	"Day of Month: %d\n",1,iday
	printf_i	"Month Name: %s\n",1,Smonth
	printf_i	"Month Number: %d\n",1,imon
	printf_i	"Year: %d\n",1,iyear
endin

</CsInstruments>

<CsScore>
i 1 0 100
e
</CsScore>

</CsoundSynthesizer>