--Tanker Method by NightWolf


local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 36)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 13)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 0)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)


local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, 60000)
setConditionParam(condition, CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, 200)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELDPERCENT, 140)
setConditionParam(condition, CONDITION_PARAM_BUFF, true)
setCombatCondition(combat, condition)




function onCastSpell(cid, var)
local mtanker = {lookType = 268, lookHead = 114, lookBody = 114, lookLegs = 114, lookFeet = 114, lookTypeEx = 0, lookAddons = 3}
local ftanker = {lookType = 269, lookHead = 114, lookBody = 114, lookLegs = 114, lookFeet = 114, lookTypeEx = 0, lookAddons = 3}


local sex = getPlayerSex(cid)
if sex == 0 then
doSetCreatureOutfit(cid, ftanker, 60000)
local mana = getCreatureMaxMana(cid)
doCreatureAddMana(cid, -mana)
else 
doSetCreatureOutfit(cid, mtanker, 60000)
local mana = getCreatureMaxMana(cid)
doCreatureAddMana(cid, -mana)
end
return doCombat(cid, combat, var)


end