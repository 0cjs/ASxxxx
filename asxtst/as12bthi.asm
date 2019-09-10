	.title	Machine Independent Assembler Test
	.module Asmtst

	;  The file 'as12bthi.asm' must be assembled with
	; a HI/LO assembler (in file ___ext.c, hilo = 1).
	;
	;   as12bthi:	Specifically For The AS6100 Assembler
	;
	;		12bt	12-Bit PC addressing
	;			(No Concept of a Byte) 
	;		hi	HI/LO assembler
	;
	; All .areas must be of type DSEG.

	.sbttl	Memory Allocation Directives

	.area	_DATA	(abs,ovr)	; Data Area

	.radix	O			; set default to octal

					; binary constants
	.byte	0b11000000		; 00 C0
	.byte	0B1110			; 00 0E
	.byte	$%11000000		; 00 C0

					; octal constants
	.byte	24			; 00 14
	.byte	024			; 00 14
	.byte	0q024			; 00 14
	.byte	0Q024			; 00 14
	.byte	0o024			; 00 14
	.byte	0O024			; 00 14
	.byte	$&24			; 00 14

					; decimal constant
	.byte	0d024			; 00 18
	.byte	0D024			; 00 18
	.byte	$#24			; 00 18

					; hexidecimal constants
	.byte	0h024			; 00 24
	.byte	0H024			; 00 24
	.byte	0x024			; 00 24
	.byte	0X024			; 00 24
	.byte	$$24			; 00 24

	.db	0			; 00 00
	.dw	0			; 00 00


	.page
	.radix	D			; set default to decimal

	.byte	1,2,3			; 00 01 00 02 00 03
	.byte	4,5,6			; 00 04 00 05 00 06
	.byte	7,8,9			; 00 07 00 08 00 09
	.word	1,2,3			; 00 01 00 02 00 03
	.word	4,5,6			; 00 04 00 05 00 06
	.word	7,8,9			; 00 07 00 08 00 09

	.blkb	16
	.ds	16

	.blkw	16
	.ds	16*2

word:	.word	.+2			;s00r78
	.word	.-2			;s00r75
	.word	2+.			;s00r7A
	.word	.-(word+2)		; 00 01


	.page
	.sbttl	Boundary Directives

	.area	bndry_1	(ABS,OVR,DSEG)
	.org	0
bndry_1:

	.even
1$:	.byte	1$ - bndry_1		; 00 00
	.even
2$:	.byte	2$ - bndry_1		; 00 02
	.even
	.odd
3$:	.byte	3$ - bndry_1		; 00 05
	.odd
4$:	.byte	4$ - bndry_1		; 00 07
	.odd
	.even
5$:	.word	5$ - bndry_1		; 00 0A
	.odd
6$:	.word	6$ - bndry_1		; 00 0B
	.even
7$:	.word	7$ - bndry_1		; 00 0C


	.page
	.sbttl	Power of 2 Boundary Modes

	.area	bndry_2	(ABS,OVR,DSEG)
	.org	0

	.even			; Address == 0
	.bndry	2		; Address == 0
	.bndry	4		; Address == 0
	.bndry	8		; Address == 0
	.bndry	16		; Address == 0
	.bndry	32		; Address == 0
	.bndry	64		; Address == 0
	.bndry	128		; Address == 0
	.bndry	256		; Address == 0
	.bndry	512		; Address == 0
	.bndry	1024		; Address == 0

	.org	0
bndry_2:

	.org	0
	.even			; Address == 0
1$:	.word	1$ - bndry_2	; 00 00

	.org	0
	.bndry	2		; Address == 0
2$:	.word	2$ - bndry_2	; 00 00

	.org	0
	.bndry	4		; Address == 0
3$:	.word	3$ - bndry_2	; 00 00

	.org	0
	.bndry	8		; Address == 0
4$:	.word	4$ - bndry_2	; 00 00

	.org	0
	.bndry	16		; Address == 0
5$:	.word	5$ - bndry_2	; 00 00

	.org	0
	.bndry	32		; Address == 0
6$:	.word	6$ - bndry_2	; 00 00

	.org	0
	.bndry	64		; Address == 0
7$:	.word	7$ - bndry_2	; 00 00

	.org	0
	.bndry	128		; Address == 0
8$:	.word	8$ - bndry_2	; 00 00

	.org	0
	.bndry	256		; Address == 0
9$:	.word	9$ - bndry_2	; 00 00

	.org	0
	.bndry	512		; Address == 0
10$:	.word	10$ - bndry_2	; 00 00

	.org	0
	.bndry	1024		; Address == 0
11$:	.word	11$ - bndry_2	; 00 00


	.page

	.area	bndry_3	(ABS,OVR,DSEG)
	.org	1

	.even			; Address == 2
	.bndry	2		; Address == 2
	.bndry	4		; Address == 4
	.bndry	8		; Address == 8
	.bndry	16		; Address == 16
	.bndry	32		; Address == 32
	.bndry	64		; Address == 64
	.bndry	128		; Address == 128
	.bndry	256		; Address == 256
	.bndry	512		; Address == 512
	.bndry	1024		; Address == 1024

	.org	0
bndry_3:

	.org	1
	.even			; Address == 2
1$:	.word	1$ - bndry_3	; 00 02

	.org	1
	.bndry	2		; Address == 2
2$:	.word	2$ - bndry_3	; 00 02

	.org	1
	.bndry	4		; Address == 4
3$:	.word	3$ - bndry_3	; 00 04

	.org	1
	.bndry	8		; Address == 8
4$:	.word	4$ - bndry_3	; 00 08

	.org	1
	.bndry	16		; Address == 16
5$:	.word	5$ - bndry_3	; 00 10

	.org	1
	.bndry	32		; Address == 32
6$:	.word	6$ - bndry_3	; 00 20

	.org	1
	.bndry	64		; Address == 64
