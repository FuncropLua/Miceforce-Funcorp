--[[
Since /mort will not work, mice can type !die, !mort or !kill to mort instead.
You can change the cannon speed by using !speed command, the range should be from 20-100.
e.g: !speed 90
]]

local funcrops = { Daichi = true, Icey00008 = true, Kalani = true, Karl = true, +zen = true }
local speed = 70

keys = { z = 90, x = 88 }
function eventNewPlayer(name)
	for _, keys in next, keys do
		system.bindKeyboard(name, keys, true)
	end
end

for name in next, tfm.get.room.playerList do
	eventNewPlayer(name)
end

function eventKeyboard(name, keys, down, x, y)
	if tfm.get.room.playerList[name].isDead == false then
		tfm.exec.addShamanObject(17, x + (keys == keys.x and 35 or keys == keys.z and -35), y, keys == keys.x and 90 or keys == keys.z and -90, speed)
	end
end

function eventChatCommand = function(name, message)
	if message == "mort" or message == "die" or message == "kill" then
		tfm.exec.killPlayer(name)
	elseif funcrops[name] and string.sub(message, 1, 5) == "speed" then
		local new_speed = tonumber(string.sub(message, 7))
		if type(new_speed) == "number" then
			if new_speed >= 20 and new_speed =< 100 then
				speed = new_speed
			else
				speed = 70
			end
		else
			speed = 70
		end
	end
end
