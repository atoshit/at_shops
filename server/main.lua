local ESX <const> = exports["es_extended"]:getSharedObject()
local type <const> = type
local activeSessions = {}

local function generateToken()
    return math.random(100000, 999999) .. os.time()
end

local function isValidSession(source, token)
    local session = activeSessions[source]
    return session and session.token == token and session.isNearShop
end

local function cleanupSessions()
    for source, session in pairs(activeSessions) do
        if not GetPlayerPing(source) then
            activeSessions[source] = nil
        end
    end
end

RegisterNetEvent('at_shops:enterShopZone')
AddEventHandler('at_shops:enterShopZone', function()
    local source = source
    if activeSessions[source] then return end
    
    local token = generateToken()
    activeSessions[source] = {
        token = token,
        isNearShop = true,
        lastUpdate = os.time()
    }
    
    TriggerClientEvent('at_shops:sessionStarted', source, token)
end)

RegisterNetEvent('at_shops:exitShopZone')
AddEventHandler('at_shops:exitShopZone', function(token)
    local source = source
    if not isValidSession(source, token) then return end
    activeSessions[source] = nil
end)

local function isValidCart(items)
    if type(items) ~= 'table' then return false end
    local configItems = Config.Items
    
    for i = 1, #items do
        local item = items[i]
        if not (item.id and item.quantity and item.price) then return false end
        if type(item.quantity) ~= 'number' or item.quantity < 1 then return false end
        
        local found = false
        for categoryName, category in pairs(configItems) do
            for j = 1, #category do
                local configItem = category[j]
                if configItem.id == item.id and configItem.price == item.price then
                    found = true
                    break
                end
            end
            if found then break end
        end
        if not found then return false end
    end
    return true
end

RegisterNetEvent('at_shops:payCart')
AddEventHandler('at_shops:payCart', function(data, token)
    local source = source
    
    if not isValidSession(source, token) then
        print(("Tentative d'exploitation détectée pour l'ID: %s"):format(source))
        return
    end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or not isValidCart(data.items) then return end
    
    local total = 0
    local items = data.items
    for i = 1, #items do
        local item = items[i]
        total = total + (item.price * item.quantity)
    end
    
    local canPay = false
    if data.method == 'cash' then
        canPay = xPlayer.getMoney() >= total
        if canPay then xPlayer.removeMoney(total) end
    elseif data.method == 'card' then
        canPay = xPlayer.getAccount('bank').money >= total
        if canPay then xPlayer.removeAccountMoney('bank', total) end
    end
    
    if canPay then
        for i = 1, #items do
            local item = items[i]
            xPlayer.addInventoryItem(item.id, item.quantity)
        end
    end
    
    TriggerClientEvent('at_shops:paymentResponse', source, canPay, data.method)
end)

CreateThread(function()
    while true do
        cleanupSessions()
        Wait(60000)
    end
end)

AddEventHandler('playerDropped', function()
    activeSessions[source] = nil
end) 