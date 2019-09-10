/* scmpmch.c */

/*
 *  Copyright (C) 2009-2014  Alan R. Baldwin
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

#include "asxxxx.h"
#include "scmp.h"

char	*cpu	= "National Semiconductor SC/MP";
char	*dsft	= "asm";

/*
 * Opcode Cycle Definitions
 */
#define	OPCY_SDP	((char) (0xFF))
#define	OPCY_ERR	((char) (0xFE))

/*	OPCY_NONE	((char) (0x80))	*/
/*	OPCY_MASK	((char) (0x7F))	*/

#define	UN	((char) (OPCY_NONE | 0x00))

/*
 * SC/MP Cycle Count
 * Source: National Semiconductor Publication 42000948
 *         SC/MP Programming and Assembly Manual
 *
 *	opcycles = scmpcyc[opcode]
 */
char scmpcyc[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/   8, 7, 5, 5, 6, 6, 5, 6, 5,UN,UN,UN,UN,UN,UN,UN,
/*10*/  UN,UN,UN,UN,UN,UN,UN,UN,UN, 5,UN,UN, 5, 5, 5, 5,
/*20*/  UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,
/*30*/   8, 8, 8, 8, 8, 8, 8, 8,UN,UN,UN,UN, 7, 7, 7, 7,
/*40*/   6,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,
/*50*/   6,UN,UN,UN,UN,UN,UN,UN, 6,UN,UN,UN,UN,UN,UN,UN,
/*60*/   6,UN,UN,UN,UN,UN,UN,UN,11,UN,UN,UN,UN,UN,UN,UN,
/*70*/   7,UN,UN,UN,UN,UN,UN,UN, 8,UN,UN,UN,UN,UN,UN,UN,
/*80*/  UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,UN,13,
/*90*/  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,
/*A0*/  UN,UN,UN,UN,UN,UN,UN,UN,22,22,22,22,UN,UN,UN,UN,
/*B0*/  UN,UN,UN,UN,UN,UN,UN,UN,22,22,22,22,UN,UN,UN,UN,
/*C0*/  18,18,18,18,10,10,10,10,18,18,18,18,18,18,18,18,
/*D0*/  18,18,18,18,10,10,10,10,18,18,18,18,10,10,10,10,
/*E0*/  18,18,18,18,10,10,10,10,23,23,23,23,23,23,23,23,
/*F0*/  19,19,19,19,10,10,10,10,20,20,20,20,12,12,12,12
};

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
{
	int op;
	struct expr e1;
	int t1, a1, v1;

	clrexpr(&e1);
	op = (int) mp->m_valu;
	switch (mp->m_type) {

	case S_MID:
		/*
		 * ild @DISP[ptr]
		 * dld @DISP[ptr]
		 */

	case S_MRI:
		/*
		 * ld  @DISP[ptr]
		 * st  @DISP[ptr]
		 * and @DISP[ptr]
		 * or  @DISP[ptr]
		 * xor @DISP[ptr]
		 * dad @DISP[ptr]
		 * add @DISP[ptr]
		 * cad @DISP[ptr]
		 */
		t1 = addr(&e1);
		a1 = aindx;
		/*
		 * PC Relative Addressing
		 */
		if (t1 == S_EXT) {
			outab(op);
			if (mchpcr(&e1)) {
				v1 = (int) (e1.e_addr - dot.s_addr);
				/* Valid Range is -128 >> 0 >> +127 */
				if ((v1 < -128) || (v1 > 127))
					aerr();
				outab(v1);
			} else {
				outrb(&e1, R_PCR0);
			}
			if (e1.e_mode != S_USER)
				rerr();
		} else
		/*
		 * Indexed Addressing - @DISP[ptr]
		 */
		if (t1 == S_IDX) {
			outab(op | (a1 & 0x07));
			/*
			 * PC Offset Addressing - @DISP[P0]
			 */
			if ((a1 & 0x03) == 0) {
				e1.e_addr -= 1;
			}
			outrb(&e1, 0);
			if (e1.e_mode != S_USER)
				rerr();
		} else
		/*
		 * Immediated Addressing
		 */
		if ((t1 == S_IMM) && (op != 0xC8)) {
			outab(op | 0x04);
			outrb(&e1, 0);
		} else
		/*
		 * Error Default
		 */
		{
			outab(op | (a1 & 0x07));
			outrb(&e1, 0);
			aerr();
		}
		break;

	case S_DLY:
		/*
		 * dly #DATA8
		 */

	case S_II:
		/*
		 * ldi #DATA8
		 * ani #DATA8
		 * ori #DATA8
		 * xri #DATA8
		 * dai #DATA8
		 * adi #DATA8
		 * cai #DATA8
		 */
		t1 = addr(&e1);
		a1 = aindx;
		outab(op);
		outrb(&e1, 0);
		if ((t1 != S_IMM) && (t1 != S_EXT)) {
			aerr();
		}
		break;
		 
	case S_JMP:
		/*
		 * jmp DISP[ptr]
		 * jp  DISP[ptr]
		 * jn  DISP[ptr]
		 * jnz DISP[ptr]
		 */
		t1 = addr(&e1);
		a1 = aindx;
		/*
		 * PC Relative Addressing
		 */
		if (t1 == S_EXT) {
			outab(op);
			if (mchpcr(&e1)) {
				v1 = (int) (e1.e_addr - dot.s_addr - 1);
				/* Valid Range is -128 >> 0 >> +127 */
				if ((v1 < -128) || (v1 > 127))
					aerr();
				outab(v1);
			} else {
				outrb(&e1, R_PCR1);
			}
			if (e1.e_mode != S_USER)
				rerr();
		} else
		/*
		 * Indexed Addressing - DISP[ptr]
		 */
		if (t1 == S_IDX) {
			outab(op | (a1 & 0x03));
			/*
			 * PC Offset Addressing - DISP[P0]
			 */
			if ((a1 & 0x03) == 0) {
				e1.e_addr -= 2;
			}
			outrb(&e1, 0);
			if (e1.e_mode != S_USER)
				rerr();
		} else
		/*
		 * Error Default
		 */
		{
			outab(op | (a1 & 0x03));
			outrb(&e1, 0);
			aerr();
		}
		if (a1 & 0x04) {		/* @ not allowed */
			aerr();
		}
		break;

	case S_XP:
		/*
		 * xpal	ptr
		 * xpah	ptr
		 * xppc	ptr
		 */
		t1 = addr(&e1);
		a1 = aindx;	
		if (a1 & 0x04) {
			aerr();
		}
		outab(op | (0x03 & a1));
		if (t1 != S_PTR) {
			aerr();
		}
		break;
			
	case S_INH:
		/*
		 * halt		lde		sio
		 * ccl		xae		sr
		 * scl		ane		srl
		 * dint		ore		rr
		 * ien		xre		rrl
		 * csa		dae
		 * cas		ade
		 * nop		cae
		 */
		outab(op);
		break;

	default:
		opcycles = OPCY_ERR;
		err('o');
		break;
	}

	if (opcycles == OPCY_NONE) {
		opcycles = scmpcyc[cb[0] & 0xFF];
	}
}

/*
 * Branch/Jump PCR Mode Check
 */
int
mchpcr(esp)
struct expr *esp;
{
	if (esp->e_base.e_ap == dot.s_area) {
		return(1);
	}
	if (esp->e_flag==0 && esp->e_base.e_ap==NULL) {
		/*
		 * Absolute Destination
		 *
		 * Use the global symbol '.__.ABS.'
		 * of value zero and force the assembler
		 * to use this absolute constant as the
		 * base value for the relocation.
		 */
		esp->e_flag = 1;
		esp->e_base.e_sp = &sym[1];
	}
	return(0);
}

/*
 * Machine dependent initialization
 */
VOID
minit()
{
	/*
	 * Byte Order
	 */
	hilo = 1;
}

