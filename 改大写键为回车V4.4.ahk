#NoEnv
#SingleInstance, Force
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%", "%A_ScriptDir%"  ; Requires v1.0.92.01+
   ExitApp
}
SetWorkingDir, %A_ScriptDir%
SetWindelay,0
CoordMode,Mouse,Screen
SendMode, Input
;"SWidth" means the relative screen px 
;note.....
;a1 = x
;a2 = y
;a3 = width
;a4 = height
;like the formate
;a1 := swidth*-8
;a2 := swidth*-1
;a3 := SWidth*220
;a4 := swidth*310
;
softwareName = 改大写键为回车
version = V4.4
/***************************************************
以下为 printScreen 热键所用的数组初始化
*/
;ArrayWinTitle := Object()
;ArrayWinState := Object()
;***************************************************
; 快速创建热键的注册表写入部分
/*
*******************************************************************************
注册表路径 ：  HKEY_CLASSES_ROOT\Directory\shell\Modifier\command
              HKEY_CLASSES_ROOT\*\shell\Modifier\command
修改数据：	cmd /c echo %1 | clip && start C:\Users\dale\Documents\autoHotKeyScript\改大写键为回车\改大写键为回车V4.2\快速创建热键.exe

两处都得修改，分别是文件与文件夹。
*********************************************************************************
*/
RegRead, HOTKEY_REG, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, 改大写键为回车开机启动项
if(HOTKEY_REG != A_ScriptFullPath){	; means the software is not been registory to startup, maybe it's the first time to be run 
	HOTKEY_REG := "cmd /c echo %1 | clip && start " A_ScriptDir "\快速创建热键.exe"
	RegWrite, REG_SZ, HKEY_CLASSES_ROOT\Directory\shell\Modifier\command,, %HOTKEY_REG%
	RegWrite, REG_SZ, HKEY_CLASSES_ROOT\*\shell\Modifier\command,, %HOTKEY_REG%
	ToolTip, 组件注册成功
	SetTimer, RemoveTooltip, 1500
}
;***************************************************
SWidth := A_ScreenWidth
;swidth := 1920
SWidth := SWidth/1366
gosub, TrayMenu
gosub, ini

; 注册音乐播放控制器热键
; Music player Hotkey rigest
fn := Func("ProcessCheck")

Hotkey, if, % fn

Hotkey, NumpadLeft, FireNumpadLeft
Hotkey, NumpadRight, FireNumpadRight
Hotkey, NumpadClear, FireNumpadClear
Hotkey, NumpadUp, FireNumpadUp
Hotkey, NumpadDown, FireNumpadDown

;加入音乐播放器快捷键功能，关闭NumLock，
;	NumPadLeft --> 上一曲
;	NumPadRight --> 下一曲
;	NumPadClear(5) --> 暂停/播放

ProcessCheck()	{
	Process, Exist, cloudmusic.exe
	return ErrorLevel
}
FireNumpadLeft()	{
	SendInput, {Media_Prev}
}
FireNumpadRight()	{
	SendInput, {Media_Next}
}
FireNumpadClear()	{
	SendInput, {Media_Play_Pause}
}
FireNumpadUp()	{
	SendInput, ^!{NumpadAdd}
}
FireNumpadDown()	{
	SendInput, ^!{NumpadSub}
}

