function onSay(cid, words, param, channel)

	    param = tonumber(param) or ""

	    if param == "" then

			    return doPlayerSendCancel(cid, words .." [itemid]")

	    end

	    local result = db.getResult("SELECT name, online FROM players WHERE id IN (SELECT player_id FROM player_items WHERE itemtype = ".. param ..");")

	    local msg = "Resultados da busca pelo item ".. param .." em seu banco de dados:\n\n"

	    if result:getID() ~= -1 then

			    while true do

					    local name = result:getDataString("name")

					    local online = result:getDataInt("online")

					    msg = msg .. name .." [".. (online == 1 and "Online" or "Offline") .."]\n"

					    if not result:next() then

							    break

					    end

			    end

	    else

			    msg = msg .. "O item não foi encontrado em nenhum jogador."

	    end

	    doShowTextDialog(cid, param, msg)

	    return true

end