local ITEM_IDS = {
[7850] = 7839,
[7838] = 7839,
[7839] = 7840,
[7840] = 7838,
[7838] = 7850,
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
if(not ITEM_IDS[item.itemid]) then
return false
end

doTransformItem(item.uid, ITEM_IDS[item.itemid])
doDecayItem(item.uid)
return true
end