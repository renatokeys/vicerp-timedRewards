local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local cfg = module("vrp","cfg/groups")
vRP = Proxy.getInterface("vRP")


helper = {}
Tunnel.bindInterface("vicerp_timedReward_helpers", helper)

function helper.getPlayedTime(user_id)
  local userData = vRP.query("vRP/vicerp_timedReward/get_user_data",{ user_id = user_id })
  print('dados')
  print(userData[1])
  
  if userData then
    local totalPlayedTime = userData[1].played_time
    local last_login = userData[1].last_login
    local last_logoff = userData[1].last_logoff
    -- if last_login < last_logoff, increment totalPlayedTime by difference between last_logoff and last_login
    if last_login > last_logoff then
      local now = os.time()
      local diff = now - last_login
      totalPlayedTime = totalPlayedTime + (diff / 60 / 60)
      vRP.execute("vRP/vicerp_timedReward/update_user_last_login",{ user_id = user_id, last_login = now })
      vRP.execute("vRP/vicerp_timedReward/update_user_last_logoff",{ user_id = user_id, last_logoff = (now-1) })
      vRP.execute("vRP/vicerp_timedReward/update_played_time",{ user_id = user_id, played_time = totalPlayedTime })
      local rewardStatus = userData[1].reward_state
      local prize = 0
      -- loop config.rewards and check if config.rewards[i][1] <= totalPlayedTime and config.rewards[i][2] > totalPlayedTime
      for i=1,#cfg.rewards do
        if cfg.rewards[i][1] <= totalPlayedTime and cfg.rewards[i][2] > totalPlayedTime then
          if rewardStatus < i then
            prize = cfg.rewards[i][2]
            rewardStatus = i
          end
          break
        end
      end
      if prize > 0 then
        vRP.execute("vRP/vicerp_timedReward/update_reward_state",{ user_id = user_id, reward_state = rewardStatus })
      end
    end
    return rewardStatus, prize
  end
end