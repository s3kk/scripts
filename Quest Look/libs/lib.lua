LimiteQuestCount = 30 -- coloque de acordo com a quantidade de quests existente no seu servidr
QuestCountSystem = 123419 -- é a storage da system, lembre-se, não deve existe outra igual

function getQuestCompletCount(uid, storage)
if isPlayer(uid) then
 if getPlayerStorageValue(uid, storage) == -1 then
  return 0
 end
return getPlayerStorageValue(uid, storage)
end
end