local positions = {
    [""] = {x = xxxxx, y = xxxxx, z = x},
	[""] = {x = xxxxx, y = xxxxx, z = x}
}

function onThink(cid, interval, lastExecution)
    for text, pos in pairs(positions) do
        doSendAnimatedText(pos, text, math.random(1, 255))
    end

    return true
end