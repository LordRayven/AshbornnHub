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
    local LocalPlayer = game.Players.LocalPlayer
    local Player = game.Players.LocalPlayer
    local HttpService = game:GetService("HttpService")
    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local N = game:GetService("VirtualInputManager")
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

    local DefaultChatSystemChatEvents = ReplicatedStorage.DefaultChatSystemChatEvents
    local SayMessageRequest = DefaultChatSystemChatEvents.SayMessageRequest

    local mt = getrawmetatable(game);
    local old = {};
    for i, v in next, mt do old[i] = v end;

    setreadonly(mt,false)


    local defualtwalkspeed = 16
    local defualtjumppower = 50
    local defualtgravity = 196.1999969482422
    newwalkspeed = defualtwalkspeed
    newjumppower = defualtjumppower
    antiafk = true
    
local AntiFlingEnabled = false
local playerAddedConnection = nil
local localHeartbeatConnection = nil 

local TrapSystem = ReplicatedStorage:WaitForChild("TrapSystem")
local PlaceTrap = TrapSystem:WaitForChild("PlaceTrap")
    
    local ownerUserIds = {
    [290931] = true,
    [4072731377] = true,
    [2911976621] = true,
    [129215104] = true,
    [6135258891] = true

    
}

    -- Constants
    local Services = setmetatable({}, {
        __index = function(Self, Index)
            local NewService = game:GetService(Index)
            if NewService then
                Self[Index] = NewService
            end
            return NewService
        end
    })

    local LocalPlayer = Services.Players.LocalPlayer

    -- Functions
    local function CharacterAdded(Player)
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local PrimaryPart = Character:WaitForChild("HumanoidRootPart")

        local Detected = false

        local function CheckFling()
            if not (Character:IsDescendantOf(workspace) and PrimaryPart:IsDescendantOf(Character)) then
                return
            end

            if PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 or PrimaryPart.AssemblyLinearVelocity.Magnitude > 100 then
                if not Detected then
                    game.StarterGui:SetCore("ChatMakeSystemMessage", {
                        Text = "Fling Exploit detected, Player: " .. tostring(Player);
                        Color = Color3.fromRGB(255, 200, 0);
                    })
                end
                Detected = true

                for _, Part in ipairs(Character:GetDescendants()) do
                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                        Part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        Part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                    end
                end

                PrimaryPart.CanCollide = false
                PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
            end
        end

        Services.RunService.Heartbeat:Connect(CheckFling)
    end

    local function OnPlayerAdded(Player)
        if AntiFlingEnabled and Player ~= LocalPlayer then
            CharacterAdded(Player)
        end
    end

    local function NeutralizeLocalPlayer()
    local LastPosition = nil
    local lastChatTime = 0

    local function CheckLocalPlayerFling()
        pcall(function()
            local Character = LocalPlayer.Character
            if Character then
                local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
                if PrimaryPart then
                    if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
                        PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        PrimaryPart.CFrame = LastPosition
                        
                        local currentTime = tick()
                        if currentTime - lastChatTime >= 5 then
                            game.StarterGui:SetCore("ChatMakeSystemMessage", {
                                Text = "You were flung. Neutralizing velocity. Thanks Ashbornn for this.";
                                Color = Color3.fromRGB(195, 115, 255);
                            })
                            lastChatTime = currentTime
                        end
                    else
                        LastPosition = PrimaryPart.CFrame
                    end
                end
            end
        end)
    end

    return Services.RunService.Heartbeat:Connect(CheckLocalPlayerFling)
end




    -- Function to teleport to a Player
    
    
    function TeleportToPlayer(playerName)
        local targetPlayer = game.Players:FindFirstChild(playerName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
        end
    end

    function GetOtherPlayers()
        local players = {}
        for _, Player in ipairs(game.Players:GetPlayers()) do
            if Player ~= game.Players.LocalPlayer then
                table.insert(players, Player.Name)
            end
        end
        return players
    end
    
    


    function EquipTool()
        for _,obj in next, game.Players.LocalPlayer.Backpack:GetChildren() do
            if obj.Name == "Knife" then
                local equip = game.Players.LocalPlayer.Backpack.Knife
                equip.Parent = game.Players.LocalPlayer.Character
            end
        end
    end
    
    function UnequipTool()
    local Player = game.Players.LocalPlayer
    local character = Player.Character or Player.CharacterAdded:Wait()
    local backpack = Player:FindFirstChild("Backpack")

    if backpack then
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "Knife" then
                tool.Parent = backpack
                break
            end
        end
    end
end

    function EquipSpray()
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        wait()
        for _,obj in next, game.Players.LocalPlayer.Backpack:GetChildren() do
            if obj.Name == "SprayPaint" then
                local equip = game.Players.LocalPlayer.Backpack.SprayPaint
                equip.Parent = game.Players.LocalPlayer.Character
            end
        end
    end

    function Stab()
        game:GetService("Players").LocalPlayer.Character.Knife.Stab:FireServer("Down")
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
    
    function roleupdaterfix()
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
            UpdateHighlights() -- Call UpdateHighlights after updating roles
            wait(1) -- Update every second
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
    
    -- Start the role updater in a separate coroutine
    spawn(function()
        pcall(roleupdaterfix)
    end)
    
    function HideHighlights()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("ESP_Highlight") then
                v.Character:FindFirstChild("ESP_Highlight"):Destroy()
            end
        end
    end
    
    
    
    function loadesp()
        if loadespenabled ~= true then
            loadespenabled = true
            AshESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/OptiEsp.lua"))()
            AshESP.Names = false
            AshESP.NamesOutline = false
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




    function clearbackpackguns()
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name ~= "Emotes" then
                if v.Name ~= "Knife" then
                    if v.Name ~= "Gun" then
                        if v.Name ~= "Pizza" then
                            if v.Name ~= "ChocolateMilk" then
                                if v.Name ~= "IceCream" then
                                    if v.Name ~= "Teddy" then
                                        if v.Name ~= "FakeBomb" then
                                            if v.Name ~= "Fireflies" then
                                                if v.Name ~= "GGSign" then
                                                    if v.Name ~= "SprayPaint" then
                                                        if v.Name ~= "EggToy2023" then
                                                            if v.Name ~= "BeachBall2023" then
                                                                v:Remove()
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        task.wait()
    end
    -------------------------END FUNCTIONS---------------------------------

    local Window = Fluent:CreateWindow({
        Title = "Ashbornn Hub " .. Fluent.Version,
        SubTitle = "Murder Mystery 2",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl -- Used when there's no MinimizeKeybind
    })

    -- Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional










    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "box" }),
        Visual = Window:AddTab({ Title = "Visual", Icon = "eye" }),
        Combat = Window:AddTab({ Title = "Combat", Icon = "swords" }),
        AutoFarm = Window:AddTab({ Title = "AutoFarm", Icon = "coins" }),
        LPlayer = Window:AddTab({ Title = "Player", Icon = "user" }),
        LEmotes = Window:AddTab({ Title = "Emotes", Icon = "laugh" }),
        Misc = Window:AddTab({ Title = "Misc", Icon = "aperture" }),
        Troll = Window:AddTab({ Title = "Trolling", Icon = "user-x" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "wand" }),
        Server = Window:AddTab({ Title = "Server", Icon = "server" }),
        Buttons = Window:AddTab({ Title = "Buttons", Icon = "command" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
        Test = Window:AddTab({ Title = "Scroll", Icon = "settings" }),
        Test2 = Window:AddTab({ Title = "Scroll", Icon = "settings" })
    }



    -------------------------EXTRAS---------------------------

    mt.__namecall = newcclosure(function(...)
        local method = tostring(getnamecallmethod());
        local args = {...}

        if method == 'FireServer' and args[1].Name == 'SayMessageRequest' then 
            if alwaysalivechat == true then
                args[3] = "Alive"
            end
            return old.__namecall(unpack(args));
        end
        return old.__namecall(...)
    end)

    setreadonly(mt,true)

    getgenv().SheriffAim = false
getgenv().GunAccuracy = 3.5

-- Hook to modify gun shooting behavior
local GunHook
GunHook = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }

    if not checkcaller() then
        if typeof(self) == "Instance" then
            if self.Name == "ShootGun" and method == "InvokeServer" then
                if getgenv().GunAccuracy and Murder and getgenv().SheriffAim then
                    local targetPlayer = Players[Murder]
                    if targetPlayer and targetPlayer.Character and targetPlayer.Character.PrimaryPart then
                        local Root = targetPlayer.Character.PrimaryPart
                        local Velocity = Root.AssemblyLinearVelocity

                        -- Predict the position based on velocity and accuracy
                        local Position = Root.Position

                        if Velocity.Magnitude > 0 then
                            -- Separate horizontal and vertical components
                            local horizontalVelocity = Vector3.new(Velocity.X, 0, Velocity.Z)
                            local verticalVelocity = Vector3.new(0, Velocity.Y, 0)

                            -- Predict horizontal position
                            Position = Position + horizontalVelocity * (getgenv().GunAccuracy / 200)

                            -- Adjust for vertical movement (jumping)
                            Position = Position + verticalVelocity * (getgenv().GunAccuracy / 200)
                        end

                        args[2] = Position
                    end
                end
            end
        end
    end

    return GunHook(self, unpack(args))
end)

-- Prevent the hook from being garbage collected
getgenv().GunHook = GunHook




    --------------------------EXTRAS--------------------------


    local Options = Fluent.Options

    do

    -------------------------------------------COMBAT---------------------------------------

    local SheriffHacks = Tabs.Combat:AddSection("Sheriff Hacks")

    Tabs.Combat:AddButton({
    Title = "Grab Gun v2",
    Description = "Teleport to and grab the gun if available",
    Callback = function()
        local Player = game.Players.LocalPlayer

        if not IsAlive(Player) then
            Fluent:Notify({
                Title = "You're not alive",
                Content = "Please wait for the new round to grab the gun.",
                Duration = 3
            })
            return
        end

        if Player.Backpack:FindFirstChild("Gun") or (Player.Character and Player.Character:FindFirstChild("Gun")) then
            Fluent:Notify({
                Title = "You already have a gun",
                Content = "Lollll.",
                Duration = 3
            })
            return
        end

        if Player.Character then
            local gundr = workspace:FindFirstChild("GunDrop")
            if gundr then
                local oldpos = Player.Character.HumanoidRootPart.CFrame
                repeat
                    Player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
                    task.wait()
                    Player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
                    task.wait()
                until not gundr:IsDescendantOf(workspace)
                Player.Character.HumanoidRootPart.CFrame = oldpos
                oldpos = false
                Player.Character.Humanoid:ChangeState(1)
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
        local Player = game.Players.LocalPlayer
        
        -- Check if the Player is alive
        if not IsAlive(Player) then
            Fluent:Notify({
                Title = "You're not alive",
                Content = "Please wait for the new round to grab the gun.",
                Duration = 3
            })
            return
        end

        local currentX = Player.Character.HumanoidRootPart.CFrame.X
        local currentY = Player.Character.HumanoidRootPart.CFrame.Y
        local currentZ = Player.Character.HumanoidRootPart.CFrame.Z
        
        if workspace:FindFirstChild("GunDrop") then
            Player.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame
            wait(0.30)
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
        else
            Fluent:Notify({
                Title = "Gun not Found",
                Content = "Wait for the Sheriff's death to grab the gun.",
                Duration = 3
            })
        end
    end
})
        

        
        local Toggle = Tabs.Combat:AddToggle("SilentAIM1", {Title = "Silent Aim to Murderer", Default = false })

    Toggle:OnChanged(function(gunsilentaim)
        getgenv().SheriffAim = gunsilentaim
    end)

    Options.SilentAIM1:SetValue(false)

    

