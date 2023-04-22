local netfunc = {
    [1] = function(data)
        print("Time : " .. net.ReadInt(32))
    end
}

net.Receive("LinvLib", function(data)
    local id = net.ReadUInt(8)
    if netfunc[id] then
        netfunc[id](data)
    end
end)