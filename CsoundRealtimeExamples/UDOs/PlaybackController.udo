; PlaybackController
; ------------------
; Plays back controller data previously stored in a function table as time stamped events (time,value)
;  (see UDO 'RecordController.udo')
; The order of data in the table should be:
; index 0	total time of recording
; index 1	initial value (time zero, no stored time stamp)
; index 2	first time stamp
; index 3	first value
; index 4	second time stamp
; index 5	second value
;   and so on...
;
; kval   PlaybackController   ifn
;
; Initialisation
; --------------
; ifn    --  Function table from which data will be retrieved. 
;            Should contain data recorded previously using the UDO 'RecordController.udo'
 
; Performance
; -----------
; kval   --  playback of controller data


opcode PlaybackController,k,i
	ifn	xin	
	; read first value
	ival	table	1,ifn				; initial controller value read from index 1
	kval	init	ival				; initial value for k-rate output	
	kndx	init	2				; Initialise index to first non-zero timestamp
	kTime	timeinsts				; time in seconds since this note started	
	iTimeStamp	tablei	2,ifn			; first non-zero timestamp
	kTimeStamp	init	iTimeStamp		; initialise k-variable for first non-zero timestamp
	if kTime>=kTimeStamp && kTimeStamp>0 then	; if we have reached the timestamp value...
	 kval	table	kndx+1,ifn			; ...Read value from table defined by current index.
	 kTimeStamp	table	kndx+2,ifn		; Read next timestamp
	 kndx	limit	kndx+2, 0, ftlen(ifn)-2		; Increment index. (Always 2 steps: timestamp and value.)
	endif
	
		xout	kval
endop
