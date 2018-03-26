function onLook(cid, thing, position, lookDistance)
if isPlayer(thing.uid) then
doPlayerSetSpecialDescription(thing.uid, "\nQuests Completas: ["..getQuestCompletCount(thing.uid, QuestCountSystem).."/"..LimiteQuestCount.."]")
end
return true
end