local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local netFolder = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")
local RF_ChargeFishingRod = netFolder:WaitForChild("RF/ChargeFishingRod")
local RF_RequestMinigame = netFolder:WaitForChild("RF/RequestFishingMinigameStarted")
local RF_CancelFishingInputs = netFolder:WaitForChild("RF/CancelFishingInputs")
local RE_FishingCompleted = netFolder:WaitForChild("RE/FishingCompleted")
local RE_MinigameChanged = netFolder:WaitForChild("RE/FishingMinigameChanged")
local RE_FishCaught = netFolder:WaitForChild("RE/FishCaught")

function TryRemoteCancel(maxAttempts, retryDelay)
	maxAttempts = maxAttempts or 30      -- berapa kali dicoba
	retryDelay = retryDelay or 0.05      -- jeda antar percobaan

	for attempt = 1, maxAttempts do
		local success, result, result2 = pcall(function()
			return api.Functions.Cancel:InvokeServer()
		end)

		if success then
			if result == true or result2 == true then
				return true, { result, result2 }
			end
		end
		task.wait(retryDelay)
	end
	return false
end

function TryRemoteCharge(maxAttempts, retryDelay)
	maxAttempts = maxAttempts or 30      -- berapa kali dicoba
	retryDelay = retryDelay or 0.05      -- jeda antar percobaan

	for attempt = 1, maxAttempts do
		local success, result = pcall(function()
            local time = workspace:GetServerTimeNow() - 0.35
			return api.Functions.ChargeRod:InvokeServer(nil, nil, nil, time)
		end)

		if success then
			if result then
				return true, { result, result2 }
			end
		end
		task.wait(retryDelay)
	end
	return false
end

function LemparBaitl(callback)
	local cancel, rescancel = TryRemoteCancel(5, 0.02)
	if not cancel then task.wait(0.1) return callback(false) end
	local charger, rescharger = TryRemoteCharge(5, 0.02)
	if not charger then task.wait(0.1) return callback(false) end
	task.spawn(function()
        local CFrame = hrp.CFrame
		local RaycastParams_new = RaycastParams.new()
		RaycastParams_new.IgnoreWater = true
		RaycastParams_new.RespectCanCollide = false
		RaycastParams_new.FilterType = Enum.RaycastFilterType.Exclude
		RaycastParams_new.FilterDescendantsInstances = RaycastUtility:getFilteredTargets(player)
		local workspace_Raycast = workspace:Raycast(CFrame.Position + CFrame.LookVector * (1 * 15 + 10), Vector3.new(0, -80, 0), RaycastParams_new)
		if not workspace_Raycast then
			return callback("Failed rod cast!") 
		end
		if not workspace_Raycast.Instance then
			return callback( "Unable to cast from this far!")
		end
		local EligiblePath = workspace_Raycast.Instance:GetAttribute("EligiblePath")
        if EligiblePath then
			local var59
			local var17 = repl.Data
			if var17 and not var17.Destroyed then
				var59 = var17:Get(EligiblePath)
			end
			if var59 ~= true then
				return callback("You do not have this area unlocked!")
			end
		end

		local send, send1 = api.Functions.StartMini:InvokeServer(unpack({ workspace_Raycast.Position.Y, 1, workspace:GetServerTimeNow() }))
		if callback then
			callback(send1)
		end
	end)
end

local fastReelThread
function fastReeler()
    if _G.FBlatant and not fastReelThread then
		fastReelThread = task.spawn(function()
			while _G.FBlatant do
				LemparBaitl(function(result)
                    if typeof(result) == "table" and result.UUID and result.RandomSeed then
                        local delayReel = tonumber(_G.FishingDelay) + 0.1
                        task.wait(delayReel)
                        api.Events.REFishDone:FireServer()
                    end
                end)
				-- task.wait(0.1)
                local delayBait = tonumber(_G.Reel) + 0.2
				task.wait(delayBait)
			end
			fastReelThread = nil -- cleanup
		end)
	end
end

function Fastest()
    task.spawn(function()
        pcall(function() api.Functions.Cancel:InvokeServer() end)
        local now = workspace:GetServerTimeNow()
        pcall(function() api.Functions.ChargeRod:InvokeServer(now) end)
        pcall(function() api.Functions.StartMini:InvokeServer(-1, 0.999) end)
        task.wait(_G.FishingDelay)
        pcall(function() api.Events.REFishDone:FireServer() end)
    end)
end