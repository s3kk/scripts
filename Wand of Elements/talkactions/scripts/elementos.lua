local config = {
    wand_id = 7735, --ID da wand

    types = {
	["all"] = 1, --Ataca os elementos aleatoriamente
    ["fire"] = 2,
	["ice"] = 3,
	["poison"] = 4,
	["death"] = 5,
	["energy"] = 6,
	["physical"] = 7,
	["holy"] = 8
    }
}

function onSay(cid, words, param)
    local wand_left = getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid
    local wand_right = getPlayerSlotItem(cid, CONST_SLOT_RIGHT).itemid 

    if wand_left ~= config.wand_id and wand_right ~= config.wand_id then
        doPlayerSendCancel(cid, "Voce deve estar equipado com uma ".. getItemNameById(config.wand_id) .." para usar este comando.")
        return true
    end
    
    if config.types[param] then
        setPlayerStorageValue(cid, 4561, config.types[param])
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Sua wand ira atacar ".. param .. ".")
    else
        local str = ""
        
        for i, _ in pairs(config.types) do
            str = str .. ", ".. i
        end
        
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Os elementos disponiveis sao: ".. string.sub(str, 3, #str) ..".")
    end

    return true
end