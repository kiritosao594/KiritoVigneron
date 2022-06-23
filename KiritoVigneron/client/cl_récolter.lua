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

Citizen.CreateThread(function()
    if Config.Vigneron.blip then
        for _, blip in pairs(Config.Vigneron.BlipJob) do
            local blip = AddBlipForCoord(blip)
            SetBlipSprite(blip, 93)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 27)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Vigneron")
            EndTextCommandSetBlipName(blip)
        end
    end
end)



Citizen.CreateThread(function()
    while true do
        local interval = 1000
        for _, v in pairs(Config.Vigneron.Recolte) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Vigneron.NameOfJob then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(22, v.x, v.y, v.z - 1.0 + 0.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 150, 55555, false, true, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour récolter du raisins", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenRecolte()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function OpenRecolte()
    local recolte = RageUI.CreateMenu(Config.Text.recolte, Config.Text.interact)

    RageUI.Visible(recolte, not RageUI.Visible(recolte))
        while recolte do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(recolte, true, false, true, function()
            
            RageUI.PercentagePanel(Config.Param.load, "Récolte de raisin en cours (~o~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + 0.0020
                else
                    Config.Param.load = 0
                         RequestAnimDict("random@domestic")
        while not HasAnimDictLoaded("random@domestic")do 
           Citizen.Wait(0) 
        end
        Citizen.Wait(100)
        TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low", 2.0, 2.0, -1, 0, 0, false, false, false)
        Citizen.Wait(2000)
        TriggerServerEvent('recolteraisin')
                    TriggerServerEvent('vigneron:recolte')
                end
            end)


        end, function()
        end)
        if not RageUI.Visible(recolte) then
            recolte = RMenu:DeleteType("recolte", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local interval = 1000
        for _, v in pairs(Config.Vigneron.Traitement) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Vigneron.NameOfJob then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(22, v.x, v.y, v.z - 1.0 + 0.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 150, 55555, false, true, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour traiter du raisins", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenTraitement()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function OpenTraitement()
    local traitement = RageUI.CreateMenu(Config.Text.traitement, Config.Text.interact)

    RageUI.Visible(traitement, not RageUI.Visible(traitement))
        while traitement do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(traitement, true, false, true, function()
            
            RageUI.PercentagePanel(Config.Param.load, "Traitement de raisin en cours (~o~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + 0.0020
                else
                    Config.Param.load = 0
        RequestAnimDict("random@domestic")
        while not HasAnimDictLoaded("random@domestic")do 
           Citizen.Wait(0) 
        end
        Citizen.Wait(100)
        TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low", 2.0, 2.0, -1, 0, 0, false, false, false)
        Citizen.Wait(2000)
        TriggerServerEvent('recolteTraitement')
        TriggerServerEvent('vigneron:traitement')
                end
            end)


        end, function()
        end)
        if not RageUI.Visible(traitement) then
            traitement = RMenu:DeleteType("traitement", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local interval = 1000
        for _, v in pairs(Config.Vigneron.Vente) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Vigneron.NameOfJob then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(22, v.x, v.y, v.z - 1.0 + 0.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 150, 55555, false, true, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour vendre du raisins", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenVente()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function OpenVente()
    local vente = RageUI.CreateMenu(Config.Text.vente, Config.Text.interact)

    RageUI.Visible(vente, not RageUI.Visible(vente))
        while vente do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(vente, true, false, true, function()
            
            RageUI.PercentagePanel(Config.Param.load, "Revente de raisin en cours (~o~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + 0.0020
                else
                    Config.Param.load = 0
                         RequestAnimDict("random@domestic")
        while not HasAnimDictLoaded("random@domestic")do 
           Citizen.Wait(0) 
        end
        Citizen.Wait(100)
        TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low", 2.0, 2.0, -1, 0, 0, false, false, false)
        Citizen.Wait(2000)
        TriggerServerEvent('recoltevendre')
                    TriggerServerEvent('vigneron:vente')
                end
            end)


        end, function()
        end)
        if not RageUI.Visible(vente) then
            vente = RMenu:DeleteType("vente", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end