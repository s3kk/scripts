local cooldown = 00*60*00


function onCastSpell(cid, var)
if os.time() - getPlayerStorageValue(cid, 19329) >= cooldown then
doPlayerSetStorageValue(cid, 19329, os.time())
local target = getCreatureTarget(cid)
doCreatureAddHealth(cid, -getCreatureHealth(cid))
doCreatureAddHealth(target, -getCreatureHealth(target))
doCreatureSay(cid, "SUICIDE!!", 20)
doSendMagicEffect(getPlayerPosition (cid), 0)
doSendMagicEffect(getPlayerPosition (target), 0)
else
doPlayerSendCancel(cid, "Your skill is in cooldown, you can use it again after "..math.floor((cooldown - (os.time() - getPlayerStorageValue(cid, 19329)))/60).." minute(s).")
end
return true
end