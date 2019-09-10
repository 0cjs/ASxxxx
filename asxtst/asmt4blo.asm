	.title	Machine Independent Assembler Test
	.module Asmtst

	;  The file 'asmt4blo.asm' must be assembled with
	; a LO/HI assembler (in file ___ext.c, hilo = 0).
	;
	;  The file 'asmt4bhi.asm' must be assembled with
	; a HI/LO assembler (in file ___ext.c, hilo = 1).
	;
	;	asmt:
	;		4	4-byte PC addressing
	;		b	1 byte data addressing
	;		lo	LO/HI assembler
	;		hi	HI/LO assembler
	;
	; All .areas must be of type DSEG.

	.sbttl	Memory Allocation Directives

	.area	_DATA	(abs,ovr)        ; Data Area

	.radix	O			; set default to octal

					; binary constants
	.byte	0b11000000		; C0
	.byte	0B1110			; 0E
	.byte	$%11000000		; C0

					; octal constants
	.byte	24			; 14
	.byte	024			; 14
	.byte	0q024			; 14
	.byte	0Q024			; 14
	.byte	0o024			; 14
	.byte	0O024			; 14
	.byte	$&24			; 14

					; decimal constant
	.byte	0d024			; 18
	.byte	0D024			; 18
	.byte	$#24			; 18

					; hexidecimal constants
	.byte	0h024			; 24
	.byte	0H024			; 24
	.byte	0x024			; 24
	.byte	0X024			; 24
	.byte	$$24			; 24

	.db	0			; 00
	.dw	0			; 00 00

	.radix	D			; set default to decimal

	.byte	1,2,3			; 01 02 03
	.byte	4,5,6			; 04 05 06
	.byte	7,8,9			; 07 08 09
	.word	1,2,3			; 01 00 02 00 03 00
	.word	4,5,6			; 04 00 05 00 06 00
	.word	7,8,9			; 07 00 08 00 09 00

	.blkb	16
	.ds	16

	.blkw	16
	.ds	16*2

word:	.word	.+2			;r92s00
	.word	.-2			;r90s00
	.word	2+.			;r96s00
	.word	.-(word+2)		; 04 00

byte4:	.4byte	.+3			;r9Bs00R00S00
	.4byte	.-3			;r99s00R00S00
	.4byte	3+.			;rA3s00R00S00
	.4byte	.-(byte4+2)		; 0A 00 00 00


	.page
	.sbttl	Boundary Directives

	.area	bndry_1	(ABS,OVR,DSEG)
	.org	0
bndry_1:

	.even
1$:	.byte	1$ - bndry_1		; 00
	.even
2$:	.byte	2$ - bndry_1		; 02
	.even
	.odd
3$:	.byte	3$ - bndry_1		; 05
	.odd
4$:	.byte	4$ - bndry_1		; 07
	.odd
	.even
5$:	.word	5$ - bndry_1		; 0A 00
	.odd
6$:	.word	6$ - bndry_1		; 0D 00
	.even
7$:	.word	7$ - bndry_1		; 10 00


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
1$:	.word	1$ - bndry_3	; 02 00

	.org	1
	.bndry	2		; Address == 2
2$:	.word	2$ - bndry_3	; 02 00

	.org	1
	.bndry	4		; Address == 4
3$:	.word	3$ - bndry_3	; 04 00

	.org	1
	.bndry	8		; Address == 8
4$:	.word	4$ - bndry_3	; 08 00

	.org	1
	.bndry	16		; Address == 16
5$:	.word	5$ - bndry_3	; 10 00

	.org	1
	.bndry	32		; Address == 32
6$:	.word	6$ - bndry_3	; 20 00

	.org	1
	.bndry	64		; Address == 64
7$:	.word	7$ - bndry_3	; 40 00

	.org	1
	.bndry	128		; Address == 128
8$:	.word	8$ - bndry_3	; 80 00

	.org	1
	.bndry	256		; Address == 256
9$:	.word	9$ - bndry_3	; 00 01

	.org	1
	.bndry	512		; Address == 512
10$:	.word	10$ - bndry_3	; 00 02

	.org	1
	.bndry	1024		; Address == 1024
11$:	.word	11$ - bndry_3	; 00 04


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
1$:	.word	1$ - bndry_5	; 03 00

	.org	1
	.bndry	5		; Address == 5
