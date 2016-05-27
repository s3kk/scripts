local t = {
["Temple"] = {pos = {x = 1000, y = 1000, z = 7}, storage = 79402, time = 30},
["Teleports"] = {pos = {x = 2000, y = 2000, z = 7}, storage = 79402, time = 30},
["Trainers"] = {pos = {x = 3000, y = 3000, z = 7}, storage = 79403, time = 30}
}

function onTextEdit(cid, item, newText)
if item.itemid == 1949 then
if isPlayerPzLocked(cid) then
doCreatureSay(cid, "Voce esta com battle!", TALKTYPE_MONSTER)
return false
end
if isInArray({'locations', 'places', 'place'}, newText) then
local i = ''
for text, x in pairs(t) do
i = i .. "\n[" .. text .. "]"
end

doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Locais de teleportes: " .. i)
else
local p = t[newText]
if not p then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Local invalido")
return false
end

local st = p.storage
if getCreatureStorage(cid, st) > os.time() then
doCreatureSay(cid, "Voce precisa esperar " .. getCreatureStorage(cid, st) - os.time() .. ' segundo(s)' .. (getCreatureStorage(cid, st) - os.time() == 1 and "" or "s") .. " para teleportar novamente.", TALKTYPE_MONSTER)
return true
end

local ti = p.time
local pos = p.pos
doTeleportThing(cid, pos, true)
doSendMagicEffect(pos, CONST_ME_TELEPORT)
doCreatureSetStorage(cid, st, os.time() + ti)
doCreatureSay(cid, "Voce foi teleportado!", TALKTYPE_MONSTER)
end
end
return true
end