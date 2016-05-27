grass = {8591, 4526, 4527, 4528, 4529, 4530, 4531, 4532, 4533, 4534, 4535, 4536, 4537, 4538, 4539, 4540, 4540, 4541, 9043, 9044, 9045, 9046, 9047, 9048, 9049, 9050, 9051, 9052, 9053, 9054, 9055, 9056, 9057, 9058}

driedgrass = {3264, 3265}

-- 1º
function isWalkable(pos, creature, proj, pz)-- by Nord
    if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
    if getTopCreature(pos).uid > 0 and creature then return false end
    if getTileInfo(pos).protection and pz then return false, true end
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

-- 2º
function hasGroundInDistance (uid, distance, tablegrama)
local checker = {} -- deixe assim
local pos = getThingPos(uid)
	for i = -distance, distance do
	for j = -distance, distance do
		local position = {x = pos.x + i, y = pos.y + j, z = pos.z, stackpos = 0}
		if i ~= 0 or j ~= 0 then
		local grama = getThingFromPos(position).itemid
			for k = 1, #tablegrama do
				if tablegrama[k] == grama then
				table.insert(checker, 1)
				end
			end
		end
	end
	end		
	if distance >= 1 then
		total = 0
		for x = 1, distance do
			number = x * 2 + 1
			t = (number * 2) + (2* (number-2))
			total = total + t
		end	
	end