2$:	.word	2$ - bndry_5	; 05 00

	.org	1
	.bndry	9		; Address == 9
3$:	.word	3$ - bndry_5	; 09 00

	.org	1
	.bndry	17		; Address == 17
4$:	.word	4$ - bndry_5	; 11 00

	.org	1
	.bndry	33		; Address == 33
5$:	.word	5$ - bndry_5	; 21 00


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
1$:	.word	1$ - bndry_6	; 30 00

	.org	47
	.bndry	6		; Address == 48
2$:	.word	2$ - bndry_6	; 30 00

	.org	47
	.bndry	12		; Address == 48
3$:	.word	3$ - bndry_6	; 30 00

	.org	47
	.bndry	24		; Address == 48
4$:	.word	4$ - bndry_6	; 30 00

	.org	47
	.bndry	48		; Address == 48
5$:	.word	5$ - bndry_6	; 30 00

	.org	47
	.bndry	96		; Address == 96
6$:	.word	6$ - bndry_6	; 60 00

	.org	47
	.bndry	192		; Address == 192
7$:	.word	7$ - bndry_6	; C0 00

	.org	47
	.bndry	384		; Address == 384
8$:	.word	8$ - bndry_6	; 80 01

	.org	47
	.bndry	768		; Address == 768
9$:	.word	9$ - bndry_6	; 00 03

	.org	47
	.bndry	1536		; Address == 1536
