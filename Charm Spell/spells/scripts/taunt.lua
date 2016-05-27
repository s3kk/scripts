local config = {
walks = 8, -- qnts passos ele vai dar
delay = 750, -- de qnts em qnts milisegundos ele dá cada passo
speed = 100 -- velocidade que ele vai ficar enquanto estiver sob efeito do taunt
}

function onCastSpell(cid, var)
Taunt(cid, variantToNumber(var), config.delay, config.walks) 
doChangeSpeed(variantToNumber(var), (config.speed - getCreatureBaseSpeed(variantToNumber(var))))
addEvent(function() 
	if isCreature(variantToNumber(var)) then
		doChangeSpeed(variantToNumber(var), (-config.speed + getCreatureBaseSpeed(variantToNumber(var))))
	end
end, config.delay * (config.walks + 1))
return true
end 