; imax,indx  tabmax  ifn
;
; RETURN THE LARGEST VALUE IN A FUNCTION TABLE
; ifn  --  number of table to be interrogated
; imax --  largest value found
; indx --  index of the maximum value

	      opcode         tabmax,ii,i		; UDO for deriving maximum value and its index from a table
itabnum       xin     
inumitems     =              ftlen(itabnum)             ; derive number of items in table
imax          table          0,itabnum                  ; maximum value starts as first table items
icount        init           1                          ; counter starts at 1 (we've already read item 0)
loop:                                                   ; loop 1 beginning
ival          table          icount,itabnum             ; read value from table
if ival>=imax then					; if value read from table is higher than (or equal to) current maximum...
 imax	=	ival					; ...values becomes new maximum
 indx	=	icount					; index of maximum becomes the index of this value
endif							; end of conditional branch
              loop_lt        icount,1,inumitems,loop    ; conditionally loop back
	      xout           imax,indx			; return maximium value to caller instrument
              endop