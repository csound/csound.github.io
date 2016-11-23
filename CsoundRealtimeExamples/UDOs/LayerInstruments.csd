LayerInstruments.csd
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
		FLpanel	"UDO - Layer Instruments", 250, 50, 0, 0

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gklayers, ihlayers 		FLcount  "Number of Layers", 		-10,    10,     1,      1,      2,    120,    25,    65,  5,    -1


;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	1, 	ihlayers

		FLpanel_end	; END OF PANEL CONTENTS


		FLrun		;RUN THE WIDGET THREAD


opcode	LayerInstruments,0,Kii
	klayers,iInstr,idur	xin			;READ IN INPUT ARGUMENTS
	klayers	=	int(klayers)			;CONVERT NUMBER OF LAYERS VARIABLE TO AN INTEGER
	klayers =       (klayers<0?0:klayers)		;NEGATIVE NUMBERS WILL BE INTERPRETTED AS ZERO
	ktime	timeinsts				;TIME ELAPSED SINCE THIS INSTRUMENT STARTED
	ktrig	changed	klayers				;TRIGGER GENERATED IF klayers CHANGES
	ktrig	=		(ktime<0.1?0:ktrig)	;OVERWRITE FIRST K-PASS TRIGGER WITH A ZERO (ERONEOUS)
	if ktrig=1 then					;IF A TRIGGER IS RECEIVED (CHANGE NUMBER OF klayers)...
	 turnoff2	iInstr,0,0			;TURN OFF ALL INSTANCES OF THE CALLED INSTRUMENT IMMEDIATELY (TRUNCATING RELEASE SEGMENTS)
	 reinit	DelayedTrigger				;BEGIN A REINITIALISATION PASS FROM THE LABEL 'DelayedTrigger' (THIS IS IDONE IN CASE TWO TRIGGERINGS OCCUR WITHIN A SINGLE DELAY PERIOD)
	endif						;END OF CONDITIONAL BRANCH
	DelayedTrigger:					;A LABEL
	ktrigdelay	delayk	ktrig,0.01		;DELAYED VERSION OF THE 'TURN OFF LAYERS' TRIGGER. INSTRUMENT RESTART MUST HAPPEN AFTER A SMALL DELAY.
	rireturn					;RETURN FROM REINITIALISATION BACK TO NORMAL PERFORMANCE (k-time)
	if ktrigdelay=1 then				;IF THE DELAYED TRIGGER IS RECEIVED (0.01 SECONDS AFTER THE TURN OFF TRIGGER)
	 reinit RESTART					;REINITIALISE FROM THE LABEL 'RESTART', TO START A NEW INSTRUMENT LAYER STACK
	endif						;END OF CONDITIONAL BRANCH
	RESTART:					;A LABEL. INSTRUMENT LAYERING BEGINS FROM HERE
	icount	=	1				;COUNTER
	ilayers	=	i(klayers)			;I-TIME VERSION OF klayers
	if ilayers=0 igoto SKIP				;IF klayers=0 - I.E. NO LAYERS - SKIP INSTRUMENT LAYER CREATION COMPLETELY
	LOOP:						;A LABEL, LOOPING JUMPS BACK TO HERE
	event_i "i",iInstr,0,idur,icount		;CALL AN INSTRUMENT LAYER. SEND THE INSTRUMENT ITS LAYER NUMBER VIA p4
	loop_le	icount,1,ilayers,LOOP			;LOOP BACK UNTIL WE HAVE COMPLETED STARTING ALL LAYERS
	SKIP:						;SKIP TO HERE IF ZERO LAYERS WAS CHOSEN
endop


instr	1	; instrument that calls UDO
	LayerInstruments	gklayers,2,3600	
endin

instr	2	; instrument to be called
	asig	vco2	0.1,cpsmidinn(60+((p4-1)*2)),4,0.5	;layers create a whole tone scale rising above middle C  
		outs	asig,asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;	UDO calling instrument
</CsScore>

</CsoundSynthesizer>