7$:	.word	7$ - bndry_3	; 00 40

	.org	1
	.bndry	128		; Address == 128
8$:	.word	8$ - bndry_3	; 00 80

	.org	1
	.bndry	256		; Address == 256
9$:	.word	9$ - bndry_3	; 01 00

	.org	1
	.bndry	512		; Address == 512
10$:	.word	10$ - bndry_3	; 02 00

	.org	1
	.bndry	1024		; Address == 1024
11$:	.word	11$ - bndry_3	; 04 00


	.page
	.sbttl	Non Power of 2 Boundary Modes

	.area	bndry_4	(ABS,OVR,DSEG)
	.org	0

	.bndry	1		; Address == 0
	.bndry	3		; Address == 0
	.bndry	7		; Address == 0
	.bndry	15		; Address == 0
	.bndry	31		; Address == 0

	.org	0
bndry_4:

	.org	0
	.bndry	1		; Address == 0
1$:	.word	1$ - bndry_4	; 00 00

	.org	0
	.bndry	3		; Address == 0
2$:	.word	2$ - bndry_4	; 00 00

	.org	0
	.bndry	7		; Address == 0
3$:	.word	3$ - bndry_4	; 00 00

	.org	0
	.bndry	15		; Address == 0
4$:	.word	4$ - bndry_4	; 00 00

	.org	0
	.bndry	31		; Address == 0
5$:	.word	5$ - bndry_4	; 00 00


	.page

	.area	bndry_5	(ABS,OVR,DSEG)
	.org	1

	.bndry	3		; Address == 3
	.bndry	5		; Address == 5
	.bndry	9		; Address == 9
	.bndry	17		; Address == 17
	.bndry	33		; Address == 33

	.org	0
bndry_5:

	.org	1
	.bndry	3		; Address == 3
1$:	.word	1$ - bndry_5	; 00 03

	.org	1
	.bndry	5		; Address == 5
2$:	.word	2$ - bndry_5	; 00 05

	.org	1
	.bndry	9		; Address == 9
3$:	.word	3$ - bndry_5	; 00 09

	.org	1
	.bndry	17		; Address == 17
4$:	.word	4$ - bndry_5	; 00 11

	.org	1
	.bndry	33		; Address == 33
5$:	.word	5$ - bndry_5	; 00 21


	.page

	.area	bndry_6	(ABS,OVR,DSEG)
	.org	47

	.bndry	3		; Address == 48
	.bndry	6		; Address == 48
	.bndry	12		; Address == 48
	.bndry	24		; Address == 48
	.bndry	48		; Address == 48
	.bndry	96		; Address == 96
	.bndry	192		; Address == 192
	.bndry	384		; Address == 384
	.bndry	768		; Address == 768
	.bndry	1536		; Address == 1536

	.org	0
bndry_6:

	.org	47
	.bndry	3		; Address == 48
1$:	.word	1$ - bndry_6	; 00 30

	.org	47
	.bndry	6		; Address == 48
2$:	.word	2$ - bndry_6	; 00 30

	.org	47
	.bndry	12		; Address == 48
3$:	.word	3$ - bndry_6	; 00 30

	.org	47
	.bndry	24		; Address == 48
4$:	.word	4$ - bndry_6	; 00 30

	.org	47
	.bndry	48		; Address == 48
5$:	.word	5$ - bndry_6	; 00 30

	.org	47
	.bndry	96		; Address == 96
6$:	.word	6$ - bndry_6	; 00 60

	.org	47
	.bndry	192		; Address == 192
7$:	.word	7$ - bndry_6	; 00 C0

	.org	47
	.bndry	384		; Address == 384
8$:	.word	8$ - bndry_6	; 01 80

	.org	47
	.bndry	768		; Address == 768
9$:	.word	9$ - bndry_6	; 03 00

	.org	47
	.bndry	1536		; Address == 1536