10$:	.word	10$ - bndry_6	; 00 06


	.page
	.sbttl	String Directives

	.area	_DATA			; Data Area

	.ascii	"abcde"			; 61 62 63 64 65
	.asciz	"abcde"			; 61 62 63 64 65 00
	.ascis	"abcde"			; 61 62 63 64 E5


	.sbttl	Expression Evaluation

	n0x00	=	0x00
	n0x01	=	0x01
	n0x10	=	0x10
	n0xff	=	0xff
	n0xeeff =	0xeeff

	n =	< n0xeeff		; 0xff		low byte
	.byte	>n,<n			; 00 FF
	n =	> n0xeeff		; 0xee		high byte
	.byte	>n,<n			; 00 EE


	n =	'A			; 0x41		single character
	.byte	>n,<n			; 00 41
	n =	"AB			; 0x4241	double character
	.byte	>n,<n			; 42 41
	n =	n0x01			; 0x01		assignment
	.byte	>n,<n			; 00 01
	n =	n + n0x01		; 0x02		addition
	.byte	>n,<n			; 00 02
	n =	n - n0x01		; 0x01		subtraction
	.byte	>n,<n			; 00 01
	n =	n * 0x05		; 0x05		multiplication
	.byte	>n,<n			; 00 05
	n =	n / 0x02		; 0x02		division
	.byte	>n,<n			; 00 02
	n =	n0x10 % 0x05		; 0x01		modulus
	.byte	>n,<n			; 00 01
	n =	n0x10 | n0x01		; 0x11		or
	.byte	>n,<n			; 00 11
	n =	n0xff & n0x01		; 0x01		and
	.byte	>n,<n			; 00 01
	n =	n0x01 << 4		; 0x10		left shift
	.byte	>n,<n			; 00 10
	n =	n0x10 >> 4		; 0x01		right shift
	.byte	>n,<n			; 00 01
	n =	n0xff ^ n0x10		; 0xef		xor
	.byte	>n,<n			; 00 EF
	n =	n ^ n0x10		; 0xff		xor
	.byte	>n,<n			; 00 FF
	n =	~n0x10			; 0xffef	1's complement
	.byte	>n,<n			; FF EF
	n =	-n0x10			; 0xfff0	2's complement
	.byte	>n,<n			; FF F0



	n =	n0xeeff & 0xff		; 0xff		low byte
	.byte	>n,<n			; 00 FF
	n =	(n0xeeff & 0xff00)/0x100; 0xee		high byte
	.byte	>n,<n			; 00 EE


	n =	n0xeeff % 0x100 	; 0xff		low byte
	.byte	>n,<n			; 00 FF
	n =	n0xeeff / 0x100 	; 0xee		high byte
	.byte	>n,<n			; 00 EE


	n =	3*(2 + 4*(6))		; 0x4e		expression evaluation
	.byte	>n,<n			; 00 4E
	n =	2*(0x20 + <~n0x10)	; 0x21e
	.byte	>n,<n			; 02 1E


	.sbttl	arithmatic tests
	;
	; The following series of tests verify that
	; the arithmetic is 32-Bit and unsigned.


	.sbttl	Addition

	n =	 1 +  1			; 0x00000001 + 0x00000001 ; 0x00000002
	.byte	>n,<n			; 00 02
	n =	-1 +  1			; 0xFFFFFFFF + 0x00000001 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-1 + -1			; 0xFFFFFFFF + 0xFFFFFFFF ; 0xFFFFFFFE
	.byte	>n,<n			; FF FE

	n =	 32768 +  32768		; 0x00008000 + 0x00008000 ; 0x00010000
	.byte	>n,<n			; 00 00
	n =	-32768 +  32768		; 0xFFFF8000 + 0x00008000 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32768 + -32768		; 0xFFFF8000 + 0xFFFF8000 ; 0xFFFF0000
	.byte	>n,<n			; 00 00

	n =	 65535 +  1		; 0x0000FFFF + 0x00000001 ; 0x00010000
	.byte	>n,<n			; 00 00
	n =	 65535 + -1		; 0x0000FFFF + 0xFFFFFFFF ; 0x0000FFFE
	.byte	>n,<n			; FF FE


	.sbttl	Subtraction

	n =	 1 -  1			; 0x00000001 - 0x00000001 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-1 -  1			; 0xFFFFFFFF - 0x00000001 ; 0xFFFFFFFE
	.byte	>n,<n			; FF FE
	n =	-1 - -1			; 0xFFFFFFFF - 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00

	n =	 32768 -  32768		; 0x00008000 - 0xFFFF8000 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32768 -  32768		; 0xFFFF8000 - 0x00008000 ; 0xFFFF0000
	.byte	>n,<n			; 00 00
	n =	-32768 - -32768		; 0xFFFF8000 - 0xFFFF8000 ; 0x00000000
	.byte	>n,<n			; 00 00

	n =	 65535 -  1		; 0x0000FFFF - 0x00000001 ; 0x0000FFFE
	.byte	>n,<n			; FF FE
	n =	 65535 - -1		; 0x0000FFFF - 0xFFFFFFFF ; 0x00010000
	.byte	>n,<n			; 00 00


	.sbttl	Multiplication

	n =	 1 *  1			; 0x00000001 * 0x00000001 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	 1 * -1			; 0x00000001 * 0xFFFFFFFF ; 0xFFFFFFFF
	.byte	>n,<n			; FF FF
	n =	-1 * -1			; 0xFFFFFFFF * 0xFFFFFFFF ; 0x00000001
	.byte	>n,<n			; 00 01

	n =	 256 *  256		; 0x00000100 * 0x00000100 ; 0x00010000
	.byte	>n,<n			; 00 00
	n =	 256 * -256		; 0x00000100 * 0xFFFFFF00 ; 0xFFFF0000
	.byte	>n,<n			; 00 00
	n =	-256 * -256		; 0xFFFFFF00 * 0xFFFFFF00 ; 0x00010000
	.byte	>n,<n			; 00 00


	.sbttl	Division

	n =	 1 /  1			; 0x00000001 / 0x00000001 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	10 /  2			; 0x0000000A / 0x00000002 ; 0x00000005
	.byte	>n,<n			; 00 05
	n =	512 / 4			; 0x00000200 / 0x00000004 ; 0x00000080
	.byte	>n,<n			; 00 80
	n =	32768 / 2		; 0x00008000 / 0x00000002 ; 0x00004000
	.byte	>n,<n			; 40 00
	n =	65535 / 2		; 0x0000FFFF / 0x00000002 ; 0x00007FFF
	.byte	>n,<n			; 7F FF

	n = 	 1 / -1			; 0x00000001 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 32767 / -1		; 0x00007FFF / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 32768 / -1		; 0x00008000 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 65534 / -1		; 0x0000FFFE / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 65535 / -1		; 0x0000FFFF / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-1 / -1			; 0xFFFFFFFF / 0xFFFFFFFF ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-2 / -1			; 0xFFFFFFFE / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32768 / -1		; 0xFFFF8000 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32769 / -1		; 0xFFFF7FFF / OxFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-65535 / -1		; 0xFFFF0001 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-65536 / -1		; 0xFFFF0000 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00

	n =	-256 /   -1		; 0xFFFFFF00 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-256 / -255		; 0xFFFFFF00 / 0xFFFFFF01 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-256 / -256		; 0xFFFFFF00 / 0xFFFFFF00 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 / -257		; 0xFFFFFF00 / 0xFFFFFEFF ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 / -32767		; 0xFFFFFF00 / 0xFFFF8001 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 / -32768		; 0xFFFFFF00 / 0xFFFF8000 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 /  32768		; 0xFFFFFF00 / 0x00008000 ; 0x0001FFFF
	.byte	>n,<n			; FF FF
	n =	-256 /  65280		; 0xFFFFFF00 / 0x0000FF00 ; 0x00010101
	.byte	>n,<n			; 01 01
	n =	-256 /  65281		; 0xFFFFFF00 / 0x0000FF01 ; 0x000100FF
	.byte	>n,<n			; 00 FF
	n =	-256 /  65535		; 0xFFFFFF00 / 0x0000FFFF ; 0x00010000
	.byte	>n,<n			; 00 00


	.sbttl	Modulus

	n =	 1 %  1			; 0x00000001 % 0x00000001 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	10 %  2			; 0x0000000A % 0x00000002 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	512 % 4			; 0x00000200 % 0x00000004 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	32768 % 2		; 0x00008000 % 0x00000002 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	65535 % 2		; 0x0000FFFF % 0x00000002 ; 0x00000001
	.byte	>n,<n			; 00 01

	n = 	 1 % -1			; 0x00000001 % 0xFFFFFFFF ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	 32767 % -1		; 0x00007FFF % 0xFFFFFFFF ; 0x00007FFF
	.byte	>n,<n			; 7F FF
	n =	 32768 % -1		; 0x00008000 % 0xFFFFFFFF ; 0x00008000
	.byte	>n,<n			; 80 00
	n =	 65534 % -1		; 0x0000FFFE % 0xFFFFFFFF ; 0x0000FFFE
	.byte	>n,<n			; FF FE
	n =	 65535 % -1		; 0x0000FFFF % 0xFFFFFFFF ; 0x0000FFFF
	.byte	>n,<n			; FF FF
	n =	-1 % -1			; 0xFFFFFFFF % 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-2 % -1			; 0xFFFFFFFE % 0xFFFFFFFF ; 0xFFFFFFFE
	.byte	>n,<n			; FF FE
	n =	-32768 % -1		; 0xFFFF8000 % 0xFFFFFFFF ; 0xFFFF8000
	.byte	>n,<n			; 80 00
	n =	-32769 % -1		; 0xFFFF7FFF % 0xFFFFFFFF ; 0xFFFF7FFF
	.byte	>n,<n			; 7F FF
	n =	-65535 % -1		; 0xFFFF0001 % 0xFFFFFFFF ; 0xFFFF0001
	.byte	>n,<n			; 00 01
	n =	-65536 % -1		; 0xFFFF0000 % 0xFFFFFFFF ; 0xFFFF0000
	.byte	>n,<n			; 00 00

	n =	-256 %   -1		; 0xFFFFFF00 % 0xFFFFFFFF ; 0XFFFFFF00
	.byte	>n,<n			; FF 00
	n =	-256 % -255		; 0xFFFFFF00 % 0xFFFFFF01 ; 0xFFFFFF00
	.byte	>n,<n			; FF 00
	n =	-256 % -256		; 0xFFFFFF00 % 0xFFFFFF00 ; 0X00000000
	.byte	>n,<n			; 00 00
	n =	-256 % -257		; 0xFFFFFF00 % 0XFFFFFF01 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 % -32767		; 0xFFFFFF00 % 0xFFFF8001 ; 0x00007EFF
	.byte	>n,<n			; 7E FF
	n =	-256 % -32768		; 0xFFFFFF00 % 0xFFFF8000 ; 0x00007F00
	.byte	>n,<n			; 7F 00
	n =	-256 %  32768		; 0xFFFFFF00 % 0x00008000 ; 0x00007F00
	.byte	>n,<n			; 7F 00
	n =	-256 %  65280		; 0xFFFFFF00 % 0x0000FF00 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-256 %  65281		; 0xFFFFFF00 % 0x0000FF01 ; 0x0000FD01
	.byte	>n,<n			; FD 01
	n =	-256 %  65535		; 0xFFFFFF00 % 0x0000FFFF ; 0x0000FF00
	.byte	>n,<n			; FF 00


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
	.byte	n,m			; 02 00


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
	.byte	n,m			; 01 02

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
	.byte	n,m			; 02 00


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
	.byte	n,m			; 01 01

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
	.byte	n,m			; 02 02


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
	.byte	n,m			; 01 00

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
	.byte	n,m			; 02 01


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
	.byte	n,m			; 01 00

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
	 .byte	0x06	        ; 06
	.endif

	.ifnb			; 0
	 .error	1		; .if nb failed
	.endif

	.ifnb	J		; 1
	 .byte	0x07		; 07
	.endif

	.undefine	defsym
	.ifdef	defsym		; 0
	 .error	1		; .if def,defsym failed
	.endif

	.define		defsym
	.ifdef	defsym		; 1
	 .byte	0x08	        ; 08
	.endif

	.ifndef	defsym		; 0
	 .error	1		; .if def,defsym failed
	.endif

	.undefine	defsym
	.ifndef	defsym		; 1
	 .byte	0x09		; 09
	.endif

	.ifidn	A,B		; 0
	 .error	1		; .if iden A,B failed
	.endif

	.ifidn	D,D		; 1
	 .byte	0x0A		; 0A
	.endif

	.ifdif	D,D		; 0
	 .error	1		; .if dif D,D failed
	.endif

	.ifdif	A,B		; 1
	 .byte	0x0B		; 0B
	.endif


	.page
	.sbttl	Alternate Conditionals With String Tests

	.if	b	J	; 0
	 .error	1		; .if b,J failed
	.endif

	.if	b		; 1
	 .byte	0x06	        ; 06
	.endif

	.if	nb		; 0
	 .error	1		; .if nb failed
	.endif

	.if	nb	J	; 1
	 .byte	0x07		; 07
	.endif

	.undefine	defsym
	.if	def	defsym	; 0
	 .error	1		; .if def,defsym failed
	.endif

	.define		defsym
	.if	def	defsym	; 1
	 .byte	0x08	        ; 08
	.endif

	.if	ndef	defsym	; 0
	 .error	1		; .if def,defsym failed
	.endif

	.undefine	defsym
	.if	ndef	defsym	; 1
	 .byte	0x09		; 09
	.endif

	.if	idn	A,B	; 0
	 .error	1		; .if iden A,B failed
	.endif

	.if	idn	D,D	; 1
	 .byte	0x0A		; 0A
	.endif

	.if	dif	D,D	; 0
	 .error	1		; .if dif D,D failed
	.endif

	.if	dif	A,B	; 1
	 .byte	0x0B		; 0B
	.endif


	.page
	.sbttl	Signed Immediate Conditionals

	n = -1

	.iifeq	n	.error	1	; n = -1, .ifeq n  != 0
	.iifne	n	.byte	0x01	; 01
	.iifgt	n	.error	1	; n = -1, .ifgt n  !>= 0
	.iiflt	n	.byte	0x02	; 02
	.iifge	n	.error	1	; n = -1, .ifge n  !>= 0
	.iifle	n	.byte	0x03	; 03


	n = 0

	.iifeq	n	.byte	0x04	; 04
	.iifne	n	.error	1	; n = 0, .ifne n  == 0
	.iifgt	n	.error	1	; n = 0, .ifgt n  !> 0
	.iiflt	n	.error	1	; n = 0, .iflt n  !< 0
	.iifge	n	.byte	0x05	; 05
	.iifle	n	.byte	0x06; 06


	n = +1

	.iifeq	n	.error	1	; n = +1, .ifeq n  != 0
	.iifne	n	.byte	0x07; 07
	.iifgt	n	.byte	0x08; 08
	.iiflt	n	.error	1	; n = +1, .iflt n  !<= 0
	.iifge	n	.byte	0x09; 09
	.iifle	n	.error	1	; n = +1, .ifle n  !<= 0


	.page
	.sbttl	Alternate Signed Immediate Conditionals

	n = -1

	.iif	eq,n	.error	1	; n = -1, .ifeq n  != 0
	.iif	ne,n	.byte	0x01	; 01
	.iif	gt,n	.error	1	; n = -1, .ifgt n  !>= 0
	.iif	lt,n	.byte	0x02	; 02
	.iif	ge,n	.error	1	; n = -1, .ifge n  !>= 0
	.iif	le,n	.byte	0x03	; 03


	n = 0

	.iif	eq,n	.byte	0x04	; 04
	.iif	ne,n	.error	1	; n = 0, .ifne n  == 0
	.iif	gt,n	.error	1	; n = 0, .ifgt n  !> 0
	.iif	lt,n	.error	1	; n = 0, .iflt n  !< 0
	.iif	ge,n	.byte	0x05	; 05
	.iif	le,n	.byte	0x06	; 06


	n = +1

	.iif	eq,n	.error	1	; n = +1, .ifeq n  != 0
	.iif	ne,n	.byte	0x07	; 07
	.iif	gt,n	.byte	0x08	; 08
	.iif	lt,n	.error	1	; n = +1, .iflt n  !<= 0
	.iif	ge,n	.byte	0x09	; 09
	.iif	le,n	.error	1	; n = +1, .ifle n  !<= 0


	.page
	.sbttl	Immediate Conditionals With Strings

	.iifb	J	 .error	1	; .if b,J failed
	.iifb	^!!	 .byte	0x01	; 01
	.iifnb	^!!	 .error	1	; .if nb failed
	.iifnb	J	 .byte	0x02	; 02

	.undefine  defsym
	.iifdef	defsym	 .error	1	; .if def,defsym failed

	.define  defsym
	.iifdef	defsym	.byte	0x03	; 03
	.iifndef defsym	.error	1	; .if def,defsym failed

	.undefine  defsym
	.iifndef defsym	 .byte	0x04	; 04

	.iifidn	A,B	.error	1	; .if iden A,B failed
	.iifidn	D,D	.byte	0x05	; 05
	.iifdif	D,D	.error	1	; .if dif D,D failed
	.iifdif	A,B	.byte	0x06	; 06


	.page
	.sbttl	Alternate Immediate Conditionals With Strings

	.iif	b,J	 .error	1	; .if b,J failed
	.iif	b,^!!	 .byte	0x01	; 01
	.iif	nb,^!!	 .error	1	; .if nb failed
	.iif	nb,J	 .byte	0x02	; 02

	.undefine  defsym
	.iif	def,defsym	 .error	1	; .if def,defsym failed

	.define  defsym
	.iif	def,defsym	.byte	0x03	; 03
	.iif	ndef,defsym	.error	1	; .if def,defsym failed

	.undefine  defsym
	.iif	ndef,defsym	 .byte	0x04	; 04

	.iif	idn	A,B	.error	1	; .if iden A,B failed
	.iif	idn	D,D	.byte	0x05	; 05
	.iif	dif	D,D	.error	1	; .if dif D,D failed
	.iif	dif	A,B	.byte	0x06	; 06


	.page
	.sbttl	Local Symbols

	.org	0