Tabs.Combat:AddButton({
    Title = "Shoot Murderer",
    Description = "Tp to Murderer and Shoot",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local humanoidRootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
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

                -- Check if the Player has a gun in their backpack or equipped
                local backpack = Player:FindFirstChild("Backpack")
                local gun = backpack and (backpack:FindFirstChild("Gun") or Player.Character:FindFirstChild("Gun"))

                if gun then
                    -- Equip the gun if not already equipped
                    if backpack:FindFirstChild("Gun") then
                        backpack.Gun.Parent = Player.Character
                    end

                    -- Teleport to the murderer
                    humanoidRootPart.CFrame = murdererPosition

                    -- Shoot the gun at the murderer's position
                    if Player.Character:FindFirstChild("Gun") then
                        wait(0.2)
                        Player.Character:MoveTo(Vector3.new(currentX, currentY, currentZ))
                        Player.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, murdererCharacter.HumanoidRootPart.Position, "AH")
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

local autoShootingActive = false
local autoShootingTask = nil
local gunNotificationShown = false -- Flag to track if the gun notification has been shown

function autoShoot()
    while autoShootingActive do
        local Player = game.Players.LocalPlayer
        local characterRootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if not characterRootPart then return end
        
        if Murder then
            local murdererPlayer = game.Players[Murder]
            local murdererCharacter = murdererPlayer and murdererPlayer.Character
            if murdererCharacter and murdererCharacter:FindFirstChild("HumanoidRootPart") then
                -- Calculate direction to murderer
                local murdererPosition = murdererCharacter.HumanoidRootPart.Position
                local rayDirection = murdererPosition - characterRootPart.Position
                
                -- Perform a raycast to check for obstacles between Player and murderer
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                raycastParams.FilterDescendantsInstances = {Player.Character}
                
                local hit = workspace:Raycast(characterRootPart.Position, rayDirection.Unit * rayDirection.Magnitude, raycastParams)
                
                -- Check if the raycast did not hit anything or if it hit the murderer
                if not hit or (hit.Instance and hit.Instance.Parent == murdererCharacter) then
                    -- Check if the Player has a gun in their backpack or equipped
                    local backpack = Player:FindFirstChild("Backpack")
                    local gun = backpack and (backpack:FindFirstChild("Gun") or Player.Character:FindFirstChild("Gun"))
                    
                    if gun then
                        -- Equip the gun if not already equipped
                        if not Player.Character:FindFirstChild("Gun") then
                            backpack.Gun.Parent = Player.Character
                        end
                        
                        -- Loop to continuously shoot the gun until the Player no longer has it
                        while autoShootingActive and (Player.Character:FindFirstChild("Gun")) do
                            -- Shoot the gun at the murderer's position
                            local gunObject = Player.Character:FindFirstChild("Gun")
                            if gunObject then
                                local knifeServer = gunObject:FindFirstChild("KnifeServer")
                                if knifeServer then
                                    knifeServer:FindFirstChild("ShootGun"):InvokeServer(1, murdererPosition, "AH")
                                else
                                    warn("KnifeServer not found in Gun.")
                                end
                            else
                                warn("Gun not found in character.")
                                break
                            end
                            task.wait(0.1) -- Short delay between shots
                        end
                    else
                        -- Notify about the absence of a gun, if not already notified
                        if not gunNotificationShown then
                            Fluent:Notify({
                                Title = "Gun Not Found",
                                Content = "You don't have a gun.",
                                Duration = 3
                            })
                            gunNotificationShown = true -- Set flag to true to prevent further notifications
                        end
                    end
                else
                    -- If the raycast hit an obstacle, do nothing (optional notification removed)
                end
            else
                -- If murderer's character not found, handle this situation (optional)
                -- Optional notification or debugging message can be added here
            end
        else
            -- If Murder is not defined or found, handle this situation (optional)
            -- Optional notification or debugging message can be added here
        end
        
        -- Wait for the cooldown interval before checking again
        wait(2) -- Cooldown before checking the murderer's presence and line of sight again
    end
end

function onCharacterAdded(character)
   if Options.AutoShoot.Value == true then
      Options.AutoShoot:SetValue(false)
      wait(0.1)
      Options.AutoShoot:SetValue(true)
   end
end



local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(onCharacterAdded)

local Toggle = Tabs.Combat:AddToggle("AutoShoot", {Title = "Auto Shoot Murderer", Default = false})

Toggle:OnChanged(function()
    autoShootingActive = Toggle.Value
    if autoShootingActive then
        autoShootingTask = task.spawn(autoShoot)
        
    else
        autoShootingActive = false
        if autoShootingTask then
            task.cancel(autoShootingTask)
            autoShootingTask = nil
        end
        gunNotificationShown = false -- Reset the flag when auto shooting is disabled
    end
end)

-- Initialize auto shooting if the toggle is already enabled
if Toggle.Value then
    autoShootingActive = true
    autoShootingTask = task.spawn(autoShoot)
end

-- Ensure auto-shoot starts if the character is already loaded
if Player.Character then
    onCharacterAdded(Player.Character)
end
        
        local MurderHacks = Tabs.Combat:AddSection("Murderer Hacks")
       
Tabs.Combat:AddButton({
    Title = "Kill Sheriff or Hero (Stab)",
    Description = "Tp to Sheriff or Hero and Stab",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local character = Player.Character
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

        function getTargetPlayer()
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

        -- Check if the Player has a knife
        local backpack = Player.Backpack
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
            -- Check if the target Player is in the owner user IDs table
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
        function knifeAuraLoopFunction()
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
        function autoKillAllLoopFunction()
            EquipTool()
            wait()
            local localCharacter = game.Players.LocalPlayer.Character
            local knife = localCharacter and localCharacter:FindFirstChild("Knife")
            if not knife then return end
            wait()
            for _, Player in ipairs(game.Players:GetPlayers()) do
                if Player ~= game.Players.LocalPlayer then
                    if ownerUserIds[Player.UserId] then
                        UnequipTool()
                        Fluent:Notify({
                            Title = "You're trying to kill the script owner",
                            Content = "Nuhh uhh",
                            SubContent = "Im here kid", -- Optional
                            Duration = 3 -- Set to nil to make the notification not disappear
                        })
                    else
                        local playerCharacter = Player.Character
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
    function handleFadeEvent()
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

    function CreateDropdown()
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

    function UpdateDropdownA()
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

            -- Teleport the local Player to the specified coordinates
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                lp.Character.HumanoidRootPart.CFrame = CFrame.new(99999, 100000, 99999)
            else
                warn("Local Player character or HumanoidRootPart not found")
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
        
    Tabs.Teleport:AddButton({
            Title = "TP to Secret Room",
            Description = "Teleport to Lobby's Secret Room",
            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-152, 153, 113)
            end
        })
        
    Tabs.Teleport:AddButton({
            Title = "TP to Secret Room",
            Description = "Teleport to Lobby's Secret Room",
            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-152, 153, 113)
            end
        })
        
    Tabs.Teleport:AddButton({
            Title = "TP to Secret Room",
            Description = "Teleport to Lobby's Secret Room",
            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-152, 153, 113)
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

    function scan(z, t)
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
            function loopnoclipfix()
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
    
      -- Getting the UserInputService

-- Function to enable infinite jump
function enableInfiniteJump(speaker)
    local infJump  -- Variable to store the connection for infinite jump
    local infJumpDebounce = false  -- Variable to prevent rapid jumping

    -- Connect infJump to UserInputService's JumpRequest event
    infJump = UserInputService.JumpRequest:Connect(function()
        -- Check if infJumpDebounce is false to prevent rapid jumping
        if not infJumpDebounce then
            infJumpDebounce = true  -- Set debounce to true to prevent rapid jumps
            
            -- Make the character jump by changing its state to Jumping
            speaker.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            
            wait()  -- Wait briefly to allow the jump action to complete
            
            infJumpDebounce = false  -- Reset debounce after the jump is done
        end
    end)

    return infJump  -- Return the infJump connection for possible disconnection later
end

-- Assuming Tabs, Options, and the necessary setup for your UI are defined elsewhere
local Toggle = Tabs.LPlayer:AddToggle("InfiJump", {Title = "Infinite Jump", Default = false })

local infJumpConnection  -- Variable to store the connection for infinite jump

Toggle:OnChanged(function(isEnabled)
    if isEnabled then
        -- Enable infinite jump when the toggle is turned on
        infJumpConnection = enableInfiniteJump(game.Players.LocalPlayer)  -- Replace with the actual Player instance
    else
        -- Disable infinite jump when the toggle is turned off
        if infJumpConnection then
            infJumpConnection:Disconnect()  -- Disconnect the infJump connection
            infJumpConnection = nil
        end
    end
end)

Options.InfiJump:SetValue(false)  -- Ensure the initial state of the toggle is set correctly

    function CreateDropdownB()
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

    function UpdateDropdownB()
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
        Description = "Stop viewing the selected Player",
        Callback = function()
            workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
        end
    })




---------------------------------------------------------------------------LOCAL PLAYER------------------------------------------------------------------------------------------






-------------------------------------------------------------------------------------TROLLING--------------------------------------------------------------------------------

    local Toggle = Tabs.Troll:AddToggle("AntiFling", {Title = "Anti Fling (You can't fling me)", Default = false })

    Toggle:OnChanged(function(enabled)
        AntiFlingEnabled = enabled
        if enabled then
            playerAddedConnection = Services.Players.PlayerAdded:Connect(OnPlayerAdded)
            for _, Player in ipairs(Services.Players:GetPlayers()) do
                if Player ~= LocalPlayer then
                    CharacterAdded(Player)
                end
            end
            localHeartbeatConnection = NeutralizeLocalPlayer()
        else
            if playerAddedConnection then
                playerAddedConnection:Disconnect()
                playerAddedConnection = nil
            end
            if localHeartbeatConnection then
                localHeartbeatConnection:Disconnect()
                localHeartbeatConnection = nil
            end
        end
    end)
        
        if _G.cons then
        for _, v in pairs(_G.cons) do
            v:Disconnect()
        end

        _G.cons = nil
    end

    local rsrv = game:GetService("RunService")
    local heartbeat = rsrv.Heartbeat
    local renderstepped = rsrv.RenderStepped

    local lp = game.Players.LocalPlayer
    local mouse = lp:GetMouse()

    local isinvisible = false
    local visible_parts = {}
    local kdown, loop

    function ghost_parts()
        for _, v in pairs(visible_parts) do
            v.Transparency = isinvisible and 0.5 or 0
        end
    end

    function setup_character(character)
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

    function GetOtherPlayers()
        local players = {}
        for _, Player in ipairs(game.Players:GetPlayers()) do
            if Player ~= game.Players.LocalPlayer then
                table.insert(players, Player.Name)
            end
        end
        return players
    end

    local selectedPlayer = ""  -- Variable to store the selected Player's name
    local FLINGTARGET = ""  -- Variable to store the fling target
    local Dropdown

    function CreateDropdown()
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

    function UpdateDropdown()
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
            -- Ensure a Player is selected before executing the script
            if selectedPlayer ~= "" then
                -- You can pass the selectedPlayer to the loaded script if needed
                getgenv().FLINGTARGET = selectedPlayer
                loadstring(game:HttpGet('https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/FlingScript.lua'))()
                wait()
            else
                -- Handle case when no Player is selected
                print("No Player selected for flinging.")
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
    
    
    local TrapSec = Tabs.Troll:AddSection("Trap Trolling (Need Perk)")

