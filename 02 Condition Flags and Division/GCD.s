	AREA	GCD, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR R0, =0		; Sets the initial value of R0 to 0
	LDR R2, =32		; Sets the value of a
	LDR R3, =24		; Sets the value of b

label1  

	CMP R2, R3		; If a is equal to b
	BEQ label2		; Skip to label2

	CMP R2, R3		; If a is lower than b
	BLO label3		; Skip to label3
	
	SUB R2, R2, R3		; Subtract b from a
	MOV R0, R2		; Move the value of a to R0
	
	B label4		; Skip to label 4
	
label3

	SUB R3, R3, R2		; Subtract a from b
	MOV R0, R3		; Move the value of b to R0
	
label4

	B label1		; Go back to label1
	
label2
	
stop	B	stop

	END