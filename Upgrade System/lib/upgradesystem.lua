--[[


	PERFECT UPGRADE SYSTEM

				2.0


	Criado por Oneshot


	É proibido a venda ou a cópia sem os devidos créditos desse script.


]]--


UpgradeHandler = {

	levels = {

		[1] = {100, false, false},

		[2] = {90, false, false},

		[3] = {75, false, false},

		[4] = {60, true, false},

		[5] = {45, true, false},

		[6] = {30, true, false},

		[7] = {25, true, false},

		[8] = {20, true, true},

		[9] = {15, true, true},

		[10] = {10, true, true}

	},

	broadcast = 7,

	attributes = {

		["attack"] = 2,

		["defense"] = 2,

		["armor"] = 2

	},

	message = {

		console = "Trying to refine %s to level +%s with %s%% success rate.",

		success = "You have upgraded %s to level +%s",

		fail = "You have failed in upgrade of %s to level +%s",

		downgrade = "The upgrade level of %s has downgraded to +%s",

		erase = "The upgrade level of %s has been erased.",

		maxlevel = "The targeted %s is already on max upgrade level.",

		notupgradeable = "This item is not upgradeable.",

		broadcast = "The player %s was successful in upgrading %s to level +%s.\nCongratulations!!",

		invalidtool = "This is not a valid upgrade tool.",

		toolrange = "This upgrade tool can only be used in items with level between +%s and +%s"

	},

	tools = {

		[8306] = {range = {0, 10}, info = {chance = 0, removeable = true}},

	},


	isEquipment = function(self)

		local weaponType = self:getItemWeaponType()

		return ((weaponType > 0 and weaponType < 7) or self.item.armor ~= 0)

	end,


	setItemName = function(self, name)

		return doItemSetAttribute(self.item.uid, "name", name)

	end,


	chance = function(self)

		local chances = {}

		chances.upgrade = (self.levels[self.item.level + 1][1] or 100)

		chances.downgrade = (self.item.level * 5)

		chances.erase = (self.item.level * 3)


		return chances

	end

}


function UpgradeHandler:new(item)

	local obj, ret = {}

	obj.item = {}


	obj.item.level = 0

	obj.item.uid = item.uid

	for key, value in pairs(getItemInfo(item.itemid)) do

		obj.item[key] = value

	end


	ret = setmetatable(obj, {__index = function(self, index)

		if _G[index] then

			return (setmetatable({callback = _G[index]}, {__call = function(self, ...)

				return self.callback(item.uid, ...)

			end}))

		else

			return UpgradeHandler[index]

		end

	end})


	if ret:isEquipment() then

		ret:update()

		return ret

	end

	return false

end


function UpgradeHandler:update()

	self.item.level = (tonumber(self:getItemName():match("%+(%d+)")) or 0)

end


function UpgradeHandler:refine(uid, item)

	if not self.item then

		doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_BLUE, self.message.notupgradeable)

		return "miss"

	end	


	local tool = self.tools[item.itemid]


	if(tool == nil) then

		doPlayerSendTextMessage(uid, MESSAGE_EVENT_DEFAULT, self.message.invalidtool)

		return "miss"

	end


	if(self.item.level > #self.levels) then

		doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.maxlevel:format(self.item.name))

		return "miss"

	end


	if(self.item.level < tool.range[1] or self.item.level >= tool.range[2]) then

		doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.toolrange:format(unpack(tool.range)))

		return "miss"

	end


	local chance = (self:chance().upgrade + tool.info.chance)

	doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_BLUE, self.message.console:format(self.item.name, (self.item.level + 1), math.min(100, chance)))


	if(tool.info.removeable == true) then

		doRemoveItem(item.uid, 1)

	end


	if chance * 100 > math.random(1, 10000) then

		doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_ORANGE, self.message.success:format(self.item.name, (self.item.level + 1)))

		if (self.item.level + 1) >= self.broadcast then

			doBroadcastMessage(self.message.broadcast:format(getCreatureName(uid), self.item.name, (self.item.level + 1)))

		end


		self:setItemName((self.item.level > 0 and self:getItemName():gsub("%+(%d+)", "+".. (self.item.level + 1)) or (self:getItemName() .." +1")))

		for key, value in pairs(self.attributes) do

			if getItemAttribute(self.item.uid, key) ~= nil or self.item[key] ~= 0 then

				doItemSetAttribute(self.item.uid, key, (self.item.level > 0 and getItemAttribute(self.item.uid, key) or self.item[key]) + value)

			end

		end

		return "success"

	else

		if(self.levels[self.item.level][3] == true and (self:chance().erase * 100) > math.random(1, 10000)) then

			doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.erase:format(self.item.name))

			self:setItemName(self.item.name)

			for key, value in pairs(self.attributes) do

				if self.item[key] > 0 then

					doItemSetAttribute(self.item.uid, key, self.item[key])

				end

			end

		elseif(self.levels[self.item.level][2] == true and (self:chance().downgrade * 100) > math.random(1, 10000)) then

			doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.downgrade:format(self.item.name, (self.item.level - 1)))

			self:setItemName((self.item.level == 1 and self.item.name or self:getItemName():gsub("%+(%d+)", "+".. (self.item.level - 1))))

			for key, value in pairs(self.attributes) do

				if getItemAttribute(self.item.uid, key) ~= nil or self.item[key] ~= 0 then

					doItemSetAttribute(self.item.uid, key, (self.item[key] + value * (self.item.level - 1)))

				end

			end

		else

			doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.fail:format(self.item.name, (self.item.level + 1)))

		end

		return "fail"

	end

end