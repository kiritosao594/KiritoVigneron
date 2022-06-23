function Menuf6Vigneron()
    local Vigneronf6 = RageUI.CreateMenu("Vigneron", "Interactions")
    local Vigneronf6sub = RageUI.CreateSubMenu(Vigneronf6, "Vigneron", "Interactions")
    RageUI.Visible(Vigneronf6, not RageUI.Visible(Vigneronf6))
    while Vigneronf6 do
        Citizen.Wait(0)
            RageUI.IsVisible(Vigneronf6, true, true, true, function()

                

                RageUI.Separator("↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_vigneron', ('Vigneron'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)


                RageUI.Separator("↓ Annonce ↓")



                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('AnnonceVigneOuvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('AnnonceVigneFermer')
                    end
                end)

                RageUI.Separator("travail")

                RageUI.ButtonWithStyle("Menu travail", nil,  {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                end, Vigneronf6sub)


                end, function() 
                end)
    
                RageUI.IsVisible(Vigneronf6sub, true, true, true, function()

                RageUI.ButtonWithStyle("Récolte raisin",nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(-1907.01, 1960.225, 150.53)
                    end
                end)

                RageUI.ButtonWithStyle("Traitement raisin",nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(-1931.84, 2052.511, 140.81)
                    end
                end)

                RageUI.ButtonWithStyle("Vente vin",nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(-440.529, -2796.50, 7.2959)
                    end
                end)
            end, function() 
            end)

                if not RageUI.Visible(Vigneronf6) and not RageUI.Visible(Vigneronf6sub) then
                    Vigneronf6 = RMenu:DeleteType("Vigneronf6", true)
        end
    end
end


Keys.Register('F6', 'Vigneron', 'Ouvrir le menu Vigneron', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    	Menuf6Vigneron()
	end
end)