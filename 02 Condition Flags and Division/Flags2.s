	AREA	Flags2, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR R0 , =0x00000001
	LDR R1 , =0x00000001
	ADDS R2 , R0 , R1 	; Part 1: all 0
	
	LDR R0 , =0xF0000000
	LDR R1 , =0x00000000
	ADDS R2 , R0 , R1 	; Part 2: N = 1
	
	LDR R0 , =0xF0000000
	LDR R1 , =0x20000000
	ADDS R2 , R0 , R1 	; Part 3: C = 1
	
	LDR R0 , =0xF0000000
	LDR R1 , =0xF0000000
	ADDS R2 , R0 , R1	 ; Part 4: N = 1, C = 1
	
	LDR R0 , =0x70000000
	LDR R1 , =0x90000000
	ADDS R2 , R0 , R1 	; Part 5: Z = 1, C = 1
	
	LDR R0 , =0x00000000
	LDR R1 , =0x00000000
	ADDS R2 , R0 , R1 	; Part 6: Z = 1
	
	LDR R0 , =0x50000000
	LDR R1 , =0x50000000
	ADDS R2 , R0 , R1 	; Part 7: N = 1, V = 1
	
	LDR R0 , =0x90000000
	LDR R1 , =0x90000000
	ADDS R2 , R0 , R1 	; Part 8: C = 1, V = 1
	
	LDR R0 , =0x80000000
	LDR R1 , =0x80000000
	ADDS R2 , R0 , R1 	; Part 9: Z = 1, C = 1, V = 1


stop	B	stop

	END