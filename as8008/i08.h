/* io8.h */

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
	$(PROGRAM) =	AS8008
	$(INCLUDE) = {
		ASXXXX.H
		I08.H
	}
	$(FILES) = {
		I08MCH.C
		I08PST.C
		I08ADR.C
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
 * Symbol types.
 */
#define	S_INH	40		/* Single Byte */
#define	S_INR	41		/* INC/DEC Register */
#define	S_ADI	42		/* One Byte Immediate */
#define	S_RST	43		/* Restart */
#define	S_MVI	44		/* MOV # */
#define	S_JMP	45		/* Jump/Call */
#define	S_IN	46		/* Input Byte */
#define	S_OUT	47		/* Output Byte */
#define	S_ADD	48		/* Register Operation */
#define	S_MOV	49		/* MOV All Modes */

/*
 * Addressing Modes
 */
#define	S_IMMED	30
#define	S_REG	31
#define	S_EXT	32

/*
 * Registers.
 */
#define	A	0
#define	B	1
#define	C	2
#define	D	3
#define	E	4
#define	H	5
#define	L	6
#define	M	7

/*
 * Extended Addressing Modes
 */
#define	R_IN	0x0100		/* ----xxx- */
#define	R_OUT	0x0200		/* --xxxxx- */
#define	R_RST	0x0300		/* --xxx--- */


struct adsym
{
	char	a_str[6];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

	/* machine dependent functions */

#ifdef	OTHERSYSTEM
	
	/* i08adr.c */
extern	struct adsym	reg[];
extern	int		addr(struct expr *esp);
extern	int		admode(struct adsym *sp);
extern	int		srch(char *str);
extern	int		any(int c, char *str);

	/* i08mch.c */
extern	VOID		machine(struct mne *mp);
extern	VOID		minit(void);

#else

	/* i08adr.c */
extern	struct adsym	reg[];
extern	int		addr();
extern	int		admode();
extern	int		srch();
extern	int		any();

	/* i08mch.c */
extern	VOID		machine();
extern	VOID		minit();

#endif

