local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-------------------FUNCTION-----------------------
roles = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()
applyesptrans = 0.5
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local players = game:GetService("Players")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local N=game:GetService("VirtualInputManager")

local defualtwalkspeed = 16
local defualtjumppower = 50
local defualtgravity = 196.1999969482422
newwalkspeed = defualtwalkspeed
newjumppower = defualtjumppower
antiafk = true

ATG = false
Grabbing = true

local newflyspeed = 50
local c
local h
local bv
local bav
local cam
local flying
local p = game.Players.LocalPlayer
local buttons = {W = false, S = false, A = false, D = false, Moving = false}

function GetMurderer()
    for i, v in game:GetService("Players"):GetChildren() do
     if v.Backpack:FindFirstChild"Knife" or v.Character and v.Character:FindFirstChild("Knife") then return v.Character end
    end
    return nil
   end

game.workspace.ChildAdded:Connect(function(child)
    if child.Name == "GunDrop" and ATG and GetMurderer() ~= LocalPlayer.Character then
      print("Gun dropped!")
      while child and task.wait() do
       if (GetMurderer().Head.Position-child.Position).magnitude < 10 then
        repeat task.wait() until (GetMurderer().Head.Position-child.Position).magnitude > 10
       end
       Grabbing = true
       LocalPlayer.Character.HumanoidRootPart.CFrame = child.CFrame + Vector3.new(0, .5, 0)
      end
      Grabbing = false
     end
   end)
   function GetMurd()
    return game:GetService("Players"):GetPlayerFromCharacter(GetMurderer())
   end
   function MurdererLoop()
    if ASM and LocalPlayer.Character and GetMurderer() and LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun") then
     if LocalPlayer.Backpack:FindFirstChild("Gun") then LocalPlayer.Backpack.Gun.Parent = LocalPlayer.Character end
     local Murd = GetMurderer()
     LocalPlayer.Character.HumanoidRootPart.CFrame = Murd.HumanoidRootPart.CFrame - Murd.Head.CFrame.LookVector*10
     LocalPlayer.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, Murd.HumanoidRootPart.Position, "AH")
    end
    task.wait(.5)
   end
   function SecondLoop()
    if GetMurderer() == LocalPlayer.Character or GetMurderer() == nil or not AE then ImageLabel.Image = '' return end
    ImageLabel.Image = game:GetService('Players'):GetUserThumbnailAsync(GetMurd().UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size150x150)
    if (GetMurderer().HumanoidRootPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 15 and not tpedtoPos and not Grabbing then
     tpedtoPos = LocalPlayer.Character.HumanoidRootPart.CFrame
     LocalPlayer.Character.HumanoidRootPart.CFrame = Part.CFrame + Vector3.new(0, 3, 0)
    elseif tpedtoPos and (GetMurderer().HumanoidRootPart.Position-Vector3.new(tpedtoPos.X, tpedtoPos.Y, tpedtoPos.Z)).magnitude > 10 and not Grabbing then 
     LocalPlayer.Character.HumanoidRootPart.CFrame = tpedtoPos
     tpedtoPos = nil
    end
   end










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
        AshESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/R3TH-PRIV/R3THPRIV/main/OtherScripts/ESP.lua"))()
        AshESP.Box = false
        AshESP.BoxOutline = false
        AshESP.HealthBar = false
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

function SpawnEmotes()
    local Remote = game.ReplicatedStorage.Remotes.Extras.GetPlayerData:InvokeServer("GetData")
    local Client = Players.LocalPlayer
    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local Modules = ReplicatedStorage.Modules
    local EmoteModule = Modules.EmoteModule
    local Emotes = Client.PlayerGui.MainGUI.Game:FindFirstChild("Emotes")
    local EmoteList = {"headless","zombie","zen","ninja","floss","dab","sit"}
    require(EmoteModule).GeneratePage(EmoteList,Emotes,'Your Emotes')
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
    Misc = Window:AddTab({ Title = "Misc", Icon = "bolt" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "zap" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}



-------------------------EXTRAS---------------------------



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
--------------------------EXTRAS--------------------------


local Options = Fluent.Options

do
    

    Tabs.Combat:AddButton({
        Title = "Grab gun",
        Description = "Tp to Gun",
        Callback = function()
            local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
            local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
            local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z	
            
            if workspace:FindFirstChild("GunDrop") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame	
                wait(.30)	
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
            else
                Fluent:Notify({
                    Title = "Gun not Found",
                    Content = "Wait for the Sheriff's death to grab the gun.",
                    Duration = 3
                })
            end
        end
    })

    


    local kniferangenum = 20

-- Slider Definition
local Slider = Tabs.Combat:AddSlider("Knife Range", {
    Title = "Knife Range",
    Description = "Adjust the range of the knife",
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
                    if player.UserId == 290931 or player.UserId == 129215104 then
                        Fluent:Notify({
                            Title = "You're trying to kill the script owner",
                            Content = "Nuhh uhh",
                            SubContent = "Im here kid", -- Optional
                            Duration = 5 -- Set to nil to make the notification not disappear
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

local knifeAuraToggle = Tabs.Combat:AddToggle("KnifeAura", {Title = "Knife Aura", Default = false})

knifeAuraToggle:OnChanged(function(knifeaura)
    knifeauraloop = knifeaura
    while knifeauraloop do
        local function knifeAuraLoopFunction()
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) < kniferangenum then
                    if v.UserId == 290931 or v.UserId == 129215104 then
                        Fluent:Notify({
                            Title = "You're trying to kill the script owner",
                            Content = "Nuhh uhh",
                            SubContent = "Im here kid", -- Optional
                            Duration = 5 -- Set to nil to make the notification not disappear
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




    

    Tabs.Main:AddButton({
        Title = "Infinite Yield",
        Description = "Best script for all games",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })
    ---------------------MISC

    local Toggle = Tabs.Misc:AddToggle("GetEmotes", {Title = "Get All Emotes", Default = false})

Toggle:OnChanged(function(getallemotes)
    emotesondeath = getallemotes
    if emotesondeath == true then
        SpawnEmotes()
        wait()
    end
end)

Options.GetEmotes:SetValue(false)
    
Tabs.Misc:AddButton({
    Title = "Get fake knife",
    Description = "Fake knife they can see it(probably)",
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


    ---------------------MISC
    local Toggle = Tabs.Misc:AddToggle("Noclip", {Title = "Noclip", Default = false })

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

local Toggle = Tabs.Misc:AddToggle("AutoShoot", { Title = "Auto Shoot Murderer", Default = false })

Toggle:OnChanged(function(state)
    ASM = state
end)

Options.AutoShoot:SetValue(false)





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
    Dropdown = Tabs.Misc:AddDropdown("Select Player", {
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

local Toggle = Tabs.Misc:AddToggle("Fling", {
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

    
    
    local Toggle = Tabs.Misc:AddToggle("Fling", {Title = "Fling Murderer", Default = false })

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

local Toggle = Tabs.Misc:AddToggle("Fling", {Title = "Fling Sheriff", Default = false })

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

local function CreateDropdownB()
    local Dropdown = Tabs.Misc:AddDropdown("ViewPlayerd", {
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

Tabs.Misc:AddButton({
    Title = "Stop Viewing",
    Description = "Stop viewing the selected player",
    Callback = function()
        workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
    end
})



    
    ----------------------MISC ENDS
    -------------------------------TELEPORTS-------------------------------

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

    Tabs.Teleport:AddButton({
        Title = "TP to Secret Room",
        Description = "Teleport to Lobby's Secret Room",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-152, 153, 113)
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
    
    -------------------TELEPORT ENDS--------------------------
    
    



------------------------VISUAL------------------------------
    
local Toggle = Tabs.Visual:AddToggle("ESPRoles", {Title = "ESP Roles", Default = false })

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
        AshESP.Names = true
        AshESP.NamesOutline = true
        end
    else
        SSeeRoles = false
        task.wait(0.2)
        loadesp()
        AshESP.Names = false
        AshESP.NamesOutline = false
        HideHighlights()
    end
end)

Options.ESPRoles:SetValue(false)

local Toggle = Tabs.Visual:AddToggle("ESPGun", {Title = "ESP Gun", Default = false })

Toggle:OnChanged(function(SeeGun)
    if SeeGun then
        SSeeGun = true
        spawn(function()
            while SSeeGun do
                repeat wait() until workspace:FindFirstChild("GunDrop")
                if workspace:FindFirstChild("GunDrop") and not workspace.GunDrop:FindFirstChild("Esp_gun") then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "AshbornnHub 1.1.0",
                        Text = "Gun is Dropped",
                        Duration = 2
                    })
                    local espgunhigh = Instance.new("Highlight", workspace:FindFirstChild("GunDrop"))
                    espgunhigh.Name = "Esp_gun"
                    espgunhigh.FillColor = Color3.fromRGB(0, 255, 0)
                    espgunhigh.OutlineTransparency = 1
                    espgunhigh.FillTransparency = 0
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
    
    
-----------------VISUAL---------------------
    
    
    
    local Slider = Tabs.Main:AddSlider("Slider", {
        Title = "Slider",
        Description = "This is a slider",
        Default = 2,
        Min = 0,
        Max = 5,
        Rounding = 1,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })

    Slider:OnChanged(function(Value)
        print("Slider changed:", Value)
    end)

    Slider:SetValue(3)

    

    
    

    local Keybind = Tabs.Main:AddKeybind("Keybind", {
        Title = "KeyBind",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "LeftControl", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            print("Keybind clicked!", Value)
        end,

        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
            print("Keybind changed!", New)
        end
    })

    -- OnClick is only fired when you press the keybind and the mode is Toggle
    -- Otherwise, you will have to use Keybind:GetState()
    Keybind:OnClick(function()
        print("Keybind clicked:", Keybind:GetState())
    end)

    Keybind:OnChanged(function()
        print("Keybind changed:", Keybind.Value)
    end)

    task.spawn(function()
        while true do
            wait(1)

            -- example for checking if a keybind is being pressed
            local state = Keybind:GetState()
            if state then
                print("Keybind is being held down")
            end

            if Fluent.Unloaded then break end
        end
    end)

    Keybind:SetValue("MB2", "Toggle") -- Sets keybind to MB2, mode to Hold

    local Input = Tabs.Main:AddInput("Input", {
        Title = "Input",
        Default = "Default",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            print("Input changed:", Value)
        end
    })

    Input:OnChanged(function()
        print("Input updated:", Input.Value)
    end)
end


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
InterfaceManager:SetFolder("AshborrnHub")
SaveManager:SetFolder("AshbornnHub/MurderMystery2")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "AshbornnHub",
    Content = "AshbornnHub has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
