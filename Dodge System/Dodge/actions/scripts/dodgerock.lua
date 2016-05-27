local config = {
   effectonuse = 14, -- efeito que sai
   levelsdodge = 100,  --- leveis que terão
   storagedodge = 48902 -- storage que será verificado
   }
   
function onUse(cid, item, frompos, item2, topos)
    if getPlayerStorageValue(cid, config.storagedodge) < config.levelsdodge then
   doRemoveItem(item.uid, 1)
doSendMagicEffect(topos,config.effectonuse)
doPlayerSendTextMessage(cid,22,"You've Leveled your Dodge Skill to ["..(getPlayerStorageValue(cid, config.storagedodge)+1).."/100].")
setPlayerStorageValue(cid, config.storagedodge, getPlayerStorageValue(cid, config.storagedodge)+1)
elseif getPlayerStorageValue(cid, config.storagedodge) >= config.levelsdodge then
doPlayerSendTextMessage(cid,22,"You've already reached the MAX level of Dodge Skill.\nCongratulations!!!!")
    return 0
    end
return 1
end