// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                 DON'T TOUCH THIS                   //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //
if CLIENT then return end
LinvLib.ServerConfig = LinvLib:LoadSettings("linvlib_server_settings", LinvLib.ServerConfig, LinvLib.Info.version, "LinvLib", true)
LinvLib.Config = LinvLib:LoadSettings("linvlib_settings", LinvLib.Config, LinvLib.Info.version, "LinvLib")