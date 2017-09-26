; ADD A VALUE TO EACH MEMBER OF A FUNCTION TABLE
; iaddval  --  value which shall be added to each value in the function table 
; ifn      --  number of function table that will be modified 

opcode	tab_add_value,0,ii
	iaddval,ifn	xin
	iNumItems	=	ftlen(ifn)
	icount		=	0
	loop:
	ival		table	icount,ifn
	ival		=	ival+iaddval
			tableiw	ival,icount,ifn
			loop_lt	icount,1,iNumItems,loop
endop

