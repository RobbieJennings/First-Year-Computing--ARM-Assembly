	AREA	MatMul, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R0, =matR
	LDR	R1, =matA
	LDR	R2, =matB	
	LDR	R3, =N		

	LDR R4, =0
	
for1

	CMP R4, R3
	BGE endFor1
	
	LDR R5, =0
	
for2

	CMP R5, R3
	BGE endFor2

	LDR R6, =0
	LDR R7, =0 
	
for3

	CMP R6, R3
	BGE endFor3

	MUL R10, R4, R3
	ADD R10, R10, R6
	MUL R11, R6, R3
	ADD R11, R11, R5
	LDR R8, [R1, R10, LSL #2]
	LDR R9, [R2, R11, LSL #2]
	MUL R12, R8, R9
	ADD R7, R7, R12
	ADD R6, R6, #1
	B for3
	
endFor3
	
	STR R7, [R0]
	ADD R0, R0, #4
	ADD R5, R5, #1
	B for2
	
endFor2
	
	ADD R4, R4, #1
	B for1
	
endFor1
	
stop	B	stop

	AREA	TestArray, DATA, READWRITE

N	EQU	4

matA	
	DCD	5,4,3,2
	DCD	3,4,3,4
	DCD	2,3,4,5
	DCD	4,3,4,3

matB	
	DCD	5,4,3,2
	DCD	3,4,3,4
	DCD	2,3,4,5
	DCD	4,3,4,3

matR	SPACE	64

	END