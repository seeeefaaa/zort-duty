

ESX = nil
local coreLoaded = false
local mekankord = vector3(908.073, -1416.7, 12.2402) --Kordinat Girin
local lodLoaded = false


RegisterNUICallback('lod:loaded', function()
    lodLoaded = true
end)

RegisterNetEvent("duty:mesaigir")
AddEventHandler("duty:mesaigir", function()
    local player = PlayerPedId()
    local job = ESX.PlayerData.job.name

    if job == 'police' or job == 'ambulance' then
        exports['mythic_notify']:SendAlert('error', 'Zaten mesaidesin!', 3000)
        return
    end

    if job == 'offpolice' or job == 'offambulance' then
        local playercoords = GetEntityCoords(player)
        local job = string.sub(job, 4)
        local jobcoords = Config[job].coords
        local distance = #(playercoords - jobcoords)
        TriggerServerEvent('duty:mesaigiris')
    end
end)

RegisterNetEvent("duty:mesaicik")
AddEventHandler("duty:mesaicik", function()
    local player = PlayerPedId()
    local job = ESX.PlayerData.job.name
    if job == 'offpolice' or job == 'offambulance' then
        exports['mythic_notify']:SendAlert('error', 'Zaten mesaide değilsin!', 3000)
        return
    end

    if job == 'police' or job == 'ambulance' then
        local playercoords = GetEntityCoords(player)
        local jobcoords = Config[job].coords
        local distance = #(playercoords - jobcoords)
        TriggerServerEvent('duty:mesaicikis')
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true

    local blip = AddBlipForCoord(mekankord)
    SetBlipSprite(blip, 473)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, 41)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Police Station")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    while not ESX and not ESX.GetPlayerData() or not lodLoaded do
        Wait(0)
    end


    SendNUIMessage({                    
        playerName = true; 
    }) 
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        
    })
end
RegisterCommand("mesai", function()
    SetDisplay(not display)
end)

Citizen.CreateThread(function()
	while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local mesafe = #(mekankord - coords)
        if mesafe < 20 and coreLoaded then
            time = 1
    if ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'offpolice'  then
            DrawMarker(2, mekankord.x, mekankord.y, mekankord.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 0, 0, 200, false, true, false, false, false, false, false)
            if mesafe < 3 then
                local yazi = ""
                if mesafe < 1 then
                    yazi = "[E] "
                    if IsControlJustReleased(0, 38) then
                        SetDisplay(not display)
                        SendNUIMessage({
                            showUI = true; 
                        }) 
                    end
                end
                DrawText3D(mekankord.x, mekankord.y, mekankord.z-0.35, yazi.."Police Station")
            end
        end
    end
        Citizen.Wait(time)
    end
end)







RegisterNUICallback("close", function(data)
    SetDisplay(bool)
    SendNUIMessage({
        showUI = false; 
    }) 
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end





RegisterNUICallback('Mesaicik', function()
    TriggerServerEvent('duty:mesaicikis')
end)

RegisterNUICallback('Mesaigir', function()
    TriggerServerEvent('duty:mesaigiris')
end)