-- Function to get other players, including an "All" option
local function GetOtherPlayers()
    local players = {"All"}
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            table.insert(players, Player.Name)
        end
    end
    return players
end

local selectedPlayer = "All"  -- Default to "All"
local Dropdown

-- Function to create the dropdown menu
local function CreateDropdown()
    Dropdown = Tabs.Troll:AddDropdown("Select Loop Target Player", {
        Title = "Select Player",
        Values = GetOtherPlayers(),
        Multi = false,
        Default = "All",
    })

    Dropdown:OnChanged(function(Value)
        selectedPlayer = Value  -- Update selectedPlayer when selection changes
        ChangeLoopTarget = Value  -- Update ChangeLoopTarget when selection changes
    end)
end

-- Initial creation of the dropdown
CreateDropdown()

-- Function to update the dropdown values
function UpdateDropdown()
    local newValues = GetOtherPlayers()
    Dropdown.Values = newValues  -- Update the dropdown values
    Dropdown:SetValue("All")  -- Reset selected value to default
end

-- Connect to PlayerAdded and PlayerRemoving events to update the dropdown
Players.PlayerAdded:Connect(UpdateDropdown)
Players.PlayerRemoving:Connect(UpdateDropdown)

local ToggleTrapAll = Tabs.Troll:AddToggle("TrapAll", {Title = "Loop Trap Selected Player", Default = false })
local ToggleTrapSheriff = Tabs.Troll:AddToggle("TrapSheriff", {Title = "Loop Trap Sheriff", Default = false })
local ToggleTrapMurderer = Tabs.Troll:AddToggle("TrapMurderer", {Title = "Loop Trap Murderer", Default = false })

function placeTrapForPlayer(Player)
    local HumanoidRootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        pcall(function()
            PlaceTrap:InvokeServer(CFrame.new(HumanoidRootPart.Position))
        end)
    end
end

function ChangeLoopTrapPlayerFix()
    if ChangeLoopTarget == "All" then
        for _, v in pairs(Players:GetChildren()) do
            if v ~= LocalPlayer then
                placeTrapForPlayer(v)
            end
        end
    else
        local Target = Players:FindFirstChild(ChangeLoopTarget)
        if Target then
            placeTrapForPlayer(Target)
        end
    end
end

function ChangeLoopTrapSheriffFix()
    if Sheriff then
        local SheriffPlayer = Players:FindFirstChild(Sheriff)
        if SheriffPlayer then
            placeTrapForPlayer(SheriffPlayer)
        end
    end
end

function ChangeLoopTrapMurdererFix()
    if Murder then
        local MurderPlayer = Players:FindFirstChild(Murder)
        if MurderPlayer then
            placeTrapForPlayer(MurderPlayer)
        end
    end
end

ToggleTrapAll:OnChanged(function(Value)
    ChangeLoopTrapPlayer = Value

    spawn(function()
        while ChangeLoopTrapPlayer do
            pcall(ChangeLoopTrapPlayerFix)
            task.wait(0.1)  -- Reduce wait time for faster trap placement
        end
    end)
end)

ToggleTrapSheriff:OnChanged(function(Value)
    ChangeLoopTrapSheriff = Value

    spawn(function()
        while ChangeLoopTrapSheriff do
            pcall(ChangeLoopTrapSheriffFix)
            task.wait(0.1)  -- Reduce wait time for faster trap placement
        end
    end)
end)

ToggleTrapMurderer:OnChanged(function(Value)
    ChangeLoopTrapMurderer = Value

    spawn(function()
        while ChangeLoopTrapMurderer do
            pcall(ChangeLoopTrapMurdererFix)
            task.wait(0.1)  -- Reduce wait time for faster trap placement
        end
    end)
end)

Options.TrapAll:SetValue(false)
Options.TrapSheriff:SetValue(false)
Options.TrapMurderer:SetValue(false)

-- Start role updater in a separate thread
spawn(updateRoles)

Tabs.Troll:AddButton({
        Title = "Get Trap Tool",
        Description = "Give you trap tool that u can place anywhere you want loll",
        Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/TrapTool",true))()
end
    })

local ToggleAntiTrap = Tabs.Troll:AddToggle("AntiTrap", {Title = "Anti Trap", Default = false})

function AntiTrapFix()
    local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if Humanoid and Humanoid.WalkSpeed == 0.009999999776482582 then
        Humanoid.WalkSpeed = 16
    end
end

ToggleAntiTrap:OnChanged(function(Value)
    ChangeAntiTrap = Value

    spawn(function()
        while ChangeAntiTrap do
            pcall(AntiTrapFix)
            task.wait(0.1)  -- Check more frequently for traps
        end
    end)
end)

Options.AntiTrap:SetValue(false)
        
        
        Tabs.Troll:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })
        
        Tabs.Troll:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })
        
        Tabs.Troll:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })
------------------------------------------------------------------------------------TROLLING-----------------------------------------------------------------------------------
        
------------------------------------------------------------------------------------------SERVER-----------------------------------------------------------------------------------

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


----------------------------------------------------------------------------SERVER------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------AUTOFARM------------------------------------------------------------------------------------------------------
Tabs.AutoFarm:AddParagraph({
    Title = "IMPORTANT: PLEASE READ",
    Content = "Please be aware that prolonged use of this Autofarm may cause lag during extended gameplay. Additionally, do not toggle the 'Auto Teleport to Rare Eggs' option if the game has not started. because it search for nothing so thats why don't always toggle it."
})
local Toggle = Tabs.AutoFarm:AddToggle("RejoinKicked", {Title = "Rejoin on Kick", Default = false })

local connection -- Declare a variable to hold the connection

Toggle:OnChanged(function(value)
    if value then
        -- Connect to the ErrorMessageChanged event
        connection = game:GetService("GuiService").ErrorMessageChanged:Connect(function()
            wait(0.1)
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end)
    else
        -- Disconnect from the event if it was previously connected
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)

Options.RejoinKicked:SetValue(false)

local Toggle = Tabs.AutoFarm:AddToggle("AntiAFK", {Title = "Anti AFK", Default = false })

local antiAfkConnection -- Declare a variable to hold the connection for anti-AFK

Toggle:OnChanged(function(value)
    if value then
        -- Connect to the Idled event for anti-AFK
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local VirtualUser = game:GetService("VirtualUser")
        
        antiAfkConnection = LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    else
        -- Disconnect from the Idled event if it was previously connected
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
            antiAfkConnection = nil
        end
    end
end)

Options.AntiAFK:SetValue(false)

local moveSpeed = 50
-- Create a slider for teleport walk speed
local Slider = Tabs.AutoFarm:AddSlider("TweenSpeed", {
    Title = "Change AutoFarm Speed",
    Description = "NOTE: The higher the value can be kick faster.",
    Default = moveSpeed,
    Min = 20,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        moveSpeed = Value
    end
})

-- Ensure slider initial value is set correctly
Slider:SetValue(moveSpeed)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Movement parameters
  -- Adjusted move speed for faster movement
local arrivalThreshold = 1  -- Distance threshold to stop moving
local touchedCoins = {}  -- Table to track touched Coin_Server parts
local isAutoFarming = false  -- Flag to track if auto farming is enabled
local isMovingToCoin = false  -- Flag to track if currently moving towards a coin
local characterAddedConnection = nil  -- Variable to store the CharacterAdded connection
local characterRemovingConnection = nil  -- Variable to store the CharacterRemoving connection

-- Function to find the nearest untapped Coin_Server part
local function findNearestUntappedCoin()
    local nearestCoin = nil
    local nearestDistance = math.huge

    -- Check if player and player.Character are valid
    if player and player.Character and player.Character.HumanoidRootPart then
        local workspace = game:GetService("Workspace")
        local coinContainer = workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("CoinContainer")
        
        if coinContainer then
            local coins = coinContainer:GetChildren()

            -- Find the nearest "Coin_Server" part that hasn't been touched yet
            for i, coin in ipairs(coins) do
                if coin:IsA("Part") and coin.Name == "Coin_Server" and not touchedCoins[coin] then
                    local distance = (coin.Position - player.Character.HumanoidRootPart.Position).magnitude
                    if distance < nearestDistance then
                        nearestCoin = coin
                        nearestDistance = distance
                    end
                end
            end
        end
    end

    return nearestCoin
end

-- Function to move to the nearest untapped Coin_Server part with smooth transition
local function moveToCoinServer()
    -- Find the nearest untapped Coin_Server part
    local nearestCoin = findNearestUntappedCoin()

    if nearestCoin then
        print("Moving towards Coin or Eggs.")
        isMovingToCoin = true

        local targetPosition = nearestCoin.Position + Vector3.new(0, 0, 0)  -- Target slightly above the part

        -- Move the character towards the nearest untapped "Coin_Server" part gradually
        while isAutoFarming and isMovingToCoin do
            if not player.Character or not player.Character.HumanoidRootPart then
                isMovingToCoin = false  -- Stop moving if character or HumanoidRootPart is nil
                break
            end

            local currentPos = player.Character.HumanoidRootPart.Position
            local direction = (targetPosition - currentPos).unit
            local distanceToTarget = (targetPosition - currentPos).magnitude

            if distanceToTarget <= arrivalThreshold then
                print("Arrived at Coin or Eggs")
                isMovingToCoin = false
                break
            end

            -- Move towards the target
            player.Character.HumanoidRootPart.CFrame = CFrame.new(currentPos + direction * moveSpeed * RunService.Heartbeat:Wait())
        end

        -- Mark the coin as touched
        touchedCoins[nearestCoin] = true

        local delay = math.random(1.7, 2.1)
        wait(delay)

        -- Move to the next nearest untapped Coin_Server part if auto farming is enabled
        if isAutoFarming and not isMovingToCoin then
            -- Use coroutine to prevent blocking
            coroutine.wrap(moveToCoinServer)()
        end
    else
        print("Coin not found. Searching for Coin_Server...")
        wait(1)  -- Wait for a short period before searching again (customize as needed)

        -- If auto farming is enabled and not currently moving towards a coin, continue searching for the nearest coin
        if isAutoFarming and not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Function to teleport the player to the map with a delay
