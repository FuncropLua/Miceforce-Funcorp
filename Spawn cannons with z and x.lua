--[[
• Since /mort will not work, mice can type !die, !mort or !kill to mort instead.
• You can change the object speed by using !speed command, the range should be from 5-25.
	e.g: !speed 10
• Objects will despawn (not all) to prevent lag/crash.
• Hold ctrl to select object
]]

local text = [[
<R><font size = '14'>Choose One:
<a href = 'event:10'><font color = '#2F7FCC'>•<J> Anvil</a>
<a href = 'event:39'><font color = '#2F7FCC'>•<J> Apple</a>
<a href = 'event:6'><font color = '#2F7FCC'>•<J> Ball</a>
<a href = 'event:23'><font color = '#2F7FCC'>•<J> Bomb</a>
<a href = 'event:27'><font color = '#2F7FCC'>•<J> Cannon</a>
<a href = 'event:33'><font color = '#2F7FCC'>•<J> Chicken</a>
<a href = 'event:34'><font color = '#2F7FCC'>•<J> Snowball</a>
<a href = 'event:95'><font color = '#2F7FCC'>•<J> Paper Ball</a>
<a href = 'event:89'><font color = '#2F7FCC'>•<J> Pumpkin Ball</a>
]]
local items = { 10 = true, 39 = true, 6 = true, 23 = true, 27 = true, 33 = true , 34 = true, 95 = true, 89 = true }
local funcrops = { ["Daichi"] = true, ["Icey00008"] = true, ["Kalani"] = true, ["Karl"] = true, ["+zen"] = true }
local obj, speed, count = 17, 25, 0

function eventNewPlayer(name)
	for _, keys in next, { 17, 88, 90 } do
		system.bindKeyboard(name, keys, true)
		system.bindKeyboard(name, keys, false)
	end
end

for name in next, tfm.get.room.playerList do
	eventNewPlayer(name)
end

function eventKeyboard(name, key, down, x, y)
	if key == 88 or key == 90 and tfm.get.room.playerList[name].isDead == false then
		if down then
			if obj == 17 then
				tfm.exec.addShamanObject(obj, x + (key == 88 and 35 or key == 90 and -35), y - 20, key == 88 and 90 or key == 90 and -90)
			else
				tfm.exec.addShamanObject(obj, x + (key == 88 and 35 or key == 90 and -35), y - 20, 0, key == 88 and speed or key == 90 and -speed)
			end
			count = count + 1
		end
	elseif key == 17 and funcrops[name] then
		if down then
			ui.addTextArea(1, text, name, 10, 30, 120, nil, 1, 1, 1)
		else
			ui.removeTextArea(1, name)
		end
	end
	
	if count == 10 then
		for o, p in next, tfm.get.room.objectList do
			if p.type == items[p.type] then
				tfm.exec.removeObject(o)
			end
		end
	end
end

function eventTextAreaCallback(id, name, cb)
		obj = cb
end

function eventChatCommand(name, message)
	local args, p, c = { }, 0, ""
	for slice in string.gmatch(message, "%S+") do
			if p == 0 then
				c = string.lower(slice)
			else 
				args[p] = slice
			end
			p = p + 1
	end
	
	if c == "mort" or c == "die" or c == "kill" then
		tfm.exec.killPlayer(name)
	elseif c == "speed" and funcrops[name] then
		if args[1] and type(tonumber(args[1])) == "number" then
			local ns = tonumber(args[1])
			if ns >= 5 and ns <= 25 then
				speed = ns
			else
				speed = 25
			end
		else
			speed = 25
		end
	elseif c == "clear" or c == "c" and funcrops[name] then
		for o, p in next, tfm.get.room.objectList do
			if p.type == items[p.type] then
				tfm.exec.removeObject(o)
			end
		end
	end
end
