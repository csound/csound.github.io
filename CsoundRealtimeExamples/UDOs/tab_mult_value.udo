; MULTIPLY EACH MEMBER OF A FUNCTION BY A VALUE
; imultval --  value which shall be multiplied to each value in the function table 
; ifn      --  number of function table of which will be modified

opcode	tab_mult_value,0,ii
	imultval,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0			;INITIALISE LOOP COUNTER
	loop:						;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn		;READ VALUE FROM TABLE
	ival		=	ival*imultval		;MULTIPLY BY VALUE
			tableiw	ival,icount,ifn		;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop	;LOOPING CONSTRUCTION
endop

