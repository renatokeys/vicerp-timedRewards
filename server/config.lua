local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

config = {}
Tunnel.bindInterface("vicerp_timedReward_config", config)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BASIC CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------

config.rewards = {
    [1] = { 4 , 1000},
    [2] = { 8 , 2000},
    [3] = { 12 , 3000},
    [4] = { 16 , 4000},
    [5] = { 20 , 5000}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------

config.discordLog = false -- true/false
config.discordHookUrl = "https://discordapp.com/api/webhooks/"

