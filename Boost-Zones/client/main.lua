local display = false
local isInArea = false
local zone = nil
local cache = {}


Citizen.CreateThread(function()
	for _, zone in pairs(Config.zones) do
		if Config.debug then
			zoneblip = AddBlipForRadius(zone.blip.pos, zone.blip.radius)
			SetBlipSprite(zoneblip,1)
            SetBlipColour(zoneblip,49)
            SetBlipAlpha(zoneblip,75)
		end
	end

	for _, info in pairs(Config.zones) do
		if Config.debug then
			info.blips = AddBlipForCoord(info.blip.pos)
			SetBlipSprite(info.blips, 1)
            SetBlipDisplay(info.blips, 4)
            SetBlipColour(info.blips, 2)
            SetBlipAsShortRange(info.blips, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.name)
            EndTextCommandSetBlipName(info.blips)
		end
	end
end)

-- ZONES
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(20)
		for k in pairs(Config.zones) do
        	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = nil
			if Config.useHeight then
				dist = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, Config.zones[k].blip.pos, true)
			else
				dist = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, Config.zones[k].blip.pos, false)
			end
			local radius = Config.zones[k].blip.radius / (3.14 * 2) / 1.25
			if dist <= radius then
				if not isInArea then
					table.insert(cache, Config.zones[k].name)
					TriggerEvent("Boost-Zones:nui:on", Config.zones[k].name, Config.zones[k].description)
					Wait(Config.showTime)
					TriggerEvent("Boost-Zones:nui:off", Config.zones[k].name)
				end
				isInArea = true
			--print("Cache ".. cache[1] .. " | " .. Config.zones[k].name)					
			elseif cache[1] == Config.zones[k].name then
				isInArea = false
				for k in pairs (cache) do
					cache[k] = nil
				end
			end
		end
	end
end)


RegisterNetEvent('Boost-Zones:nui:on')
AddEventHandler('Boost-Zones:nui:on', function(data, desc)
  SendNUIMessage({
	type = "ui",
	display = true,
	zone = data,
	description = desc
  })
end)

RegisterNetEvent('Boost-Zones:nui:initialize')
AddEventHandler('Boost-Zones:nui:initialize', function(data)
  SendNUIMessage({
	type = "setUp",
	display = false,
	zone = data
  })
end)

RegisterNetEvent('Boost-Zones:nui:off')
AddEventHandler('Boost-Zones:nui:off', function(data)
  SendNUIMessage({
	type = "ui",
	display = false,
	zone = data
  })
end)
