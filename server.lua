ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('duty:mesaigiris')
AddEventHandler('duty:mesaigiris', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'police' or job == 'ambulance' then 
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Zaten mesaidesin!'})
        return
    end

    if job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiye girdin!'})
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiye girdin!'})
    end
end)

RegisterServerEvent('duty:mesaicikis')
AddEventHandler('duty:mesaicikis', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'offpolice' or job == 'offambulance' then 
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Zaten mesaide değilsin!'})
        return
    end
 

    if job == 'police' then
        xPlayer.setJob('offpolice', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiden çıktın!'})
    elseif job == 'ambulance' then
        xPlayer.setJob('offambulance', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiden çıktın!'})
    end
end)

-- function getIdentity(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local identifier = xPlayer.getIdentifier()
--     local result = exports.ghmattimysql:executeSync("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
   
--     if result[1] ~= nil then
--         local identity = result[1]
--         print(json.encode(identity))
--         fullName =  result[1].firstname .. ' ' .. result[1].lastname
--         return {
--             firstname = identity['firstname'],
--             lastname = identity['lastname'],
--             return fullName
--         }
--     else
--         return nil
--     end
-- end

-- function getIdentity(source)
--     local identifier = GetPlayerIdentifiers(source)[1]
--     local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
--     if result[1] ~= nil then
--         local identity = result[1]
--         return {
--             firstname = identity['firstname'],
--             lastname = identity['lastname'],
--         }
--     else
--         return nil
--     end
-- end

--  ESX.RegisterServerCallback("cagan:GetPlayerName", function(source, cb)
--     cb(getIdentity(source))
--  end)

