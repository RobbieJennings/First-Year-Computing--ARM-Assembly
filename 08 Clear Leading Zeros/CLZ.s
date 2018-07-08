	AREA	CLZ, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	r4, =0x40000024			; 0x40000024 is mapped to 0x00000024
	LDR	r5, =UndefHandler 		; Address of new undefined handler
	STR	r5, [r4]				; Store new undef handler address
	
	;
	; Test our new instruction
	;
	LDR	r4, =0x00000003			; test 00000003
	
	; This is our undefinied unstruction opcode
	DCD	0x71610114				; CLZ r0, r4
		
	; R0 should be 1E
	
stop	B	stop	

;
; Undefined exception handler
;
UndefHandler
	STMFD	sp!, {r0-r12, LR}	; save registers

	LDR	r4, [lr, #-4]			; load undefinied instruction
	BIC	r5, r4, #0xFFF0FFFF		; clear all but opcode bits
	TEQ	r5, #0x00010000			; check for undefined opcode 0x1
	BNE	endif1					; if (CLZ instruction) {

	BIC	r5, r4, #0xFFFFFFF0		;  isolate Rm register number
	BIC	r6, r4, #0xFFFF0FFF		;  isolate Rd register number
	MOV	r6, r6, LSR #12			;

	LDR	r1, [sp, r5, LSL #2]	;  grab saved Rm off stack

	BL	countLeadingZeros		;  call  CLZ subroutine

	STR	r0, [sp, r6, LSL #2]	;  save result over saved Rd
	
endif1							; }

	LDMFD	sp!, {r0-r12, PC}^	; restore register and CPSR
	
countLeadingZeros

	STMFD sp!, {r1, LR}			; save registers
	CMP r1, #0					; if( number == 0 )
	BNE ifGTZero				; {
	MOV r0, #32					;	answer = 32
	B endIfCLZ					; }
	
ifGTZero
	
	MOV r0, #0					; answer = 0
	
loop							; while( carry not set ){
	MOVS r1, r1, LSL #1			;	shift number left
	BCS endIfCLZ				;	check carry flag
	ADD r0, r0, #1				;	answer ++
	B loop						; }
	
endIfCLZ	

	LDMFD	sp!, {r1, PC} 		; restore registers and return

	END