function onSay(cid, words, param)
name = {}
for i in param:gmatch('(%a+)') do
  table.insert(name,i)
end
name = table.concat(name, ' ')  
  if words == '!addreward' then
    if name == nil and param:match('(%d+)') == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Player not found.")
      return true
    elseif name == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Choose the player to add ".. param:match('(%d+)') .." in his reward.")
      return true
    elseif param:match('(%d+)') == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Choose the reward to add to ".. name ..".")
      return true
    end
    if getPlayerGUIDByName(name) then
      doPlayerAddReward(name,tonumber(param:match('(%d+)')))
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "You added ".. tonumber(param:match('(%d+)')) .. " gold coins in the reward of ".. name ..".")
      return true
    else
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, name.." isn't a Player.")
      return true
    end
  elseif words == '!removereward' then
    if name == nil and param:match('(%d+)') == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Player not found.")
      return true
    elseif name == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Choose the player to remove ".. param:match('(%d+)') .." from his reward.")
      return true
    elseif param:match('(%d+)') == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Choose the reward to remove from ".. name ..".")
      return true
    elseif getPlayerGUIDByName(name) then
      doPlayerRemoveReward(name,tonumber(param:match('(%d+)')))
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "You removed ".. param:match('(%d+)') .. " gold coins in the reward of ".. name ..".")
      return true
    else
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Player not found.")
      return true  
    end
  elseif words == '!setreward' then
    if name == nil and param:match('(%d+)') == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Player not found.")
      return true
    elseif name == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Choose the player to set his reward to ".. param:match('(%d+)') ..".")
      return true
    elseif param:match('(%d+)') == nil then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Choose the reward to set from ".. name ..".")
      return true
    elseif getPlayerGUIDByName(name) then
      setPlayerReward(name,tonumber(param:match('(%d+)')))
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "You set the reward from ".. name .." to ".. param:match('(%d+)') ..".")
      return true
    else
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Player not found.")
      return true
    end
  elseif words == '!reward' then
    local voca = {[0]='No vocation', [1]='Sorcerer',[2]='Druid',[3]='Paladin',[4]='Knight',[5]='Master Sorcerer',[6]='Elder Druid',[7]='Royal Paladin',[8]='Elite Knight'}

    if getPlayerGUIDByName(name) then
      local voca = {[0]='No vocation', [1]='Sorcerer',[2]='Druid',[3]='Paladin',[4]='Knight',[5]='Master Sorcerer',[6]='Elder Druid',[7]='Royal Paladin',[8]='Elite Knight'}
      local query = db.getResult("SELECT `level`,`vocation` FROM `players` WHERE `id` = ".. getPlayerGUIDByName(name) ..";")
      local level, voc = query:getDataInt('level'), query:getDataInt('vocation')
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "\n|¯¯¯¯| "..param..": Level "..level.."\n|            | "..voca[voc].."\n|____| Reward: ".. getPlayerReward(param) .. "\nWanted") 
      return true
    else
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Player not found.")
      return true
    end
  elseif words == '!pay' then
  gold = param:match('(%d+)')
    if gold then
      if type(tonumber(gold)) == 'number' then
        if getPlayerReward(getPlayerName(cid)) >= tonumber(gold) then
          if doPlayerRemoveMoney(cid, tonumber(gold)) then
            doPlayerRemoveReward(getPlayerName(cid),tonumber(gold))
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "You removed ".. gold .." gold coins from your reward.")
            return true
          else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ORANGE, "You don't have ".. gold .." gold coins.")
            return true
          end
        else
          doPlayerSendTextMessage(cid,MESSAGE_EVENT_ORANGE, "You don't have ".. gold .." gold coins in your reward.")
          return true
        end
      else
        doPlayerSendTextMessage(cid,MESSAGE_EVENT_ORANGE, gold.." isn't a number.")
        return true
      end
    else
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Choose how many gold coins you'll remove from your reward.")
        return true
    end
  elseif words == '!support' then
    local str = "¤Functions:\n\n!reward Socket » Will show how many gold coin the government will pay if you kill Socket.\n\n!pay 10 » Will remove 10 gold coins from your reward.\n\n!support » Will show this to you."
    local str1 = "¤Functions:\n\n!addreward Socket 10 » Will add 10 gold coins in the reward of Socket.\n\n!removereward Socket 10 » Will remove 10 gold coins from the reward of Socket.\n\n!setreward Socket 10 » Will change the reward of Socket to 10.\n\n!reward Socket » Will show how many gold coin the government will pay if you kill Socket.\n\n!pay 10 » Will remove 10 gold coins from your reward.\n\n!support » Will show this to you."
    if getPlayerAccess(cid) > 3 then
      doPlayerPopupFYI(cid, str1)
      return true
    else
      doPlayerPopupFYI(cid, str)
      return true
    end
  end
end