lngui_run_commands(input)
{
    if (input == "?") ; ?
    {
        close_lngui()
        tryrun("HELP-Commands.txt")
        Sleep(100)
        close_lngui()
        build_lngui()
        return
    }

    if (input == "a dir") ; Directory of LNCHR
    {
        close_lngui()
        tryrun('%A_ScriptDir%\..\')
        return
    }

    if (input == "a ex") ; Exit lnchr
    {
        close_lngui()
        ExitApp()
        return
    }

    if (input == "a mem") ; LNCHR Memory File
    {
        close_lngui()
        tryrun('"LNCHR-Memory.ini"')
        return
    }

    if (input == "a rec") ; Recompile LNCHR
    {
        close_lngui()
        TryRun("LNCHR-Recompile.exe")
        return
    }

    if (input == "a rel") ; Reload Script
    {
        close_lngui()
        Reload
        return
    }

    if (input == "a sag") ; Search and Generate Commands
    {
        close_lngui()
        Sleep(100)
        FileDelete("HELP-Commands.txt")
        SearchLNCHRFileAndGenerateHelp()
        Reload
        return
    }

    if (input == "a slc") ; Sort LNCHR Config
    {
        close_lngui()
        SortLNCHRConfigFile()
        return
    }

    if (input == "ah f l") ; Autohotkey AHK Folder LNCHR
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("LNCHRFolderPath"))
        return
    }

    if (input == "ah f p") ; Autohotkey AHK Folder Packages
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("AutohotkeyPackages"))
        return
    }

    if (input == "ah f r") ; Autohotkey AHK Folder Root
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("AuthotkeyRootPath"))
        return
    }

    if (input == "ah f t") ; Autohotkey AHK Folder Testing
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("AutohotkeyTestingFolderLocation"))
        return
    }

    if (input == "ah for") ; Autohotkey Forum
    {
        close_lngui()
        tryrun("https://www.autohotkey.com/boards/viewforum.php?f=83")
        return
    }

    if (input == "ah h") ; Autohotkey Help
    {
        close_lngui()
        OpenAutohotkeyHelpWithDarkMode()
        return
    }

    if (input == "ah ma") ; Autohotkey Mute Active Application Script
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("AutohotkeyMuteActiveApplication"))
        return
    }

    if (input == "ah uia") ; Autohotkey UIA Tree Viewer
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("AutohotkeyUIAInspectorPath"))
        return
    }

    if (input == "ah wsd") ; Autohotkey Winspy Delta
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("AutohotkeyWinspyDelta"))
        return
    }

    if (input == "ama") ; Amazon
    {
        close_lngui()
        tryrun('https://www.amazon.com/')
        return
    }

    if (input == "baze") ; Bazecor
    {
        close_lngui()
        WinActivate("Bazecor")
        return
    }

    if (input == "c ") ; Calculator
    {
        lngui_enable_calc()
        return
    }

    if (input == "caps") ; Toggle Cap Lock
    {
        close_lngui()
        toggleCapsLock()
        return
    }

    if (input == "cgpt") ; Chat GPT
    {
        close_lngui()
        TryRun("https://chatgpt.com/")
        return
    }

    if (input == "ci ") ; Chrome Incognito
    {
        lngui_enable_query("Google Private", make_run_ReplaceTexts_func(
            "C:\Program Files\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?q=REPLACEME"
        ))
        return
    }

    if (input == "dis") ; Activate Discord
    {
        close_lngui()
        WinActivate("Discord")
        return
    }

    if (input == "emo") ; Emojis
    {
        close_lngui()
        SendInput '#.'
        return
    }

    if (input == "exer ") ; Exercise RX Search
    {
        lngui_enable_query("Exercise RX Search", make_run_ReplaceTexts_func(
            "https://www.google.com/search?num=50&safe=off&site=&source=hp&q=site:https://exrx.net/ REPLACEME&btnG=Search&oq=&gs_l="
        ))
        return
    }

    if (input == "fcdr") ; Folder C Drive
    {
        close_lngui()
        tryrun('C:\')
        return
    }

    if (input == "fdesk") ; Folder desk
    {
        close_lngui()
        tryrun('"C:\Users\' A_Username '\Desktop"')
        return
    }

    if (input == "fdoc") ; Folder My Documents
    {
        close_lngui()
        tryrun('"C:\Users\' A_Username '\Documents"')
        return
    }

    if (input == "fdown") ; Folder Downloads
    {
        close_lngui()
        tryrun('"C:\Users\' A_Username '\Downloads"')
        return
    }

    if (input == "fdrop") ; Folder Dropbox
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("DropboxFolderPath"))
        return
    }

    if (input == "fnvcf") ; Folder Neo Vim Config Folder
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("NeovimConfigFolderLocation"))
        return
    }

    if (input == "fnvcgit") ; Folder Neo Vim Config Git
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("NeovimGithubConfigFolderLocation"))
        return
    }

    if (input == "fobs") ; Folder Obsidian
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("ObsidianFolderLocation"))
        return
    }

    if (input == "fsharex") ; Folder ShareX folder
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("SharexFolderPath"))
        return
    }

    if (input == "fst") ; Folder Startup
    {
        close_lngui()
        tryrun("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup")
        return
    }

    if (input == "fw") ; Visual Studio Code Workspaces
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("FolderWorkspace"))
        return
    }

    if (input == "g ") ; Google
    {
        lngui_enable_query("Google", make_run_ReplaceTexts_func(
            "https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l="))
        return
    }

    if (input == "gdri") ; Google Drive
    {
        close_lngui()
        tryrun('www.drive.google.com/')
        return
    }

    if (input == "gimp") ; Run Gimp
    {
        close_lngui()
        RunOrActivateGimp()
        return
    }

    if (input == "gitd") ; Github Desktop
    {
        close_lngui()

        Send("{LWin}")
        Sleep(200)
        SendText("Github Desktop")
        Sleep(200)
        Send("{Enter}")

        return
    }

    if (input == "gitw") ; Github Website
    {
        close_lngui()
        tryrun('https://github.com/multiplex55')
        return
    }

    if (input == "gmal") ; Gmail
    {
        close_lngui()
        tryrun('https://mail.google.com/')
        return
    }

    if (input == "gmap") ; Google Maps
    {
        close_lngui()
        tryrun('https://www.google.com/maps/')
        return
    }

    if (input == "mail") ; Yahoo Mail
    {
        close_lngui()
        TryRun("https://mail.yahoo.com/d/folders/1")
        return
    }

    if (input == "mm") ; MouseMaster
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("MouseMasterLocation"))
        return
    }

    if (input == "n f r") ; Nim Folder Location root
    {
        close_lngui()
        TryRun(TryGetValueFromINIFile("NimFolderLocation"))
        return
    }

    if (input == "n i") ; Nim Index
    {
        close_lngui()
        TryRun("https://nim-lang.org/docs/theindex.html")
        return
    }

    if (input == "np") ; Notepad
    {
        close_lngui()
        tryrun('Notepad')
        return
    }

    if (input == "nv") ; Neovide
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("Neovide"))
        return
    }

    if (input == "obs") ; Activate Obsidian
    {
        close_lngui()
        WinActivate("Obsidian")
        return
    }

    if (input == "ont") ; OnTopReplica
    {
        close_lngui()
        tryrun("C:\Users\" . A_Username .
            "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OnTopReplica\OnTopReplica.lnk")
        return
    }

    if (input == "osrs ") ; Old School Runescape Search
    {
        lngui_enable_query("OSRS", make_run_ReplaceTexts_func("https://oldschool.runescape.wiki/?search=REPLACEME"))
        return
    }

    if (input == "pai") ; MS Paint
    {
        close_lngui()
        tryrun('C:\Windows\system32\mspaint.exe')
        return
    }

    if (input == "pc") ; My Pc
    {
        close_lngui()
        tryrun('explorer =')
        return
    }

    if (input == "pdp") ; Phone Link Bring To Desktop Primary
    {
        close_lngui()
        SendToDesktopAndActivate("Phone Link", 1)
        return
    }

    if (input == "pds") ; Phone Link Bring To Desktop Secondary
    {
        close_lngui()
        SendToDesktop("Phone Link", 2)
        return
    }

    if (input == "pwe") ; PW E
    {
        close_lngui()
        A_Clipboard := TryGetValueFromINIFile("pwe")
        return
    }

    if (input == "pwk") ; PW k
    {
        close_lngui()
        A_Clipboard := TryGetValueFromINIFile("pwk")
        return
    }

    if (input == "pww") ; PW wow
    {
        close_lngui()
        A_Clipboard := TryGetValueFromINIFile("pww")
        return
    }

    if (input == "r ") ; Run Anything
    {
        lngui_enable_query("Run", make_run_ReplaceTexts_func("REPLACEME"))
        return
    }

    if (input == "rec") ; Recycle Bin
    {
        close_lngui()
        tryrun('::{645FF040-5081-101B-9F08-00AA002F954E}')
        return
    }

    if (input == "red map") ; Reddit Map of Reddit
    {
        close_lngui()
        tryrun("https://anvaka.github.io/map-of-reddit/?x=18239&y=12514&z=23244.04817852816&v=2")
        return
    }

    if (input == "red ms") ; Reddit My Stuff
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("MyRedditStuff"))
        return
    }

    if (input == "red osrs") ; Reddit OSRS
    {
        close_lngui()
        tryrun("https://www.reddit.com/r/2007scape/")
        return
    }

    if (input == "red rs") ; Reddit Runescape
    {
        close_lngui()
        tryrun("https://www.reddit.com/r/runescape/")
        return
    }

    if (input == "red tfd") ; Reddit The First Descendant
    {
        close_lngui()
        tryrun("https://www.reddit.com/r/TheFirstDescendant/")
        return
    }

    if (input == "red war") ; Reddit Warframe
    {
        close_lngui()
        tryrun("https://www.reddit.com/r/Warframe")
        return
    }

    if (input == "redd") ; Reddit
    {
        close_lngui()
        tryrun('www.reddit.com')
        return
    }

    if (input == "reds") ; Reddit Search
    {
        lngui_enable_query("Reddit", make_run_ReplaceTexts_func(
            "https://www.reddit.com/search?q=REPLACEME&include_over_18=on&sort=relevance&t=all"))
        return
    }

    if (input == "resxplorer") ; Restart Explorer
    {
        close_lngui()
        run 'taskkill /f /im explorer.exe'
        run 'explorer.exe'
        return
    }

    if (input == "rnv") ; Restart Neovide
    {
        close_lngui()
        restartNeovide()
        return
    }

    if (input == "rs ") ; Runescape Search
    {
        lngui_enable_query("RS3 ", make_run_ReplaceTexts_func(
            "https://runescape.wiki/w/Special:Search?search=REPLACEME"))
        return
    }

    if (input == "rss") ; Runescape Start
    {
        close_lngui()
        RunRunescapeJagexClients()
        return
    }

    if (input == "s ") ; Spotify
    {
        lngui_enable_query("Spotify", make_run_ReplaceTexts_func("https://open.spotify.com/search/REPLACEME"))
        return
    }

    if (input == "stea") ; Activate Steam
    {
        close_lngui()
        RunOrActivateSteam()
        return
    }

    if (input == "sw") ; Activate Swiftpoint
    {
        close_lngui()
        WinActivate("Swiftpoint X1 Control Panel")
        return
    }

    if (input == "ta ") ; Timer Create Add
    {
        lngui_enable_query("Timer", lngui_query_timer_add)
        return
    }

    if (input == "td ") ; Timer Delete
    {
        lngui_enable_query("Timer", lngui_query_timer_delete)
        return
    }

    if (input == "tl") ; Timer List
    {
        close_lngui()
        ViewToolTipAllTimers()
        return
    }

    if (input == "tm") ; Task Manager
    {
        close_lngui()
        tryrun('taskmgr')
        return
    }

    if (input == "tn") ; Timer Notepad Log FIle
    {
        close_lngui()
        Run("notepad.exe TimerLog.txt")
        return
    }

    if (input == "vall") ; Video Game All games at one time- melvor, space, warframe
    {
        close_lngui()
        GameRunStream("MelvorIdle.exe", "1267910")
        Sleep(1000)
        GameRunStream("SpaceIdle.exe", "2471100")
        Sleep(1000)
        GameRunStream("Warframe.exe", "230410")
        Sleep(1000)
        return
    }

    if (input == "vbdo") ; Video Game Black Desert
    {
        close_lngui()
        GameRunStream("Black Desert Online", "582660")
        return
    }

    if (input == "vdest") ; Destiny 2
    {
        close_lngui()
        GameRunStream("Destiny.exe", "1085660")
        return
    }

    if (input == "vdl") ; Virtual Desktop Left
    {
        close_lngui()
        VirtualDesktopGoLeft()
        return
    }

    if (input == "vdr") ; Virtual Desktop Right
    {
        close_lngui()
        VirtualDesktopGoRight()
        return
    }

    if (input == "vm") ; Volume Mixer
    {
        close_lngui()
        OpenVolumeMixer()
        return
    }

    if (input == "vsc") ; Run Visual Studio Code
    {
        close_lngui()
        TryRun("C:\Users\" . A_Username . "\AppData\Local\Programs\Microsoft VS Code\Code.exe")
        return
    }

    if (input == "vspace") ; Video Game Unnamed Space Idle
    {
        close_lngui()
        GameRunStream("SpaceIdle.exe", "2471100")
        return
    }

    if (input == "vwar") ; Video Game Warframe
    {
        close_lngui()
        GameRunStream("Warframe.exe", "230410")
        return
    }

    if (input == "w ") ; Wolfram Alpha
    {
        lngui_enable_query("Wolfram Alpha", make_run_ReplaceTexts_func(
            "https://www.wolframalpha.com/input/?i=REPLACEME"))
        return
    }

    if (input == "weag") ; Weather Google
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("GoogleWeather"))
        return
    }

    if (input == "weawi") ; Weather Windy
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("WindyWeatherPath"))
        return
    }

    if (input == "weawo") ; Weather Wow
    {
        close_lngui()
        tryrun('https://weawow.com/')
        return
    }

    if (input == "wo r") ; Workspaces Root
    {
        close_lngui()
        tryrun(TryGetValueFromINIFile("FolderWorkspace"))
        return
    }

    if (input == "wow cur") ; Wow Curse forge addons
    {
        close_lngui()
        TryRun(TryGetValueFromINIFile("WowCurseForge"))
        return
    }

    if (input == "wow elv") ; Wow Elvui
    {
        close_lngui()
        TryRun("https://tukui.org/elvui#")
        return
    }

    if (input == "wow f log") ; Wow folder logs location
    {
        close_lngui()
        TryRun("E:\BattleNet\World of Warcraft\_retail_\Logs")
        return
    }

    if (input == "wow mmo") ; Wow mmo champion
    {
        close_lngui()
        TryRun("https://www.mmo-champion.com/content/")
        return
    }

    if (input == "wow raid tank cheat sheet") ; Wow Google Sheet raid cheat sheet
    {
        close_lngui()
        TryRun("https://docs.google.com/spreadsheets/d/1Cql9m6Ckh78qVhMUDI65wcmnQ2oeImXwOdYWwX3Vz40/edit?gid=0#gid=0")
        return
    }

    if (input == "wow rbs") ; Wow Raidbots simulation
    {
        close_lngui()
        TryRun("https://www.raidbots.com/simbot")
        return
    }

    if (input == "wow rio p") ; Wow Raider IO Profile
    {
        close_lngui()
        TryRun("https://raider.io/characters/us/thrall/Multitiamat")
        return
    }

    if (input == "wow wh dh h") ; Wow Wowhead DH Havoc
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/demon-hunter/havoc/overview-pve-dps")
        return
    }

    if (input == "wow wh dh v") ; Wow Wowhead DH Veng
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/demon-hunter/vengeance/overview-pve-tank")
        return
    }

    if (input == "wow wh dk b") ; Wow Wowhead DK Blood
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/death-knight/blood/overview-pve-tank")
        return
    }

    if (input == "wow wh dk f") ; Wow Wowhead DK Frost
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/death-knight/frost/overview-pve-dps")
        return
    }

    if (input == "wow wh dk u") ; Wow Wowhead DK Unholy
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/death-knight/unholy/overview-pve-dps")
        return
    }

    if (input == "wow wh dr b") ; Wow Wowhead Druid Balance
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/druid/balance/overview-pve-dps")
        return
    }

    if (input == "wow wh dr f") ; Wow Wowhead Druid Feral
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/druid/feral/overview-pve-dps")
        return
    }

    if (input == "wow wh dr g") ; Wow Wowhead Druid Guard
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/druid/guardian/overview-pve-tank")
        return
    }

    if (input == "wow wh dr r") ; Wow Wowhead Druid Resto
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/druid/restoration/overview-pve-healer")
        return
    }

    if (input == "wow wh ev a") ; Wow Wowhead Evoker Augmentation
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/evoker/augmentation/overview-pve-dps")
        return
    }

    if (input == "wow wh ev d") ; Wow Wowhead Evoker Devastation
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/evoker/devastation/overview-pve-dps")
        return
    }

    if (input == "wow wh ev p") ; Wow Wowhead Evoker Preservation
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/evoker/preservation/overview-pve-healer")
        return
    }

    if (input == "wow wh h b") ; Wow Wowhead Hunter Beastmaster
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/hunter/beast-mastery/overview-pve-dps")
        return
    }

    if (input == "wow wh h m") ; Wow Wowhead Hunter Marksman
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/hunter/marksmanship/overview-pve-dps")
        return
    }

    if (input == "wow wh h s") ; Wow Wowhead Hunter Survival
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/hunter/survival/overview-pve-dps")
        return
    }

    if (input == "wow wh ma a") ; Wow Wowhead Mage Arcane
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/mage/arcane/overview-pve-dps")
        return
    }

    if (input == "wow wh ma fi") ; Wow Wowhead Mage Fire
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/mage/fire/overview-pve-dps")
        return
    }

    if (input == "wow wh ma fr") ; Wow Wowhead Mage Frost
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/mage/frost/overview-pve-dps")
        return
    }

    if (input == "wow wh mo b") ; Wow Wowhead Monk Brew
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/monk/brewmaster/overview-pve-tank")
        return
    }

    if (input == "wow wh mo m") ; Wow Wowhead Monk Mistweaver
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/monk/mistweaver/overview-pve-healer")
        return
    }

    if (input == "wow wh mo w") ; Wow Wowhead Monk Windwalker
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/monk/windwalker/overview-pve-dps")
        return
    }

    if (input == "wow wh pa h") ; Wow Wowhead Paladin Holy
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/paladin/holy/overview-pve-healer")
        return
    }

    if (input == "wow wh pa p") ; Wow Wowhead Paladin Protection
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/paladin/protection/overview-pve-tank")
        return
    }

    if (input == "wow wh pa r") ; Wow Wowhead Paladin Ret
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/paladin/retribution/overview-pve-dps")
        return
    }

    if (input == "wow wh pr d") ; Wow Wowhead Priest Disc
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/priest/discipline/overview-pve-healer")
        return
    }

    if (input == "wow wh pr h") ; Wow Wowhead Priest Holy
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/priest/holy/overview-pve-healer")
        return
    }

    if (input == "wow wh pr s") ; Wow Wowhead Priest Shadow
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/priest/shadow/overview-pve-dps")
        return
    }

    if (input == "wow wh r a") ; Wow Wowhead Rogue Assassination
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/rogue/assassination/overview-pve-dps")
        return
    }

    if (input == "wow wh r o") ; Wow Wowhead Rogue Outlaw
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/rogue/outlaw/overview-pve-dps")
        return
    }

    if (input == "wow wh r s") ; Wow Wowhead Rogue Subtlety
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/rogue/subtlety/overview-pve-dps")
        return
    }

    if (input == "wow wh s eh") ; Wow Wowhead Shaman Enhancement
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/shaman/enhancement/overview-pve-dps")
        return
    }

    if (input == "wow wh s el") ; Wow Wowhead Shaman Elemental
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/shaman/elemental/overview-pve-dps")
        return
    }

    if (input == "wow wh s r") ; Wow Wowhead Shaman Resto
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/shaman/restoration/overview-pve-healer")
        return
    }

    if (input == "wow wh w a") ; Wow Wowhead Warrior Arms
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/warrior/arms/overview-pve-dps")
        return
    }

    if (input == "wow wh w aff") ; Wow Wowhead Warlock Affliction
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/warlock/affliction/overview-pve-dps")
        return
    }

    if (input == "wow wh w dem") ; Wow Wowhead Warlock Demonology
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/warlock/demonology/overview-pve-dps")
        return
    }

    if (input == "wow wh w des") ; Wow Wowhead Warlock Destruction
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/warlock/destruction/overview-pve-dps")
        return
    }

    if (input == "wow wh w f") ; Wow Wowhead Warrior Fury
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/warrior/fury/overview-pve-dps")
        return
    }

    if (input == "wow wh w p") ; Wow Wowhead Warrior Protection
    {
        close_lngui()
        TryRun("https://www.wowhead.com/guide/classes/warrior/protection/overview-pve-tank")
        return
    }

    if (input == "wow wla") ; Wow Warcraft Logs Uploader App
    {
        close_lngui()
        TryRun(TryGetValueFromINIFile("WowWarcraftLogUploader"))
        return
    }

    if (input == "wow wlw") ; Wow Warcraft Logs Website
    {
        close_lngui()
        TryRun("https://www.warcraftlogs.com/profile")
        return
    }

    if (input == "wuwa chars") ; Wuthering Waves Character Tier List
    {
        close_lngui()
        TryRun("https://game8.co/games/Wuthering-Waves/archives/454729")
        return
    }

    if (input == "wuwa guides") ; Wuthering Waves Guides
    {
        close_lngui()
        TryRun("https://www.prydwen.gg/wuthering-waves/guides/")
        return
    }

    if (input == "yth") ; YouTube Home
    {
        close_lngui()
        TryRun("https://www.youtube.com")
        return
    }

    if (input == "yts ") ; YouTube Search
    {
        lngui_enable_query("YouTube", make_run_ReplaceTexts_func(
            "https://www.youtube.com/results?search_query=REPLACEME"))
        return
    }

    if (input == "ytw") ; YouTube Watch Later
    {
        close_lngui()
        TryRun("https://www.youtube.com/playlist?list=WL")
        return
    }


}
