..\asxmak\djgpp\exe\asst7 -lov st7gbl.asm
..\asxmak\djgpp\exe\asst7 -glovaxff st7err.asm
..\asxmak\djgpp\exe\asxscn st7err.lst
..\asxmak\djgpp\exe\aslink -u st7err st7gbl st7err
..\asxmak\djgpp\exe\asxscn -i st7err.rst

