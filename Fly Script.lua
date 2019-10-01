function eventNewPlayer(name)
	for _, keys in next, { 32, 3 } do
		system.bindKeyboard(name, keys, true)
	end
end

for name in next, tfm.get.room.playerList do
	eventNewPlayer(name)
end

function eventChatCommand(name, message)
	if message == "die" or message == "mort" or message == "kill" then
		tfm.exec.killPlayer(name)
	end
end

function eventKeyboard(name, key, down, x, y)
	if tfm.get.room.playerList[name].isDead == false then
		tfm.exec.movePlayer(name, 0, 0, false, 0, -80, false)
	end
end
