local config = {
storagekill = 19500, --- storage q conta a quantidade de kills
storageaegis = 19332, --- storage da skill
tempo = 5, -- tempo até ele renascer
times = 2, --- quantidade de vezes que tenho que matar
charges = 1, --- cargas da skill q ganha ao matar definitivamente
effect1 = 66, -- efeito ao morrer
effect2 = 10  --- efeito ao renascer
}


function onKill(cid, target, lastHit)
local killed = getPlayerStorageValue(cid,config.storagekill)
local skill = getPlayerStorageValue(cid, config.storageaegis)


if isMonster(target) and getCreatureName(target):lower() == 'aegis' then
if killed < config.times then
doCreatureSay(target, "I'll be back mortal...", 20)
doSendMagicEffect(getThingPos(target), config.effect1)
setPlayerStorageValue(cid, config.storagekill, killed+1)
addEvent(doSendMagicEffect, 1000*config.tempo, getThingPos(target), config.effect2)
addEvent(doCreateMonster, 1000*config.tempo, "Aegis", getCreaturePosition(target), true)
end


if killed >= config.times then
setPlayerStorageValue(cid, config.storagekill, 0)
if skill < config.charges then
doPlayerSendTextMessage(cid,22,"Congratulations, you just killed "..getCreatureName(target).." and earned Aegis of Immortal skill!")
setPlayerStorageValue(cid, config.storageaegis, config.charges)
end
end
end
return true
end