lclsym0:
					; forward references
	.word	0$,1$			;r14s00r16s00
	.word	2$,3$			;r18s00r1As00
	.word	4$,5$			;r1Cs00r1Es00
	.word	6$,7$			;r20s00r22s00
	.word	8$,9$			;r24s00r26s00

0$:	.word	9$			;r26s00
1$:	.word	8$			;r24s00
2$:	.word	7$			;r22s00
3$:	.word	6$			;r20s00
4$:	.word	5$			;r1Es00
5$:	.word	4$			;r1Cs00
6$:	.word	3$			;r1As00
7$:	.word	2$			;r18s00
8$:	.word	1$			;r16s00
9$:	.word	0$			;r14s00
10$:

					; backward references
	.word	0$,1$			;r14s00r16s00
	.word	2$,3$			;r18s00r1As00
	.word	4$,5$			;r1Cs00r1Es00
	.word	6$,7$			;r20s00r22s00
	.word	8$,9$			;r24s00r26s00

	.page

lclsym1:
					; forward references
	.word	0$,1$			;r50s00r52s00
	.word	2$,3$			;r54s00r56s00
	.word	4$,5$			;r58s00r5As00
	.word	6$,7$			;r5Cs00r5Es00
	.word	8$,9$			;r60s00r62s00

