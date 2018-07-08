		AREA	StringReverse, CODE, READONLY
		IMPORT	main
		EXPORT	start

start
		LDR R1, =strSrc		; set src string pointer
		LDR R2, =strDst		; set dst string pointer
		MOV R4, R1			; copy src string ponter
	
whLen		
		LDRB R3, [R1]		; char = Memory.Byte[adrSrc]
		CMP R3, #0			; while (ch /= 0)
		BEQ ewhLen			; {
		ADD R1, R1, #1		;	adrSrc++
		ADD R2, R2, #1		;	adrDst++
		B whLen				; }
ewhLen

		MOV R3, #0			; ch = null
		STRB R3, [R2]		; Memory.Byte[adrDst] = ch
		SUB R2, R2, #1		; adrDst--
		
		MOV R1, R4			; restore src string pointer to start of src string
		
whRev		
		LDRB R3, [R1]		; char = Memory.Byte[adrSrc]
		CMP R3, #0			; while (ch /= 0)
		BEQ ewhRev			; {
		STRB R3, [R2]		;	Memory.Byte[adrDst] = ch
		ADD R1, R1, #1		;	adrSrc++
		SUB R2, R2, #1		;	adrDst--
		B whRev				; }
ewhRev		

stop	B	stop

		AREA	TestData, DATA, READWRITE

strSrc	DCB	"hello",0
strDst	SPACE	128

		END