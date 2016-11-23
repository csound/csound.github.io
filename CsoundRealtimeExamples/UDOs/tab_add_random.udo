; ADD A DIFFERENT RANDOM NUMBER TO EACH MEMBER OF A FUNCTION TABLE
; irange  --  random value will be chosen from within the range 0 to irange 
; ifn     --  number of table which will be modified

opcode	tab_add_random,0,ii
	irange,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0                       ;INITIALISE LOOP COUNTER
	loop:                                      	;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn		;READ VALUE FROM TABLE
	iRAdd		random	0,irange		;CREATE A RANDOM VALUE
	ival		=	ival+iRAdd		;ADD RANDOM VALUE
			tableiw	ival,icount,ifn		;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop	;LOOPING CONSTRUCTION
endop
