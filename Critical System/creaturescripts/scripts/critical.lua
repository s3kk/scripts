--[[Critical System
-------------------------  By Night Wolf]]


local lvlcrit = 48913
local multiplier = 1.5


function onStatsChange(cid, attacker, type, combat, value)
if isPlayer(attacker) and (not (attacker == cid)) and (type == STATSCHANGE_HEALTHLOSS or type == STATSCHANGE_MANALOSS)  then
if (getPlayerStorageValue(attacker, lvlcrit)*3) >= math.random (0,1000) then
dano = math.ceil(value*(multiplier))
doTargetCombatHealth(attacker, cid, combat, -dano, -dano, 255)
doSendAnimatedText(getCreaturePos(attacker), "CRITICAL!!", 144)
return false
end
end
return true
end