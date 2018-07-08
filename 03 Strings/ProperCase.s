	AREA	ProperCase, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R1, =testStr		; adr = start of string
	MOV R2, #0				; count = 0
	
word

	LDRB R3, [R1]			; ch = Memory.Byte[adr]
	
	CMP R3, #0				; while (ch != NULL)
	BEQ endString			; {

	CMP R3, #0x20			;	if (ch != SPACE)
	BEQ newWord				;	{

	CMP R2, #0				;		if (count != 0)
	BEQ firstLetter			;		{
	
	CMP R3, #'a'			;			if (ch > "a")
	BHS letterEnd			;			{
	
	ADD R3, #0x20			;				ch = ch + 20
	STRB R3, [R1]			;				Memory.Byte[adr] = ch
	ADD R1, R1, #1			;				adr++
	B word					;			}
							;		}
firstLetter					;		else
							;		{
	ADD R2, #1				;			count++
	CMP R3, #'a'			;			if (ch <= "a"}
	BLO letterEnd			;			{
	
	SUB R3, R3, #0x20		;				ch = ch - 20
	STRB R3, [R1]			;				Memory.Byte[adr] = ch
	
letterEnd					;			}
							;		}
	ADD R1, #1				;		adr++
	B word					;	}
							
newWord						;	else
							;	{
	MOV R2, #0				;		count = 0
	ADD R1, #1				;		adr++
	B word					;	}
	
endString					; }

stop	B	stop

	AREA	TestData, DATA, READWRITE

testStr	DCB	"hello WORLD",0

	END