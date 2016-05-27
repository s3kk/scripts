function onStepIn(cid, item, position, fromPosition)

if isPlayer(cid) then
setPlayerStorageValue(cid, 121314, 20)
end

return true
end

function onStepOut(cid, item, position, fromPosition)

pos = {x=position.x,y=position.y,z=position.z,stackpos=0}
ground = getThingFromPos(pos)


--------- Deserto Tiles -------------

deserto_tile = {231}          --  Primeira ID "diferente do padrao de "ID=ID + 1 " ^^

deserto_tileid_min = 8315     -- Minimo ID do deserto
deserto_tileid_max = 8322     -- Maximo ID do deserto

for i=deserto_tileid_min, deserto_tileid_max, 1 do
 
  table.insert(deserto_tile,i)

end
-------------------------------------

if not isInArray(deserto_tile,ground.id) then
setPlayerStorageValue(cid, 121314, 0)
end

return true
end