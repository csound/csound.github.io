; imin,indx  tabmin  ifn
;
; RETURN THE SMALLEST VALUE IN A FUNCTION TABLE
; ifn  --  number of table to be interrogated
; imin --  smallest value found
; indx --  index of the minimum value

              opcode         tabmin,ii,i	        ; UDO for deriving minimum value and its index from a table
itabnum       xin     
inumitems     =              ftlen(itabnum)             ; derive number of items in table
imin          table          0,itabnum                  ; minimum value starts as first table item
icount        init           1                          ; counter starts at 1 (we've already read item 0)
loop:                                                   ; loop 1 beginning
ival          table          icount,itabnum             ; read value from table
if ival<=imin then					; if value read from table is lower than (or equal to) current minimum...
 imin	=	ival					; ...values becomes new minimum
 indx	=	icount					; index of minimum becomes the index of this value
endif							; end of conditional branch
              loop_lt        icount,1,inumitems,loop    ; conditionally loop back
	      xout           imin,indx			; return minimum value & its index to caller instrument
              endop