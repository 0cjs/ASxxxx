/* s8xadr.c */

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
#include "s8x.h"

int aindx;

int
addr(esp,nsp,xsp)
struct expr *esp;
struct expr *nsp;
struct expr *xsp;
{
	aindx = 0;

	/*
	 * Check For Rn Form
	 */
	if (admode(reg)) {
		esp->e_addr = aindx;
		esp->e_mode = A_REG;
	} else {
		eaddr(esp);
	}
	naddr(nsp);
	xaddr(xsp);
	return (esp->e_mode);
}

VOID
eaddr(esp)
struct expr *esp;
{
	int c,cp;
	char id[NCPS];
	char *ipr, iprc;
	char *ips;
	struct sym *sp;
	a_uint vsp;

	ips = ip;
	c = getnb();
	if ((c == ',') || (c == ';') || (c == '\0')) {
		ip = ips;
		mcherr("Missing argument");
		return;
	}
	ip = ips;
	ipr = NULL;
	iprc = 0;
	cp = 0x2A; /* BINOP */
	while (more()) {
		c = getnb();
		if ((c == ',') || (c == '[') || ((c == '(') && (ctype[cp] != BINOP))) {
			unget(c);
			ipr  = ip;
			iprc = c;
			*ip = '\0';
			break;
		}
		cp = c;
	}
	ip = ips;
	c = getnb();
	if (ctype[c] & LETTER) {
		getid(id, c);
		sp = lookup(id);
		if (sp->s_flag & (F_LIV | F_RIV)) {
			vsp = sp->s_addr;
			sp->s_addr = (vsp >> 6) & 0xFF;
			ip = ips;
			expr(esp, 0);
			abscheck(esp);
			esp->e_addr = ((esp->e_addr & 0x03FF) << 6) | (vsp & 0x3F);
			sp->s_addr = vsp;
			if (sp->s_flag & F_LIV) { esp->e_mode = A_LIV; }
			if (sp->s_flag & F_RIV) { esp->e_mode = A_RIV; }
		}
	}
	if (esp->e_mode == 0) {
		ip = ips;
		expr(esp, 0);
		esp->e_mode = A_EXT;
	}
	if (ipr != NULL) {
		ip  = ipr;
		*ip = iprc;
	}
}

VOID
naddr(esp)
struct expr *esp;
{
	int c;
	a_uint v;
	char *ips;

	/*
	 * Check Forms:
	 *	(R)
	 *	(n)
	 *	(df,len)
	 */
	if ((c = getnb()) == '(') {
		ips = ip;
		while (*ips != ')') {
			if (*(++ips) == 0) {
				qerr();
			}
		}
		*ips = 0;
		/* A_REG - (Rx) */
		if (admode(reg)) {
			esp->e_addr = aindx;
			esp->e_mode = A_REG;
			if (comma(0)) {
				mcherr("Form (Rn,N) is not allowed");
			}
		} else
		/* A_EXT | A_LIV | A_RIV */
		{
			eaddr(esp);
			if (comma(0)) {
				v = absexpr();
				if (v > 8) {
					mcherr("Bits more than 8");
				}
				esp->e_addr &= ~0x07;
				esp->e_addr |= (v & 0x07);
			}
		}
		*ips++ = ')';
		ip = ips;
	} else {
		unget(c);
	}
}

VOID
xaddr(esp)
struct expr *esp;
{
	int c;
	char *ips;
	char id[NCPS];
	int i;
	int argcnt;
	a_uint argval;
	int d_bits,d_skip;
	a_uint v_xtnd,v_bits,v_mask;

	/*
	 * Check [xtnd] Form
	 */
	if ((c = getnb()) == '[') {
		ips = ip;
		while (*ips != ']') {
			if (*(++ips) == 0) {
				qerr();
			}
		}
		*ips = 0;
		argcnt = 0;
		argval = 0;
		v_xtnd = d_xtnd;
		v_bits = 0;
		while (more()) {
			if (argcnt >= d_xdef) {
				mcherr("More fields than defined");
				break;
			}
			d_bits = xfield[argcnt].d_bits;
			d_skip = xfield[argcnt].d_skip;
			for (i=0,v_mask=1; i<d_bits; i++) {
				v_mask *= 2;
			}
			v_mask -= 1;
			v_bits += d_bits;
			if ((c = getnb()) == ',') {
				;
			} else {
				unget(c);
				clrexpr(esp);
				eaddr(esp);
				if (esp->e_mode & (A_LIV | A_RIV)) {
					argval = esp->e_addr >> 6;
				} else {
					argval = esp->e_addr;
				}
				if ((d_skip == 0) && (argval & ~v_mask)) {
					sprintf(id, "Value %d exceeds maximum bit range of %d", argval, v_mask);
					mcherr(id);
				}
				v_xtnd &= ~(v_mask << (16 - v_bits));
				v_xtnd |= ((argval & v_mask) << (16 - v_bits));
				comma(0);
			}
			argcnt += 1;
		}
		esp->e_addr = v_xtnd;
		esp->e_mode = A_XTND;
		*ips++ = ']';
		ip = ips;
	} else {
		unget(c);
	}
}

/*
 * Enter admode() to search a specific addressing mode table
 * for a match. Return the addressing value on a match or
 * zero for no match.
 */
int
admode(sp)
struct adsym *sp;
{
	char *ptr;
	int i;
	char *ips;

	ips = ip;
	unget(getnb());

	i = 0;
	while ( *(ptr = &sp[i].a_str[0]) ) {
		if (srch(ptr)) {
			aindx = sp[i].a_val;
			return(1);
		}
		i++;
	}
	ip = ips;
	return(0);
}

/*
 *      srch --- does string match ?
 */
int
srch(str)
char *str;
{
	char c;
	char *ptr;

	ptr = ip;
	if (any(*ptr,",;([") || (*ptr == 0)) {
		return(0);
	}

	while (*ptr && *str) {
		if (ccase[*ptr & 0x007F] != ccase[*str & 0x007F])
			break;
		ptr++;
		str++;
	}
	if (ccase[*ptr & 0x007F] == ccase[*str & 0x007F]) {
		ip = ptr;
		return(1);
	}

	if (!*str) {
		while ((c=*ptr) == ' ' || c == '\t') { ptr++; }
		if (any(*ptr,",;([") || (c == 0)) {
			ip = ptr;
			return(1);
		}
	}
	return(0);
}

/*
 *      any --- does str contain c?
 */
int
any(c,str)
int c;
char *str;
{
	while (*str)
		if(*str++ == c)
			return(1);
	return(0);
}

/*
 * Registers
 */

struct	adsym	reg[] = {
    {	"aux",	0x00	},
    {	 "r0",	0x00	},
    {	"r1",	0x01	},
    {	"r2",	0x02	},
    {	"r3",	0x03	},
    {	"r4",	0x04	},
    {	"r5",	0x05	},
    {	"r6",	0x06	},
    {	"ivl",	0x07	},
    {	 "r7",	0x07	},
    {	"ovf",	0x08	},
    {	 "r10",	0x08	},
    {	"r11",	0x09	},
    {	"r12",	0x0A	},
    {	"r13",	0x0B	},
    {	"r14",	0x0C	},
    {	"r15",	0x0D	},
    {	"r16",	0x0E	},
    {	"ivr",	0x0F	},
    {	 "r17",	0x0F	},
    {	"",	0000	}
};


