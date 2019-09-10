/* r65adr.c */

/*
 *  Copyright (C) 1995-2014  Alan R. Baldwin
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

/*
 * With Contributions from
 *
 * Marko Makela
 * Sillitie 10 A
 * 01480 Vantaa
 * Finland
 * Internet: Marko dot Makela at Helsinki dot Fi
 * EARN/BitNet: msmakela at finuh
 */

#include "asxxxx.h"
#include "r6500.h"

int
addr(esp)
struct expr *esp;
{
	int c;

	if ((c = getnb()) == '#') {
		expr(esp, 0);
		esp->e_mode = S_IMMED;
	} else if (c == '*') {
		expr(esp, 0);
		esp->e_mode = S_DIR;
		if (more()) {
			comma(1);
			switch(admode(axy)) {
			case S_X:
				esp->e_mode = S_DINDX;
				break;
			case S_Y:
				esp->e_mode = S_DINDY;
				break;
			default:
				aerr();
			}
		}
	} else if (c == '[') {
		if ((c = getnb()) != '*') {
			unget(c);
		}
		expr(esp, 0);
		if ((c = getnb()) == ']') {
			if (more()) {
				comma(1);
				if (admode(axy) != S_Y)
					qerr();
				esp->e_mode = S_IPSTY;
			} else {
				esp->e_mode = S_IND;
			}
		} else {
			unget(c);
			comma(1);
			if (admode(axy) != S_X)
				qerr();
			esp->e_mode = S_IPREX;
			if (getnb() != ']')
				qerr();
		}
	} else {
		unget(c);
		switch(admode(axy)) {
		case S_A:
			esp->e_mode = S_ACC;
			break;
		case S_X:
		case S_Y:
			aerr();
			break;
		default:
			if (!more()) {
			    esp->e_mode = S_ACC;
			} else {
			    expr(esp, 0);
			    if (more()) {
				comma(1);
				switch(admode(axy)) {
				case S_X:
					if ((!esp->e_flag)
					    && (esp->e_base.e_ap==NULL)
						&& !(esp->e_addr & ~0xFF)) {
						esp->e_mode = S_DINDX;
					} else {
						esp->e_mode = S_INDX;
					}
					break;
				case S_Y:
					if ((!esp->e_flag)
					    && (esp->e_base.e_ap==NULL)
						&& !(esp->e_addr & ~0xFF)) {
						esp->e_mode = S_DINDY;
					} else {
						esp->e_mode = S_INDY;
					}
					break;
				default:
					aerr();
					break;
				}
			    } else {
				if ((!esp->e_flag)
					&& (esp->e_base.e_ap==NULL)
					&& !(esp->e_addr & ~0xFF)) {
					esp->e_mode = S_DIR;
				} else {
					esp->e_mode = S_EXT;
				}
			    }
			}
		}
	}
	return (esp->e_mode);
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
			return(sp[i].a_val);
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
	char *ptr;
	ptr = ip;

	while (*ptr && *str) {
		if(ccase[*ptr & 0x007F] != ccase[*str & 0x007F])
			break;
		ptr++;
		str++;
	}
	if (ccase[*ptr & 0x007F] == ccase[*str & 0x007F]) {
		ip = ptr;
		return(1);
	}

	if (!*str)
		if (any(*ptr," \t\n,];")) {
			ip = ptr;
			return(1);
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

struct adsym	axy[] = {	/* a, x, or y registers */
    {	"a",	S_A	},
    {	"x",    S_X	},
    {	"y",    S_Y	},
    {	"",	0x00	}
};
