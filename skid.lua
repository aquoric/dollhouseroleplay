
local settings = {
  ["message"] = "ping"
}

local queueTp = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end


repeat wait() until game:IsLoaded()

spawn(function()
    while wait(1) do
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(settings.message ,"all")
    end
end)

-- skid ahh 
local togo = false
for i, v in pairs(game.Players:GetPlayers()) do
    --Skidded from Infinite Yield
    pcall(
        function()
            if game.Players.LocalPlayer.Character.Humanoid.Sit then
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
            local tofling = v
            local rootpart = game.Players.LocalPlayer.Character.HumanoidRootPart
            if not rootpart then
                return
            end
            OldVelocity = rootpart.Velocity
            local bv = Instance.new("BodyAngularVelocity")
            bv.MaxTorque = Vector3.new(1, 1, 1) * math.huge
            bv.P = math.huge
            bv.AngularVelocity = Vector3.new(0, 9e5, 0)
            bv.Parent = rootpart
            local Char = game.Players.LocalPlayer.Character:GetChildren()
            for i, v in next, Char do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                    v.Massless = true
                    v.Velocity = Vector3.new(0, 0, 0)
                end
            end
            game:GetService("RunService").Stepped:Connect(
                function()
                    for i, v in next, Char do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            )

            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tofling.Character.HumanoidRootPart.CFrame
            wait(0.5)
        end
    )
end



wait(10)

-- join new game

queueTp("loadstring(game:HttpGet('https://raw.githubusercontent.com/aquoric/dollhouseroleplay/main/skid.lua'))()")

while wait() do
   local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	end
	
	wait(0.5)
end
