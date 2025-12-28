@echo off
set RUN=0
set CLEAN=0
set PRE=0

if "%1"=="--help" goto showhelp
if "%1"=="-h" goto showhelp

set ARG=%1

echo(%ARG% | findstr /i "r" >nul && set RUN=1
echo(%ARG% | findstr /i "c" >nul && set CLEAN=1
echo(%ARG% | findstr /i "p" >nul && set PRE=1

if "%PRE%"=="1" (
    echo.
    echo Running Premake5
    echo.
    call build-MinGW-W64.bat
    goto pc
)

if "%CLEAN%"=="1" (
    echo.
    echo Cleaning Build...
    echo.
    mingw32-make clean
    goto pc
)

:pc

echo.
echo Building Game...
echo.
mingw32-make

if "%RUN%"=="1" (
    echo.
    echo Running Game...
    echo.
    .\bin\Debug\Game.exe
)
goto end

:showhelp
echo.
echo Usage:
echo   %~nx0 [options]
echo.
echo Options:
echo   r   Run the game after building
echo   c   Clean the build directory before building
echo   p   Run premake before building
echo   h   Show this help message
echo.
echo Flags can be combined:
echo   %~nx0 rp      Run premake, build, then run
echo   %~nx0 cr      Clean, build, then run
echo   %~nx0 pcr     Premake, clean, build, then run
goto end

:end
echo.