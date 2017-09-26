; MULTIPLY EACH MEMBER OF A FUNCTION TABLE BY A DIFFERENT RANDOM NUMBER
; irange --  each member of the table will be multiplied by a random number on the range 1 to 1+irange  
; ifn    --  number of table which will be modified 

opcode	tab_mult_random,0,ii
	irange,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0			;INITIALISE LOOP COUNTER
	loop:						;LABEL - LOOPING LOOPS BACK TO HERE
	ival	table	icount,ifn			;READ VALUE FROM TABLE
	iRMult	random	1,1+irange			;CREATE A RANDOM VALUE
	ival	=	ival*iRMult			;MULTIPLY BY RANDOM VALUE
		tableiw	ival,icount,ifn			;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
		loop_lt	icount,1,iNumItems,loop		;LOOPING CONSTRUCTION
endop

