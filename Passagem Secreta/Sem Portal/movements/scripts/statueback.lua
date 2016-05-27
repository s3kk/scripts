-- Do not remove the credits --
-- [MOVEMENT] Secret Teleport --
-- Developed by Rigby (João Vitor) --
 
    local fields = {1492, 1495} -- id do fire field e energy field
    local tile1 = {x = 1000, y = 1012, z = 7, stackpos= 1} -- Posição do tile 1
    local tile2 = {x = 1002, y = 1012, z = 7, stackpos= 1} -- Posição do tile 2
    local statue_Of_Position = {x = 1001, y = 1012, z = 7} -- posição onde fica a estátua, que ira aparecer o teleport
    local teleport = {x = 1001, y = 1015, z = 7} -- posição da onde o player vai quando entrar no teleport
    local go_Backward = {x = 1001, y = 1011, z = 7} -- Posição para aonde a estátua vai
    local statue = 3697 -- id da estátua
	
function onAddItem(cid, moveitem, tileitem, position)
    if getItemStack(go_Backward, statue) then
        if getItemStack(tile1, fields[1]) then
            doRemoveItem(getItemStack(tile1, fields[1]).uid, 1)
        elseif getItemStack(tile1, fields[2]) then
            doRemoveItem(getItemStack(tile1, fields[2]).uid, 1)
        elseif getItemStack(tile2, fields[1]) then
            doRemoveItem(getItemStack(tile2, fields[1]).uid, 1)
        elseif getItemStack(tile2, fields[2]) then
            doRemoveItem(getItemStack(tile2, fields[2]).uid, 1)
        end
    end 
end

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bem vindo.")
	doTeleportThing(cid, teleport)
	local teleport = doCreateItem(statue, 1, statue_Of_Position)
    doItemSetAttribute(teleport, "aid", 6567) -- actionid
    doRemoveItem(getItemStack(go_Backward, statue).uid, 1)
	return true
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