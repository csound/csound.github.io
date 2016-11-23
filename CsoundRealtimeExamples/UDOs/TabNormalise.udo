; TabNormalise
; ------------
; Normalises a function table between a maximum of 1 and -1 according to the current maximum of the table.
; This can be useful if a table has been altered using one of the table_ opcodes.
;
;       TabNormalise  ifn
;
; Initilialisation
; ----------------
; ifn    --  function table number to be normalised

	      opcode         TabNormalise,0,i		; UDO for normalising a table
itabnum       xin     
inumitems     =              ftlen(itabnum)             ; derive number of items in table
imax          table          0,itabnum                  ; maximum value starts as first table items
icount        init           1                          ; counter starts at 1 (we've already read item 0)
loop:                                                   ; loop 1 beginning
ival          table          icount,itabnum             ; read value from table
if abs(ival)>=imax then					; if absolute value read from table is higher than (or equal to) current maximum...
 imax	=	abs(ival)				; ...values becomes new maximum
 indx	=	icount					; index of maximum becomes the index of this value
endif							; end of conditional branch
              loop_lt        icount,1,inumitems,loop    ; conditionally loop back
icount        =              0	
loop2:
ival          table           icount,gi1
   	      tableiw         ival/imax, icount,itabnum
              loop_lt         icount,1,ftlen(itabnum),loop2
              endop
