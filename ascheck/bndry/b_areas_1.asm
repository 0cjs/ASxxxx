	.title	Boundary Tests
	.module	b_areas_1

	.sbttl	Power of 2 Boundary Modes

	.area	Area_1	(ABS,CON)

0$:
	.org	0
1$:			; Address == 0
	.even
2$:			; Address == 0
	.odd
3$:			; Address == 1
	.odd
4$:			; Address == 1
	.even
5$:			; Address == 2
	.even
6$:			; Address == 2
	.odd
7$:			; Address == 3
	.odd
8$:			; Address == 3
	.even
9$:			; Address == 4

	.word	0$
	.word	1$		; 00 00
	.word	2$		; 00 00
	.word	3$		; 00 01
	.word	4$		; 00 01
	.word	5$		; 00 02
	.word	6$		; 00 02
	.word	7$		; 00 03
	.word	8$		; 00 03
	.word	9$		; 00 04
Area_1_1:


	.page

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 2 (0x0002)

	.area	Area_2	(REL,CON)

0$:
	. = . + 0
1$:			; Address == 0
	.even
2$:			; Address == 0
	.odd
3$:			; Address == 1
	.odd
4$:			; Address == 1
	.even
5$:			; Address == 2
	.even
6$:			; Address == 2
	.odd
7$:			; Address == 3
	.odd
8$:			; Address == 3
	.even
9$:			; Address == 4

	.word	0$
	.word	1$ - 0$		; 00 00
	.word	2$ - 0$		; 00 00
	.word	3$ - 0$		; 00 01
	.word	4$ - 0$		; 00 01
	.word	5$ - 0$		; 00 02
	.word	6$ - 0$		; 00 02
	.word	7$ - 0$		; 00 03
	.word	8$ - 0$		; 00 03
	.word	9$ - 0$		; 00 04

	.word	b_Area_2_1	; 00 02
	.word	s_Area_2
	.word	l_Area_2
Area_2_1:


	.page

	.area	Area_A	(ABS,OVR)

0$:
	.org	0
1$:			; Address == 0
	.even
2$:			; Address == 0
	.odd
3$:			; Address == 1
	.odd
4$:			; Address == 1
	.even
5$:			; Address == 2
	.even
6$:			; Address == 2
	.odd
7$:			; Address == 3
	.odd
8$:			; Address == 3
	.even
9$:			; Address == 4

	.word	0$
	.word	1$		; 00 00
	.word	2$		; 00 00
	.word	3$		; 00 01
	.word	4$		; 00 01
	.word	5$		; 00 02
	.word	6$		; 00 02
	.word	7$		; 00 03
	.word	8$		; 00 03
	.word	9$		; 00 04
Area_A:


	.end	0x1234
