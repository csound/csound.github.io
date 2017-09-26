; ROUND MEMBERS OF A FUNCTION TABLE TO THE NEAREST INTEGER
; ifn  --  number of table which will be modified

opcode	tab_round,0,i
	ifn		xin
	iNumItems	=	ftlen(ifn)
	icount		=	0
	loop:
	ival		table	icount,ifn
	ival		=	round(ival)
			tableiw	ival,icount,ifn
			loop_lt	icount,1,iNumItems,loop
endop

