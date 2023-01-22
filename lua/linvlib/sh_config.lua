// -- // -- // -- // -- // -- // -- // -- //
//                                        //
//            Global Settings             //
//                                        //
// -- // -- // -- // -- // -- // -- // -- //

// Main Settings
LinvLib.Config.Language = "english" // Language (english - french) you can add your own language in sh_language.lua
LinvLib.Config.Theme = "linventif" // Theme (linventif - dark - grey - light) you can add your own theme in cl_theme.lua

// Developer Settings
LinvLib.Config.DebugMode = true // Debug (true - false)

// Admin Settings
LinvLib.Config.AdminGroups = { // Admin Group
    ["superadmin"] = true,
    ["admin"] = true,
    ["moderator"] = true,
    ["helper"] = true,
}

// -- // -- // -- // -- // -- // -- // -- //
//                                        //
//       Linventif Library Settings       //
//                                        //
// -- // -- // -- // -- // -- // -- // -- //

// General Settings
LinvLib.Config.Compatibility = { // Compatibility Settings (after the update run linvlib_refresh in the console server)
    ["one_hud"] = false,
    ["sentro_context"] = true,
}

// Admin Settings
LinvLib.Config.AdminMenu = true // Admin Menu (true - false)
LinvLib.Config.AdminMenuExtended = true // Admin Menu Extended (true - false)
LinvLib.Config.AdminTicket = true // Admin Ticket (true - false)
LinvLib.Config.AdminCommands = { // Admin Commands to open the admin menu
    ["!admin_menu"] = true,
    ["/admin_menu"] = true,
    ["!staff_menu"] = true,
    ["/staff_menu"] = true,
}

// Monitor Settings
LinvLib.Config.MonitorShowEveryJoin = true // Monitor Show At Every Connection (true - false)
LinvLib.Config.MonitorShowIfNewUpdate = true // Monitor Show If New Update (true - false)
LinvLib.Config.MonitorShowIfNewAddon = true // Monitor Show If New Addon Detected (true - false)

// Linventif Security Settings
LinvLib.Config.GlobalBan = true // Global Ban (true - false)
LinvLib.Config.PlayerTrustFactor = true // Player Trust Factor (true - false)