local function teleportToMapWithDelay(delay)
    wait(delay)
    local workspace = game:GetService("Workspace")
    local Workplace = workspace:GetChildren()
    
    for i, Thing in pairs(Workplace) do
        local ThingChildren = Thing:GetChildren()
        for i, Child in pairs(ThingChildren) do
            if Child.Name == "Spawns" then
                if player.Character and player.Character.HumanoidRootPart then
                    player.Character.HumanoidRootPart.CFrame = Child.Spawn.CFrame
                end
            end
        end
    end
end

-- Function to handle character added (when player respawns)
local function onCharacterAdded(character)
    player.Character = character
    touchedCoins = {}  -- Reset touchedCoins table when character resets
    isMovingToCoin = false  -- Reset moving to coin flag
    if isAutoFarming then
        -- Teleport to the map with a delay before starting auto farming again
        teleportToMapWithDelay(5)  -- Adjust the delay to 5 seconds as required
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Function to handle character removing (when player dies)
local function onCharacterRemoving()
    if isAutoFarming then
        print("Character removed. Stopping auto farming and teleporting to map...")
        isAutoFarming = false  -- Stop auto farming when character dies
        isMovingToCoin = false  -- Stop moving towards the coin
        teleportToMapWithDelay(5)  -- Teleport to map with a delay of 5 seconds
        isAutoFarming = true  -- Resume auto farming after teleporting (if toggle is still on)
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Example toggle integration
local Toggle = Tabs.AutoFarm:AddToggle("AutoFarmCoinEggs", {Title = "Auto Farm Coin and Eggs", Default = false })

Toggle:OnChanged(function(isEnabled)
    isAutoFarming = isEnabled
    if isAutoFarming then
        print("Auto Farm Coin enabled.")
        -- Connect the character added event handler only when auto farming is enabled
        characterAddedConnection = Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
        -- Connect the character removing event handler only when auto farming is enabled
        characterRemovingConnection = Players.LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving)
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    else
        
        isMovingToCoin = false  -- Stop moving towards the coin if auto farming is disabled
        -- Disconnect the character added event handler when auto farming is disabled
        if characterAddedConnection then
            characterAddedConnection:Disconnect()
            characterAddedConnection = nil
        end
        -- Disconnect the character removing event handler when auto farming is disabled
        if characterRemovingConnection then
            characterRemovingConnection:Disconnect()
            characterRemovingConnection = nil
        end
        -- Optionally, you could stop the character here
    end
end)

-- Listen for new coins spawning
local workspace = game:GetService("Workspace")
workspace.ChildAdded:Connect(function(child)
    if child:IsA("Part") and child.Name == "Coin_Server" and isAutoFarming and not isMovingToCoin then
        coroutine.wrap(moveToCoinServer)()
    end
end)


local function findNearestUntappedCoin()
    local nearestCoin = nil
    local nearestDistance = math.huge

    -- Check if player and player.Character are valid
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local normalContainer = game.Workspace:FindFirstChild("Normal")
        if normalContainer then
            local coinContainer = normalContainer:FindFirstChild("CoinContainer")
            if coinContainer then
                local coins = coinContainer:GetChildren()

                -- Find the nearest "Coin_Server" part that has "MainCoin" child and hasn't been touched yet
                for _, coinServer in ipairs(coins) do
                    if coinServer:IsA("Part") and coinServer.Name == "Coin_Server" then
                        local coinVisual = coinServer:FindFirstChild("CoinVisual")
                        if coinVisual and coinVisual:FindFirstChild("MainCoin") and not touchedCoins[coinVisual.MainCoin] then
                            local distance = (coinVisual.MainCoin.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            if distance < nearestDistance then
                                nearestCoin = coinVisual.MainCoin
                                nearestDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end

    return nearestCoin
end

-- Function to move to the nearest untapped Coin_Server part with smooth transition
local function moveToCoinServer()
    -- Find the nearest untapped Coin_Server part with MainCoin child
    local nearestCoin = findNearestUntappedCoin()

    if nearestCoin then
        print("Moving towards to Coin")
        isMovingToCoin = true

        local targetPosition = nearestCoin.Position

        -- Move the character towards the nearest untapped "Coin_Server" part gradually
        while isAutoFarming and isMovingToCoin do
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                isMovingToCoin = false  -- Stop moving if character or HumanoidRootPart is nil
                break
            end

            local currentPos = player.Character.HumanoidRootPart.Position
            local direction = (targetPosition - currentPos).Unit
            local distanceToTarget = (targetPosition - currentPos).Magnitude

            if distanceToTarget <= arrivalThreshold then
                print("Arrived at Coin")
                isMovingToCoin = false
                break
            end

            -- Move towards the target
            player.Character.HumanoidRootPart.CFrame = CFrame.new(currentPos + direction * moveSpeed * RunService.Heartbeat:Wait())
        end

        -- Mark the coin as touched
        touchedCoins[nearestCoin] = true

        local delay = math.random(1.7, 2.1)
        wait(delay)

        -- Move to the next nearest untapped Coin_Server part if auto farming is enabled
        if isAutoFarming and not isMovingToCoin then
            -- Use coroutine to prevent blocking
            coroutine.wrap(moveToCoinServer)()
        end
    else
        print("[ AshbornnHub ] Coin not Found.. Searching again...")
        wait(1)  -- Wait for a short period before searching again (customize as needed)

        -- If auto farming is enabled and not currently moving towards a coin, continue searching for the nearest coin
        if isAutoFarming and not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Function to teleport the player to the map with a delay
local function teleportToMapWithDelay(delay)
    wait(delay)
    local workspace = game:GetService("Workspace")
    local Workplace = workspace:GetChildren()
    
    for _, Thing in pairs(Workplace) do
        local ThingChildren = Thing:GetChildren()
        for _, Child in pairs(ThingChildren) do
            if Child.Name == "Spawns" then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = Child.Spawn.CFrame
                end
            end
        end
    end
end

-- Function to handle character added (when player respawns)
local function onCharacterAdded(character)
    player.Character = character
    touchedCoins = {}  -- Reset touchedCoins table when character resets
    isMovingToCoin = false  -- Reset moving to coin flag
    if isAutoFarming then
        -- Teleport to the map with a delay before starting auto farming again
        teleportToMapWithDelay(5)  -- Adjust the delay to 5 seconds as required
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Function to handle character removing (when player dies)
local function onCharacterRemoving()
    if isAutoFarming then
        print("Character removed. Stopping auto farming and teleporting to map...")
        isAutoFarming = false  -- Stop auto farming when character dies
        isMovingToCoin = false  -- Stop moving towards the coin
        teleportToMapWithDelay(5)  -- Teleport to map with a delay of 5 seconds
        isAutoFarming = true  -- Resume auto farming after teleporting (if toggle is still on)
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Example toggle integration
local Toggle = Tabs.AutoFarm:AddToggle("AutoFarmCoin", {Title = "Auto Farm Coin Only", Default = false })

Toggle:OnChanged(function(isEnabled)
    isAutoFarming = isEnabled
    if isAutoFarming then
        print("Auto Farm Coin enabled.")
Options.AutoFarmEggs:SetValue(false)
        -- Connect the character added event handler only when auto farming is enabled
        characterAddedConnection = Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
        -- Connect the character removing event handler only when auto farming is enabled
        characterRemovingConnection = Players.LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving)
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    else
        
        isMovingToCoin = false  -- Stop moving towards the coin if auto farming is disabled
        -- Disconnect the character added event handler when auto farming is disabled
        if characterAddedConnection then
            characterAddedConnection:Disconnect()
            characterAddedConnection = nil
        end
        -- Disconnect the character removing event handler when auto farming is disabled
        if characterRemovingConnection then
            characterRemovingConnection:Disconnect()
            characterRemovingConnection = nil
        end
        -- Optionally, you could stop the character here
    end
end)

-- Listen for new Coin_Server parts spawning
local workspace = game:GetService("Workspace")
workspace.ChildAdded:Connect(function(child)
    if child:IsA("Part") and child.Name == "Coin_Server" and child:FindFirstChild("CoinVisual") and child.CoinVisual:FindFirstChild("MainCoin") and isAutoFarming and not isMovingToCoin then
        coroutine.wrap(moveToCoinServer)()
    end
end)

-- Function to check if a part has TouchInterest and an empty CoinVisual
local function hasTouchInterestAndEmptyCoinVisual(part)
    if part:IsA("Part") then
        local touchInterest = part:FindFirstChild("TouchInterest")
        local coinVisual = part:FindFirstChild("CoinVisual")
        return touchInterest ~= nil and coinVisual ~= nil and #coinVisual:GetChildren() == 0
    end
    return false
end

