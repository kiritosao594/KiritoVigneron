
local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'vigneron', 'Alerte vigneron', true, true) --- Si vous avez un GCPHONE
TriggerEvent('esx_society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'public'})




ESX.RegisterServerCallback('vigneron:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterNetEvent('vigneron:getStockItem')
AddEventHandler('vigneron:getStockItem', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
        else
            TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
        end
    end)
end)

ESX.RegisterServerCallback('vigneron:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

RegisterNetEvent('vigneron:putStockItems')
AddEventHandler('vigneron:putStockItems', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            xPlayer.showNotification(_U('have_deposited', count, inventoryItem.name))
        else
            TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
        end
    end)
end)

AddEventHandler('playerDropped', function()
    -- Save the source in case we lose it (which happens a lot)
    local _source = source

    -- Did the player ever join?
    if _source ~= nil then
        local xPlayer = ESX.GetPlayerFromId(_source)

        -- Is it worth telling all clients to refresh?
        if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'vigneron' then
            Citizen.Wait(5000)
            TriggerClientEvent('esx_vigneronjob:updateBlip', -1)
        end
    end
end)

RegisterServerEvent('esx_vigneronjob:spawned')
AddEventHandler('esx_vigneronjob:spawned', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'vigneron' then
        Citizen.Wait(5000)
        TriggerClientEvent('esx_vigneronjob:updateBlip', -1)
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.Wait(5000)
        TriggerClientEvent('esx_vigneronjob:updateBlip', -1)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerEvent('esx_phone:removeNumber', 'vigneron')
    end
end)

RegisterServerEvent('esx_vigneronjob:message')
AddEventHandler('esx_vigneronjob:message', function(target, msg)
    TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('AnnonceVigneOuvert')
AddEventHandler('AnnonceVigneOuvert', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers  = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', '~p~Annonce', 'Venez gouter le meilleur vin de la ville!', 'CHAR_PROPERTY_BAR_LES_BIANCO', 8)
    end
end)

RegisterServerEvent('AnnonceVigneFermer')
AddEventHandler('AnnonceVigneFermer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers  = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', '~p~Annonce', 'Le vigneron est désormais fermé à plus tard!', 'CHAR_PROPERTY_BAR_LES_BIANCO', 8)
    end
end)

RegisterServerEvent('vigneron:prendreitems')
AddEventHandler('vigneron:prendreitems', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then

            -- can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
            end
        else
            TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
        end
    end)
end)


RegisterNetEvent('vigneron:stockitem')
AddEventHandler('vigneron:stockitem', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
        else
            TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
        end
    end)
end)


ESX.RegisterServerCallback('vigneron:inventairejoueur', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('vigneron:prendreitem', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
        cb(inventory.items)
    end)
end)

ESX.RegisterServerCallback('vigneron:getArmoryWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_vigneron', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('vigneron:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_vigneron', function(store)
        local weapons = store.get('weapons') or {}
        local foundWeapon = false

        for i=1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name  = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('vigneron:removeArmoryWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_vigneron', function(store)
        local weapons = store.get('weapons') or {}

        local foundWeapon = false

        for i=1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)



RegisterServerEvent('vigneron:recolte')
AddEventHandler('vigneron:recolte', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local item = Config.Vigneron.RecolteItem
    local count = Config.Vigneron.RecolteCount
    local label = Config.Vigneron.RecolteItemLabel
    if xPlayer.canCarryItem(item, count) then
        xPlayer.addInventoryItem(item, count)
        TriggerClientEvent('esx:showNotification', _src, 'Vous avez récolté ' .. count .. ' ' .. label)
    else
        TriggerClientEvent('esx:showNotification', _src, 'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterServerEvent('vigneron:traitement')
AddEventHandler('vigneron:traitement', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local item_give = Config.Vigneron.TraitementItem
    local count_give = Config.Vigneron.TraitementCount
    local item_remove = Config.Vigneron.RecolteItem
    local label_item_remove = Config.Vigneron.RecolteItemLabel
    local count_remove = Config.Vigneron.RecolteRemove
    local label_item_give = Config.Vigneron.TraitementItemLabel
    local countItem = xPlayer.getInventoryItem(item_remove).count

    if xPlayer.canCarryItem(item_give, count_give) then
        if countItem >= count_remove then
            xPlayer.removeInventoryItem(item_remove, count_remove)
            xPlayer.addInventoryItem(item_give, count_give)
            TriggerClientEvent('esx:showNotification', _src, "Vous avez traité " .. count_give .. " " .. label_item_give)
        else
            TriggerClientEvent('esx:showNotification', _src, "Vous n'avez pas assez de " .. label_item_remove .. " pour traiter il en faut "..count_remove)
        end
    else
        TriggerClientEvent('esx:showNotification', _src, "Vous n'avez pas assez de place dans votre inventaire")
    end
end)


RegisterServerEvent('vigneron:vente')
AddEventHandler('vigneron:vente', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    local item_vendue = Config.Vigneron.VenteCount
    local itemRequired = Config.Vigneron.TraitementItem
    local itemRequiredLabel = Config.Vigneron.TraitementItemLabel
    local numberRequired = Config.Vigneron.NumberForSell
    local countItem = xPlayer.getInventoryItem(itemRequired).count
    local itemVendu = Config.Vigneron.VenteCount
    local price = Config.Vigneron.PriceForSell
    local minvente = Config.Vigneron.minvente
    local maxvente = Config.Vigneron.maxvente

    if countItem >= numberRequired then
        local money = math.random(minvente, maxvente)
        xPlayer.removeInventoryItem(itemRequired, itemVendu)
        local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)
                societyAccount = account
            end)
            if societyAccount ~= nil then
        xPlayer.addMoney(price)
        societyAccount.addMoney(money)
        
    else
        TriggerClientEvent('esx:showNotification', _src, "Vous n'avez pas assez de " .. itemRequiredLabel .. " pour vendre")
    end
    end
end)


