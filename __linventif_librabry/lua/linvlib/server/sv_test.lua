util.AddNetworkString("LinvLib:Equip")
util.AddNetworkString("LinvLib:Unequip")

local item_type_action = {
    ["weapon"] = {
        ["Primary Weapon"] = true,
        ["Secondary Weapon"] = true,
        ["Melee Weapon"] = true,
    },
    ["armor"] = {
        ["Armor"] = true,
    },
}

net.Receive("LinvLib:Equip", function(len, ply)
    local state = net.ReadBool()
    local data = util.JSONToTable(net.ReadString())
    if !ply:Alive() then return end
    if state then
        if item_type_action["weapon"][data["type"]] then
            ply:Give(data.cmd)
            ply:SelectWeapon(data.cmd)
        elseif item_type_action["armor"][data["type"]] then
            ply:SetArmor(100)
        end
    else
        if item_type_action["weapon"][data["type"]] then
            ply:StripWeapon(data.cmd)
        elseif item_type_action["armor"][data["type"]] then
            ply:SetArmor(0)
        end
    end
end)