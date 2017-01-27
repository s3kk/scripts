function onLogin(cid)

	registerCreatureEvent(cid, "resetlook")

	return true

end


function getResets(cid)
	local query = db.getResult("SELECT `resets` FROM `players` WHERE `id`= "..getPlayerGUID(cid))
	return query:getDataInt("resets") <= 0 and 0 or query:getDataInt("resets")
end


function onLook(cid, thing, position, lookDistance)

	if isPlayer(thing.uid) and thing.uid ~= cid then

		doPlayerSetSpecialDescription(thing.uid,' [Resets: '..getResets(thing.uid)..']')

		return true

	elseif thing.uid == cid then

		doPlayerSetSpecialDescription(cid,' [Resets: '..getResets(thing.uid)..']')

		local string = 'You see yourself. (Level: '..getPlayerLevel(thing.uid)..')'

		if getPlayerFlagValue(cid, PLAYERFLAG_SHOWGROUPINSTEADOFVOCATION) then

			string = string..' You are '.. getPlayerGroupName(cid) ..'.'

		elseif getPlayerVocation(cid) ~= 0 then

			string = string..' You are '.. getPlayerVocationName(cid) ..'.'

		else

			string = string..' You have no vocation.'

		end

		string = string..getPlayerSpecialDescription(cid)..''


		if getPlayerNameByGUID(getPlayerPartner(cid), false, false) ~= nil then

			string = string..' You are '.. (getPlayerSex(cid) == 0 and 'wife' or 'husband') ..' of '.. getPlayerNameByGUID(getPlayerPartner(cid)) ..'.'

		end


		if getPlayerGuildId(cid) > 0 then

			string = string..' You are ' .. (getPlayerGuildRank(cid) == '' and 'a member' or getPlayerGuildRank(cid)) ..' of the '.. getPlayerGuildName(cid)

			string = getPlayerGuildNick(cid) ~= '' and string..' ('.. getPlayerGuildNick(cid) ..').' or string..'.'

		end


		if getPlayerFlagValue(cid, PLAYERCUSTOMFLAG_CANSEECREATUREDETAILS) then

			string = string..' Health: ['.. getCreatureHealth(cid) ..' / '.. getCreatureMaxHealth(cid) ..'], Mana: ['.. getCreatureMana(cid) ..' / '.. getCreatureMaxMana(cid) ..'].'

			string = string..' IP: '.. doConvertIntegerToIp(getPlayerIp(cid)) ..'.'

		end


		if getPlayerFlagValue(cid, PLAYERCUSTOMFLAG_CANSEEPOSITION) then

			string = string..' Position: [X:'.. position.x..'] [Y:'.. position.y..'] [Z:'.. position.z..'].'

		end

		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)  

		return false

	end

	return true

end