Unicode True
!include "MUI2.nsh"

Name "MSHV Section 2 UTC Filter"
OutFile "..\dist\MSHV-Section2-UTC-Win64-Setup.exe"
InstallDir "$LOCALAPPDATA\Programs\MSHV-Section2-UTC"
RequestExecutionLevel user
SetCompressor /SOLID lzma
ShowInstDetails show
ShowUninstDetails show

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Section "MSHV" SecMain
    SetOutPath "$INSTDIR"
    File /r "..\dist\MSHV\*"
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    CreateDirectory "$SMPROGRAMS\MSHV Section 2 UTC"
    CreateShortcut "$SMPROGRAMS\MSHV Section 2 UTC\MSHV.lnk" "$INSTDIR\MSHV.exe"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MSHV-Section2-UTC" "DisplayName" "MSHV Section 2 UTC Filter"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MSHV-Section2-UTC" "UninstallString" '"$INSTDIR\Uninstall.exe"'
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MSHV-Section2-UTC" "InstallLocation" "$INSTDIR"
SectionEnd

Section "Uninstall"
    ; Preserve the MSHV settings and log folders (the user may have QSOs there).
    Delete "$SMPROGRAMS\MSHV Section 2 UTC\MSHV.lnk"
    RMDir "$SMPROGRAMS\MSHV Section 2 UTC"
    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MSHV-Section2-UTC"
    Delete "$INSTDIR\MSHV.exe"
    Delete "$INSTDIR\COPYING.txt"
    Delete "$INSTDIR\*.dll"
    RMDir /r "$INSTDIR\platforms"
    RMDir /r "$INSTDIR\styles"
    RMDir /r "$INSTDIR\imageformats"
    RMDir /r "$INSTDIR\iconengines"
    RMDir /r "$INSTDIR\bearer"
    RMDir /r "$INSTDIR\sqldrivers"
    RMDir /r "$INSTDIR\tls"
    RMDir /r "$INSTDIR\translations"
    Delete "$INSTDIR\Uninstall.exe"
    ; Intentionally leave any user log, settings, and other runtime folders.
    RMDir "$INSTDIR"
SectionEnd