10$:	.word	10$ - bndry_6	; 06 00


	.page
	.sbttl	String Directives

	.area	_DATA			; Data Area

	.ascii	"ab"			; 00 61 00 62
	.asciz	"ab"			; 00 61 00 62 00 00
	.ascis	"ab"			; 00 61 00 E2


	.sbttl	Expression Evaluation

	n0x00	=	0x00
	n0x01	=	0x01
	n0x10	=	0x10
	n0xff	=	0xff
	n0xeeff =	0xeeff


	n	=	< n0xeeff	; 0xff		low byte
	.byte	>n,<n			; 00 00 00 FF
	n	=	> n0xeeff	; 0xee		high byte
	.byte	>n,<n			; 00 00 00 EE


	n	=	'A		; 0x41		single character
	.byte	>n,<n			; 00 00 00 41
	n	=	"AB		; 0x4142	double character
	.byte	>n,<n			; 00 41 00 42
	n	=	n0x01		; 0x01		assignment
	.byte	>n,<n			; 00 00 00 01
	n	=	n + n0x01	; 0x02		addition
	.byte	>n,<n			; 00 00 00 02
	n	=	n - n0x01	; 0x01		subtraction
	.byte	>n,<n			; 00 00 00 01
	n	=	n * 0x05	; 0x05		multiplication
	.byte	>n,<n			; 00 00 00 05
	n	=	n / 0x02	; 0x02		division
	.byte	>n,<n			; 00 00 00 02
	n	=	n0x10 % 0x05	; 0x01		modulus
	.byte	>n,<n			; 00 00 00 01
	n	=	n0x10 | n0x01	; 0x11		or
	.byte	>n,<n			; 00 00 00 11
	n	=	n0xff & n0x01	; 0x01		and
	.byte	>n,<n			; 00 00 00 01
	n	=	n0x01 << 4	; 0x10		left shift
	.byte	>n,<n			; 00 00 00 10
	n	=	n0x10 >> 4	; 0x01		right shift
	.byte	>n,<n			; 00 00 00 01
	n	=	n0xff ^ n0x10	; 0xef		xor
	.byte	>n,<n			; 00 00 00 EF
	n	=	n ^ n0x10	; 0xff		xor
	.byte	>n,<n			; 00 00 00 FF
	n	=	~n0x10		; 0xffef	1's complement
	.byte	>n,<n			; 00 FF 00 EF
	n	=	-n0x10		; 0xfff0	2's complement
	.byte	>n,<n			; 00 FF 00 F0



	n	=	n0xeeff & 0xff	; 0xff		low byte
	.byte	>n,<n			; 00 00 00 FF
	n = (n0xeeff & 0xff00)/0x100	; 0xee		high byte
	.byte	>n,<n			; 00 00 00 EE


	n	=	n0xeeff % 0x100 ; 0xff		low byte
	.byte	>n,<n			; 00 00 00 FF
	n	=	n0xeeff / 0x100 ; 0xee		high byte
	.byte	>n,<n			; 00 00 00 EE


	n	=	3*(2 + 4*(6))	; 0x4e		expression evaluation
	.byte	>n,<n			; 00 00 00 4E
	n	=	2*(0x20 + <~n0x10)	; 0x21e
	.byte	>n,<n			; 00 02 00 1E


	.sbttl	arithmatic tests

	;
	; The following series of tests verify that
	; the arithmetic is 16-Bit and unsigned.


	.sbttl	Addition

	n =	 1 +  1			; 0x0001 + 0x0001 ; 0x0002
	.byte	>n,<n			; 00 00 00 02
	n =	-1 +  1			; 0xFFFF + 0x0001 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-1 + -1			; 0xFFFF + 0xFFFF ; 0xFFFE
	.byte	>n,<n			; 00 FF 00 FE

	n =	 32768 +  32768		; 0x8000 + 0x8000 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-32768 +  32768		; 0x8000 + 0x8000 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-32768 + -32768		; 0x8000 + 0x8000 ; 0x0000
	.byte	>n,<n			; 00 00 00 00

	n =	 65535 +  1		; 0xFFFF + 0x0001 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	 65535 + -1		; 0xFFFF + 0xFFFF ; 0xFFFE
	.byte	>n,<n			; 00 FF 00 FE


	.sbttl	Subtraction

	n =	 1 -  1			; 0x0001 - 0x0001 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-1 -  1			; 0xFFFF - 0x0001 ; 0xFFFE
	.byte	>n,<n			; 00 FF 00 FE
	n =	-1 - -1			; 0xFFFF - 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00

	n =	 32768 -  32768		; 0x8000 - 0x8000 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-32768 -  32768		; 0x8000 - 0x8000 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-32768 - -32768		; 0x8000 - 0x8000 ; 0x0000
	.byte	>n,<n			; 00 00 00 00

	n =	 65535 -  1		; 0xFFFF - 0x0001 ; 0xFFFE
	.byte	>n,<n			; 00 FF 00 FE
	n =	 65535 - -1		; 0xFFFF - 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00


	.sbttl	Multiplication

	n =	 1 *  1			; 0x0001 * 0x0001 ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	 1 * -1			; 0x0001 * 0xFFFF ; 0xFFFF
	.byte	>n,<n			; 00 FF 00 FF
	n =	-1 * -1			; 0xFFFF * 0xFFFF ; 0x0001
	.byte	>n,<n			; 00 00 00 01

	n =	 256 *  256		; 0x0100 * 0x0100 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	 256 * -256		; 0x0100 * 0xFF00 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-256 * -256		; 0xFF00 * 0xFF00 ; 0x0000
	.byte	>n,<n			; 00 00 00 00


	.sbttl	Division

	n =	 1 /  1			; 0x0001 / 0x0001 ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	10 /  2			; 0x000A / 0x0002 ; 0x0005
	.byte	>n,<n			; 00 00 00 05
	n =	512 / 4			; 0x0200 / 0x0004 ; 0x0080
	.byte	>n,<n			; 00 00 00 80
	n =	32768 / 2		; 0x8000 / 0x0002 ; 0x4000
	.byte	>n,<n			; 00 40 00 00
	n =	65535 / 2		; 0xFFFF / 0x0002 ; 0x7FFF
	.byte	>n,<n			; 00 7F 00 FF

	n = 	 1 / -1			; 0x0001 / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	 32767 / -1		; 0x7FFF / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	 32768 / -1		; 0x8000 / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	 65534 / -1		; 0xFFFE / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	 65535 / -1		; 0xFFFF / 0xFFFF ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-1 / -1			; 0xFFFF / 0xFFFF ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-2 / -1			; 0xFFFE / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-32768 / -1		; 0x8000 / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-32769 / -1		; 0x7FFF / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-65535 / -1		; 0x0001 / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-65536 / -1		; 0x0000 / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00

	n =	-256 /   -1		; 0xFF00 / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-256 / -255		; 0xFF00 / 0xFF01 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-256 / -256		; 0xFF00 / 0xFF00 ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-256 / -257		; 0xFF00 / 0xFEFF ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-256 / -32767		; 0xFF00 / 0x8001 ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-256 / -32768		; 0xFF00 / 0x8000 ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-256 /  32768		; 0xFF00 / 0x8000 ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-256 /  65280		; 0xFF00 / 0xFF00 ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-256 /  65281		; 0xFF00 / 0xFF01 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-256 /  65535		; 0xFF00 / 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00


	.sbttl	Modulus

	n =	 1 %  1			; 0x0001 % 0x0001 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	10 %  2			; 0x000A % 0x0002 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	512 % 4			; 0x0200 % 0x0004 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	32768 % 2		; 0x8000 % 0x0002 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	65535 % 2		; 0xFFFF % 0x0002 ; 0x0001
	.byte	>n,<n			; 00 00 00 01

	n = 	 1 % -1			; 0x0001 % 0xFFFF ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	 32767 % -1		; 0x7FFF % 0xFFFF ; 0x7FFF
	.byte	>n,<n			; 00 7F 00 FF
	n =	 32768 % -1		; 0x8000 % 0xFFFF ; 0x8000
	.byte	>n,<n			; 00 80 00 00
	n =	 65534 % -1		; 0xFFFE % 0xFFFF ; 0xFFFE
	.byte	>n,<n			; 00 FF 00 FE
	n =	 65535 % -1		; 0xFFFF % 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-1 % -1			; 0xFFFF % 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-2 % -1			; 0xFFFE % 0xFFFF ; 0xFFFE
	.byte	>n,<n			; 00 FF 00 FE
	n =	-32768 % -1		; 0x8000 % 0xFFFF ; 0x8000
	.byte	>n,<n			; 00 80 00 00
	n =	-32769 % -1		; 0x7FFF % 0xFFFF ; 0x7FFF
	.byte	>n,<n			; 00 7F 00 FF
	n =	-65535 % -1		; 0x0001 % 0xFFFF ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-65536 % -1		; 0x0000 % 0xFFFF ; 0x0000
	.byte	>n,<n			; 00 00 00 00

	n =	-256 %   -1		; 0xFF00 % 0xFFFF ; 0xFF00
	.byte	>n,<n			; 00 FF 00 00
	n =	-256 % -255		; 0xFF00 % 0xFF01 ; 0xFF00
	.byte	>n,<n			; 00 FF 00 00
	n =	-256 % -256		; 0xFF00 % 0xFF00 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-256 % -257		; 0xFF00 % 0xFEFF ; 0x0001
	.byte	>n,<n			; 00 00 00 01
	n =	-256 % -32767		; 0xFF00 % 0x8001 ; 0x7EFF
	.byte	>n,<n			; 00 7E 00 FF
	n =	-256 % -32768		; 0xFF00 % 0x8000 ; 0x7F00
	.byte	>n,<n			; 00 7F 00 00
	n =	-256 %  32768		; 0xFF00 % 0x8000 ; 0x7F00
	.byte	>n,<n			; 00 7F 00 00
	n =	-256 %  65280		; 0xFF00 % 0xFF00 ; 0x0000
	.byte	>n,<n			; 00 00 00 00
	n =	-256 %  65281		; 0xFF00 % 0xFF01 ; 0xFF00
	.byte	>n,<n			; 00 FF 00 00
	n =	-256 %  65535		; 0xFF00 % 0xFFFF ; 0xFF00
	.byte	>n,<n			; 00 FF 00 00


	.page
	.sbttl	IF, ELSE, and ENDIF

	;*******************************************************

	n = 0
	m = 0

	.if	0
		n = 1
		.if	0
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 2, m = 0
	.byte	n,m			; 00 02 00 00


	n = 0
	m = 0

	.if	1
		n = 1
		.if	0
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 1, m = 2
	.byte	n,m			; 00 01 00 02

	;*******************************************************
	.page
	;*******************************************************

	n = 0
	m = 0

	.if	0
		n = 1
		.if	1
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 2, m = 0
	.byte	n,m			; 00 02 00 00


	n = 0
	m = 0

	.if	1
		n = 1
		.if	1
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 1, m = 1
	.byte	n,m			; 00 01 00 01

	;*******************************************************
	.page
	;*******************************************************

	n = 0
	m = 0

	.if	0
		n = 1
	.else
		.if	0
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 2, m = 2
	.byte	n,m			; 00 02 00 02


	n = 0
	m = 0

	.if	1
		n = 1
	.else
		.if	0
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 1, m = 0
	.byte	n,m			; 00 01 00 00

	;*******************************************************
	.page
	;*******************************************************

	n = 0
	m = 0

	.if	0
		n = 1
	.else
		.if	1
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 2, m = 1
	.byte	n,m			; 00 02 00 01


	n = 0
	m = 0

	.if	1
		n = 1
	.else
		.if	1
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 1, m = 0
	.byte	n,m			; 00 01 00 00

	;*******************************************************

	.page
	.sbttl	Signed Conditionals With -1

	n = -1

	.ifeq	n
		.error	1		; n = -1, .ifeq n  != 0
	.endif

	.ifne	n
	.else
		.error	1		; n = -1, .ifne n  != 0
	.endif

	.ifgt	n
		.error	1		; n = -1, .ifgt n  !>= 0
	.endif

	.iflt	n
	.else
		.error	1		; n = -1, .iflt n  !>= 0
	.endif

	.ifge	n
		.error	1		; n = -1, .ifge n  !>= 0
	.endif

	.ifle	n
	.else
		.error	1		; n = -1, .ifle n  !> 0
	.endif


	.page
	.sbttl	Signed Conditionals With 0

	n = 0

	.ifeq	n
	.else
		.error	1		; n = 0, .ifeq n  == 0
	.endif

	.ifne	n
		.error	1		; n = 0, .ifne n  == 0
	.endif

	.ifgt	n
		.error	1		; n = 0, .ifgt n  !> 0
	.endif

	.iflt	n
		.error	1		; n = 0, .iflt n  !< 0
	.endif

	.ifge	n
	.else
		.error	1		; n = 0, .ifge n  !< 0
	.endif

	.ifle	n
	.else
		.error	1		; n = 0, .ifle n  !> 0
	.endif


	.page
	.sbttl	Signed Conditionals With +1

	n = +1

	.ifeq	n
		.error	1		; n = +1, .ifeq n  != 0
	.endif

	.ifne	n
	.else
		.error	1		; n = +1, .ifne n  != 0
	.endif

	.ifgt	n
	.else
		.error	1		; n = +1, .ifgt n  !<= 0
	.endif

	.iflt	n
		.error	1		; n = +1, .iflt n  !<= 0
	.endif

	.ifge	n
	.else
		.error	1		; n = +1, .ifge n  !< 0
	.endif

	.ifle	n
		.error	1		; n = +1, .ifle n  !<= 0
	.endif


	.page
	.sbttl	Alternate Signed Conditionals With -1

	n = -1

	.if	eq	n
		.error	1		; n = -1, .ifeq n  != 0
	.endif

	.if	ne	n
	.else
		.error	1		; n = -1, .ifne n  != 0
	.endif

	.if	gt	n
		.error	1		; n = -1, .ifgt n  !>= 0
	.endif

	.if	lt	n
	.else
		.error	1		; n = -1, .iflt n  !>= 0
	.endif

	.if	ge	n
		.error	1		; n = -1, .ifge n  !>= 0
	.endif

	.if	le	n
	.else
		.error	1		; n = -1, .ifle n  !> 0
	.endif


	.page
	.sbttl	Alternate Signed Conditionals With 0

	n = 0

	.if	eq	n
	.else
		.error	1		; n = 0, .ifeq n  == 0
	.endif

	.if	ne	n
		.error	1		; n = 0, .ifne n  == 0
	.endif

	.if	gt	n
		.error	1		; n = 0, .ifgt n  !> 0
	.endif

	.if	lt	n
		.error	1		; n = 0, .iflt n  !< 0
	.endif

	.if	ge	n
	.else
		.error	1		; n = 0, .ifge n  !< 0
	.endif

	.if	le	n
	.else
		.error	1		; n = 0, .ifle n  !> 0
	.endif


	.page
	.sbttl	Alternate Signed Conditionals With +1

	n = +1

	.if	eq	n
		.error	1		; n = +1, .ifeq n  != 0
	.endif

	.if	ne	n
	.else
		.error	1		; n = +1, .ifne n  != 0
	.endif

	.if	gt	n
	.else
		.error	1		; n = +1, .ifgt n  !<= 0
	.endif

	.if	lt	n
		.error	1		; n = +1, .iflt n  !<= 0
	.endif

	.if	ge	n
	.else
		.error	1		; n = +1, .ifge n  !< 0
	.endif

	.if	le	n
		.error	1		; n = +1, .ifle n  !<= 0
	.endif


	.page
	.sbttl	Conditionals With String Tests

	.ifb	J		; 0
	 .error	1		; .if b,J failed
	.endif

	.ifb			; 1
	 .byte	0x06	        ; 00 06
	.endif

	.ifnb			; 0
	 .error	1		; .if nb failed
	.endif

	.ifnb	J		; 1
	 .byte	0x07		; 00 07
	.endif

	.undefine	defsym
	.ifdef	defsym		; 0
	 .error	1		; .if def,defsym failed
	.endif

	.define		defsym
	.ifdef	defsym		; 1
	 .byte	0x08	        ; 00 08
	.endif

	.ifndef	defsym		; 0
	 .error	1		; .if def,defsym failed
	.endif

	.undefine	defsym
	.ifndef	defsym		; 1
	 .byte	0x09		; 00 09
	.endif

	.ifidn	A,B		; 0
	 .error	1		; .if iden A,B failed
	.endif

	.ifidn	D,D		; 1
	 .byte	0x0A		; 00 0A
	.endif

	.ifdif	D,D		; 0
	 .error	1		; .if dif D,D failed
	.endif

	.ifdif	A,B		; 1
	 .byte	0x0B		; 00 0B
	.endif


	.page
	.sbttl	Alternate Conditionals With String Tests

	.if	b	J	; 0
	 .error	1		; .if b,J failed
	.endif

	.if	b		; 1
	 .byte	0x06	        ; 00 06
	.endif

	.if	nb		; 0
	 .error	1		; .if nb failed
	.endif

	.if	nb	J	; 1
	 .byte	0x07		; 00 07
	.endif

	.undefine	defsym
	.if	def	defsym	; 0
	 .error	1		; .if def,defsym failed
	.endif

	.define		defsym
	.if	def	defsym	; 1
	 .byte	0x08	        ; 00 08
	.endif

	.if	ndef	defsym	; 0
	 .error	1		; .if def,defsym failed
	.endif

	.undefine	defsym
	.if	ndef	defsym	; 1
	 .byte	0x09		; 00 09
	.endif

	.if	idn	A,B	; 0
	 .error	1		; .if iden A,B failed
	.endif

	.if	idn	D,D	; 1
	 .byte	0x0A		; 00 0A
	.endif

	.if	dif	D,D	; 0
	 .error	1		; .if dif D,D failed
	.endif

	.if	dif	A,B	; 1
	 .byte	0x0B		; 00 0B
	.endif


	.page
	.sbttl	Signed Immediate Conditionals

	n = -1

	.iifeq	n	.error	1	; n = -1, .ifeq n  != 0
	.iifne	n	.byte	0x01	; 00 01
	.iifgt	n	.error	1	; n = -1, .ifgt n  !>= 0
	.iiflt	n	.byte	0x02	; 00 02
	.iifge	n	.error	1	; n = -1, .ifge n  !>= 0
	.iifle	n	.byte	0x03	; 00 03


	n = 0

	.iifeq	n	.byte	0x04	; 00 04
	.iifne	n	.error	1	; n = 0, .ifne n  == 0
	.iifgt	n	.error	1	; n = 0, .ifgt n  !> 0
	.iiflt	n	.error	1	; n = 0, .iflt n  !< 0
	.iifge	n	.byte	0x05	; 00 05
	.iifle	n	.byte	0x06	; 00 06


	n = +1

	.iifeq	n	.error	1	; n = +1, .ifeq n  != 0
	.iifne	n	.byte	0x07	; 00 07
	.iifgt	n	.byte	0x08	; 00 08
	.iiflt	n	.error	1	; n = +1, .iflt n  !<= 0
	.iifge	n	.byte	0x09	; 00 09
	.iifle	n	.error	1	; n = +1, .ifle n  !<= 0


	.page
	.sbttl	Alternate Signed Immediate Conditionals

	n = -1

	.iif	eq,n	.error	1	; n = -1, .ifeq n  != 0
	.iif	ne,n	.byte	0x01	; 00 01
	.iif	gt,n	.error	1	; n = -1, .ifgt n  !>= 0
	.iif	lt,n	.byte	0x02	; 00 02
	.iif	ge,n	.error	1	; n = -1, .ifge n  !>= 0
	.iif	le,n	.byte	0x03	; 00 03


	n = 0

	.iif	eq,n	.byte	0x04	; 00 04
	.iif	ne,n	.error	1	; n = 0, .ifne n  == 0
	.iif	gt,n	.error	1	; n = 0, .ifgt n  !> 0
	.iif	lt,n	.error	1	; n = 0, .iflt n  !< 0
	.iif	ge,n	.byte	0x05	; 00 05
	.iif	le,n	.byte	0x06	; 00 06


	n = +1

	.iif	eq,n	.error	1	; n = +1, .ifeq n  != 0
	.iif	ne,n	.byte	0x07	; 00 07
	.iif	gt,n	.byte	0x08	; 00 08
	.iif	lt,n	.error	1	; n = +1, .iflt n  !<= 0
	.iif	ge,n	.byte	0x09	; 00 09
	.iif	le,n	.error	1	; n = +1, .ifle n  !<= 0


	.page
	.sbttl	Immediate Conditionals With Strings

	.iifb	J	 .error	1	; .if b,J failed
	.iifb	^!!	 .byte	0x01	; 00 01
	.iifnb	^!!	 .error	1	; .if nb failed
	.iifnb	J	 .byte	0x02	; 00 02

	.undefine  defsym
	.iifdef	defsym	 .error	1	; .if def,defsym failed

	.define  defsym
	.iifdef	defsym	.byte	0x03	; 00 03
	.iifndef defsym	.error	1	; .if def,defsym failed

	.undefine  defsym
	.iifndef defsym	 .byte	0x04	; 00 04

	.iifidn	A,B	.error	1	; .if iden A,B failed
	.iifidn	D,D	.byte	0x05	; 00 05
	.iifdif	D,D	.error	1	; .if dif D,D failed
	.iifdif	A,B	.byte	0x06	; 00 06


	.page
	.sbttl	Alternate Immediate Conditionals With Strings

	.iif	b,J	 .error	1	; .if b,J failed
	.iif	b,^!!	 .byte	0x01	; 00 01
	.iif	nb,^!!	 .error	1	; .if nb failed
	.iif	nb,J	 .byte	0x02	; 00 02

	.undefine  defsym
	.iif	def,defsym	 .error	1	; .if def,defsym failed

	.define  defsym
	.iif	def,defsym	.byte	0x03	; 00 03
	.iif	ndef,defsym	.error	1	; .if def,defsym failed

	.undefine  defsym
	.iif	ndef,defsym	 .byte	0x04	; 00 04

	.iif	idn	A,B	.error	1	; .if iden A,B failed
	.iif	idn	D,D	.byte	0x05	; 00 05
	.iif	dif	D,D	.error	1	; .if dif D,D failed
	.iif	dif	A,B	.byte	0x06	; 00 06


	.page
	.sbttl	Local Symbols

	.org	0

