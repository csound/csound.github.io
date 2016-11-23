; TriggerToGatei
; --------------
; Turns a trigger signal into a gate signal 
;
; kgate  TriggerToGatei  ktrig,idur
;
; Initialisation
; --------------
; idur   --  duration (in seconds) that the gate will stay open 
; 
; Performance
; -----------
; ktrig  --  input trigger signal


opcode TriggerToGatei,k,ki
 ktrig,idur xin
 kdlytrig  delayk	ktrig,idur
 kgate	   samphold	ktrig,ktrig + kdlytrig
           xout         kgate
endop
