// -- // -- // -- // -- // -- // -- // -- //
// This addon can't work without Linventif Library : https://linv.dev/docs/#library
// Some configuration are only editable in Linventif Monitor : https://linv.dev/docs/#monitor
// If you have any problem with this addon please contact me on discord : https://linv.dev/discord
// -- // -- // -- // -- // -- // -- // -- //

// -- // -- // -- // -- // -- // -- // -- // -- // -- //

local folder = "linvlib"
local name = "Linventif Library"
local license = "CC BY-SA 4.0"
local version = "0.2.3"

LinvLib = {
    ["Config"] = {},
    ["Install"] = {},
    ["Info"] = {["name"] = name, ["version"] = version, ["folder"] = folder, ["license"] = license}
}

// -- // -- // -- // -- // -- // -- // -- // -- // -- //

if SERVER then AddCSLuaFile("linvlib/server/sh_linventif_loader.lua") end
include("linvlib/server/sh_linventif_loader.lua")

// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.Install[folder] = version
LinvLib.LoadStr(name, version, license)
LinvLib.LoadTrad("resource/localization/", folder, name)
LinvLib.Loader(folder, name)