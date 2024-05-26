local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "AshbornnHub" .. Fluent.Version,
    SubTitle = "Flee the facility",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Game", Icon = "box" }),
    LPlayer = Window:AddTab({ Title = "Local Player", Icon = "users" }),
    ServerH = Window:AddTab({ Title = "Server", Icon = "server" }), 
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Create a ScreenGui object to hold the button
local gui = Instance.new("ScreenGui")
gui.Name = "AshbornnHubGui"
gui.Parent = game.CoreGui

-- Create the button
local button = Instance.new("TextButton")
button.Name = "ToggleButton"
button.Text = "Open/Close"
button.Size = UDim2.new(0, 70, 0, 30) -- Adjust the size as needed
button.Position = UDim2.new(0, 10, 0, 10) -- Position at top left with 10px offset
button.BackgroundColor3 = Color3.new(0, 0, 0) -- Black background
button.TextColor3 = Color3.new(1, 1, 1) -- White text
button.Parent = gui

-- Functionality for the button
button.MouseButton1Click:Connect(function()
    Window:Minimize()
    
end)

local Options = Fluent.Options

do
    -------FUNCTIONS--------
    -- Constants

local rsrv = game:GetService("RunService")
local heartbeat = rsrv.Heartbeat
local renderstepped = rsrv.RenderStepped

local lp = game.Players.LocalPlayer
local mouse = lp:GetMouse()

local isinvisible = false
local visible_parts = {}
local kdown, loop

local function ghost_parts()
    for _, v in pairs(visible_parts) do
        v.Transparency = isinvisible and 0.5 or 0
    end
end

