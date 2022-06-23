ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
    PlayerData.job = job  
    Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

        ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

function Coffrevigneron()
    local Cvigneron = RageUI.CreateMenu("Coffre", "Vigneron")
        RageUI.Visible(Cvigneron, not RageUI.Visible(Cvigneron))
            while Cvigneron do
            Citizen.Wait(0)
            RageUI.IsVisible(Cvigneron, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                end, function()
                end)
            if not RageUI.Visible(Cvigneron) then
            Cvigneron = RMenu:DeleteType("Cvigneron", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local interval = 1000
        for _, v in pairs(Config.Vigneron.coffre) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Vigneron.NameOfJob then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(22, v.x, v.y, v.z - 1.0 + 0.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 150, 55555, false, true, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour récolter du raisins", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            Coffrevigneron()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)


itemstock = {}
function VRetirerobjet()
    local StockVigneron = RageUI.CreateMenu("Coffre", "Vigneron")
    ESX.TriggerServerCallback('vigneron:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockVigneron, not RageUI.Visible(StockVigneron))
        while StockVigneron do
            Citizen.Wait(0)
                RageUI.IsVisible(StockVigneron, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('vigneron:getStockItem', v.name, tonumber(count))
                                    VRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockVigneron) then
            StockVigneron = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function VDeposerobjet()
    local DepositVigneron = RageUI.CreateMenu("Coffre", "Vigneron")
    ESX.TriggerServerCallback('vigneron:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositVigneron, not RageUI.Visible(DepositVigneron))
    while DepositVigneron do
        Citizen.Wait(0)
            RageUI.IsVisible(DepositVigneron, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('vigneron:putStockItems', item.name, tonumber(count))
                                            VDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositVigneron) then
                DepositVigneron = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end