local config = {
	minlevel = 150, --- level inical para resetar
	price = 0, --- preço inicial para resetar
	newlevel = 8, --- level após reset
	priceByReset = 0, --- preço acrescentado por reset
	percent = 100, ---- porcentagem da vida/mana que você terá ao resetar (em relação à sua antiga vida total)
	maxresets = 50,
	levelbyreset = 0 --- quanto de level vai precisar a mais no próximo reset
}
local function getResets(cid)
	local query = db.getResult("SELECT `resets` FROM `players` WHERE `id`= "..getPlayerGUID(cid))
	return query:getDataInt("resets") <= 0 and 0 or query:getDataInt("resets")
end
local function addReset(cid)
	local resets = getResets(cid)
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
	db.query("UPDATE `players` SET  `level` = "..config.newlevel..", `experience`= 0, `resets`= "..description.." WHERE `players`.`id`= ".. guid)
	return true
end

function onSay(cid, words, param, channel)
	local var = getResets(cid)
	local newPrice = config.price + (var * config.priceByReset)
	local newminlevel = config.minlevel + (var * config.levelbyreset)
	if param == "quantity" then
		return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'You have a total of '..var..' reset(s).')
	end
	if var >= config.maxresets then
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
	local number = var+1
	local msg ="---[Reset: "..number.."]-- You have reseted! You'll be disconnected in 3 seconds."
	doPlayerPopupFYI(cid, msg)
	return true
end