// -- // -- // -- // -- // -- // -- // -- // -- // -- //
// Please don't use a static version of this addon
// Please use the workshop version : https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990
// If you don't use the workshop version, you will not receive any update and you will not be able to use new features or addons I will create.
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.ServerConfig.InGameSettings = true // Put to false if you want to change the configuration in this file

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//             SQL DATABASE CONFIGURATION             //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.ServerConfig.UseExternalDatabase = false // Do you want to use an external database ?
LinvLib.ServerConfig.SQL = { // If you want to use an external database, please fill this table
    ["host"] = "",
    ["port"] = 3306,
    ["database"] = "",
    ["username"] = "",
    ["password"] = ""
}