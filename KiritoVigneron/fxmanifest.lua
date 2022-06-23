fx_version('cerulean')
games({ 'gta5' })


shared_script{
    'shared/*.lua',
}



client_scripts {
    "src/RMenu.lua",
    "src/LiteMySQL.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    '@es_extended/locale.lua',
    'client/cl_boss.lua',
    'client/cl_Menu6.lua',
    'client/cl_récolter.lua',
    'client/Coffre.lua',
    'client/Vêtements.lua',
    'client/Garage.lua'
}


server_scripts {
    '@es_extended/locale.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/sv_vigneron.lua',

}

dependencies {
    'es_extended'
}

export 'getSharedObject';
server_export 'getSharedObject';
