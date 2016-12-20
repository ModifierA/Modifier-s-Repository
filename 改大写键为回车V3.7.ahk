#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
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
version = V3.7

SWidth := A_ScreenWidth
;swidth := 1920
SWidth := SWidth/1366
gosub, TrayMenu
gosub, ini
return

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
#If

!+LButton::
	Send,{lbutton}
	Sleep,100
	send ^c
	sleep,200
	clipboard = %clipboard% 
	tooltip, %clipboard%
	sleep,500
	tooltip,
	
	Array1 := StrSplit(Clipboard, ".")
	j := Array1.length()-2
	i = 1
	str := Array1[1]

	Loop, %j%{
		i += 1
		var := "."Array1[i]
		str := str var
	}
	
	dir := str
	FileCreateDir, %dir%
return

$Space::
KeyWait, space
#If, Getkeystate("space", "p")
Space::
var =
Send, {space}
return

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
#If

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
Menu, tray, Default, 热键钩子
Menu, tray, Tip, %A_ScriptName%
return

ini:
IfNotExist, Adress.path
{
	IniWrite, 以上就是所有的记录了！, Adress.path, main, 
}
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
	IfExist, %A_Startup%\%scriptname%.lnk
	{
		MsgBox, 4160, 提示, 成功加入开机启动项！, 2
	}
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
Gui, Add, Picture, x%a1% y%a2% w%a3% h%a4% , backgroundpic\dasktop3.im
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
scriptname := A_ScriptName
scriptname := StrSplit(scriptname, `.)
j := scriptname.length()-2
i=1
str := scriptname[1]
Loop, %j%{
	i++
	var := "."scriptname[i]
	str := str var
}
scriptname := str
FileCreateShortcut, %A_ScriptFullPath%, %scriptname%.lnk
FileCopy, %scriptname%.lnk, %A_Startup%
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
ControlFocus, Static1, Look, 您已储存的热键：(“热键”-->“文件”)

return

lookbackok:
Gui, destroy
return
