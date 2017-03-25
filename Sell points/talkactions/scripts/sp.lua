function onSay(cid, words, param)
	local var,points = "[Sell Point System] Este documento vale %s points para você usar no site.",getPremiumPoints(cid)
	local min,max = 5, 100
	if param == "" or not tonumber(param) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Desculpe, use somente numeros.") return true
	elseif tonumber(param) < min or tonumber(param) > max then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Desculpe, Minimo "..min.." e Maximo "..max.." points.") return true
	elseif points < tonumber(param) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Desculpe, mas você só possui "..points.." Premium Points.") return true
	end
	local item = doPlayerAddItem(cid, 7702,1) 
	doItemSetAttribute(item, "description", var:format(tonumber(param)))
	setPremiumPoints(cid, points-tonumber(param))
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"[Sell Point System] Você recebeu um paper com "..param.." Premium Points.")
	return true
end