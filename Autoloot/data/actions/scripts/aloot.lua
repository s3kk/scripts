function onUse(cid, item, frompos, item2, topos)

local days,stor = 1, 91911

if getPlayerStorageValue(cid, stor) >= os.time() then
	doPlayerSendCancel(cid, 'você ainda tem até '..os.date("%d %B %Y %X", getPlayerStorageValue(cid,stor))..' de AutoLoot.') return true
end

setPlayerStorageValue(cid, stor, os.time()+days*86400)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,'Você recebeu '..days..' dias de AutoLoot, irá durar até '..os.date("%d %B %Y %X", getPlayerStorageValue(cid,stor))..'.')
doRemoveItem(item.uid) return true
end