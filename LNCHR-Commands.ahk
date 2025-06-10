#Include <JSON_for_AHKv2>

; Loads the JSON command configuration
LoadCommands()
{
    static commands := ""
    if (commands == "")
    {
        jsonText := FileRead("commands.json")
        commands := Jsons.Load(&jsonText)
    }
    return commands
}

; Dispatch commands based on configuration
lngui_run_commands(input)
{
    cmds := LoadCommands()
    if !cmds.Has(input)
        return

    cmd := cmds[input]
    if (cmd.Has("type"))
    {
        switch cmd["type"]
        {
            case "query":
                lngui_enable_query(cmd["label"], make_run_ReplaceTexts_func(cmd["url"]))
                return
            case "queryfunc":
                lngui_enable_query(cmd["label"], Func(cmd["function"]))
                return
        }
    }

    if (cmd.Has("ops"))
    {
        for _, op in cmd["ops"]
        {
            fn := op["func"]
            args := op.HasOwnProp("args") ? op["args"] : []
            Func(fn).Call(args*)
        }
    }
}
