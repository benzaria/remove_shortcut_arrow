@echo off
:: Made by benzaria and converted using Bat_To_Exe
setlocal EnableDelayedExpansion
chcp 65001 > nul

:: Initialize variables
set "directory=%windir%"
:: for the executable file use, remove <rem>
rem set "icon=blanc.ico"
:: for the batch file use, remove <rem>
set "icon=%~dp0blanc.ico"
set "isdirectory="
set "isicon="
set "style="
set "res="

:: Receiving arguments
for %%j in (%*) do (
    if "%%~j" equ "/?" goto :help
    if "%%~j" equ "-help" goto :help
    if "%%~j" equ "-undo" set "res=-undo"
    if "%%~j" equ "-hidden" set "style=-WindowStyle Hidden"
    if defined isicon (
        set "icon=%%~j" & set "isicon="
    ) else if "%%~j" equ "-ico" (
        set "isicon=true"
    )
    if defined isdirectory (
        set "directory=%%~j" & set "isdirectory="
    ) else if "%%~j" equ "-dir" (
        set "isdirectory=true"
    )
)

:: Check for admin privilage
openfiles > nul 2>&1
if !errorlevel! neq 0 (
    echo [94mFor more info try [/?, -help][0m
    echo | set /p="[93mThe execution needs elevated privileges (y|n) [0m"
    choice /n
    if !errorlevel! equ 1 (
        :: for the executable file use, remove <rem>
        rem start /b /wait PowerShell -NoProfile -Command "Start-Process -Verb RunAs \"%~f0\" -ArgumentList '%res% -ico \"%icon%\" -dir \"%directory%\"' %style%" > nul 2>&1
        :: for the batch file use, remove <rem>
        start /b /wait "" PowerShell -NoProfile -Command "Start-Process -Wait -Verb RunAs cmd.exe -ArgumentList '/C \"\"%~f0\" %res% -ico \"%icon%\" -dir \"%directory%\"\"' %style%" > nul 2>&1
        exit /b 0
    )
)

:: Saving the blanc.ico to the specified directory
if not exist "%directory%\" (
    echo [91mError: Unable to find directory %directory%.[0m
    timeout /t 1 > nul
    echo | set /p="[93mDo you want to make dir %directory% (y|n) [0m"
    choice /n /d y /t 5
    if !errorlevel! equ 1 ( 
        mkdir "%directory%" 
    ) else exit /b 1
)
if not exist "%icon%" (
    echo [91mError: Unable to find "%icon%".[0m
    timeout /t 3 > nul
    exit /b 1
)

copy "%icon%" "%directory%\blanc.ico" > nul 2>&1

:: Specify the registry path and value name
set "key=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons"
set "value=29"
set "data=%directory%\blanc.ico"

:: Use reg.exe to modify the registry
if not exist "%directory%\blanc.ico" (
    echo [91mError: Unable to find blanc.ico in %directory%.[0m
    exit /b 1
) else (
    if defined res (
        reg delete "%key%" /v "%value%" /f > nul 2>&1
    ) else (
        reg add "%key%" /v "%value%" /t REG_SZ /d "%data%" /f > nul 2>&1
    )
)

:: Check for errors
if %errorlevel% neq 0 (
    echo [91mError: Unable to modify the registry.[0m
) else (
    echo [92mRegistry updated successfully.[0m
)

:: Restart Windows Explorer
taskkill /f /im explorer.exe > nul 2>&1
start explorer.exe

timeout /t 5 > nul
endlocal
EXIT /B

:help
    echo [95m
    echo  ╔═══════════════════════════════════════════════════════════════════════╗
    echo  ║ remove_shortcut_arrow made by benzaria and converted using Bat_To_Exe ║
    echo  ║    It's used to remove or change the shortcut arrow from shortcuts    ║
    echo  ╚═══════════════════════════════════════════════════════════════════════╝[0m
    echo   ^>^>for more info check [90mhttps://github.com/benzaria/remove_shortcut_arrow[0m
    echo [93m
    echo remove_shortcut_arrow.exe [/?, -help] [-hidden] [-dir] [-undo] [-ico][0m
    echo [94m
    echo    -hidden[0m     hide the admin command prompt ( don't show Errors )
    echo [94m
    echo    -dir [96m^<dir^>[0m  change the saving directory of blanc.ico [default ^<%windir%^>]
    echo [94m
    echo    -undo[0m       undo and restore the changes happend on the shortcut icon
    echo [94m
    echo    -ico [96m^<ico^>[0m  change the default ^<blanc.ico^> for your desired icon
    echo [31m 
    echo | set /p="^!^! The program needs elevated privileges to make changes on the registry ^!^!"
    echo [0m
    exit /b 0
