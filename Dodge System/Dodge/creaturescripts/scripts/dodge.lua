local lvldodge = 48902
local percent = 0.5


function onStatsChange(cid, attacker, type, combat, value)
if type == STATSCHANGE_HEALTHLOSS and isCreature(attacker) then
if (getPlayerStorageValue(cid, lvldodge)*3) >= math.random (0,1000) then
value = math.ceil(value*(percent))
doTargetCombatHealth(attacker, cid, combat, -value, -value, 255)
doSendAnimatedText(getCreaturePos(cid), "DODGE", 6)
return false
end
end
return true
end