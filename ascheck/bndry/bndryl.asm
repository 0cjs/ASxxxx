	.title	Boundary Tests

	.area	Bndry_1	(ABS,OVR)

	.sbttl	Power of 2 Boundary Modes

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

	.word	1$		; 00 00
	.word	2$		; 00 00
	.word	3$		; 00 01
	.word	4$		; 00 01
	.word	5$		; 00 02
	.word	6$		; 00 02
	.word	7$		; 00 03
	.word	8$		; 00 03
	.word	9$		; 00 04
Bndry_1:


	.page
	.area	Bndry_2	(ABS,OVR)

	.org	0
1$:			; Address == 0
	.even
2$:			; Address == 0	
	.bndry	2
3$:			; Address == 0
	.bndry	4
4$:			; Address == 0
	.bndry	8
5$:			; Address == 0
	.bndry	16
6$:			; Address == 0
	.bndry	32
7$:			; Address == 0
	.bndry	64
8$:			; Address == 0
	.bndry	128
9$:			; Address == 0
	.bndry	256
10$:			; Address == 0
	.bndry	512
11$:			; Address == 0
	.bndry	1024
12$:			; Address == 0

	.word	1$		; 00 00
	.word	2$		; 00 00
	.word	3$		; 00 00
	.word	4$		; 00 00
	.word	5$		; 00 00
	.word	6$		; 00 00
	.word	7$		; 00 00
	.word	8$		; 00 00
	.word	9$		; 00 00
	.word	10$		; 00 00
	.word	11$		; 00 00
	.word	12$		; 00 00
Bndry_2:


	.page
	.area	Bndry_3	(ABS,OVR)

	; The area start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.

	.org	1
1$:
	.even
2$:			; Address == 2
	.bndry	2
3$:			; Address == 2
	.bndry	4
4$:			; Address == 4
	.bndry	8
5$:			; Address == 8
	.bndry	16
6$:			; Address == 16:
	.bndry	32
7$:			; Address == 32
	.bndry	64
8$:			; Address == 64
	.bndry	128
9$:			; Address == 128
	.bndry	256
10$:			; Address == 256
	.bndry	512
11$:			; Address == 512
	.bndry	1024
12$:			; Address == 1024

	.word	1$		; 00 01
	.word	2$		; 00 02
	.word	3$		; 00 02
	.word	4$		; 00 04
	.word	5$		; 00 08
	.word	6$		; 00 10
	.word	7$		; 00 20
	.word	8$		; 00 40
	.word	9$		; 00 80
	.word	10$		; 01 00
	.word	11$		; 02 00
	.word	12$		; 04 00
Bndry_3:


	.page
	.area	Bndry_4	(ABS,OVR)

	.org	0
1$:			; Address == 0
	.bndry	3
2$:			; Address == 0
	.bndry	6
3$:			; Address == 0
	.bndry	12
4$:			; Address == 0
	.bndry	24
5$:			; Address == 0
	.bndry	48
6$:			; Address == 0
	.bndry	96
7$:			; Address == 0
	.bndry	192
8$:			; Address == 0
	.bndry	384
9$:			; Address == 0
	.bndry	768
10$:			; Address == 0
	.bndry	1536
11$:			; Address == 0

	.word	1$		; 00 00
	.word	2$		; 00 00
	.word	3$		; 00 00
	.word	4$		; 00 00
	.word	5$		; 00 00
	.word	6$		; 00 00
	.word	7$		; 00 00
	.word	8$		; 00 00
	.word	9$		; 00 00
	.word	10$		; 00 00
	.word	11$		; 00 00
Bndry_4:


	.page
	.sbttl	Mixed Boundaries

	.area	Bndry_5	(ABS,OVR)

	.org	0
1$:			; Address == 0
	.odd
2$:			; Address == 1
	.even
3$:			; Address == 2
	.odd
4$:			; Address == 3
	.bndry	2
5$:			; Address == 4
	.bndry	3
6$:			; Address == 6
	.bndry	4
7$:			; Address == 8
	.bndry	6
8$:			; Address == 12
	.bndry	8
9$:			; Address == 16
	.bndry	9
