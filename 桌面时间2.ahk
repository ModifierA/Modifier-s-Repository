#NoTrayIcon

CustomColor = cLime  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s32  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cLime, XXXXXXXXXXXXXX`n`n   ; XX & YY serve to auto-size the window.
; Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 160
SetTimer, UpdateTime, 1000
Gosub, UpdateTime  ; Make the first update immediate rather than waiting for the timer.
Gui, Show, x-20 y560 NoActivate  ; NoActivate avoids deactivating the currently active window.
return

UpdateTime:
GuiControl,, MyText, %A_Hour%:%A_Min%:%A_Sec%`n%A_Year%年%A_Mon%月%A_MDay%日`n%A_DDDD%
return








