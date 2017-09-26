<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>
<CsInstruments>
 
sr = 44100  
ksmps = 32
nchnls = 2
0dbfs = 1

opcode TriggerToGatei,k,ki
 ktrig,idur xin
 kdlytrig  delayk	ktrig,idur
 kgate	   samphold	ktrig,ktrig + kdlytrig
           xout         kgate
endop
 

instr	1
 ktrig	metro	5                        ; simple trigger
 imax	=	1                        ; maximum gate duration
 idur	=	p4                       ; gate durations (from score)
 kgate  TriggerToGatei ktrig,idur        ; call UDO
 agate	interp	kgate                    ; interpolate
 asig	poscil	0.1*agate,300,-1         ; pulse a sine wave
 	outs	asig,asig
endin


</CsInstruments>
<CsScore>
i 1 0 3 0.1
i 1 4 3 0.01
i 1 8 3 0.19
e
</CsScore>
</CsoundSynthesizer>
 
