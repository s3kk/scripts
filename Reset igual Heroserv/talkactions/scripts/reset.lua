local time = 30 -- tempo em segundos para permitir o login(coloque um pouco mais do tempo de um Server Game do seu mapa)

function onSay()
    doSetGameState(GAMESTATE_CLOSED)
    db.query("UPDATE `players` SET `level` = "..getConfigInfo("newPlayerLevel").." WHERE `group_id` < 6;")
    db.query("DELETE FROM `player_depotitems` WHERE `itemtype` NOT IN (11257, 11238, 11237, 11236, 11235, 11115, 10522, 10521, 10520, 10519, 10518, 9775, 9774, 7343, 7342, 5950, 5949, 5927, 5926, 5801, 3960, 3940, 3939, 2365, 2004, 2003, 2002, 2001, 2000, 1999, 1998, 1997, 1996, 1995, 1994, 1993, 1992, 1991, 1988, 1987, 2160);") -- Bags, backpacks and crystal coin already added
    db.query("DELETE FROM `player_items` WHERE `itemtype` NOT IN (11257, 11238, 11237, 11236, 11235, 11115, 10522, 10521, 10520, 10519, 10518, 9775, 9774, 7343, 7342, 5950, 5949, 5927, 5926, 5801, 3960, 3940, 3939, 2365, 2004, 2003, 2002, 2001, 2000, 1999, 1998, 1997, 1996, 1995, 1994, 1993, 1992, 1991, 1988, 1987, 2160);") -- Bags, backpacks and crystal coin already added
    return addEvent(doSetGameState, 1000 * time, GAMESTATE_NORMAL)
end