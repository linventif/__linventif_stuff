concommand.Add("linvlib_sql", function(ply, cmd, args)
    if !args[1] || !args[2] then return end
    if args[1] == "show" then
        local sql_data = sql.Query("SELECT * FROM "..args[2])
        if sql_data then
            PrintTable(sql_data)
        else
            print("No data found in table "..args[2])
        end
    elseif args[1] == "clear" then
        sql.Query("DELETE FROM "..args[2])
        print("Table "..args[2].." cleared")
    elseif args[1] == "delete" then
        sql.Query("DROP TABLE "..args[2])
        print("Table "..args[2].." deleted")
    else
        print("Invalid argument")
    end
end)