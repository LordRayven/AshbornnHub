-- made by rang#2415
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = {
    Box = false,
    BoxOutline = false,
    BoxColor = Color3.fromRGB(255, 255, 255),
    BoxOutlineColor = Color3.fromRGB(0, 0, 0),
    HealthBar = false,
    HealthBarSide = "Left",
    Names = true,
    NamesOutline = true,
    NamesColor = Color3.fromRGB(255, 255, 255),
    NamesOutlineColor = Color3.fromRGB(0, 0, 0),
    NamesFont = 3,  -- Increase font type for better readability
    NamesSize = 16  -- Increase size for better visibility
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
            if not v.Killed and not v.Dead then
                return true
            else
                return false
            end
        end
    end
    return false
end

local function getRoleColor(player)
    if player.UserId == 290931 or player.UserId == 129215104 then
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
    local Box = Drawing.new("Square")
    local BoxOutline = Drawing.new("Square")
    local Name = Drawing.new("Text")
    local HealthBar = Drawing.new("Square")
    local HealthBarOutline = Drawing.new("Square")

    local Updater = game:GetService("RunService").RenderStepped:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.Humanoid.Health > 0 and Player.Character:FindFirstChild("Head") then
            local LocalPlayer = game:GetService("Players").LocalPlayer
            local TargetPos, IsVisible = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.Head.Position)
            local LocalPos = workspace.CurrentCamera:WorldToViewportPoint(LocalPlayer.Character.Head.Position)
            local MidPoint = (TargetPos + LocalPos) / 2

            local scale = 1 / (MidPoint.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 100
            local width, height = math.floor(40 * scale), math.floor(60 * scale)

            if Config.Box then
                Box.Visible = IsVisible
                Box.Color = Config.BoxColor
                Box.Size = Vector2.new(width, height)
                Box.Position = Vector2.new(MidPoint.X - Box.Size.X / 2, MidPoint.Y - Box.Size.Y / 2)
                Box.Thickness = 1
                Box.ZIndex = 69

                if Config.BoxOutline then
                    BoxOutline.Visible = IsVisible
                    BoxOutline.Color = Config.BoxOutlineColor
                    BoxOutline.Size = Box.Size
                    BoxOutline.Position = Box.Position
                    BoxOutline.Thickness = 3
                    BoxOutline.ZIndex = 1
                else
                    BoxOutline.Visible = false
                end
            else
                Box.Visible = false
                BoxOutline.Visible = false
            end

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
                Name.Position = Vector2.new(MidPoint.X, MidPoint.Y - height * 0.5 - 15)
                Name.Font = Config.NamesFont
                Name.Size = Config.NamesSize
            else
                Name.Visible = false
            end

            if Config.HealthBar then
                HealthBarOutline.Visible = IsVisible
                HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
                HealthBarOutline.Filled = true
                HealthBarOutline.ZIndex = 1

                HealthBar.Visible = IsVisible
                HealthBar.Color = Color3.fromRGB(255, 0, 0):lerp(Color3.fromRGB(0, 255, 0), Player.Character.Humanoid.Health / Player.Character.Humanoid.MaxHealth)
                HealthBar.Thickness = 1
                HealthBar.Filled = true
                HealthBar.ZIndex = 69

                local barPos = Vector2.new(MidPoint.X - Box.Size.X / 2, MidPoint.Y - Box.Size.Y / 2)
                if Config.HealthBarSide == "Left" then
                    HealthBarOutline.Size = Vector2.new(2, height)
                    HealthBarOutline.Position = barPos + Vector2.new(-3, 0)
                    HealthBar.Size = Vector2.new(1, - (HealthBarOutline.Size.Y - 2) * (Player.Character.Humanoid.Health / Player.Character.Humanoid.MaxHealth))
                    HealthBar.Position = HealthBarOutline.Position + Vector2.new(1, -1 + HealthBarOutline.Size.Y)
                elseif Config.HealthBarSide == "Bottom" then
                    HealthBarOutline.Size = Vector2.new(width, 3)
                    HealthBarOutline.Position = barPos + Vector2.new(0, height + 2)
                    HealthBar.Size = Vector2.new((HealthBarOutline.Size.X - 2) * (Player.Character.Humanoid.Health / Player.Character.Humanoid.MaxHealth), 1)
                    HealthBar.Position = HealthBarOutline.Position + Vector2.new(1, -1 + HealthBarOutline.Size.Y)
                elseif Config.HealthBarSide == "Right" then
                    HealthBarOutline.Size = Vector2.new(2, height)
                    HealthBarOutline.Position = barPos + Vector2.new(width + 1, 0)
                    HealthBar.Size = Vector2.new(1, - (HealthBarOutline.Size.Y - 2) * (Player.Character.Humanoid.Health / Player.Character.Humanoid.MaxHealth))
                    HealthBar.Position = HealthBarOutline.Position + Vector2.new(1, -1 + HealthBarOutline.Size.Y)
                end
            else
                HealthBar.Visible = false
                HealthBarOutline.Visible = false
            end
        else
            Box.Visible = false
            BoxOutline.Visible = false
            Name.Visible = false
            HealthBar.Visible = false
            HealthBarOutline.Visible = false
            if not Player then
                Box:Remove()
                BoxOutline:Remove()
                Name:Remove()
                HealthBar:Remove()
                HealthBarOutline:Remove()
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
