local languages = {
    ["english"] = {
        ["not_allow_cmd"] = "You are not allowed to use this command!",
        ["not_perm"] = "You don't have the permission to do this!",
        ["save_setting"] = "Settings Sucessfully Saved.",
        ["new_setting_received"] = "LinvLib : New Settings Received.",
    },
}

// -- // -- // -- // -- // -- // -- // -- //
// DO NOT EDIT BELOW THIS LINE
// -- // -- // -- // -- // -- // -- // -- //

function LinvLib:GetTrad(id)
    if languages[LinvLib.Config.Language] && languages[LinvLib.Config.Language][id] then
        return languages[LinvLib.Config.Language][id]
    else
        return id
    end
end