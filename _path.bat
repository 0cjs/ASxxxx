@echo off
REM Note:
REM   This is NOT a real 'make' file, just an alias.
REM
REM This BATCH file sets the PATH for code compiled with:
REM
REM    cygwin
REM    djgpp
REM    linux
REM    symantec
REM    turboc
REM    vc6
REM    vs05
REM    vs10
REM    vs13
REM    watcom
REM

if %1.==/?. goto ERROR
REM Default
if %1.==. goto WATCOM
REM Cygwin
if %1.==CYGWIN. goto CYGWIN
if %1.==cygwin. goto CYGWIN
REM Djgpp
if %1.==DJGPP. goto DJGPP
if %1.==djgpp. goto DJGPP
REM Linux
if %1.==LINUX. goto CYGWIN
if %1.==linux. goto LINUX
REM Symantec
if %1.==SYMANTEC. goto SYMANTEC
if %1.==symantec. goto SYMANTEC
REM Turboc
if %1.==TURBOC. goto TURBOC
if %1.==turboc. goto TURBOC
REM VC6
if %1.==VC6. goto VC6
if %1.==vc6. goto VC6
REM VS05
if %1.==VS05. goto VS05
if %1.==vs05. goto VS05
REM VS10
if %1.==VS10. goto VS10
if %1.==vs10. goto VS10
REM VS13
if %1.==VS13. goto VS13
if %1.==vs13. goto VS13
REM VS15
if %1.==VS15. goto VS15
if %1.==vs15. goto VS15
REM Watcom
if %1.==WATCOM. goto WATCOM
if %1.==watcom. goto WATCOM
REM Unknown
goto ERROR

:CYGWIN
path=r:\asxv5pxx\asxmak\cygwin\exe
goto EXIT

:DJGPP
path=r:\asxv5pxx\asxmak\djgpp\exe
goto EXIT

:LINUX
path=r:\asxv5pxx\asxmak\linux\exe
goto EXIT

:SYMANTEC
path=r:\asxv5pxx\asxmak\symantec\exe
goto EXIT

:TURBOC
path=r:\asxv5pxx\asxmak\turboc30\exe
goto EXIT

:VC6
path=r:\asxv5pxx\asxmak\vc6\exe
goto EXIT

:VS05
path=r:\asxv5pxx\asxmak\vs05\exe
goto EXIT

:VS10
path=r:\asxv5pxx\asxmak\vs10\exe
goto EXIT

:VS13
path=r:\asxv5pxx\asxmak\vs13\exe
goto EXIT

:VS15
path=r:\asxv5pxx\asxmak\vs15\exe
goto EXIT

:WATCOM
path=r:\asxv5pxx\asxmak\watcom\exe
goto EXIT

:ERROR
echo.
echo _PATH
echo.
echo Valid arguments are:
echo --------  --------
echo cygwin    CYGWIN
echo djgpp     DJGPP
echo linux     LINUX
echo symantec  SYMANTEC
echo turboc    TURBOC
echo vc6       VC6
echo vs05      VS05
echo vs10      VS10
echo vs13      VS13
echo vs15      VS15
echo watcom    WATCOM
echo --------  --------
echo.
goto EXIT

:EXIT