local function setup_character(character)
    local hum = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")

    visible_parts = {}

    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency == 0 then
            visible_parts[#visible_parts + 1] = v
        end
    end

    if kdown then
        kdown:Disconnect()
    end

    kdown = mouse.KeyDown:Connect(function(key)
        if key == "g" then
            isinvisible = not isinvisible
            ghost_parts()
        end
    end)

    if loop then
        loop:Disconnect()
    end

    loop = heartbeat:Connect(function()
        if isinvisible then
            local oldcf = root.CFrame
            local oldcamoffset = hum.CameraOffset

            local newcf = oldcf * CFrame.new(0, -25, 0)

            hum.CameraOffset = newcf:ToObjectSpace(CFrame.new(oldcf.Position)).Position
            root.CFrame = newcf

            renderstepped:Wait()

            hum.CameraOffset = oldcamoffset
            root.CFrame = oldcf
        end
    end)

    _G.cons = {kdown, loop}
end

lp.CharacterAdded:Connect(function(character)
    setup_character(character)
    if isinvisible then
        ghost_parts()
    end
end)
    -----THINGS---------
    
   
Tabs.Main:AddButton({
    Title = "Update ESP",
    Description = "Click this when a new round starts",
    Callback = function()
        if _G.ExitsESP then
            for _, obj in ipairs(game.Workspace:GetDescendants()) do
                if obj.Name == "ExitDoor" and not obj:FindFirstChild("ExitsHighlight") then
                    local hili = Instance.new("Highlight", obj)
                    hili.Name = "ExitsHighlight"
                    hili.OutlineTransparency = 1
                    hili.FillColor = Color3.fromRGB(255, 255, 0)
                end
            end
        end

        if _G.PCsESP then
            for _, obj in ipairs(game.Workspace:GetDescendants()) do
                if obj.Name == "ComputerTable" and not obj:FindFirstChild("PCHighlight") then
                    local hili = Instance.new("Highlight", obj)
                    hili.Name = "PCHighlight"
                    hili.OutlineTransparency = 1
                    hili.FillColor = obj:FindFirstChild("Screen").Color
                end
            end
        end

        local function getBeast()
            local players = game.Players:GetChildren()
            for _, player in ipairs(players) do
                local character = player.Character
                if character and character:FindFirstChild("BeastPowers") then
                    return player
                end
            end
        end

        if _G.PlayersESP then
            local players = game.Players:GetChildren()
            for _, player in ipairs(players) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local character = player.Character
                    if not character:FindFirstChild("PlayerHighlight") then
                        local a = Instance.new("Highlight", character)
                        a.Name = "PlayerHighlight"
                        a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        task.spawn(function()
                            repeat
                                task.wait(0.1)
                                if player == getBeast() then
                                    a.FillColor = Color3.fromRGB(255, 0, 0)
                                else
                                    a.FillColor = Color3.fromRGB(0, 255, 0)
                                end
                            until character == nil or a == nil
                        end)
                    end
                end
            end
        end

        if _G.PodsESP then
            for _, obj in ipairs(game.Workspace:GetDescendants()) do
                if obj.Name == "FreezePod" and not obj:FindFirstChild("PodsHighlight") then
                    local hili = Instance.new("Highlight", obj)
                    hili.Name = "PodsHighlight"
                    hili.OutlineTransparency = 1
                    hili.FillColor = Color3.fromRGB(0, 200, 255)
                end
            end
        end

        if getgenv().Fullbright then
            local lighting = game:GetService("Lighting")
            lighting.Brightness = 2
            lighting.ClockTime = 14
            lighting.FogEnd = 100000
            lighting.GlobalShadows = false
            lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            lighting.Ambient = Color3.fromRGB(128, 128, 128) -- Set ambient light for fullbright
        end
    end
})

local function updatePodsHighlight(pods)
    local state = pods

    if state then
        _G.PodsESP = true

        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj.Name == "FreezePod" then
                local hili = Instance.new("Highlight", obj)
                hili.Name = "PodsHighlight"
                hili.OutlineTransparency = 1
                hili.FillColor = Color3.fromRGB(0, 200, 255)
            end
        end
    else
        _G.PodsESP = false

        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj.Name == "PodsHighlight" then
                obj:Destroy()
            end
        end
    end
end

local function updateExitsHighlight(exits)
    local state = exits

    if state then
        _G.ExitsESP = true

        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj.Name == "ExitDoor" and not obj:FindFirstChild("ExitsHighlight") then
                local hili = Instance.new("Highlight", obj)
                hili.Name = "ExitsHighlight"
                hili.OutlineTransparency = 1
                hili.FillColor = Color3.fromRGB(255,255,0)
            end
        end
    else
        _G.ExitsESP = false

        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj.Name == "ExitsHighlight" then
                obj:Destroy()
            end
        end
    end
end

local function updatePcESP(pcesp)
    _G.PCsESP = pcesp
end

local function getBeast()
    local players = game.Players:GetChildren()
    for _, player in ipairs(players) do
        local character = player.Character
        if character and character:FindFirstChild("BeastPowers") then
            return player
        end
    end
    return nil
end

local function updatePlayersHighlight(state)
    _G.PlayersESP = state

    if state then
        local players = game.Players:GetChildren()
        for _, player in ipairs(players) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local character = player.Character
                if not character:FindFirstChild("PlayerHighlight") then
                    local highlight = Instance.new("Highlight", character)
                    highlight.Name = "PlayerHighlight"
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    task.spawn(function()
                        while _G.PlayersESP and character and highlight do
                            task.wait(0.1)
                            if player == getBeast() then
                                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            else
                                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                            end
                        end
                        if highlight then
                            highlight:Destroy()
                        end
                    end)
                end
            end
        end
    else
        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj:IsA("Highlight") and obj.Name == "PlayerHighlight" then
                obj:Destroy()
            end
        end
    end
end

local function updatePCHighlight(pcs)
    local state = pcs

    if state then
        _G.PCsESP = true
    
        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj.Name == "ComputerTable" and not obj:FindFirstChild("PCHighlight") then
                local hili = Instance.new("Highlight", obj)
                hili.Name = "PCHighlight"
                hili.OutlineTransparency = 1
                hili.FillColor = obj:FindFirstChild("Screen").Color
            end
        end
    else
        _G.PCsESP = false

        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj.Name == "PCHighlight" then
                obj:Destroy()
            end
        end
    end
end

local TogglePods = Tabs.Main:AddToggle("PodsHighlight", {Title = "Pods ESP", Default = false})

TogglePods:OnChanged(function(pods)
    updatePodsHighlight(pods)
end)

Options.PodsHighlight:SetValue(false)

local ToggleExits = Tabs.Main:AddToggle("ExitsHighlight", {Title = "Exit ESP", Default = false})

ToggleExits:OnChanged(function(exits)
    updateExitsHighlight(exits)
end)

Options.ExitsHighlight:SetValue(false)

local TogglePCESP = Tabs.Main:AddToggle("PcESP", {Title = "ESP Computer", Default = false })

TogglePCESP:OnChanged(function(pcesp)
    updatePcESP(pcesp)
end)

Options.PcESP:SetValue(false)

local TogglePlayers = Tabs.Main:AddToggle("PlayersHighlight", {Title = "Players ESP", Default = false})

TogglePlayers:OnChanged(function(players)
    updatePlayersHighlight(players)
end)

Options.PlayersHighlight:SetValue(false)

local TogglePCs = Tabs.Main:AddToggle("PCHighlight", {Title = "PCs ESP", Default = false})

TogglePCs:OnChanged(function(pcs)
    updatePCHighlight(pcs)
end)

Options.PCHighlight:SetValue(false)

local ToggleAntiFail = Tabs.Main:AddToggle("AntiFail", {Title = "Anti Fail Computer", Default = false})

ToggleAntiFail:OnChanged(function(antiFail)
    local state = antiFail

    if state then
        task.spawn(function() 
            local OldNameCall = nil

            OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
                local Args = {...}
                local NamecallMethod = getnamecallmethod()
                
                if NamecallMethod == "FireServer" and Args[1] == "SetPlayerMinigameResult" then
                    print("Minigame result - Intercepting result to true")
                    Args[2] = true
                end
                
                return OldNameCall(Self, unpack(Args))
            end)
        end)
    else
        -- Disable AntiFail here if needed
        -- Example: Disconnect the hook
    end
end)

