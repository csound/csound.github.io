; RecordController
; ----------------
; Records controller data to a function table as time stamped events (time,value)
; The order of data in the table will be:
; index 0	total time of recording
; index 1	initial value (time zero, no stored time stamp)
; index 2	first time stamp
; index 3	first value
; index 4	second time stamp
; index 5	second value
;   and so on...
;
;      RecordController  kval,ifn
;
; Initialisation
; --------------
; ifn    --  Function table to which data will be stored. 
;            Size required will depend upon density of events as well as duration of recording.
;            Recording will stop if the end of the table is reached
 
; Performance
; -----------
; kval   --  controller data to be recorded


opcode RecordController,0,Ki
	kval,ifn	xin
	i_	ftgen	1,0,ftlen(ifn),-2,0		; Table containing gesture data. Refill with zeros each time instrument is restarted.
	tableiw	i(kval),1,ifn				; write initial value at index 1. (Index 0 will be used be storing the complete gesture duration.)
	kndx	init	2				; Initialise index
	kTime	timeinsts				; time since this instrument started in seconds
	if changed(kval)==1 && kndx<=(ftlen(ifn)-2) && kTime>0 then	; Write a data event only when the input calue changes
	 tablew	kTime, kndx, ifn			; Write timestamp to table location defined by current index.
	 tablew	kval, kndx + 1, ifn			; Write slider value to table location defined by current index.
	 kndx	=	kndx + 2			; Increment index 2 steps (one for time, one for value).
	endif
	krel	release					; sense note release
	if(krel==1) then				; if we are in the final k-cycle before the note ends
	 tablew	kTime,0,ifn				; write total gesture duration into the table at index 0
	endif
endop
