#NoTrayIcon
#SingleInstance, force
SetWorkingDir, %A_ScriptDir%
ADMINISTRATOR := DeCode("yk,Driyu")
AD_PASSWORD := DeCode("QCWWXR6Q5WC.\IJ9M=yba:7")
SavedDATAini=SavedDATA.data
gosub, INI
screenlockerguard:="screenlockerguard" A_Space version
SetTimer, FOCUSON1, On
SetTimer, CHECKING, on
CustomColor = cLime
ScreenWidth := A_ScreenWidth*5
ScreenHeight := A_ScreenHeight*5
Gui MAINGUI: new,, ScreenLockerMain
Gui MAINGUI: +LastFound +ToolWindow +AlwaysOnTop -Caption
distanceX := 75
distanceY := -50
LW_w = 400
LW_x := (ScreenWidth-LW_w)/2
LW_y := ScreenHeight/2
LW_x := LW_x+distanceX
LW_y := LW_y+distanceY
Gui MAINGUI: Font, s20
Gui MAINGUI: add, edit, x%LW_x% y%LW_y% w%LW_w% r1 cLime vMyUSER1 Center Hidden Password*, **********
LW_w = 400
LW_x := (ScreenWidth-LW_w)/2
LW_y := ScreenHeight/2+50
LW_x := LW_x+distanceX
LW_y := LW_y+distanceY
Gui MAINGUI: add, Edit, x%LW_x% y%LW_y% w%LW_w% r1 cLime vMyPASSWORD1 Center Hidden Password*, **********
WinSet, Trans, 1
Gui MAINGUI: Show, w%ScreenWidth% h%ScreenHeight%
Gui LoginBG2: new,, LoginBG2
Gui LoginBG2: +lastfound +toolwindow +AlwaysOnTop -Caption
Gui LoginBG2: Color, Black
WinSet, trans, 200 
LW_x := 55
LW_y := 55
Gui LoginBG2: Show, x%LW_x% y%LW_y% w200 h50
Gui MAINGUISIGN: new,, SIGN
Gui MAINGUISIGN: +lastfound +toolwindow +alwaysontop -caption
Gui MAINGUISIGN: color, %CustomColor%
Gui MAINGUISIGN: font, s20 verdana bold
Gui MAINGUISIGN: add, Text, r1 cLime vMyTextSIGN, MODE:LOCKED
WinSet, transcolor, %CustomColor% 150
Gui MAINGUISIGN: show, x50 y50
return