10$:			; Address == 18

	.word	1$		; 00 00
	.word	2$		; 00 01
	.word	3$		; 00 02
	.word	4$		; 00 03
	.word	5$		; 00 04
	.word	6$		; 00 06
	.word	7$		; 00 08
	.word	8$		; 00 0C
	.word	9$		; 00 10
	.word	10$		; 00 12
Bndry_5:


	.page
	.area	Bndry_6	(ABS,OVR)

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
Bndry_6:


	.page
	.area	Bndry_11	(REL,CON)

	.sbttl	Power of 2 Boundary Modes

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 2 (0x0002)

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

	.word	a_Bndry_11
	.word	m_Bndry_11_1	; 00 02
	.word	s_Bndry_11_1
	.word	l_Bndry_11
Bndry_11:


	.page
	.area	Bndry_12	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 1024 (0x0400)

0$:
	. = . + 0
1$:			; Address == 0
	.even
2$:			; Address == 0	
	.bndry	2
3$:			; Address == 0
	.bndry	4
4$:			; Address == 0
	.bndry	8
5$:			; Address == 0
	.bndry	16
6$:			; Address == 0
	.bndry	32
7$:			; Address == 0
	.bndry	64
8$:			; Address == 0
	.bndry	128
9$:			; Address == 0
	.bndry	256
10$:			; Address == 0
	.bndry	512
11$:			; Address == 0
	.bndry	1024
12$:			; Address == 0

	.word	0$
	.word	1$ - 0$		; 00 00
	.word	2$ - 0$		; 00 00
	.word	3$ - 0$		; 00 00
	.word	4$ - 0$		; 00 00
	.word	5$ - 0$		; 00 00
	.word	6$ - 0$		; 00 00
	.word	7$ - 0$		; 00 00
	.word	8$ - 0$		; 00 00
	.word	9$ - 0$		; 00 00
	.word	10$ - 0$	; 00 00
	.word	11$ - 0$	; 00 00
	.word	12$ - 0$	; 00 00

	.word	a_Bndry_12
	.word	m_Bndry_12_1	; 04 00
	.word	s_Bndry_12_1
	.word	l_Bndry_12
Bndry_12:


	.page
	.area	Bndry_13	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 1024 (0x0400)

0$:
	. = . + 1
1$:
	.even
2$:			; Address == 2
	.bndry	2
3$:			; Address == 2
	.bndry	4
4$:			; Address == 4
	.bndry	8
5$:			; Address == 8
	.bndry	16
6$:			; Address == 16:
	.bndry	32
7$:			; Address == 32
	.bndry	64
8$:			; Address == 64
	.bndry	128
9$:			; Address == 128
	.bndry	256
10$:			; Address == 256
	.bndry	512
11$:			; Address == 512
	.bndry	1024
12$:			; Address == 1024

	.word	0$
	.word	1$ - 0$		; 00 01
	.word	2$ - 0$		; 00 02
	.word	3$ - 0$		; 00 02
	.word	4$ - 0$		; 00 04
	.word	5$ - 0$		; 00 08
	.word	6$ - 0$		; 00 10
	.word	7$ - 0$		; 00 20
	.word	8$ - 0$		; 00 40
	.word	9$ - 0$		; 00 80
	.word	10$ - 0$	; 01 00
	.word	11$ - 0$	; 02 00
	.word	12$ - 0$	; 04 00

	.word	a_Bndry_13
	.word	m_Bndry_13_1	; 04 00
	.word	s_Bndry_13_1
	.word	l_Bndry_13
Bndry_13:


	.page
	.area	Bndry_14	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 1536 (0x0600)

0$:
	. = . + 0
1$:			; Address == 0
	.bndry	3
2$:			; Address == 0
	.bndry	6
3$:			; Address == 0
	.bndry	12
4$:			; Address == 0
	.bndry	24
5$:			; Address == 0
	.bndry	48
6$:			; Address == 0
	.bndry	96
7$:			; Address == 0
	.bndry	192
8$:			; Address == 0
	.bndry	384
9$:			; Address == 0
	.bndry	768
10$:			; Address == 0
	.bndry	1536
