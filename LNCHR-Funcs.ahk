#Requires AutoHotkey v2.0+

#Include <UIA>
#Include <VD>
#Include <ToolTip_Follow>
#Include <Notify>

; these are functions that are called by some of the Commands.


; ______________________________________________________________________________ TryRun ___________


TryRun(s) {
    try {
        run s
    }
    catch {
        QuickTrayTip("failed to run:`n" s, tit := "LNCHR")
        ToolTip("failed to run:`n" s, 500, 0)
        SetTimer(() => ToolTip(), -3000)
    }
}


UrlEncode(str, sExcepts := "-_.", enc := "UTF-8")
{
    hex := "00", func := "msvcrt\swprintf"
    buff := Buffer(StrPut(str, enc)), StrPut(str, buff, enc)
    encoded := ""
    Loop {
        if (!b := NumGet(buff, A_Index - 1, "UChar"))
            break
        ch := Chr(b)
        ; "is alnum" is not used because it is locale dependent.
        if (b >= 0x41 && b <= 0x5A ; A-Z
            || b >= 0x61 && b <= 0x7A ; a-z
            || b >= 0x30 && b <= 0x39 ; 0-9
            || InStr(sExcepts, Chr(b), true))
            encoded .= Chr(b)
        else {
            DllCall(func, "Str", hex, "Str", "%%%02X", "UChar", b, "Cdecl")
            encoded .= hex
        }
    }
    return encoded
}


