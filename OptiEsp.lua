-- made by rang#2415
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ownerUserIds = {
    [290931] = true,
    [4072731377] = true,
    [2911976621] = true,
    [129215104] = true
}

local Config = {
    Box = false,
    Names = true,
    NamesOutline = true,
    NamesColor = Color3.fromRGB(255, 255, 255),
    NamesOutlineColor = Color3.fromRGB(0, 0, 0),
    NamesFont = 3,
    NamesSize = 16
}

local roles = {}

local function roleUpdater()
    while true do
        roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
        wait(1)  -- Update every second
    end
end

spawn(roleUpdater)

local function IsAlive(Player)
    for i, v in pairs(roles) do
        if Player.Name == i then
            return not (v.Killed or v.Dead)
        end
    end
    return false
end

local function getRoleColor(player)
    if ownerUserIds[player.UserId] then
        return Color3.fromRGB(128, 0, 128) -- Purple color for specific UserIds
    end

    for i, v in pairs(roles) do
        if v.Role == "Murderer" and i == player.Name then
            return Color3.fromRGB(225, 0, 0) -- Red color
        elseif v.Role == "Sheriff" and i == player.Name then
            return Color3.fromRGB(0, 0, 225) -- Blue color
        elseif v.Role == "Hero" and i == player.Name then
            return Color3.fromRGB(255, 255, 0) -- Yellow color
        end
    end
    return Color3.fromRGB(0, 225, 0) -- Green color for alive players
end

local function CreateEsp(Player)
    local Name = Drawing.new("Text")

    local Updater = game:GetService("RunService").RenderStepped:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.Humanoid.Health > 0 and Player.Character:FindFirstChild("Head") then
            local HeadPos, IsVisible = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.Head.Position + Vector3.new(0, 0.2, 0))
            local scale = 1 / (HeadPos.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 100
            local height = math.floor(60 * scale)

            if Config.Names then
                Name.Visible = IsVisible
                if IsAlive(Player) then
                    Name.Color = getRoleColor(Player)
                else
                    Name.Color = Color3.fromRGB(100, 100, 100) -- Gray color if not alive
                end
                Name.Text = Player.Name .. " " .. math.floor((workspace.CurrentCamera.CFrame.p - Player.Character.HumanoidRootPart.Position).magnitude) .. "m"
                Name.Center = true
                Name.Outline = Config.NamesOutline
                Name.OutlineColor = Config.NamesOutlineColor
                Name.Position = Vector2.new(HeadPos.X, HeadPos.Y - height * 0.5 - 10)
                Name.Font = Config.NamesFont
                Name.Size = Config.NamesSize
            else
                Name.Visible = false
            end
        else
            Name.Visible = false
            if not Player then
                Name:Remove()
                Updater:Disconnect()
            end
        end
    end)
end

for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game:GetService("Players").LocalPlayer then
        CreateEsp(v)
        v.CharacterAdded:Connect(function() CreateEsp(v) end)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    if v ~= game:GetService("Players").LocalPlayer then
        CreateEsp(v)
        v.CharacterAdded:Connect(function() CreateEsp(v) end)
    end
end)

return Config
