<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>
<CsInstruments>
 
sr = 44100  
ksmps = 32
nchnls = 2
0dbfs = 1

opcode TriggerToGatek,k,kki
 ktrig,kdur,imax xin
 kdlytrig  vdelayk	ktrig,kdur,imax
 kgate	   samphold	ktrig,ktrig + kdlytrig
           xout         kgate
endop
 

instr	1
 ktrig	metro	5                        ; simple trigger
 imax	=	1                        ; maximum gate duration
 kdur	randomi	0.005,0.15,1             ; gate durations (random changing)
 kgate  TriggerToGatek ktrig,kdur,imax   ; call UDO
 agate	interp	kgate                    ; interpolate
 asig	poscil	0.1*agate,300,-1         ; pulse a sine wave
 	outs	asig,asig
endin


</CsInstruments>
<CsScore>
i 1 0 3600
e
</CsScore>
</CsoundSynthesizer>
 
