function onUse(cid, item, frompos, item2, topos)
          spellName = "XXXXXX" -- Nome da spell
          if getPlayerStorageValue(cid, 40000) <= 0 then
                    setPlayerStorageValue(cid, 40000, 1)
                    doPlayerSendTextMessage(cid, 20, "You received permission to use the ".. spellName ..".")
          else
                    doPlayerSendTextMessage(cid, 20, "You already have permission to use the ".. spellName .." spell.")
          end
          return TRUE
end