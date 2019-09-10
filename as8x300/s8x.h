/* s8x.h */

/*
 *  Copyright (C) 2018-2019  Alan R. Baldwin
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
	$(PROGRAM) =	AS8X300
	$(INCLUDE) = {
		ASXXXX.H
		S8X.H
	}
	$(FILES) = {
		S8XMCH.C
		S8XPST.C
		S8XADR.C
		ASMAIN.C
		ASDBG.C
		ASLEX.C
		ASSYM.C
		ASSUBR.C
		ASEXPR.C
		ASMCRO.C
		ASDATA.C
		ASLIST.C
		ASOUT.C
	}
	$(STACK) = 3000
*/

/*
 * CPU type
 */
#define	X_300	0		/* 8x300 */
#define	X_305	1		/* 8x305 */

/*
 * Symbol types.
 */
#define	S_MOV	40		/* Move */
#define	S_ADD	41		/* ADD */
#define	S_AND	42		/* AND */
#define	S_XOR	43		/* XOR */
#define	S_XEC	44		/* Execute # */
#define	S_NZT	45		/* Conditional Jump */
#define	S_XMT	46		/* Output Byte */
#define	S_JMP	47		/* Jump */

#define	S_XML	50		/* XMIT to Left  Bank */
#define	S_XMR	51		/* XMIT to Right Bank */

#define	S_SEL	52		/* Load I/O Address */
#define	S_CAL	53		/* Call */
#define	S_RTN	54		/* Return */
#define	S_NOP	55		/* No Operation */
#define	S_HLT	56		/* Halt */

#define	S_CPU	60		/* CPU Type */
#define	S_XTND	61		/* Set Extended Area */

#define	S_LIV	62		/* LIV Definition */
#define	S_RIV	63		/* RIV Definition */
#define	S_DEF	64		/* Define a LIV or RIV Constant */

#define	M_DATA	70		/* Replaced Data  Assembler Mnemonics */
#define	M_ASCIX	71		/* Replaced ASCII Assembler Mnemonics */
#define	S_XERR	72		/* Expanded Error Reporting */

/*
 * Special Symbol Flags
 */
#define	F_LIV	0x40		/* Left  Bank Data Field Variable */
#define	F_RIV	0x80		/* Right Bank Data Field Variable */

#define	F_BYT	0x0100		/* An Address: < 256 */
#define	F_LEN	0x0200		/* Number Of Bits In Variable <= 8 */ 
#define	F_BIT	0x0400		/* Least Significant Bit of the Variable: < 8 and <= BIT+1 */

/*
 * Addressing Modes
 */
#define	A_REG	0x01		/* Registers r0 - r17 */
#define	A_EXT	0x02		/* Regular Variable/Address */
#define	A_LIV	0x04		/* Left  Bank Data Field Variable */
#define	A_RIV	0x08		/* Right Bank Data Field Variable */

#define	A_XTND	0x10		/* [---] */

/*
 * Extended Addressing Modes
 */
#define	R_JMP	0x0100		/* ---XXXXXXXXXXXXX */
#define	R_LO8	0x0200		/* --------XXXXXXXX */
#define	R_VO8	0x0300		/* --XXXXXXXX------ */
#define	R_LO5	0x0400		/* -----------XXXXX */
#define	R_VO5	0x0500		/* -----XXXXX------ */
#define	R_LEN	0x0600		/* --------XXX----- */


extern	a_uint xerr;

struct adsym
{
	char	a_str[6];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

extern	int	aindx;


struct xdef
{
	int	d_bits;		/* Number of Bits in Field */
	int	d_dval;		/* Default Value */
	int	d_skip;		/* Skip Value Fits in Field Test */
};

extern	struct	xdef	xfield[16];
extern	int	d_xtnd;
extern	int	d_xdef;


	/* machine dependent functions */

#ifdef	OTHERSYSTEM
	
	/* s8xadr.c */
extern	struct adsym	reg[];
extern	int		addr(struct expr *esp,struct expr *nsp,struct expr *xsp);
extern	VOID		eaddr(struct expr *esp);
extern	VOID		naddr(struct expr *esp);
extern	VOID		xaddr(struct expr *esp);
extern	int		admode(struct adsym *sp);
extern	int		srch(char *str);
extern	int		any(int c, char *str);

	/* sx8mch.c */
extern	struct adsym	regsym[];
extern	VOID		machine(struct mne *mp);
extern	int		regchk(int src, int dst);
extern	VOID		xtndout(struct expr *esp);
extern	VOID		mcherr(char *str);
extern	VOID		minit(void);

#else

	/* s8xadr.c */
extern	struct adsym	reg[];
extern	int		addr();
extern	VOID		eaddr();
extern	VOID		naddr();
extern	VOID		xaddr();
extern	int		admode();
extern	int		srch();
extern	int		any();

	/* s8xmch.c */
extern	struct adsym	regsym[];
extern	VOID		machine();
extern	int		regchk();
extern	VOID		xtndout();
extern	VOID		mcherr();
extern	VOID		minit();

#endif

