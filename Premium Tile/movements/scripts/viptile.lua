function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then
        return true
    end
    
if getPlayerPremiumDays(cid) <= 0 then
doPlayerSendCancel(cid, "Apenas premium accounts podem passar aqui.")
doTeleportThing(cid, fromPosition)
doSendMagicEffect(position, 13)
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Bem-Vindo a area premium.")
doSendMagicEffect(position, 12)
end
return true
end