@ECHO OFF
CHCP 65001 >NUL
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A

REM ── Header ─────────────────────────────────────────────────────────────────
ECHO ShopTitan Sentinel Monitor: Monitors the ShopTitan process and restarts it if it stops unexpectedly.
ECHO Created by CyberNinja.
ECHO.

SET "EXEName=ShopTitan.exe"
SET "BaseName=%EXEName:.exe=%"
SET "prevState=UNKNOWN"
SET /A sessionSeconds=0, restartCount=0
SET "CheckInterval=1"

REM ── Auto‑detect game directory on Steam and Epic ────────────────────────────
FOR %%D IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
    IF NOT DEFINED GameDir (
        IF EXIST "%%D:\SteamLibrary\steamapps\common\%BaseName%\%EXEName%" (
            SET "GameDir=%%D:\SteamLibrary\steamapps\common\%BaseName%"
            SET "Platform=Steam"
        ) ELSE IF EXIST "%%D:\Program Files (x86)\Steam\steamapps\common\%BaseName%\%EXEName%" (
            SET "GameDir=%%D:\Program Files (x86)\Steam\steamapps\common\%BaseName%"
            SET "Platform=Steam"
        ) ELSE IF EXIST "%%D:\Program Files\Epic Games\%BaseName%\%EXEName%" (
            SET "GameDir=%%D:\Program Files\Epic Games\%BaseName%"
            SET "Platform=Epic"
        )
    )
)
IF NOT DEFINED GameDir (
    ECHO Error: could not locate %EXEName%.
    PAUSE
    EXIT /B 1
)

IF /I "%Platform%"=="Steam" (
    SET "Launcher=%ProgramFiles(x86)%\Steam\steam.exe"
    REM Replace 1258080 with the actual AppID
    SET "LaunchArgs=-applaunch 1258080"
) ELSE (
    SET "Launcher=%GameDir%\%EXEName%"
    SET "LaunchArgs="
)

REM ── Initial banner ─────────────────────────────────────────────────────────
CLS
ECHO ********************************************
ECHO *  ShopTitan Sentinel Monitor              *
ECHO *  Created by CyberNinja                   *
ECHO *  Description: Monitors and auto‑restarts *
ECHO *  Platform   : %Platform%                  *
ECHO *  Directory  : %GameDir%                   *
ECHO ********************************************
ECHO Monitoring every %CheckInterval% second(s). Press Ctrl+C to exit.
TIMEOUT /T 3 /NOBREAK >NUL

:loop
    REM ── Check process ──────────────────────────────────────────────────────
    TASKLIST /FI "IMAGENAME eq %EXEName%" /NH | FINDSTR /I "%EXEName%" >NUL
    IF ERRORLEVEL 1 (SET "currState=NOT_RUNNING") ELSE (SET "currState=RUNNING")

    REM ── Update timer ───────────────────────────────────────────────────────
    IF "%currState%"=="RUNNING" (SET /A sessionSeconds+=CheckInterval) ELSE (SET sessionSeconds=0)
    SET /A hh=sessionSeconds/3600, mm=(sessionSeconds%%3600)/60, ss=sessionSeconds%%60
    IF %hh% LSS 10 (SET hh=0%hh%) & IF %mm% LSS 10 (SET mm=0%mm%) & IF %ss% LSS 10 (SET ss=0%ss%)

    REM ── Display status ──────────────────────────────────────────────────────
    CLS
    ECHO ********************************************
    ECHO *  ShopTitan Sentinel Monitor              *
    ECHO *  Created by CyberNinja                   *
    ECHO *  Description: Monitors and auto‑restarts *
    ECHO *  Status     : %currState%                *
    ECHO *  Uptime     : %hh%:%mm%:%ss%              *
    ECHO *  Restarts   : %restartCount%              *
    ECHO *  Platform   : %Platform%                  *
    ECHO *  Directory  : %GameDir%                   *
    ECHO ********************************************
    CALL ECHO Timestamp : %%DATE%% %%TIME%%

    REM ── Restart logic ───────────────────────────────────────────────────────
    IF "%currState%"=="NOT_RUNNING" (
        SET /A restartCount+=1
        ECHO Action : Restarting via %Platform%...
        START "" "%Launcher%" %LaunchArgs%
    ) ELSE (
        IF "%prevState%"=="NOT_RUNNING" (
            ECHO Action : Detected new session
        ) ELSE (
            ECHO Action : No action – running
        )
    )

    REM ── Repeat description ───────────────────────────────────────────────────
    ECHO ShopTitan Sentinel Monitor: Monitors the ShopTitan process and restarts if closed.

    SET "prevState=%currState%"
    TIMEOUT /T %CheckInterval% /NOBREAK >NUL
GOTO loop
