function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 40000) >= 1 then
    return doCombat(cid, combat, var)
          else
                    doPlayerSendCancel(cid, "Desculpe,Você tem que comprar a permissao para usar está magia.")
          end
          return true
end