Esc::
IfWinNotExist, LoginWindow1
{
	index=1
	SetTimer, FLASH2, off
	SetTimer, UpdateOSD, 20
	GuiControl, MAINGUI:Show, MyUSER1
	GuiControl, MAINGUI:Show, MyPASSWORD1
	Gui LoginBG: new,, LoginBG
	Gui LoginBG: +lastfound +toolwindow +AlwaysOnTop -Caption
	Gui LoginBG: Color, Black
	WinSet, trans, 200 
	LW_x := 300
	LW_y := 335
	LW_x := LW_x+distanceX
	LW_y := LW_y+distanceY
	Gui LoginBG: Show, x%LW_x% y%LW_y% w635 h150
	Gui LoginWindow: new,, LoginWindow1
	Gui LoginWindow: +lastfound +ToolWindow +AlwaysOnTop -Caption
	Gui LoginWindow: color, %CustomColor%
	LW_w = 1000
	LW_x := (ScreenWidth-LW_w)/2
	LW_y := ScreenHeight/2-50
	Gui LoginWindow: Font, s40, Verdana bold
	Gui LoginWindow: Add, Text, x%LW_x% y%LW_y% w%LW_w% r2 cLime vMyText1 Center Hidden, ACCESS ACCEPTED
	Gui LoginWindow: Add, Text, x%LW_x% y%LW_y% w%LW_w% r2 cTeal vMyText11 Center Hidden, ACCESS ACCEPTED
	Gui LoginWindow: Add, Text, x%LW_x% y%LW_y% w%LW_w% r2 cRed vMyText2 Center Hidden, ACCESS DENIED
	Gui LoginWindow: Add, Text, x%LW_x% y%LW_y% w%LW_w% r2 cMaroon vMyText22 Center Hidden, ACCESS DENIED
	WinSet, TransColor, %CustomColor% 255
	Gui LoginWindow: Show, w%ScreenWidth% h%ScreenHeight%
	Gui LoginWindow2: new,, LoginWindow2
	Gui LoginWindow2: +lastfound +ToolWindow +AlwaysOnTop -Caption
	Gui LoginWindow2: color, %CustomColor%
	LW_w = 400
	LW_x := (ScreenWidth-LW_w)/2
	LW_x := LW_x+distanceX
	LW_y := ScreenHeight/2+50
	LW_y := LW_y+distanceY
	Gui LoginWindow2: Font, s20 bold
	Gui LoginWindow2: add, Text, x%LW_x% y%LW_y% w%LW_w% r1.3 cLime vMyPASSWORD2 Border Center, **********
	LW_w = 400
	LW_x := (ScreenWidth-LW_w)/2
	LW_x := LW_x+distanceX
	LW_y := ScreenHeight/2
	LW_y := LW_y+distanceY
	Gui LoginWindow2: add, Text, x%LW_x% y%LW_y% w%LW_w% r1.3 cLime vMyUSER2 Border Center, **********
	LW_w = 400
	LW_x := (ScreenWidth-LW_w)/2-140
	LW_x := LW_x+distanceX
	LW_y := ScreenHeight/2
	LW_y := LW_y+distanceY
	Gui LoginWindow2: Add, Text, x%LW_x% y%LW_y% r1 cLime, USER ID :
	LW_w = 400
	LW_x := (ScreenWidth-LW_w)/2-140
	LW_x := LW_x+distanceX
	LW_y := ScreenHeight/2+50
	LW_y := LW_y+distanceY
	Gui LoginWindow2: Add, Text, x%LW_x% y%LW_y% r1 cLime, PASSWORD:
	WinSet, TransColor, %CustomColor% 255
	Gui LoginWindow2: Show, w%ScreenWidth% h%ScreenHeight%
}
return

CHECKING:
Process, exist, %screenlockerguard%
if(errorlevel != 0){
	index2=0
	return
}
else{
	if(index2<1){
		index2++
		Run, %screenlockerguard%,, useerrorlevel
	}
	if useerrorlevel = error
	{
		Run, %screenlockerguard%,, useerrorlevel
	}
}
return

UpdateOSD:
GuiControlGet, var1, MAINGUI:, MyUSER1
GuiControlGet, var2, MAINGUI:, MyPASSWORD1
IfWinExist, LoginWindow2
{
	if(index < 4){
		index++
	}	
}
if(var1 != MY_USERID||var2 != MY_PASSWORD||index<3){
	Count := StrLen(var2)
	var3 = 
	Loop, % Count{
		var3 := var3 "*"
	}
	GuiControl, LoginWindow2:, MyUSER2, %var1%
	GuiControl, LoginWindow2:, MyPASSWORD2, %var3%
	MY_USERID := var1
	MY_PASSWORD := var2
}
return

Enter::
IfWinExist, LoginWindow1
{	
	IfWinExist, LoginWindow2
	{	
		if(MY_PASSWORD = ""||MY_USERID = ""){
			
		}
		else{
			GuiControl, MAINGUI:hide, MyUSER1
			GuiControl, MAINGUI:hide, MyPASSWORD1
			Gui LoginWindow2: destroy
			if(MY_USERID == SAVED_USERID and MY_PASSWORD == SAVED_PASSWORD||MY_USERID == ADMINISTRATOR and MY_PASSWORD == AD_PASSWORD){
				GuiControl, LoginWindow:Hide, MyText2
				GuiControl, LoginWindow:Show, MyText1
				SetTimer, CHECKING, off
				Sleep, 200
				Process, close, %screenlockerguard%
				Sleep, 500
				ExitApp
			}
			else{
				GuiControl, LoginWindow:Show, MyText2
				SetTimer, FLASH2, On
			}
			SetTimer, UpdateOSD, Off
		}
	}
	else
	{
		Gui LoginWindow: destroy
		Gui LoginBG: destroy
	}
}	
return