return (#checker == total and true or false)
end

-- 3º
function checkGroundInDistance (uid, distance, tablegrama)
local checker = {} -- deixe assim
local pos = getThingPos(uid)
	for i = -distance, distance do
	for j = -distance, distance do
		local position = {x = pos.x + i, y = pos.y + j, z = pos.z, stackpos = 0}
		if i ~= 0 or j ~= 0 then
		local grama = getThingFromPos(position).itemid
			for k = 1, #tablegrama do
				if tablegrama[k] == grama then
				table.insert(checker, position)
				end
			end
		end
	end
	end		
return checker
end

-- 4º
function spinRotate(uid, spins, delay)
doCreatureSetNoMove(uid, true)
look = getCreatureLookDirection(uid)
	for i = 1, (4* spins) + 1 do		
		addEvent(function()
			if isPlayer(uid) then
				if i <= (4 * spins) then
					look = look < 3 and look + 1 or 0
					doCreatureSetLookDirection(uid, look)
				else
					doCreatureSetNoMove(uid, false)
				end
			end
		end, delay * i)	
	end
return true
end

-- 5º
function getPositionsByDirection(uid)
pos = getCreaturePosition(uid)
positionsByDirection = {
[0] = {
[1] = {x = pos.x + 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[2] = {x = pos.x + 1, y = pos.y, z = pos.z, stackpos = 0},
[3] = {x = pos.x + 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[4] = {x = pos.x, y = pos.y + 1, z = pos.z, stackpos = 0},
[5] = {x = pos.x - 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[6] = {x = pos.x - 1, y = pos.y, z = pos.z, stackpos = 0},
[7] = {x = pos.x - 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[8] = {x = pos.x, y = pos.y - 1, z = pos.z, stackpos = 0},
[9] = {x = pos.x, y = pos.y, z = pos.z, stackpos = 0}
},
[1] = {
[1] = {x = pos.x + 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[2] = {x = pos.x, y = pos.y + 1, z = pos.z, stackpos = 0},
[3] = {x = pos.x - 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[4] = {x = pos.x - 1, y = pos.y, z = pos.z, stackpos = 0},
[5] = {x = pos.x - 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[6] = {x = pos.x, y = pos.y - 1, z = pos.z, stackpos = 0},
[7] = {x = pos.x + 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[8] = {x = pos.x + 1, y = pos.y, z = pos.z, stackpos = 0},
[9] = {x = pos.x, y = pos.y, z = pos.z, stackpos = 0}
},
[2] = {
[1] = {x = pos.x - 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[2] = {x = pos.x - 1, y = pos.y, z = pos.z, stackpos = 0},
[3] = {x = pos.x - 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[4] = {x = pos.x, y = pos.y - 1, z = pos.z, stackpos = 0},
[5] = {x = pos.x + 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[6] = {x = pos.x + 1, y = pos.y, z = pos.z, stackpos = 0},
[7] = {x = pos.x + 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[8] = {x = pos.x, y = pos.y + 1, z = pos.z, stackpos = 0},
[9] = {x = pos.x, y = pos.y, z = pos.z, stackpos = 0}
},
[3] = {
[1] = {x = pos.x - 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[2] = {x = pos.x, y = pos.y - 1, z = pos.z, stackpos = 0},
[3] = {x = pos.x + 1, y = pos.y - 1, z = pos.z, stackpos = 0},
[4] = {x = pos.x + 1, y = pos.y, z = pos.z, stackpos = 0},
[5] = {x = pos.x + 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[6] = {x = pos.x, y = pos.y + 1, z = pos.z, stackpos = 0},
[7] = {x = pos.x - 1, y = pos.y + 1, z = pos.z, stackpos = 0},
[8] = {x = pos.x - 1, y = pos.y, z = pos.z, stackpos = 0},
[9] = {x = pos.x, y = pos.y, z = pos.z, stackpos = 0}
}
}
return positionsByDirection[getCreatureLookDirection(uid)]
end

-- 6º
function checkGroundInArray(array, tablegrama)
local checker = {} -- deixe assim
for i = 1, #array do
	local grama = getThingFromPos(array[i]).itemid
			for k = 1, #tablegrama do
				if tablegrama[k] == grama then
				table.insert(checker, array[i])
				end
			end
		end
return checker
end

-- 7º
function creatureGoToPos(uid, position, delay) 
	if not isOnSameFloor(getCreaturePosition(uid), position) then
		return isPlayer(uid) and doPlayerSendCancel(uid, "You are not in the same floor of destination.") or false
	end	
	local interPos, k = 0, 0	
	local range = getDistanceBetween(getCreaturePosition(uid), position)	
	while k < range and (getCreaturePosition(uid).x ~= position.x or getCreaturePosition(uid).y ~= position.y) do	
		k = k + 1
		addEvent(function()
			if isCreature(uid) then
				local fromPos = fromPos or getCreaturePosition(uid)
				dir = getDirectionTo(fromPos, position)
				toPos = getPosByDir(fromPos, dir)
				toPos.stackpos = STACKPOS_TOP_MOVEABLE_ITEM_OR_CREATURE
				if isWalkable(toPos, false, false, false) then
					doTeleportThing(uid, toPos)
					fromPos = toPos
				else			
					for i = 1, #getPositionsByDirection(uid) do
						interPos = interPos ~= 0 and interPos or getCreaturePosition(uid)
						if isWalkable(getPositionsByDirection(uid)[i], false, false, false) and getDistanceBetween(getPositionsByDirection(uid)[i], position) <= getDistanceBetween(interPos, position) then
							interPos = getPositionsByDirection(uid)[i]						
						end
					end
					doTeleportThing(uid, interPos)
					fromPos = interPos
				end
			end
		end, delay * k)	
	end	
	addEvent(function()
		if isPlayer(uid) then
			local pos = getCreaturePosition(uid)
			if pos.x == position.x and pos.y == position.y and pos.z == position.z then
				doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_BLUE, "You just arrived your destination.")
				doCreatureSetLookDirection(uid, 2)
			end
		end
	end, (delay * k) + 100)	
return k
end

-- 8º
function isOnSameFloor(fromPos, toPos)
return fromPos.z == toPos.z and true or false
end

-- 9º
function isEven(arg)
return arg % 2 == 0 and true or false
end

-- 10º
function getDistanceRadius(fromPos, toPos)
	if not isOnSameFloor(fromPos, toPos) then
	return false
	end
local distance = getDistanceBetween(fromPos, toPos)
return isEven(distance) and (distance/2) or math.floor(distance/2) + 1
end

-- 11º
function walkForward(uid)
local dir = getCreatureLookDirection(uid)
local pos = getCreaturePosition(uid)
local newPos = getPosByDir(pos, dir)
return doTeleportThing(uid, newPos)
end

-- 12º
function getMiddlePos(fromPos, toPos)
	if not isOnSameFloor(fromPos, toPos) then
	return false
	end
local middle = {x = 0, y = 0, z = 0}	
middle.x = isEven(fromPos.x + toPos.x) and (fromPos.x + toPos.x)/2 or math.floor((fromPos.x + toPos.x)/2) + 1
middle.y = isEven(fromPos.y + toPos.y) and (fromPos.y + toPos.y)/2 or math.floor((fromPos.y + toPos.y)/2) + 1
middle.z = fromPos.z or toPos.z
return middle
end

-- 13º
function Taunt(uid, target, delay, times) 
	local interPos, k = 0, 0		
	doCreatureSetNoMove(target, true)
	doSendMagicEffect(getCreaturePosition(target), 36)	
	while k < times do	
		k = k + 1				
		addEvent(function()
			if isCreature(uid) and isCreature(target) then
				if not isOnSameFloor(getCreaturePosition(uid), getCreaturePosition(target)) then
					return isPlayer(uid) and doPlayerSendCancel(uid, "You are not in the same floor of target.") or false
				end
				local range = getDistanceBetween(getCreaturePosition(uid), getCreaturePosition(target))
				local fromPos = fromPos or getCreaturePosition(target)
				doSendMagicEffect(getCreaturePosition(target), 13)
				dir = getDirectionTo(fromPos, getCreaturePosition(uid))
				toPos = getPosByDir(fromPos, dir)
				toPos.stackpos = STACKPOS_TOP_MOVEABLE_ITEM_OR_CREATURE				
					if range <= 1 then
						return false
					end				
				if isWalkable(toPos, false, true, true) then
					doTeleportThing(target, toPos)
					fromPos = toPos
				else			
					for i = 1, #getPositionsByDirection(target) do
						interPos = interPos ~= 0 and interPos or getCreaturePosition(target)
						if isWalkable(getPositionsByDirection(target)[i], false, true, true) and getDistanceBetween(getPositionsByDirection(target)[i], getCreaturePosition(uid)) <= getDistanceBetween(interPos, getCreaturePosition(uid)) then
							interPos = getPositionsByDirection(target)[i]						
						end
					end
					doTeleportThing(target, interPos)
					fromPos = interPos
				end
			end
		end, delay * k)	
	end		
	addEvent(function()
		if isCreature(target) then
			doCreatureSetNoMove(target, false)
		end
		if isMonster(target) then
			doMonsterSetTarget(target, uid)
		end
	end, (delay * k) + 100)		
return true
end

-- 14º
function getFloorsBetweenPos(fromPos, toPos)
return math.abs(fromPos.z - toPos.z)
end

-- 15º
function getLowestFloor(fromPos, toPos)
return fromPos.z > toPos.z and toPos.z or fromPos.z
end

-- 16º
function getAllPlayersInArea(fromPos, toPos)
local players = {}	
local andares = getFloorsBetweenPos(fromPos, toPos)
	for index, creature in ipairs(getPlayersOnline()) do
		local z = getLowestFloor(fromPos, toPos)
		local frompos = {x = fromPos.x, y = fromPos.y, z = fromPos.z}
		local topos = {x = toPos.x, y = toPos.y, z = toPos.z}		
		for i = 0, andares do
			z = z or 0
			frompos.z = z + i
			topos.z = z + i	
			if isInArea(getThingPos(creature), frompos, topos) then
				table.insert(players, creature)
			end
		end
	end
return players
end

-- 17º
function clearArea(middlePos, rangex, rangey, mob, player)
	for i = -rangex, rangex do
	for j = -rangey, rangey do
		pos = {x = middlePos.x + i, y = middlePos.y + j, z = middlePos.z}
		creature = getTopCreature(pos).uid		
		if isMonster(creature) and mob then
			doSendMagicEffect(getThingPos(creature), 14)
			addEvent(doCreateMonster, 1000, getCreatureName(creature), pos)
			doRemoveCreature(creature)
		end
		if isPlayer(creature) and player then
			doSendMagicEffect(getThingPos(creature), 14)
			doTeleportThing(creature, getTownTemplePosition(getPlayerTown(creature)))
		end
	end
	end
return true
end

-- 18º
function addQuery(table, name, tipo, default)
if type(table) ~= 'string' and type(name) ~= "string" and (type(tipo) ~= "string") then
		return nil, error('Voce presisa inserir um valor do tipo string.')
end
tipo = string.upper(tipo)
db.executeQuery("ALTER TABLE `"..table.."` ADD `"..name.."` "..tipo.." NOT NULL DEFAULT "..default..";")
end

-- 19º
function loopEffect(uid, effect, tempo)
		local effectPositions = getPositionsByDirection(uid)
		doSendDistanceShoot(effectPositions[math.random(#effectPositions)], effectPositions[math.random(#effectPositions)], effect)
		addEvent(function()
		   if isCreature(uid) then
			  loopEffect(uid, effect, tempo)
		   end
		end, 1000 * tempo)
return true
end

-- 20º
function getDistanceToMiddle(fromPos, toPos)
local middlePos = getMiddlePos(fromPos, toPos)
local pos = {
x = math.max(math.abs(middlePos.x - fromPos.x), math.abs(middlePos.x - toPos.x)),
y = math.max(math.abs(middlePos.y - fromPos.y), math.abs(middlePos.y - toPos.y)),
z = middlePos.z
}
return pos
end

-- 21º
function pairsByKeys(t, f) -- Lua.org
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
    end
return iter
end
	
-- 22º
function table.max(t)
	local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, function(a, b) return a > b end)
return a[1]
end

-- 23º
function table.min(t)
	local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
return a[1]
end

-- 24º
function doKillCreature(uid)-- by Shawak
	return doCreatureAddHealth(uid, -getCreatureHealth(uid))
end

-- 25º
function isHandItem(uid) -- NW based on Mock
uid = uid or 0
    if isInArray({1,2,3,4,5,6}, getItemWeaponType(uid)) then
        return true
    end
return false
end

-- 26º
function isWearing(uid)
uid = uid or 0
	for i = 1, 10 do         
		if isInArray({uid}, getPlayerSlotItem(uid, i).uid) then
		return true
		end
	end
    return false
end

-- 27º
function getItemDodgePercent(itemuid)
	return getItemAttribute(itemuid, "dodgePercent") or 0
end

-- 28º
function setItemDodgePercent(uid, percent)
doItemSetAttribute(uid, "description", "[Dodge: "..percent.."%]")
doItemSetAttribute(uid, "dodgePercent", percent)
end

-- 29ª
function tableToString(tb) -- by Mock
	if type(tb) ~= "table" then
		return nil, error("bad argument #1 to 'saveTable' (table expected, got "..type(tb)..")", 2)
	end
	local str = "{"
	for k,d in pairs(tb) do
		if type(k) == 'string' then
			if type(d) == 'string' then
				str = str..""..k.."='"..d.."',"
			elseif type(d) == 'number' or type(d) == 'boolean' then
				str = str..""..k.."="..tostring(d)..","
			elseif type(d) == 'table' then
				str = str..'{'
				for e,f in pairs(d) do
					if type(e) == 'string' then
						if type(f) == 'string' then
							str = str..""..e.."='"..f.."',"
						elseif type(f) == 'number' or type(e) == 'boolean' then
							str = str..""..e.."="..tostring(f)..","
						elseif type(f) == 'table' then
							str = str..""..e.."="..tableToString(f)..","
						end
					elseif type(e) == 'number' then
						if type(f) == 'string' then
							str = str.."["..e.."]='"..f.."',"
						elseif type(f) == 'number' or type(f) == 'boolean' then
							str = str.."["..e.."]="..tostring(f)..","
						elseif type(f) == 'table' then
							str = str.."["..e.."]="..tableToString(f)..","
						end
					end
				end
				str = str..'},'
			end
		elseif type(k) == 'number' then
			if type(d) == 'string' then
				str = str.."["..k.."]='"..d.."',"
			elseif type(d) == 'number' or type(d) == 'boolean' then
				str = str.."["..k.."]="..tostring(d)..","
			elseif type(d) == 'table' then
				str = str..'{'
				for e,f in pairs(d) do
					if type(e) == 'string' then
						if type(f) == 'string' then
							str = str..""..e.."='"..f.."',"
						elseif type(f) == 'number' or type(e) == 'boolean' then
							str = str..""..e.."="..tostring(f)..","
						elseif type(f) == 'table' then
							str = str..""..e.."="..tableToString(f)..","
						end
					elseif type(e) == 'number' then
						if type(f) == 'string' then
							str = str.."["..e.."]='"..f.."',"
						elseif type(f) == 'number' or type(f) == 'boolean' then
							str = str.."["..e.."]="..tostring(f)..","
						elseif type(f) == 'table' then
							str = str.."["..e.."]="..tableToString(f)..","
						end
					end
				end
				str = str..'},'
			end
		end
	end
	local str = str.."}"
	if string.sub(str,string.len(str)-2,string.len(str)-2) == "," then
		str = string.sub(str,0,string.len(str)-3).."}"
	end
	return str
end
table.tostring = tableToString

-- 30º
function saveTable(table,name)-- by Mock
	if type(table) ~= "table" then
		return nil, error("bad argument #1 to 'saveTable' (table expected, got "..type(table)..")", 2)
	end
	if type(name) ~= 'string' then
		error('Voce presisa inserir um valor do tipo string')
	end
	local file = io.open('data/storage/'..name..'.tbl','r')
	if file == nil then
		local file = io.open('data/storage/'..name..'.tbl','w')
		file:write(tableToString(table))
		file:close()
	else
		file:close()
		local file = io.open('data/storage/'..name..'.tbl','w')
		file:write("")
		file:close()
		local file = io.open('data/storage/'..name..'.tbl','w')
		file:write(tableToString(table))
		file:close()
	end
end

-- 31º
function loadTable(name)-- by Mock
	if type(name) ~= 'string' and type(name) ~= "number" then
		return nil, error('Voce presisa inserir um valor do tipo string ou number.')
	end
	if io.open('data/storage/'..name..'.tbl','r') == nil then
		return nil
	end
	local file = io.open('data/storage/'..name..'.tbl','r')
	local f ,err = loadstring("return "..file:read())
	if err then
		return nil, error('Error in file "data/storage/'..name..'.tbl". Data lost.')
	end
	file:close()
	return f()
end

-- 32º
function getWeapon(uid)
	teste = getPlayerSlotItem(uid, CONST_SLOT_RIGHT)
	if teste.itemid > 0 then
		if not isThatWeapon(teste.uid) then
			teste = getPlayerSlotItem(uid, CONST_SLOT_LEFT)
		end
	else
		teste = getPlayerSlotItem(uid, CONST_SLOT_LEFT)
	end

	if teste.itemid > 0 then
		if not isThatWeapon(teste.uid) then
			teste = false
		end
	else
		teste = false
	end
return teste
end

-- 33º
function getItemLevel(uid, maxlevel)
	level = 0
	local name = getItemName(uid)
	
	for i = 1, maxlevel do
		if string.find(tostring(name),"+".. i .."") then
			level = i
			end
		end
return level
end

-- 34º
function getMirroredPos(uid, target, radius)
	n = radius or 1
	local pos = getCreaturePosition(uid)
	local middlePos = getCreaturePosition(target)
	local vPos = {x = pos.x - middlePos.x, y = pos.y - middlePos.y, z = 0}	
	for i, k in pairs (vPos) do
		if math.abs(k) > n and i == "x" then
			vPos.x = k >= 0 and n or -n
		elseif math.abs(k) > n and i == "y" then
			vPos.y = k >= 0 and n or -n
		end
	end
	local finalPos = {x = middlePos.x - vPos.x, y = middlePos.y - vPos.y, z = pos.z}
	b = 0
	while not isWalkable(finalPos, true, true, true) and b < radius do
	b = b + 1
	if b == radius then
		finalPos = pos
	    break
	end
	n = n - 1
		for i, k in pairs (vPos) do		
			if math.abs(k) > n and i == "x" then
				vPos.x = k >= 0 and n or -n
			elseif math.abs(k) > n and i == "y" then
				vPos.y = k >= 0 and n or -n
			end
		end
	finalPos = {x = middlePos.x - vPos.x, y = middlePos.y - vPos.y, z = pos.z}
	end
return finalPos
end

-- 35º
function outfitOnWalk(uid, key, id, tempo, lastPos)
	if getPlayerStorageValue(uid, key) - os.time() >= 0 then
		lastPos = lastPos or getCreaturePosition(uid)
		if getCreaturePosition(uid).x ~= lastPos.x or getCreaturePosition(uid).y ~= lastPos.y or getCreaturePosition(uid).z ~= lastPos.z  then
			lastPos = getCreaturePosition(uid)
			local atual = getCreatureOutfit(uid)
			atual.lookType = id
			doSetCreatureOutfit(uid, atual, tempo)
		end
	addEvent(function()
		if isCreature(uid) then
			outfitOnWalk(uid, key, id, tempo, lastPos)
		end
	end, tempo) 
	end
return true
end

-- 36º
function onCastChannel(uid, target, delay, effect, key)
local str = {"Casting:\n[", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "]"}
local pos = getCreaturePosition(uid)
effect = effect or 255
key = key or 88888
delay = delay or 200
setPlayerStorageValue(uid, key, 0)
for i = 2, 11 do
addEvent(function()
	if isCreature(uid) and getCreaturePosition(uid).x == pos.x and getCreaturePosition(uid).y == pos.y and (getCreatureTarget(uid) == target or not target) then
		if str[i-1] ~= "   " then		
			str[i] = "@"
			local msg = ""
			for _, k in pairs(str) do
			msg = msg.."".. k ..""
			end
			if isEven(i) then
				doSendMagicEffect(getCreaturePosition(uid), effect)
			end
			setPlayerStorageValue(uid, key, i)
			doPlayerSendTextMessage(uid, 25, msg)
		end
	end
end, delay * (i - 1))
end
return delay * (#str - 1)
end

-- 37º
function doBlast(uid, target, delay, effectx, effectz, percent, min, max, type, hits, fromPos, n)
	if fromPos ~= nil and (fromPos.x ~= getCreaturePosition(target).x or fromPos.y ~= getCreaturePosition(target).y) then
		doSendDistanceShoot(fromPos, getCreaturePosition(target), effectx)
		fromPos = (fromPos.x ~= getCreaturePosition(target).x or fromPos.y ~= getCreaturePosition(target).y) and getCreaturePosition(target) or nil
	else
		fromPos = getCreaturePosition(target)
	end	
doTargetCombatHealth(uid, target, type, -min, -max, effectz)
n = n or 1
if math.random(1, 10) <= (percent/10) then
	possible = {}
	for j = -3, 3 do
	for k = -3, 3 do
		middlePos = {x = getCreaturePosition(target).x + j, y = getCreaturePosition(target).y + k, z = getCreaturePosition(target).z, stackpos = 253}
		if isWalkable(middlePos, false, true, true) then
			creature = getTopCreature(middlePos).uid		
			if creature > 0 then
				table.insert(possible, creature)
			end
		end
	end
	end		
	target = #possible > 0 and possible[math.random(#possible)] or target
end		
if n < hits then
	addEvent(function()
	if isCreature(uid) and isCreature(target) then
		doBlast(uid, target, delay, effectx, effectz, percent, min, max, type, hits, fromPos, (n + 1))
	end
	end, delay)
end
return true
end

-- 38º
function doShowTimeByPos(uid, pos, duration, type)
type = type or 20
	for i = 0, (duration - 1) do
	addEvent(function()
		if isCreature(uid) then
			doCreatureSay(uid, tostring(duration - i), type, false, 0, pos)
		end
	end, i * 1000)
	end
return true
end


-- functions of TFS Compiled (removed from OTAL)
function setItemName(uid,name)
 return doItemSetAttribute(uid,'name',name)
end

function setItemArmor(uid,name)
 return doItemSetAttribute(uid,'armor',name)
end

function setItemDefense(uid,name)
 return doItemSetAttribute(uid,'defense',name)
end

function setItemAttack(uid,name)
 return doItemSetAttribute(uid,'attack',name)
end

function getItemAttack(uid)
   return getItemAttribute(uid,'attack')
end

function getItemDefense(uid)
   return getItemAttribute(uid,'defense')
end

function getItemArmor(uid)
   if type(uid) == 'number' then
      return getItemAttribute(uid,'armor')
   else
      return getItemInfo(uid.itemid).armor
   end
end