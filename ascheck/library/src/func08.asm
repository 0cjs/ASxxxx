	.module func08
	.area	func08

	.globl	lfnc08		; Make Internal Element Global
	.globl	lfnc01		; Define External Element As Global

	.list	(md,meb)

	.macro	call	arg	; dumby function call
	.byte	0xFF, >arg, <arg
	.endm

lfnc08:	.byte	0,8,0		; dumby function entry point

	call	lfnc01		; external function call

	.end