11$:			; Address == 0

	.word	0$
	.word	1$ - 0$		; 00 00
	.word	2$ - 0$		; 00 00
	.word	3$ - 0$		; 00 00
	.word	4$ - 0$		; 00 00
	.word	5$ - 0$		; 00 00
	.word	6$ - 0$		; 00 00
	.word	7$ - 0$		; 00 00
	.word	8$ - 0$		; 00 00
	.word	9$ - 0$		; 00 00
	.word	10$ - 0$	; 00 00
	.word	11$ - 0$	; 00 00

	.word	a_Bndry_14
	.word	m_Bndry_14_1	; 06 00
	.word	s_Bndry_14_1
	.word	l_Bndry_14
Bndry_14:


	.page
	.sbttl	Mixed Boundaries

	.area	Bndry_15	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 72 (0x0048)

0$:
	. = . + 0
1$:			; Address == 0
	.odd
2$:			; Address == 1
	.even
3$:			; Address == 2
	.odd
4$:			; Address == 3
	.bndry	2
5$:			; Address == 4
	.bndry	3
6$:			; Address == 6
	.bndry	4
7$:			; Address == 8
	.bndry	6
8$:			; Address == 12
	.bndry	8
9$:			; Address == 16
	.bndry	9
10$:			; Address == 18

	.word	0$
	.word	1$ - 0$		; 00 00
	.word	2$ - 0$		; 00 01
	.word	3$ - 0$		; 00 02
	.word	4$ - 0$		; 00 03
	.word	5$ - 0$		; 00 04
	.word	6$ - 0$		; 00 06
	.word	7$ - 0$		; 00 08
	.word	8$ - 0$		; 00 0C
	.word	9$ - 0$		; 00 10
	.word	10$ - 0$	; 00 12

	.word	a_Bndry_15
	.word	m_Bndry_15_1	; 00 48
	.word	s_Bndry_15_1
	.word	l_Bndry_15
Bndry_15:


	.page
	.area	Bndry_16	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 72 (0x0048)

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

	.word	a_Bndry_16
	.word	m_Bndry_16_1	; 00 48
	.word	s_Bndry_16_1
	.word	l_Bndry_16
Bndry_16:


	.page
	.area	Bndry_21	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 18 (0x0012)

0$:
	. = . + 1
1$:			; Address == 1
	.bndry	6
2$:			; Address == 6
	.bndry	9
3$:			; Address == 9

	.word	0$
	.word	1$ - 0$		; 00 01
	.word	2$ - 0$		; 00 06
	.word	3$ - 0$		; 00 09

	.word	a_Bndry_21
 	.word	m_Bndry_21_1	; 00 12
	.word	s_Bndry_21_1
	.word	l_Bndry_21
Bndry_21:


	.page
	.area	Bndry_22	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 10 (0x000A)

0$:
	. = . + 1
1$:			; Address == 1
	.bndry	5
2$:			; Address == 5
	.bndry	10
3$:			; Address == 10

	.word	0$
	.word	1$ - 0$		; 00 01
	.word	2$ - 0$		; 00 05
	.word	3$ - 0$		; 00 0A

	.word	a_Bndry_22
 	.word	m_Bndry_22_1	; 00 0A
	.word	s_Bndry_22_1
	.word	l_Bndry_22
Bndry_22:


	.page
	.area	Bndry_23	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 30 (0x001E)

0$:
	. = . + 1
1$:			; Address == 1
	.bndry	10
2$:			; Address == 10
	.bndry	15
3$:			; Address == 15

	.word	0$
	.word	1$ - 0$		; 00 01
	.word	2$ - 0$		; 00 0A
	.word	3$ - 0$		; 00 0F

	.word	a_Bndry_23
 	.word	m_Bndry_23_1	; 00 1E
	.word	s_Bndry_23_1
	.word	l_Bndry_23
Bndry_23:


	.page
	.area	Bndry_24	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 2520 (0x09D8)

0$:
	. = . + 1
1$:			; Address == 1
	.bndry	1
2$:			; Address == 1
	.bndry	2
3$:			; Address == 2
	.bndry	3
4$:			; Address == 3
	.bndry	4
