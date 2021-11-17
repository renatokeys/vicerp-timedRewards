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
  return rewardStatus, prize
end

