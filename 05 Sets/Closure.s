	AREA	Closure, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	
	LDR R1, =ASize			; address = ASisze
	LDR R1, [R1]			; size of set = Memory.byte[address]
	SUB R1, R1, #1			; size of set -= 1
	
	LDR R2, =AElems			; address = AElems
	
	LDR R0, =1				; closed = true

	LDR R5, =0				; R5 = 0
	LDR R6, =0				; count = 0

while
	
	CMP R1, #0				; while (size of set > 0)
	BLS endWhile			; {
	
	MOV R3, R1				;	 R3 = size of set
	
	LDR R4, [R2]			; 	 R4 = next element 1
	ADD R7, R4, R4			;	 R7 = (2 x next element 1)
	SUB R4, R4, R7			;	 R4 = next element 1 - (2 x next element 1)

check

	CMP R3, #0				;		 whie (size of set /= 0)
	BLS fail				;		 {
	
	ADD R2, R2, #4			;			 element 2 = next element of set
	LDR R7, [R2]			;			 R7 = Memory[next element of set]
	
	CMP R7, R4				;			 if (next element 1 = next element 2)
	BEQ same				;			 { (see same)
	
	SUB R3, R3, #1			;			 size of set --
	B check					;		 }
	
fail

	MOV R0, #0				;	 closed = false
	B endWhile				;	 System.exit(0)
	
same

	STR R5, [R2]			;			 element 2 = 0
	ADD R6, R6, #1			;			 count ++
	
	LDR R2, =AElems			;			 address = AElems
	ADD R2, R2, R6			;			 address += count
	ADD R2, R2, R6			;			 address += count
	ADD R2, R2, R6			;			 address += count
	ADD R2, R2, R6			;			 address += count
	
	LDR R1, =ASize			;			 address = ASize
	LDR R1, [R1]			;			 R1 = size of set
	
	SUB R1, R1, #1			;			 size of set --
	SUB R1, R1, R6			;			 size of set -= count
	
	B while					;			 }
	
endWhile					; }

stop	B	stop

	AREA	TestData, DATA, READWRITE

ASize	DCD	8			; Number of elements in A
AElems	DCD	+4,-6,-4,+3,-8,+6,+8,-3	; Elements of A

	END