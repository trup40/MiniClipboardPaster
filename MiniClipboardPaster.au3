Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_MINIMIZE = -4
Global Const $GUI_CHECKED = 1
Global Const $GUI_UNCHECKED = 4
Global Const $WS_POPUPWINDOW = 0x80880000
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Global Const $TRAY_EVENT_PRIMARYUP = -8
Opt("GUIOnEventMode", 1)
Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 1 + 2)
Opt("TrayIconHide", 0)
TraySetClick(8)
Global $sAppName = "Mini Clipboard Paster"
Global $hGUI, $btnSettings, $btnAbout
Global $inputs[10], $lblKeys[10]
Global $sIniFile = @ScriptDir & "\clips.ini"
Global $iThemeMode = IniRead($sIniFile, "Settings", "ThemeMode", 0)
Global $iBgColor, $iInputBgColor, $iTextColor, $iLabelColor, $iAccentColor
Global $hSettingsWin, $rbAuto, $rbDark, $rbLight, $lblAuto, $lblDark, $lblLight
Global $cbSetOnTop, $lblSetOnTop
Global $idTrayShow = TrayCreateItem("Show Application")
TrayItemSetOnEvent(-1, "OnRestore")
TrayCreateItem("")
Global $idTrayExit = TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "OnExit")
If FileExists("app.ico") Then
TraySetIcon("app.ico")
EndIf
TraySetOnEvent($TRAY_EVENT_PRIMARYUP, "OnRestore")
TraySetToolTip($sAppName)
$hGUI = GUICreate($sAppName, 300, 410, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "OnMinimize")
Local $iOnTopState = IniRead($sIniFile, "Settings", "AlwaysOnTop", $GUI_UNCHECKED)
If $iOnTopState = $GUI_CHECKED Then
WinSetOnTop($hGUI, "", 1)
Else
WinSetOnTop($hGUI, "", 0)
EndIf
Local $yPos = 30
For $i = 0 To 9
Local $sKeyText = "CTRL+" &($i + 1)
If $i = 9 Then $sKeyText = "CTRL+0"
$lblKeys[$i] = GUICtrlCreateLabel($sKeyText, 15, $yPos + 3, 50, 18)
GUICtrlSetFont(-1, 9, 600, 0, "Segoe UI")
$inputs[$i] = GUICtrlCreateInput("", 70, $yPos, 215, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
Local $sSavedData = IniRead($sIniFile, "Slots", "Slot" & $i, "")
GUICtrlSetData(-1, $sSavedData)
$yPos += 32
Next
$yPos += 15
$btnSettings = GUICtrlCreateButton("Settings", 15, $yPos, 130, 30)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetOnEvent(-1, "OnSettings")
$btnAbout = GUICtrlCreateButton("About", 155, $yPos, 130, 30)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetOnEvent(-1, "OnAbout")
HotKeySet("^1", "_PasteSlot0")
HotKeySet("^2", "_PasteSlot1")
HotKeySet("^3", "_PasteSlot2")
HotKeySet("^4", "_PasteSlot3")
HotKeySet("^5", "_PasteSlot4")
HotKeySet("^6", "_PasteSlot5")
HotKeySet("^7", "_PasteSlot6")
HotKeySet("^8", "_PasteSlot7")
HotKeySet("^9", "_PasteSlot8")
HotKeySet("^0", "_PasteSlot9")
_ApplyTheme()
GUISetState(@SW_SHOW)
While 1
Sleep(100)
WEnd
Func _ApplyTheme()
Local $bIsDark = True
Local $iSystemThemeVal = RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", "AppsUseLightTheme")
If @error Then $iSystemThemeVal = 0
If $iThemeMode = 2 Then
$bIsDark = False
ElseIf $iThemeMode = 1 Then
$bIsDark = True
Else
If $iSystemThemeVal = 1 Then
$bIsDark = False
Else
$bIsDark = True
EndIf
EndIf
If $bIsDark Then
$iBgColor = 0x1E1E1E
$iInputBgColor = 0x2D2D30
$iTextColor = 0xFFFFFF
$iLabelColor = 0xFFFFFF
$iAccentColor = 0x3498DB
Else
$iBgColor = 0xF3F3F3
$iInputBgColor = 0xFFFFFF
$iTextColor = 0x000000
$iLabelColor = 0x333333
$iAccentColor = 0x0078D7
EndIf
GUISetBkColor($iBgColor, $hGUI)
For $i = 0 To 9
GUICtrlSetColor($lblKeys[$i], $iLabelColor)
GUICtrlSetBkColor($inputs[$i], $iInputBgColor)
GUICtrlSetColor($inputs[$i], $iTextColor)
Next
EndFunc
Func _PasteText($iIndex)
Local $sText = GUICtrlRead($inputs[$iIndex])
If $sText = "" Then Return
Local $sOldClip = ClipGet()
ClipPut($sText)
Sleep(50)
Send("^v")
EndFunc
Func _PasteSlot0()
_PasteText(0)
EndFunc
Func _PasteSlot1()
_PasteText(1)
EndFunc
Func _PasteSlot2()
_PasteText(2)
EndFunc
Func _PasteSlot3()
_PasteText(3)
EndFunc
Func _PasteSlot4()
_PasteText(4)
EndFunc
Func _PasteSlot5()
_PasteText(5)
EndFunc
Func _PasteSlot6()
_PasteText(6)
EndFunc
Func _PasteSlot7()
_PasteText(7)
EndFunc
Func _PasteSlot8()
_PasteText(8)
EndFunc
Func _PasteSlot9()
_PasteText(9)
EndFunc
Func OnSettings()
GUISetState(@SW_DISABLE, $hGUI)
$hSettingsWin = GUICreate("Settings", 260, 270, -1, -1, $WS_POPUPWINDOW, $WS_EX_TOPMOST)
GUISetBkColor($iBgColor)
GUISetOnEvent($GUI_EVENT_CLOSE, "OnSettingsCancel")
GUICtrlCreateLabel("Theme Settings", 15, 15, 200, 20)
GUICtrlSetFont(-1, 11, 800, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
GUICtrlCreateGroup("", 15, 40, 230, 95)
GUICtrlSetColor(-1, $iLabelColor)
Local $sSys = "Dark"
Local $val = RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", "AppsUseLightTheme")
If $val = 1 Then $sSys = "Light"
$rbAuto = GUICtrlCreateRadio("", 30, 55, 20, 20)
GUICtrlSetBkColor(-1, $iBgColor)
$lblAuto = GUICtrlCreateLabel("Auto (System: " & $sSys & ")", 55, 57, 180, 20)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
GUICtrlSetOnEvent(-1, "ClickRbAuto")
$rbDark = GUICtrlCreateRadio("", 30, 80, 20, 20)
GUICtrlSetBkColor(-1, $iBgColor)
$lblDark = GUICtrlCreateLabel("Dark", 55, 82, 180, 20)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
GUICtrlSetOnEvent(-1, "ClickRbDark")
$rbLight = GUICtrlCreateRadio("", 30, 105, 20, 20)
GUICtrlSetBkColor(-1, $iBgColor)
$lblLight = GUICtrlCreateLabel("Light", 55, 107, 180, 20)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
GUICtrlSetOnEvent(-1, "ClickRbLight")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("General", 15, 145, 200, 20)
GUICtrlSetFont(-1, 11, 800, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
GUICtrlCreateGroup("", 15, 170, 230, 40)
GUICtrlSetColor(-1, $iLabelColor)
$cbSetOnTop = GUICtrlCreateCheckbox("", 30, 183, 20, 20)
GUICtrlSetBkColor(-1, $iBgColor)
GUICtrlSetOnEvent(-1, "ClickCbSetOnTop")
$lblSetOnTop = GUICtrlCreateLabel("Always on Top", 55, 185, 180, 20)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
GUICtrlSetOnEvent(-1, "ClickLblSetOnTop")
Local $currOnTop = IniRead($sIniFile, "Settings", "AlwaysOnTop", $GUI_UNCHECKED)
If $currOnTop = $GUI_CHECKED Then GUICtrlSetState($cbSetOnTop, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)
If $iThemeMode = 0 Then
GUICtrlSetState($rbAuto, $GUI_CHECKED)
ElseIf $iThemeMode = 1 Then
GUICtrlSetState($rbDark, $GUI_CHECKED)
Else
GUICtrlSetState($rbLight, $GUI_CHECKED)
EndIf
Local $btnSave = GUICtrlCreateButton("Save", 30, 230, 90, 25)
GUICtrlSetOnEvent(-1, "OnSettingsSave")
Local $btnCancel = GUICtrlCreateButton("Cancel", 140, 230, 90, 25)
GUICtrlSetOnEvent(-1, "OnSettingsCancel")
GUISetState(@SW_SHOW)
EndFunc
Func ClickLblSetOnTop()
If BitAND(GUICtrlRead($cbSetOnTop), $GUI_CHECKED) Then
GUICtrlSetState($cbSetOnTop, $GUI_UNCHECKED)
Else
GUICtrlSetState($cbSetOnTop, $GUI_CHECKED)
EndIf
EndFunc
Func ClickCbSetOnTop()
EndFunc
Func ClickRbAuto()
GUICtrlSetState($rbAuto, $GUI_CHECKED)
GUICtrlSetState($rbDark, $GUI_UNCHECKED)
GUICtrlSetState($rbLight, $GUI_UNCHECKED)
EndFunc
Func ClickRbDark()
GUICtrlSetState($rbDark, $GUI_CHECKED)
GUICtrlSetState($rbAuto, $GUI_UNCHECKED)
GUICtrlSetState($rbLight, $GUI_UNCHECKED)
EndFunc
Func ClickRbLight()
GUICtrlSetState($rbLight, $GUI_CHECKED)
GUICtrlSetState($rbAuto, $GUI_UNCHECKED)
GUICtrlSetState($rbDark, $GUI_UNCHECKED)
EndFunc
Func OnSettingsSave()
Local $newMode = 0
If BitAND(GUICtrlRead($rbDark), $GUI_CHECKED) Then $newMode = 1
If BitAND(GUICtrlRead($rbLight), $GUI_CHECKED) Then $newMode = 2
$iThemeMode = $newMode
IniWrite($sIniFile, "Settings", "ThemeMode", $newMode)
Local $newOnTop = BitAND(GUICtrlRead($cbSetOnTop), $GUI_CHECKED)
If $newOnTop = $GUI_CHECKED Then
WinSetOnTop($hGUI, "", 1)
IniWrite($sIniFile, "Settings", "AlwaysOnTop", $GUI_CHECKED)
Else
WinSetOnTop($hGUI, "", 0)
IniWrite($sIniFile, "Settings", "AlwaysOnTop", $GUI_UNCHECKED)
EndIf
_ApplyTheme()
OnSettingsCancel()
EndFunc
Func OnSettingsCancel()
GUIDelete($hSettingsWin)
GUISetState(@SW_ENABLE, $hGUI)
WinActivate($hGUI)
EndFunc
Func OnAbout()
GUISetState(@SW_DISABLE, $hGUI)
Local $iWidth = 350
Local $iHeight = 420
Local $hAboutWin = GUICreate("About", $iWidth, $iHeight, -1, -1, $WS_POPUPWINDOW, $WS_EX_TOPMOST)
GUISetBkColor($iBgColor)
GUISetOnEvent($GUI_EVENT_CLOSE, "OnAboutClose")
GUICtrlCreateLabel($sAppName, 0, 30, $iWidth, 35, 0x01)
GUICtrlSetFont(-1, 16, 800, 0, "Segoe UI")
GUICtrlSetColor(-1, $iAccentColor)
GUICtrlCreateLabel("Simple Clipboard Tool v1.0.0", 0, 65, $iWidth, 20, 0x01)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, 0x888888)
GUICtrlCreateLabel("", 40, 95, $iWidth - 80, 1)
GUICtrlSetBkColor(-1, 0x555555)
GUICtrlCreateLabel("This software is designed to speed up" & @CRLF & "your daily workflow efficiency.", 0, 110, $iWidth, 40, 0x01)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
Local $sFeatures = "10 Customizable Slots" & @CRLF & "Instant Hotkey Pasting" & @CRLF & "Smart Theme Detection" & @CRLF & "Portable & Lightweight"
GUICtrlCreateLabel($sFeatures, 0, 160, $iWidth, 80, 0x01)
GUICtrlSetFont(-1, 10, 800, 0, "Segoe UI")
GUICtrlSetColor(-1, $iTextColor)
GUICtrlCreateLabel("", 40, 250, $iWidth - 80, 1)
GUICtrlSetBkColor(-1, 0x555555)
GUICtrlCreateLabel("Developer: Eagle" & @CRLF & "Contact: trup40@protonmail.com", 0, 265, $iWidth, 40, 0x01)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, 0x888888)
GUICtrlCreateLabel("All Rights Reserved" & @CRLF & "© 2025", 0, 315, $iWidth, 40, 0x01)
GUICtrlSetFont(-1, 8, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, 0x888888)
Local $btnClose = GUICtrlCreateButton("Close",($iWidth - 100) / 2, 360, 100, 30)
GUICtrlSetOnEvent(-1, "OnAboutClose")
GUISetState(@SW_SHOW)
EndFunc
Func OnAboutClose()
GUIDelete(@GUI_WinHandle)
GUISetState(@SW_ENABLE, $hGUI)
WinActivate($hGUI)
EndFunc
Func OnMinimize()
GUISetState(@SW_HIDE, $hGUI)
EndFunc
Func OnRestore()
GUISetState(@SW_SHOW, $hGUI)
GUISetState(@SW_RESTORE, $hGUI)
WinActivate($hGUI)
EndFunc
Func OnExit()
For $i = 0 To 9
IniWrite($sIniFile, "Slots", "Slot" & $i, GUICtrlRead($inputs[$i]))
Next
Exit
EndFunc
