// -- // -- // -- // -- // -- // -- // -- // -- // -- //
// Please don't use a static version of this addon
// Please use the workshop version : https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990
// If you don't use the workshop version, you will not receive any update and you will not be able to use new features or addons I will create.
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//             SQL DATABASE CONFIGURATION             //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.ConfigSQL_UseExternalDatabase = false // Do you want to use an external database ?
LinvLib.ConfigSQL = { // If you want to use an external database, please fill this table
    ["host"] = "localhost",
    ["username"] = "username",
    ["password"] = "password",
    ["database"] = "database",
    ["port"] = 3306
}