/* 以下这部分负责桌面显示正在播放的音乐名
*/
; the window you need to be detected title and the other attributes
global windows := "ahk_exe cloudmusic.exe ahk_class OrpheusBrowserHost"	
; wangyiyun ahk_exe and ahk_class
SetTimer, Update, 1500
return
/* 这部分是桌面显示正在播放的音乐名
*/
Update(){
	global
	; check the process of cloudmusic.exe, true if the wangyiyun
	; working, false if it does not working properly
	Process, Exist, cloudmusic.exe
	if IsEqualTemp(ErrorLevel, "ErrorLevel_temp")	{
		if ErrorLevel = 0
			Gui Music_show: show, hide
		else
			Gui Music_show: show, NoActivate
	}
	if ErrorLevel = 0		; if the music player is closed, doing the 
		return					; next is nonsense! So return
	; detect the music name if it has been changed?
	local Music_name := HiddenWindowsGetTitle(windows)
	; judge the monitor count
	SysGet, Monitor_count, MonitorCount
	if IsEqualTemp(Monitor_count, "Monitor_count_temp")	{
		if (Monitior_count = 1){
			Monitor_Width := A_ScreenWidth
		}
		else{
			SysGet, Mon2, Monitor, 2
			Monitor_Width := Mon2Right - Mon2Left
			Monitor_X := Mon2Left
		}
		Gui Music_show: destroy
		UI()
		GuiControl, Music_show:, MyText_1, %Music_name%
	}
	if IsEqualTemp(Music_name, "Music_name_temp")	{
		GuiControl, Music_show:, MyText_1, %Music_name%
	}
	if not HiddenWindowsGetExStyle(MusicDisplayPlatform_ID) & 0x8	{
		WinSet, AlwaysOnTop, On, %MusicDisplayPlatform_ID%
	}
}

IsEqualTemp(var, var_temp){		; judge if the value is changed?
	global											; var_temp is the name of a temp
	if (var != %var_temp%) {			; variable, don't make it the same
		%var_temp% := var				; variable with the other place
		return true								; var_temp is passed the string
	}
	else
		return false
}

HiddenWindowsGetExStyle(windows)	{
	DetectHiddenWindows, On
	WinGet, ExStyle, ExStyle, %windows%
	DetectHiddenWindows, Off
	return ExStyle
}

HiddenWindowsGetID(windows)	{
	DetectHiddenWindows, On
	WinGet, ID, ID, %windows%
	DetectHiddenWindows, Off
	return ID
}

HiddenWindowsGetTitle(windows)	{
	DetectHiddenWindows, On
	WinGetTitle, WinTitle, %windows%	; get the music name and player name
	DetectHiddenWindows, Off
	return WinTitle
}

UI(){
	global
	Gui_title = MusicDisplayPlatform_RandomID_0b2a3s3
	Gui Music_show: New, +lastfound +alwaysonTop +toolwindow -Caption, %Gui_title%
	Gui Music_show: color, FF0001
	WinSet, transcolor, FF0001 220
	WinSet, exstyle, +0x20
	Gui Music_show: font, s22 cRed, Arial
	if !Monitor_Width
		Monitor_Width := 1000
	Gui Music_show: add, text, x0 y0 w%Monitor_Width% r2 vMyText_1, Music Display Platform
	if !Monitor_X
		Monitor_X := 0
	if !Monitor_Y
		Monitor_Y := 0
	Gui Music_show:	Show, w%Monitor_Width% h75 x%Monitor_X% y%Monitor_Y%
	if A_IsCompiled
		local Gui_Name := Gui_title " ahk_class AutoHotkeyGUI ahk_exe " A_ScriptName
	else
		local Gui_Name := Gui_title " ahk_class AutoHotkeyGUI ahk_exe AutoHotkeyU64.exe"
	MusicDisplayPlatform_ID := "ahk_id " HiddenWindowsGetID(Gui_Name)
}