lclsym0:
					; forward references
	.word	0$,1$			;s00r0As00r0B
	.word	2$,3$			;s00r0Cs00r0D
	.word	4$,5$			;s00r0Es00r0F
	.word	6$,7$			;s00r10s00r11
	.word	8$,9$			;s00r12s00r13

0$:	.word	9$			;s00r13
1$:	.word	8$			;s00r12
2$:	.word	7$			;s00r11
3$:	.word	6$			;s00r10
4$:	.word	5$			;s00r0F
5$:	.word	4$			;s00r0E
6$:	.word	3$			;s00r0D
7$:	.word	2$			;s00r0C
8$:	.word	1$			;s00r0B
9$:	.word	0$			;s00r0A
10$:

					; backward references
	.word	0$,1$			;s00r0As00r0B
	.word	2$,3$			;s00r0Cs00r0D
	.word	4$,5$			;s00r0Es00r0F
	.word	6$,7$			;s00r10s00r11
	.word	8$,9$			;s00r12s00r13

	.page

lclsym1:
					; forward references
	.word	0$,1$			;s00r28s00r29
	.word	2$,3$			;s00r2As00r2B
	.word	4$,5$			;s00r2Cs00r2D
	.word	6$,7$			;s00r2Es00r2F
	.word	8$,9$			;s00r30s00r31

