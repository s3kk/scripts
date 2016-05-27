-- By Godfather (rev 1)
local porcentagem = 40 -- Porcentagem de dano que será BLO-QUE-A-DO
local pt_br = false
 
function onStatsChange(cid, attacker, type, combat, value)
        local lang = {"You lose %d hitpoints (damage protected by amulet: %x).","Você perdeu %d pontos de vida (proteção do amuleto: %x)."}
        local reset = 9235
        if getPlayerSlotItem(cid,2).itemid == 2218 then
                if type == 1 or type == 3 then
                        if getPlayerStorageValue(cid,reset) == 2 then
                                setPlayerStorageValue(cid,reset,1)
                                return true
                        else
                                local new_dmg = math.ceil(((100-porcentagem)/100)*value)
                                setPlayerStorageValue(cid,reset,2)
                                doTargetCombatHealth(attacker, cid, combat, -new_dmg, -new_dmg, -1)
                                doPlayerSendCancel(cid,(pt_br and lang[2]:format(new_dmg, value-new_dmg) or lang[1]:format(new_dmg, value-new_dmg)))
                                return false
                        end
                end
        end
    return true
end