;ini_Read , once the ScrollLock, pageUp, pageDown is been activated,
; the program gets the windows .Position and scale to campare with
; mouse position for now from the "Window_Position.ini". That's for
; judging the mouse position if on the windows which have been changed
; status before.
IniRead_check:
MouseGetPos, varX, varY, WinID
;MsgBox, window %Wintitle% is at %winx% %winy%, width %winwidth% height %winheight%
IniRead, WindowsPos_Attributes, Window_Position.ini, WindowsPos_Attributes
if(WindowsPos_Attributes!=""){
	; windows_array_1 is under the WindowsPos_Attributes 
	windows_array_1 := StrSplit(WindowsPos_Attributes, "`n", "`r")
	loop, % windows_array_1.length(){

		windows_array_2 := StrSplit(windows_array_1[A_Index], "=")
		windows_array_3 := StrSplit(windows_array_2[2], ",")
		; windows_array_3[1] is the winPos_X
		; windows_array_3[2] is the winPos_Y
		; windows_array_3[3] is the winWidth
		; windows_array_3[4] is the winHeight
		; windows_rightside is the windows' right pixel Pos
		; windows_underside is the windows' underside pixel pos
		windows_rightside := windows_array_3[1]+windows_array_3[3]
		windows_underside := windows_array_3[2]+windows_array_3[4]
		if(varX>=windows_array_3[1]&&varX<=windows_rightside&&varY>=windows_array_3[2]&&varY<=windows_underside){
			; windows_array_2[1] is the Windows' ahk_id stored by win_ID
			win_ID := windows_array_2[1]
			IfWinExist, ahk_id %Win_ID%
			{
				WinGetTitle, winTitle, ahk_id %Win_ID%
				WinGet, win_transparent, Transparent, ahk_id %Win_ID%
				E_level := 1
				Return
			}
			else{
				; delete the ahk_id line which is out of time
				IniDelete, Window_Position.ini, WindowsPos_Attributes, %win_ID%
			}
		}
	}
}
/*
if(WindowsPos_Attributes=""){
	; for test
}
*/
if(WinID=""){
	E_level := 2       ; E_level := 2 means Error
	ToolTip, There is no window`nno window is under your mouse cursor!
	SetTimer, RemoveToolTip, 2000
	Return
}
WinGetPos, winX, winY, winWidth, winHeight, ahk_id %WinID%
WinGetTitle, winTitle, ahk_id %WinID%
WinGet, win_transparent, Transparent, ahk_id %WinID%
E_level := 0

Return

ScrollLock::
Gosub, IniRead_check
if(E_level=2){
	Return
}
if(E_level=1){   ; means the windows has been set to Exstyle 0x20
	IniDelete, Window_Position.ini, WindowsPos_Attributes, %win_ID%
	WinSet, AlwaysOnTop, Off, ahk_id %Win_ID%
	WinSet, ExStyle, -0x20, ahk_id %Win_ID%
	if(win_transparent=255){
		win_transparent := "Off"
		WinSet, Transparent, %win_transparent%, ahk_id %win_ID%
	}
	ToolTip, window: %Wintitle%`nTransparent: %win_transparent%`nstatus: Removed cursor_penetrate
	SetTimer, RemoveToolTip, 2000

}
if(E_level=0){
	; if is not true ,then the codes behind will be excuted
	WindowsPos_Attributes_value := winX "," winY "," winWidth "," winHeight
	;winID is the ahk_id got from the getmousePos functin
	;win_ID is the ahk_id got from the Window_Position.ini file
	;to avoid the conflict.
	IniWrite, %WindowsPos_Attributes_value%, Window_Position.ini, WindowsPos_Attributes, %winID%

	;WinGet, win_transparent, Transparent, ahk_id %WinID%
	if(win_transparent=""){
		WinSet, Transparent, 255, ahk_id %WinID%
		win_transparent := 255
	}
	WinSet, AlwaysOnTop, On, ahk_id %WinID%
	WinSet, ExStyle, +0x20, ahk_id %WinID%
	ToolTip, window: %Wintitle%`nTransparent: %win_transparent%`nstatus: Add cursor_penetrate
	SetTimer, RemoveToolTip, 2000
}

Return

PgUp::
Gosub, IniRead_check
if(E_level=2){
	Return
}
if(win_transparent=""){
	ToolTip, window: %Wintitle%`nTransparent: Off
	SetTimer, RemoveToolTip, 2000
	Return
}
;win_transparent:=win_transparent>=255 ? "Off" : win_transparent+=10

