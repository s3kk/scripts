function onUse(cid, item, frompos, item2, topos)
	local var = getItemAttribute(item.uid, "description")
	if var == nil then return true end
	local x = var:match("%b[]")
	if x == "[Sell Point System]" then
		local ret = var:match("%d+")
		doPlayerSendTextMessage(cid, 22,"você recebeu "..ret.." Premium Points.")
		setPremiumPoints(cid, getPremiumPoints(cid)+ret)
		doRemoveItem(item.uid) 
	end
	return true
end