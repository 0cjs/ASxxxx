@echo off
REM _prep.bat
REM   Remove all build files.
REM

if %1.==/?. goto ERROR
if %1.==. goto ALL
if %1.==all. goto ALL
goto ASXXXX

:ALL
cd as1802
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as2650
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as430
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6100
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as61860
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6500
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6800
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6801
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6804
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6805
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6808
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6809
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6811
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6812
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as6816
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as740
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as78k0
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as78k0s
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as8008
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as8008s
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as8048
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as8051
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as8085
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as8x300
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd as8xcxxx
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asavr
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd ascheck
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asez80
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asf2mc8
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asf8
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asgb
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd ash8
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asm8c
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd aspic
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asrab
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asscmp
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asst6
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asst7
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asst8
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asz8
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asz80
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asz280
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd aslink
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asxcnv
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd asxscn
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
cd s19os9
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
del /q ..\misc\*.lst
goto EXIT

:ASXXXX
cd %1
if not exist %1.vcproj goto ERROR
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
del /q ..\misc\%1.lst
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

