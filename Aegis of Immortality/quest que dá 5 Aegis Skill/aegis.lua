function onUse(cid, item)
local storage = 19332
if getPlayerStorageValue(cid, storage) ~= 5 then
doPlayerSetStorageValue(cid, storage, 5)
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have habilited your [BOSS SKILL]")
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your [BOSS SKILL] is already with "..getPlayerStorageValue(cid, storage).." charges.")
end
return true
end