if(E_level=1){
	win_transparent:=win_transparent>=255 ? 255 : win_transparent+=10
	WinSet, Transparent, %win_transparent%, ahk_id %Win_ID%

}
if(E_level=0){
	win_transparent:=win_transparent>=255 ? "Off" : win_transparent+=10
	WinSet, Transparent, %win_transparent%, ahk_id %WinID%
}
ToolTip, window: %Wintitle%`nTransparent: %win_transparent%
SetTimer, RemoveToolTip, 2000
Return

PgDn::
Gosub, IniRead_check
if(E_level=2){
	Return
}
if(win_transparent=""){
	win_transparent := 255
}
;win_transparent:=win_transparent>=255 ? "Off" : win_transparent+=10
win_transparent:=win_transparent<=50 ? 50 : win_transparent-=10

if(E_level=1){
	;win_transparent:=win_transparent>=255 ? 255 : win_transparent+=10
	WinSet, Transparent, %win_transparent%, ahk_id %Win_ID%

}
if(E_level=0){
	;win_transparent:=win_transparent>=255 ? "Off" : win_transparent+=10
	WinSet, Transparent, %win_transparent%, ahk_id %WinID%
}
ToolTip, window: %Wintitle%`nTransparent: %win_transparent%
SetTimer, RemoveToolTip, 2000
Return

PrintScreen::
MouseGetPos,,, win
WinSet, alwaysontop, Toggle, ahk_id %win%
WinGetTitle, WinTitle, ahk_id %win%
WinGet, ExStyle, ExStyle, ahk_id %win%
if (ExStyle & 0x8){
	ToolTip, %WinTitle%`nHas been ＂ＳＥＴ ＴＯ＂ the top state
	SetTimer, RemoveToolTip, 2000
}
else{
	ToolTip, %WinTitle%`nHas been ＂ＣＡＮＣＬＥＤ＂ the top state
	SetTimer, RemoveToolTip, 2000
}
return

RemoveToolTip:
SetTimer, RemoveToolTip, off
ToolTip
return

#If not (mouseisover("ahk_class AutoHotkeyGUI ahk_exe DeskTop ShowV1.5.exe") or mouseisover("ahk_class AutoHotkeyGUI ahk_exe Monitor2.exe"))
^mbutton::
MouseGetPos,x,y,win
WinGetPos,x1,y1,,,ahk_id %win%
a=%x1%
b=%y1%
loop
{
MouseGetPos,x2,y2
c=%x2%
d=%y2%
c-=%x%
d-=%y%
a+=%c%
b+=%d%
x=%x2%
y=%y2%
WinMove,ahk_id %win%,,%a%,%b%
getkeystate,var,Mbutton,p
if var=U
return
Sleep,20
continue
}
return

Sys_ScrrenRange(){
	SysGet, MonitorCount, MonitorCount
	MinLeft = 0
	MinTop = 0
	Loop, % MonitorCount{
		SysGet, Mon%A_Index%, Monitor, %A_Index%
		; compare the top coordinates
		MinLeft := MinLeft > Mon%A_Index%Left ? Mon%A_Index%Left : MinLeft
		MaxRight := MaxRight < Mon%A_Index%Right ? Mon%A_Index%Right : MaxRight
		MinTop := MinTop > Mon%A_Index%Top ? Mon%A_Index%Top : MinTop
		MaxBottom := MaxBottom < Mon%A_Index%Bottom ? Mon%A_Index%Bottom : MaxBottom
	}	; it will return a string
	MaxWidth := MaxRight - MinLeft
	MaxHeight := MaxBottom - MinTop
	return_ := MaxWidth "," MaxHeight	; is splited by the "," character
	return return_
}

^RButton:: ;若要修改热键，此处应修改。 1/2（共2处）
MouseGetPos,mx1,my1, win
WinGetPos,winx,winy,winw,winh, ahk_id %win%
win_w_middle := winx + winw/2
win_h_middle := winy + winh/2
ScreenWidth := StrSplit(Sys_ScrrenRange(), ",")[1]	; is splited by the "," character
ScreenHeight := StrSplit(Sys_ScrrenRange(), ",")[2]
loop{
GetKeyState,varp,RButton,p ;若要修改热键，此处应修改。 2/2（共2处）
if varp=U
break
MouseGetPos,mx2,my2
if(mx1 >= win_w_middle){
	xx=% winw + mx2 - mx1
	win_move_x := winx
}
else{
	xx := winw + mx1 - mx2
	if(xx < ScreenWidth){
		win_move_x := winx + mx2 - mx1
	}
}
if(my1 >= win_h_middle){
	yy=% winh + my2 - my1
	win_move_y := winy
}
else{
	yy := winh + my1 - my2
	if(yy < ScreenHeight){
		win_move_y := winy + my2 - my1
	}
}
winmove,ahk_id %win%,,%win_move_x%,%win_move_y%,%xx%,%yy%
sleep,20
}
return