-- Function to find the nearest untapped Coin_Server part with TouchInterest and empty CoinVisual
local function findNearestUntappedCoin()
    local nearestCoin = nil
    local nearestDistance = math.huge

    -- Check if player and player.Character are valid
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local normalContainer = game.Workspace:FindFirstChild("Normal")
        if normalContainer then
            local coinContainer = normalContainer:FindFirstChild("CoinContainer")
            if coinContainer then
                local coins = coinContainer:GetChildren()

                -- Find the nearest "Coin_Server" part with TouchInterest and empty CoinVisual
                for _, coinServer in ipairs(coins) do
                    if hasTouchInterestAndEmptyCoinVisual(coinServer) and not touchedCoins[coinServer] then
                        local distance = (coinServer.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance < nearestDistance then
                            nearestCoin = coinServer
                            nearestDistance = distance
                        end
                    end
                end
            end
        end
    end

    return nearestCoin
end

-- Function to move to the nearest untapped Coin_Server part with smooth transition
local function moveToCoinServer()
    -- Find the nearest untapped Coin_Server part with TouchInterest and empty CoinVisual
    local nearestCoin = findNearestUntappedCoin()

    if nearestCoin then
        print("Moving towards to the Eggs")
        isMovingToCoin = true

        local targetPosition = nearestCoin.Position

        -- Move the character towards the nearest untapped "Coin_Server" part gradually
        while isAutoFarming and isMovingToCoin do
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                isMovingToCoin = false  -- Stop moving if character or HumanoidRootPart is nil
                break
            end

            local currentPos = player.Character.HumanoidRootPart.Position
            local direction = (targetPosition - currentPos).Unit
            local distanceToTarget = (targetPosition - currentPos).Magnitude

            if distanceToTarget <= arrivalThreshold then
                print("Arrived at the Egg")
                isMovingToCoin = false
                break
            end

            -- Move towards the target
            player.Character.HumanoidRootPart.CFrame = CFrame.new(currentPos + direction * moveSpeed * RunService.Heartbeat:Wait())
        end

        -- Mark the coin as touched
        touchedCoins[nearestCoin] = true

        local delay = math.random(1.7, 2.1)
        wait(delay)

        -- Move to the next nearest untapped Coin_Server part if auto farming is enabled
        if isAutoFarming and not isMovingToCoin then
            -- Use coroutine to prevent blocking
            coroutine.wrap(moveToCoinServer)()
        end
    else
        print("[ AshbornnHub ] Searching for eggs..")
        wait(1)  -- Wait for a short period before searching again (customize as needed)

        -- If auto farming is enabled and not currently moving towards a coin, continue searching for the nearest coin
        if isAutoFarming and not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Function to teleport the player to the map with a delay
local function teleportToMapWithDelay(delay)
    wait(delay)
    local workspace = game:GetService("Workspace")
    local Workplace = workspace:GetChildren()
    
    for _, Thing in pairs(Workplace) do
        local ThingChildren = Thing:GetChildren()
        for _, Child in pairs(ThingChildren) do
            if Child.Name == "Spawns" then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = Child.Spawn.CFrame
                end
            end
        end
    end
end

-- Function to handle character added (when player respawns)
local function onCharacterAdded(character)
    player.Character = character
    touchedCoins = {}  -- Reset touchedCoins table when character resets
    isMovingToCoin = false  -- Reset moving to coin flag
    if isAutoFarming then
        -- Teleport to the map with a delay before starting auto farming again
        teleportToMapWithDelay(5)  -- Adjust the delay to 5 seconds as required
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Function to handle character removing (when player dies)
local function onCharacterRemoving()
    if isAutoFarming then
        print("Character removed. Stopping auto farming and teleporting to map...")
        isAutoFarming = false  -- Stop auto farming when character dies
        isMovingToCoin = false  -- Stop moving towards the coin
        teleportToMapWithDelay(5)  -- Teleport to map with a delay of 5 seconds
        isAutoFarming = true  -- Resume auto farming after teleporting (if toggle is still on)
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    end
end

-- Example toggle integration
local Toggle = Tabs.AutoFarm:AddToggle("AutoFarmEggs", {Title = "Auto Farm Eggs Only ", Default = false })

Toggle:OnChanged(function(isEnabled)
    isAutoFarming = isEnabled
    if isAutoFarming then
        print("Auto Farm Coin enabled.")
        Options.AutoFarmCoin:SetValue(false)
        -- Connect the character added event handler only when auto farming is enabled
        characterAddedConnection = Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
        -- Connect the character removing event handler only when auto farming is enabled
        characterRemovingConnection = Players.LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving)
        if not isMovingToCoin then
            coroutine.wrap(moveToCoinServer)()
        end
    else
        
        isMovingToCoin = false  -- Stop moving towards the coin if auto farming is disabled
        -- Disconnect the character added event handler when auto farming is disabled
        if characterAddedConnection then
            characterAddedConnection:Disconnect()
            characterAddedConnection = nil
        end
        -- Disconnect the character removing event handler when auto farming is disabled
        if characterRemovingConnection then
            characterRemovingConnection:Disconnect()
            characterRemovingConnection = nil
        end
        -- Optionally, you could stop the character here
    end
end)

-- Listen for new Coin_Server parts spawning
local workspace = game:GetService("Workspace")
workspace.ChildAdded:Connect(function(child)
    if child:IsA("Part") and child.Name == "Coin_Server" and isAutoFarming and not isMovingToCoin then
        coroutine.wrap(moveToCoinServer)()
    end
end)


-- Function to check if a part has TouchInterest, an empty CoinVisual, and ParticleEmitter
local function hasTouchInterestAndEmptyCoinVisualAndParticleEmitter(part)
    if part:IsA("Part") then
        local touchInterest = part:FindFirstChild("TouchInterest")
        local coinVisual = part:FindFirstChild("CoinVisual")
        local particleEmitter = part:FindFirstChild("ParticleEmitter")
        return touchInterest ~= nil and coinVisual ~= nil and #coinVisual:GetChildren() == 0 and particleEmitter ~= nil
    end
    return false
end




-- Table to keep track of touched rare eggs
local touchedRareEggs = {}

-- Function to check if a part has TouchInterest, empty CoinVisual, and ParticleEmitter
local function hasTouchInterestAndEmptyCoinVisualAndParticleEmitter(part)
    if part:IsA("Part") then
        local touchInterest = part:FindFirstChild("TouchInterest")
        local coinVisual = part:FindFirstChild("CoinVisual")
        local particleEmitter = part:FindFirstChild("ParticleEmitter")
        return touchInterest ~= nil and coinVisual ~= nil and #coinVisual:GetChildren() == 0 and particleEmitter ~= nil
    end
    return false
end

-- Function to find the nearest untapped Coin_Server part with TouchInterest, empty CoinVisual, and ParticleEmitter
local function findNearestUntappedCoin()
    local nearestCoin = nil
    local nearestDistance = math.huge

    -- Check if player and player.Character are valid
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local normalContainer = game.Workspace:FindFirstChild("Normal")
        if normalContainer then
            local coinContainer = normalContainer:FindFirstChild("CoinContainer")
            if coinContainer then
                local coins = coinContainer:GetChildren()

                -- Find the nearest "Coin_Server" part with TouchInterest, empty CoinVisual, and ParticleEmitter
                for _, coinServer in ipairs(coins) do
                    if hasTouchInterestAndEmptyCoinVisualAndParticleEmitter(coinServer) and not touchedRareEggs[coinServer] then
                        local distance = (coinServer.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance < nearestDistance then
                            nearestCoin = coinServer
                            nearestDistance = distance
                        end
                    end
                end
            end
        end
    end

    return nearestCoin
end

-- Define the teleportation function
local function teleportToNearestCoin()
    local player = game.Players.LocalPlayer

    if player.Character then
        local nearestCoin = findNearestUntappedCoin()
        if nearestCoin then
            local oldPos = player.Character.HumanoidRootPart.CFrame
            local startTime = tick()
            repeat
                player.Character.HumanoidRootPart.CFrame = nearestCoin.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
                task.wait()
                player.Character.HumanoidRootPart.CFrame = nearestCoin.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
                task.wait()
            until not nearestCoin:IsDescendantOf(workspace) or tick() - startTime >= 3
            player.Character.HumanoidRootPart.CFrame = oldPos
            player.Character.Humanoid:ChangeState(1)
            Fluent:Notify({
                Title = "Rare Egg Found",
                Content = "Successfully teleported to the rare egg.",
                Duration = 3
            })
            -- Mark the coin as touched
            touchedRareEggs[nearestCoin] = true
            return true
        else
            print("[ AshbornnHub ] Rare Egg Not Found.. Searching again....")
            return false
        end
    end
end

-- Coroutine handle for the auto teleportation loop
local teleportCoroutine
local isTeleporting = false

-- Example button integration
Tabs.AutoFarm:AddButton({
    Title = "Teleport to Rare Egg",
    Description = "Teleport to the nearest rare egg if available",
    Callback = teleportToNearestCoin
})

-- Toggle to automatically teleport to rare egg on spawn
local Toggle = Tabs.AutoFarm:AddToggle("TPtoRareEgg", {Title = "Auto Teleport to Rare eggs on spawn", Default = false })

Toggle:OnChanged(function(state)
    if state then
        if not isTeleporting then
            isTeleporting = true
            teleportCoroutine = coroutine.create(function()
                while isTeleporting do
                    local found = teleportToNearestCoin()
                    if found then
                        isTeleporting = false
                          -- Reset the toggle to off after teleportation
                    else
                        task.wait(2)  -- Wait for 2 seconds before searching again
                    end
                end
            end)
            coroutine.resume(teleportCoroutine)
        end
    else
        isTeleporting = false
    end
end)


Options.TPtoRareEgg:SetValue(false)  -- Ensure the toggle starts off
Tabs.AutoFarm:AddParagraph({
            Title = "Scrolling Only",
            Content = "Ignore this is just for scrolling"
        })
        Tabs.AutoFarm:AddParagraph({
            Title = "Scrolling Only",
            Content = "Ignore this is just for scrolling"
        })
        Tabs.AutoFarm:AddParagraph({
            Title = "Scrolling Only",
            Content = "Ignore this is just for scrolling"
        })
        


---------------------------------------------------------------------------------AUTOFARM------------------------------------------------------------------------------------------------

------------------------------------------------------------------------EMOTES---------------------------------------------------------------------------------------------
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







----------------------------------------------------------------------EMOTES-------------------------------------------------------------------------------------------------

--------------------------------------------------------------------BUTTONS------------------------------------------------------------------------------------------------

Tabs.Buttons:AddParagraph({
            Title = "READ ME",
            Content = "To adjust the position of Buttons you can drag it at the side of UI. Also if you want to save your config you can use the Settings and Goto Configuration Add Config Name and Save it and Auto Load if You want."
        })
    
    
    local ButtonsC = Tabs.Buttons:AddSection("Button Customize")
    local TColorpicker = Tabs.Buttons:AddColorpicker("TransparencyColorpicker", {
        Title = "Customize Buttons",
        Description = "Customize its Color and Transparency",
        Transparency = 0,
        Default = Color3.fromRGB(0, 0, 0)
    })
    
    local InputHeight = Tabs.Buttons:AddInput("InputHeight", {
        Title = "Change Button Size (Height)",
        Default = 75,
        Placeholder = "Height",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            print("Button Size Height changed to:", Value)
        end
    })
    local InputWidth = Tabs.Buttons:AddInput("InputWidth", {
        Title = "Change Button Size (Width)",
        Default = 100,
        Placeholder = "Width",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            print("Button size Width changed to:", Value)
        end
    })
    local InputTSize = Tabs.Buttons:AddInput("InputTSize", {
        Title = "Change Button Text Size",
        Default = 8,
        Placeholder = "Text Size",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            print("Button Text Size changed to:", Value)
        end
    })
    
    local LockFrames = false
-- Define the toggle and its initial state
local Toggle = Tabs.Buttons:AddToggle("LockPos", {Title = "Lock All Frames Position", Default = false })

Toggle:OnChanged(function(value)
    LockFrames = value
end)
   
   
    local ButtonsS = Tabs.Buttons:AddSection("Button Shortcuts")

-- Assuming you have a UI library providing Toggle functionality
local Toggle = Tabs.Buttons:AddToggle("FEInviButtonPerk", {Title = "FE invisible Button + Invisible(Need Ghost Perk) ", Default = false})

-- Constants for file handling
local SAVED_POSITION_FILE = "AshbornnHub/MM2/PerkFEInviButtPos.json"

-- Variable to hold the ScreenGui and its position
local screenGui
local savedPosition = UDim2.new(0.5, -0.5, 0.5, -37.5)  -- Default position

-- Function to save the position to file
function savePositionA()
    if screenGui then
        local positionData = {
            X = savedPosition.X.Scale,
            XOffset = savedPosition.X.Offset,
            Y = savedPosition.Y.Scale,
            YOffset = savedPosition.Y.Offset
        }
        local success, error = pcall(function()
            writefile(SAVED_POSITION_FILE, game:GetService("HttpService"):JSONEncode(positionData))
        end)
        if not success then
            warn("Failed to save position:", error)
        end
    end
end

-- Function to load the position from file
local function loadPositionA()
    local positionData = nil
    local success, data = pcall(function()
        return readfile(SAVED_POSITION_FILE)
    end)
    if success then
        positionData = game:GetService("HttpService"):JSONDecode(data)
    end
    if positionData then
        savedPosition = UDim2.new(positionData.X, positionData.XOffset, positionData.Y, positionData.YOffset)
    end
end

-- Attempt to load the saved position
loadPositionA()

-- Function to create the GUI
function createGuiA()
    -- Create a ScreenGui
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create a Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Smaller size
    frame.Position = savedPosition  -- Use saved position
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = TColorpicker.Transparency 
    frame.BackgroundColor3 = TColorpicker.Value -- Black background
    frame.Parent = screenGui

    -- Add UICorner to Frame
    local uiCornerFrame = Instance.new("UICorner")
    uiCornerFrame.CornerRadius = UDim.new(0, 15)
    uiCornerFrame.Parent = frame

    -- Create a Button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 160, 0, 40) -- Adjusted size for longer text
    button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.BackgroundTransparency = 1 -- Remove background color
    button.Text = "(Ghost Perk) +\nFE Invisible is"
    button.TextSize = InputTSize.Value
    button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
    button.Parent = frame

    -- Function to toggle button text based on Options.FEInvisible value
    local function toggleButtonText()
        if Options.FEInvisible.Value then
            button.Text = "(Ghost Perk) +\nFE Invisible is [ON]"
            game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(true)
        else
            button.Text = "(Ghost Perk) +\nFE Invisible is [OFF]"
            game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(false)
        end
    end

    -- Connect the button click event to the toggle function
    button.MouseButton1Click:Connect(function()
        Options.FEInvisible:SetValue(not Options.FEInvisible.Value)
        toggleButtonText()
    end)

    -- Make the Frame draggable
    

    local dragging, dragInput, dragStart, startPos

     function updateA(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        savedPosition = frame.Position  -- Save the updated position
    end

    frame.InputBegan:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                -- Save position when drag ends
                savePositionA()
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not LockFrames and input == dragInput and dragging then
        updateA(input)
    end
end)

    -- Update button text based on Options.FEInvisible initial value
    toggleButtonText()
