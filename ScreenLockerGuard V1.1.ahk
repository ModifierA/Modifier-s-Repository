#NoTrayIcon
#SingleInstance, force
SetWorkingDir, %A_ScriptDir%
SavedDATAini=SavedDATA.data
gosub, INI
SCREENLOCKER := "screenlocker" A_Space version
CustomColor = cLime
scale := A_ScreenHeight/A_ScreenWidth
offset_x:=50
offset_y:=-50
PIC_W := 900
PIC_H := PIC_W*scale

Hotkey, IfWinActive, 1
Hotkey, enter, enter
Hotkey, esc, esc
Hotkey, IfWinActive, 2
Hotkey, enter, enter
Hotkey, esc, esc
Hotkey, IfWinActive, 3
Hotkey, enter, enter
Hotkey, esc, esc
Hotkey, IfWinActive, 4
Hotkey, enter, enter
Hotkey, esc, esc
Hotkey, IfWinActive, 5
Hotkey, enter, enter
Hotkey, esc, esc

IfWinNotExist, ScreenLockerMain
{
	gosub, GUI
	SetTimer, UpdateOSD, 20
}
else
{
	SetTimer, CHECKING, on
}
return

GUI:
Gui 1: new,, 1
Gui 1: +LastFound -Caption
Gui 1: color, %customcolor%
Gui 1: add, picture, x0 y0 w%PIC_W% h%PIC_H%, BackgroundPic\shield-1.ee
Gui 1: Font, s20, verdana
Gui 1: add, text, r1 x815 y10 cWhite g1Text1, －
Gui 1: add, text, r1 x869 y10 cWhite g1Text2, X
WinSet, transcolor, %customcolor% 255
Gui 1: show, w%PIC_W% h%PIC_H%
Gui 3: new,,3
Gui 3: +lastfound +owner1 +AlwaysOnTop -caption
Gui 3: Color, black
WinSet, trans, 200
WinSet, alwaysontop, off
w:=350
y:=pic_h/2+100+offset_y
x:=pic_w/2+55
Gui 3: show, x%x% y%y% w%w% h100
Gui 2: new,, 2
Gui 2: +lastfound +owner3 +AlwaysOnTop -Caption
Gui 2: color, %customcolor%
w:=200
x:=(pic_w-w)/2+offset_x
y:=pic_h/2+offset_y
Gui 2: font, s15, bold
Gui 2: add, edit, r1 x%x% y%y% w%w% cLime Center vMyUSER1 Password*, ******
y:=y+40
Gui 2: add, edit, r1 x%x% y%y% w%w% cLime Center vMyPASSWORD1 Password*, ******
WinSet, transcolor, %customcolor% 1
WinSet, alwaysontop, off
Gui 2: show, w%pic_w% h%pic_h%
Gui 4: new,,4
Gui 4: +lastfound +owner3 +alwaysontop -caption
Gui 4: color, %customcolor%w:=600
offset_this:=-56
x:=(pic_w-w)/2
y:=pic_h/2+offset_this
Gui 4: font, s15, verdana bold
Gui 4: add, text, r1 x%x% y%y% w%w% cRed Center Hidden v4Text_1, WARNING
Gui 4: add, text, r1 x%x% y%y% w%w% cMaroon Center Hidden v4Text0, WARNING
w:=600
x:=(pic_w-w)/2
y:=pic_h/2+offset_this+30
Gui 4: font, s18, Lucida Console
Gui 4: add, text, r2 x%x% y%y% w%w% cLime Center Hidden v4Text1, REMEMBER THE PASSWORD`nSET SUCCESSFULLY
w:=60
x:=(pic_w-w)/2-80
y:=pic_h/2+offset_this+60
Gui 4: add, text, r1 x%x% y%y% cTeal Center Hidden V4TEXT5, [YES]
x:=(pic_w-w)/2+80
Gui 4: add, text, r1 x%x% y%y% cTeal Center Hidden V4TEXT6, [NO]
w:=600
x:=(pic_w-w)/2
y:=pic_h/2-240
Gui 4: font, s18, bold
Gui 4: add, text, r1 x%x% y%y% w%w% cLime Center v4text2, WELCOME TO THE REGISTER SYSTEM
w:=200
x:=(pic_w-w)/2+offset_x
y:=pic_h/2+offset_y
Gui 4: font, s15, bold
Gui 4: add, text, r1.3 x%x% y%y% w%w% cLime Border Center vMyUSER2, ******
y:=y+40
Gui 4: add, text, r1.3 x%x% y%y% w%w% cLime Border Center vMyPASSWORD2, ******
w:=200
x:=(pic_w-w)/2-110+offset_x
y:=pic_h/2+offset_y
Gui 4: add, text, r1 x%x% y%y% cLime v4text3, USER ID :
y:=y+40
Gui 4: add, text, r1 x%x% y%y% cLime v4text4, PASSWORD:
WinSet, transcolor,  %customcolor% 255
WinSet, alwaysontop, off
Gui 4: show, w%pic_w% h%pic_h%
Gui 5: new,, 5
Gui 5: +lastfound +owner4 +AlwaysOnTop -caption
w:=60
x:=1
y:=1
Gui 5: font, s18, Lucida Console
Gui 5: add, text, r1 x%x% y%y% g5text1, [YES]
x:=x+160
Gui 5: add, text, r1 x%x% y%y% g5text2, [NO]
WinSet, trans, 1
WinSet, alwaysontop, off
w:=60
x:=(pic_w-w)/2+152
y:=pic_h/2+offset_this+175
Gui 5: show, x%x% y%y%
Gui 5: hide
GuiControl, 2:focus, MyUSER1
return

enter:
if(error1 = 1){
	GuiControl, 4:Show, MyUSER2
	GuiControl, 4:Show, MyPASSWORD2
	GuiControl, 4:Show, 4text3
	GuiControl, 4:Show, 4text4
	GuiControl, 2:Show, MyUSER1
	GuiControl, 2:Show, MyPASSWORD1
	GuiControl, 4:Hide, 4text1
	GuiControl, 4:Hide, 4text0
	GuiControl, 4:Hide, 4text_1
	SetTimer, FLASH1, Off
	error1=0	
	return
}
if(error2 = 1){
	GuiControl, 4:, 4text1, START LOCKING COMPUTER?`n 
	GuiControl, 4:Show, 4text5
	GuiControl, 4:Show, 4text6
	WinShow, 5
	error2=0
	error3=1
	return
}
if(error3 = 1){
	Run, %SCREENLOCKER%,, useerrorlevel
	if errorlevel = error
	{
		MsgBox, ＰＬＥＡＳＥ　ＤＯＮ＇Ｔ　ＤＥＬＥＴＥ　ＡＮＹＴＨＩＮＧ　ＯＦ　ＴＨＥ　ＡＰＬＩＣＡＴＩＯＮ，　ＩＴ＇Ｓ　Ａ　ＳＹＳＴＥＭ　ＡＮＤ　ＷＥ　ＣＡＮ　ＮＯＴ　ＲＵＮ　ＴＨＥ　ＳＣＲＥＥＮＬＯＣＫＥＲ　ＮＯＷ！
		return
	}
	else
	{
		GuiControl, 4:Hide, 4text5
		GuiControl, 4:Hide, 4text6
		GuiControl, 4:, 4text1, COMMAND ACCEPTED`nSTART LOCKING
		Sleep, 1000
		Gui, destroy
		SetTimer, CHECKING, On
		return
	}
}
if(MY_USERID = ""||MY_PASSWORD = ""){
	GuiControl, 4:hide, MyUSER2
	GuiControl, 4:hide, MyPASSWORD2
	GuiControl, 4:hide, 4text3
	GuiControl, 4:hide, 4text4
	GuiControl, 2:hide, MyUSER1
	GuiControl, 2:hide, MyPASSWORD1
	GuiControl, 4:, 4text1, THE USER ID OR PASSWORD`nCAN NOT BE NULL
	GuiControl, 4:, 4text_1, WARNING
	GuiControl, 4:show, 4text1
	GuiControl, 4:show, 4text_1
	SetTimer, FLASH1, on
	error1=1
}
else{
	if(MY_USERID = "******"||MY_PASSWORD = "******"){
		GuiControl, 4:hide, MyUSER2
		GuiControl, 4:hide, MyPASSWORD2
		GuiControl, 4:hide, 4text3
		GuiControl, 4:hide, 4text4
		GuiControl, 2:hide, MyUSER1
		GuiControl, 2:hide, MyPASSWORD1
		GuiControl, 4:, 4text1, YOUR ID DOES NOT CHANGED`nID IS THE SAME OLD
		GuiControl, 4:show, 4text1
		GuiControl, 4:, 4text_1, TIPS
		GuiControl, 4:show, 4text_1
	}
	else{	
		saveit1 := EnCode(MY_USERID)
		saveit2 := EnCode(MY_PASSWORD)
		IniWrite, %saveit1%, %SavedDATAini%, main, 1
		IniWrite, %saveit2%, %SavedDATAini%, main, 2
		GuiControl, 4:hide, MyUSER2
		GuiControl, 4:hide, MyPASSWORD2
		GuiControl, 4:hide, 4text3
		GuiControl, 4:hide, 4text4
		GuiControl, 2:hide, MyUSER1
		GuiControl, 2:hide, MyPASSWORD1
		GuiControl, 4:, 4text1, REMEMBER THE PASSWORD`nSET SUCCESSFULLY
		GuiControl, 4:show, 4text1
		GuiControl, 4:, 4text_1, TIPS
		GuiControl, 4:show, 4text_1
	}	
	error2=1
}
return

Esc:
if(error3 = 1){
	GuiControl, 4:Show, MyUSER2
	GuiControl, 4:Show, MyPASSWORD2
	GuiControl, 4:Show, 4text3
	GuiControl, 4:Show, 4text4
	GuiControl, 2:Show, MyUSER1
	GuiControl, 2:Show, MyPASSWORD1
	GuiControl, 4:Hide, 4text1
	GuiControl, 4:Hide, 4text_1
	GuiControl, 4:Hide, 4text5
	GuiControl, 4:Hide, 4text6
	WinHide, 5
	error2=0
	error3=0	
	return
}
return

INI:
IfExist, %SavedDATAini%
{
	IniRead, version, %SavedDATAini%, main, 4, default
}
else
{
	MsgBox, ＩＦ　ＹＯＵ　ＨＡＶＥ　ＤＥＬＥＴＥＤ　ＴＨＥ　＂ＳＡＶＥＤＤＡＴＡ．ＤＡＴＡ＂？　ＰＬＥＡＳＥ　ＴＲＹ　ＴＯ　ＤＯＷＮＬＯＡＤ　ＩＴ　ＦＲＯＭ　ＷＨＥＲＥ　ＩＴ　ＣＯＭＥＳ．
	ExitApp
}
return

CHECKING:
IfWinNotExist, ScreenLockerMain
{
	Run, %SCREENLOCKER%,, useerrorlevel
}
return

FLASH1:
GuiControl, 4:show, 4text0
Sleep, 400
GuiControl, 4:Hide, 4text0
Sleep, 400
return

UpdateOSD:
GuiControlGet, var1, 2:, MyUSER1
GuiControlGet, var2, 2:, MyPASSWORD1
IfWinExist, 4
{
	if(index < 4){
		index++
	}
}
if(var1 != MY_USERID||var2 != MY_PASSWORD||index<3){
	/*
	Count := StrLen(var2)
	var3 = 
	Loop, % Count{
		var3 := var3 "*"
	}
	*/
	GuiControl, 4:, MyUSER2, %var1%
	GuiControl, 4:, MyPASSWORD2, %var2%
	MY_USERID := var1
	MY_PASSWORD := var2
}
return

1Text1:
WinMinimize
return

1Text2:
ExitApp
return

5text1:
gosub, enter
return

5text2:
gosub, esc
return

EnCode(StringToEnCode){
	code1=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz~!@#$^&*()_+{}|:<>?-=[]\;',.%A_Space%/
	code2=12Q3WA4ESZ5RDX6TFC7YGV8UHB9IJN0OKMPLpolikujmyhntgbr/.,';\][=-?><:|{}+_)(*&^$#@!~fvedcwsxqa%A_Space%z
	Str_len := StrLen(StringToEnCode)	
	temp_str := SubStr(stringtoencode, 2, str_len-1)
	stringtoencode := temp_str SubStr(stringtoencode, 1, 1)
	if(Mod(str_len, 2) != 0){
		k := Ceil(str_len/2)
		temp_str := SubStr(stringtoencode, k, k)
		stringtoencode := temp_str SubStr(stringtoencode, 1, k-1)
	}
	else{
		k := str_len/2
		temp_str := SubStr(stringtoencode, k+1, k)
		stringtoencode := temp_str SubStr(stringtoencode, 1, k)
	}
	i=0
	Loop, % str_len{
		i++
		Pos := InStr(code1, substr(stringtoencode, i, 1), true, 1, 1)
		temp_str := SubStr(code2, pos, 1)
		encode_str := encode_str temp_str
	}
	StringReplace, encode_str, encode_str, %a_space%, `%, all
	return encode_str
}
