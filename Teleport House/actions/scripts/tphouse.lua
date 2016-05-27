function onUse(cid, item, fromPosition, itemEx, toPosition)
 if hasCondition(cid, CONDITION_INFIGHT) then  
  return doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Desculpe,voce esta em batalha.")
 end
 
 if getPlayerLevel(cid) < getConfigInfo("levelToBuyHouse") then
  return doPlayerSendCancel(cid, "Sorry, not possible.")
 end
 
 if not getHouseByPlayerGUID(getPlayerGUID(cid)) then
  return doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Desculpe voce nao tem house.")
 end
 
 doTeleportThing(cid, getHouseEntry(getHouseByPlayerGUID(getPlayerGUID(cid))))
 return true
end