	AREA	Anagram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR R1, =stringA		; address 1 = stringA
	LDR R2, =stringB		; address 2 = stringB
	
	LDRB R3, [R1]			; element 1 = Memory.byte[address 1]
	LDRB R4, [R2]			; element 2 = Memory.byte[address 2]
	
	LDR R0, =1				; anagram = true
	LDR R5, ='@'			; R5 = "@"
	
while

	CMP R3, #0				; while (element 1 /= 0)
	BEQ endWhile			; {
	
check

	CMP R4, #0				;	 if (element 2 == 0)
	BLS fail				;	 { (see fail)
	
	CMP R3, R4				;	 if (element 1 == element 2)
	BEQ same				;	 { (see same)
	
	ADD R2, R2, #1			;	 address 2 ++
	LDRB R4, [R2]			;	 element 2 = Memory.byte[address 2]
		
	B check					; }
	
fail

	LDR R0, =0				;		 anagram = false
	B endRecheck			;	 }
	
same
	
	STRB R5, [R2]			;		 Memory.byte[address 2] = "@"
	
	ADD R1, R1, #1			;		 address 1 ++
	LDR R2, =stringB		;		 address 2 = stringB
	
	LDRB R3, [R1]			;		 element 1 = Memory.byte[address 1]
	LDRB R4, [R2]			;		 element 2 = Memory.byte[address 2]
	
	B while					;	 }

endWhile

	LDR R2, =stringB		; address 2 = stringB
	LDRB R4, [R2]			; element 2 = Memory.byte[address 2]
	
recheck
	
	CMP R4, #0				; while (element 2 /= 0)
	BEQ endRecheck			; {
	
	CMP R4, R5				;	 if (element 2 /= @)
	BNE fail				;	 { (see fail)
	
	ADD R2, R2, #1			;	 address 2 ++
	LDRB R4, [R2]			;	 element 2 = Memory.byte[address 2]
	
	B recheck				; }
	
endRecheck

stop	B	stop

	AREA	TestData, DATA, READWRITE

stringA	DCB	"bests",0
stringB	DCB	"beets",0

	END