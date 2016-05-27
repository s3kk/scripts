local min, max = 15000,20000 --Ataque mínino e ataque máximo

local w = {
	[1] = {ef = 36, sh = 3, dmg = COMBAT_FIREDAMAGE},
	[2] = {ef = 42, sh = 28, dmg = COMBAT_ICEDAMAGE},
	[3] = {ef = 46, sh = 38, dmg = COMBAT_POISONDAMAGE},
	[4] = {ef = 17, sh = 31, dmg = COMBAT_DEATHDAMAGE},
	[5] = {ef = 47, sh = 35, dmg = COMBAT_ENERGYDAMAGE},
	[6] = {ef = 36, sh = 31, dmg = COMBAT_PHYSICALDAMAGE},
	[7] = {ef = 49, sh = 37, dmg = COMBAT_HOLYDAMAGE}
}

function onUseWeapon(cid, var)
        local effect = getPlayerStorageValue(cid, 4561)
        local target = getCreatureTarget(cid)
        
        if target ~= 0 then
                local wx = w[effect] or w[math.random(#w)]
                doSendDistanceShoot(getThingPos(cid), getThingPos(target), wx.sh)
                addEvent(doAreaCombatHealth, 100, cid, wx.dmg, getThingPos(target), 0, -min, -max, wx.ef)
        end
        return true
end