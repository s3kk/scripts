function onStatsChange(cid, attacker, type, combat, value)
	if type == STATSCHANGE_HEALTHLOSS then
		if isAura(cid) then
			if math.random(1, 100) < auexchance then
				sendExplosion(cid, getAura(cid), math.random(1, 2))
			end
		end
	end
	return true
end

function onLogin(cid)
	if isAura(cid) then
		startAura(cid, getAura(cid))
	end
	return true
end