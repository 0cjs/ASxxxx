	.page
	.sbttl	Multiple Banks

	; SIZE is in bytes, 4096 words => 8192 bytes
	.bank	BANK0	(SIZE = 8192, FSFX = 0)
	.bank	BANK1	(SIZE = 8192, FSFX = 1)

	.area	BANK0	(ABS, CON, BANK = BANK0)

	.setpg 0
	B0P0 = .

	pa0x00 = B0P0 + 0x0000
	pa0x7F = B0P0 + 0x007F

	.setpg 1
	B0P1 = .

	pa1x00 = B0P1 + 0x0000
	pa1x7F = B0P1 + 0x007F

	and	*pa0x00		; 00 00
	;...
	and	*pa0x7F		; 00 7F
	and	pa1x00		; 00 80
	;...
	and	pa1x7F		; 00 FF
	and	*[pa0x00]	; 01 00
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa1x00]	; 01 80
	;...
	and	[pa1x7F]	; 01 FF

	and	pa0x00

	.setpg 31
	B0P31 = .

	pa31x00 = B0P31 + 0x0000
	pa31x7F = B0P31 + 0x007F

	and	*pa0x00		; 00 00
	;...
	and	*pa0x7F		; 00 7F
	and	pa31x00		; 00 80
	;...
	and	pa31x7F		; 00 FF
	and	*[pa0x00]	; 01 00
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa31x00]	; 01 80
	;...
	and	[pa31x7F]	; 01 FF


	.area	BANK1	(ABS, CON, BANK = BANK1)

	.setpg 0
	B1P0 = .

	pa0x00 = B1P0 + 0x0000
	pa0x7F = B1P0 + 0x007F

	.setpg 1
	B1P1 = .

	pa1x00 = B1P1 + 0x0000
	pa1x7F = B1P1 + 0x007F

	and	*pa0x00		; 00 00
	;...
	and	*pa0x7F		; 00 7F
	and	pa1x00		; 00 80
	;...
	and	pa1x7F		; 00 FF
	and	*[pa0x00]	; 01 00
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa1x00]	; 01 80
	;...
	and	[pa1x7F]	; 01 FF

	.setpg 31
	B1P31 = .

	pa31x00 = B1P31 + 0x0000
	pa31x7F = B1P31 + 0x007F

	and	*pa0x00		; 00 00
	;...
	and	*pa0x7F		; 00 7F
	and	pa31x00		; 00 80
	;...
	and	pa31x7F		; 00 FF
	and	*[pa0x00]	; 01 00
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa31x00]	; 01 80
	;...
	and	[pa31x7F]	; 01 FF

	.end
