function onLogin(cid)
	registerCreatureEvent(cid, "BossCorpse")
	return true
end

function onKill(cid, target)
	local monsters = {
		["larva"] = {chance = 50, next = "bug", msg = {"Not today."}},
		["bug"] = {chance = 50, next = "scarab", msg = {"Welcome to Hell!"}},
		["scarab"] = {chance = 50, next = "ancient scarab", msg = {"Oh shit"}}
	}
	function doRemoveCorpse(pos, creature)
		for i = 0, 255 do
			pos.stackpos = i
			tile = getTileThingByPos(pos)
			if tile.uid > 0 and isCorpse(tile.uid) then
				doRemoveItem(tile.uid)
			end
		end
	doSummonCreature(creature, pos)	
	end
	if isPlayer(cid) and isMonster(target) then
		local var = monsters[getCreatureName(target)]
		if var then
			if var.chance >= math.random(1, 100) then
				addEvent(doRemoveCorpse, 0, getThingPos(target), var.next)
				doCreatureSay(target, var.msg[math.random(1, #var.msg)], TALKTYPE_ORANGE_1)
			end
		end
	end
	return true
end