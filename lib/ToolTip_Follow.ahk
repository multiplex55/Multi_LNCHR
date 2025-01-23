; Source https://www.autohotkey.com/boards/viewtopic.php?f=83&t=115306

#Requires AutoHotkey v2.0

ToolTip_Follow(Text?, TimeSeconds:=5, WhichToolTip?){
	SetTimer(ToolTipSub.Bind(Text?, A_TickCount+TimeSeconds*1000, WhichToolTip?), 50)
	X_Mouse_Prev := ""
	Y_Mouse_Prev := ""

	ToolTipSub(Text?, TimeTarget?, WhichToolTip?){

		if (A_TickCount>TimeTarget){
			ToolTip("",,,WhichToolTip?)
			SetTimer(,0)
		} else {
			MouseGetPos(&X_Mouse, &Y_Mouse)
			if (X_Mouse_Prev!=X_Mouse or Y_Mouse_Prev!=Y_Mouse){
				ToolTip(Text?,,,WhichToolTip?)
				X_Mouse_Prev := X_Mouse
				Y_Mouse_Prev := Y_Mouse
			}
		}
	}
}