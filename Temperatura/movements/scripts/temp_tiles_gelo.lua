function onStepIn(cid, item, position, fromPosition)

if isPlayer(cid) then
setPlayerStorageValue(cid, 121314, -20)
end

return true
end

function onStepOut(cid, item, position, fromPosition)

pos = {x=position.x,y=position.y,z=position.z,stackpos=0}
ground = getThingFromPos(pos)


--- GELO tiles----

gelo_tile = {}

gelo_tileid_min = 6580
gelo_tileid_max = 6608

for i=gelo_tileid_min, gelo_tileid_max, 1 do  
    table.insert(gelo_tile,i)
end             
---------------

if not isInArray(gelo_tile,ground.id) then
setPlayerStorageValue(cid, 121314, 0)
end

return true
end