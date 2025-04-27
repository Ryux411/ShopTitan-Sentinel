@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A

SET "EXEName=ShopTitan.exe"
SET "BaseName=%EXEName:.exe=%"
SET "prevState=UNKNOWN"
SET /A sessionSeconds=0, restartCount=0
SET "CheckInterval=1"

FOR %%D IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
    IF NOT DEFINED GameDir (
        IF EXIST "%%D:\Program Files\Epic Games\%BaseName%\%EXEName%" (
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

SET "Launcher=%ProgramFiles(x86)%\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe"
SET "LaunchArgs=com.epicgames.launcher://apps/Coral?action=launch&silent=true"

CLS
ECHO ============================================
ECHO =  ShopTitans-Watchdog                      =
ECHO =  Created by CyberNinja                   =
ECHO =  Monitoring every %CheckInterval% sec     =
ECHO =  Platform   : %Platform%                 =
ECHO =  Directory  : %GameDir%                  =
ECHO ============================================
TIMEOUT /T 3 /NOBREAK >NUL

:loop
IF NOT DEFINED CheckInterval SET CheckInterval=1

TASKLIST /FI "IMAGENAME eq %EXEName%" /NH | FINDSTR /I "%EXEName%" >NUL
IF ERRORLEVEL 1 (SET "currState=NOT_RUNNING") ELSE (SET "currState=RUNNING")

IF "%currState%"=="RUNNING" (SET /A sessionSeconds+=CheckInterval) ELSE (SET sessionSeconds=0)
SET /A hh=sessionSeconds/3600, mm=(sessionSeconds%%3600)/60, ss=sessionSeconds%%60
IF %hh% LSS 10 (SET hh=0%hh%) & IF %mm% LSS 10 (SET mm=0%mm%) & IF %ss% LSS 10 (SET ss=0%ss%)

CLS
ECHO ============================================
ECHO =  ShopTitans-Watchdog                      =
ECHO =  Status     : %currState%                =
ECHO =  Uptime     : %hh%:%mm%:%ss%             =
ECHO =  Restarts   : %restartCount%             =
ECHO =  Platform   : %Platform%                 =
ECHO =  Directory  : %GameDir%                  =
ECHO ============================================
ECHO Timestamp : %DATE% %TIME%

IF "%currState%"=="NOT_RUNNING" (
    SET /A restartCount+=1
    ECHO Action : Restarting via %Platform%...
    START "" "%Launcher%" "%LaunchArgs%"
    TIMEOUT /T 5 /NOBREAK >NUL
) ELSE (
    IF "%prevState%"=="NOT_RUNNING" (
        ECHO Action : Detected new session
    ) ELSE (
        ECHO Action : No action – running
    )
)

SET "prevState=%currState%"
TIMEOUT /T %CheckInterval% /NOBREAK >NUL
GOTO loop
