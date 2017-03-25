function getPremiumPoints(cid)
	local query = db.getResult("SELECT `premium_points` FROM `accounts` WHERE `id` = "..getPlayerAccountId(cid))
	return query:getDataInt("premium_points") <= 0 and 0 or query:getDataInt("premium_points")
end
function setPremiumPoints(cid, amount)
	return db.query("UPDATE `accounts` SET `premium_points` = "..amount.." WHERE `id` = "..getPlayerAccountId(cid))
end