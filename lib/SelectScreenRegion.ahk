SelectScreenRegion(Key, Color := "Lime", Transparent:= 80)
{
	CoordMode("Mouse", "Screen")
	MouseGetPos(&sX, &sY)
	ssrGui := Gui("+AlwaysOnTop -caption +Border +ToolWindow +LastFound -DPIScale")
	WinSetTransparent(Transparent)
	ssrGui.BackColor := Color
	Loop 
	{
		Sleep 10
		MouseGetPos(&eX, &eY)
		W := Abs(sX - eX), H := Abs(sY - eY)
		X := Min(sX, eX), Y := Min(sY, eY)
		ssrGui.Show("x" X " y" Y " w" W " h" H)
	} Until !GetKeyState(Key, "p")
	ssrGui.Destroy()
	Return { X: X, Y: Y, W: W, H: H, X2: X + W, Y2: Y + H }
}



; #Requires AutoHotkey v2

; ; Select Screen Region with Mouse
; ^#LButton:: ; Control+Win+Left Mouse to select with Red
; {
; 	Area := SelectScreenRegion("LButton", "Red", 30)
; 	MsgBox "Top Left:		X " Area.X "`tY " Area.Y "`nBottom Right	X " Area.X2 "`tY " Area.Y2 "`n`nWidth	" Area.W "`tHeight " Area.H
; }

; L:: ; L to select with defaults
; {
; 	Area := SelectScreenRegion("L")
; 	MsgBox "Top Left:		X " Area.X "`tY " Area.Y "`nBottom Right	X " Area.X2 "`tY " Area.Y2 "`n`nWidth	" Area.W "`tHeight " Area.H
; }

; Esc:: ExitApp

; SelectScreenRegion(Key, Color := "Lime", Transparent:= 80)
; {
; 	CoordMode("Mouse", "Screen")
; 	MouseGetPos(&sX, &sY)
; 	ssrGui := Gui("+AlwaysOnTop -caption +Border +ToolWindow +LastFound -DPIScale")
; 	WinSetTransparent(Transparent)
; 	ssrGui.BackColor := Color
; 	Loop 
; 	{
; 		Sleep 10
; 		MouseGetPos(&eX, &eY)
; 		W := Abs(sX - eX), H := Abs(sY - eY)
; 		X := Min(sX, eX), Y := Min(sY, eY)
; 		ssrGui.Show("x" X " y" Y " w" W " h" H)
; 	} Until !GetKeyState(Key, "p")
; 	ssrGui.Destroy()
; 	Return { X: X, Y: Y, W: W, H: H, X2: X + W, Y2: Y + H }
; }