function onLogin(cid)
local pos = {x = 1002, y = 1019, z = 7}
local storage = 21590

   if getPlayerStorageValue(cid, storage) <= 0 and getPlayerPremiumDays(cid) >= 1 then
      setPlayerStorageValue(cid, storage, 1)
   end

   if getPlayerPremiumDays(cid) >= 1 then
   doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você tem "..getPlayerPremiumDays(cid).." dias de premium restantes.")
   else
   doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você é free account.")
   end
   
   if getPlayerStorageValue(cid, storage) >= 1 and getPlayerPremiumDays(cid) <= 0 then
      doTeleportThing(cid, pos)
      doPlayerSendTextMessage(cid, 25, "Sua premium expirou.")
      setPlayerStorageValue(cid, storage, -1)
      doSendMagicEffect(getPlayerPosition(cid), 13)
   end
 return true
end