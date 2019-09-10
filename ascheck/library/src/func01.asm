	.module func01
	.area	func01

	.globl	lfnc01		; Make Internal Element Global
	.globl	lfnc07		; Define External Element As Global

	.list	(md,meb)

	.macro	call	arg	; dumby function call
	.byte	0xFF, >arg, <arg
	.endm

lfnc01:	.byte	0,1,0		; dumby function entry point

	call	lfnc07		; external function call

	.end