	AREA	ArrayMove, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R0, =array				; load start of array
	LDR	R1, =N					; load N
	LDR	R2, =6					; load index1
	LDR	R3, =3					; load index2
	LDR R4, =1					; load shift
	
	CMP R2, R3					; if( index1 > index2 )
	BHI leftShift				; branch to leftShift
	
	LDR R4, =-1					; shift = -1
	
leftShift

	LDR R5, [R0, R2, LSL #2]	; load value at memory address of index1

while

	CMP R2, R3					; while( index1 /= index2 )
	BEQ endWhile				; {
	
	SUB R2, R2, R4				;	index1 -= shift
	LDR R6, [R0, R2, LSL #2]	;	load value at memory address of index1
	ADD R2, R2, R4				;	index1 += shift
	STR R6, [R0, R2, LSL #2]	;	store value in memory at address of index1
	SUB R2, R2, R4				;	index1 -= shift
	
	B while						; }
	
endWhile

	STR R5, [R0, R2, LSL #2]	; store value in memory at address of index1
	
stop	B	stop

	AREA	TestArray, DATA, READWRITE

N	equ	9
array	DCD	7,2,5,9,1,3,2,3,4

	END