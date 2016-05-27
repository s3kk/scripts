function isHandItem(uid) -- NW based on Mock
         uid = uid or 0
        if isInArray({1,2,3,4,5,6}, getItemWeaponType(uid)) then
             return true
         end
         return false
end


function getItemDodgePercent(itemuid)
return getItemAttribute(itemuid, "dodgePercent") or 0
end


function setItemDodgePercent(uid, percent)
doItemSetAttribute(uid, "description", "[Dodge: "..percent.."%]")
doItemSetAttribute(uid, "dodgePercent", percent)
end








function onUse(cid, item, fromPosition, itemEx, toPosition) 
level = 0
local upgrade = {
[1] = {min = 1, max = 5, chance = 100},
[2] = {min = 5, max = 10, chance = 80},
[3] = {min = 10, max = 20, chance = 60},
[4] = {min = 20, max = 40, chance = 40},
[5] = {min = 40, max = 50, chance = 20}
}


function isWearing(uid) -- NW based on Mock
         uid = uid or 0
        if isInArray({uid}, getPlayerSlotItem(cid, 1).uid) or isInArray({uid}, getPlayerSlotItem(cid, 4).uid) or isInArray({uid}, getPlayerSlotItem(cid, 7).uid) or isInArray({uid}, getPlayerSlotItem(cid, 8).uid) then
             return true
         end
         return false
end




if isHandItem(itemEx.uid) or isWearing(itemEx.uid) then
local name = getItemName(itemEx.uid)
local atual = math.floor(getItemDodgePercent(itemEx.uid)*10)/10
for i = 1, #upgrade do
if string.find(tostring(name),"+".. i .."") then
level = i
end
end


if level >= #upgrade then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,"Your item is already on max level, you can't upgrade it any further.")
return true
end




if math.random(0,100) <= upgrade[level + 1].chance then 
doRemoveItem(item.uid, 1)
doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,"You leveled your "..getItemNameById(itemEx.itemid).." to ".. level+1 ..".")
setItemDodgePercent(itemEx.uid, atual + (math.random(upgrade[level+1].min,upgrade[level+1].max))/10)
doItemSetAttribute(itemEx.uid,'name', getItemNameById(itemEx.itemid)..' +'..(level+1))
doSendMagicEffect(toPosition, math.random(28,30))
else
doRemoveItem(itemEx.uid, 1)
doRemoveItem(item.uid, 1)
doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,"Your "..getItemNameById(item.itemid).." has failed and destroyed your "..getItemNameById(itemEx.itemid).." in the process")
doSendMagicEffect(toPosition, 4)
end


else
doPlayerSendTextMessage(cid, 24,"You cant refine this item.")
end
return true
end