	.title	AS6100 Error Tests
	.sbttl	IM6100/HM6100 Instruction Tests

	.area	page0	(abs,ovr)
	.setpg	0

	.sbttl	Group 1 Instruction Errors

	; Group 1 instructions will have an error code of '1'
	; Any combination of cla, cll, cma, cml, or iac with
	; the following combinations which generate an error
	; will also generate an error code of '1'

	; All combinations of rar, ral, rtl, rtr, and bsw

	bsw			;

	ral			;
	ral bsw			;1

	rar			;
	rar bsw			;1
	rar ral			;
	rar ral bsw		;1

	rtl			;
	rtl bsw			;1
	rtl ral			;1
	rtl ral bsw		;1
	rtl rar			;1
	rtl rar bsw		;1
	rtl rar ral		;1
	rtl rar ral bsw		;1

	rtr			;
	rtr bsw			;1
	rtr ral			;1
	rtr ral bsw		;1
	rtr rar			;1
	rtr rar bsw		;1
	rtr rar ral		;1
	rtr rar ral bsw		;1
	rtr rtl			;
	rtr rtl bsw		;1
	rtr rtl ral		;1
	rtr rtl ral bsw		;1
	rtr rtl rar		;1
	rtr rtl rar bsw		;1
	rtr rtl rar ral		;1
	rtr rtl rar ral bsw	;1


	.page
	.sbttl	Group 2 Instruction Errors

	; Group 2 instructions will have an error code of '2'
	; Any combination of cla, osr, or hlt with
	; the following combinations which generate an error
	; will also generate an error code of '2'

	; All combinations of spa, sma, sna, sza, szl, and snl

	snl			;

	szl			;
	szl snl			;2

	sza			;
	sza snl			;
	sza szl			;2
	sza szl snl		;2

	sna			;
	sna snl			;2
	sna szl			;
	sna szl snl		;2
	sna sza			;2
	sna sza snl		;2
	sna sza szl		;2
	sna sza szl snl		;2

	sma			;
	sma snl			;
	sma szl			;2
	sma szl snl		;2
	sma sza			;
	sma sza snl		;
	sma sza szl		;2
	sma sza szl snl		;2
	sma sna			;2
	sma sna snl		;2
	sma sna szl 		;2
	sma sna szl snl		;2
	sma sna sza 		;2
	sma sna sza snl		;2
	sma sna sza szl		;2
	sma sna sza szl snl	;2

	.page

	spa			;
	spa snl			;2
	spa szl			;
	spa szl snl		;2
	spa sza			;2
	spa sza snl		;2
	spa sza szl		;2
	spa sza szl snl		;2
	spa sna			;
	spa sna snl		;2
	spa sna szl		;
	spa sna szl snl		;2
	spa sna sza		;2
	spa sna sza snl		;2
	spa sna sza szl		;2
	spa sna sza szl snl	;2
	spa sma			;2
	spa sma snl		;2
	spa sma szl		;2
	spa sma szl snl		;2
	spa sma sza		;2
	spa sma sza snl		;2
	spa sma sza szl		;2
	spa sma sza szl snl	;2
	spa sma sna		;2
	spa sma sna snl		;2
	spa sma sna szl		;2
	spa sma sna szl snl	;2
	spa sma sna sza 	;2
	spa sma sna sza snl	;2
	spa sma sna sza szl	;2
	spa sma sna sza szl snl	;2


	.page
	.sbttl	Group 1 with Group 2 & 3 Instruction Errors

	; Group 1 instructions will have an error code of '1'.
	; Any combination of cma, cml, ral, rtl, rar, rtr, or
	; iac in place of cll (or in addition to cll)
	; will also generate an error code of '1'.

	cll hlt			;1
	cll osr			;1
	cll snl			;1
	cll szl			;1
	cll sza			;1
	cll sna			;1
	cll sma			;1
	cll spa			;1

	cll mqa			;1
	cll mql			;1


	.page
	.sbttl	Group 2 with Group 1 & 3 Instruction Errors

	; Group 2 instructions will have an error code of '2'.
	; Any combination of sma, spa, sza, sna, snl, szl,
	; or hlt in place of osr (or in addition to osr)
	; will also generate an error code of '2'.

	osr iac			;2
	osr ral			;2
	osr rtl			;2
	osr rar			;2
	osr rtr			;2
	osr cml			;2
	osr cma			;2
	osr cll			;2

	osr mqa			;2
	osr mql			;2


	.page
	.sbttl	Group 3 with Group 1 & 2 Instruction Errors

	; Group 3 instructions will have an error code of '3'.
	; mql in place of mqa (or in addition to mqa)
	; will also generate an error code of '3'.

	mqa iac			;3
	mqa ral			;3
	mqa rtl			;3
	mqa rar			;3
	mqa rtr			;3
	mqa cml			;3
	mqa cma			;3
	mqa cll			;3

	mqa hlt			;3
	mqa osr			;3
	mqa snl			;3
	mqa szl			;3
	mqa sza			;3
	mqa sna			;3
	mqa sma			;3
	mqa spa			;3


	.page
	.sbttl	Memory Reference Instructions

	.setpg 0

1$:	and	0
	and	*0
	and i	0
	and	[0]
	and i	*0
	and	*[0]
	and	[*0]

	.sbttl	Memory Reference Instruction Errors

	and i	[0]		;a
	and i	*[0]		;a
	and i	[*0]		;a
	and	*[*0]		;a
	and i	*[*0]		;a


	.page
	.sbttl	Link Time PageN Relocation Errors

	.macro	pgblk	...a,?...b,?...c
	  .iif eq,...a % 5  .page
...b:	  .word	1,2,3,4,5,.	; 00 01 00 02 00 03
	  jmp	. - 6		;n0A*80
	  jmp	...c		;n0A*80
				; PageN Relocation Errors for 'nnnn$'
	  jmp	...b - 1	;n0A*FF
	  .setpg	...a % 0d32
...c:	
	.endm

	.macro	test_setpg
	  .setpg 0
	  ...a = 1
	  .rept	0d32
	    pgblk ...a
	    ...a = ...a +1
	  .endm
	.endm


	.page
	.list	(me,meb)

	test_setpg


	.page
	.sbttl	.mempn and .mempa Page Boundary Errors

	.mempn  2
	.mempn -1		;b
	.mempn 32		;b

	.mempa 0x0100
	.mempa 0xFFFF		;b
	.mempa 0x1000		;b

	.mempa 0x0101		;b
	.mempa 0x017F		;b
	.mempa 0xFF01		;b
	.mempa 0xFF7F		;b
	.mempa 0x1001		;b
	.mempa 0x107F		;b


	.page
	.sbttl	Illegal 6-Bit ASCII Characters

	; Notes:
	;   Lower case letters are converted to
	;   upper case in 6-Bit ASCII.
	;
	;   Illegal characters are mapped as ' ',
	;   a SPACE, and generate a 'c' error code.

	.text	"@"		;c
	.text	"~"		;c
	.text	"{"		;c
	.text	"|"		;c
	.text	"}"		;c
	.text	"`"		;c

	.end
