@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A

SET "EXEName=ShopTitans.exe"
SET "BaseName=%EXEName:.exe=%"
SET "prevState=UNKNOWN"
SET /A sessionSeconds=0, restartCount=0, launchRetryCount=0
SET "CheckInterval=1"
SET "MaxRetries=20"

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
SET "LaunchURL=com.epicgames.launcher://apps/Coral?action=launch&silent=true"

CLS
ECHO ============================================
ECHO =  ShopTitans-Watchdog
ECHO ============================================
ECHO Platform   : %Platform%
ECHO Directory  : %GameDir%
ECHO Monitoring every %CheckInterval% sec
ECHO ============================================
TIMEOUT /T 3 /NOBREAK >NUL

:loop
IF NOT DEFINED CheckInterval SET CheckInterval=1

TASKLIST /FI "IMAGENAME eq %EXEName%" /NH | FINDSTR /I "%EXEName%" >NUL
IF ERRORLEVEL 1 (
    SET "currState=NOT_RUNNING"
) ELSE (
    SET "currState=RUNNING"
)

IF "%currState%"=="RUNNING" (
    SET /A sessionSeconds+=CheckInterval
    SET launchRetryCount=0
) ELSE (
    SET sessionSeconds=0
)

SET /A hh=sessionSeconds/3600, mm=(sessionSeconds%%3600)/60, ss=sessionSeconds%%60
IF %hh% LSS 10 (SET hh=0%hh%)
IF %mm% LSS 10 (SET mm=0%mm%)
IF %ss% LSS 10 (SET ss=0%ss%)

CLS
ECHO ============================================
ECHO =  ShopTitans-Watchdog
ECHO ============================================
ECHO Status     : %currState%
ECHO Uptime     : %hh%:%mm%:%ss%
ECHO Restarts   : %restartCount%
ECHO Platform   : %Platform%
ECHO Directory  : %GameDir%
ECHO LaunchAttempts: %launchRetryCount%
ECHO ============================================
ECHO Timestamp : %DATE% %TIME%

IF "%currState%"=="NOT_RUNNING" (
    IF %launchRetryCount% EQU 0 (
        SET /A restartCount+=1
        ECHO Epic Games Launcher check...

        TASKLIST /FI "IMAGENAME eq EpicGamesLauncher.exe" /NH | FINDSTR /I "EpicGamesLauncher.exe" >NUL
        IF ERRORLEVEL 1 (
            ECHO Epic Games Launcher not running. Starting...
            START "" "%Launcher%"
            TIMEOUT /T 30 /NOBREAK >NUL
        ) ELSE (
            ECHO Epic Games Launcher already running.
        )
    )

    SET /A launchRetryCount+=1
    ECHO Attempt #%launchRetryCount% to launch Shop Titans
    START "" "%LaunchURL%"
    TIMEOUT /T 15 /NOBREAK >NUL

    IF %launchRetryCount% GEQ %MaxRetries% (
        CLS
        ECHO =====================================================
        ECHO WARNING: Could not auto-launch Shop Titans after %MaxRetries% attempts.
        ECHO You must manually open Shop Titans in Epic Games now.
        ECHO Waiting for manual launch...
        ECHO =====================================================
        :waitmanual
        TASKLIST /FI "IMAGENAME eq %EXEName%" /NH | FINDSTR /I "%EXEName%" >NUL
        IF ERRORLEVEL 1 (
            TIMEOUT /T 5 /NOBREAK >NUL
            GOTO waitmanual
        )
        SET launchRetryCount=0
        ECHO Manual launch detected, resuming watchdog...
        TIMEOUT /T 5 /NOBREAK >NUL
    )
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
