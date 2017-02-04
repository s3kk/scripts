-- [( Mount System 1.4 created by Matheus for TibiaKing.com )] --
function onUse(cid, item)
    local outfit = 342  -- Outfit da montaria!
    local exhaust = 60 -- Tempo para player poder usar o item novamente! (tempo em segundos)
    local time = 60 -- Tempo para ficar na montaria! (tempo em segundos)
    local speed = 500 -- Velocidade adicionada ao player após usar o item! (500 = velocidade, quanto maior mais rapido...)
    local mana = 0 -- Quantidade de mana que o player necessita para usar o sistema!
    local premium = true -- Apenas players premium accounts true (sim) ou false (não)!?
    local storage, storage_time = 9393, 9394     --Não mexa aqui!  
    if premium and not isPremium(cid) then
        return doPlayerSendTextMessage(cid, 23, "Sorry, only premium players.")
    elseif getCreatureMana(cid) < mana then
        return doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTENOUGHMANA)
    elseif getPlayerStorageValue(cid, storage) > os.time() then
        return doPlayerSendCancel(cid, "Sorry, you only can again use this item after "..exhaust.." seconds.")
    else
        doCreatureSay(cid, "Yeeeah!!!\nYou went up on his ride.", 19)
        doSetCreatureOutfit(cid, {lookType = outfit}, -1)
        doChangeSpeed(cid, speed)
        doSendMagicEffect(getCreaturePosition(cid), 34)
        setPlayerStorageValue(cid, storage, os.time() + exhaust)
        setPlayerStorageValue(cid, storage_time, os.time() + time)
        doPlayerAddMana(cid, -mana)
        addEvent(function()
            if isPlayer(cid) then
                doChangeSpeed(cid, -speed)
                doPlayerSendTextMessage(cid, 23, "Mount System is time out!")
                doSendMagicEffect(getCreaturePosition(cid), 2)
                doRemoveCondition(cid, CONDITION_OUTFIT)
            end
        end, time * 1000)
    end
    return true
end