#NoTrayIcon
global obj_offset
obj_offset = 0
CustomColor = EEAA99
Gui +lastfound +toolwindow -Caption
Gui, color, %CustomColor%
Gui, Add, Progress, x42 y160 w310 r1 vMyProgress1 Background808080 cLime, 0
WinSet, transcolor, %CustomColor% 200
Gui, Show,x970 y400 w479 h379, Untitled GUI
SetTimer, MOVE1, 30
SetTimer, RandomNum, 200
return

GuiClose:
ExitApp
return

RandomNum:
Random, var1, 0, 100
return

MOVE1:
obj = MyProgress1
Move(obj, var1)
return

Move(obj, iTarget){
	speed := (iTarget - obj_offset)/20
	speed:=speed>0?ceil(speed):floor(speed)
	if(iTarget = obj_offset){
		return
	}
	else{
		obj_offset := obj_offset + speed
		GuiControl,, %obj%, %obj_offset%
	}
}