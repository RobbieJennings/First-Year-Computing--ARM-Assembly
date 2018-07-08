	AREA	Unique, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	MOV R0, #1					; boolean isUnique = true
	MOV R5, #0					; iterations = 0

while1

	LDR	R1, =VALUES				; valuesadr = VALUES
	LDR R2, =COUNT				; countadr = COUNT
	LDR R2, [R2]				; char = Memory.Byte[COUNT]
	
	CMP R5, R2					; while( iterations >= count )
	BHS endwhile1				; {
	
	ADD R1, R1, R5				;	valuesadr++
	ADD R1, R1, R5				;	valuesadr++
	ADD R1, R1, R5				;	valuesadr++
	ADD R1, R1, R5				;	valuesadr++
	
	SUB R2, R2, R5				;	count--
	
	LDR R3, [R1]				;	char1 = Memory.Byte[VALUES]
	
while
	
	CMP R2, #0					;	while( count != 0 )
	BEQ endwhile				;	{
	
	ADD R1, R1, #4				;		valuesadr += 4	
	LDR R4, [R1]				;		char2 = Memory.Byte[VALUES]
	
	CMP R3, R4					;		if( char2 != char1 )
	BEQ notUnique				;		{

	SUB R2, R2, #1				;			count -= 1
	B while						;		}
	
notUnique						;		else
								;		{
	MOV R0, #0					;			isUnique = false;
	B endwhile					;		}
	
endwhile						;	}

	ADD R5, R5, #1				;	iterations++
	B while1					; }
	
endwhile1

stop	B	stop

	AREA	TestData, DATA, READWRITE

COUNT	DCD	10
VALUES	DCD	5, 2, 7, 4, 13, 30, 18, 8, 9, 12

	END