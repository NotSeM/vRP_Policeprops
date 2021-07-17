vRPpm = {}
Tunnel.bindInterface("vRP_Policeprops",vRPpm)
Proxy.addInterface("vRP_Policeprops",vRPpm)
PMserver = Tunnel.getInterface("vRP_Policeprops","vRP_Policeprops")
vRPserver = Tunnel.getInterface("vRP","vRP_Policeprops")
vRP = Proxy.getInterface("vRP")



-- HT BASE FUNKTION --
HT = nil

Citizen.CreateThread(function()
	while HT == nil do
		TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1)
                  if IsControlJustReleased(1, 344) then
                      HT.TriggerServerCallback("TjekPoliti", function(cb)
                          if cb then
                              openPropMenu()
                          end
                      end)
                  end
              
  end
end)

-- LABELS --
function openPropMenu()
    local elements = {
        { label = "Sømmåtte", value = "som" },
        { label = "Kegle", value = "kegle" },
        { label = "Vej Blokade", value = "blokade" }, 
        { label = "Luk", value = "Luk" },
    }
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "vrp_htmenu", 
        {
            title    = "Traffik Menu",
            align    = "right",
            elements = elements
        },
    

-- SØMMÅTTE FUNKTION --    
        function(data, menu)
        menu = menu
        if(data.current.value == 'som') then
            TriggerEvent('spike')

end



-- KEGLE FUNKTION --
    if(data.current.value == 'kegle') then
        TriggerEvent('kegle')
end


-- VEJBLOKADE FUNKTION --
if(data.current.value == 'blokade') then
    TriggerEvent('vejblokade')
end



-- LUK FUNKTION --
        if(data.current.value == 'Luk') then
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end



-- SPIKE PROP --

RegisterNetEvent('spike')
AddEventHandler('spike', function()
    SetSpikesOnGround()
end)

function SetSpikesOnGround()
    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    spike = GetHashKey("P_ld_stinger_s")

    RequestModel(spike)
    while not HasModelLoaded(spike) do
      Citizen.Wait(1)
    end

    local object = CreateObject(spike, x+1, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
end


-- KEGLE PROP --
RegisterNetEvent('kegle')
AddEventHandler('kegle', function()
    vRPpm.setConeOnGround()
end)

function vRPpm.setConeOnGround()
    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    cone = GetHashKey("prop_mp_cone_02")

    RequestModel(cone)
    while not HasModelLoaded(cone) do
      Citizen.Wait(1)
    end

    local object = CreateObject(cone, x+1, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
end



-- VEJ BLOKADE PROP --
RegisterNetEvent('vejblokade')
AddEventHandler('vejblokade', function()
    vRPpm.setBarrierOnGround()
end)

function vRPpm.setBarrierOnGround()
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	h = GetEntityHeading(ped)
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, -1.0, 1.0, -1.65))
	barrier = GetHashKey("prop_mp_barrier_02b")

    RequestModel(barrier)
    while not HasModelLoaded(barrier) do
      Citizen.Wait(1)
    end

    local object = CreateObject(barrier, ox, oy, oz, true, true, false)
    PlaceObjectOnGroundProperly(object)
	SetEntityHeading(object, h+90)
end

-- FJERN ALLE --
RegisterNetEvent('fjernalle')
AddEventHandler('fjernalle', function()
        DeleteObject(spike)
        DeleteObject(cone)
        DeleteObject(barrier)
       end)


