	AREA	Divide, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR R2, =10		; Sets the value of a
	LDR R3, =3		; Sets the value of b
	
	LDR R0, =0		; Sets the initial remainder to 0

	CMP R3, #0		; If b is equal to zero
	BEQ label1		; Skip to label1
	
label3	

	CMP R2, R3		; If b is larger than a
	BCC label4		; skip to label 4
	SUB R2, R2, R3		; Subtract b from a
	ADD R0, R0, #1		; Add 1 to quotiant
	MOV R1, R2		; set remainder value to a

	B label3		; Go back to label 3
	
label4

	B   label2		; Skip to label 1
	
label1

	LDR R0, =0		; Set the value of a to 0
	LDR R1, =0		; Set the value of b to 0
	
label2
	
stop	B	stop

	END