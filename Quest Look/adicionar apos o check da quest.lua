if getQuestCompletCount(cid, QuestCountSystem) < LimiteQuestCount then
 doCreatureSetStorage(cid, QuestCountSystem, getQuestCompletCount(cid, QuestCountSystem)+1)
end 