end

-- Function to handle GUI creation and destruction
local function handleToggle(value)
    if value then
        -- Create and show the GUI
        createGuiA()
    else
        -- Destroy the GUI
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
            -- Save position when GUI is closed
            savePositionA()
        end
    end
end

-- Handle the toggle state change
Toggle:OnChanged(handleToggle)

-- Set the initial state of the toggle
Options.FEInvisible:SetValue(false)
Options.Invisible:SetValue(false)

-- Ensure the GUI persists across respawns
local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        createGuiA()
    end
end)



-- Assuming you have a UI library providing Toggle functionality
local Toggle = Tabs.Buttons:AddToggle("FEInviButton", {Title = "FE Invisible Button Only", Default = false})

-- Constants for file handling
local SAVED_POSITION_FILE = "AshbornnHub/MM2/FEInviButPos.json"

-- Variable to hold the ScreenGui and its position
local screenGui
local savedPosition = UDim2.new(0.5, -0.5, 0.5, -37.5)  -- Default position

-- Function to save the position to file
function savePositionB()
    if screenGui then
        local positionData = {
            X = savedPosition.X.Scale,
            XOffset = savedPosition.X.Offset,
            Y = savedPosition.Y.Scale,
            YOffset = savedPosition.Y.Offset
        }
        local success, error = pcall(function()
            writefile(SAVED_POSITION_FILE, game:GetService("HttpService"):JSONEncode(positionData))
        end)
        if not success then
            warn("Failed to save position:", error)
        end
    end
end

-- Function to load the position from file
function loadPositionB()
    local positionData = nil
    local success, data = pcall(function()
        return readfile(SAVED_POSITION_FILE)
    end)
    if success then
        positionData = game:GetService("HttpService"):JSONDecode(data)
    end
    if positionData then
        savedPosition = UDim2.new(positionData.X, positionData.XOffset, positionData.Y, positionData.YOffset)
    end
end

-- Attempt to load the saved position
loadPositionB()

-- Function to create the GUI
 function createGuiB()
    -- Create a ScreenGui
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create a Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Smaller size
    frame.Position = savedPosition  -- Use saved position
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = TColorpicker.Transparency
    frame.BackgroundColor3 = TColorpicker.Value
    frame.Parent = screenGui

    -- Add UICorner to Frame
    local uiCornerFrame = Instance.new("UICorner")
    uiCornerFrame.CornerRadius = UDim.new(0, 15)
    uiCornerFrame.Parent = frame

    -- Create a Button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 160, 0, 40) -- Adjusted size for longer text
    button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.BackgroundTransparency = 1 -- Remove background color
    button.Text = "FE Invisible is [OFF]"
    button.TextSize = InputTSize.Value
    button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
    button.Parent = frame

    -- Function to toggle button text based on Options.FEInvisible value
    local function toggleButtonText()
        if Options.FEInvisible.Value then
            button.Text = "FE Invisible is [ON]"
        else
            button.Text = "FE Invisible is [OFF]"
        end
    end

    -- Connect the button click event to the toggle function
    button.MouseButton1Click:Connect(function()
        Options.FEInvisible:SetValue(not Options.FEInvisible.Value)
        toggleButtonText()
    end)

    -- Make the Frame draggable
    

    local dragging, dragInput, dragStart, startPos

     function updateB(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        savedPosition = frame.Position  -- Save the updated position
    end

    frame.InputBegan:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                -- Save position when drag ends
                savePositionB()
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not LockFrames and input == dragInput and dragging then
        updateB(input)
    end
end)

    -- Update button text based on Options.FEInvisible initial value
    toggleButtonText()
end

-- Function to handle GUI creation and destruction
local function handleToggle(value)
    if value then
        -- Create and show the GUI
        createGuiB()
    else
        -- Destroy the GUI
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
            -- Save position when GUI is closed
            savePositionB()
        end
    end
end

-- Handle the toggle state change
Toggle:OnChanged(handleToggle)

-- Set the initial state of the toggle
Options.FEInvisible:SetValue(false)

-- Ensure the GUI persists across respawns
local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        createGuiB()
    end
end)


-- Assuming you have a UI library providing Toggle functionality
local Toggle = Tabs.Buttons:AddToggle("InviButton", {Title = "Invisible Button (Need Ghost Perk)", Default = false})

-- Constants for file handling
local SAVED_POSITION_FILE = "AshbornnHub/MM2/InviButPos.json"

-- Variable to hold the ScreenGui and its position
local screenGui
local savedPosition = UDim2.new(0.5, 100, 0.5, 37.5)  -- Default position

-- Function to save the position to file
function savePositionQ()
    if screenGui then
        local positionData = {
            X = savedPosition.X.Scale,
            XOffset = savedPosition.X.Offset,
            Y = savedPosition.Y.Scale,
            YOffset = savedPosition.Y.Offset
        }
        local success, error = pcall(function()
            writefile(SAVED_POSITION_FILE, game:GetService("HttpService"):JSONEncode(positionData))
        end)
        if not success then
            warn("Failed to save position:", error)
        end
    end
end

-- Function to load the position from file
function loadPositionQ()
    local positionData = nil
    local success, data = pcall(function()
        return readfile(SAVED_POSITION_FILE)
    end)
    if success then
        positionData = game:GetService("HttpService"):JSONDecode(data)
    end
    if positionData then
        savedPosition = UDim2.new(positionData.X, positionData.XOffset, positionData.Y, positionData.YOffset)
    end
end

-- Attempt to load the saved position
loadPositionQ()

-- Function to create the GUI
 function createGuiQ()
    -- Create a ScreenGui
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create a Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Smaller size
    frame.Position = savedPosition  -- Use saved position
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = TColorpicker.Transparency
    frame.BackgroundColor3 = TColorpicker.Value
    frame.Parent = screenGui

    -- Add UICorner to Frame
    local uiCornerFrame = Instance.new("UICorner")
    uiCornerFrame.CornerRadius = UDim.new(0, 15)
    uiCornerFrame.Parent = frame

    -- Create a Button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 0, 40) -- Smaller size
    button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.BackgroundTransparency = 1 -- Remove background color
    button.Text = "Invisible is"
    button.TextSize = InputTSize.Value
    button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
    button.Parent = frame

    -- Function to toggle button text based on Options.Invisible value
    local function toggleButtonText()
        if Options.Invisible.Value then
            button.Text = "Invisible is [ON]"
            game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(true)
        else
            button.Text = "Invisible is [OFF]"
            game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(false)
        end
    end

    -- Connect the button click event to the toggle function
    button.MouseButton1Click:Connect(function()
        Options.Invisible:SetValue(not Options.Invisible.Value)
        toggleButtonText()
    end)

    -- Make the Frame draggable
    

    local dragging, dragInput, dragStart, startPos

     function updateQ(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        savedPosition = frame.Position  -- Save the updated position
    end

    frame.InputBegan:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                -- Save position when drag ends
                savePositionQ()
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not LockFrames and input == dragInput and dragging then
        updateQ(input)
    end
end)

    -- Update button text based on Options.Invisible initial value
    toggleButtonText()
end

-- Function to handle GUI creation and destruction
local function handleToggle(value)
    if value then
        -- Create and show the GUI
        createGuiQ()
    else
        -- Destroy the GUI
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
            -- Save position when GUI is closed
            savePositionQ()
        end
    end
end

-- Handle the toggle state change
Toggle:OnChanged(handleToggle)

-- Set the initial state of the toggle
Options.Invisible:SetValue(false)

-- Ensure the GUI persists across respawns
local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        createGuiQ()
    end
end)


-- Assuming you have a UI library providing Toggle functionality
local Toggle = Tabs.Buttons:AddToggle("Togglename", {Title = "Silent Aim Button", Default = false})

-- Constants for file handling
local SAVED_POSITION_FILE = "AshbornnHub/MM2/SilentAimPos.json"

-- Function to call when button is clicked
local function onButtonClicked()
    -- Define the murderer character
    if Murder then
        local Player = game.Players.LocalPlayer
        local murdererCharacter = game.Players[Murder].Character
        
        if murdererCharacter and murdererCharacter:FindFirstChild("HumanoidRootPart") then
            if Player.Character:FindFirstChild("Gun") then
                Player.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, murdererCharacter.HumanoidRootPart.Position, "AH")
            else
                -- Player doesn't have a gun, show notification
                Fluent:Notify({
                    Title = "You don't have a gun",
                    Content = "Wait for the sheriff death or grab the gun",
                    Duration = 3
                })
            end
        else
            warn("Murderer character or HumanoidRootPart not found!")
        end
    else
        warn("Murderer not defined!")
    end
end

-- Variable to hold the ScreenGui and its position
local screenGui
local savedPosition = UDim2.new(0.5, -75, 0.5, -37.5)  -- Default position

-- Function to save the position to file
function savePositionC()
    if screenGui then
        local positionData = {
            X = savedPosition.X.Scale,
            XOffset = savedPosition.X.Offset,
            Y = savedPosition.Y.Scale,
            YOffset = savedPosition.Y.Offset
        }
        local success, error = pcall(function()
            writefile(SAVED_POSITION_FILE, game:GetService("HttpService"):JSONEncode(positionData))
        end)
        if not success then
            warn("Failed to save position:", error)
        end
    end
end

-- Function to load the position from file
function loadPositionC()
    local positionData = nil
    local success, data = pcall(function()
        return readfile(SAVED_POSITION_FILE)
    end)
    if success then
        positionData = game:GetService("HttpService"):JSONDecode(data)
    end
    if positionData then
        savedPosition = UDim2.new(positionData.X, positionData.XOffset, positionData.Y, positionData.YOffset)
    end
end

-- Attempt to load the saved position
loadPositionC()

-- Function to create the GUI
 function createGuiC()
    -- Create a ScreenGui
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create a Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Smaller size
    frame.Position = savedPosition  -- Use saved position
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = TColorpicker.Transparency
    frame.BackgroundColor3 = TColorpicker.Value
    frame.Parent = screenGui

    -- Add UICorner to Frame
    local uiCornerFrame = Instance.new("UICorner")
    uiCornerFrame.CornerRadius = UDim.new(0, 15)
    uiCornerFrame.Parent = frame

    -- Create a Button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 0, 40) -- Smaller size
    button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.BackgroundTransparency = 1 -- Remove background color
    button.Text = "Shoot"
    button.TextSize = InputTSize.Value
    button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
    button.Parent = frame

    -- Connect the button click event to the function
    button.MouseButton1Click:Connect(onButtonClicked)

    -- Make the Frame draggable
    

    local dragging, dragInput, dragStart, startPos

     function updateC(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        savedPosition = frame.Position  -- Save the updated position
    end

    frame.InputBegan:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                -- Save position when drag ends
                savePositionC()
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not LockFrames and input == dragInput and dragging then
        updateC(input)
    end
end)
end

-- Function to handle GUI creation and destruction
local function handleToggle(value)
    if value then
        -- Create and show the GUI
        createGuiC()
    else
        -- Destroy the GUI
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
            -- Save position when GUI is closed
            savePositionC()
        end
    end
end

-- Handle the toggle state change
Toggle:OnChanged(handleToggle)

-- Set the initial state of the toggle
Options.Togglename:SetValue(false)

-- Ensure the GUI persists across respawns
local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        createGuiC()
    end
end)



-- Create the toggle
local Toggle = Tabs.Buttons:AddToggle("GrabButton", {Title = "Grab Gun Button", Default = false })

-- Constants for file handling
local SAVED_POSITION_FILE = "AshbornnHub/MM2/GrabGunButtonPos.json"

-- Create a ScreenGui
local screenGui
local savedPosition = UDim2.new(0.5, 75, 0.5, -37.5)  -- Default position

-- Function to save the position to file
function savePositionD()
    if screenGui then
        local positionData = {
            X = savedPosition.X.Scale,
            XOffset = savedPosition.X.Offset,
            Y = savedPosition.Y.Scale,
            YOffset = savedPosition.Y.Offset
        }
        local success, error = pcall(function()
            writefile(SAVED_POSITION_FILE, game:GetService("HttpService"):JSONEncode(positionData))
        end)
        if not success then
            warn("Failed to save position:", error)
        end
    end
end

-- Function to load the position from file
local function loadPositionD()
    local positionData = nil
    local success, data = pcall(function()
        return readfile(SAVED_POSITION_FILE)
    end)
    if success then
        positionData = game:GetService("HttpService"):JSONDecode(data)
    end
    if positionData then
        savedPosition = UDim2.new(positionData.X, positionData.XOffset, positionData.Y, positionData.YOffset)
    end
end

-- Attempt to load the saved position
loadPositionD()

-- Function to create or destroy the GUI based on toggle state
local function toggleGui(value)
    if value then
        -- Create the GUI
        screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        -- Create the Frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Smaller size
        frame.Position = savedPosition  -- Use saved position
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BackgroundColor3 = TColorpicker.Value
        frame.Parent = screenGui
        frame.BackgroundTransparency = TColorpicker.Transparency

        -- Add UICorner to Frame
        local uiCornerFrame = Instance.new("UICorner")
        uiCornerFrame.CornerRadius = UDim.new(0, 15)
        uiCornerFrame.Parent = frame

        -- Create the Button
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 80, 0, 40) -- Smaller size
        button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.BackgroundTransparency = 1 -- Remove background color
        button.Text = "Grab Gun"
        button.TextSize = InputTSize.Value
        button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
        button.Parent = frame

        -- Function to update the button text based on gun availability
        local function updateButtonText()
            local gunReady = workspace:FindFirstChild("GunDrop")
            if gunReady then
                button.Text = "Grab Gun (Ready)"
            else
                button.Text = "Grab Gun"
            end
        end

        -- Connect the function to update the button text
        workspace.ChildAdded:Connect(updateButtonText)
        workspace.ChildRemoved:Connect(updateButtonText)

        -- Function to handle the button click event
        button.MouseButton1Click:Connect(function()
            local Player = game.Players.LocalPlayer
            
            if not IsAlive(Player) then
                Fluent:Notify({
                    Title = "You're not alive",
                    Content = "Please wait for the new round to grab the gun.",
                    Duration = 3
                })
                return
            end
            
            if Player.Backpack:FindFirstChild("Gun") or (Player.Character and Player.Character:FindFirstChild("Gun")) then
                Fluent:Notify({
                    Title = "You already have a gun",
                    Content = "Lollll.",
                    Duration = 3
                })
                return
            end
            
            if Player.Character then
                local gundr = workspace:FindFirstChild("GunDrop")
                if gundr then
                    local oldpos = Player.Character.HumanoidRootPart.CFrame
                    repeat
                        Player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
                        task.wait()
                        Player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
                        task.wait()
                    until not gundr:IsDescendantOf(workspace)
                    Player.Character.HumanoidRootPart.CFrame = oldpos
                    oldpos = false
                    Player.Character.Humanoid:ChangeState(1)
                    button.Text = "Grab Gun (Gotcha)"
                else
                    Fluent:Notify({
                        Title = "Gun not Found",
                        Content = "Wait for the Sheriff's death to grab the gun.",
                        Duration = 3
                    })
                end
            end
        end)

        -- Function to handle GUI drag on mobile
        

        local dragging, dragInput, dragStart, startPos

        function updateD(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            savedPosition = frame.Position  -- Save the updated position
        end

        frame.InputBegan:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                -- Save position when drag ends
                savePositionD()
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not LockFrames and input == dragInput and dragging then
        updateD(input)
    end
end)

    else
        -- Destroy the GUI if it exists
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
            savePositionD()  -- Save position when GUI is closed
        end
    end
end

-- Connect the toggle's OnChanged event to the function
Toggle:OnChanged(toggleGui)

-- Set the initial state of the toggle
Options.GrabButton:SetValue(false)

-- Ensure the GUI persists across respawns and retains its position
local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        toggleGui(true)
    end
end)


-- Create the toggle
local Toggle = Tabs.Buttons:AddToggle("ShootMurd", {Title = "TP Shoot Murd", Default = false })

-- Constants for file handling
local SAVED_POSITION_FILE = "AshbornnHub/MM2/ShootMurdButtonPos.json"

-- Create a ScreenGui
local screenGui
local savedPosition = UDim2.new(0.5, 75, 0.5, 37)  -- Default position

-- Function to save the position to file
function savePositionE()
    if screenGui then
        local positionData = {
            X = savedPosition.X.Scale,
            XOffset = savedPosition.X.Offset,
            Y = savedPosition.Y.Scale,
            YOffset = savedPosition.Y.Offset
        }
        local success, error = pcall(function()
            writefile(SAVED_POSITION_FILE, game:GetService("HttpService"):JSONEncode(positionData))
        end)
        if not success then
            warn("Failed to save position:", error)
        end
    end
end

-- Function to load the position from file
function loadPositionE()
    local positionData = nil
    local success, data = pcall(function()
        return readfile(SAVED_POSITION_FILE)
    end)
    if success then
        positionData = game:GetService("HttpService"):JSONDecode(data)
    end
    if positionData then
        savedPosition = UDim2.new(positionData.X, positionData.XOffset, positionData.Y, positionData.YOffset)
    end
end

-- Attempt to load the saved position
loadPositionE()

-- Function to create or destroy the GUI based on toggle state
local function toggleGui(value)
    if value then
        -- Create the GUI
        screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        -- Create the Frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Smaller size
        frame.Position = savedPosition  -- Use saved position
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BackgroundColor3 = TColorpicker.Value
        frame.Parent = screenGui
        frame.BackgroundTransparency = TColorpicker.Transparency

        -- Add UICorner to Frame
        local uiCornerFrame = Instance.new("UICorner")
        uiCornerFrame.CornerRadius = UDim.new(0, 15)
        uiCornerFrame.Parent = frame

        -- Create the Button
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 80, 0, 40) -- Smaller size
        button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.BackgroundTransparency = 1 -- Remove background color
        button.Text = "TP Shoot Murd"
        button.TextSize = InputTSize.Value
        button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
        button.Parent = frame

        -- Function to handle the button click event
        button.MouseButton1Click:Connect(function()
            local Player = game.Players.LocalPlayer
            local humanoidRootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end

            local currentPosition = humanoidRootPart.CFrame

            if Murder then
                local murdererCharacter = game.Players[Murder] and game.Players[Murder].Character

                -- Check if the murderer is in the owner user IDs table
                if murdererCharacter and ownerUserIds[game.Players[Murder].UserId] then
                    Fluent:Notify({
                        Title = "You're trying to kill the script owner",
                        Content = "Nuhh uhh",
                        SubContent = "Im here kid", -- Optional
                        Duration = 3 -- Set to nil to make the notification not disappear
                    })
                    return
                end

                if murdererCharacter and murdererCharacter:FindFirstChild("HumanoidRootPart") then
                    local murdererPosition = murdererCharacter.HumanoidRootPart.CFrame

                    -- Check if the Player has a gun in their backpack or equipped
                    local backpack = Player:FindFirstChild("Backpack")
                    local gun = backpack and (backpack:FindFirstChild("Gun") or Player.Character:FindFirstChild("Gun"))

                    if gun then
                        -- Equip the gun if not already equipped
                        if backpack:FindFirstChild("Gun") then
                            backpack.Gun.Parent = Player.Character
                        end

                        -- Teleport to the murderer
                        humanoidRootPart.CFrame = murdererPosition

                        -- Shoot the gun at the murderer's position
                        if Player.Character:FindFirstChild("Gun") then
                            wait(0.2)
                            Player.Character:MoveTo(currentPosition.Position)
                            Player.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, murdererCharacter.HumanoidRootPart.Position, "AH")
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
        end)

        -- Function to handle GUI drag on mobile
        

        local dragging, dragInput, dragStart, startPos

        local function updateE(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            savedPosition = frame.Position  -- Save the updated position
        end

        frame.InputBegan:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                -- Save position when drag ends
                savePositionE()
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not LockFrames and input == dragInput and dragging then
        updateE(input)
    end
end)

    else
        -- Destroy the GUI if it exists
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
            savePositionE()  -- Save position when GUI is closed
        end
    end
end

-- Connect the toggle's OnChanged event to the function
Toggle:OnChanged(toggleGui)

-- Set the initial state of the toggle
Options.ShootMurd:SetValue(false)

-- Ensure the GUI persists across respawns and retains its position
local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        toggleGui(true)
    end
end)



