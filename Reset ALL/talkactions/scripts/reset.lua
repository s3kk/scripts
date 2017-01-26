local time = 5 -- tempo em segundos para permitir o login(coloque um pouco mais do tempo de um Server Game do seu mapa)

function onSay()
    doSetGameState(GAMESTATE_CLOSED)
    db.query("UPDATE `players` SET `level` = "..getConfigInfo("newPlayerLevel").." WHERE `group_id` < 4;")
	db.query("UPDATE `players` SET `posx` = "..getConfigInfo("newPlayerSpawnPosX").." WHERE `group_id` < 4;")
	db.query("UPDATE `players` SET `posy` = "..getConfigInfo("newPlayerSpawnPosY").." WHERE `group_id` < 4;")
	db.query("UPDATE `players` SET `posz` = "..getConfigInfo("newPlayerSpawnPosZ").." WHERE `group_id` < 4;")
	db.query("UPDATE `players` SET `town_id` = "..getConfigInfo("newPlayerTownId").." WHERE `group_id` < 4;")
    db.query("DELETE FROM `player_depotitems` WHERE `itemtype` NOT IN ();")
    db.query("DELETE FROM `player_items` WHERE `itemtype` NOT IN ();")
    return addEvent(doSetGameState, 1000 * time, GAMESTATE_NORMAL)
end