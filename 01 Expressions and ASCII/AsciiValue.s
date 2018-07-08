	AREA	AsciiValue, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, ='2'	; Load '2','0','3','4' into R4...R1
	LDR	R3, ='0'	;
	LDR	R2, ='3'	;
	LDR	R1, ='4'	;
	
	SUB R5, R4, '0'		; Convert R4 character into hex number
	SUB R6, R3, '0'		; Convert R3 character into hex number
	SUB R7, R2, '0'		; Convert R2 character into hex number
	SUB R8, R1, '0'		; Convert R1 character into hex number
	
	LDR R4, =1000		; Load thousands
	LDR R3, =100		; Load hundreds
	LDR R2, =10		; Load tens (no need for units)
		
	MUL R9, R5, R4		; Make R4 into thousands
	MUL R10, R6, R3		; Make R3 into hundreds
	MUL R11, R7, R2		; Make R2 into tens
	
	ADD R5, R9, R10		; Add the thousands and hundreds
	ADD R6, R5, R11		; Add the thousands and hundreds to the tens
	ADD R0, R6, R8		; Find the total
	
stop	B	stop

	END	