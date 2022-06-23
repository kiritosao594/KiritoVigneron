
Config = {}


--garage = true --- true = Oui | false = Non

Config.Vigneron = {
    blip = true,
    NameOfJob = "vigneron",
    BlipJob = {
        vector3(-1888.1695556641, 2050.4248046875, 140.9841003418)
    },
    Recolte = {
        vector3(-1907.01, 1960.225, 150.53)
    },
    Traitement = {
        vector3(-1931.84, 2052.511, 140.81)
    },
    Vente = {
       vector3(-440.529, -2796.50, 7.2959)

    },
    coffre = {
        vector3(-1880.01, 2069.768, 141.00)
    },
     vetements = {
        vector3(-1874.25, 2054.055, 141.06)
    },
       patron = {
        vector3(-1898.00, 2067.390, 141.02)
    },
    SortieVehicule = vector3(-1900.68, 2033.358, 140.74),

    RecolteItem = "raisin", -- Item à récolter
    RecolteItemLabel = "Raisin", -- Label de l'item récolté
    RecolteCount = 1, --- Nombre d'item give lors de la récolte
    TraitementItem = "grand_cru", --- nom de l'item a give lors de la récolte
    TraitementItemLabel = "Grand cru", --- Label de l'item give lors de la récolte
    TraitementCount = 1, --- Nombre d'item give lors du traitement
    RecolteRemove = 1, --- Nombre d'item remove lors du traitement / nombre d'item qu'il faut pour traiter
    NumberForSell = 1, --- Nombre d'item qu'il faut pour vendre
    VenteCount = 1, --- Nombre d'item vendue lors de la vente
    PriceForSell = 5, --- Prix de vente
    minvente = 100, --- Prix de vente entreprise
    maxvente = 200, --- Prix de vente entreprise


}


voiture = {
        garage = {
        position = {x = -1925.82, y = 2058.93, z = 140.83}
    },
        spawnvoiture = {
        position = {x = -1919.76, y = 2057.13, z = 140.73, h = 253.62}
    },

}


Gvigneronvoiture = {
    {nom = "Burrito", modele = "burrito"},
}

Config.Text = {
    ["recolte"] = "Récolter",
    ["interact"] = "Interaction",
    ["traitement"] = "Traitement",
    ["vente"] = "Vendre"
}

Config.Param = {
    load = 0.0,
}


Tenue  = {
    male = {
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['tshirt_1'] = 0, ['tshirt_2'] = 0,
        ['torso_1'] = 24, ['torso_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 48, ['pants_2'] = 0,
        ['shoes_1'] = 36, ['shoes_2'] = 0,
},

    female = {
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['tshirt_1'] = 23,['tshirt_2'] = 4,
        ['torso_1'] = 52, ['torso_2'] = 0,
        ['arms'] = 5, ['arms_2'] = 0,
        ['pants_1'] = 36, ['pants_2'] = 0,
        ['shoes_1'] = 42, ['shoes_2'] = 1,
    }
}