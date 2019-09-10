@echo off
REM Note:
REM   This is NOT a real 'make' file, just an alias.
REM
if %VC$BUILD%.==MSBUILD. goto BUILD
REM
REM This BATCH file assumes Environment Variables need to be initialized.
REM
REM call "c:\Program Files\Microsoft Visual Studio 12.0\VC\bin\vcvars32.bat"
call "c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\vcvars32.bat"
REM
REM This definition is valid for Visual Studio 2013
REM installed in the default location.
REM
SET VC$BUILD=MSBUILD
REM

:BUILD
if %1.==/?. goto ERROR
if %1.==. goto ALL
if %1.==all. goto ALL
if %1.==clean. goto EXIT
goto ASXXXX

:ALL
cd as1802
@echo on
%VC$BUILD% /p:Configuration=Release as1802.vcxproj 
@echo off
cd ..
cd as2650
@echo on
%VC$BUILD% /p:Configuration=Release as2650.vcxproj 
@echo off
cd ..
cd as430
@echo on
%VC$BUILD% /p:Configuration=Release as430.vcxproj 
@echo off
cd ..
cd as6100
@echo on
%VC$BUILD% /p:Configuration=Release as6100.vcxproj 
@echo off
cd ..
cd as61860
@echo on
%VC$BUILD% /p:Configuration=Release as61860.vcxproj 
@echo off
cd ..
cd as6500
@echo on
%VC$BUILD% /p:Configuration=Release as6500.vcxproj 
@echo off
cd ..
cd as6800
@echo on
%VC$BUILD% /p:Configuration=Release as6800.vcxproj 
@echo off
cd ..
cd as6801
@echo on
%VC$BUILD% /p:Configuration=Release as6801.vcxproj 
@echo off
cd ..
cd as6804
@echo on
%VC$BUILD% /p:Configuration=Release as6804.vcxproj 
@echo off
cd ..
cd as6805
@echo on
%VC$BUILD% /p:Configuration=Release as6805.vcxproj 
@echo off
cd ..
cd as6808
@echo on
%VC$BUILD% /p:Configuration=Release as6808.vcxproj 
@echo off
cd ..
cd as6809
@echo on
%VC$BUILD% /p:Configuration=Release as6809.vcxproj 
@echo off
cd ..
cd as6811
@echo on
%VC$BUILD% /p:Configuration=Release as6811.vcxproj 
@echo off
cd ..
cd as6812
@echo on
%VC$BUILD% /p:Configuration=Release as6812.vcxproj 
@echo off
cd ..
cd as6816
@echo on
%VC$BUILD% /p:Configuration=Release as6816.vcxproj 
@echo off
cd ..
cd as740
@echo on
%VC$BUILD% /p:Configuration=Release as740.vcxproj 
@echo off
cd ..
cd as78k0
@echo on
%VC$BUILD% /p:Configuration=Release as78k0.vcxproj 
@echo off
cd ..
cd as78k0s
@echo on
%VC$BUILD% /p:Configuration=Release as78k0s.vcxproj 
@echo off
cd ..
cd as8008
@echo on
%VC$BUILD% /p:Configuration=Release as8008.vcxproj 
@echo off
cd ..
cd as8008s
@echo on
%VC$BUILD% /p:Configuration=Release as8008s.vcxproj 
@echo off
cd ..
cd as8048
@echo on
%VC$BUILD% /p:Configuration=Release as8048.vcxproj 
@echo off
cd ..
cd as8051
@echo on
%VC$BUILD% /p:Configuration=Release as8051.vcxproj 
@echo off
cd ..
cd as8085
@echo on
%VC$BUILD% /p:Configuration=Release as8085.vcxproj 
@echo off
cd ..
cd as8x300
@echo on
%VC$BUILD% /p:Configuration=Release as8x300.vcxproj 
@echo off
cd ..
cd as8xcxxx
@echo on
%VC$BUILD% /p:Configuration=Release as8xcxxx.vcxproj 
@echo off
cd ..
cd asavr
@echo on
%VC$BUILD% /p:Configuration=Release asavr.vcxproj 
@echo off
cd ..
cd ascheck
@echo on
%VC$BUILD% /p:Configuration=Release ascheck.vcxproj 
@echo off
cd ..
cd asez80
@echo on
%VC$BUILD% /p:Configuration=Release asez80.vcxproj 
@echo off
cd ..
cd asf2mc8
@echo on
%VC$BUILD% /p:Configuration=Release asf2mc8.vcxproj 
@echo off
cd ..
cd asf8
@echo on
%VC$BUILD% /p:Configuration=Release asf8.vcxproj 
@echo off
cd ..
cd asgb
@echo on
%VC$BUILD% /p:Configuration=Release asgb.vcxproj 
@echo off
cd ..
cd ash8
@echo on
%VC$BUILD% /p:Configuration=Release ash8.vcxproj 
@echo off
cd ..
cd asm8c
@echo on
%VC$BUILD% /p:Configuration=Release asm8c.vcxproj 
@echo off
cd ..
cd aspic
@echo on
%VC$BUILD% /p:Configuration=Release aspic.vcxproj 
@echo off
cd ..
cd asrab
@echo on
%VC$BUILD% /p:Configuration=Release asrab.vcxproj 
@echo off
cd ..
cd asscmp
@echo on
%VC$BUILD% /p:Configuration=Release asscmp.vcxproj 
@echo off
cd ..
cd asst6
@echo on
%VC$BUILD% /p:Configuration=Release asst6.vcxproj 
@echo off
cd ..
cd asst7
@echo on
%VC$BUILD% /p:Configuration=Release asst7.vcxproj 
@echo off
cd ..
cd asst8
@echo on
%VC$BUILD% /p:Configuration=Release asst8.vcxproj 
@echo off
cd ..
cd asz8
@echo on
%VC$BUILD% /p:Configuration=Release asz8.vcxproj 
@echo off
cd ..
cd asz80
@echo on
%VC$BUILD% /p:Configuration=Release asz80.vcxproj 
@echo off
cd ..
cd asz280
@echo on
%VC$BUILD% /p:Configuration=Release asz280.vcxproj 
@echo off
cd ..
cd aslink
@echo on
%VC$BUILD% /p:Configuration=Release aslink.vcxproj 
@echo off
cd ..
cd asxcnv
@echo on
%VC$BUILD% /p:Configuration=Release asxcnv.vcxproj 
@echo off
cd ..
cd asxscn
@echo on
%VC$BUILD% /p:Configuration=Release asxscn.vcxproj 
@echo off
cd ..
cd s19os9
@echo on
%VC$BUILD% /p:Configuration=Release s19os9.vcxproj 
@echo off
cd ..
goto EXIT

:ASXXXX
cd %1
if not exist %1.vcxproj goto ERROR
@echo on
%VC$BUILD% /p:Configuration=Release %1.vcxproj 
@echo off
cd ..
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