0$:	.word	9$			;r62s00
1$:	.word	8$			;r60s00
2$:	.word	7$			;r5Es00
3$:	.word	6$			;r5Cs00
4$:	.word	5$			;r5As00
5$:	.word	4$			;r58s00
6$:	.word	3$			;r56s00
7$:	.word	2$			;r54s00
8$:	.word	1$			;r52s00
9$:	.word	0$			;r50s00
10$:

					; backward references
	.word	0$,1$			;r50s00r52s00
	.word	2$,3$			;r54s00r56s00
	.word	4$,5$			;r58s00r5As00
	.word	6$,7$			;r5Cs00r5Es00
	.word	8$,9$			;r60s00r62s00


	.page
	.sbttl	Offset calculations

	ofsbyte	=	(10$-0$)	; 0x0014
	ofsword	=	ofsbyte/2	; 0x000A

					; 1$ + 0x001E
	.word	1$+ofsbyte+ofsword	;r70s00

	.sbttl	Lower/Upper Byte Selections

	.globl	extern

					; low byte
	.byte	< (extern + 0x0001)	;r01

					; low byte
	.byte	< (extern + 0x0200)	;r00

					; high byte
	.byte	> (extern + 0x0003)	;s00

					; high byte
	.byte	> (extern + 0x0400)	;s04

	.msb	0			; select byte 0
	.byte	> (extern + 0x76543210)	;r10

	.msb	1			; select byte 1
	.byte	> (extern + 0x76543210)	;s32

	.msb	2			; select byte 2
	.byte	> (extern + 0x76543210)	;R54

	.msb	3			;select byte 3
	.byte	> (extern + 0x76543210)	;S76

	.msb	1			; reset to byte 1


	.page
	.sbttl	Area Definitions

	.globl	code0
	.globl	cnstnt1,cnstnt2

	cnstnt0 == 0xabcd		; global equate

