ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyvigneronmoney = nil

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

function Garagevigneron()
    local Gvigneron = RageUI.CreateMenu("Garage", "Vigneron")
      RageUI.Visible(Gvigneron, not RageUI.Visible(Gvigneron))
          while Gvigneron do
              Citizen.Wait(0)
                  RageUI.IsVisible(Gvigneron, true, true, true, function()
                      for k,v in pairs(Gvigneronvoiture) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Citizen.Wait(1)  
                              spawnuniCarvigneron(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Gvigneron) then
              Gvigneron = RMenu:DeleteType("Garage", true)
          end
      end
  end


  Citizen.CreateThread(function()
          while true do
              local Timer = 500
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
              local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
              local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, voiture.garage.position.x, voiture.garage.position.y, voiture.garage.position.z)
              if dist3 <= 10.0 and garage then
                  Timer = 0
                 -- DrawMarker(20, voiture.garage.position.x, voiture.garage.position.y, voiture.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
                  end
                  if dist3 <= 3.0 then
                  Timer = 0   
                      RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                      if IsControlJustPressed(1,51) then           
                          Garagevigneron()
                      end   
                  end
              end 
          Citizen.Wait(Timer)
       end
  end)
  
  function spawnuniCarvigneron(car)
      local car = GetHashKey(car)
  
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Citizen.Wait(0)
      end
  
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
      local vehicle = CreateVehicle(car, voiture.spawnvoiture.position.x, voiture.spawnvoiture.position.y, voiture.spawnvoiture.position.z, voiture.spawnvoiture.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "vigneron"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
  end


-- Ranger 
local range = { 
    {x = -1899.68, y = 2036.208, z = 140.56}
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
        for k in pairs(range) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, range[k].x, range[k].y, range[k].z)
            if dist <= 1.5  then
                DrawMarker(2, -1899.68, 2036.208, 140.56, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                 RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au Ranger", time_display = 1 })
                if IsControlJustPressed(1,38) then
                    TriggerEvent('esx:deleteVehicle')
         end end end end end end)


Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_waremech_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_waremech_01", -1927.51, 2059.323, 139.81, 343.96, false, true) --Emplacement du PEDS
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)
