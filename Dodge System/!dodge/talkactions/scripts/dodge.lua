local dodge = 48902
function onSay(cid)
if getPlayerStorageValue(cid, dodge) >= 1 then
doShowTextDialog(cid, 2175, "Voce possui "..getPlayerStorageValue(cid, dodge).." dodges.")
else
doPlayerSendCancel(cid,"Voce nao possui dodges.")
end
return 1
end