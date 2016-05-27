-- Código feito por Omega (http://www.xtibia.com/forum/topic/221228-peca-aqui-o-seu-sistemaevento)

function doSendAreaEffect(pos, effect, radius)
    for x = pos.x-radius, pos.x+radius do
        for y = pos.y-radius, pos.y+radius do
            doSendMagicEffect({x=x, y=y, z=pos.z}, effect)
        end
    end
    return true
end

function onStatsChange(cid, attacker, type, combat, value)
    registerCreatureEvent(cid, "empe_dmg")
    if isPlayer(cid) then return true end
    if type == 1 then
        local mhp = getCreatureMaxHealth(cid)
        local percentChange = 10
        local newMonster = 'Demon'
        if (getCreatureHealth(cid) - value) <= percentChange/100*mhp then
            local pos = getThingPos(cid)
            doRemoveCreature(cid)
            newMonster = doCreateMonster(newMonster, pos)
            doCreatureAddHealth(newMonster, (getCreatureMaxHealth(newMonster)))
            doSendAreaEffect(pos, 5, 1)
            return false
        end
    end
    return true
end