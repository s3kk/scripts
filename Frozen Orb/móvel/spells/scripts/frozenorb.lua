local config = {
velocidade = 350, -- intervalo entre os giros (quanto menor, mais rapido)
hits = 24, -- quantos hits vai dar
msg = "Frozen Orb", -- msg ao soltar a spell
key = 13871, -- storage que sera utilizado pro cooldown
cooldown = 3, -- tempo em segundos de cooldown entre um uso da spell e outro.
effect1 = 36, -- efeito de distancia que vai ficar rodando
effect3 = 37, -- efeito ao castar a spell
effect4 = 43 -- efeito ao acertar a roda no player
}
--[[Note que a velocidade multiplicada pelo numero de hits deve dar algo proximo de 8550 pra que a magia nao fique ruim ou um efeito acabe antes do outro.
Nos valores que eu utilizei eles dao 8400, oque ja eh considerado perto pois temos 200 milisegundos iniciais, 
8550 eh o tempo que o item sera removido e coincide com o tempo de duracao do efeito 56 (config.effect2)]]

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 255)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 5, 5, 1.4, 2.1)
function onTargetCreature(cid, target)
   doSendMagicEffect(getCreaturePosition(target), config.effect4)
end
setCombatCallback(combat, 4, "onTargetCreature")

local arr = {
{1, 1, 1},
{1, 3, 1}, -- area que vai acertar a spell enquanto estiver rodando
{1, 1, 1},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function initEffect(position)
	for i = 0, 3 do
		local pos = {x = position.x, y = position.y, z = position.z}
		local dir = getPosByDir(pos, i)
		doSendDistanceShoot(position, dir, config.effect1)
	end
return true
end

function middleEffect(uid, param, lim, count)
n = count or 0
	if isCreature(uid) and n < lim then
		for i = 0, 3 do
			local pos = {x = getCreaturePosition(uid).x, y = getCreaturePosition(uid).y, z = getCreaturePosition(uid).z}
			local pos2 = {x = getCreaturePosition(uid).x, y = getCreaturePosition(uid).y, z = getCreaturePosition(uid).z}
			local dir = getPosByDir(pos, i)
			local dir2 = getPosByDir(pos2, i + 1 <= 3 and i + 1 or 0)
			doSendDistanceShoot(dir, dir2, config.effect1)
		end
		doCombat(uid, combat, {
			pos = getCreaturePosition(uid),
			type = 2
        })
		addEvent(middleEffect, config.velocidade, uid, param, lim, n + 1)
	end
return true
end

function endEffect(uid)
	if isCreature(uid) then
	for i = 0, 3 do
		local pos = {x = getCreaturePosition(uid).x, y = getCreaturePosition(uid).y, z = getCreaturePosition(uid).z}
		local dir = getPosByDir(pos, i)
		doSendDistanceShoot(dir, getCreaturePosition(uid), config.effect1)
	end
	end
return true
end

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, config.key) - os.time() <= 0 then
	setPlayerStorageValue(cid, config.key, os.time() + config.cooldown)
	local position = getCreaturePosition(cid)
	doCreatureSay(cid, config.msg, 20)
	addEvent(endEffect, 8.55 * 1000, uid)
	doSendMagicEffect(position, config.effect3)
	initEffect(position)
	addEvent(middleEffect, 200, cid, var, config.hits)
else
	doPlayerSendCancel(cid, "You're exhausted.")
end
return true
end