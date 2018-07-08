	AREA	Val2Dec, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R2, =7890				; numberToBeConverted
	LDR	R0, =decstr				; memoryAddress
	BL val2dec					; convert numberToBeConverted
	ADD R12, R12, #0			; (required for to pc to reset properly)
	B stop	
;
; divide subroutine
; divides one number by another number
; parameters
; R2 = numberToBeDivided
; R3 = divideNum
; output
; R0 = quotient
; R1 = remainder
divide
	STMFD SP!, {LR}				; save link register
	LDR R0, =0					; quotient = 0
	
while	

	CMP R2, R3					; while (numberToBeDivided > divideNum)
	BCC endwhile				; {
	
	SUB R2, R2, R3				;   numberToBeDivided -= divideNum
	ADD R0, R0, #1				; 	quotient++

	B while						; }
	
endwhile
	MOV R1, R2					; remainder = numberToBeDivided
	LDMFD SP!, {PC}				; restore link register



; val2dec subroutine
; converts a number to ASCII, and stores in in memory
; Parameters:
; R0: memoryAddress
; R2: numberToBeConverted

val2dec
	STMFD SP!, {R3-R4, R6, LR}	; store valus on stack
	LDR R3, =10					; divideNum = 10;
	LDR R4, =0					; digits = 0;
	
wh1
	CMP R2, R3					; while (numberToBeConverted > divideNum)
	BLO endwh1					; {
	STMFD SP!, {R0}				; store memoryAddress to stack
	BL divide					;	divide numberToBeConverted by divideNum
	MOV R2, R0					;	move remaider to numberToBeConverted	
	LDMFD SP!, {R0}				; load memoryAddress from stack
	ADD R1, R1, #'0'			;	quotient += '0'
	STMFD SP!, {R1}				;	store quotient on stack
	ADD R4, R4, #1				;	digits++
	B wh1						; }
endwh1
	ADD R2, R2, #'0'			; remainder += '0'
	STMFD SP!, {R2}				; store remainder to stack
	ADD R4, R4, #1				; digits++
	
wh2
	CMP R4, #0					; while (digits != 0)
	BEQ endwh2					; {
	LDMFD SP!, {R6}				;	load number from stack
	STRB R6, [R0, #1]!			;	store number to memory
	SUB R4, R4, #1				;	digits--
	B wh2						; }
endwh2
	
	LDMFD SP!, {R3-R4, R6, PC}	; restore link register
	
stop	B	stop


	AREA	TestString, DATA, READWRITE

decstr	SPACE	16

	END	