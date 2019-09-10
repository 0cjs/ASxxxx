/* i6100.h */

/*
 *  Copyright (C) 2013-2014  Alan R. Baldwin
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
	$(PROGRAM) = AS6100
	$(INCLUDE) = {
		ASXXXX.H
		I6100.H
	}
	$(FILES) = {
		I61MCH.C
		I61ADR.C
		I61PST.C
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

struct adsym
{
	char	a_str[2];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

/*
 * Addressing types
 */
#define S_ADDR		0x00		/* normal addressing */
#define	S_ZP		0x01		/* zero page */
#define	S_IND		0x02		/* indirect */
#define	S_ZPIND		0x03		/* zero page indirect */

/*
 * Machine Specific Directives
 */
#define	S_MPN		50
#define	S_MPA		51
#define	S_SPG		52
#define	S_TXT		53

#define	S_VAL		54
#define	S_WRD		55
#define	S_STR		56

/*
 * 6100 Instructions
 */
#define	S_MRI		60
#define	S_IOT		61
#define	S_GOP		62
#define	S_INH		63

/*
 * Extended Addressing Modes
 */
#define	R_6BIT	0x0100		/* 6-Bit Addressing Mode */
#define	R_7BIT	0x0200		/* 7-Bit Addressing Mode */
#define	R_8BIT	0x0300		/* 8-Bit Addressing Mode */
#define	R_9BIT	0x0400		/* 8-Bit Addressing Mode */
#define	R_LOWRD	0x0500		/* Lower 12-Bits Addressing Mode */
#define	R_HIWRD	0x0600		/* Upper 12-Bits Addressing Mode */

/*
 * machine dependent functions
 */

#ifdef	OTHERSYSTEM

	/* i61adr.c */
extern	struct	adsym	ind[];
extern	int		addr(struct expr *esp);
extern	int		admode(struct adsym *sp);
extern	int		any(int c, char *str);
extern	int		srch(char *str);
extern	int		zpage(struct expr *esp);

	/* i61mch.c */
extern	VOID		machine(struct mne *mp);
extern	int		mapchr(int c);
extern	VOID		minit(void);

#else

	/* i61adr.c */
extern	struct	adsym	ind[];
extern	int		addr();
extern	int		admode();
extern	int		any();
extern	int		srch();
extern	int		zpage();

	/* i61mch.c */
extern	VOID		machine();
extern	int		mapchr();
extern	VOID		minit();

#endif

