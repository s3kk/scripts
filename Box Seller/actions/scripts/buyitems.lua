local coin = 9020 -- sua moeda vip
local lever = {
[6001] = {30,7429},
[6002] = {20,7366},
[6003] = {10,8926},
[6004] = {5,5978}
}
function onUse(cid,item,fromPosition,itemEx,toPosition)
                  if doPlayerRemoveItem(cid,coin,lever[item.actionid][1]) == FALSE then
                  return doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "você precisa de "..lever[item.actionid][1].." " ..getItemNameById(coin))
                  end
                                doPlayerAddItem(cid,lever[item.actionid][2], isItemStackable(lever[item.actionid][2]) and 1 or 1)
                                doPlayerSendTextMessage(cid,22,"você comprou um " .. getItemNameById(lever[item.actionid][2]))
                                doSendMagicEffect(getCreaturePosition(cid), math.random(28,30))
                return true
end