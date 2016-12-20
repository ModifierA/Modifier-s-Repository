#NoTrayIcon
/*
Create a window for the console use and do something or run some codes to look like cool
*/
global time
global SleepTime
global Count
global ChangingText

CustomColor = cLime
Gui +LastFound +ToolWindow -Caption
Gui, Color, %CustomColor%
Gui, font, s10
Gui, Add, Text, x2 y-1 w360 h500 cLime vMyText, ...........
;Gui, Add, Edit, x2 y499 r1 w360 cLime, you can type you code on here`, kick enter will make your codes to be run.
Gui, font, s20
Gui, Add, text, x10 y500 r4 vMySystemLogin cLime, System reboot...`nStart scanning...
WinSet, transcolor, %CustomColor% 255
GuiControl, Focus, MyText
gosub, MAIN
SetTimer, UpdateOSD, %time%
Gui, Show,x995 w367 h570, Black Window
goto, UpdateOSD
return

GuiClose:
ExitApp
return

MAIN:
FileRead, codes, Gdip代码用来滚动.txt
ChangingText := StrSplit(codes, "`n", "`r")
;MsgBox, % changingtext[3]
;ExitApp
SleepTime = 500
Count := ChangingText.length()
time := Count*SleepTime

ChangingTitle1 := "."
ChangingTitle2 := ".."
ChangingTitle3 := "..."

return

UpdateOSD:
i = 1
m = 1
Loop, % Count{
	;ChangingTitle := ChangingTitle%i%
	;ChangingTextOUT := ChangingText[i]
    str := changingtext[i]
    j=1
    lines = 10
    Loop, % lines{
      str := str "`n" changingtext[i+j]
      j++
    }
	ChangingTextOUT := str
	ChangingTitleOUT := "System reboot" ChangingTitle%m%
	;MsgBox, %A_Index%
	if(A_Index > 20){
		ChangingTitleOUT := "System online `nStart scanning" ChangingTitle%m%
		;MsgBox, %ChangingTitleOUT%
	}
	GuiControl,, MyText, %ChangingTextOUT%
	GuiControl,, MySystemLogin, %ChangingTitleOUT%
	Sleep, %SleepTime%
	i++	
	if(m<3){
		m++
	}
	else{
		m=1
	}

}
return