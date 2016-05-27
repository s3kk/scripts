local config = {
minlevel = 8, --- level que precisa pra comprar o livro
price = 1000000, --- preço do livro
itemid = 1950 --- ID DO LIVRO
}
--- end config


function getDodgeSkill(cid)
dodgeskill = getPlayerStorageValue(cid, 48902)
return dodgeskill
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

-- OTServ event handling functions start
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                      npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
    -- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
    if (not npcHandler:isFocused(cid)) then
        return false
    end
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid

if msgcontains(msg, 'skill book') then
if getDodgeSkill(cid)  == dodgeskill then
selfSay('You want to buy Skill Book [DODGE]? It will cost '..config.price..' gp\'s!', cid)
talkState[talkUser] = 1
else
selfSay('I couldnt acess your data bank!', cid)
end
elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
if getPlayerMoney(cid) < config.price then
selfSay('Its necessary to have at least '..config.price..' gp\'s in order to buy the Skill Book!', cid)
elseif getPlayerLevel(cid) < config.minlevel then
selfSay('The minimum level for buying this skill book is '..config.minlevel..'!', cid)
else
doPlayerRemoveMoney(cid,config.price)
doPlayerAddItem(cid, config.itemid, 1, TRUE)
end
talkState[talkUser] = 0
elseif(msgcontains(msg, 'no')) and isInArray({1}, talkState[talkUser]) == TRUE then
talkState[talkUser] = 0
selfSay('Ok.', cid)
elseif msgcontains(msg, 'level') then
selfSay('You have Leveled your Dodge Skill to ['..getDodgeSkill(cid)..'/100].', cid)
end


return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new()) 