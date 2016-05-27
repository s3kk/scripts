local tpId = 1387
local tp = {
    info = {
        pos = {x = 1002, y = 1022, z = 7},
        toPos = {x = 1002, y = 1019, z = 7},
        time = 10,
    },
    kill = {
        ["Demon"] = {count = 2, str = 10629},
        ["Dragon"] = {count = 1, str = 10630},
    },
}
 
function checkTask()
    for name, info in pairs(tp.kill) do
        if getGlobalStorageValue(info.str) < info.count then
            return false
        end
    end
    return true
end
 
function removeTp(tp)
    local t = getTileItemById(tp.info.pos, tpId)
    if t then
        doRemoveItem(t.uid, 1)
        doSendMagicEffect(tp.info.pos, CONST_ME_POFF)
    end
end
 
function onDeath(cid)
    local m = tp.kill[getCreatureName(cid)]
    if not tp then
        return true
    end
    setGlobalStorageValue(m.str, getGlobalStorageValue(m.str) < 0 and 1 or getGlobalStorageValue(m.str) + 1)
    if checkTask() then
        doCreateTeleport(tpId, tp.info.toPos, tp.info.pos)
        doCreatureSay(cid, "O teleport irá sumir em "..tp.info.time.." segundos.", TALKTYPE_ORANGE_1)
        addEvent(removeTp, tp.info.time * 1000, tp)
        for _, info in pairs(tp.kill) do
            setGlobalStorageValue(info.str, -1)
        end
    end
    return true
end