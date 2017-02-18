-- "\nResets: "..getResets(cid)..
function onSay(cid, words, param)

local level = getPlayerLevel(cid)
local vocation = getPlayerVocationName(cid)
local health, maxhealth = getCreatureHealth(cid), getCreatureMaxHealth(cid)
local mana, maxmana = getCreatureMana(cid), getCreatureMaxMana(cid)
local fist, club, sword, axe = getPlayerSkillLevel(cid, 0), getPlayerSkillLevel(cid, 1), getPlayerSkillLevel(cid, 2), getPlayerSkillLevel(cid, 3)
local distance, shield, fishing, magic =  getPlayerSkillLevel(cid, 4), getPlayerSkillLevel(cid, 5), getPlayerSkillLevel(cid, 6), getPlayerMagLevel(cid)
--[[local function getResets(cid)
resets = getPlayerStorageValue(cid, 2310)
	if resets < 0 then
		resets = 0
	end
return resets
end]]

local cap = getPlayerFreeCap(cid)
local text = "Vocation: "..vocation.."\nLevel: ".. level .."\nHP: ".. health .."/".. maxhealth .."\nMP: ".. mana .."/".. maxmana .."\n\nMagic Level: ".. magic .."\n\nFist: ".. fist .."\nClub: ".. club .."\nSword: ".. sword .."\nAxe: ".. axe .."\nDistance: ".. distance .."\nShield: ".. shield .."\nFishing: ".. fishing ..""
doShowTextDialog(cid, 5808, text)
return true
end