; Decode precent encoding
UrlDecode(Url, Enc := "UTF-8")
{
    Pos := 1
    Loop {
        Pos := RegExMatch(Url, "i)(?:%[\da-f]{2})+", &code, Pos++)
        If (Pos = 0)
            Break
        code := code[0]
        var := Buffer(StrLen(code) // 3, 0)
        code := SubStr(code, 2)
        loop Parse code, "`%"
            NumPut("UChar", Integer("0x" . A_LoopField), var, A_Index - 1)
        Url := StrReplace(Url, "`%" code, StrGet(var, Enc))
    }
    Return Url
}


run_ReplaceText(replacement, runString) {
    if InStr(runString, "http")  ; if url, do a clean replacement
    {
        replacement := UrlEncode(replacement)
    }
    ; assume proper formatting for command line stuff
    runString := StrReplace(runstring, "REPLACEME", replacement)
    TryRun(runString)
}


make_run_ReplaceTexts_func(args*) { ; create a 1 arg function from a list of args given as templates, used to pass to run_Replace_Text
    func(rep) {
        for index, arg in args
            run_ReplaceText(rep, arg)
    }
    return func
}


; https://www.autohotkey.com/boards/viewtopic.php?t=23352
; todo must fix this to get active explorer path in last window open...
GetActiveExplorerPath()
{
    explorerHwnd := WinActive("ahk_class CabinetWClass")
    if (explorerHwnd)
    {
        for window in ComObject("Shell.Application").Windows
        {
            if (window.hwnd == explorerHwnd)
            {
                return window.Document.Folder.Self.Path
            }
        }
    }
}

; ______________________________________________________________________________ UTILS ___________

SearchLNCHRFileAndGenerateHelp()
{
    jsonText := FileRead("commands.json")
    commands := Jsons.Load(&jsonText)
    longestCommand := 0
    for key, obj in commands
    {
        if (StrLen(key) > longestCommand)
            longestCommand := StrLen(key)
    }

    outFile := FileOpen("HELP-Commands.txt", "w")
    for key, obj in commands
    {
        outFile.WriteLine(Format("{:-" . longestCommand . "}", key) . " : " . obj["description"])
    }
    outFile.Close()
}

SortLNCHRConfigFile()
{
    if (FileExist(lngui_props.configFileName))
    {
        commands := Map()
        fOpen := FileOpen(lngui_props.configFileName, 'r')
        loop read lngui_props.configFileName
        {
            if (!InStr(A_LoopReadLine, '['))
            {
                splitString := StrSplit(A_LoopReadLine, "=", , 2)
                commands[splitString[1]] := splitString[2]
            }
        }
        fOut := FileOpen(lngui_props.configFileName, 'w')
        fOut.WriteLine("[SecureSettings]")
        for (key, val in commands)
        {
            fOut.WriteLine(key . "=" . val)
        }
        fOut.Close()
    }
}

SetClipboardFromINI(key)
{
    A_Clipboard := TryGetValueFromINIFile(key)
}

ExpandVars(str)
{
    while RegExMatch(str, "%(.*?)%", &match)
    {
        name := match[1]
        value := ""
        try value := %name%
        catch
        {
            try value := EnvGet(name)
            catch value := ""
        }
        if (value == "")
            value := TryGetValueFromINIFile(name)
        str := StrReplace(str, "%" name "%", value)
    }
    return str
}

OpenVolumeMixer() {
    ; Try to activate the Volume Mixer window if it exists
    if WinExist("ahk_class #32770") {
        WinActivate("ahk_class #32770")
    } else {
        ; Otherwise, open the Volume Mixer
        Run("ms-settings:apps-volume")
    }
}

OpenAutohotkeyHelpWithDarkMode()
{
    TryRun(TryGetValueFromINIFile("AutohotkeyHelpPath"))
    Sleep(500)
    WinActivate("AutoHotkey v2 Help")
    if (WinActive("AutoHotkey v2 Help"))
    {
        handle := UIA.ElementFromHandle("AutoHotkey v2 Help")
        handle.ElementFromPath("YYYYR8/70").Click()
        Sleep(250)
        handle.FindElement({ Name: "Search tab", Type: "Button" }).Click()
    }
}

; ______________________________________________________________________________ Outlook ___________

GetOutlookCom() {
    try
        outlookApp := ComObjActive("Outlook.Application")
    catch
        outlookApp := ComObject("Outlook.Application")
    return outlookApp
}


OutlookSearch(searchstr)
{
    searchstr := StrReplace(searchstr, "!", " hasattachments:yes")
    olApp := GetOutlookCom()
    static olSearchScopeAllFolders := 2
    olApp.ActiveExplorer.Search(searchstr, olSearchScopeAllFolders) ; Activate the Outlook window
    WinActivate("ahk_class rctrl_renwnd32") ; Send Tab to hide the "suggested searches" drop down
    ControlSend "{Tab}", "RICHEDIT60W1", "ahk_class rctrl_renwnd32"
    return
}

; ______________________________________________________________________________ Virtual Desktop ___________


VirtualDesktopGoTo(num)
{
    VD.goToDesktopNum(num)
}

VirtualDesktopGoLeft()
{
    VD.goToRelativeDesktopNum(-1)
}

VirtualDesktopGoRight()
{
    VD.goToRelativeDesktopNum(1)
}

SendToDesktop(appName, desktopNumber)
{
    VD.MoveWindowToDesktopNum(appName, desktopNumber)
}

SendToDesktopAndActivate(appName, desktopNumber)
{
    VD.MoveWindowToDesktopNum(appName, desktopNumber)
    Sleep(1000)
    if (WinActive(appName))
    {
        WinActivate(appName)
    }
}
; ______________________________________________________________________________ math JS "Calculate" ___________
#Include JS.ahk


JS := JsRT.Edge() ; instantiate JS obj
JS.Eval(FileRead("mathjs.js"))  ; add math js

JS.Eval("const parser = math.parser()") ; create a parser object in JS

Loop Read, lngui_props.calceqfile { ; load equations
    JS.Eval("parser.evaluate('" A_LoopReadLine "')")
}


MakeMathExpr(expr) => "math.format(parser.evaluate('" expr "'), {precision: 5}).toString()"
TryEvalMathExpr(expr) => JS.Eval("try { " . MakeMathExpr(expr) . "; } catch(e) { 'undefined'; }")


js_math_exp_helper(exp)
{
    exp := StrReplace(exp, "**", "^") ; python syntax, ** = ^2
    some_number := "(\d|\d\)[)]?)" ; regex to capture a number (followed by an optional ))
    exp := RegExReplace(exp, some_number . "j", "$1i") ; replace j with 1i, because I'm an EE (:
    exp := RegExReplace(exp, some_number . "sq", "$1^2") ; shortcut for number squard eg: 3sq or (1+2)sq
    exp := RegExReplace(exp, some_number . "cu", "$1^3") ; shortcut for number cubed
    exp := RegExReplace(exp, some_number . "roo", "$1^0.5") ; shortcut for square root (3+6)roo = 3
    return exp
}


run_calc_shortcut_then_return(s) {
    TryRun(s)
    set_lngui_input()
    Sleep(200)
    WinActivate(lngui.Hwnd)
    return
}


Calculate(expr)
{
    ;
    exprOG := expr
    expr := js_math_exp_helper(expr)  ;

    if expr == '?' { ; load equations list
        run_calc_shortcut_then_return(lngui_props.calceqfile)
        return
    } else if expr == "mem" {
        run_calc_shortcut_then_return(lngui_props.memfile)
        return
    }


    result := TryEvalMathExpr(expr)

    if result != "undefined" {
        if InStr(expr, '=') {
            FileAppend expr "`n", lngui_props.calceqfile ; store equation in memory
        } else {
            A_Clipboard := result
            IniWrite(exprOG, lngui_props.memfile, "Calculate", "Calculate")
        }
    } else {
        result := "..."
    }

    set_calc_text(result)

}

