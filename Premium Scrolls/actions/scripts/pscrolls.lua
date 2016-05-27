--Config--
local Scrolls = 
{
[9004] = {20, "You bought 20 premium days."},
[8981] = {10, "You bought 10 premium days."}
}
local DaysLimit = 360 -- Limite de dias premium
--Config end --
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
if(Scrolls[item.itemid] ~= nil) then
if(getPlayerPremiumDays(cid) + Scrolls[item.itemid][1]) >= DaysLimit then
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You can't buy more than "..DaysLimit.." premium days.")
else
doPlayerAddPremiumDays(cid, Scrolls[item.itemid][1])
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, Scrolls[item.itemid][2])
doRemoveItem(item.uid, 1)
end
return TRUE
end
return FALSE
end