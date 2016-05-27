local up = {
{0, 1, 1, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 2, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0}         
}

 local area1 = createCombatArea(up)
 
local down = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 2, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 1, 1, 0}
}

 local area2 = createCombatArea(down)
 
local left = {
{0, 0, 0, 0, 0},
{1, 0, 0, 0, 0},
{1, 1, 2, 0, 0},
{1, 0, 0, 0, 0},
{0, 0, 0, 0, 0}
}

 local area3 = createCombatArea(left)
 
local right = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 1},
{0, 0, 2, 1, 1},
{0, 0, 0, 0, 1},
{0, 0, 0, 0, 0}
}

local area4 = createCombatArea(right)


local tempo = 1 -- tempo entre 1 uso e outro
local storage = 19481

function onUse(cid, item, frompos, item2, topos)
if getPlayerSlotItem(cid, 5).itemid == item.itemid or getPlayerSlotItem(cid, 6).itemid == item.itemid then
if not exhaustion.get(cid, storage) then
exhaustion.set(cid, storage, tempo)
if getPlayerLookDirection(cid) == 0 then
doAreaCombatHealth(cid, 1, getThingPos(cid), area2, -(getPlayerLevel(cid) * 2 / 3), -(getPlayerLevel(cid) * 4 / 3), 15)
elseif getPlayerLookDirection(cid) == 1 then
doAreaCombatHealth(cid, 1, getThingPos(cid), area3, -(getPlayerLevel(cid) * 2 / 3), -(getPlayerLevel(cid) * 4 / 3), 15)
elseif getPlayerLookDirection(cid) == 2 then
doAreaCombatHealth(cid, 1, getThingPos(cid), area1, -(getPlayerLevel(cid) * 2 / 3), -(getPlayerLevel(cid) * 4 / 3), 15)
elseif getPlayerLookDirection(cid) == 3 then
doAreaCombatHealth(cid, 1, getThingPos(cid), area4, -(getPlayerLevel(cid) * 2 / 3), -(getPlayerLevel(cid) * 4 / 3), 15)
end
else
doPlayerSendCancel(cid, "You are exhausted.")
end
end
return true
end