w = {
[12031] = {ef = 36, sh = 3, dmg = COMBAT_FIREDAMAGE},
[12032] = {ef = 42, sh = 28, dmg = COMBAT_ICEDAMAGE},
[12033] = {ef = 45, sh = 38, dmg = COMBAT_POISONDAMAGE},
[12034] = {ef = 17, sh = 31, dmg = COMBAT_DEATHDAMAGE},
[12035] = {ef = 11, sh = 35, dmg = COMBAT_ENERGYDAMAGE},
[12036] = {ef = 49, sh = 37, dmg = COMBAT_HOLYDAMAGE}
}

function onUseWeapon(cid, var)
min, max = 15000, 20000 -- dano minimo e maximo
target = getCreatureTarget(cid)
for stor, info in pairs(w) do
if getPlayerStorageValue(cid, stor) == 1 then
if target ~= 0 then
doSendDistanceShoot(getThingPos(cid), getThingPos(target), info.sh)
addEvent(doAreaCombatHealth, 100, cid, info.dmg, getThingPos(target), 0, -min, -max, info.ef)
end
end
end
return true
end