#NoTrayIcon
CustomColor =   cblue
Gui, +AlwaysOnTop +LastFound +Owner  
Gui, Color, %CustomColor%  
gui, font, s30 italic, Verdana
Gui, Add, Text, vMyText cblue,XXXXXXXXXXXXXXXXXXXX
WinSet, TransColor, %CustomColor% 250 
Gui, -Caption  
SetTimer,UpdateOSD,1000  
Gosub,UpdateOSD  
Gui, Show, x800 y600 ;
UpdateOSD: 
time=%A_YYYY%年%A_MM%月%A_DD%日
time2=%A_Hour%:%A_Min%:%A_Sec% 
GuiControl,,MyText,%time%,%time2%

F10::
msgbox,4096,,You have shutted this app down!,1
exitapp
return  
