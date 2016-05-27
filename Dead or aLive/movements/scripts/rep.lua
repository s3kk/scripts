local sex = {
  [0] = 'she\'s',
  [1] = 'he\'s',
}
local config = {
  bc = true, -- se quer que mande uma mensagem global de que alguem entro num lugar errado e está procurado coloque true, se não false.
  uid = 1000, -- unique id do tile.
  reward = 1500 -- quantidade que vai adcionar na reward do player.
}

function onStepIn(cid, item, pos)
  if item.uid == config.uid then
    doPlayerAddReward(getPlayerName(cid),config.reward)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "You entered an area of government, now you're wanted for ".. getPlayerReward(getPlayerName(cid)) .." gold coins.")
    if config.bc == true then
      doBroadcastMessage(getPlayerName(cid).." have entered an area of government, now ".. sex[getPlayerSex(cid)] .." wanted for ".. getPlayerReward(getPlayerName(cid)) .. " gold coins.", 22)
    end
  end
  return true
end