@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A

SET "EpicApp=329064225aaf4df29c4658f141173905"
SET "prevState=UNKNOWN"
SET /A sessionSeconds=0, restartCount=0, batSeconds=0
SET "CheckInterval=1"

CLS
ECHO ============================================
ECHO =  ShopTitans-Watchdog (Epic)              =
ECHO =  Created by CyberNinja                   =
ECHO =  Monitoring every %CheckInterval% sec    =
ECHO =  Platform   : Epic Games                 =
ECHO =  App ID     : %EpicApp%                  =
ECHO ============================================
TIMEOUT /T 3 /NOBREAK >NUL

:loop
IF NOT DEFINED CheckInterval SET CheckInterval=1

TASKLIST /FI "IMAGENAME eq ShopTitans.exe" /NH | FINDSTR /I "ShopTitans.exe" >NUL
IF ERRORLEVEL 1 (
    SET "currState=NOT_RUNNING"
) ELSE (
    SET "currState=RUNNING"
)

IF "%currState%"=="RUNNING" (
    SET /A sessionSeconds+=CheckInterval
) ELSE (
    SET sessionSeconds=0
)
SET /A batSeconds+=CheckInterval

SET /A hh=sessionSeconds/3600, mm=(sessionSeconds%%3600)/60, ss=sessionSeconds%%60
IF %hh% LSS 10 (SET hh=0%hh%) & IF %mm% LSS 10 (SET mm=0%mm%) & IF %ss% LSS 10 (SET ss=0%ss%)

SET /A bhh=batSeconds/3600, bmm=(batSeconds%%3600)/60, bss=batSeconds%%60
IF %bhh% LSS 10 (SET bhh=0%bhh%) & IF %bmm% LSS 10 (SET bmm=0%bmm%) & IF %bss% LSS 10 (SET bss=0%bss%)

CLS
ECHO ============================================
ECHO =  ShopTitans-Watchdog (Epic)             =
ECHO =  Status     : %currState%               =
ECHO =  Game Uptime: %hh%:%mm%:%ss%             =
ECHO =  Bat Uptime : %bhh%:%bmm%:%bss%           =
ECHO =  Restarts   : %restartCount%             =
ECHO =  Platform   : Epic Games                 =
ECHO =  App ID     : %EpicApp%                  =
ECHO ============================================
ECHO Timestamp : %DATE% %TIME%

IF "%currState%"=="NOT_RUNNING" (
    SET /A restartCount+=1
    ECHO Action : Restarting via Epic Launcher...
    START "" "com.epicgames.launcher://apps/%EpicApp%?action=launch&silent=true"
    TIMEOUT /T 5 /NOBREAK >NUL
) ELSE (
    IF "%prevState%"=="NOT_RUNNING" (
        ECHO Action : Detected new session
    ) ELSE (
        ECHO Action : No action - running
    )
)

SET "prevState=%currState%"
TIMEOUT /T %CheckInterval% /NOBREAK >NUL
GOTO loop
