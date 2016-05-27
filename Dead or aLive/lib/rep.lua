function rewardtable()
local q = db.executeQuery("ALTER TABLE `players` ADD `reward` INT NOT NULL DEFAULT '0' AFTER `name`;")
  return q
end 
function setPlayerReward(player,qnt)
  db.executeQuery("UPDATE `players` SET `reward` = '".. qnt .."' WHERE `name` = '".. player .."' LIMIT 1;")
  return true
end
function getPlayerReward(player)
local get = db.getResult("SELECT `reward` FROM `players` WHERE `name` = '".. player .."';")
local reward = get:getDataInt('reward')
  return reward
end
function haveReward(player)
  if getPlayerReward(player) > 0 then
    return true
  end
  return false
end
function doPlayerAddReward(player,qnt)
t = (qnt and qnt or 1)
local get = db.getResult("SELECT `reward` FROM `players` WHERE `name` = '".. player .."';")
local reward = get:getDataInt('reward')
  return db.executeQuery("UPDATE `players` SET `reward` = '".. reward + t .."' WHERE `name` = '".. player .."' LIMIT 1;")
end
function doPlayerRemoveReward(player,qnt)
t = (qnt and qnt or 1)
local get = db.getResult("SELECT `reward` FROM `players` WHERE `name` = '".. player .."';")
local reward = get:getDataInt('reward')
  if reward > t then
    return db.executeQuery("UPDATE `players` SET `reward` = '".. reward - t .."' WHERE `name` = '".. player .."' LIMIT 1;")
  else
    return db.executeQuery("UPDATE `players` SET `reward` = '".. 0 .."' WHERE `name` = '".. player .."' LIMIT 1;")
  end
end