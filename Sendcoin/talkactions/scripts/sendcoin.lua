--[[
    Send Coins System developed by Zoom in 04/02/2016 21:27.
    For more scripts, please contact me on skype : halls.santos
    
    Enjoy!
]]

local info = [[Olá %s,
Este comando serve para o envio de gold coin(s).
Caso você queira enviar para um amigo, é necessário informar
o nome do jogador e em seguida a quantia em gold coin(s).

ex : /sendcoins Magezin 3500

PS : Será descontado do seu balance no banco caso você não
tenha coin(s) em sua mochila. Este processo é automático.]]

local SEND_COINS_LIMIT = 9999999999
local SEND_YOURSELF     = false

function onSay(cid, words, param)
    
    local tmp = param.explode(param, ' ')
    if not tmp[1] then
        return doPlayerPopupFYI(cid, info:format(getCreatureName(cid)))
    elseif not tmp[2] then
        return doPlayerSendCancel(cid,'Você precisa especificar um valor.')
    end

    if(not SEND_YOURSELF and getCreatureByName(tmp[1]) == cid) then
        return doPlayerSendCancel(cid, 'Não é possível enviar para si mesmo(a).')
    end
    
    if isPlayer(getCreatureByName(tmp[1])) then
        if(getPlayerBalance(cid) >= tonumber(tmp[2]) and setPlayerBalance(cid, getPlayerBalance(cid) - tmp[2]) or doPlayerRemoveMoney(cid, tmp[2])) or getPlayerAccess(cid) >= 3 then
            if(tonumber(tmp[2]) <= SEND_COINS_LIMIT) then
                doPlayerAddMoney(getCreatureByName(tmp[1]), tmp[2])
            else
                return doPlayerSendCancel(cid, "Você tentou enviar muitos coins, tente um valor mais baixo.")
            end
        else
            return doPlayerSendCancel(cid, "Você não possui "..tmp[2].." gold coin(s).")
        end
    else
        return doPlayerSendCancel(cid, 'Este player não está online ou não existe.')
    end
    
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'Envio de '..tmp[2]..' gold coin(s) realizado.')
    doSendMagicEffect(getThingPos(getCreatureByName(tmp[1])), 13)

    return doPlayerSendTextMessage(getCreatureByName(tmp[1]), MESSAGE_STATUS_DEFAULT, 'Você recebeu '..tmp[2]..' gold coin(s) enviado(s) pelo jogador '..getCreatureName(cid)..'.')
end