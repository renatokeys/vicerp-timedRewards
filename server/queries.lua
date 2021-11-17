local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------

vRP.prepare("vRP/vicerp_timedReward/reset","UPDATE vicerp_timedReward SET last_login = now(), played_time = 0")
vRP.prepare("vRP/vicerp_timedReward/get_user_data","SELECT * FROM vicerp_timedReward WHERE id = @id")
vRP.prepare("vRP/vicerp_timedReward/update_user_last_login", "UPDATE vicerp_timedReward SET last_login = now() WHERE id = @id")
vRP.prepare("vRP/vicerp_timedReward/update_user_last_logoff", "UPDATE vicerp_timedReward SET last_logoff = now() WHERE id = @id")
vRP.prepare("vRP/vicerp_timedReward/update_played_time", "UPDATE vicerp_timedReward SET played_time = @played_time WHERE id = @id")







