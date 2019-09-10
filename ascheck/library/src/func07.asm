	.module func07
	.area	func07

	.globl	lfnc07		; Make Internal Element Global
	.globl	lfnc04		; Define External Element As Global

	.list	(md,meb)

	.macro	call	arg	; dumby function call
	.byte	0xFF, >arg, <arg
	.endm

lfnc07:	.byte	0,7,0		; dumby function entry point

	call	lfnc04		; external function call

	.end