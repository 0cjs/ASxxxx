	.title	Paging Tests

	; The Relocatable SFR Area

	.area	SFR	(pag)
	.setdp	0x0000,SFR

sfrx00:	.blkb	1
	.blkb	254
sfrxFF:	.blkb	1
	.blkb	16
sfrxYY:	.blkb	1


	; The Code area

	.area	PROG	(rel,con)

	mov	*sfrx00,#0x12
	mov	*sfrxFF,#0x34
	mov	*sfrxYY,#0x56

	.xerr 3

	.error	1

	mov	*0x0010,#0x78

