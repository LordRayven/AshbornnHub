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
local N=game:GetService("VirtualInputManager")

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


local newflyspeed = 50
local c
local h
local bv
local bav
local cam
local flying
local p = game.Players.LocalPlayer
local buttons = {W = false, S = false, A = false, D = false, Moving = false}


-- Function to teleport to a player
local function TeleportToPlayer(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
    end
end

local function GetOtherPlayers()
    local players = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
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

function startFly()
    if not p.Character or not p.Character.Head or flying then return end
    c = p.Character
    h = c.Humanoid
    h.PlatformStand = true
    cam = workspace:WaitForChild('Camera')
    bv = Instance.new("BodyVelocity")
    bav = Instance.new("BodyAngularVelocity")
    bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
    bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
    bv.Parent = c.Head
    bav.Parent = c.Head
    flying = true
    h.Died:connect(function() flying = false end)
end
  
function endFly()
    if not p.Character or not flying then return end
    h.PlatformStand = false
    bv:Destroy()
    bav:Destroy()
    flying = false
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
			if v.Name == Sheriff and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(0, 0, 225)
                Highlight.FillTransparency = applyesptrans
			elseif v.Name == Murder and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(225, 0, 0)
                Highlight.FillTransparency = applyesptrans
			elseif v.Name == Hero and IsAlive(v) and v.Backpack:FindFirstChild("Gun") then
				Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                Highlight.FillTransparency = applyesptrans
			elseif v.Name == Hero and IsAlive(v) and v.Character:FindFirstChild("Gun") then
				Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                Highlight.FillTransparency = applyesptrans
			elseif not IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(100, 100, 100)
                Highlight.FillTransparency = applyesptrans
			else
				Highlight.FillColor = Color3.fromRGB(0, 225, 0)
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
    Misc = Window:AddTab({ Title = "Misc", Icon = "triangle-alert" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "zap" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
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
getgenv().GunAccuracy = 25

-- Hook to modify gun shooting behavior
local GunHook
GunHook = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }

    if not checkcaller() then
        if typeof(self) == "Instance" then
            if self.Name == "ShootGun" and method == "InvokeServer" then
                if getgenv().GunAccuracy and Murder then
                    local targetPlayer = Players[Murder]
                    if targetPlayer and targetPlayer.Character and targetPlayer.Character.PrimaryPart then
                        local Root = targetPlayer.Character.PrimaryPart
                        local Velocity = Root.AssemblyLinearVelocity
                        local Position = Root.Position + (Velocity * Vector3.new(getgenv().GunAccuracy / 200, 0, getgenv().GunAccuracy / 200))
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

-------------------------------------------COMBAT---------------------------------------

Tabs.Combat:AddParagraph({
        Title = "Sheriff Hacks",
        Content = "Under this paragraph is for Sheriff/ Innocent"
    })
    
    
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
    
    local Toggle = Tabs.Combat:AddToggle("SilentAIM1", {Title = "Silent Aim to Murderer", Default = false })

Toggle:OnChanged(function(gunsilentaim)
    getgenv().SheriffAim = gunsilentaim
end)

Options.SilentAIM1:SetValue(false)

Tabs.Combat:AddParagraph({
        Title = "Murderer Hacks",
        Content = "Under this paragraph is for Murderer Hacks"
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

-- Knife Aura Toggle Definition
local knifeAuraToggle = Tabs.Combat:AddToggle("KnifeAura", {Title = "Knife Aura", Default = false})

knifeAuraToggle:OnChanged(function(knifeaura)
    knifeauraloop = knifeaura
    while knifeauraloop do
        local function knifeAuraLoopFunction()
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) < kniferangenum then
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
        wait()
        pcall(knifeAuraLoopFunction)
    end
end)
Options.KnifeAura:SetValue(false)

-- Auto Kill All Toggle Definition
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
                    wait()
                    local playerCharacter = player.Character
                    local humanoidRootPart = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")
                    
                    if humanoidRootPart then
                        Stab()
                        firetouchinterest(humanoidRootPart, knife.Handle, 1)
                        firetouchinterest(humanoidRootPart, knife.Handle, 0)
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

local Toggle = Tabs.Misc:AddToggle("Enable Fly", {Title = "Enable Fly", Default = false})

Toggle:OnChanged(function(enablefly)
    if flyfirst ~= true then
        flyfirst = true

        game:GetService("UserInputService").InputBegan:Connect(function(input, GPE)
            if GPE then return end
            for i, e in pairs(buttons) do
                if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
                    buttons[i] = true
                    buttons.Moving = true
                end
            end
        end)

        game:GetService("UserInputService").InputEnded:Connect(function(input, GPE)
            if GPE then return end
            local a = false
            for i, e in pairs(buttons) do
                if i ~= "Moving" then
                    if input.KeyCode == Enum.KeyCode[i] then
                        buttons[i] = false
                    end
                    if buttons[i] then a = true end
                end
            end
            buttons.Moving = a
        end)

        game:GetService("RunService").Heartbeat:Connect(function(step)
            if flying and c and c.PrimaryPart then
                local p = c.PrimaryPart.Position
                local cf = cam.CFrame
                local ax, ay, az = cf:ToEulerAnglesXYZ()
                c:SetPrimaryPartCFrame(CFrame.new(p.x, p.y, p.z) * CFrame.Angles(ax, ay, az))
                if buttons.Moving then
                    local t = Vector3.new()
                    if buttons.W then t = t + (setVec(cf.LookVector)) end
                    if buttons.S then t = t - (setVec(cf.LookVector)) end
                    if buttons.A then t = t - (setVec(cf.RightVector)) end
                    if buttons.D then t = t + (setVec(cf.RightVector)) end
                    c:TranslateBy(t * step)
                end
            end
        end)
    end

    if enablefly then
        startFly()
    else
        endFly()
    end
end)

----------------------------------------------------MISC---------------------------------------------------

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

Tabs.Misc:AddButton({
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
    
Tabs.Teleport:AddButton({
        Title = "TP to Secret Room",
        Description = "Teleport to Lobby's Secret Room",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-152, 153, 113)
        end
    })




-------------------------------------------TELEPORT ENDS--------------------------------------------
    
    

    
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
                    Fluent:Notify({
        Title = "Gun found",
        Content = "Please tap the Grab Gun and move your character a little bit.",
        SubContent = "Combat => Grab Gun", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
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


    
    
--------------------------------------------------VISUAL ENDS---------------------------------------------------------------------
    
    
    --------------------------------------------MAIN---------------------------------------------
  Tabs.Main:AddButton({
        Title = "Infinite Yield",
        Description = "Best script for all games",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    end
    ------------------------------------------MAIN ENDS------------------------------------

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
SaveManager:SetFolder("AshborrnHub/MM2")

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