; ______________________________________________________________________________ Games ___________


GameRunStream(name, id)
{
    if (WinExist("ahk_exe " . name))
    {
        WinActivate("ahk_exe " . name)
    }
    else
    {
        Run("steam://rungameid/" . id)
    }

}

RunRunescapeJagexClients()
{
    ; TODO add some error checking here
    if (!ProcessExist("rs2client.exe"))
    {
        if (WinExist("Jagex Launcher"))
        {
            ; click rs3 play button
            rsWindow := UIA.ElementFromHandle("Jagex Launcher")
            rsWindow.FindElement({ Name: "Play", Type: "Button" }).Click()
            Sleep(3000)
            rsWindow.FindElement({ Name: "Old School RuneScape", Type: "Button" }).Click()
            Sleep(3000)
            rsWindow := UIA.ElementFromHandle("Jagex Launcher")
            rsWindow.FindElement({ Name: "Play", Type: "Button" }).Click()
            Sleep(3000)
            rsWindow.FindElement({ Name: "Minimize", Type: "Button" }).Click()
        }
    }

}

; ______________________________________________________________________________ Timers ___________

TimerList := Map()
Global TimerIniFile := "Timers.ini"
timeRegexPatterns := "^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)(\.(\d{1,9}))?$"
global timerLogFileName := "TimerLog.txt"

Class TimerClass
{
    Name := ""
    OriginalTimeString := ""
    CompletionTime := ""

    __New(name := "default", timestring := "00:00:10", ogTime := "00:00:10")
    {
        this.Name := name
        this.OriginalTimeString := timestring
        RegExMatch(timestring, timeRegexPatterns, &match)

        nowPlusTime := A_Now
        nowPlusTime := DateAdd(nowPlusTime, match[1], "Hours")
        nowPlusTime := DateAdd(nowPlusTime, match[2], "Minutes")
        nowPlusTime := DateAdd(nowPlusTime, match[3], "Seconds")
        if (match.Count > 5)
        {
            nowPlusTime := DateAdd(nowPlusTime, match[5] / 1000, "Seconds")
        }

        this.CompletionTime := nowPlusTime
    }
}

lngui_query_timer_add(s) {
    try {
        splitTime := StrSplit(s, " ")
        CreateTimer(splitTime[1], splitTime[2])
    }
    catch {
    }
}

lngui_query_timer_delete(s) {
    try {
        DeleteTimer(s)
    }
    catch {
    }
}

CreateTimer(timerName, timeString, completionTime := "")
{
    if (TimerList.Has(timerName))
    {
        MsgBox("Timer with name " . timerName . " already exists")
        return
    }

    regexResult := RegExMatch(timeString, timeRegexPatterns, &match)

    if (regexResult == 0)
    {
        return
    }

    if (completionTime = "")
    {
        newTimer := TimerClass(timerName, timeString)
    }
    else
    {
        newTimer := TimerClass()
        newTimer.Name := timerName
        newTimer.OriginalTimeString := timeString
        newTimer.CompletionTime := completionTime
    }

    if (!TimerList.Has(timerName))
    {
        TimerList[timerName] := newTimer
        ; Save timer to ini file
        IniWrite(timerName, TimerIniFile, timerName, "Name")
        IniWrite(timeString, TimerIniFile, timerName, "OriginalTimeString")
        IniWrite(newTimer.CompletionTime, TimerIniFile, timerName, "CompletionTime")

        notification := "Timer with name " . timerName . " with time " . timeString . " has been created"
        Notify.Show('Info', notification, 'iconi', , , 'TC=black MC=black BC=75AEDC style=edge show=slideWest@250 hide=slideEast@250')
        ; TrayTip(notification, "LNCHR - Timer Created")
        WriteToTimerLogFile(notification)
    }
    SetTimer(CheckTimersForExpired, 1000)
}

