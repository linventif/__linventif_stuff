//
// This Functions are only usable if server is in Debug Mode and by superadmins only
//

hook.Add("PlayerSpawnVehicle", "LinvLib:Debug:PlayerSpawnVehicle", function(ply, model, name, vtable)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(model) then return end
    if !isstring(name) then return end
    if !istable(vtable) then return end

    return true
end)

hook.Add("PlayerSpawnSWEP", "LinvLib:Debug:PlayerSpawnSWEP", function(ply, class, swep)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(class) then return end
    if !isstring(swep) then return end

    return true
end)

hook.Add("PlayerSpawnSENT", "LinvLib:Debug:PlayerSpawnSENT", function(ply, class)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(class) then return end

    return true
end)

hook.Add("PlayerSpawnRagdoll", "LinvLib:Debug:PlayerSpawnRagdoll", function(ply, model)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(model) then return end

    return true
end)

hook.Add("PlayerSpawnProp", "LinvLib:Debug:PlayerSpawnProp", function(ply, model)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(model) then return end

    return true
end)

hook.Add("PlayerSpawnObject", "LinvLib:Debug:PlayerSpawnObject", function(ply, model, skin)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(model) then return end
    if !isnumber(skin) then return end

    return true
end)

hook.Add("PlayerSpawnNPC", "LinvLib:Debug:PlayerSpawnNPC", function(ply, npc_type, weapon)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(npc_type) then return end
    if !isstring(weapon) then return end

    return true
end)

hook.Add("PlayerSpawnEffect", "LinvLib:Debug:PlayerSpawnEffect", function(ply, model)
    if !LinvLib.debug then return end
    if !ply:IsLinvLibSuperAdmin() then return end

    if !IsValid(ply) then return end
    if !ply:IsPlayer() then return end
    if !isstring(model) then return end

    return true
end)