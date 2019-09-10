@echo off
REM Note:
REM   This is NOT a real 'make' file, just an alias.
REM
REM This BATCH file assumes PATH includes wmake.exe
REM

if %1.==/?. goto ERROR
if %1.==. goto ALL
if %1.==all. goto ALL
if %1.==clean. goto CLEAN
goto ASXXXX

:ALL
@echo on
wmake -f as1802.mk -h -e
wmake -f as2650.mk -h -e
wmake -f as430.mk -h -e
wmake -f as6100.mk -h -e
wmake -f as61860.mk -h -e
wmake -f as6500.mk -h -e
wmake -f as6800.mk -h -e
wmake -f as6801.mk -h -e
wmake -f as6804.mk -h -e
wmake -f as6805.mk -h -e
wmake -f as6808.mk -h -e
wmake -f as6809.mk -h -e
wmake -f as6811.mk -h -e
wmake -f as6812.mk -h -e
wmake -f as6816.mk -h -e
wmake -f as740.mk -h -e
wmake -f as78k0.mk -h -e
wmake -f as78k0s.mk -h -e
wmake -f as8008.mk -h -e
wmake -f as8008s.mk -h -e
wmake -f as8048.mk -h -e
wmake -f as8051.mk -h -e
wmake -f as8085.mk -h -e
wmake -f as8x300.mk -h -e
wmake -f as8xcxxx.mk -h -e
wmake -f asavr.mk -h -e
wmake -f ascheck.mk -h -e
wmake -f asez80.mk -h -e
wmake -f asf2mc8.mk -h -e
wmake -f asf8.mk -h -e
wmake -f asgb.mk -h -e
wmake -f ash8.mk -h -e
wmake -f asm8c.mk -h -e
wmake -f aspic.mk -h -e
wmake -f asrab.mk -h -e
wmake -f asscmp.mk -h -e
wmake -f asst6.mk -h -e
wmake -f asst7.mk -h -e
wmake -f asst8.mk -h -e
wmake -f asz8.mk -h -e
wmake -f asz80.mk -h -e
wmake -f asz280.mk -h -e
wmake -f aslink.mk -h -e
wmake -f asxcnv.mk -h -e
wmake -f asxscn.mk -h -e
wmake -f s19os9.mk -h -e
@echo off
goto EXIT

:ASXXXX
@echo on
wmake -f %1.mk -h -e
@echo off
goto EXIT

:CLEAN
del *.exe
del *.obj
del *.map
del *.sym
goto EXIT

:ERROR
echo.
echo make - Compiles the ASxxxx Assemblers, Linker, and Utilities.
echo.
echo Valid arguments are:
echo --------  --------  --------  --------  --------  --------
echo all       ==        'blank'
echo --------  --------  --------  --------  --------  --------
echo as1802    as2650    as430     as6100    as61860   as6500
echo as6800    as6801    as6804    as6805    as6808    as6809
echo as6811    as6812    as6816    as740     as78k0    as78k0s
echo as8008    as8008s   as8048    as8051    as8085    as8x300
echo as8xcxxx  asavr     ascheck   asez80    asf2mc8   asf8
echo asgb      ash8      asm8c     aspic     asrab     asscmp
echo asst6     asst7     asst8     asz8      asz80     asz280
echo --------  --------  --------  --------  --------  --------
echo aslink    asxcnv    asxscn    s19os9
echo --------  --------  --------  --------  --------  --------
echo.
goto EXIT

:EXIT

