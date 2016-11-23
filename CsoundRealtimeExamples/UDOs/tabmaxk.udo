; kmax,kndx  tabmaxk  ifn
;
; RETURN THE LARGEST VALUE IN A FUNCTION TABLE
; ifn  --  number of table to be interrogated
; kmax --  largest value found
; kndx --  index of the maximum value

	      opcode         tabmaxk,kk,i		; UDO for deriving maximum value and its index from a table
itabnum       xin     
inumitems     =              ftlen(itabnum)             ; derive number of items in table
kmax          table          0,itabnum                  ; maximum value starts as first table items
kcount        =              1                          ; counter starts at 1 (we've already read item 0)
loop:                                                   ; loop 1 beginning
kval          table          kcount,itabnum             ; read value from table
if kval>=kmax then					; if value read from table is higher than (or equal to) current maximum...
 kmax	=	kval					; ...values becomes new maximum
 kndx	=	kcount					; index of maximum becomes the index of this value
endif							; end of conditional branch
              loop_lt        kcount,1,inumitems,loop    ; conditionally loop back
	      xout           kmax,kndx			; return maximium value to caller instrument
              endop