0$:	.word	9$			;s00r31
1$:	.word	8$			;s00r30
2$:	.word	7$			;s00r2F
3$:	.word	6$			;s00r2E
4$:	.word	5$			;s00r2D
5$:	.word	4$			;s00r2C
6$:	.word	3$			;s00r2B
7$:	.word	2$			;s00r2A
8$:	.word	1$			;s00r29
9$:	.word	0$			;s00r28
10$:

					; backward references
	.word	0$,1$			;s00r28s00r29
	.word	2$,3$			;s00r2As00r2B
	.word	4$,5$			;s00r2Cs00r2D
	.word	6$,7$			;s00r2Es00r2F
	.word	8$,9$			;s00r30s00r31


	.page
	.sbttl	Offset calculations

	ofsbyte	=	(10$-0$)	; 0x000A
	ofsword	=	ofsbyte/2	; 0x0005

					; 1$ + 0x000F
	.word	1$+ofsbyte+ofsword	;s00r38


	.sbttl	Lower/Upper Byte Selections

	.globl	extern

					; low byte
	.byte	< (extern + 0x0001)	;s00r01

					; low byte
	.byte	< (extern + 0x0200)	;s00r00

					; high byte
	.byte	> (extern + 0x0003)	;s00r03

					; high byte
	.byte	> (extern + 0x0400)	;s00r00


	.page
	.sbttl	Area Definitions

	.globl	code0
	.globl	cnstnt1,cnstnt2

	cnstnt0 == 0xabcd		; global equate

