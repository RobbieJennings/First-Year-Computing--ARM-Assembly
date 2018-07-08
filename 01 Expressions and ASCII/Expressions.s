	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	; Variables
	LDR	R1, =5		; x = 5
	LDR	R2, =6		; y = 6
	
	; Equation 1
	MUL R3, R1, R1 		; x^2
	LDR R4, =3		; 3
	MUL R5, R4, R3		; 3x^2
	
	LDR R6, =5		; 5
	MUL R7, R6, R1		; 5x
	
	ADD R0, R5, R7		; 3x^2 + 5x
	
	MOV R10, R0
	
	; Result for Equation 1 is stored in R10
	; Answer should be 0x64
	
	; Equation 2
	MUL R3, R1, R1 		; x^2
	LDR R4, =2		; 2
	MUL R4, R3, R4		; 2x^2
	
	LDR R5, =6		; 6
	MUL R6, R2, R1		; xy
	MUL R5, R6, R5		; 6xy
	
	MUL R6, R2, R2		; y^2
	LDR R7, =3		; 3
	MUL R6, R7, R6		; 3y^2	
	
	ADD R8, R4, R5		; 2x^2 + 6xy
	ADD R0, R8, R6		; 2x^2 + 6xy + 3y^2
	
	MOV R11, R0
	
	; Result for Equation 2 is stored in R11
	; Answer should be 0x152
	
	; Equation 3
	MUL R3, R1, R1		; x^2
	MUL R4, R3, R1		; x^3
	
	LDR R5, =4		; 4
	MUL R5, R3, R5		; 4x^2
	
	LDR R6, =3		; 3
	MUL R6, R1, R6		; 3x
	
	LDR R7, =8		; 8
	
	SUB R8, R4, R5		; x^3 - 4x^2
	ADD R9, R8, R6		; x^3 - 4x^2 + 3x
	ADD R0, R9, R7		; x^3 - 4x^2 + 3x + 8
	
	MOV R12, R0
	
	; Result for Equation 3 is stored in R12
	; Answer should be 0x30
		
stop	B	stop

	END