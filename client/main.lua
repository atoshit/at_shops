local ESX <const> = exports['es_extended']:getSharedObject()
local display = false
local nearestShop = nil
local GetEntityCoords <const> = GetEntityCoords
local PlayerPedId <const> = PlayerPedId
local DrawMarker <const> = DrawMarker
local Wait <const> = Wait
local IsControlJustReleased <const> = IsControlJustReleased
local sessionToken = nil

RegisterNUICallback('closeUI', function(data, cb)
    if not display then return cb('ok') end
    display = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('payCart', function(data, cb)
    if not sessionToken then return cb('no_session') end
    if type(data.items) ~= 'table' or #data.items == 0 then return cb('invalid_data') end
    if data.method ~= 'cash' and data.method ~= 'card' then return cb('invalid_method') end
    
    TriggerServerEvent('at_shops:payCart', data, sessionToken)
    cb('ok')
end)

local function SetDisplay(bool)
    if (bool and display) or (not bool and not display) then return end
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "openShop" or "closeShop",
        config = bool and Config or nil
    })
end

CreateThread(function()
    local shops = Config.Shops
    for i = 1, #shops do
        local shop = shops[i]
        local pos = shop.pos
        local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
        SetBlipSprite(blip, shop.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, shop.blip.scale)
        SetBlipColour(blip, shop.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(shop.blip.label)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    local shops = Config.Shops
    local drawDistance = Config.DrawDistance
    local interactionDistance = Config.InteractionDistance
    local marker = Config.Marker
    local wasNearShop = false
    
    while true do
        local interval = 1000
        if not display then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local isNearShop = false
            
            for i = 1, #shops do
                local shop = shops[i]
                local pos = shop.pos
                local distance = #(playerCoords - pos)
                
                if distance < drawDistance then
                    isNearShop = true
                    interval = 0
                    
                    if distance < interactionDistance then
                        nearestShop = shop
                        if not wasNearShop then
                            TriggerServerEvent('at_shops:enterShopZone')
                            wasNearShop = true
                        end
                        
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la supérette")
                        
                        if IsControlJustReleased(0, 38) then
                            SetDisplay(true)
                        end
                    end
                    
                    DrawMarker(marker.type, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, marker.scale.x, marker.scale.y, marker.scale.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 2, marker.rotate)
                end
            end
            
            if not isNearShop and wasNearShop then
                TriggerServerEvent('at_shops:exitShopZone', sessionToken)
                wasNearShop = false
                sessionToken = nil
            end
        end
        Wait(interval)
    end
end)

RegisterNetEvent('at_shops:paymentResponse')
AddEventHandler('at_shops:paymentResponse', function(success, method)
    SendNUIMessage({
        type = success and 'paymentSuccessful' or 'paymentFailed',
        method = method
    })
end)

RegisterNetEvent('at_shops:sessionStarted')
AddEventHandler('at_shops:sessionStarted', function(token)
    sessionToken = token
end) 