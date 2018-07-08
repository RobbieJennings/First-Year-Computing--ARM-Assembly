	AREA	SymmDiff, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR R1, =ASize			; address = ASize
	LDR R1, [R1]			; ASize = Memory[address]
	
	LDR R10, =CSize			; address = CSize
	LDR R10, [R10]			; CSize = Memory[address]
	
	LDR R2, =AElems			; address 1 = AElems
	LDR R3, =BElems			; address 2 = BElems
	LDR R4, =CElems			; address 3 = CElems
	
	MOV R5, R1				; size = ASize
	LDR R6, =0				; count = 0

while
	
	CMP R1, #0				; while (size > 0)
	BLS endWhile			; {
	
	MOV R7, R5				;	 size of set 1 = ASize
	LDR R8, [R2]			;	 element 1 = Memory[AElems]
	
check

	CMP R7, #0				;	 while (size of set 1 > 0)
	BLS fail				;	 {
	
	LDR R9, [R3]			;		 element 2 = Memory[BElems]
	ADD R3, R3, #4			;		 address 2 ++
		
	CMP R9, R8				;		 if (element 2 == element 1)
	BEQ same				;		 { (see same)
	
	SUB R7, R7, #1			;		 size of set 1 --
	B check					;	 }
	
fail

	ADD R6, R6, #1			;	 count ++
	ADD R2, R2, #4			;	 address 1 ++
	
	LDR R1, =ASize			;	 address = ASize
	LDR R1, [R1]			;	 ASize = Memory[address]
	
	SUB R1, R1, R6			;	 ASize -= count
	
	LDR R3, =BElems			;	 address 2 = BElems
	
	B while					; }
	
same

	ADD R6, R6, #1			;			 count++
	ADD R2, R2, #4			;			 address 1 ++
	
	LDR R1, =ASize			;			 address = ASize
	LDR R1, [R1]			;			 ASize = Memory.byte[address]
	
	ADD R10, R10, #1		;			 CSize ++
	
	SUB R1, R1, R6			;			 ASize -= count
	
	STR R8, [R4]			;			 address 3 = element 1
	ADD R4, R4, #4			;			 address 3 ++
	
	LDR R3, =BElems			;			 address 2 = BElems
	
	B while					;		 }

endWhile

	LDR R11, =CSize			; address = CSize
	STR R10, [R11]			; CSize = CSize

stop	B	stop

	AREA	TestData, DATA, READWRITE

ASize	DCD	8			; Number of elements in A
AElems	DCD	4,6,2,13,19,7,1,3	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	13,9,1,20,5,8		; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END