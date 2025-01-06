local display = false
local isAnimating = false

RegisterNUICallback('closeUI', function(data, cb)
    if not display then return end
    display = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('selectCategory', function(data, cb)
    print('Catégorie sélectionnée : ' .. data.category)
    cb('ok')
end)

function SetDisplay(bool)
    if bool and display then return end 
    if not bool and not display then return end 
    
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "openShop" or "closeShop",
        config = bool and Config or nil
    })
end

RegisterCommand('shop', function()
    SetDisplay(not display)
end) 