local config = {
    minlevel = 150, --- level inical para resetar
    price = 10000, --- preço inicial para resetar
    newlevel = 20, --- level após reset
    priceByReset = 0, --- preço acrescentado por reset
    percent = 100, ---- porcentagem da vida/mana que você terá ao resetar (em relação à sua antiga vida total)
    maxresets = 50,
    levelbyreset = 0 --- quanto de level vai precisar a mais no próximo reset
}
--- end config

local function getResets(uid)
    local resets = getPlayerStorageValue(uid, 378378)
    if resets < 0 then
        resets = 0
    end
    return resets
end

local function addReset(cid)
    local resets = getResets(cid)
    setPlayerStorageValue(cid, 378378, resets+1) 
    doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
    local hp = getCreatureMaxHealth(cid)
    local resethp = hp*(config.percent/100)
    setCreatureMaxHealth(cid, resethp)
    local differencehp = (hp - resethp)
    doCreatureAddHealth(cid, -differencehp)
    local mana = getCreatureMaxMana(cid)
    local resetmana = mana*(config.percent/100)
    setCreatureMaxMana(cid, resetmana)
    local differencemana = (mana - resetmana)
    doCreatureAddMana(cid, -differencemana)
    local guid = getPlayerGUID(cid)
    doRemoveCreature(cid)        
    local description = resets+1
    db.query("UPDATE `players` SET `description` = ' [Reset: "..description.."]' WHERE `players`.`id`= ".. guid)
    db.query("UPDATE `players` SET `level`="..config.newlevel..",`experience`= 0 WHERE `players`.`id`= ".. guid)
    return true
end

function onSay(cid, words, param, channel)
    local newPrice = config.price + (getResets(cid) * config.priceByReset)
    local newminlevel = config.minlevel + (getResets(cid) * config.levelbyreset)
    if param == "quantity" then
        return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'You have a total of '..getResets(cid)..' reset(s).')
    end

    if getResets(cid) >= config.maxresets then
		return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,'You already have reached the maximum of '.. config.maxresets.. ' resets!')
    elseif getPlayerMoney(cid) < newPrice then
        return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,'Its necessary to have at least '..newPrice..' gp\'s for reseting!')
    elseif getPlayerLevel(cid) < newminlevel then
        return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,'The minimum level for reseting is '..newminlevel..'!')
    end

    doPlayerRemoveMoney(cid,newPrice)
    addEvent(function()
        if isPlayer(cid) then
            addReset(cid)
        end
        end, 3000)
    local number = getResets(cid)+1
    local msg ="---[Reset: "..number.."]-- You have reseted!  You'll be disconnected in 3 seconds."
    doPlayerPopupFYI(cid, msg)
    return true
end