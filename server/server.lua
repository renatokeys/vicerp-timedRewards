local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local cfg = module("vrp","cfg/groups")

vRP = Proxy.getInterface("vRP")
API = {}
Tunnel.bindInterface("vicerp_timedReward", API)




function API.getData()
  local source = source
  local user_id = vRP.getUserId(source)
  local rewardStatus, prize = helper.getPlayedTime(user_id)
  print(user_id, prize, rewardStatus)
  return rewardStatus, prize
end



function API.getCoins()
  local source = source
  local user_id = vRP.getUserId(source)
  local data = vRP.query("vRP/vicerp_timedReward/get_user_coins", {user_id = user_id})
  
  if data then
    return data[1].moedas
  end
  return 0
end