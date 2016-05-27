function onKill(cid,target)

  if isPlayer(cid) and isPlayer(target) then
    local sk = getCreatureSkullType(target)
    local level = getPlayerLevel(target)
    local prize = {0.7*level*100, 1.3*level*100} -- Coloque o min,max que vai adcionar na reward do player.
    if getPlayerIp(cid) ~= getPlayerIp(target) then
      if sk == SKULL_WHITE or sk == SKULL_RED or sk == SKULL_BLACK then
        if haveReward(getPlayerName(target)) then
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "The government payed ".. getPlayerReward(getPlayerName(target)) .." gold coins for the killer of ".. getPlayerName(target) ..". Thank you.")
          doPlayerAddMoney(cid, getPlayerReward(getPlayerName(target)))
          setPlayerReward(getPlayerName(target),0)
        else
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "That player aren't wanted.")
        end
      else
        doPlayerAddReward(getPlayerName(cid), math.random(prize[1],prize[2]))
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Now the government will pay ".. getPlayerReward(getPlayerName(cid)) .." gold coins for your head.")
        setPlayerReward(getPlayerName(target),0)  
      end
    end
  end
  retur