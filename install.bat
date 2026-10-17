@echo off
if not exist "C:\Windows\ffmpeg.exe" (
    if not exist "%CD%/ffmpeg.exe" (
        echo [ERROR] ffmpeg.exe is missing in %CD%/ffmpeg.exe
        goto :EXIT
    )

    mklink "C:\Windows\ffmpeg.exe" "%CD%/ffmpeg.exe"
)

if not exist "C:\Windows\AviSynth.dll" (
    if not exist "%CD%/plugins/AviSynth.dll" (
        echo [ERROR] AviSynth.dll is missing in %CD%/AviSynth.dll
        goto :EXIT
    )
    
    mklink "C:\Windows\AviSynth.dll" "%CD%/plugins/AviSynth.dll"
)

if not exist "%CD%/plugins/ffms2.dll" (
    echo [ERROR] Missing plugin ffms2.dll in: %CD%\plugins
	goto :EXIT
)

if not exist "%CD%/plugins/svpflow1.dll" (
    echo [ERROR] Missing plugin svpflow1.dll in: %CD%\plugins
	goto :EXIT
)

if not exist "%CD%/plugins/svpflow2.dll" (
    echo [ERROR] Missing plugin svpflow2.dll in: %CD%\plugins
	goto :EXIT
)

rem set __COMPAT_LAYER=RunAsInvoker

set "curpath=%CD%"
set "escpath=%curpath:\=\\%"

(
echo Windows Registry Editor Version 5.00

echo ; deleting previous settings
echo [-HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mp4\shell\AVS-scripts]
echo [-HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mkv\shell\AVS-scripts]


echo [HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mp4\shell\AVS-scripts]
echo "icon"="imageres.dll,280"
echo "subcommands"=""

echo [HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mkv\shell\AVS-scripts]
echo "icon"="imageres.dll,280"
echo "subcommands"=""


echo [HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mp4\shell\AVS-scripts\shell\60fps]
echo "icon"="imageres.dll,280"

echo [HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mkv\shell\AVS-scripts\shell\60fps]
echo "icon"="imageres.dll,280"


echo [HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mp4\shell\AVS-scripts\shell\60fps\command]
echo @="\"%escpath%\\shell\\interpolation.bat\" \"%%1\" \"%escpath%\\scripts\\60fps.avs\""

echo [HKEY_CURRENT_USER\SOFTWARE\Classes\SystemFileAssociations\.mkv\shell\AVS-scripts\shell\60fps\command]
echo @="\"%escpath%\\shell\\interpolation.bat\" \"%%1\" \"%escpath%\\scripts\\60fps.avs\""
) > temp.reg

regedit.exe /S temp.reg
del temp.reg

echo [SUCCESS] avs-shell has been successfully installed.
echo You can now right-click mp4 and mkv files to see the new AVS-scripts menu.

:EXIT
pause
exit
