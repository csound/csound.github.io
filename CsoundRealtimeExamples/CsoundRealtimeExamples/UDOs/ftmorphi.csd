ftmorphi.csd
Written by Iain McCurdy, 2012

Initialisation time version of the 'ftmorph' opcode.
The function table created by ftmorph is not available at init. time but is only first available during the first performance time (k-time) pass after the note has been initiated.
If a table is required at i-time this UDO can be used instead
The syntax for ftmorphi is identical to that for ftmorph

ftmorfi iftndx, iftfn, iresfn

Initialization
--------------
iftfn      -- The table containing the numbers of any existing tables which are used for the morphing.
iresfn     -- Table number of the morphed function
  
The length of all the tables in iftfn must equal the length of iresfn.

Performance
-----------
iftndx     -- The index into the iftfn table. 




<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 1
0dbfs =	1

;create three GEN10 function tables
gi1 ftgen 0,0,1024,10,1,1,1,1,1,1,1,1,1,1,1	;buzzy
gi2 ftgen 0,0,1024,10,1,0,1/2,0,1/4,0,1/8	;square wave-ish
gi3 ftgen 0,0,1024,10,1				;sine

;table that contains a list of the table numbers of the GEN10 tables created above
gitabs ftgen 0,0,4,-2,gi1,gi2,gi3,gi3

;map midi notes to indices
gimap ftgen 0,0,128,-27,0,0,36,0,60,1,84,2,128,2


	opcode ftmorfi,0,iii
iindex,itabs,imorftab xin			; INPUT PARMETERS
; DERIVE TABLE NUMBERS FOR THE TWO TABLES BETWEEN WHICH TO MORPH
itab1	table	int(iindex),itabs		; LOWER TABLE
itab2	table	int(iindex)+1,itabs		; UPPER TABLE
ilen	=	ftlen(imorftab)			; DERIVE	LENGTH OF TABLE INTO WHICH THE MORPH WILL BE WRITTEN
; GAIN VALUES FOR THE TWO TABLES
igain1	=	1-frac(iindex)			; LOWER
igain2	=	frac(iindex)			; UPPER
; CREATE MORPHED TABLE
	tableimix	imorftab,0,ilen,itab1,0,igain1,itab2,0,igain2
	endop

instr	1	;CALL ftmorphi UDO AND CREATE AN AUDIO OSCILLATOR
			inote		notnum
	iindex		table		inote,gimap			; READ INDEX VALUE (RANGE 0 - 2) FROM INDEX MAP
	imorftab	ftgentmp	0,0,1024,10,1			; CREATE MORPHED TABLE FOR THIS NOTE ONLY
			ftmorfi		iindex,gitabs,imorftab		; CALL UDO
	a1		poscil		0.2,cpsmidinn(inote),imorftab	; AUDIO OSCILLATOR THAT USES THE MORPHED TABLE
			out		a1				; SEND AUDIO TO OUTPUT
endin

instr	2	;PRINT A MESSAGE TO THE TERMINAL
	prints	"Morph between three different waveforms (buzz-square-sine) across the keyboard"
	prints	"%n"
	prints	"See .csd for further information."
endin

</CsInstruments>

<CsScore>
f 0 3600
i 2 0 0	; PRINT A MESSAGE TO THE TERMINAL
</CsScore>

</CsoundSynthesizer>