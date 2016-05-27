function onSay(cid, words, param)
	if words == "/itemlist" then
		local itemid = tonumber(param) or false
		if not itemid then
			return true
		end
		local query1 = db.getResult("SELECT name FROM players WHERE id IN (SELECT owner FROM houses WHERE id IN (SELECT house_id FROM tiles WHERE id IN (SELECT tile_id FROM tile_items WHERE itemtype = "..itemid..")))")
		local str = "     Players who have "..getItemNameById(itemid) .. "\n"
		local list = {}
		if query1:getID() > -1 then
			repeat
				local name = query1:getDataString("name")
				table.insert(list, name)
			until not query1:next()
			query1:free()
		end
		local query2 = db.getResult("SELECT name FROM players WHERE id IN (SELECT player_id FROM player_items WHERE itemtype = "..itemid..")")
		if query2:getID() > -1 then
			repeat
				local name = query2:getDataString("name")
				if not isInArray(list, name) then
					table.insert(list, name)
				end
			until not query2:next()
			query2:free()
		end
		local query3 = db.getResult("SELECT name FROM players WHERE id IN (SELECT player_id FROM player_depotitems WHERE itemtype = "..itemid..")")
		if query3:getID() > -1 then
			repeat
				local name = query3:getDataString("name")
				if not isInArray(list, name) then
					table.insert(list, name)
				end
			until not query3:next()
			query3:free()
		end
		if type(list) == "table" and #list == 0 then
			return doShowTextDialog(cid, itemid, "No players with designated item.")
		end
		for _, name in ipairs(list) do
			str = str.. '\n' .. name
		end
		doShowTextDialog(cid, itemid, str)
	elseif words == "/itemcount" then
		local param = string.explode(param, ',')
		local playername = param[1]
		local itemid = tonumber(param[2])
		if not playername or not itemid then
			doPlayerSendTextMessage(cid, 27, "Command syntax: /itemcount playername, itemid")
			return true
		end
		local GUID = getPlayerGUIDByName(playername)
		if not GUID then
			doPlayerSendTextMessage(cid, 27, "Unable to retrieve info about that player.")
			return true
		end
		local query1 = db.getResult("SELECT count FROM tile_items WHERE itemtype = "..itemid.." AND tile_id IN (SELECT id FROM tiles WHERE house_id = (SELECT id FROM houses WHERE owner = "..GUID.."))")
		local query2 = db.getResult("SELECT count FROM player_items WHERE itemtype = "..itemid.." AND player_id = "..GUID)
		local query3 = db.getResult("SELECT count FROM player_depotitems WHERE itemtype = "..itemid.." AND player_id = "..GUID)
		local count = 0
		if query1:getID() > -1 then
			repeat
				local count_ = query1:getDataInt("count")
				count = count + count_
			until not query1:next()
			query1:free()
		end
		if query2:getID() > -1 then
			repeat
				local count_ = query2:getDataInt("count")
				count = count + count_
			until not query2:next()
			query2:free()
		end
		if query3:getID() > -1 then
			repeat
				local count_ = query3:getDataInt("count")
				count = count + count_
			until not query3:next()
			query3:free()
		end
		if count == 0 then
			doPlayerSendTextMessage(cid, 27, "Player doesn't have the specified item.")
		else
			doPlayerSendTextMessage(cid, 27, playername.." has "..count.." "..getItemNameById(itemid)..".")
		end
	end
	return true
end