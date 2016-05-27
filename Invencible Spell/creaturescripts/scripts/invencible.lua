local config = { 
storage = 3482101,
effect1 = 2 --- efeito ao ser atacado estando invulnerável
} 


function onStatsChange(cid, attacker, type, combat, value)
if value >= 1 and (type == STATSCHANGE_HEALTHLOSS or (getCreatureCondition(cid, CONDITION_MANASHIELD) and type == STATSCHANGE_MANALOSS))  then
if getPlayerStorageValue(cid,config.storage) - os.time() > 0 and isCreature(attacker) then
doSendMagicEffect(getCreaturePosition(cid), config.effect1)
doSendAnimatedText(getCreaturePosition(cid), "0", 180)
return false
end
end
return true
end