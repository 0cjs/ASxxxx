	.nlist	; Macro Definitions Listing Control
	; This File Contains Macros For Specific
	; 8x300 / 8x305 MCCAP Options Not Implemented
	; Directly in the AS8X300 Assembler
	;
	;	ORG	SPACE,PGSIZE ^/[...]/
	;
	;	PROG	USE	.TITLE
	;	PROC	SUB	.SBTTL	SUB
	;			SUB:
	;
	;	ENTRY	SUB	SAME AS	SUB:
	;
	;	CALL	SUB ^/[...]/
	;	RTN	^/[...]
	;
	;	CALL_TABLE	AREA_C,AREA_X ^/[...]/
	;
	.macro	org	space,pgsize code
	  .nlist
	  .ifb	pgsize
	    .nval	.org.	.
	    .org. = space - .org.
	    . = . + .org.
	  .else
	    .ifne	pgsize - 0x0020
	      .ifne	pgsize - 0x0100
	        .list	(!,me,err,loc,bin,cyc,src)
	  .error pgsize	; Not 32 or 256 Page Size
	        .nlist
	      .endif
	    .endif
	    .nval	.pc.	.
	    .ifeq	space - pgsize
	      .ifne	.pc. % pgsize
	        .list	(!,me,err,loc,bin,cyc,src)
	  jmp	. + (pgsize - .pc. % pgsize) code
	        .nlist
	      .endif
	      .list	(!,me,err,loc,bin,cyc,src)
	  .bndry	pgsize
	      .nlist
	    .else
	      .ifgt	space - (pgsize - .pc. % pgsize)
	        .list	(!,me,err,loc,bin,cyc,src)
	  jmp	. + (pgsize - .pc. % pgsize) code
	  .bndry	pgsize
	        .nlist
	      .endif
	    .endif
	  .endif
	.endm

	.macro	proc	sub
	  .nlist
	  .sbttl	sub
	  .list	(!,me,err,loc,bin,cyc,src)
sub:
	.endm

	.macro	entry	sub
	  .list	(!,me,err,loc,bin,cyc,src)
sub:
	.endm

	.macro	.rtn_sym.	n
	  .nlist
	  .rtn.'n = .
	.endm

	.macro	.xmt_cnt.	n code A
	  .list	(!,me,err,loc,bin,cyc,src)
	  xmit	'n,r11 code	A
	.endm

	.macro	call	sub  code  A  B
	  .nlist
	  .ifeq	.cnt.-.tcnt.
	    .cnt. = 0
	  .endif
	  .xmt_cnt.	\.cnt. ^/code/ ^/A/
	  .list	(!,me,err,loc,bin,cyc,src)
	  jmp	sub code	B
	  .nlist
	  .rtn_sym.	\.cnt.
	  .cnt. = .cnt. + 1
	.endm

	.macro	rtn	code	A
	  .list	(!,me,err,loc,bin,cyc,src)
	  jmp	.tbgn.	code	A
	.endm

	.macro	.table_entry.	n code
	  .list	(!,me,err,loc,bin,cyc,src)
	  jmp	.rtn.'n code
	  .nlist
	.endm

	.macro	Call_Table	area_c,area_x code
	  .nlist
	  .ifnb	area_c
	    .list	(!,me,err,loc,bin,cyc,src)
	    .area	area_c
	    .nlist
 	  .endif
	  .ifnb	area_x
	    .list	(!,me,err,loc,bin,cyc,src)
	    .xtnd	area_x
	    .nlist
	  .endif

	  .ifgt	.cnt.
	    .tbgn. = .
	    .list	(!,me,err,loc,bin,eqt,cyc,src)
	  xec	.+1(r11) code
	    .nlist
	    .tcnt. = 0
	    .rept	.cnt.
	      .table_entry.	\.tcnt. ^/code/
	      .tcnt. = .tcnt. + 1
	    .endm
	  .endif
	.endm
	.list	; Macro Definitions Listing Control
