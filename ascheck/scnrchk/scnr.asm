	.title	ASXSCN Scanner Testing

	.area	A	(rel,con)

	100$:
	101$:	.blkb	0x10
		.blkb	0x10
		.byte	0,1,2,3
		.blkb	0x20

	byte0:	.byte	#byte0
	byte1:	.byte	#byte1
	byte2:	.byte	#byte2
	byte3:	.byte	#byte3
	byte4:	.byte	#byte4
	byte5:	.byte	#byte5
	byte6:	.byte	#byte6
	byte7:	.byte	#byte7
	byte8:	.byte	#byte8
	byte9:	.byte	#byte9
	byteA:	.byte	#byteA
	byteB:	.byte	#byteB
	byteC:	.byte	#byteC
	byteD:	.byte	#byteD
	byteE:	.byte	#byteE
	byteF:	.byte	#byteF
		.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

	byte10:
	.list (!)
	byte11:

	.nlist (!)
;	.list (!,err,loc,bin,eqt,cyc,lin,src)
	.list (!,err,loc,bin,eqt,cyc,lin,src)
	0$:	.opcode	0
		code = #byte0

	.nlist (!)
;	.list (!,err,loc,bin,eqt,cyc,lin)
	.list (!,err,loc,bin,eqt,cyc,lin)
	1$:	.opcode	1
		code = #byte1

	.nlist (!)
;	.list (!,err,loc,bin,eqt,cyc)
	.list (!,err,loc,bin,eqt,cyc)
	2$:	.opcode	2
		code = #byte2

	.nlist (!)
;	.list (!,err,loc,bin,eqt)
	.list (!,err,loc,bin,eqt)
	3$:	.opcode	3
		code = #byte3

	.nlist (!)
;	.list (!,err,loc,bin)
	.list (!,err,loc,bin)
	4$:	.opcode	4
		code = #byte4

	.nlist (!)
;	.list (!,err,loc)
	.list (!,err,loc)
	5$:	.opcode	5
		code = #byte5

	.nlist (!)
;	.list (!,err)
	.list (!,err)
	6$:	.opcode	6
		code = #byte6

	.nlist (!)
	.area B

	byte20:	.byte	#byte20
	byte21:	.byte	#byte21
	byte22:	.byte	#byte22
	byte23:	.byte	#byte23
	byte24:	.byte	#byte24
	byte25:	.byte	#byte25
	byte26:	.byte	#byte26
	byte27:	.byte	#byte27
	byte28:	.byte	#byte28
	byte29:	.byte	#byte29
	byte2A:	.byte	#byte2A
	byte2B:	.byte	#byte2B
	byte2C:	.byte	#byte2C
	byte2D:	.byte	#byte2D
	byte2E:	.byte	#byte2E
	byte2F:	.byte	#byte2F
		.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

	byte30:
	.list (!)
	byte31:

	.nlist (!)
;	.list (!,loc,bin,eqt,cyc,lin,src)
	.list (!,loc,bin,eqt,cyc,lin,src)
	10$:	.opcode	0
		code = #byte0
		code = #byte20
	20$:

	.nlist (!)
;	.list (!,bin,eqt,cyc,lin,src)
	.list (!,bin,eqt,cyc,lin,src)
	11$:	.opcode	1
		code = #byte1
		code = #byte21
	21$:

	.nlist (!)
;	.list (!,loc,eqt,cyc,lin,src)
	.list (!,loc,eqt,cyc,lin,src)
	12$:	.opcode	2
		code = #byte2
		code = #byte22
	22$:

	.nlist (!)
;	.list (!,loc,bin,cyc,lin,src)
	.list (!,loc,bin,cyc,lin,src)
	13$:	.opcode	3
		code = #byte3
		code = #byte23
	23$:

	.nlist (!)
;	.list (!,loc,bin,eqt,lin,src)
	.list (!,loc,bin,eqt,lin,src)
	14$:	.opcode	4
		code = #byte4
		code = #byte24
	24$:

	.nlist (!)
;	.list (!,loc,bin,eqt,cyc,src)
	.list (!,loc,bin,eqt,cyc,src)
	15$:	.opcode	5
		code = #byte5
		code = #byte25
	25$:

	.nlist (!)
		.globl	byte40
		cddd = byte40
		cdde = byte41
		cddf = .
		cddj = . + 2
		cddj = . - 2
		.word	cddf
		cddg = 2

	.area	A

		.word	.
	a = 2
	b = .
	c = .+34
	d = c-32

	.area	B

	j = 2

	k = .
		;
	l = .+34

		;
		.list(!)
		;************
		.list
	m = l-32

	;as:

