-- [[ FUNÇÕES ]] --
au = {
["fire"] = {ef = {5, 6, 15, 36}, sh = 3, dmg = COMBAT_FIREDAMAGE},
["ice"] = {ef = {41, 42, 43}, sh = 28, dmg = COMBAT_ICEDAMAGE},
["earth"] = {ef = {8, 45, 20}, sh = 29, dmg = COMBAT_EARTHDAMAGE},
["death"] = {ef = {17, 34, 38}, sh = 31, dmg = COMBAT_DEATHDAMAGE},
["holy"] = {ef = {39, 49}, sh = 30, dmg = COMBAT_HOLYDAMAGE},
["energy"] = {ef = {11, 47, 48}, sh = 35, dmg = COMBAT_ENERGYDAMAGE}
}

function isAura(cid)
	if type(getPlayerStorageValue(cid, aurast)) == "string" then
		return true
	end
	return false
end

function addAura(cid, aura)
	return setPlayerStorageValue(cid, aurast, aura)
end

function getAura(cid)
	return getPlayerStorageValue(cid, aurast)
end

function startAura(cid, aura)
	a = au[aura]
	if not isCreature(cid) then return true end
	doSendMagicEffect(getThingPos(cid), a.ef[math.random(1, #a.ef)])
	addEvent(startAura, 2000, cid, aura)
end

arrex = createCombatArea{
{0, 0, 1, 0, 0},
{0, 1, 1, 1, 0},
{1, 1, 2, 1, 1},
{0, 1, 1, 1, 0},
{0, 0, 1, 0, 0}
}

function sendExplosion(cid, aura, model)
rateatk = math.ceil(getPlayerLevel(cid)/2*1,5)
a = au[aura]
min, max = rateatk/2, rateatk
	if model == 1 then
		doAreaCombatHealth(cid, a.dmg, getThingPos(cid), arrex, -min, -max, a.ef[math.random(1, #a.ef)])
	elseif model == 2 then
		for i = 0, 3 do
			doSendDistanceShoot(getThingPos(cid), getPositionByDirection(getThingPos(cid), i, 1), a.sh)
			doAreaCombatHealth(cid, a.dmg, getPositionByDirection(getThingPos(cid), i, 1), 0, -min, -max, a.ef[math.random(1, #a.ef)])
		end
	end
end

function getPositionByDirection(position, direction, size) -- TFS FUNCTION
	local n = size or 1
	if(direction == NORTH) then
		position.y = position.y - n
	elseif(direction == SOUTH) then
		position.y = position.y + n
	elseif(direction == WEST) then
		position.x = position.x - n
	elseif(direction == EAST) then
		position.x = position.x + n
	elseif(direction == NORTHWEST) then
		position.y = position.y - n
		position.x = position.x - n
	elseif(direction == NORTHEAST) then
		position.y = position.y - n
		position.x = position.x + n
	elseif(direction == SOUTHWEST) then
		position.y = position.y + n
		position.x = position.x - n
	elseif(direction == SOUTHEAST) then
		position.y = position.y + n
		position.x = position.x + n
	end

	return position
end