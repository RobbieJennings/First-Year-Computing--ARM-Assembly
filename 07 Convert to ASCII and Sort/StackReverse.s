	AREA	StackReverse, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R5, =string



	
stop	B	stop


	AREA	TestString, DATA, READWRITE

string	DCB	"abcdef"

	END	