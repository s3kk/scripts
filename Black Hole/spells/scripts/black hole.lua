local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -9.0, -30, -10.0, 4)


arr = {
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 3, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)


function canEffect(pos, pz, proj) -- Night Wolf based on Nord
if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
if getTilePzInfo(pos) and not pz then return false end
local n = not proj and 3 or 2
for i = 0, 255 do
pos.stackpos = i
local tile = getTileThingByPos(pos)
if tile.itemid ~= 0 and not isCreature(tile.uid) then
if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
return false
end
end
end
return true
end


function onCastSpell(cid, var)
local pos = getPlayerPosition(cid)
local player = getThingfromPos({x=pos.x,y=pos.y,z=pos.z,stackpos= 253})
local raio = 3 -- alcance do buraco negro
i = ((pos.x)-raio)
while i <= ((pos.x)+raio) do
j = ((pos.y)-raio)
while j <= ((pos.y)+raio) do
player = getThingfromPos({x=i,y=j,z=pos.z,stackpos=253})
if ((isMonster(player.uid) or isPlayer(player.uid)) and ((math.abs(i-(pos.x)) > 1) or (math.abs(j-(pos.y)) > 1)) and (canEffect({x = i, y = j, z = pos.z}))) then

npos = getClosestFreeTile(cid, pos, false, true)
if canEffect(npos) then
doSendMagicEffect(npos, 10)
doTeleportThing(player.uid,npos, false)
end

end
j = j + 1
end
i = i + 1
end
doCombat(cid, combat, var)
return true
end