code0:	.word	a0			;s00r00
	.word	cnstnt0			; 0B CD

	; Bank selected as _DSEG
	; Overlay and Data Segment
	.area	AreaA (OVR,DSEG,BANK=_DSEG)

	cnstnt1 = 0x1234

a0:	.word	0x00ff			; 00 FF

	; Bank selected as _DSEG
	; Overlay and Data Segment
	.area	AreaB (ABS,OVR,DSEG,BANK=_DSEG)

	cnstnt2 = 0x5678

	.word	a1			;s00r00

	.area	AreaA

	.=.+0x0020
	.word	a2			;s00r00

	.area	AreaB
	.org	0x40

	.word	a0,a1,a2		;s00r00s00r00s00r00
	.word	AreaB,OVR		;s00r00s00r00

abcdabcd::				; global symbol


	.page
	.sbttl	Macro Processor Tests

	.list	(md)
	.list	(me)

	.radix	X

	;	The Macro Processor directives are:
	;
	;	.macro	arg(,arg ...)		Create a Macro Definition
	;	.endm				End of Macro Definition
	;
	;	.mexit				Unconditional GoTo .endm
	;
	;	.irp	arg(,arg ...)		Indefinite Repeat Block
	;	.irpc	acbdefg			Indefinite Repeat on Characters
	;	.rept	arg			Repeat Code Block arg Times
	;
	;	.mdelete  arg(,arg ...)		Delete Macro Definitions
	;
	;	.nchr	arg			Number of Characters in String
	;	.narg	sym			Return Number of args in .macro call
	;	.ntyp	typ,symbol		Return Symbol Type - (ABS = 0, REL = 1)
	;	.nval	val,symbol		Return Value of Symbol (As Absolute Value)
	;

	.page
	.sbttl	Macro Creation

	; Macro definition with the
	; name 'seta' and two arguments.
	;
	.macro	seta	A,B	; Define macro seta
	  .byte	A,B		; 00 01 00 6A
	.endm

	.org	0
	seta	0x01, 'j

	.mdelete	seta


	; Macro definition with the
	; name 'setb' and a regular
	; argument and a dumby argument.
	;
	.macro	setb	A,?B	; Define macro setb
