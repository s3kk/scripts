function getPlayerNameByGUID2(n)
	local c = db.getResult("SELECT `name` FROM `players` WHERE `group_id` <= 2 and `id` = "..n..";")
	if c:getID() == -1 then
		return nil
	end
	return c:getDataString("name")
end



function onSay(cid, words, param)
	local max = 20
	local letters_to_next = 20
	local option = 2 -- coloque 1 ou 2 pra ver as opções de amostragem de rank
	 
	local skills = {
		['fist'] = 0,
		['club'] = 1,
		['sword'] = 2,
		['axe'] = 3,
		['distance'] = 4,
		['shielding'] = 5,
		['fishing'] = 6,
		['dist'] = 4,
		['shield'] = 5,
		['fish'] = 6,
	}
	
	local name_now
	local name = "Highscore for level\n"
	local rkn, no_break = 0, 0
	param = string.lower(param)
	dofile('config.lua')


	if (param == "" or param == "level") and skills[param] == nil then
		name = name.."\n"
		name = name.."Rank Level - Nome do Jogador\n"
		local v = db.getResult("SELECT `name`, `level`, `experience` FROM `players` WHERE `group_id` <= 2 ORDER BY `experience` DESC LIMIT 0,"..(max)..";")
		repeat
			no_break = no_break +1
			if v:getID() == -1 then
				break
			end
			rkn = rkn+1
			name_now, l = v:getDataString("name"), string.len(v:getDataString("name"))
			space = ""
			for i=1, letters_to_next-l do
				space = space.." "
			end
			name = name..rkn..". "..v:getDataInt("level") .." - "..name_now..space.." ".."\n"
			if no_break >= 20 then
				break
			end
		until v:next() == false
		 
	elseif param == "magic" or param == "ml" then
		name = name.."\n"
		name = name.."Rank Magic - Nome do Jogador\n"
		local v = db.getResult("SELECT `name`, `level`, `maglevel` FROM `players` WHERE `group_id` <= 2 ORDER BY `maglevel` DESC LIMIT 0,"..(max)..";")
		repeat
			if v:getID() == -1 then
				break
			end
			rkn = rkn+1
			name_now, l = v:getDataString("name"), string.len(v:getDataString("name"))
			space = ""
			for i=1, letters_to_next-l do
				space = space.." "
			end
			name = name..rkn..". "..v:getDataInt("maglevel").." - "..name_now..space.." ".." ".."".."\n"
		until v:next() == false
	elseif skills[param] ~= nil then
		name = name.."\n"
		name = name.."Rank "..param.." fighting - Nome do Jogador\n"
		local v = db.getResult("SELECT `player_id`, `value` FROM `player_skills` WHERE `skillid` = "..skills[param].." ORDER BY `value` DESC;")
		local kk = 0
		 
		repeat
			if kk == max or v:getID() == -1 then
				break
			end
			name_now = getPlayerNameByGUID2(v:getDataInt("player_id"))
			if name_now ~= nil then
			kk = kk+1
				space = ""
				l = string.len(getPlayerNameByGUID2(v:getDataInt("player_id")))
				for i=1, letters_to_next-l do
					space = space.." "
				end
				name = name..kk..". "..v:getDataInt("value").." - "..name_now..space.." \n"
			end
		until v:next() == false
	end
	if name ~= "Highscore\n" then
		if option == 1 then
			doPlayerPopupFYI(cid, name)
		else
			doShowTextDialog(cid, 7386, name)
		end
	end 
return true
end