5$:			; Address == 4
	.bndry	5
6$:			; Address == 5
	.bndry	6
7$:			; Address == 6
	.bndry	7
8$:			; Address == 7
	.bndry	8
9$:			; Address == 8
	.bndry	9
10$:			; Address == 9
	.bndry	10
11$:			; Address == 10

	.word	0$
	.word	1$ - 0$		; 00 01
	.word	2$ - 0$		; 00 01
	.word	3$ - 0$		; 00 02
	.word	4$ - 0$		; 00 03
	.word	5$ - 0$		; 00 04
	.word	6$ - 0$		; 00 05
	.word	7$ - 0$		; 00 06
	.word	8$ - 0$		; 00 07
	.word	9$ - 0$		; 00 08
	.word	10$ - 0$	; 00 09
	.word	11$ - 0$	; 00 0A

	.word	a_Bndry_24
 	.word	m_Bndry_24_1	; 09 D8
	.word	s_Bndry_24_1
	.word	l_Bndry_24
Bndry_24:


	.page
	.area	Bndry_25	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Boundary Modulus = 12 (0x000C)

0$:
	. = . + 1
1$:	.word	1$ - 0$		; 00 01
	.word	. - 0$		; 00 03
	.bndry	3
2$:	.word	2$ - 0$		; 00 06
	.word	. - 0$		; 00 08
	.bndry	4
3$:	.word	3$ - 0$		; 00 0C
	.word	. - 0$		; 00 0E

	.word	a_Bndry_25
 	.word	m_Bndry_25_1	; 00 0C
	.word	s_Bndry_25_1
	.word	l_Bndry_25
Bndry_25:

	.page
	.area	Bndry_99	(REL,CON)

	; The linked start address will be changed
	; so that all .bndry entries will be correct
	; within this area segment.
	;
	; Verify Symbols Relocated Correctly

	; (ABS,OVR) Sections
        .word   a_Bndry_1, l_Bndry_1, Bndry_1           ; 00 00 00 16 00 16
        .word   a_Bndry_2, l_Bndry_2, Bndry_2           ; 00 00 00 18 00 18
        .word   a_Bndry_3, l_Bndry_3, Bndry_3           ; 00 00 04 18 04 18
        .word   a_Bndry_4, l_Bndry_4, Bndry_4           ; 00 00 00 16 00 16
        .word   a_Bndry_5, l_Bndry_5, Bndry_5           ; 00 00 00 26 00 26
        .word   a_Bndry_6, l_Bndry_6, Bndry_6           ; 00 00 00 2A 00 2A

	; (REL,CON) Sections
        .word   a_Bndry_11, l_Bndry_11, Bndry_11        ; 00 00 00 20 00 20
        .word   a_Bndry_12, l_Bndry_12, Bndry_12        ; 00 20 04 02 04 22
        .word   a_Bndry_13, l_Bndry_13, Bndry_13        ; 04 22 08 00 0C 22
        .word   a_Bndry_14, l_Bndry_14, Bndry_14        ; 0C 22 05 FE 12 20
        .word   a_Bndry_15, l_Bndry_15, Bndry_15        ; 12 20 00 58 12 78
        .word   a_Bndry_16, l_Bndry_16, Bndry_16        ; 12 78 00 4C 12 C4
        .word   a_Bndry_21, l_Bndry_21, Bndry_21        ; 12 C4 00 1B 12 DF
        .word   a_Bndry_22, l_Bndry_22, Bndry_22        ; 12 DF 00 23 13 02
        .word   a_Bndry_23, l_Bndry_23, Bndry_23        ; 13 02 00 37 13 39
        .word   a_Bndry_24, l_Bndry_24, Bndry_24        ; 13 39 00 A1 13 DA
        .word   a_Bndry_25, l_Bndry_25, Bndry_25        ; 13 DA 00 1E 13 F8
        .word   a_Bndry_99, l_Bndry_99, Bndry_99        ; 13 F8 00 74 14 6C

	.word	a_Bndry_99
 	.word	m_Bndry_99_1	; 00 00
	.word	s_Bndry_99_1
	.word	l_Bndry_99
Bndry_99:


	.end


