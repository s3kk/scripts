function getItemDodgePercent(itemuid)
return getItemAttribute(itemuid, "dodgePercent")
end
function doPlayerAddDodgeItem(cid, itemid, percent)
local item = doPlayerAddItem(cid, itemid)
doItemSetAttribute(item, "description", "[Dodge: "..percent.."%]")
doItemSetAttribute(item, "dodgePercent", percent)
end