	AREA	Flags, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

		LDR R1 , =0xC0001000
		LDR R2 , =0x51004000
		ADDS R0 , R1 , R2 	; Result = 0x11005000 Flags = C
		
		LDR R1 , =0x92004000
		SUBS R0 , R1 , R1 	; Result = 0x00000000 Flags = Z, C
		
		LDR R1 , =0x74000100
		LDR R2 , =0x40004000
		ADDS R0 , R1 , R2 	; Result = 0xB4004100 Flags = N, V
		
		LDR R1 , =0x6E0074F2
		LDR R2 , =0x211D6000
		ADDS R0 , R1 , R2 	; Result = 0x8F1DD4F2 Flags = N, V
		
		LDR R1 , =0xBF2FDD1E
		LDR R2 , =0x40D022E2
		ADDS R0 , R1 , R2 	; Result = 0x00000000 Flags = Z, C,
	
stop	B	stop

	END