function onUse(cid, item, fromPosition, itemEx, toPosition)

local items = {6497,2472,2471} -- defina seus itens

local r = items[math.random(#items)]

doPlayerSendTextMessage(cid,22,"Você ganhou uma "..getItemNameById(r))

return doTransformItem(item.uid, r)

end