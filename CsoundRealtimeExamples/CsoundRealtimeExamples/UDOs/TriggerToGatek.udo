; TriggerToGatek
; --------------
; Turns a trigger signal into a gate signal
; Similar to TriggerToGatei except that the gate duration can be changed at k-rate.
; 
; kgate  TriggerToGatei  ktrig,kdur,imax
;
; Initialisation
; --------------
; imax   --  maximum gate duration time
;
; Performance
; -----------
; ktrig  --  input trigger signal
; kdur   --  duration (in seconds) that the gate will stay open

opcode TriggerToGatek,k,kki
 ktrig,kdur,imax xin
 kdlytrig  vdelayk	ktrig,kdur,imax
 kgate	   samphold	ktrig,ktrig + kdlytrig
           xout         kgate
endop