B:	  .byte	A		; 00 02
	  .word	B		;s00r00
	.endm

	.org	0
	setb	0x02, K		; Use label K

	.mdelete	setb


	.macro	setb	A,?B	; Define macro setb
B:	  .byte	A		; 00 03
	  .word	B		;s00r02
	.endm

	setb	0x03		; Create a local symbol

	.mdelete	setb


	.page
	; Macro definition with the
	; name 'setc' and two regular
	; arguments with concatenation.
	;
	.macro setc	A,B	; Define macro setc
A'B:	  .byte	0x04		; 00 04
	  .word	A'B		;s00r00
	.endm

	.org	0
	setc	J, K

	.mdelete	.setc


	; Macro definition with the
	; name 'setd' and three regular
	; arguments with concatenation.
	;
	.macro setd	A,B,C	; Define macro setd
A'B:	  .byte	0x05		; 00 05
	  .word	A'B		;s00r00
A'C:	  .byte	0x06		; 00 06
	  .word	A'C		;s00r02
B'C:	  .byte	0x07		; 00 07
	  .word	B'C		;s00r04
A''B''C:  .byte	0x08		; 00 08
	  .word	A''B''C		;s00r06
	.endm

	.org	0
	setd	X, Y, Z

	.mdelete	.setd


	.page
	; Macro definition with the
	; name 'sete' and two regular
	; arguments.  The second
	; argument is converted to
	; a numerical value.
	.macro	sete	A,B	; Define macro sete
	 ...A = A
	 ...B = B
	 .byte	A,B
	 A = A + 1
	.endm

	qxd = 0
	sete	qxd, \(qxd+1)
	.iif	ne,...A-0	.error	1	; ...A != 0
	.iif	ne,...B-1	.error	1	; ...B != 1
	sete	qxd, \(qxd+2)
	.iif	ne,...A-1	.error	1	; ...A != 1
	.iif	ne,...B-3	.error	1	; ...B != 3
	sete	qxd, \(qxd+3)
	.iif	ne,...A-2	.error	1	; ...A != 2
	.iif	ne,...B-5	.error	1	; ...B != 5

	.mdelete	.sete


	.page
	; Macro definition with
	; conditional exits.
	.macro	cond	A,B,C	; Define macro cond
	...A = 0
	.if	nb,^!A!
	  .if	nb,^!B!
	    .if	nb,^!C!
	      ...A = 3
	      .mexit	; C
	    .endif
	    ...A = 2
	    .mexit	; B
	  .endif
	  ...A = 1
	  .mexit	; A
	.endif
	.endm

	cond
	.iif	ne,...A-0	.error	1	; ...A != 0
	cond	1
	.iif	ne,...A-1	.error	1	; ...A != 1
	cond	1,2
	.iif	ne,...A-2	.error	1	; ...A != 2
	cond	1,2,3
	.iif	ne,...A-3	.error	1	; ...A != 3

	.mdelete	cond


	.page
	.sbttl	Repeat Macro
	; Repeat Macro Definition.

	.macro	RMD	J,K
	 .byte	...cnt	J'K
	.endm

	...cnt = 0
	.rept	0d5
	 RMD	^!; 00 0!,\...cnt
	 ...cnt = ...cnt + 1
	.endm
	.iif	ne,...cnt - 5	.error	1	; ...cnt != 5


	...cnt = 0
	.rept	0d10
	 RMD	^!; 00 0!,\...cnt
	 ...cnt = ...cnt + 1
	 .iif	eq,...cnt - 5	.mexit
	 .iif	gt,...cnt - 5	.error	1	; ...cnt >  5
	.endm
	.iif	ne,...cnt - 5	.error	1	; ...cnt != 5

	.mdelete	RMD


	.page
	.sbttl	Indefinite Repeat Macro

	...val = 0d12
	.irp	sym	A,B,\...val
	 .globl	val'sym
	 .word	val'sym		;s00r00
	.endm


	.irp	sym	^!.word	0x1234		; 02 34!,	^!.byte	0xFF		; 00 FF!
	 sym
	.endm


	.page
	.sbttl	Indefinite Repeat on Character
	;
	; Note that these macros are used to create
	; comments.  The comment delimiter ';' always
	; terminates the macro substitution scan when
	; found in a macro call.
	;(even if the ';' is within a delimited string !!!)
	;
	; The ';' character is thus placed in the last
	; argument of the macro call.
	;

	.macro	irpcm1	I	J,K,L,M
	 .byte	''I,''I - '0	M'J'K'L
	.endm

	.macro	irpcm2	I	J,K,L
	 .asciz	"'I"			L'J'K
	.endm

	.irpc	sym	0123456789abcdef
	 ...sym = ''sym
	 .if	ge,''sym - '0
	  .if	le,''sym - '9
	   irpcm1	sym	\''sym, ^! 00 0!, \(''sym-'0), ^!; 00 !
	  .else
	   irpcm2	sym	\''sym, ^! 00 00!, ^!; 00 !
	  .endif
	 .endif
	.endm

	.mdelete	irpcm1, irpcm2


	.page
	.sbttl	Macro Definitions and User Labels

	.macro	DUL	A	B,C
	 .byte	A	C'B
	.endm

	.macro	LESS	I,J	; Define macro LESS
	  .iif	lt,(I - J)	DUL	I	\I, ^!; 00 0!
	  .iif	gt,(I - J)	DUL	J	\J, ^!; 00 0!
	  .iif	eq,(I - J)	DUL	0	\0, ^!; 00 0!
	.endm

	sym1	=	1
	sym2	=	2

	.org	0
				;LESS is defined as a label
LESS:	.byte	2	        ; 00 02
	  ;
	  ;
	  ;			;LESS is considered to be a label
	.word	LESS		;s00r00
	  ;
	  ;
	  ;
	LESS	sym1,sym2	;LESS is a macro call


	.page
	.sbttl	Immediate Conditional Macro Execution

	.if	ne,0
	  .byte	0xE0		; 00 E0
	  .iif    f	LESS	sym1,sym2
	  .byte 0xE1		; 00 E1
	  .iif	  t	LESS	sym2,sym1
	  .byte	0xE2		; 00 E2
	  .iif    tf	LESS	sym1,sym1
	  .byte	0xE3		; 00 E3
	.endif

	.if	eq,0
	  .byte	0xF0		; 00 F0
	  .iif	  f	LESS	sym1,sym2
	  .byte	0xF1		; 00 F1
	  .iif    t	LESS	sym2,sym1
	  .byte 0xF2		; 00 F2
	  .iif    tf	LESS	sym2,sym2
	  .byte	0xF3		; 00 F3
	.endif

	.mdelete	DUL, LESS


	.sbttl	Assembler Symbol Table Output

.if 0

 Listing of Symbol Table

       assembled by:
                as6100 -glacxff as12bthi.asm

Symbol Table

    ...A           =   0003     |     ...B           =   0005 
    ...cnt         =   0005     |     ...sym         =   0066 
    ...val         =   000C     |     .__.$$$.       =   2711 L
    .__.ABS.       =   0000 G   |     .__.CPU.       =   0000 L
    .__.H$L.       =   0001 L   |     AreaB              **** GX
  3 JK                 0000 R   |   3 K                  0000 R
  3 LESS               0000 R   |     OVR                **** GX
  3 XY                 0000 R   |   3 XYZ                0006 R
  3 XZ                 0002 R   |   3 YZ                 0004 R
  2 a0                 0000 R   |     a1                 **** GX
    a2                 **** GX  |   3 abcdabcd           0045 GR
  1 bndry_1            0000 R   |   1 bndry_2            0000 R
  1 bndry_3            0000 R   |   1 bndry_4            0000 R
  1 bndry_5            0000 R   |   1 bndry_6            0000 R
    cnstnt0        =   ABCD G   |     cnstnt1        =   1234 G
    cnstnt2        =   5678 G   |   1 code0              0041 GR
    extern             **** GX  |   1 lclsym0            0000 R
  1 lclsym1            001E R   |     m              =   0000 
    n              =   0001     |     n0x00          =   0000 
    n0x01          =   0001     |     n0x10          =   0010 
    n0xeeff        =   EEFF     |     n0xff          =   00FF 
    ofsbyte        =   000A     |     ofsword        =   0005 
    qxd            =   0003     |     sym1           =   0001 
    sym2           =   0002     |     valA               **** GX
    valB               **** GX  |     valC               **** GX
  1 word               0076 R

ASxxxx Assembler V05.06+  (Intersil IM6100 / Harris HM6100)            Page 56
Hexadecimal [16-Bits]                                 Mon Oct 28 17:32:24 2013
Machine Independent Assembler Test
Area Table

[_CSEG]
   0 _CODE            size    0   flags C081
[_DSEG]
   1 _DATA            size   43   flags CDCD
   2 AreaA            size   22   flags C5C5
   3 AreaB            size    B   flags CDCD

.endif


