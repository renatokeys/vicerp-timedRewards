-- Import all vrp modules

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

-- Get interfaces

vRP = Proxy.getInterface("vRP")
API = Tunnel.getInterface("vicerp_timedReward")


local function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end

RegisterCommand('tempo', function()
  toggleNuiFrame(true)
  --debugPrint('Show NUI frame')
end)

RegisterNUICallback('hideFrame', function(_, cb)
  toggleNuiFrame(false)
  --debugPrint('Hide NUI frame')
  cb({})
end)


RegisterNUICallback('getData', function(_, cb)
  local rewardStatus, prize = API.getData()
  cb({rewardStatus, prize})
end)

RegisterNUICallback('getRewards', function(_, cb)
  local rewards = API.getRewards()
  cb({rewards})
end)
-- cron reset table everydat at 6 am

RegisterNUICallback('getCoins', function(_, cb)
  local coins = API.getCoins()
  cb({coins})
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if GetClockHours() == 6 then
      vRP.execute("vRP/vicerp_timedReward/reset")
    end
  end
end)