Options.AntiFail:SetValue(false)

local ToggleFullbright = Tabs.Main:AddToggle("Fullbright", {Title = "Fullbright", Default = false})

local lighting = game:GetService("Lighting")

-- Store the original lighting settings to revert back to them later
local originalBrightness = lighting.Brightness
local originalClockTime = lighting.ClockTime
local originalFogEnd = lighting.FogEnd
local originalGlobalShadows = lighting.GlobalShadows
local originalOutdoorAmbient = lighting.OutdoorAmbient
local originalAmbient = lighting.Ambient

ToggleFullbright:OnChanged(function(fullbright)
    getgenv().Fullbright = fullbright

    if fullbright then
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.GlobalShadows = false
        lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        lighting.Ambient = Color3.fromRGB(128, 128, 128) -- Set ambient light for fullbright
    else
        -- Revert to the original lighting settings
        lighting.Brightness = originalBrightness
        lighting.ClockTime = originalClockTime
        lighting.FogEnd = originalFogEnd
        lighting.GlobalShadows = originalGlobalShadows
        lighting.OutdoorAmbient = originalOutdoorAmbient
        lighting.Ambient = originalAmbient
    end
end)

-- Initialize the toggle state
ToggleFullbright:SetValue(getgenv().Fullbright)


Tabs.ServerH:AddButton({
        Title = "Rejoin",
        Description = "Rejoining on this current server",
        Callback = function()
            Window:Dialog({
                Title = "Rejoin this server?",
                Content = "Do you want to rejoin this server? ",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
        wait()
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Rejoin cancelled.")
                        end
                    }
                }
            })
        end
    })

Tabs.ServerH:AddButton({
        Title = "Serverhop",
        Description = "Join to another server",
        Callback = function()
            Window:Dialog({
                Title = "Join to another server?",
                Content = "Do you want to join to another server?",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/ServerHop.lua", true))()
        wait()
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Serverhop cancelled.")
                        end
                    }
                }
            })
        end
    })
    
    local Toggle = Tabs.LPlayer:AddToggle("Noclip", {Title = "Noclip", Default = false })