code0:	.word	a0			;r00s00
	.word	cnstnt0			; CD AB

	; Bank selected as _DSEG
	; Overlay and Data Segment
	.area	AreaA (OVR,DSEG,BANK=_DSEG)

	cnstnt1 = 0x1234

a0:	.word	0x00ff			; FF 00

	; Bank selected as _DSEG
	; Overlay and Data Segment
	.area	AreaB (ABS,OVR,DSEG,BANK=_DSEG)

	cnstnt2 = 0x5678

	.word	a1			;r00s00

	.area	AreaA

	.=.+0x0020
	.word	a2			;r00s00

	.area	AreaB
	.org	0x40

	.word	a0,a1,a2		;r00s00r00s00r00s00
	.word	AreaB,OVR		;r00s00r00s00

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
	  .byte	A,B		; 01 6A
	.endm

	.org	0
	seta	0x01, 'j

	.mdelete	seta


	; Macro definition with the
	; name 'setb' and a regular
	; argument and a dumby argument.
	;
	.macro	setb	A,?B	; Define macro setb
B:	  .byte	A		; 02
	  .word	B		;r00s00
	.endm

	.org	0
	setb	0x02, K		; Use label K

	.mdelete	setb


	.macro	setb	A,?B	; Define macro setb
B:	  .byte	A		; 03
	  .word	B		;r03s00
	.endm

	setb	0x03		; Create a local symbol

	.mdelete	setb


	.page
	; Macro definition with the
	; name 'setc' and two regular
	; arguments with concatenation.
	;
	.macro setc	A,B	; Define macro setc
