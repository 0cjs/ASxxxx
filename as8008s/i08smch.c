/* i08smch.c */

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

#include "asxxxx.h"
#include "i08s.h"

char	*cpu	= "Intel 8008 SIM8";
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
 * 8008 Cycle Count
 *
 *	opcycles = i08pg1[opcode]
 */
static char i08pg1[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/   1,UN, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 2, 1, 3, 1,
/*10*/   1, 1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 2, 1, 3, 1,
/*20*/   1, 1,UN, 1, 2, 1, 3,UN, 1, 1,UN, 1, 2, 1, 3,UN,
/*30*/   1, 1,UN, 1, 2, 1, 3, 1,UN,UN,UN, 1, 2, 1, 3, 1,
/*40*/   3, 2, 3, 2, 3, 2, 3, 2, 3, 2, 3, 2,UN, 2,UN, 2,
/*50*/   3, 2, 3, 2,UN, 2,UN, 2, 3, 2, 3, 2,UN, 2,UN, 2,
/*60*/   3, 2, 3, 2,UN, 2,UN, 2, 3, 2, 3, 2,UN, 2,UN, 2,
/*70*/   3, 2, 3, 2,UN, 2,UN, 2, 3, 2, 3, 2,UN, 2,UN, 2,
/*80*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2,
/*90*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2,
/*A0*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2,
/*B0*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2,
/*C0*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2,
/*D0*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2,
/*E0*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2,
/*F0*/   1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2
};

/*
 * Process machine ops.
 */
VOID
machine(mp)
struct mne *mp;
{
	unsigned int op;
	struct expr e1;
	a_uint v1;

	clrexpr(&e1);
	op = (int) mp->m_valu;
	switch (mp->m_type) {

	case S_INH:
		outab(op);
		break;

	case S_ADI:
		expr(&e1, 0);
		outab(op);
		outrb(&e1, 0);
		break;

	case S_RST:
		if (more()) {
			expr(&e1, 0);
			if (is_abs(&e1)) {
				if (e1.e_addr & ~0x07) {
					aerr();
				}
				v1 = (e1.e_addr & 0x07) << 3;
				outab(op | v1);
			} else {
				outrbm(&e1, R_RST, op);
			}
		} else {
			outab(op);
		}
		break;

	case S_MVI:
		expr(&e1, 0);
		outab(op);
		outrb(&e1, 0);
		break;

	case S_JMP:
		expr(&e1, 0);
		outab(op);
		outrw(&e1, 0);
		break;

	case S_INP:
		expr(&e1, 0);
		if (is_abs(&e1)) {
			if (e1.e_addr & ~0x07) {
				outab(op);
				aerr();
			} else {
				outab(op | (e1.e_addr<<1));
			}
		} else {
			outrbm(&e1, R_INP, op);
		}
		break;

	case S_OUT:
		expr(&e1, 0);
		if (is_abs(&e1)) {
			if ((e1.e_addr & ~0x1F) || (e1.e_addr < 0x08)) {
				outab(op | 0x08);
				aerr();
			} else {
				outab(op | (e1.e_addr<<1));
			}
		} else {
			outrbm(&e1, R_OUT, op);
		}
		break;

	case S_SHL:
		expr(&e1, 0);
		v1 = e1.e_addr;
		outab(0x2E);
		outrb(&e1, R_MSB);
		e1.e_addr = v1;
		outab(0x36);
		outrb(&e1, 0);
		break;

	default:
		opcycles = OPCY_ERR;
		err('o');
		break;
	}
	if (opcycles == OPCY_NONE) {
		if (mp->m_type == S_SHL) {
			opcycles = 6;
		} else {
			opcycles = i08pg1[cb[0] & 0xFF];
		}
	}
}

/*
 *Machine specific initialization.
 */
VOID
minit()
{
	/*
	 * Byte Order
	 */
	hilo = 0;
}
