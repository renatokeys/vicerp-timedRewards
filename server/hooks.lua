local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")


AddEventHandler('playerSpawned', function() -- user hoin
  local source = source
  local playerId = vRP.getUserId({source})
  vRP.execute("vRP/vicerp_timedReward/update_last_login", {user_id = playerId})
end)


AddEventHandler('playerDropped', function() -- user logoff
  local source = source
  local playerId = vRP.getUserId({source})
  local now = os.time()
  local userData = vRP.query("vRP/vicerp_timedReward/get_user_data",{ user_id = playerId })
  if userData then
    local played_time = userData[1].played_time
    played_time = played_time + ((now - userData[1].last_login) / 60 / 60)
    vRP.execute("vRP/vicerp_timedReward/update_played_time",{ user_id = playerId, played_time = played_time })
    vRP.execute("vRP/vicerp_timedReward/update_last_logoff", { user_id = playerId})
  end
end)