Toggle:OnChanged(function(noclip)
    loopnoclip = noclip
    while loopnoclip do
        local function loopnoclipfix()
            for _, b in pairs(Workspace:GetChildren()) do
                if b.Name == LocalPlayer.Name then
                    for _, v in pairs(Workspace[LocalPlayer.Name]:GetChildren()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
            wait()
        end
        wait()
        pcall(loopnoclipfix)
    end
end)

Options.Noclip:SetValue(false)

local Toggle = Tabs.LPlayer:AddToggle("FEInvisible", {Title = "FE Invisible", Default = false })

Toggle:OnChanged(function(value)
    isinvisible = value
    if lp.Character then
        if not isinvisible then
            -- Restore visibility
            for _, v in pairs(visible_parts) do
                v.Transparency = 0
            end
        else
            ghost_parts()
        end
    end
end)

if lp.Character then
    setup_character(lp.Character)
    if isinvisible then
        ghost_parts()
    end
end

    
-- Store input values in getgenv()
getgenv().walkSpeedValue = 16
getgenv().jumpPowerValue = 50

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")

    -- Set initial values
    humanoid:SetAttribute("WalkSpeed", getgenv().walkSpeedValue)
    humanoid:SetAttribute("JumpPower", getgenv().jumpPowerValue)
    humanoid:SetAttribute("WalkSpeedLock", false) -- Start unlocked
    humanoid:SetAttribute("JumpPowerLock", false) -- Start unlocked

    -- Update humanoid properties
    humanoid.WalkSpeed = humanoid:GetAttribute("WalkSpeed")
    humanoid.JumpPower = humanoid:GetAttribute("JumpPower")

    -- Monitor and enforce locked values
    spawn(function()
        while true do
            wait(0.1) -- Check every 0.1 seconds
            if humanoid:GetAttribute("WalkSpeedLock") and humanoid.WalkSpeed ~= getgenv().walkSpeedValue then
                humanoid.WalkSpeed = getgenv().walkSpeedValue
            end
            if humanoid:GetAttribute("JumpPowerLock") and humanoid.JumpPower ~= getgenv().jumpPowerValue then
                humanoid.JumpPower = getgenv().jumpPowerValue
            end
        end
    end)

    -- Listen for attribute changes
    humanoid:GetAttributeChangedSignal("WalkSpeed"):Connect(function()
        if not humanoid:GetAttribute("WalkSpeedLock") then
            humanoid.WalkSpeed = humanoid:GetAttribute("WalkSpeed")
            print("WalkSpeed updated to:", humanoid.WalkSpeed)
        end
    end)
    humanoid:GetAttributeChangedSignal("JumpPower"):Connect(function()
        if not humanoid:GetAttribute("JumpPowerLock") then
            humanoid.JumpPower = humanoid:GetAttribute("JumpPower")
            print("JumpPower updated to:", humanoid.JumpPower)
        end
    end)
end

-- Listen for CharacterAdded event
player.CharacterAdded:Connect(onCharacterAdded)

-- Trigger onCharacterAdded immediately if character already exists
if player.Character then
    onCharacterAdded(player.Character)
end

Tabs.LPlayer:AddInput("WalkSpeed", {
    Title = "WalkSpeed",
    Default = "16",
    Placeholder = "Enter WalkSpeed",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        getgenv().walkSpeedValue = tonumber(Value) or getgenv().walkSpeedValue -- If input is invalid, keep the previous value
        print("WalkSpeed input changed to:", getgenv().walkSpeedValue)
    end
})

Tabs.LPlayer:AddInput("JumpPower", {
    Title = "JumpPower",
    Default = "50",
    Placeholder = "Enter JumpPower",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        getgenv().jumpPowerValue = tonumber(Value) or getgenv().jumpPowerValue -- If input is invalid, keep the previous value
        print("JumpPower input changed to:", getgenv().jumpPowerValue)
    end
})

Tabs.LPlayer:AddButton({
    Title = "Lock WalkSpeed",
    Description = "So when you crouch it won't reset the speed",
    Callback = function()
        if player.Character then
            player.Character.Humanoid:SetAttribute("WalkSpeed", getgenv().walkSpeedValue)
            player.Character.Humanoid:SetAttribute("WalkSpeedLock", true)
            print("WalkSpeed locked at:", getgenv().walkSpeedValue)
        else
            print("Character not found")
        end
    end
})

Tabs.LPlayer:AddButton({
    Title = "Lock JumpPower",
    Description = "So when you crouch it won't reset your jump power",
    Callback = function()
        if player.Character then
            player.Character.Humanoid:SetAttribute("JumpPower", getgenv().jumpPowerValue)
            player.Character.Humanoid:SetAttribute("JumpPowerLock", true)
            print("JumpPower locked at:", getgenv().jumpPowerValue)
        else
            print("Character not found")
        end
    end
})



Tabs.LPlayer:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
    Tabs.LPlayer:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
Tabs.LPlayer:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
    
    Tabs.Main:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
    Tabs.Main:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
Tabs.Main:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })









end
    -----THINGS---------
   

    

    
    
    -------FUNCTIONS---------


    

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("AshbornnHub")
SaveManager:SetFolder("AshbornnHub/FleeFacility")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "AshbornnHub",
    Content = "Has been loaded.",
    Duration = 4
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
