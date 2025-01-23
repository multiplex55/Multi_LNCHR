#Requires AutoHotkey v2
#Warn All, Off
#SingleInstance force
DetectHiddenWindows true
SetWinDelay(0)
#SingleInstance Force

#Include <ToolTip_Follow>

ESC::
{
    ExitApp
}

help_file := "HELP-Commands.txt"
path_to_compiler := IniRead("LNCHR-ConfigFile.ini", "SecureSettings", "Ahk2ExePath")

if (!FileExist(path_to_compiler))
{
    OutputDebug(path_to_compiler)
    return
}

; Attempt to close the process
if ProcessCloseByName("LNCHR-Main.exe") {
    ToolTip_Follow("Closed old instance", 1)
} else {
    ToolTip_Follow("Failed to close, may not be running", 1)
}

Sleep(2000)

if (FileExist(help_file))
{
    FileDelete(help_file)
}

Run(path_to_compiler . ' /in "src\LNCHR-Main.ahk"')

Sleep(2000)

FilePath := A_WorkingDir "\LNCHR-Main.exe"
TimeOut := 5000 ; 5 seconds in milliseconds
StartTime := A_TickCount

Loop
{
    if (FileExist(FilePath))
    {
        Run(FilePath)
        ToolTip_Follow("Good to go", 1)
        ExitApp
    }
    if (A_TickCount - StartTime > TimeOut)
    {
        ExitApp
    }
    Sleep 100 ; Check every 100 milliseconds
}

ExitApp()

ProcessCloseByName(exeName) {
    try {
        Process := ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process Where Name = '" exeName "'")
        for proc in Process {
            proc.Terminate()
            return True
        }
    } catch {
        return False
    }
    return False
}