#if mouseisover("ahk_class Shell_SecondaryTrayWnd") or mouseisover("ahk_class Shell_TrayWnd")
wheelup::Volume_Up
WheelDown::Volume_Down
return 
mouseisover(wintitle){
	MouseGetPos,,,win
	return WinExist(wintitle . " ahk_id " . win)
}
#If

^+q::
Run, SnapShot.exe, %A_ScriptDir%, UseErrorLevel
If ErrorLevel=Error
	MsgBox, 0, ERROR, 组件异常，检查SnapShot.exe是否被更名或者删除
Return

$CapsLock::
KeyWait, CapsLock
If (A_PriorKey="CapsLock"){
	Send,{enter}
}
Return
#If, GetKeyState("CapsLock", "P")
w::Up
a::Left
s::Down
d::Right
e::Backspace
q::Send,^{Enter}
r::Delete

mouseisover_anotherClass(wintitle){		; because the conflict with mouseisover() up there
	MouseGetPos,,,win		; wintitle should be the ahk_class and ahk_exe
	WinGet, this_name, ProcessName, ahk_id %win%
	WinGetClass, this_class, ahk_id %win%
	judge := "ahk_class " this_class " ahk_exe " this_name
	if(wintitle = judge){
		return true
	}
	else{
		return false
	}
}

