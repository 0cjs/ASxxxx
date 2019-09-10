	.title	Boundary Tests
	.module	b_areas_3

	.sbttl	Mixed Boundaries

	.area	Area_1	(ABS,CON)

0$:
	;.org	0
1$:			; Address == 0
	.odd
2$:			; Address == 1
	.even
3$:			; Address == 2
	.odd
4$:			; Address == 3
	.bndry	9
5$:			; Address == 9
	.bndry	8
6$:			; Address == 16
	.bndry	6
7$:			; Address == 18
	.bndry	4
8$:			; Address == 20
	.bndry	3
9$:			; Address == 21
	.bndry	2
10$:			; Address == 22

	.word	0$
	.word	1$ - 0$		; 00 00
	.word	2$ - 0$		; 00 01
	.word	3$ - 0$		; 00 02
	.word	4$ - 0$		; 00 03
	.word	5$ - 0$		; 00 09
	.word	6$ - 0$		; 00 10
	.word	7$ - 0$		; 00 12
	.word	8$ - 0$		; 00 14
	.word	9$ - 0$		; 00 15
	.word	10$ - 0$	; 00 16
Area_1_3:


	.page

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 72 (0x0048)

	.area	Area_2	(REL,CON)

0$:
	. = . + 0
1$:			; Address == 0
	.odd
2$:			; Address == 1
	.even
3$:			; Address == 2
	.odd
4$:			; Address == 3
	.bndry	9
5$:			; Address == 9
	.bndry	8
6$:			; Address == 16
	.bndry	6
7$:			; Address == 18
	.bndry	4
8$:			; Address == 20
	.bndry	3
9$:			; Address == 21
	.bndry	2
10$:			; Address == 22

	.word	0$
	.word	1$ - 0$		; 00 00
	.word	2$ - 0$		; 00 01
	.word	3$ - 0$		; 00 02
	.word	4$ - 0$		; 00 03
	.word	5$ - 0$		; 00 09
	.word	6$ - 0$		; 00 10
	.word	7$ - 0$		; 00 12
	.word	8$ - 0$		; 00 14
	.word	9$ - 0$		; 00 15
	.word	10$ - 0$	; 00 16

	.word	b_Area_2_3	; 00 48
	.word	s_Area_2
	.word	l_Area_2
Area_2_3:


	.page

	.area	Area_C	(ABS,OVR)

0$:
	.org	0
1$:			; Address == 0
	.odd
2$:			; Address == 1
	.even
3$:			; Address == 2
	.odd
4$:			; Address == 3
	.bndry	9
5$:			; Address == 9
	.bndry	8
6$:			; Address == 16
	.bndry	6
7$:			; Address == 18
	.bndry	4
8$:			; Address == 20
	.bndry	3
9$:			; Address == 21
	.bndry	2
10$:			; Address == 22

	.word	0$
	.word	1$		; 00 00
	.word	2$		; 00 01
	.word	3$		; 00 02
	.word	4$		; 00 03
	.word	5$		; 00 09
	.word	6$		; 00 10
	.word	7$		; 00 12
	.word	8$		; 00 14
	.word	9$		; 00 15
	.word	10$		; 00 16
Area_C_1:


