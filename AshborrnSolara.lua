repeat wait() until game:IsLoaded()

print("[ AshbornnHub ]: Murder Mystery 2 loading...")

local TimeStart = tick()
-- Place this LocalScript in StarterPlayerScripts
    
    
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    -------------------FUNCTION-----------------------
    applyesptrans = 0.5
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local StarterGui = game:GetService("StarterGui")
    local LocalPlayer = Players.LocalPlayer
    local HttpService = game:GetService("HttpService")
    local players = game:GetService("Players")
    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local N = game:GetService("VirtualInputManager")

    local DefaultChatSystemChatEvents = ReplicatedStorage.DefaultChatSystemChatEvents
    local SayMessageRequest = DefaultChatSystemChatEvents.SayMessageRequest

    local defualtwalkspeed = 16
    local defualtjumppower = 50
    local defualtgravity = 196.1999969482422
    newwalkspeed = defualtwalkspeed
    newjumppower = defualtjumppower
    antiafk = true


    local newflyspeed = 50
    local c
    local h
    local bv
    local bav
    local cam
    local flying
    local p = game.Players.LocalPlayer
    local buttons = {W = false, S = false, A = false, D = false, Moving = false}
    
    
    
    


    local AntiFlingEnabled = false
    local playerAddedConnection = nil
    local localHeartbeatConnection = nil
    
    local ownerUserIds = {
    [290931] = true,
    [4072731377] = true,
    [2911976621] = true,
    [129215104] = true
}








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

            local newcf = oldcf * CFrame.new(-1500, -5000, -1500)

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

function EquipTool()
    for _,obj in next, game.Players.LocalPlayer.Backpack:GetChildren() do
        if obj.Name == "Knife" then
            local equip = game.Players.LocalPlayer.Backpack.Knife
            equip.Parent = game.Players.LocalPlayer.Character
        end
    end
end

function Stab()
    game:GetService("Players").LocalPlayer.Character.Knife.Stab:FireServer("Down")
end

local function TeleportToPlayer(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
    end
end

local function roleupdaterfix()
    while true do
       roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
        for i, v in pairs(roles) do
            if v.Role == "Murderer" then
                Murder = i
            elseif v.Role == "Sheriff" then
                Sheriff = i
            elseif v.Role == "Hero" then
                Hero = i
            end
        end
        wait(1)  -- Update every second
    end
end

-- Start the role updater in a separate coroutine
spawn(function()
    pcall(roleupdaterfix)
end)


function loadesp()
    if loadespenabled ~= true then
        loadespenabled = true
        AshESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/OptiEsp.lua"))()
        AshESP.Names = false
        AshESP.NamesOutline = false
    end
end


function CreateHighlight()
	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and not v.Character:FindFirstChild("ESP_Highlight") then
			local esphigh = Instance.new("Highlight", v.Character)
            esphigh.Name = "ESP_Highlight"
            esphigh.FillColor = Color3.fromRGB(160, 160, 160)
            esphigh.OutlineTransparency = 0.5
            esphigh.FillTransparency = applyesptrans   
        end
	end
end
 
function UpdateHighlights()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("ESP_Highlight") then
            local Highlight = v.Character:FindFirstChild("ESP_Highlight")
            if v.UserId == 290931 or v.UserId == 129215104 then
                Highlight.FillColor = Color3.fromRGB(128, 0, 128) -- Purple color
                Highlight.FillTransparency = applyesptrans
            elseif v.Name == Sheriff and IsAlive(v) then
                Highlight.FillColor = Color3.fromRGB(0, 0, 225) -- Blue color
                Highlight.FillTransparency = applyesptrans
            elseif v.Name == Murder and IsAlive(v) then
                Highlight.FillColor = Color3.fromRGB(225, 0, 0) -- Red color
                Highlight.FillTransparency = applyesptrans
            elseif v.Name == Hero and IsAlive(v) and v.Backpack:FindFirstChild("Gun") then
                Highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Yellow color
                Highlight.FillTransparency = applyesptrans
            elseif v.Name == Hero and IsAlive(v) and v.Character:FindFirstChild("Gun") then
                Highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Yellow color
                Highlight.FillTransparency = applyesptrans
            elseif not IsAlive(v) then
                Highlight.FillColor = Color3.fromRGB(100, 100, 100) -- Gray color
                Highlight.FillTransparency = applyesptrans
            else
                Highlight.FillColor = Color3.fromRGB(0, 225, 0) -- Green color
                Highlight.FillTransparency = applyesptrans
            end
        end
    end
end

 
function IsAlive(Player)
	for i, v in pairs(roles) do
		if Player.Name == i then
			if not v.Killed and not v.Dead then
				return true
			else
				return false
			end
		end
	end
end
 
function HideHighlights()
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("ESP_Highlight") then
			v.Character:FindFirstChild("ESP_Highlight"):Destroy()
		end
	end
end

function PlayZen()
    game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("zen")
end

function PlayHeadless()
    game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("headless")
end

function PlayDab()
    game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("dab")
end

function PlayFloss()
    game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("floss")
end

function PlayZombie()
    game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("zombie")
end

function PlayNinja()
    game.ReplicatedStorage.Remotes.PlayEmote:Fire("ninja")
end


-------------------------END FUNCTIONS---------------------------------

local Window = Fluent:CreateWindow({
    Title = "Ashbornn Hub " .. Fluent.Version,
    SubTitle = "by Ashbornn",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when there's no MinimizeKeybind
})

-- Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "box" }),
        Visual = Window:AddTab({ Title = "Visual", Icon = "eye" }),
        Combat = Window:AddTab({ Title = "Combat", Icon = "swords" }),
        LPlayer = Window:AddTab({ Title = "Player", Icon = "user" }),
        LEmotes = Window:AddTab({ Title = "Emotes", Icon = "laugh" }),
        Misc = Window:AddTab({ Title = "Misc", Icon = "aperture" }),
        Troll = Window:AddTab({ Title = "Trolling", Icon = "user-x" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "wand" }),
        Server = Window:AddTab({ Title = "Server", Icon = "server" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}



-------------------------EXTRAS---------------------------

--------------------------EXTRAS--------------------------


local Options = Fluent.Options

do


    --------------------------------------------------------------------------------MAIN------------------------------------------------------------------------------------------

        
local discord = "https://discord.com/invite/nzXkxej9wa"


Tabs.Main:AddButton({
        Title = "Infinite Yield",
        Description = "Best script for all games",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })
    
    
Tabs.Main:AddButton({
    Title = "Copy Discord Invite (for updates)",
    Callback = function()
        setclipboard(discord)
    end
})
    
Tabs.Main:AddButton({
    Title = "Respawn",
    Callback = function()
        LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
        wait()
    end
})

Tabs.Main:AddButton({
    Title = "Open Console",
    Callback = function()
        game.StarterGui:SetCore("DevConsoleVisible", true)
        wait()
    end
})

Tabs.Main:AddButton({
    Title = "Anti-Lag (Smooth parts)",
    Callback = function()
        local ToDisable = {
    Textures = true,
    VisualEffects = true,
    Parts = true,
    Particles = true,
    Sky = true
}


local ToEnable = {
    FullBright = false
}

local Stuff = {}

for _, v in next, game:GetDescendants() do
    if ToDisable.Parts then
        if v:IsA("Part") or v:IsA("Union") or v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            table.insert(Stuff, 1, v)
        end
    end
    
    if ToDisable.Particles then
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Explosion") or v:IsA("Sparkles") or v:IsA("Fire") then
            v.Enabled = false
            table.insert(Stuff, 1, v)
        end
    end
    
    if ToDisable.VisualEffects then
        if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
            v.Enabled = false
            table.insert(Stuff, 1, v)
        end
    end
    
    if ToDisable.Textures then
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Texture = ""
            table.insert(Stuff, 1, v)
        end
    end
    
    if ToDisable.Sky then
        if v:IsA("Sky") then
            v.Parent = nil
            table.insert(Stuff, 1, v)
        end
    end
end

game:GetService("TestService"):Message("Effects Disabler Script : Successfully disabled "..#Stuff.." assets / effects. Settings :")

for i, v in next, ToDisable do
    print(tostring(i)..": "..tostring(v))
end

if ToEnable.FullBright then
    local Lighting = game:GetService("Lighting")
    
    Lighting.FogColor = Color3.fromRGB(255, 255, 255)
    Lighting.FogEnd = math.huge
    Lighting.FogStart = math.huge
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = 5
    Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
    Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.Outlines = true
end
    end
})
    
--------------------------------------------------------------------------------MAIN------------------------------------------------------------------------------------------


    -------------------------------------------COMBAT---------------------------------------

    local SheriffHacks = Tabs.Combat:AddSection("Sheriff Hacks")

    Tabs.Combat:AddButton({
    Title = "Grab Gun v2",
    Description = "Teleport to and grab the gun if available",
    Callback = function()
        local player = game.Players.LocalPlayer

        if not IsAlive(player) then
            Fluent:Notify({
                Title = "You're not alive",
                Content = "Please wait for the new round to grab the gun.",
                Duration = 3
            })
            return
        end

        if player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
            Fluent:Notify({
                Title = "You already have a gun",
                Content = "Lollll.",
                Duration = 3
            })
            return
        end

        if player.Character then
            local gundr = workspace:FindFirstChild("GunDrop")
            if gundr then
                local oldpos = player.Character.HumanoidRootPart.CFrame
                repeat
                    player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
                    task.wait()
                    player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
                    task.wait()
                until not gundr:IsDescendantOf(workspace)
                player.Character.HumanoidRootPart.CFrame = oldpos
                oldpos = false
                player.Character.Humanoid:ChangeState(1)
                button.Text = "Grab Gun (Gotcha)"
            else
                Fluent:Notify({
                    Title = "Gun not Found",
                    Content = "Wait for the Sheriff's death to grab the gun.",
                    Duration = 3
                })
            end
        end
    end
})
        
Tabs.Combat:AddButton({
    Title = "Grab gun",
    Description = "Tp to Gun",
    Callback = function()
        local player = game.Players.LocalPlayer
        
        -- Check if the player is alive
        if not IsAlive(player) then
            Fluent:Notify({
                Title = "You're not alive",
                Content = "Please wait for the new round to grab the gun.",
                Duration = 3
            })
            return
        end

        local currentX = player.Character.HumanoidRootPart.CFrame.X
        local currentY = player.Character.HumanoidRootPart.CFrame.Y
        local currentZ = player.Character.HumanoidRootPart.CFrame.Z
        
        if workspace:FindFirstChild("GunDrop") then
            player.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame
            wait(0.30)
            player.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
        else
            Fluent:Notify({
                Title = "Gun not Found",
                Content = "Wait for the Sheriff's death to grab the gun.",
                Duration = 3
            })
        end
    end
})


local player = game.Players.LocalPlayer
local shootKey = Enum.KeyCode.E  -- Default shoot key

-- Function to shoot at the murderer's position
local function shootAtMurderer()
    local murderer = game.Players[Murder]
    local murdererCharacter = murderer and murderer.Character
    local playerCharacter = player.Character

    if murdererCharacter and murdererCharacter:FindFirstChild("HumanoidRootPart") then
        if playerCharacter:FindFirstChild("Gun") then
            playerCharacter.Gun.KnifeServer.ShootGun:InvokeServer(1, murdererCharacter.HumanoidRootPart.Position, "AH")
        else
            -- Player doesn't have a gun, show notification
            Fluent:Notify({
                Title = "You don't have a gun",
                Content = "Wait for the sheriff death or grab the gun",
                Duration = 3
            })
        end
    else
        -- Notify if the murderer or its root part isn't found
        Fluent:Notify({
            Title = "Murderer or HumanoidRootPart not found",
            Content = "Character or root part missing.",
            Duration = 3
        })
    end
end

-- Function to update shoot key based on keybind change
local function updateShootKey(newKey)
    shootKey = newKey
    print("Shoot key updated to:", shootKey.Name)  -- Use .Name to get the string representation of the key
end

-- Listen for the shoot key press
game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == shootKey then
        print(shootKey.Name.." key pressed")  -- Use .Name to get the string representation of the key
        
        -- Check if the player has a gun
        local playerCharacter = player.Character
        if playerCharacter then
            local gun = playerCharacter:FindFirstChild("Gun")
            if gun then
                shootAtMurderer()
            else
                Fluent:Notify({
                    Title = "You don't have a Gun",
                    Content = "Grab the gun or wait for Sheriff Death.",
                    Duration = 3
                })
            end
        end
    end
end)

-- Adding the Keybind to change shoot key
local Keybind = Tabs.Combat:AddKeybind("Keybind", {
    Title = "Change Shoot Keybind",
    Mode = "Always", -- Allow the keybind to always be active
    Default = shootKey.Name, -- Default to current shoot key
    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        local newKey = Enum.KeyCode[Value]
        if newKey then
            updateShootKey(newKey)
            Fluent:Notify({
                Title = "Shoot Keybind Changed",
                Content = "New keybind set to "..newKey.Name,  -- Use .Name to get the string representation of the key
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "Invalid Keybind",
                Content = "Please choose a valid keybind.",
                Duration = 3
            })
        end
    end,
    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        local newKey = New
        updateShootKey(newKey)
        Fluent:Notify({
            Title = "Shoot Keybind Changed",
            Content = "New keybind set to "..newKey.Name,  -- Use .Name to get the string representation of the key
            Duration = 3
        })
    end
})

    

Tabs.Combat:AddButton({
    Title = "Shoot Murderer",
    Description = "Tp to Murderer and Shoot",
    Callback = function()
        local player = game.Players.LocalPlayer
        local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end

        local currentX = humanoidRootPart.CFrame.X
        local currentY = humanoidRootPart.CFrame.Y
        local currentZ = humanoidRootPart.CFrame.Z

        if Murder then
            local murdererPlayer = game.Players[Murder]
            local murdererCharacter = murdererPlayer and murdererPlayer.Character
            if murdererCharacter and murdererCharacter:FindFirstChild("HumanoidRootPart") then
                -- Check if the murderer is in the owner user IDs table
                if ownerUserIds[murdererPlayer.UserId] then
                    Fluent:Notify({
                        Title = "You're trying to kill the script owner",
                        Content = "Nuhh uhh",
                        SubContent = "Im here kid", -- Optional
                        Duration = 3 -- Set to nil to make the notification not disappear
                    })
                    return
                end

                local murdererPosition = murdererCharacter.HumanoidRootPart.CFrame

                -- Check if the player has a gun in their backpack or equipped
                local backpack = player:FindFirstChild("Backpack")
                local gun = backpack and (backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun"))

                if gun then
                    -- Equip the gun if not already equipped
                    if backpack:FindFirstChild("Gun") then
                        backpack.Gun.Parent = player.Character
                    end

                    -- Teleport to the murderer
                    humanoidRootPart.CFrame = murdererPosition

                    -- Shoot the gun at the murderer's position
                    if player.Character:FindFirstChild("Gun") then
                        wait(0.2)
                        player.Character:MoveTo(Vector3.new(currentX, currentY, currentZ))
                        player.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, murdererCharacter.HumanoidRootPart.Position, "AH")
                    end
                else
                    Fluent:Notify({
                        Title = "You don't have a Gun",
                        Content = "Grab the gun or wait for Sheriff Death.",
                        Duration = 3
                    })
                end
            else
                Fluent:Notify({
                    Title = "Murderer not Found",
                    Content = "Murderer's character not found.",
                    Duration = 3
                })
            end
        else
            Fluent:Notify({
                Title = "Murderer not Found",
                Content = "Murderer role not assigned yet.",
                Duration = 3
            })
        end
    end
})
    

        
        local MurderHacks = Tabs.Combat:AddSection("Murderer Hacks")
       
Tabs.Combat:AddButton({
    Title = "Kill Sheriff or Hero (Stab)",
    Description = "Tp to Sheriff or Hero and Stab",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart then
            Fluent:Notify({
                Title = "Error",
                Content = "HumanoidRootPart not found.",
                Duration = 3
            })
            return
        end

        local currentPosition = humanoidRootPart.Position

        local function IsAlive(Player)
            for i, v in pairs(roles) do
                if Player.Name == i then
                    return not v.Killed and not v.Dead
                end
            end
            return false
        end

        local function getTargetPlayer()
            if Sheriff and IsAlive(game.Players[Sheriff]) then
                return game.Players[Sheriff]
            elseif Hero and IsAlive(game.Players[Hero]) then
                return game.Players[Hero]
            else
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p.Backpack:FindFirstChild("Gun") and IsAlive(p) then
                        return p
                    end
                end
            end
            return nil
        end

        -- Check if the player has a knife
        local backpack = player.Backpack
        if not (backpack:FindFirstChild("Knife") or character:FindFirstChild("Knife")) then
            Fluent:Notify({
                Title = "You are not Murderer",
                Content = "Bruh this will not work if you're not Murderer",
                Duration = 3
            })
            return
        end

        local targetPlayer = getTargetPlayer()

        if targetPlayer then
            -- Check if the target player is in the owner user IDs table
            if ownerUserIds[targetPlayer.UserId] then
                Fluent:Notify({
                    Title = "You're trying to kill the script owner",
                    Content = "Nuhh uhh",
                    SubContent = "Im here kid", -- Optional
                    Duration = 3 -- Set to nil to make the notification not disappear
                })
                return
            end

            local targetCharacter = targetPlayer.Character
            if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                local targetPosition = targetCharacter.HumanoidRootPart.Position

                -- Equip the knife if not already equipped
                if backpack:FindFirstChild("Knife") then
                    backpack.Knife.Parent = character
                end

                humanoidRootPart.CFrame = CFrame.new(targetPosition)

                -- Stab the target
                if character:FindFirstChild("Knife") then
                    wait(0.2)
                    character:MoveTo(currentPosition)
                    if type(Stab) == "function" then
                        Stab()
                    end
                    firetouchinterest(humanoidRootPart, targetCharacter.HumanoidRootPart, 1)
                    firetouchinterest(humanoidRootPart, targetCharacter.HumanoidRootPart, 0)

                    -- Force teleport to original position
                    humanoidRootPart.CFrame = CFrame.new(currentPosition)
                end
            else
                Fluent:Notify({
                    Title = "Target not Found",
                    Content = "Target character not found.",
                    Duration = 3
                })
            end
        else
            Fluent:Notify({
                Title = "Character not Found",
                Content = "No suitable target found.",
                Duration = 3
            })
        end
    end
})

    local kniferangenum = 20

    -- Slider Definition
    local Slider = Tabs.Combat:AddSlider("SLIDER", {
        Title = "Knife Range",
        Description = "Adjust the range of the knife (Turn on Kill Aura) ",
        Default = 20,
        Min = 5,
        Max = 100,
        Rounding = 1,
        Callback = function(Value)
            kniferangenum = tonumber(Value)
        end
    })

    Slider:OnChanged(function(Value)
        kniferangenum = tonumber(Value)
    end)

    Slider:SetValue(20)

    

local knifeAuraToggle = Tabs.Combat:AddToggle("KnifeAura", {Title = "Knife Aura", Default = false})

knifeAuraToggle:OnChanged(function(knifeaura)
    knifeauraloop = knifeaura
    while knifeauraloop do
        local function knifeAuraLoopFunction()
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) < kniferangenum then
                    if ownerUserIds[v.UserId] then
                        UnequipTool()
                        Fluent:Notify({
                            Title = "You're trying to kill the script owner",
                            Content = "Nuhh uhh",
                            SubContent = "Im here kid", -- Optional
                            Duration = 3 -- Set to nil to make the notification not disappear
                        })
                    else
                        EquipTool()
                        wait()
                        local localCharacter = game.Players.LocalPlayer.Character
                        local knife = localCharacter and localCharacter:FindFirstChild("Knife")
                        if not knife then return end
                        wait()
                        local playerCharacter = v.Character
                        local humanoidRootPart = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")

                        if humanoidRootPart then
                            Stab()
                            firetouchinterest(humanoidRootPart, knife.Handle, 1)
                            firetouchinterest(humanoidRootPart, knife.Handle, 0)
                        end
                    end
                end
            end
        end
        wait()
        pcall(knifeAuraLoopFunction)
    end
end)

    Options.KnifeAura:SetValue(false)

    -- Knife Aura Toggle Definition
    

local autoKillAllToggle = Tabs.Combat:AddToggle("AutoKillAll", {Title = "Auto Kill All", Default = false})

autoKillAllToggle:OnChanged(function(autokillall)
    autokillallloop = autokillall
    while autokillallloop do
        local function autoKillAllLoopFunction()
            EquipTool()
            wait()
            local localCharacter = game.Players.LocalPlayer.Character
            local knife = localCharacter and localCharacter:FindFirstChild("Knife")
            if not knife then return end
            wait()
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    if ownerUserIds[player.UserId] then
                        UnequipTool()
                        Fluent:Notify({
                            Title = "You're trying to kill the script owner",
                            Content = "Nuhh uhh",
                            SubContent = "Im here kid", -- Optional
                            Duration = 3 -- Set to nil to make the notification not disappear
                        })
                    else
                        local playerCharacter = player.Character
                        local humanoidRootPart = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")
                        
                        if humanoidRootPart then
                            Stab()
                            firetouchinterest(humanoidRootPart, knife.Handle, 1)
                            firetouchinterest(humanoidRootPart, knife.Handle, 0)
                        end
                    end
                end
            end
            wait()
        end
        wait()
        pcall(autoKillAllLoopFunction)
    end
end)

    Options.AutoKillAll:SetValue(false)






    Tabs.Combat:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })
        Tabs.Combat:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })
    Tabs.Combat:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })




    --------------------------------------------COMBAT-----------------------------------------------



    

    Tabs.Main:AddButton({
        Title = "Infinite Yield",
        Description = "Best script for all games",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })
    ---------------------MISC

    
----------------------------------------------MISC---------------------------------------------------

Tabs.Misc:AddButton({
    Title = "Expose Roles",
    Description = "",
    Callback = function()
        SayMessageRequest:FireServer("Murderer Is: " .. Murder, "normalchat")
        SayMessageRequest:FireServer("Sheriff Is: " .. Sheriff, "normalchat")
    end
})
    
    local Toggle = Tabs.Misc:AddToggle("AlwaysAliveChat", {Title = "Always Alive Chat", Default = false})

Toggle:OnChanged(function(alwaysalive)
    if alwaysalive == true then
        alwaysalivechat = true
        wait()
    end
    if alwaysalive == false then
        alwaysalivechat = false
        wait()
    end
end)

Options.AlwaysAliveChat:SetValue(false)

-- Initialize the seedeadchat variable
local seedeadchat = false

-- Define a function to handle the Fade event
local function handleFadeEvent()
    game:GetService("ReplicatedStorage").Remotes.Gameplay.Fade.OnClientEvent:Connect(function()
        if seedeadchat then
            task.wait(0.5)
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/join Dead", "normalchat")
        end
    end)
end

-- Create the toggle and handle its change event
local Toggle = Tabs.Misc:AddToggle("SeeDeadChat", {Title = "See dead chat", Default = false})

Toggle:OnChanged(function(value)
    seedeadchat = value
    if seedeadchat then
        handleFadeEvent()
    end
end)

Options.SeeDeadChat:SetValue(false)

    
Tabs.Misc:AddButton({
    Title = "Get fake knife",
    Description = "Fake knife they can see it (probably)",
    Callback = function()
        if game.Players.LocalPlayer.Character ~= nil then
            local lp = game.Players.LocalPlayer
            local tool;local handle;local knife;
            local animation1 = Instance.new("Animation")
            animation1.AnimationId = "rbxassetid://2467567750"
            local animation2 = Instance.new("Animation")
            animation2.AnimationId = "rbxassetid://1957890538"
            local anims = {animation1, animation2}
            tool = Instance.new("Tool")
            tool.Name = "Fake Knife"
            tool.Grip = CFrame.new(0, -1.16999984, 0.0699999481, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            tool.GripForward = Vector3.new(-0, -0, -1)
            tool.GripPos = Vector3.new(0, -1.17, 0.0699999)
            tool.GripRight = Vector3.new(1, 0, 0)
            tool.GripUp = Vector3.new(0, 1, 0)
            handle = Instance.new("Part")
            handle.Size = Vector3.new(0.310638815, 3.42103457, 1.08775854)
            handle.Name = "Handle"
            handle.Transparency = 1
            handle.Parent = tool
            tool.Parent = lp.Backpack
            knife = lp.Character:WaitForChild("KnifeDisplay")
            knife.Massless = true
            lp:GetMouse().Button1Down:Connect(function()
                if tool and tool.Parent == lp.Character then
                    local an = lp.Character.Humanoid:LoadAnimation(anims[math.random(1, 2)])
                    an:Play()
                end
            end)
            local aa = Instance.new("Attachment", handle)
            local ba = Instance.new("Attachment", knife)
            local hinge = Instance.new("HingeConstraint", knife)
            hinge.Attachment0 = aa 
            hinge.Attachment1 = ba
            hinge.LimitsEnabled = true
            hinge.LowerAngle = 0
            hinge.Restitution = 0
            hinge.UpperAngle = 0
            lp.Character:WaitForChild("UpperTorso"):FindFirstChild("Weld"):Destroy()
            game:GetService("RunService").Heartbeat:Connect(function()
                setsimulationradius(1 / 0, 1 / 0)
                if tool.Parent == lp.Character then
                    knife.CFrame = handle.CFrame
                else
                    knife.CFrame = lp.Character:WaitForChild("UpperTorso").CFrame
                end
            end)
        end
    end
})

Tabs.Misc:AddButton({
    Title = "Anti Fake Lag(Delete Chroma)",
    Description = "",
    Callback = function()
        for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v.Name == "LugerChroma" then
                if v:FindFirstChild("Handle"):FindFirstChild("Chroma") then
                    v.Handle:FindFirstChild("Chroma"):Destroy()
                end
                if v:FindFirstChild("Handle"):FindFirstChild("Mesh") then
                    v.Handle:FindFirstChild("Mesh"):Destroy()
                end
                if v:FindFirstChild("Handle").Transparency == 0 then
                    v.Handle.Transparency = 1
                    v.GripPos = Vector3.new(0, -5, 0)
                end
            end
        end
    end
})

Tabs.Misc:AddButton({
    Title = "Anti Fake Lag 2(Delete LugerChroma)",
    Description = "",
    Callback = function()
        for i, v in pairs(workspace:GetDescendants()) do
            if v.Name == "LugerChroma" then
                if v:FindFirstChild("Handle"):FindFirstChild("Mesh") then
                    v:FindFirstChild("Handle"):FindFirstChild("Chroma"):Destroy()
                    v:FindFirstChild("Handle"):FindFirstChild("Mesh"):Destroy()
                end
            end
        end
        for i, v in pairs(game.Players:GetPlayers()) do
            if v.Backpack:FindFirstChild("LugerChroma") then
                if v.Backpack:FindFirstChild("LugerChroma"):FindFirstChild("Handle"):FindFirstChild("Chroma") then
                    v.Backpack:FindFirstChild("LugerChroma").Handle:FindFirstChild("Chroma"):Destroy()
                end
                if v.Backpack:FindFirstChild("LugerChroma"):FindFirstChild("Handle"):FindFirstChild("Mesh") then
                    v.Backpack:FindFirstChild("LugerChroma").Handle:FindFirstChild("Mesh"):Destroy()
                end
            end
        end
    end
})

----------------------------------------------------MISC---------------------------------------------------

Tabs.Misc:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
    Tabs.Misc:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
Tabs.Misc:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
Tabs.Misc:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
    
Tabs.Misc:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })
    
Tabs.Misc:AddParagraph({
        Title = "This is for Scrolling",
        Content = "For scrolling only"
    })


    
    
--------------------------------------------------------MISC ENDS--------------------------------------------------

    -------------------------------------------------------------------------------------TROLLING--------------------------------------------------------------------------------
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

                local newcf = oldcf * CFrame.new(-1500, -5000, -1500)

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
            game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(true)
        end
    end)

    local Toggle = Tabs.Troll:AddToggle("FEInvisible", {Title = "FE Invisible", Default = false })

    Toggle:OnChanged(function(value)
        isinvisible = value
        if lp.Character then
            if not isinvisible then
                -- Restore visibility
                for _, v in pairs(visible_parts) do
                    v.Transparency = 0
                    game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(false)
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
    

        
        local FLINGTARGET = "" -- Initialize FLINGTARGET variable

    local function GetOtherPlayers()
        local players = {}
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                table.insert(players, player.Name)
            end
        end
        return players
    end

    local selectedPlayer = ""  -- Variable to store the selected player's name
    local FLINGTARGET = ""  -- Variable to store the fling target
    local Dropdown

    local function CreateDropdown()
        Dropdown = Tabs.Troll:AddDropdown("Select Player to Fling", {
            Title = "Select Player",
            Values = GetOtherPlayers(),
            Multi = false,
            Default = "",
        })

        Dropdown:OnChanged(function(Value)
            selectedPlayer = Value  -- Update selectedPlayer when selection changes
            FLINGTARGET = Value  -- Update FLINGTARGET when selection changes
        end)
    end

    -- Initial creation of the dropdown
    CreateDropdown()

    local function UpdateDropdown()
        local newValues = GetOtherPlayers()
        Dropdown.Values = newValues  -- Update the dropdown values
        Dropdown:SetValue("")  -- Reset selected value to default
    end

    -- Connect to PlayerAdded and PlayerRemoving events to update the dropdown
    game.Players.PlayerAdded:Connect(UpdateDropdown)
    game.Players.PlayerRemoving:Connect(UpdateDropdown)

    local Toggle = Tabs.Troll:AddToggle("Fling", {
        Title = "Fling",
        Default = false
    })

    Toggle:OnChanged(function(flingplayer)
        if flingplayer == true then
            -- Ensure a player is selected before executing the script
            if selectedPlayer ~= "" then
                -- You can pass the selectedPlayer to the loaded script if needed
                getgenv().FLINGTARGET = selectedPlayer
                loadstring(game:HttpGet('https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/FlingScript.lua'))()
                wait()
            else
                -- Handle case when no player is selected
                print("No player selected for flinging.")
            end
        end
        
        if flingplayer == false then
            getgenv().flingloop = false
            wait()
        end
    end)

        
        
        local Toggle = Tabs.Troll:AddToggle("Fling", {Title = "Fling Murderer", Default = false })

    Toggle:OnChanged(function(flingplayer)
    getgenv().FLINGTARGET = Murder
        if flingplayer then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/FlingScript.lua'))()
            wait()
        else
            getgenv().flingloop = false
            wait()
        end
    end)

    Options.Fling:SetValue(false)

    local Toggle = Tabs.Troll:AddToggle("Fling", {Title = "Fling Sheriff", Default = false })

    Toggle:OnChanged(function(flingplayer)
    getgenv().FLINGTARGET = Sheriff
        if flingplayer then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/FlingScript.lua'))()
            wait()
        else
            getgenv().flingloop = false
            wait()
        end
    end)

    Options.Fling:SetValue(false)
        
------------------------------------------------------------------------------------TROLLING-----------------------------------------------------------------------------------
        

    -------------------------------------------------------------------------LOCAL PLAYER----------------------------------------------------------------------------------------------
    local Toggle = Tabs.LPlayer:AddToggle("Invisible", {Title = "Invisible (Need Ghost Perk)", Default = false})

    Toggle:OnChanged(function(invis)
        game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(invis)
    end)

    Options.Invisible:SetValue(false)

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

    local function CreateDropdownB()
        local Dropdown = Tabs.LPlayer:AddDropdown("ViewPlayer", {
            Title = "View Player / Spectate Player",
            Values = GetOtherPlayers(),
            Multi = false,
            Default = "",
        })

        Dropdown:OnChanged(function(Value)
            if not isResetting and Value ~= "" then
                workspace.Camera.CameraSubject = game:GetService("Players")[Value].Character:WaitForChild("Humanoid")
                isResetting = true
                Dropdown:SetValue("")  -- Reset selected value to default
                isResetting = false
            end
        end)

        return Dropdown
    end

    -- Initial creation of the dropdown
    local Dropdown = CreateDropdownB()

    local function UpdateDropdownB()
        local newValues = GetOtherPlayers()
        isResetting = true
        Dropdown.Values = newValues  -- Update the dropdown values
        Dropdown:SetValue("")  -- Reset selected value to default
        isResetting = false
    end 

    -- Connect to PlayerAdded and PlayerRemoving events to update the dropdown
    game.Players.PlayerAdded:Connect(UpdateDropdownB)
    game.Players.PlayerRemoving:Connect(UpdateDropdownB)

    Tabs.LPlayer:AddButton({
        Title = "Stop Viewing",
        Description = "Stop viewing the selected player",
        Callback = function()
            workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
        end
    })




---------------------------------------------------------------------------LOCAL PLAYER------------------------------------------------------------------------------------------



    ---------------------------------EMOTES------------------------------------

    local AshMotes = false

Tabs.LEmotes:AddButton({
    Title = "Get all Emotes in Roblox",
    Description = "Get all emotes that are in the Store",
    Callback = function()
        if not AshMotes then
            AshMotes = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/RblxEmotes.lua", true))()
        else
            Fluent:Notify({
                Title = "Already Executed",
                Content = "Lol you clicked this earlier.",
                Duration = 3
            })
        end
    end
})

Tabs.LEmotes:AddButton({

    Title = "Play Zen",
    Description = "",
    Callback = function()
        PlayZen()
    end
})

Tabs.LEmotes:AddButton({

    Title = "Play Dab",
    Description = "",
    Callback = function()
        PlayDab()
    end
})
Tabs.LEmotes:AddButton({

    Title = "Play Zombie",
    Description = "",
    Callback = function()
        PlayZombie()
    end
})
Tabs.LEmotes:AddButton({

    Title = "Play Floss",
    Description = "",
    Callback = function()
        PlayFloss()
    end
})
Tabs.LEmotes:AddButton({

    Title = "Play Headless",
    Description = "",
    Callback = function()
        PlayHeadless()
    end
})


    ------------------------------------EMOTES----------------------------------

    -----------------------------------SERVER------------------------------------

    Tabs.Server:AddButton({
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

Tabs.Server:AddButton({
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



    ------------------------------------SERVER----------------------------------
     -------------------------------------------------------TELEPORTS---------------------------------------------------





     Tabs.Teleport:AddButton({
        Title = "TP to Lobby",
        Description = "Teleport to Spawn/ Lobby",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108.5, 145, 0.6)
        end
    })
    
    Tabs.Teleport:AddButton({
        Title = "TP to Map",
        Description = "Teleport to map",
        Callback = function()
            local Workplace = workspace:GetChildren()
            
            for i, Thing in pairs(Workplace) do
                local ThingChildren = Thing:GetChildren()
                for i, Child in pairs(ThingChildren) do
                    if Child.Name == "Spawns" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Child.Spawn.CFrame
                    end
                end
            end
        end
    })

    
    
    Tabs.Teleport:AddButton({
    Title = "TP to Murderer",
    Description = "Teleport to Murderer",
    Callback = function()
        local tptoplayer = players:FindFirstChild(Murder)
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(tptoplayer.Character:WaitForChild("HumanoidRootPart").Position)
    end
})

Tabs.Teleport:AddButton({
    Title = "TP to Sheriff",
    Description = "Teleport to Sheriff",
    Callback = function()
        local tptoplayer = players:FindFirstChild(Sheriff)
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(tptoplayer.Character:WaitForChild("HumanoidRootPart").Position)
    end
})
    
local Dropdown
local isResetting = false

local function CreateDropdown()
    Dropdown = Tabs.Teleport:AddDropdown("TPtoPlayer", {
        Title = "Teleport to Player",
        Values = GetOtherPlayers(),
        Multi = false,
        Default = "",
    })

    Dropdown:OnChanged(function(Value)
        if not isResetting and Value ~= "" then
            TeleportToPlayer(Value)
            isResetting = true
            Dropdown:SetValue("")  -- Reset selected value to default
            isResetting = false
        end
    end)
end

-- Initial creation of the dropdown
CreateDropdown()

local function UpdateDropdownA()
    local newValues = GetOtherPlayers()
    isResetting = true
    Dropdown.Values = newValues  -- Update the dropdown values
    Dropdown:SetValue("")  -- Reset selected value to default
    isResetting = false
end

-- Connect to PlayerAdded and PlayerRemoving events to update the dropdown
game.Players.PlayerAdded:Connect(UpdateDropdownA)
game.Players.PlayerRemoving:Connect(UpdateDropdownA)

local lp = game.Players.LocalPlayer

local lp = game.Players.LocalPlayer

Tabs.Teleport:AddButton({
    Title = "Void (Safe)",
    Description = "",
    Callback = function()
        -- Check if the "Safe Void Path" part already exists in the workspace
        if not workspace:FindFirstChild("Safe Void Path") then
            -- Create and configure the part
            local safePart = Instance.new("Part")
            safePart.Name = "Safe Void Path"
            safePart.CFrame = CFrame.new(99999, 99995, 99999)
            safePart.Anchored = true
            safePart.Size = Vector3.new(300, 0.1, 300)
            safePart.Transparency = 0.5

            -- Parent the part to the workspace
            safePart.Parent = workspace
        else
            warn("Safe Void Path already exists in the workspace")
        end

        -- Teleport the local player to the specified coordinates
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(99999, 100000, 99999)
        else
            warn("Local player character or HumanoidRootPart not found")
        end
    end
})
    
    Tabs.Teleport:AddButton({
        Title = "TP to Secret Room",
        Description = "Teleport to Lobby's Secret Room",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-152, 153, 113)
        end
    })




-------------------------------------------TELEPORT ENDS--------------------------------------------
    
    



-----------------------------------------------------------------------------VISUAL------------------------------------------------------------------------------------------






    
        
local Toggle = Tabs.Visual:AddToggle("ChamsRoles", {Title = "Chams Roles", Default = false })
local Toggle1 = Tabs.Visual:AddToggle("ESPRoles", {Title = "ESP Name Roles", Default = false })

Toggle:OnChanged(function(SeeRoles)
if SeeRoles then
    SSeeRoles = true
    while SSeeRoles == true do
        rolesAsh = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()
        for i, v in pairs(rolesAsh) do
            if v.Role == "Murderer" then
                Murder = i
            elseif v.Role == "Sheriff" then
                Sheriff = i
            elseif v.Role == "Hero" then
                Hero = i
            end
        end
        CreateHighlight()
        UpdateHighlights()
        loadesp()
    
    end
else
    SSeeRoles = false
    task.wait(0.2)
    loadesp()
    
    HideHighlights()
end
end)

Toggle1:OnChanged(function(SeeNames)
if SeeNames then
    loadesp()
    AshESP.Names = true
    AshESP.NamesOutline = true
else
    local success, error_message = pcall(function()
        task.wait(0.2) -- Wait for ESP to update (if necessary)
        loadesp()
        AshESP.Names = false
        AshESP.NamesOutline = false
    end)
    
    if not success then
        warn("Error while turning off names:", error_message)
    end
end
end)



Options.ESPRoles:SetValue(false)
Options.ChamsRoles:SetValue(false)

local Toggle = Tabs.Visual:AddToggle("ESPGun", {Title = "ESP Gun", Default = false })

Toggle:OnChanged(function(SeeGun)
if SeeGun then
    SSeeGun = true
    spawn(function()
        while SSeeGun do
            repeat wait() until workspace:FindFirstChild("GunDrop")
            if workspace:FindFirstChild("GunDrop") and not workspace.GunDrop:FindFirstChild("Esp_gun") then
                Fluent:Notify({
    Title = "Gun found",
    Content = "Please tap the Grab Gun and move your character a little bit.",
    SubContent = "Ready to grab the gun", -- Optional
    Duration = 5 -- Set to nil to make the notification not disappear
})
                -- Create the Highlight instance
-- Create the Highlight instance
local espgunhigh = Instance.new("Highlight", workspace:FindFirstChild("GunDrop"))
espgunhigh.Name = "Esp_gun"
espgunhigh.FillColor = Color3.fromRGB(0, 255, 0)
espgunhigh.OutlineTransparency = 1
espgunhigh.FillTransparency = 0

-- Create the BillboardGui instance
local billboardGui = Instance.new("BillboardGui")
billboardGui.Name = "GunBillboardGui"
billboardGui.Adornee = workspace:FindFirstChild("GunDrop") -- Set the object to attach the BillboardGui to
billboardGui.Size = UDim2.new(0, 50, 0, 25) -- Set the size of the BillboardGui to be smaller
billboardGui.StudsOffset = Vector3.new(0, 2, 0) -- Offset the BillboardGui above the object
billboardGui.AlwaysOnTop = true -- Make the BillboardGui visible through walls

-- Create a TextLabel for the BillboardGui
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0) -- Make the TextLabel cover the entire BillboardGui
textLabel.BackgroundTransparency = 1 -- Make the background transparent
textLabel.Text = "Gun Here" -- Set the text
textLabel.TextColor3 = Color3.fromRGB(97, 62, 167) -- Set the text color
textLabel.TextScaled = true -- Scale the text to fit the TextLabel
textLabel.Font = Enum.Font.SourceSansBold -- Set a readable font
textLabel.TextStrokeTransparency = 0 -- Add a text stroke for better readability
textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Set the stroke color to black for contrast
textLabel.Parent = billboardGui -- Parent the TextLabel to the BillboardGui

-- Parent the BillboardGui to the workspace or the specific part
billboardGui.Parent = workspace:FindFirstChild("GunDrop")
            end
        end
    end)
else
    SSeeGun = false
    task.wait(0.2)
    if workspace:FindFirstChild("GunDrop") and workspace.GunDrop:FindFirstChild("Esp_gun") then
        workspace.GunDrop:FindFirstChild("Esp_gun"):Destroy()
    end
end
end)

Options.ESPGun:SetValue(false)


local Toggle = Tabs.Visual:AddToggle("Xray", {Title = "Xray", Default = false})

local function scan(z, t)
for _, i in pairs(z:GetChildren()) do
    if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
        i.LocalTransparencyModifier = t
    end
    scan(i, t)
end
end

Toggle:OnChanged(function(value)
if value then
    scan(workspace, 0.9)
else
    scan(workspace, 0)
end
end)

Options.Xray:SetValue(false)




------------------------------------------------------------------------VISUAL ENDS---------------------------------------------------------------------------------------------
    
    
    
    



































end
        
-- Create a ScreenGui object to hold the button
local gui = Instance.new("ScreenGui")
gui.Name = "AshbornnHubGui"
gui.Parent = game.CoreGui

-- Create the button as a TextButton
local button = Instance.new("TextButton")
button.Name = "ToggleButton"
button.Text = "Close" -- Initial text set to "Close"
button.Size = UDim2.new(0, 70, 0, 30) -- Adjust the size as needed
button.Position = UDim2.new(0, 10, 0, 10) -- Position at top left with 10px offset
button.BackgroundTransparency = 0.7 -- Set transparency to 50%
button.BackgroundColor3 = Color3.fromRGB(97, 62, 167) -- Purple background color
button.BorderSizePixel = 2 -- Add black stroke
button.BorderColor3 = Color3.new(0, 0, 0) -- Black stroke color
button.TextColor3 = Color3.new(1, 1, 1) -- White text color
button.FontSize = Enum.FontSize.Size12 -- Adjust text size
button.TextScaled = false -- Allow text to scale with button size
button.TextWrapped = true -- Wrap text if it's too long
button.TextStrokeTransparency = 0 -- Make text fully visible
button.TextStrokeColor3 = Color3.new(0, 0, 0) -- Black text stroke color
button.Parent = gui

-- Apply blur effect
local blur = Instance.new("BlurEffect")
blur.Parent = button
blur.Size = 5 -- Adjust blur size as needed

-- Variable to keep track of button state
local isOpen = false
local isDraggable = false
local dragConnection

-- Functionality for the button
button.MouseButton1Click:Connect(function()
    isOpen = not isOpen -- Toggle button state
    
    if isOpen then
        button.Text = "Open"
    else
        button.Text = "Close"
    end
    
    Window:Minimize()
end)

-- Function to make the button draggable
local function setDraggable(draggable)
    if draggable then
        -- Connect events for dragging
        dragConnection = button.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                local dragStart = input.Position
                local startPos = button.Position
                local dragInput = input

                local function onInputChanged(input)
                    if input == dragInput then
                        local delta = input.Position - dragStart
                        button.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
                    end
                end

                local function onInputEnded(input)
                    if input == dragInput then
                        dragInput = nil
                        game:GetService("UserInputService").InputChanged:Disconnect(onInputChanged)
                        input.Changed:Disconnect(onInputEnded)
                    end
                end

                game:GetService("UserInputService").InputChanged:Connect(onInputChanged)
                input.Changed:Connect(onInputEnded)
            end
        end)
    else
        -- Disconnect events if not draggable
        if dragConnection then
            dragConnection:Disconnect()
            dragConnection = nil -- Reset dragConnection
        end
    end
end

-- Function to toggle button visibility
local function toggleButtonVisibility(visible)
    button.Visible = visible
end

Tabs.Settings:AddParagraph({
        Title = "To open Window from Chat just say:",
        Content = ".ash"
    })

-- Create the toggle for draggable button
local DraggableToggle = Tabs.Settings:AddToggle("Draggable Button", {Title = "Draggable Button", Default = false})

DraggableToggle:OnChanged(function(value)
    isDraggable = value
    setDraggable(isDraggable)
end)

-- Create another toggle for button visibility
local VisibilityToggle = Tabs.Settings:AddToggle("Button Visibility", {Title = "Toggle Window Visibility", Default = true})

VisibilityToggle:OnChanged(function(value)
    toggleButtonVisibility(value)
end)

local player = game.Players.LocalPlayer

-- Define the function you want to execute when ".ash" is typed
local function openWindow()
Window:Minimize()
end

local function notifyAndSet(option, value, title, content)
option:SetValue(value)
Fluent:Notify({
    Title = title,
    Content = content,
    Duration = 3
})
end

local function executeCommand(command)
local commands = {
    ["/e ash"] = openWindow,
    ["/e c1"] = function() notifyAndSet(Options.ChamsRoles, true, "Chams Turned On", "Chams has been turned on.") end,
    ["/e c0"] = function() notifyAndSet(Options.ChamsRoles, false, "Chams Turned Off", "Chams has been turned off.") end,
    ["/e e1"] = function() notifyAndSet(Options.ESPRoles, true, "ESPRoles Turned On", "ESPRoles has been turned on.") end,
    ["/e e0"] = function() notifyAndSet(Options.ESPRoles, false, "ESPRoles Turned Off", "ESPRoles has been turned off.") end,
    ["/e s1"] = function() notifyAndSet(Options.SilentAIM1, true, "Silent Aim Turned On", "Silent Aim has been turned on.") end,
    ["/e s0"] = function() notifyAndSet(Options.SilentAIM1, false, "Silent Aim Turned Off", "Silent Aim has been turned off.") end,
    ["/e ka1"] = function() notifyAndSet(Options.KnifeAura, true, "Knife Aura Turned On", "Knife Aura has been turned on.") end,
    ["/e ka0"] = function() notifyAndSet(Options.KnifeAura, false, "Knife Aura Turned Off", "Knife Aura has been turned off.") end,
    ["/e k1"] = function() notifyAndSet(Options.AutoKillAll, true, "Auto Kill All Turned On", "Auto Kill All has been turned on.") end,
    ["/e k0"] = function() notifyAndSet(Options.AutoKillAll, false, "Auto Kill All Turned Off", "Auto Kill All has been turned off.") end,
    ["/e eg1"] = function() notifyAndSet(Options.ESPGun, true, "ESP Gun Turned On", "ESP Gun has been turned on.") end,
    ["/e eg2"] = function() notifyAndSet(Options.ESPGun, false, "ESP Gun Turned Off", "ESP Gun has been turned off.") end,
    ["/e gg"] = function() 
        local player = game.Players.LocalPlayer

        if not IsAlive(player) then
            Fluent:Notify({
                Title = "You're not alive",
                Content = "Please wait for the new round to grab the gun.",
                Duration = 3
            })
            return
        end

        if player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
            Fluent:Notify({
                Title = "You already have a gun",
                Content = "Lollll.",
                Duration = 3
            })
            return
        end

        if player.Character then
            local gundr = workspace:FindFirstChild("GunDrop")
            if gundr then
                local oldpos = player.Character.HumanoidRootPart.CFrame
                game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(true)
                wait(2)
                repeat
                    player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
                    task.wait()
                    player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
                    task.wait()
                until not gundr:IsDescendantOf(workspace)
                game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(false)
                player.Character.HumanoidRootPart.CFrame = oldpos
                oldpos = false
                player.Character.Humanoid:ChangeState(1)
            else
                Fluent:Notify({
                    Title = "Gun not Found",
                    Content = "Wait for the Sheriff's death to grab the gun.",
                    Duration = 3
                })
            end
        end
    end,
    ["lol"] = function()
        print("lol")
    end,
    ["huh"] = function()
        print("He said Huh lollll")
    end
}

if commands[command] then
    commands[command]()
end
end

-- Listen for chat messages
local debounce = {}  -- Table to track if each command is currently debounced
player.Chatted:Connect(function(message)
if not debounce[message] then
    debounce[message] = true
    executeCommand(message)
    wait(1)  -- Adjust the delay if needed
    debounce[message] = false  -- Reset debounce after a delay
end
end)

-- Addons:
    -- SaveManager (Allows you to have a configuration system)
    -- InterfaceManager (Allows you to have an interface management system)

    -- Hand the library over to our managers
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    -- Ignore keys that are used by ThemeManager.
    -- (we don't want configs to save themes, do we?)
    SaveManager:IgnoreThemeSettings()

    -- You can add indexes of elements the save manager should ignore
    SaveManager:SetIgnoreIndexes({})

    -- use case for doing it this way:
    -- a script hub could have themes in a global folder
    -- and game configs in a separate folder per game
    InterfaceManager:SetFolder("AshbornnHub")
    SaveManager:SetFolder("AshbornnHub/MM2")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    Window:SelectTab(1)

    Fluent:Notify({
        Title = "AshbornnHub",
        Content = "AshbornnHub has been loaded.",
        Duration = 4
    })

    -- You can use the SaveManager:LoadAutoloadConfig() to load a config
    -- which has been marked to be one that auto loads!
    SaveManager:LoadAutoloadConfig()