-- Create the toggle
local Toggle = Tabs.Buttons:AddToggle("StabSheriff", {Title = "TP Stab Sheriff/Hero", Default = false })

-- Constants for file handling
local SAVED_POSITION_FILE = "AshbornnHub/MM2/StabSheriffButtonPos.json"

-- Create a ScreenGui
local screenGui
local savedPosition = UDim2.new(0.5, 75, 0.5, 37)  -- Default position

-- Function to save the position to file
local function savePositionF()
    if screenGui then
        local positionData = {
            X = savedPosition.X.Scale,
            XOffset = savedPosition.X.Offset,
            Y = savedPosition.Y.Scale,
            YOffset = savedPosition.Y.Offset
        }
        local success, error = pcall(function()
            writefile(SAVED_POSITION_FILE, game:GetService("HttpService"):JSONEncode(positionData))
        end)
        if not success then
            warn("Failed to save position:", error)
        end
    end
end

-- Function to load the position from file
local function loadPositionF()
    local positionData = nil
    local success, data = pcall(function()
        return readfile(SAVED_POSITION_FILE)
    end)
    if success then
        positionData = game:GetService("HttpService"):JSONDecode(data)
    end
    if positionData then
        savedPosition = UDim2.new(positionData.X, positionData.XOffset, positionData.Y, positionData.YOffset)
    end
end

-- Attempt to load the saved position
loadPositionF()

-- Function to create or destroy the GUI based on toggle state
local function toggleGui(value)
    if value then
        -- Create the GUI
        screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        -- Create the Frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Smaller size
        frame.Position = savedPosition  -- Use saved position
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BackgroundTransparency = TColorpicker.Transparency
        frame.BackgroundColor3 = TColorpicker.Value
        frame.Parent = screenGui

        -- Add UICorner to Frame
        local uiCornerFrame = Instance.new("UICorner")
        uiCornerFrame.CornerRadius = UDim.new(0, 15)
        uiCornerFrame.Parent = frame

        -- Create the Button
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 80, 0, 40) -- Smaller size
        button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.BackgroundTransparency = 1 -- Remove background color
        button.Text = "TP Stab Sheriff/Hero"
        button.TextSize = InputTSize.Value
        button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
        button.Parent = frame

        -- Function to handle the button click event
        button.MouseButton1Click:Connect(function()
            local Player = game.Players.LocalPlayer
            local character = Player.Character
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

            -- Check if the Player has a knife
            local backpack = Player.Backpack
            if not (backpack:FindFirstChild("Knife") or character:FindFirstChild("Knife")) then
                Fluent:Notify({
                    Title = "You are not Murderer",
                    Content = "Bruh will not work if you're not Murderer",
                    Duration = 3
                })
                return
            end

            local targetPlayer = getTargetPlayer()

            if targetPlayer then
                -- Check if the target Player is in the owner user IDs table
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
                        else
                            warn("Stab function is nil or not defined")
                        end
                        firetouchinterest(humanoidRootPart, targetCharacter.HumanoidRootPart, 1)
                        firetouchinterest(humanoidRootPart, targetCharacter.HumanoidRootPart, 0)

                        -- Force teleport to original position
                        humanoidRootPart.CFrame = CFrame.new(currentPosition)
                    else
                        warn("Knife not found in character after equipping")
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
        end)

        -- Function to handle GUI drag on mobile
        local dragging, dragInput, dragStart, startPos

        local function updateF(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            savedPosition = frame.Position  -- Save the updated position
        end

        frame.InputBegan:Connect(function(input)
            if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        -- Save position when drag ends
                        savePositionF()
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if not LockFrames and input == dragInput and dragging then
                updateF(input)
            end
        end)
    else
        -- Destroy the GUI if it exists
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
            savePositionF()  -- Save position when GUI is closed
        end
    end
end

-- Connect the toggle's OnChanged event to the function
Toggle:OnChanged(toggleGui)

-- Set the initial state of the toggle
Options.StabSheriff:SetValue(false)

-- Ensure the GUI persists across respawns and retains its position
local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        wait(1)  -- Delay to ensure the character is fully loaded
        toggleGui(true)
    end
end)


local SheriffHacks = Tabs.Buttons:AddSection("Speed Hacks")

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local normalWalkSpeed = 16
local tpWalkSpeed = 3  -- Initial speed value
local tpwalking = false

-- Create a toggle button in the GUI
local Toggle = Tabs.Buttons:AddToggle("HoldTpWalk", {Title = "Hold to Speed", default = false})

-- Create a slider for teleport walk speed
local Slider = Tabs.Buttons:AddSlider("TpWalkSpeed", {
    Title = "Speed",
    Description = "Hold to Speed Slider",
    Default = tpWalkSpeed,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        tpWalkSpeed = Value
    end
})

-- Ensure slider initial value is set correctly
Slider:SetValue(tpWalkSpeed)

-- Define the file path for saving the position
local filePath = "AshbornnHub/MM2/HoldSpeedPos.json"

-- Function to read JSON from a file
local function readJsonFile(filePath)
    if isfile(filePath) then
        local content = readfile(filePath)
        return game:GetService("HttpService"):JSONDecode(content)
    end
    return nil
end

-- Function to write JSON to a file
local function writeJsonFile(filePath, data)
    local json = game:GetService("HttpService"):JSONEncode(data)
    writefile(filePath, json)
end

-- Load the saved position from the JSON file
local savedData = readJsonFile(filePath)
local savedPosition = UDim2.new(0.5, 75, 0.5, 37)  -- Default position

if savedData and savedData.x and savedData.y then
    savedPosition = UDim2.new(savedData.scaleX, savedData.x, savedData.scaleY, savedData.y)
end

-- Create a ScreenGui
local screenGui

-- Function to create or destroy the GUI based on toggle state
local function toggleGui(value)
    if value then
        -- Create the GUI
        screenGui = Instance.new("ScreenGui")
        screenGui.Parent = Player:WaitForChild("PlayerGui")

        -- Create the Frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, InputWidth.Value, 0, InputHeight.Value) -- Use the InputWidth and InputHeight values
        frame.Position = savedPosition  -- Use saved position
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BackgroundTransparency = TColorpicker.Transparency
        frame.BackgroundColor3 = TColorpicker.Value
        frame.Parent = screenGui

        -- Add UICorner to Frame
        local uiCornerFrame = Instance.new("UICorner")
        uiCornerFrame.CornerRadius = UDim.new(0, 15)
        uiCornerFrame.Parent = frame

        -- Create the Button
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 80, 0, 40) -- Smaller size
        button.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered in the frame
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.BackgroundTransparency = 1 -- Remove background color
        button.Text = "Hold to Speed"
        button.TextSize = InputTSize.Value
        button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
        button.Parent = frame

        -- Teleport walk function
        local function startTpWalk()
            tpwalking = true
            local chr = Player.Character
            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
            while tpwalking and chr and hum and hum.Parent do
                local delta = RunService.Heartbeat:Wait()
                if hum.MoveDirection.Magnitude > 0 then
                    chr:TranslateBy(hum.MoveDirection * tpWalkSpeed * delta * 10)
                end
            end
        end

        -- Stop teleport walk function
        local function stopTpWalk()
            tpwalking = false
        end

        -- Hold to speed button event
        button.MouseButton1Down:Connect(function()
            Player.Character.Humanoid.WalkSpeed = tpWalkSpeed
            startTpWalk()
        end)

        button.MouseButton1Up:Connect(function()
            Player.Character.Humanoid.WalkSpeed = normalWalkSpeed
            stopTpWalk()
        end)

        -- Function to handle GUI drag on mobile
        local dragging, dragInput, dragStart, startPos

        local function updateG(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            savedPosition = frame.Position  -- Save the updated position

            -- Save the new position to the JSON file
            local dataToSave = {
                scaleX = savedPosition.X.Scale,
                x = savedPosition.X.Offset,
                scaleY = savedPosition.Y.Scale,
                y = savedPosition.Y.Offset
            }
            writeJsonFile(filePath, dataToSave)
        end

        frame.InputBegan:Connect(function(input)
            if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if not LockFrames and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if not LockFrames and input == dragInput and dragging then
                updateG(input)
            end
        end)
    else
        -- Destroy the GUI if it exists
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
        end
    end
end

-- Connect the toggle's OnChanged event to the function
Toggle:OnChanged(toggleGui)

-- Set the initial state of the toggle
Options.HoldTpWalk:SetValue(false)

-- Ensure the GUI persists across respawns and retains its position
Player.CharacterAdded:Connect(function()
    if Toggle.Value then
        wait(1)  -- Delay to ensure the character is fully loaded
        toggleGui(true)
    end
end)














Tabs.Buttons:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })
        
        Tabs.Buttons:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })
        
        Tabs.Buttons:AddParagraph({
            Title = "This is for Scrolling",
            Content = "For scrolling only"
        })



















--------------------------------------------------------------------BUTTONS------------------------------------------------------------------------------------------------

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
function setDraggable(draggable)
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
function toggleButtonVisibility(visible)
        button.Visible = visible
    end
    
    Tabs.Settings:AddParagraph({
            Title = "To open Window from Chat just say:",
            Content = "/e ash"
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
    
local Player = game.Players.LocalPlayer

-- Define the function you want to execute when "/e ash" is typed
function openWindow()
    Window:Minimize()
end

function notifyAndSet(option, value, title, content)
    option:SetValue(value)
    Fluent:Notify({
        Title = title,
        Content = content,
        Duration = 3
    })
end

function executeCommand(command)
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
            local Player = game.Players.LocalPlayer

            if not IsAlive(Player) then
                Fluent:Notify({
                    Title = "You're not alive",
                    Content = "Please wait for the new round to grab the gun.",
                    Duration = 3
                })
                return
            end

            if Player.Backpack:FindFirstChild("Gun") or (Player.Character and Player.Character:FindFirstChild("Gun")) then
                Fluent:Notify({
                    Title = "You already have a gun",
                    Content = "Lollll.",
                    Duration = 3
                })
                return
            end

            if Player.Character then
                local gundr = workspace:FindFirstChild("GunDrop")
                if gundr then
                    local oldpos = Player.Character.HumanoidRootPart.CFrame
                    game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(true)
                    wait(2)
                    repeat
                        Player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
                        task.wait()
                        Player.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
                        task.wait()
                    until not gundr:IsDescendantOf(workspace)
                    game:GetService("ReplicatedStorage").Remotes.Gameplay.Stealth:FireServer(false)
                    Player.Character.HumanoidRootPart.CFrame = oldpos
                    oldpos = false
                    Player.Character.Humanoid:ChangeState(1)
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
Player.Chatted:Connect(function(message)
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

    
    -- You can use the SaveManager:LoadAutoloadConfig() to load a config
    -- which has been marked to be one that auto loads!
    
    
    
local TimeEnd = tick()
local TotalTime = string.format("%.2f", math.abs(TimeStart - TimeEnd))
Fluent:Notify({
    Title = "AshbornnHub",
    Content = "Successfully loaded the script in " .. TotalTime .. "s.",
    Duration = 4
})
wait(5)
    SaveManager:LoadAutoloadConfig()