-- at_shops made by @atoshi
-- date: 06/01/2025 00:53

-- Resource manifest version
fx_version 'cerulean'
game 'gta5'

-- Lua 5.4 version
lua54 'yes'

-- Experimental FXV2 OAL
use_experimental_fxv2_oal 'yes'

-- Resource data
author 'atoshi'
version '1.0.0'
description 'at_shops'

-- Shared scripts
shared_scripts {
    'shared/*.lua'
}

-- Client scripts
client_scripts {
    'client/*.lua'
}

-- Server scripts
server_scripts {
    'server/*.lua'
}

-- Dependencies
dependencies {
    'es_extended'
}