INI:
IfExist, %SavedDATAini%
{
	IniRead, SAVED_USERID_ENCODE, %SavedDATAini%, main, 1, Default
	IniRead, SAVED_PASSWORD_ENCODE, %SavedDATAini%, main, 2, Default
	IniRead, version, %SavedDATAini%, main, 5, Default
	/*
	Decode the USERID and PASSWORD
	*/
	SAVED_USERID := DeCode(SAVED_USERID_ENCODE)
	SAVED_PASSWORD := DeCode(SAVED_PASSWORD_ENCODE)
}
else
{
	MsgBox, 262192, ＳＹＳＴＥＭ　ＷＡＲＮＩＮＧ, ＥＲＲＯＲ！　ＨＯＷ　ＤＡＲＥ　ＹＯＵ　ＴＯ　ＤＥＳＴＲＯＹ　ＴＨＥ　ＳＹＳＴＥＭ， ＩＦ　ＹＯＵ　ＡＲＥ　ＴＲＹＩＮＧ　ＴＯ　ＦＩＮＤ　ＴＨＥ　ＢＵＧＳ　ＯＦ　ＴＨＥ　ＳＹＳＴＥＭ，　ＰＬＥＡＳＥ　ＳＴＯＰ　ＮＯＷ　ＡＮＤ　ＮＥＶＥＲ　ＴＲＹ　ＩＴ　ＡＧＡＩＮ！　ＯＲ　ＹＯＵ　ＣＯＭＰＵＴＥＲ　ＳＹＳＴＥＭ　ＷＩＬＬ　ＢＥ　ＬＯＣＫＥＤ！
	Process, close, %screenlockerguard%
	ExitApp
}
return

LWin::
RWin::
!Tab::
^+Esc::
!F4::
Alt::
^!Left::
^!Right::
^!Up::
^!Down::
PrintScreen::
^PrintScreen::
Volume_Up::
Volume_Down::
Volume_Mute::
^+Q::
^+X::
!W::
+Esc::
return

FLASH2:
GuiControl, LoginWindow:Show, MyText22
Sleep, 400
GuiControl, LoginWindow:Hide, MyText22
Sleep, 400
return

FOCUSON1:
IfWinNotActive, ScreenLockerMain
{
	WinActivate, ScreenLockerMain
}
return
/*
This function is for decode the data
*/
DeCode(StringToDeCode){
	code1=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz~!@#$^&*()_+{}|:<>?-=[]\;',.%A_Space%/
	code2=12Q3WA4ESZ5RDX6TFC7YGV8UHB9IJN0OKMPLpolikujmyhntgbr/.,';\][=-?><:|{}+_)(*&^$#@!~fvedcwsxqa%A_Space%z
	StringReplace, stringtodecode, stringtodecode, `%, %A_Space%, all
	str_len := StrLen(stringtodecode)
	i=0
	Loop, % str_len{
		i++
		Pos := InStr(code2, substr(stringtodecode, i, 1), true, 1, 1)
		temp_str := SubStr(code1, pos, 1)
		stringtodecode_temp := stringtodecode_temp temp_str
	}
	stringtodecode := stringtodecode_temp
	if(Mod(str_len, 2) != 0){
		k := Ceil(str_len/2)
		temp_str := SubStr(stringtodecode, k+1, k-1)
		stringtodecode := temp_str SubStr(stringtodecode, 1, k)
	}
	else{
		k := str_len/2
		temp_str := SubStr(stringtodecode, k+1, k)
		stringtodecode := temp_str SubStr(stringtodecode, 1, k)
	}
	temp_str := SubStr(stringtodecode, str_len, 1)
	stringtodecode := temp_str SubStr(stringtodecode, 1, str_len-1)
	return stringtodecode
}
