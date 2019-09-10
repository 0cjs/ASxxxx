	.sbttl	Jump Range Tests

	; This code verifies the assembler and linker
	; code / error generation.
	;
	; To test the assembler code generation define 'tasm':
	;
	;	asscmp -gloxff tasm tscmpe
	;	asxscn tasm.lst
	;
	; To test the linker code generation define 'tlnk':
	;
	;	asscmp -gloxff tlnk tscmpe
	;	aslink -u tlnk
	;	asxscn -i tlnk
	;

	;a error:
	xpal	1		; 30
	;a error:
	xpah	2(p0)		; 34
	;a error
	xppc	@3(p0)		; 3C

	;a error:
	jmp	#3	        ; 90 03
	;a error:
	jmp	p1		; 91 00
	;a error:
	jmp	@(p2)		; 92 00
	;a error:
	jmp	@2(p3)		; 93 02

	;a error:
	jmp	.-128	        ; 90 7E
	;a error:
	jmp	.-127		; 90 7F

	jmp	.-126		; 90 80
	jmp	.-1		; 90 FD
	jmp	.		; 90 FE
	jmp	.+1		; 90 FF
	jmp	.+2		; 90 00
	jmp	.+3		; 90 01
	jmp	.+127		; 90 7D
	jmp	.+128		; 90 7E

	;a error:
	jmp	.+130		; 90 80

	.area	Code1	(rel,con)

jt:	jmp	.+5		; 90 03

	.ifdef	tasm
	; check assembler code generation
	jmp	1$		; 90p03
	.endif

	.ifdef	tlnk
	; check linker code generation
	jmp	1$		; 90 03
	.endif


	.area	Code2	(rel,con)

	.byte	0
	.byte	1
	.byte	2
1$:	.byte	3

	; *****-----*****-----*****-----*****

	.area	M127	(rel,con)

m127:	.blkb	0d127

	.area	CoM127	(rel,con)

	.ifdef	tasm
	; check assembler code generation
	jmp	m127		; 90p00
	.endif

	.ifdef	tlnk
	; check linker code generation - ASlink Error
	jmp	m127		; 90 7F
	.endif

	; *****-----*****-----*****-----*****

	.area	M126	(rel,con)

m126:	.blkb	0d126

	.area	CoM126	(rel,con)

	.ifdef	tasm
	; check assembler code generation
	jmp	m126		; 90p00
	.endif

	.ifdef	tlnk
	; check linker code generation
	; The Linker allows the special offset of -128 !!!
	; The instruction uses the extension register rather than the offset value !!!
	jmp	m126		; 90 80
	.endif

	; *****-----*****-----*****-----*****

	.area	CoP127	(rel,con)

	.ifdef	tasm
	; check assembler code generation
	jmp	p127		; 90p7F
	.endif

	.ifdef	tlnk
	; check linker code generation
	jmp	p127		; 90 7F
	.endif

	.area	P127	(rel,con)

	.blkb	0d127	
p127:

	; *****-----*****-----*****-----*****

	.area	CoP128	(rel,con)

	.ifdef	tasm
	; check assembler code generation
	jmp	p128		; 90p80
	.endif

	.ifdef	tlnk
	; check linker code generation - ASlink Error
	jmp	p128		; 90 80
	.endif

	.area	P128

	.blkb	0d128
p128:

	; *****-----*****-----*****-----*****


