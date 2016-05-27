--- CRITICAL SYSTEM ----
registerCreatureEvent(cid, "critical")
if getPlayerStorageValue(cid, 48913) == -1 then
        setPlayerStorageValue(cid, 48913, 0) 
    end 