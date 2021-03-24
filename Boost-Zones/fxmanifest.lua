fx_version 'cerulean'
game 'gta5' 

author 'Boost#4383'
description 'Boost-Zones UI'
version '1.0.0'

ui_page 'html/index.html'

shared_script "config.lua"

client_scripts {
    'client/main.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/listener.js',
    'html/img/*.png',
    'html/img/*.jpg'
}
