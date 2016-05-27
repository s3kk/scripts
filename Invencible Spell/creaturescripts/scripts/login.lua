---------- Invencible ----------------
registerCreatureEvent(cid, "invencible")
if getPlayerStorageValue(cid, 3482101) ~= 0 then
        setPlayerStorageValue(cid, 3482101, 0) 
end