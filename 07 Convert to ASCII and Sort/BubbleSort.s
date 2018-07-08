	AREA	BubbleSort, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =array			; address of array
	LDR	R5, =arrayN			; address of array size
	LDR	R5, [R5]			; load array size, N
	
sort						; do {
	LDR R6, =0				;	 swapped = false
	LDR R2, =1				;	 i = 1
for						
	CMP R2, R5				;	 while (i < N)
	BHS endfor				;	 {
	SUB R1, R2, #1			;		j = i - 1
	LDR R7, [R0, R1, LSL #2];		load array[i-1]
	LDR R8, [R0, R2, LSL #2];		load array[i]
	CMP R7, R8				;		if (array[i-1] > array[i])
	BLS endif				;		{
	BL swap					;			swap array[i-1] and array[i]
	LDR R6, =1				;			swapped = true
endif						;		}
	ADD R2, R2, #1			;		i++
	B for					;	 }
endfor						; }
	CMP R6, #0				; while (swapped == true)
	BEQ stop				;
	B sort					;


;
; swap subroutine
; swaps two elements  in a 1-dimensional array of word-size integers
; parameters
; R0: memoryAddress
; R1: elementIndexToSwap
; R2: indexToPlace

swap
	STMFD SP!, {R3-R4, LR}	; push registers onto stack
	LDR R3, [R0, R1, LSL #2]; load element one
	LDR R4, [R0, R2, LSL #2]; load element two
	STR R3, [R0, R2, LSL #2]; store element one in index two
	STR R4, [R0, R1, LSL #2]; store element one in index one
	LDMFD SP!, {R3-R4, PC}	; pop registers off stack
		
;
; sort program
;



	
stop	B	stop


	AREA	TestArray, DATA, READWRITE

; Array Size
arrayN	DCD	15

; Array Elements
array	DCD	33,17,18,92,49,28,78,75,22,13,19,13,8,44,35

	END	