/* i08s.h */

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
	$(PROGRAM) =	AS8008S
	$(INCLUDE) = {
		ASXXXX.H
		I08S.H
	}
	$(FILES) = {
		I08SMCH.C
		I08SPST.C
		I08SADR.C
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
#define	S_ADI	41		/* One Byte Immediate */
#define	S_RST	42		/* Restart */
#define	S_MVI	43		/* LIx # */
#define	S_JMP	44		/* Jump/Call */
#define	S_INP	45		/* Input Byte */
#define	S_OUT	46		/* Output Byte */
#define	S_SHL	47		/* LHI and LLI combined */

/*
 * Addressing Modes
 */
#define	S_IMMED	30
#define	S_EXT	31

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
#define	R_INP	0x0100		/* ----xxx- */
#define	R_OUT	0x0200		/* --xxxxx- */
#define	R_RST	0x0300		/* --xxx--- */


	/* machine dependent functions */

#ifdef	OTHERSYSTEM
	
	/* i08adr.c */
extern	int		addr(struct expr *esp);

	/* i08mch.c */
extern	VOID		machine(struct mne *mp);
extern	VOID		minit(void);

#else

	/* i08adr.c */
extern	int		addr();

	/* i08mch.c */
extern	VOID		machine();
extern	VOID		minit();

#endif

