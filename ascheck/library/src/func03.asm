	.module func03
	.area	func03

	.globl	lfnc03		; Make Internal Element Global
	.globl	lfnc02		; Define External Element As Global

	.list	(md,meb)

	.macro	call	arg	; dumby function call
	.byte	0xFF, >arg, <arg
	.endm

lfnc03:	.byte	0,3,0		; dumby function entry point

	call	lfnc02		; external function call

	.end