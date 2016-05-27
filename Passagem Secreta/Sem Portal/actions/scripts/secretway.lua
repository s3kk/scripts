-- Do not remove the credits --
-- [ACTION] Secret Teleport --
-- Developed by Rigby (João Vitor) --
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
    local fields = {1492, 1495} -- id do fire field e energy field
    local tile1 = {x = 1000, y = 1012, z = 7, stackpos= 1} -- Posição do tile 1
    local tile2 = {x = 1002, y = 1012, z = 7, stackpos= 1} -- Posição do tile 2
    local statue_Of_Position = {x = 1001, y = 1012, z = 7} -- posição onde fica a estátua, que ira aparecer o teleport
    local teleport = {x = 1001, y = 1015, z = 7} -- posição da onde o player vai quando entrar no teleport
    local go_Backward = {x = 1001, y = 1011, z = 7} -- Posição para aonde a estátua vai
    local statue = 3697 -- id da estátua
    local tempo = 5 -- tempo em segundos que o teleporte ficara aberto
 
    local pos1 = getThingfromPos(tile1)
    local pos2 = getThingfromPos(tile2)
    if (pos1.itemid == fields[1] and pos2.itemid == fields[2]) or (pos1.itemid == fields[2] and pos2.itemid == fields[1]) then
        if getItemStack(statue_Of_Position, statue) then
            doRemoveItem(getItemStack(statue_Of_Position, statue).uid, 1)
            doCreateItem(statue, 1, go_Backward)
            local teleport = doCreateItem(424, 1, statue_Of_Position)
            doItemSetAttribute(teleport, "aid", 5555) -- actionid
            if getItemStack(tile1, fields[1]) then
                doRemoveItem(getItemStack(tile1, fields[1]).uid, 1)
                doRemoveItem(getItemStack(tile2, fields[2]).uid, 1)
            else
                doRemoveItem(getItemStack(tile1, fields[2]).uid, 1)
                doRemoveItem(getItemStack(tile2, fields[1]).uid, 1)
            end
            addEvent(function()
                if getItemStack(go_Backward, statue) then
                    	local teleport = doCreateItem(statue, 1, statue_Of_Position)
    doItemSetAttribute(teleport, "aid", 6567) -- actionid
                    doRemoveItem(getItemStack(go_Backward, statue).uid, 1)
                end
            end, tempo*1000)
        end
    end
end
 
 
function getItemStack(pos, iid)
    for i = 1, 255 do
        posa = getThingFromPos({x=pos.x, y=pos.y, z=pos.z, stackpos=i})
        if posa.itemid == iid then
        return posa
        end
    end
return nil
end