#If mouseisover("ahk_class CabinetWClass")
!LButton::
    Send, {lbutton}
    Sleep, 50
    KeyWait shift
    KeyWait alt
	send, ^c
	sleep, 200
	clipboardtemp = %clipboard% 
	if(InStr(Clipboardtemp, ":\")){
		Array1 := StrSplit(Clipboardtemp, ".")
		j := Array1.length()-2
		i = 1
		dir := Array1[1]
		Loop, %j%{
			i += 1
			var := "."Array1[i]
			dir := dir var
		}
		IfExist, %dir%
		{
			ToolTip, Have already exist, please check it!
			SetTimer, RemoveToolTip, 1500
		}
		else
		{
			tooltip, %clipboardtemp%
			SetTimer, RemoveTooltip, 1500
			FileCreateDir, %dir%
			FileMove, %clipboardtemp%, %dir%, 0
		}
	}
return
; 因为alt 和shift 一起按会切换美式键盘，所以屏蔽掉。
; 这是为了上面的部分
+Alt::
!Shift::
return
;**********************************************
#If

~Space::
var :=
return

#If Getkeystate("space", "p")
a::
var := var "a"
return

b::
var := var "b"
return

c::
var := var "c"
return

d::
var := var "d"
return

e::
var := var "e"
return

f::
var := var "f"
return

g::
var := var "g"
return

h::
var := var "h"
return

i::
var := var "i"
return

j::
var := var "j"
return

k::
var := var "k"
return

l::
var := var "l"
return

m::
var := var "m"
return

n::
var := var "n"
return

o::
var := var "o"
return

p::
var := var "p"
return

q::
var := var "q"
return

r::
var := var "r"
return

s::
var := var "s"
return

t::
var := var "t"
return

u::
var := var "u"
return

v::
var := var "v"
return

w::
var := var "w"
return

x::
var := var "x"
return

y::
var := var "y"
return

z::
var := var "z"
return

0::
var := var "0"
return

1::
var := var "1"
return

2::
var := var "2"
return

3::
var := var "3"
return

4::
var := var "4"
return

5::
var := var "5"
return

6::
var := var "6"
return

7::
var := var "7"
return

8::
var := var "8"
return

9::
var := var "9"
return

Numpad0::
var := var "0"
return

Numpad1::
var := var "1"
return

Numpad2::
var := var "2"
return

Numpad3::
var := var "3"
return

Numpad4::
var := var "4"
return

Numpad5::
var := var "5"
return

Numpad6::
var := var "6"
return

Numpad7::
var := var "7"
return

Numpad8::
var := var "8"
return

Numpad9::
var := var "9"
return

NumpadEnter::
Enter::
CapsLock::
if(var != ""){
	IniRead, exePath, Adress.path, main, %var%
	if(exePath = "error"){
		SetTimer, ChangeButtonNames, 10
		MsgBox, 4163, 提示, 系统未找到目标程式！请检查操作并重新输入或者点击“取消”来创建目标程式，点击“帮助”查看已创建的热键`n（您也可以在任何时候按下“空格”和“=”键来创建新的热键）
		IfMsgBox, no
			goto, add
		else
			IfMsgBox, Cancel
				goto, lookback
		return
	}
	else{
		;this scriptname means the exePath
		scriptname := exePath
		scriptname := StrSplit(scriptname, "\")
		j := scriptname.length()-2
		i=1
		str := scriptname[1]
		Loop, %j%{
			i++
			var := "\"scriptname[i]
			str := str var
		}
		workingdir := str
		Run, %exePath%, %workingdir%, UseErrorLevel
		if ErrorLevel = Error
			MsgBox, 4160, 提示, 不能运行该文件，请检查文件是否存在！`n可能是找不到与该文件关联的程序！
		return
	}
}
return

=::
goto, Add
return
; 空格加上F10 暂停热键或者开始热键
F10::
Suspend
if(ac=%ac%){
	tips=关闭
	ac=ad
}
else{
	tips=打开
	ac=ac
}
SetTimer, tooltip1, on
return
#If

tooltip1:
SetTimer, tooltip1, off
ToolTip, 您已经%tips%了热键服务！
Sleep, 2000
ToolTip,
return

ChangeButtonNames:
IfWinNotExist, 提示, 系统未找到目标程式！请检查操作并重新
    return  ; Keep waiting.
SetTimer, ChangeButtonNames, off 
WinActivate 
ControlSetText, Button1, 确定 
ControlSetText, Button2, 取消
ControlSetText, button3, 帮助
return

Add:
Gui, destroy
a5 := swidth*9
Gui, font, s%a5%
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*640
a4 := swidth*380
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\cover.im
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*633
a4 := swidth*382
Gui, Show, w%a3% h%a4%, 热键钩子  制作者：modifier，版本：%version%
Sleep, 2000
Gui, destroy
a5 := swidth*9
Gui, font, s%a5%
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*650
a4 := swidth*430
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\defineKey.im
a1 := swidth*282
a2 := swidth*399
a3 := SWidth*100
a4 := swidth*20
Gui, Add, Edit, x%a1% y%a2% w%a3% h%a4% vHotKey Uppercase,
a1 := swidth*522
a2 := swidth*389
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% gnext, 下一步
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*645
a4 := swidth*432
Gui, Show, w%a3% h%a4%, 定义热键  制作者：modifier，版本：%version%
;SetTimer, capslockon, 50
return
/*
CapsLockon:
IfWinActive, 定义热键  制作者：modifier，版本：%version%, 下一步
{
	SetCapsLockState, on
}
return
*/
GuiClose:
Gui, destroy
return
/*
CapsLockoff(){
	SetTimer, capslockon, Off
	SetCapsLockState, off
}
*/
next:
var1=
GuiControlGet, var1,, HotKey
if(var1 = ""){
	MsgBox, 4160, 提示, 您还没有输入任何热键！
}
else{
	IniRead, allKey, Adress.path, main
	Array := strsplit(allKey, "`n", "`r")
	i=0
	Loop, % array.length(){
		i++
		arrstr := StrSplit(Array[i], "=")
		if(var1 = arrstr[1]){
			MsgBox, 4129, 提示, 您输入的热键已存在`n是否希望覆盖上一个`n设置？
			IfMsgBox, Cancel
			return
			break
		}
	}
	var2=
	Gui, destroy
	a1 := swidth*-8
	a2 := swidth*-1
	a3 := SWidth*640
	a4 := swidth*410
	Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\selectfile.im
	a5 := swidth*9
	Gui, font, s%a5%
	a1 := swidth*12
	a2 := swidth*419
	a3 := SWidth*100
	a4 := swidth*40
	Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 作者：modifier`n`n版本：%version%
	a1 := swidth*122
	a2 := swidth*419
	a3 := SWidth*390
	a4 := swidth*20
	Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 最后一步了，单击“选择文件路径”选择您想要打开的文件路径
	a1 := swidth*522
	a2 := swidth*429
	a3 := SWidth*100
	a4 := swidth*20
	Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% gSelectFile, 选择文件
	a1 := swidth*522
	a2 := swidth*409
	a3 := swidth*100
	a4 := swidth*20
	Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% gSelectFolder, 选择文件夹
	a1 := swidth*122
	a2 := swidth*439
	a3 := SWidth*390
	a4 := swidth*30
	Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% vFilePath, 文件(夹)路径：
	a1 := swidth*522
	a2 := swidth*449
	a3 := SWidth*100
	a4 := swidth*20
	Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% gOK, 确定
	; Generated using SmartGUI Creator for SciTE
	a1 := swidth*-8
	a2 := swidth*-1
	a3 := SWidth*634
	a4 := swidth*473
	Gui, Show, w%a3% h%a4%, 选择文件  制作者：modifier，版本：%version%
}
return

SelectFile:
FileSelectFile, var2
GuiControl,, FilePath, 文件路径：%var2%
return

SelectFolder:
FileSelectFolder, var2
GuiControl,, FilePath, 文件夹路径：%var2%
return

OK:
if(var2 = ""){
	MsgBox, 4129, 提示, 您没有选择任何文件`n确定要退出？
	IfMsgBox, Cancel
	return
	Gui, destroy
}
else{
	Gui, destroy
	;lable "add" will return two varities: var1. Key; var2. aimed shellexecute path.
	
	IniWrite, %var2%, Adress.path, main, %var1%
	MsgBox, 4160, 提示, 热键创建成功！, 2
}
return

TrayMenu:
Menu, Tray, NoStandard
Menu, tray, DeleteAll
Menu, tray, Add, 热键钩子, About
Menu, tray, add,
Menu, tray, add, 添加新的热键, Add
Menu, tray, add, 设置, setting
Menu, tray, add, 帮助, lookback
Menu, tray, add, 退出, Exit
Menu, tray, add, 重启软件, Reboot
Menu, tray, Default, 热键钩子
Menu, tray, Tip, %A_ScriptName%
return

ini:
IfNotExist, Adress.path
{
	IniWrite, 以上就是所有的记录了！, Adress.path, main, 
}
return

Reboot:
Reload
return

About:
Gui, destroy
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*220
a4 := swidth*310
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\About.im
a5 := swidth*11
Gui, font, s%a5%
a1 := swidth*212
a2 := swidth*-1
a3 := Swidth*190
a4 := swidth*310
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , `n`n软件作者：modifier`n`n版本：%version%`n`n  Nothing is impossible to a willing heart`n`n  Do whatever you can and never give up`n`n`n`n`n        ······That's what I want to say to myself, be the greater one!
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*404
a4 := swidth*309
Gui, Show, w%a3% h%a4%, 关于作者

return

Exit:
ExitApp
return

setting:
Gui, destroy
a5 := swidth*9
Gui, font, s%a5%
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*680
a4 := swidth*420
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\setting.im
a1 := swidth*32
a2 := swidth*429
a3 := SWidth*170
a4 := swidth*30
Gui, Add, CheckBox, x%a1% y%a2% w%a3% h%a4% gcheck, 把软件加入开机启动项
a=a
a1 := swidth*32
a2 := swidth*459
a3 := SWidth*400
a4 := swidth*60
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4%, （把软件加入开机启动项之后，它就是您打开文件的一个小工具，您的桌面可以完全解放出来，桌面只用放上一个回收站或者经常使用的文档，作业等等，而打开程序只需要按键combo就能搞定。软件没有酷炫的效果，但是在低调之中带给了用户一丝丝便捷，轻松！）
a1 := swidth*442
a2 := swidth*429
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% gconfirm, 确定
a1 := swidth*442
a2 := swidth*469
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% ggoon, 继续
a1 := swidth*552
a2 := swidth*429
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 点击“确定”保存设置
a1 := swidth*552
a2 := swidth*469
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 点击“继续”查看您的桌面！
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*670
a4 := swidth*520
Gui, Show, w%a3% h%a4%, 设置

return

check:
;a means the situation of checkbox
;a means being unchoosed
;b means being choosed
if(a=%a%){
	a=b
}
else{
	a=a
}
return

confirm:
if(a="b"){
	gosub, startup
	MsgBox, 4160, 提示, 成功加入开机启动项！, 2
}
Gui, destroy
return

goon:
Gui, destroy
a5 := swidth*9
Gui, font, s%a5%
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*1100
a4 := swidth*580
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\desktop3.im
a1 := swidth*12
a2 := swidth*589
a3 := SWidth*940
a4 := swidth*50
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 如果您的桌面像这样！！！我们可以让它变得更整洁,点击“继续”查看变化。
a1 := swidth*962
a2 := swidth*589
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% ggoon2, 继续
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*1092
a4 := swidth*626
Gui, Show, w%a3% h%a4%, 

return

goon2:
Gui, destroy
a5 := swidth*9
Gui, font, s%a5%
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*1000
a4 := swidth*660
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\desktop2.im
a1 := swidth*12
a2 := swidth*669
a3 := SWidth*770
a4 := swidth*20
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 可以让它变成这样！清爽了许多！或者点击“继续”看看没有回收站的样子
a1 := swidth*842
a2 := swidth*664
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% ggoon3, 继续
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*993
a4 := swidth*700
Gui, Show, w%a3% h%a4%, 

return

goon3:
Gui, destroy
a5 := swidth*9
Gui, font, s%a5%
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*960
a4 := swidth*660
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\desktop.im
a1 := swidth*12
a2 := swidth*669
a3 := SWidth*730
a4 := swidth*30
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 是不是感觉不错呢！
a1 := swidth*802
a2 := swidth*664
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% gsetting, 确定
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*953
a4 := swidth*700
Gui, Show, w%a3% h%a4%, 

return

;add itself to startup file
startup:
;scriptname := A_ScriptName
;HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
RegWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, 改大写键为回车开机启动项, %a_scriptfullpath%
return

;create a listview for the user could see what they have saved clearly
lookback:
Gui, destroy
a5 := swidth*9
Gui, font, s%a5%
IniRead, lookBacklist, Adress.path, main
StringReplace, lookbacklist, lookbacklist, =, %a_space%-->%A_Space%, all
StringReplace, lookbacklist, lookbacklist, `n, `n`n, all
a1 := swidth*2
a2 := swidth*9
a3 := SWidth*600
a4 := swidth*20
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% +Left, 您已储存的热键：(“热键”-->“文件”)
a1 := swidth*2
a2 := swidth*39
a3 := SWidth*600
a4 := swidth*310
Gui, Add, Edit, x%a1% y%a2% w%a3% h%a4% vlookbackedit,
GuiControl,, lookbackedit, %lookbacklist%
a1 := swidth*482
a2 := swidth*359
a3 := SWidth*100
a4 := swidth*30
Gui, Add, Button, x%a1% y%a2% w%a3% h%a4% glookbackok vlookbackok, 确定
a1 := swidth*12
a2 := swidth*359
a3 := SWidth*450
a4 := swidth*30
Gui, Add, Text, x%a1% y%a2% w%a3% h%a4% , 建议您使用与文件相关联的数字和字母作为热键，更容易记忆。比如：网易云，热键“WYY”；360浏览器，热键“36”或者“360L”；360杀毒，热键“360S”等等
; Generated using SmartGUI Creator for SciTE
a1 := swidth*-8
a2 := swidth*-1
a3 := SWidth*607
a4 := swidth*402
Gui, Show, w%a3% h%a4%, Look
ControlFocus, Button1, Look ahk_class AutoHotkeyGUI ahk_exe %A_ScriptName%

return

lookbackok:
Gui, destroy
return