A'B:	  .byte	0x04		; 04
	  .word	A'B		;r00s00
	.endm

	.org	0
	setc	J, K

	.mdelete	.setc


	; Macro definition with the
	; name 'setd' and three regular
	; arguments with concatenation.
	;
	.macro setd	A,B,C	; Define macro setd
A'B:	  .byte	0x05		; 05
	  .word	A'B		;r00s00
A'C:	  .byte	0x06		; 06
	  .word	A'C		;r03s00
B'C:	  .byte	0x07		; 07
	  .word	B'C		;r06s00
A''B''C:  .byte	0x08		; 08
	  .word	A''B''C		;r09s00
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
	 RMD	^!; 0!,\...cnt
	 ...cnt = ...cnt + 1
	.endm
	.iif	ne,...cnt - 5	.error	1	; ...cnt != 5


	...cnt = 0
	.rept	0d10
	 RMD	^!; 0!,\...cnt
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
	 .word	val'sym		;r00s00
	.endm


	.irp	sym	^!.word	0x1234		; 34 12!,	^!.byte	0xFF		; FF!
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

	.macro	irpcm2	I	J,K
	 .asciz	"'I"			K'J' 00
	.endm

	.irpc	sym	0123456789abcdef
	 ...sym = ''sym
	 .if	ge,''sym - '0
	  .if	le,''sym - '9
	   irpcm1	sym	\''sym, ^! 0!, \(''sym-'0), ^!; !
	  .else
	   irpcm2	sym	\''sym, ^!; !
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
	  .iif	lt,(I - J)	DUL	I	\I, ^!; 0!
	  .iif	gt,(I - J)	DUL	J	\J, ^!; 0!
	  .iif	eq,(I - J)	DUL	0	\0, ^!; 0!
	.endm

	sym1	=	1
	sym2	=	2

	.org	0
				;LESS is defined as a label
LESS:	.byte	2	        ; 02
	  ;
	  ;
	  ;			;LESS is considered to be a label
	.word	LESS		;r00s00
	  ;
	  ;
	  ;
	LESS	sym1,sym2	;LESS is a macro call


	.page
	.sbttl	Immediate Conditional Macro Execution

	.if	ne,0
	  .byte	0xE0
	  .iif    f	LESS	sym1,sym2
	  .byte 0xE1
	  .iif	  t	LESS	sym2,sym1
	  .byte	0xE2
	  .iif    tf	LESS	sym1,sym1
	  .byte	0xE3
	.endif

	.if	eq,0
	  .byte	0xF0
	  .iif	  f	LESS	sym1,sym2
	  .byte	0xF1
	  .iif    t	LESS	sym2,sym1
	  .byte 0xF2
	  .iif    tf	LESS	sym2,sym2
	  .byte	0xF3
	.endif

	.mdelete	DUL, LESS


	.sbttl	Assembler Symbol Table Output

.if 0

 Listing of Symbol Table

       assembled by:
                asxxxx -gloxff out lohi.asm a32bit.asm asmt4blo.asm

Symbol Table

    ...A           =    00000003 G   |     ...B           =    00000005 G
    ...cnt         =    00000005 G   |     ...sym         =    00000066 G
    ...val         =    0000000C G   |     .__.$$$.       =    00002711 L
    .__.ABS.       =    00000000 G   |     .__.CPU.       =    00000000 L
    .__.H$L.       =    00000000 L   |     AreaB               ******** GX
  3 JK                  00000000 GR  |   3 K                   00000000 GR
  3 LESS                00000000 GR  |     OVR                 ******** GX
  3 XY                  00000000 GR  |   3 XYZ                 00000009 GR
  3 XZ                  00000003 GR  |   3 YZ                  00000006 GR
  2 a0                  00000000 GR  |     a1                  ******** GX
    a2                  ******** GX  |   3 abcdabcd            0000004A GR
  1 bndry_1             00000000 GR  |   1 bndry_2             00000000 GR
  1 bndry_3             00000000 GR  |   1 bndry_4             00000000 GR
  1 bndry_5             00000000 GR  |   1 bndry_6             00000000 GR
  1 byte4               00000098 GR  |     cnstnt0        =    0000ABCD G
    cnstnt1        =    00001234 G   |     cnstnt2        =    00005678 G
  1 code0               00000082 GR  |     extern              ******** GX
  1 lclsym0             00000000 GR  |   1 lclsym1             0000003C GR
    m              =    00000000 G   |     n              =    00000001 G
    n0x00          =    00000000 G   |     n0x01          =    00000001 G
    n0x10          =    00000010 G   |     n0xeeff        =    0000EEFF G
    n0xff          =    000000FF G   |     ofsbyte        =    00000014 G
    ofsword        =    0000000A G   |     qxd            =    00000003 G
    sym1           =    00000001 G   |     sym2           =    00000002 G
    valA                ******** GX  |     valB                ******** GX
    valC                ******** GX  |   1 word                00000090 GR


Area Table

[_CSEG]
   0 _CODE            size        0   flags C080
[_DSEG]
   1 _DATA            size       86   flags CDCC
   2 AreaA            size       24   flags C5C4
   3 AreaB            size        C   flags CDCC

.endif


