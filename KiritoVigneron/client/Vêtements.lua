
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

function Vetementsvigneron()
    local Cvigneron = RageUI.CreateMenu("Vêtements", "Vigneron")
        RageUI.Visible(Cvigneron, not RageUI.Visible(Cvigneron))
            while Cvigneron do
            Citizen.Wait(0)
            RageUI.IsVisible(Cvigneron, true, true, true, function()


                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Vigneron",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuevigneron()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil()
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
        for _, v in pairs(Config.Vigneron.vetements) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Vigneron.NameOfJob then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(22, v.x, v.y, v.z - 1.0 + 0.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 150, 55555, false, true, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au vetements", time_display = 1 })
                        if IsControlJustPressed(0, 51) then
                            Vetementsvigneron()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function tenuevigneron()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Tenue.male
        else
            uniformObject = Tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end


function vcivil()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end