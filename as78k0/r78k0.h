/* R78K0.H */

/*
 *  Copyright (C) 2019  Alan R. Baldwin
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*)BUILD
	$(PROGRAM) =	AS78K0
	$(INCLUDE) = {
		ASXXXX.H
		R78K0.H
	}
	$(FILES) = {
		R78K0MCH.C
		R78K0ADR.C
		R78K0PST.C
		ASMAIN.C
		ASMCRO.C
		ASDBG.C
		ASLEX.C
		ASSYM.C
		ASSUBR.C
		ASEXPR.C
		ASDATA.C
		ASLIST.C
		ASOUT.C
	}
	$(STACK) = 3000
*/

/*
 * Instruction Pages
 */
#define RK0PG31 0x31    
#define RK0PG61 0x61    
#define RK0PG71 0x71    

/*
 * Addressing types
 */
#define	S_REG8	30
#define	S_REG16	31
#define	S_SPCL	32
#define	S_IDX	33
#define	S_IDXB	34
#define	S_IHLR	35
#define	S_IMM	36
#define	S_SADDR	37
#define	S_SFR	38
#define	S_AEXT	39
#define	S_EXT	40

/*
 * 78KO Instruction types
 */
#define	S_MOV	50
#define	S_XCH	51
#define	S_MOVW	52
#define	S_XCHW	53
#define	S_ACC	54
#define	S_ACCW	55
#define	S_INC	56
#define	S_DEC	57
#define	S_INCW	58
#define	S_DECW	59
#define	S_ROT	60
#define	S_ROT4	61
#define	S_MOV1	62
#define	S_ACC1	63
#define	S_SET1	64
#define	S_CLR1	65
#define	S_NOT1	66
#define	S_CALL	67
#define	S_CALLF	68
#define	S_CALLT	69
#define	S_PSH	70
#define	S_POP	71
#define	S_BR	72
#define	S_BRCZ	73
#define	S_BT	74
#define	S_BF	75
#define	S_BTCLR	76
#define	S_DBNZ	77
#define	S_SEL	78
#define	S_INH	79
#define	S_INHW	80
#define	S_MUL	81
#define	S_DIV	82

#define	S_XERR	89

/*
 * Set Direct Pointer
 */
#define	S_SDP	90

/*
 * Register Definitions
 */
#define	REG8_X		0
#define	REG8_A		1
#define	REG8_C		2
#define	REG8_B		3
#define	REG8_E		4
#define	REG8_D		5
#define	REG8_L		6
#define	REG8_H		7

#define	REG16_AX	0
#define	REG16_BC	1
#define	REG16_DE	2
#define	REG16_HL	3

#define	SPCL_CY		0
#define	SPCL_SP		1
#define	SPCL_PSW	2

#define	RB0		0
#define	RB1		1
#define	RB2		2
#define	RB3		3


struct	sdp
{
	a_uint	s_addr;
	struct	area *	s_area;
};

struct adsym
{
	char	a_str[4];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

extern struct adsym reg8[];
extern struct adsym reg16[];
extern struct adsym spcl[];
extern struct adsym rb[];

/*
 * Extended Addressing Modes
 */
#define	R_3BIT	0x0100		/* 3-Bit Addressing Mode */
#define	R_5BIT	0x0200		/* 5-Bit Addressing Mode */
#define	R_11BIT	0x0300		/* 11-Bit Addressing Mode */

 	/* machine dependent functions */

#ifdef	OTHERSYSTEM
	
	/* r78kadr.c */
extern	int		addr(struct expr *esp, int *aindx);
extern	int		addrext(struct expr *esp, int *aindx, int *cidx, int *eidx);
extern	VOID		addrbit(struct expr *esp1, int *aindx1, int *amode1, struct expr *esp2, int *aindx2, int *amode2, int *eidx);
extern	int		argdot(struct expr *esp, int *aindx, int flag);
extern	int		dotarg(struct expr *esp, int *aindx, int flag);
extern	int		admode(struct adsym *sp, int *aindx);
extern	int		any(int c, char *str);
extern	int		srch(char *str);

	/* r78kmch.c */
extern	VOID		machine(struct mne *mp);
extern	int		mchpcr(struct expr *esp);
extern	VOID		minit(void);
extern	VOID		pcrbra(struct expr *esp);
extern	int		setbit(int b);
extern	int		getbit(void);
extern	VOID		mcherr(char *str);
extern	a_uint		xerr;
extern	struct	sdp	sdp;

#else

	/* r78kadr.c */
extern	int		addr();
extern	int		addrext();
extern	int		addrbit();
extern	int		argdot();
extern	int		dotarg();
extern	int		admode();
extern	int		any();
extern	int		srch();

	/* r78kmch.c */
extern	VOID		machine();
extern	int		mchpcr();
extern	VOID		minit();
extern	VOID		pcrbra();
extern	int		setbit();
extern	int		getbit();
extern	VOID		mcherr();
extern	a_uint		xerr;
extern	struct	sdp	sdp;

#endif

