/* i08mch.c */

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
#include "i08.h"

char	*cpu	= "Intel 8008 MCS-8";
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
 *	opcycles = i80pg1[opcode]
 */
static char i80pg1[256] = {
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
	struct expr e1,e2;
	int t1,t2;
	a_uint v1,v2;

	clrexpr(&e1);
	clrexpr(&e2);
	op = (int) mp->m_valu;
	switch (mp->m_type) {

	case S_INH:
		outab(op);
		break;

	case S_INR:
		t1 = addr(&e1);
		v1 = e1.e_addr;
		if ((t1 == S_REG) && (v1 > 0) && (v1 < 7)) {
			outab(op | (v1<<3));
		} else {
			outab(op);
			aerr();
		}
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
		t1 = addr(&e1);
		v1 = e1.e_addr;
		comma(1);
		expr(&e2, 0);
		if (t1 == S_REG) {
			outab(op | (v1<<3));
			outrb(&e2, 0);
		} else {
			outab(op);
			outab(0);
			aerr();
		}
		break;

	case S_JMP:
		expr(&e1, 0);
		outab(op);
		outrw(&e1, 0);
		break;

	case S_IN:
		expr(&e1, 0);
		if (is_abs(&e1)) {
			if (e1.e_addr & ~0x07) {
				outab(op);
				aerr();
			} else {
				outab(op | (e1.e_addr<<1));
			}
		} else {
			outrbm(&e1, R_IN, op);
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

	case S_ADD:
		t1 = addr(&e1);
		v1 = e1.e_addr;
		switch(t1) {
		case S_IMMED:
			switch(op) {
			default:
			case 0x80:	outab(0x04);	break;	/* ADD # -> ADI */
			case 0x88:	outab(0x0C);	break;	/* ADC # -> ACI */
			case 0x90:	outab(0x14);	break;	/* SUB # -> SUI */
			case 0x98:	outab(0x1C);	break;	/* SUB # -> SBI */
			case 0xA0:	outab(0x24);	break;	/* ANA # -> ANI */
			case 0xA8:	outab(0x2C);	break;	/* XRA # -> XRI */
			case 0xB0:	outab(0x34);	break;	/* ORA # -> ORI */
			case 0xB8:	outab(0x3C);	break;	/* CMP # -> CPI */
			}
			outrb(&e1, 0);
			break;
		case S_REG:
			outab(op | v1);
			break;
		default:
			aerr();
			outab(op);
			break;
		}
		break;

	case S_MOV:
		t1 = addr(&e1);
		v1 = e1.e_addr;
		comma(1);
		t2 = addr(&e2);
		v2 = e2.e_addr;
		if ((t1 == S_REG) && (t2 == S_REG)) {
			outab(op | (v1<<3) | v2);
		} else
		if ((t1 == S_REG) && (t2 == S_IMMED)) {
			switch(v1) {
			case A:		outab(0x06);	break;	/* MVI A,X */
			case B:		outab(0x0E);	break;	/* MVI B,X */
			case C:		outab(0x16);	break;	/* MVI C,X */
			case D:		outab(0x1E);	break;	/* MVI D,X */
			case E:		outab(0x26);	break;	/* MVI E,X */
			case H:		outab(0x2E);	break;	/* MVI H,X */
			case L:		outab(0x36);	break;	/* MVI L,X */
			case M:		outab(0x3E);	break;	/* MVI M,X */
			}
			outrb(&e2, 0);
		} else {
			outab(op);
			aerr();
		}
		break;

	default:
		opcycles = OPCY_ERR;
		err('o');
		break;
	}
	if (opcycles == OPCY_NONE) {
		opcycles = i80pg1[cb[0] & 0xFF];
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
