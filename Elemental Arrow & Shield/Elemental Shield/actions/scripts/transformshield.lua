local ITEM_IDS = {
[8905] = 8906,
[8907] = 8906,
[8906] = 8909,
[8909] = 8907,
[8907] = 8908,
[8908] = 8905,
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
if(not ITEM_IDS[item.itemid]) then
return false
end

doTransformItem(item.uid, ITEM_IDS[item.itemid])
doDecayItem(item.uid)
return true
end