DeleteTimer(timerName)
{
    if (TimerList.Has(timerName))
    {
        TimerList.Delete(timerName)
        ; Remove timer from ini file
        IniDelete(TimerIniFile, timerName)
        notification := "Timer with name " . timerName . " is deleted"
        ; TrayTip(notification, "LNCHR - Timer Deletion")
        Notify.Show('LNCHR - Timer Deletion', notification, 'iconi', , , 'TC=black MC=black BC=75AEDC style=edge show=slideWest@250 hide=slideEast@250')
        WriteToTimerLogFile(notification)
    }
    else
    {
        notification := "Timer with name " . timerName . " does not exist"
        ; TrayTip(notification, "LNCHR - Timer Deletion Error")
        Notify.Show('LNCHR - Timer Deletion Error', notification, 'iconi', , , 'TC=black MC=black BC=75AEDC style=edge show=slideWest@250 hide=slideEast@250')
        WriteToTimerLogFile(notification)
    }
    return
}

CheckTimersForExpired()
{
    global
    timersToDelete := []
    for currTime in TimerList
    {
        currTime := TimerList[currTime]
        diffSeconds := DateDiff(currTime.CompletionTime, A_Now, "Seconds")
        OutputDebug("Now: " . A_Now . " diffSeconds: " . diffSeconds)
        if (diffSeconds < 0)
        {
            timersToDelete.Push(currTime.Name)
            notification := "Timer " . currTime.Name . " has completed"
            ; TrayTip(notification, "LNCHR - Timer Expired")
            Notify.Show('LNCHR - Timer Expired', notification, 'iconi', , , 'TC=black MC=black BC=75AEDC style=edge show=slideWest@250 hide=slideEast@250')
            WriteToTimerLogFile(notification)
        }
    }

    for ttd in timersToDelete
    {
        TimerList.Delete(ttd)
        ; Remove expired timer from ini file
        IniDelete(TimerIniFile, ttd)
        notification := "Removed " . ttd
        WriteToTimerLogFile(notification)
        ; TrayTip("Removed " . ttd, "LNCHR - Timer Deleted")
    }
}

ViewToolTipAllTimers()
{
    tooltipDisplay := ""
    if (TimerList.Capacity >= 1)
    {
        for currTime in TimerList
        {
            currTime := TimerList[currTime]
            diffSeconds := DateDiff(currTime.CompletionTime, A_Now, "Seconds")
            formattedTimeSeconds := Format("{:02}:{:02}:{:02}", Floor(diffSeconds / 3600), Floor(Mod(diffSeconds, 3600) / 60), Mod(diffSeconds, 60))

            formattedTime := FormatTime(currTime.CompletionTime, "dddd MMMM d, yyyy hh:mm:ss tt")
            tooltipDisplay .= currTime.Name . " Remaining Time: " . formattedTimeSeconds . " Completion Date: " . formattedTime . "`n"
        }
    }
    else
    {
        tooltipDisplay := "No Active Timers"
    }


    ToolTip_Follow(tooltipDisplay, 5)
}

LoadTimersFromIni()
{
    global
    if !FileExist(TimerIniFile)
        return

    timersIni := IniRead(TimerIniFile)
    timersIni := StrSplit(timersIni, "`n")
    for _, sectionName in timersIni
    {
        name := IniRead(TimerIniFile, sectionName, "Name")
        timeString := IniRead(TimerIniFile, sectionName, "OriginalTimeString")
        savedCompletionTime := IniRead(TimerIniFile, sectionName, "CompletionTime")

        ; Calculate remaining time
        diffSeconds := DateDiff(savedCompletionTime, A_Now, "Seconds")
        if (diffSeconds > 0)
        {
            newCompletionTime := DateAdd(A_Now, diffSeconds, "Seconds")
            CreateTimer(name, timeString, newCompletionTime)
        }
        else
        {
            notification := "Timer " . name . " has expired"
            ; TrayTip(notification, "LNCHR - Timer Expired")
            Notify.Show('LNCHR - Timer Expired', notification, 'iconi', , , 'TC=black MC=black BC=75AEDC style=edge show=slideWest@250 hide=slideEast@250')
            WriteToTimerLogFile(notification)
            IniDelete(TimerIniFile, name) ; Timer has expired while the script was not running
        }
    }
}

WriteToTimerLogFile(name)
{
    fOut := FileOpen("TimerLog.txt", 'a')
    fOut.WriteLine(A_Now . " " . name)
    fOut.Close()
}

; ______________________________________________________________________________ Run or Activate ___________

RunOrActivateGimp()
{
    title := "GNU Image Manipulation Program"
    if (WinActive(title))
    {
        WinActivate(title)
        return
    }
    else
    {
        TryRun(TryGetValueFromINIFile("GimpLocation"))
    }
    return
}

RunOrActivateSteam()
{
    title := "Steam"
    if (WinActive(title))
    {
        WinActivate(title)
        return
    }
    else
    {
        TryRun(TryGetValueFromINIFile("SteamLocation"))
    }
    return
}