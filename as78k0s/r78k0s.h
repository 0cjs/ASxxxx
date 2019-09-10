/* r78k.h */

/*
 *  Copyright (C) 2014  Alan R. Baldwin
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
	$(PROGRAM) =	AS78K0S
	$(INCLUDE) = {
		ASXXXX.H
		R78K0S.H
	}
	$(FILES) = {
		R78KMCH.C
		R78KADR.C
		R78KPST.C
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
#define	RK0SPG1	0x0A	

/*
 * Addressing types
 */
#define	S_REG8	30
#define	S_REG16	31
#define	S_SPCL	32
#define	S_IDX	33
#define	S_IDXB	34
#define	S_IMM	35
#define	S_SADDR	36
#define	S_SFR	37
#define	S_AEXT	38
#define	S_EXT	39

/*
 * 78KOS Instruction types
 */
#define	S_ACC	50
#define	S_ACCW	51
#define	S_ROT	52
#define	S_DEC	53
#define	S_DECW	54
#define	S_INC	55
#define	S_INCW	56
#define	S_XCH	57
#define	S_XCHW	58
#define	S_MOV	59
#define	S_MOVW	60
#define	S_CLR	61
#define	S_SET	62
#define	S_NOT	63
#define	S_BIT	64
#define	S_BTF	65
#define	S_BR	66
#define	S_BRCZ	67
#define	S_DBNZ	68
#define	S_CALL	69
#define	S_CALLT	70
#define	S_POP	71
#define	S_INH	72
#define	S_INHP	73

/*
 * Set Direct Pointer
 */
#define	S_SDP	80

/*
 * Register Definitions
 */
#define	REG8_X		0
#define	REG8_A		1
#define	REG8_C		2
#define	REG8_B		3
#define	REG8_E		4
#define	REG8_D		5
#define	REG8_H		6
#define	REG8_L		7

#define	REG16_AX	0
#define	REG16_BC	1
#define	REG16_DE	2
#define	REG16_HL	3

#define	SPCL_CY		0
#define	SPCL_SP		1
#define	SPCL_PSW	2

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

/*
 * Extended Addressing Modes
 */
#define	R_5BIT	0x0100		/* 5-Bit Addressing Mode */
#define	R_3BITL	0x0200		/* 3-Bit Addressing Mode */
#define	R_3BITU	0x0300		/* 3-Bit Addressing Mode */

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
extern	int		setbit();
extern	int		getbit();
extern	struct	sdp	sdp;

#endif

