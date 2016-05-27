local pos = {
[1] = {"Scratch", { x = 1002, y = 1019, z = 7 }},
[2] = {"Area VIP", { x = 993, y = 1019, z = 7 }},
[3] = {"Hunts", { x = 994, y = 1012, z = 7 }},
[4] = {"BattleEvt", { x = 994, y = 1013, z = 7 }},
[5] = {"Castle24H", { x = 994, y = 1014, z = 7 }},
[6] = {"Hunts VIP", { x = 990, y = 1018, z = 7 }},
[7] = {"Quest VIP", { x = 990, y = 1019, z = 7 }},
[8] = {"VIP City", { x = 990, y = 1020, z = 7 }},
[9] = {"Trainers", { x = 994, y = 1011, z = 7 }},
[10] = {"Quests", { x = 994, y = 1015, z = 7 }},
[11] = {"Compras", { x = 1001, y = 1008, z = 7 }},
[12] = {"Templo", { x = 1008, y = 1008, z = 8 }},
[13] = {"10 Pontos", { x = 1014, y = 1008, z = 8 }},
[14] = {"10 Pontos", { x = 1014, y = 1011, z = 8 }},
[15] = {"10 Pontos", { x = 1014, y = 1014, z = 8 }},
[16] = {"10 Pontos", { x = 1014, y = 1017, z = 8 }},
[17] = {"5 Pontos", { x = 1014, y = 1020, z = 8 }},
[18] = {"5 Pontos", { x = 1012, y = 1023, z = 8 }},
[19] = {"10 Pontos", { x = 1007, y = 1018, z = 8 }},
[20] = {"5 Pontos", { x = 1006, y = 1018, z = 8 }},
[21] = {"5 Pontos", { x = 1000, y = 1014, z = 8 }},
[22] = {"5 Pontos", { x = 1000, y = 1017, z = 8 }},
[23] = {"5 Pontos", { x = 1000, y = 1020, z = 8 }},
[24] = {"5 Pontos", { x = 1000, y = 1023, z = 8 }},
[25] = {"4 Pontos", { x = 1000, y = 1008, z = 8 }},
[26] = {"1 Ponto", { x = 1000, y = 1012, z = 8 }}
}
 
function onThink(cid, interval, lastExecution)

    for x = 1, 26 do
        doSendAnimatedText(pos[x][2], pos[x][1], math.random(1, 255))
    end
    
    return true
end