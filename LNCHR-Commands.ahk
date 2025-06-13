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
    if (cmd.Has("ops"))
    {
        for _, op in cmd["ops"]
        {
            if (op.Has("func"))
            {
                args := op.Has("args") ? op["args"] : []
                Func(op["func"]).Call(args*)
            }
            else if (op.Has("type"))
            {
                switch op["type"]
                {
                    case "query":
                        lngui_enable_query(op["label"], make_run_ReplaceTexts_func(op["url"]))
                        return
                    case "queryfunc":
                        lngui_enable_query(op["label"], Func(op["function"]))
                        return
                }
            }
        }
    }
}
