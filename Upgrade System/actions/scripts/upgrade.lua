function onUse(cid, item, fromPosition, itemEx, toPosition)

	if isCreature(itemEx.uid) then	

		return doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)

	end


	local obj = UpgradeHandler:new(itemEx)


	if(obj == false) then

		return doPlayerSendCancel(cid, UpgradeHandler.message.notupgradeable)

	end


	local status = obj:refine(cid, item)

	if status == "success" then

		--doSendAnimatedText(toPosition, "Success!", COLOR_GREEN)

		doSendMagicEffect(toPosition, CONST_ME_MAGIC_GREEN)

	elseif status == "fail" then

		--doSendAnimatedText(toPosition, "Fail!", COLOR_RED)

		doSendMagicEffect(toPosition, CONST_ME_POFF)

	else

		doSendMagicEffect(toPosition, CONST_ME_POFF)

	end

	return true

end