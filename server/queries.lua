local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    vRP._prepare("vRP/vicerp_timedReward/createDB", [[
      CREATE TABLE IF NOT EXISTS vicerp_timedReward (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        last_login BIGINT(20) NOT NULL DEFAULT 0,
        last_logoff BIGINT(20) NOT NULL DEFAULT 0,
        played_time INT NOT NULL DEFAULT 0,
        reward_state INT NOT NULL DEFAULT 0,
      )
      ]])  
      vRP.execute("vRP/vicerp_timedReward/createDB")
end)




vRP.prepare("vRP/vicerp_timedReward/get_user_coins", "SELECT coins FROM vrp_users WHERE user_id=@id")

vRP.prepare('vRP/vicerp_timedReward/insert_user', "INSERT INTO vicerp_timedReward (user_id, last_login, last_logoff, played_time, reward_state) VALUES (@id, 0, 0, 0, 0)")
vRP.prepare("vRP/vicerp_timedReward/reset","UPDATE vicerp_timedReward SET last_login = now(), played_time = 0")
vRP.prepare("vRP/vicerp_timedReward/get_user_data","SELECT * FROM vicerp_timedReward WHERE user_id = @id")
vRP.prepare("vRP/vicerp_timedReward/update_user_last_login", "INSERT INTO vicerp_timedReward (user_id, last_login) VALUES (@id, @last_login) ON DUPLICATE KEY UPDATE last_login = @last_login")
vRP.prepare("vRP/vicerp_timedReward/update_user_last_logoff", "UPDATE vicerp_timedReward SET last_logoff = @last_logoff WHERE user_id = @id")
vRP.prepare("vRP/vicerp_timedReward/update_played_time", "UPDATE vicerp_timedReward SET played_time = @played_time WHERE user_id = @id")







