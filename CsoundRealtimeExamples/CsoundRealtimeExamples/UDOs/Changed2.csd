Changed2.csd
Written by Iain McCurdy, 2013

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>
sr	=	44100	
ksmps	=	32
nchnls	=	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"UDO - Changed2", 450, 70, 0, 0
;COUNTERS						MIN   | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkval, ihval 		FLcount  "Change Scanned Value", -10,    10,     1,      1,      2,    120,    25,    65,  5,    -1
gkval2, ihval2 		FLcount  "Change Scanned Value", -10,    10,     1,      1,      2,    120,    25,   220,  5,    -1
;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	0, 	ihval
			FLsetVal_i	0, 	ihval2

		FLpanel_end	; END OF PANEL CONTENTS


		FLrun		;RUN THE WIDGET THREAD

opcode	Changed2,k,kOOOOOOOOOOOOOOOOOOO
	kval1,kval2,kval3,kval4,kval5,kval6,kval7,kval8,kval9,kval10,kval11,kval12,kval13,kval14,kval15,kval16,kval17,kval18,kval19,kval20	xin				;READ IN ARGUMENTS (VALUES TO BE SCANNED)
	ktime	timeinstk			;READ TIME ELAPSED FOR THIS INSTRUMENT FROM INITIALISATION IN k-PERIODS
	ktrig	changed	kval1,kval2,kval3,kval4,kval5,kval6,kval7,kval8,kval9,kval10,kval11,kval12,kval13,kval14,kval15,kval16,kval17,kval18,kval19,kval20			;SCAN FOR CHANGES IN THE INPUT ARGUMENT
	ktrig	=	(ktime<1?0:ktrig)	;IGNORE TRIGGER GENERATED FOR THE FIRST k PERIOD
		xout	ktrig			;OUTPUT CORRECTED TRIGGER
endop

gisine	ftgen	0,0,4096,10,1

instr	1	; instrument that calls UDO
	ktrig	Changed2	gkval,gkval2
	;ktrig	changed	gkval
	printk2	ktrig
	schedkwhen	ktrig,0,0,2,0,0.4
endin

instr	2	; audible 'ping'
	aenv	transeg	1,p3,-2,0
	asig	oscili	aenv*0.1,400,gisine
		outs	asig,asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;	UDO calling instrument
</CsScore>

</CsoundSynthesizer>