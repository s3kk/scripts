local cfg = {
    storage = 9394,
    speed = 500,                    --Velocidade adicionada ao player após usar o item! (500 = velocidade, quanto maior mais rapido...)
    outfit = 342,                   --Outfit da montaria!
}
function onLogin(cid)
    if getPlayerStorageValue(cid, cfg.storage) > os.time() then
        doSetCreatureOutfit(cid, {lookType = cfg.outfit}, -1)
        doChangeSpeed(cid, cfg.speed)
    end
    return true
end