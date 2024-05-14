--[[
    R3TH PRIV MURDER MYSTERY 2 SOURCE

    It should be noted that this script is rather messy and not recommended for learning off because it is many months old and my first script hub ever.
    V2 is being developed, and now that I've had six months of experience with lua, I can create a much better script hub.
    .gg/pethicial

    Credits:
        pethicial
]]

--------------------------------------------------------------------------------------R3THPRIV----------------------------------------------------------------------------------------
repeat wait() until game:IsLoaded()

for _,obj in next, game.Players.LocalPlayer.Backpack.Toys:GetChildren() do
    if obj.Name == "SprayPaint" then
        doeshavespraypaint = true
    elseif doeshavespraypaint ~= true then
        for _,obj in next, game.Players.LocalPlayer.Backpack:GetChildren() do
            if obj.Name == "SprayPaint" then
                doeshavespraypaint = true
            elseif doeshavespraypaint ~= true then
                if game.Players.LocalPlayer.Character:FindFirstChild("SprayPaint") then
                    doeshavespraypaint = true
                end
            end
        end
        wait()
    end
end

print("[ R3TH PRIV ]: R3TH PRIV MURDER MYSTERY 2 LOADING...")

--------------------------------------------------------------------------------------THEME----------------------------------------------------------------------------------------
privateProperties = {
	Color = Color3.fromRGB(138,43,226); 
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}

--------------------------------------------------------------------------------------DEFINE----------------------------------------------------------------------------------------
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/R3TH-PRIV/R3THPRIV/main/OtherScripts/VenyxUI.lua"))()
local R3TH = library.new("R3TH PRIV                                                                             .gg/pethicial", 5013109572)


local Universal = R3TH:addPage("Universal", 5012540623)
local Player = Universal:addSection("Player")
local ESP = Universal:addSection("ESP")
local Fling = Universal:addSection("Fling")
local Game = Universal:addSection("Game")
local Combat = R3TH:addPage("Combat", 5012544944)
local Murderer = Combat:addSection("Murderer")
local Sheriff = Combat:addSection("Sheriff")
local Innocent = Combat:addSection("Innocent")
local Main0 = R3TH:addPage("Main", 5012540623)
local Teleports = Main0:addSection("Teleports")
local Map = Main0:addSection("Map")
local Chams = Main0:addSection("Chams")
local Main = Main0:addSection("Main")
local Misc = Main0:addSection("Misc")
local Toggles = R3TH:addPage("Toggles", 5012544092)
local World = Toggles:addSection("World")
local Visual = Toggles:addSection("Visual")
local ChromaGuns = Toggles:addSection("Chroma Guns")
local Trading = Toggles:addSection("Trading")
local Traps = Toggles:addSection("Traps")
local Target0 = R3TH:addPage("Spray Paint", 5012542120)
local Target = Target0:addSection("Target")
local LoopTarget = Target0:addSection("Loop Target")
local FE = Target0:addSection("FE")
local Antijoin = Target0:addSection("Anti Join")
local MultiKill = R3TH:addPage("Multi Kill", 5012538583)
local Mutlikill1 = MultiKill:addSection("Mutli Kill 1")
local Mutlikill2 = MultiKill:addSection("Mutli Kill 2")
local Mutlikill3 = MultiKill:addSection("Mutli Kill 3")
local Mutlikill4 = MultiKill:addSection("Mutli Kill 4")
local Mutlikill5 = MultiKill:addSection("Mutli Kill 5")
local Mutlikill6 = MultiKill:addSection("Mutli Kill 6")
local Mutlikill7 = MultiKill:addSection("Mutli Kill 7")
local Mutlikill8 = MultiKill:addSection("Mutli Kill 8")
local Mutlikill9 = MultiKill:addSection("Mutli Kill 9")
local Mutlikill10 = MultiKill:addSection("Mutli Kill 10")
local Mutlikill11 = MultiKill:addSection("Mutli Kill 11")
local Mutlikill12 = MultiKill:addSection("Mutli Kill 12")
local Settings0 = R3TH:addPage("Settings", 5012544372)
local Settings = Settings0:addSection("Settings")
local Credits = Settings0:addSection("Credits")

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

--------------------------------------------------------------------------------------FUNCTIONS----------------------------------------------------------------------------------------
function toggleui()
    wait()
    local Toggle = false
    
    local R3THTOGGLEBUTTON = Instance.new("ScreenGui")
    local Button = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UICorner_2 = Instance.new("UICorner")

    R3THTOGGLEBUTTON.Name = "R3THTOGGLEBUTTON"
    R3THTOGGLEBUTTON.Parent = game.CoreGui
    
    Button.Name = "Button"
    Button.Parent = R3THTOGGLEBUTTON
    Button.BackgroundColor3 = Color3.fromRGB(77, 77, 77) -- CHANGES BUTTON COLOR
    Button.BorderColor3 = Color3.fromRGB(52, 52, 52)
    Button.BorderSizePixel = 0
    Button.Position = UDim2.new(0.942588627, 0, 0.223685458, 0)
    Button.Size = UDim2.new(0.0358672254, 0, 0.0771396905, 0)
    Button.Font = Enum.Font.FredokaOne
    Button.Text = "T"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255) -- CHANGES TEXT COLOR
    Button.TextScaled = true
    Button.TextSize = 33.000
    Button.TextWrapped = true
    Button.Draggable = true
    
    UICorner.Parent = Button
    
    UICorner_2.Parent = Button
    
    Button.MouseButton1Click:connect(function()
        Toggle = not Toggle
    end)
    
    while r3thtoggleui do
        function toggleuifix()
        if Toggle then
            Toggle = false
            R3TH:toggle()
            wait()
        end
    end
    wait()
    pcall(toggleuifix)
    end
end

-- Create a ScreenGui object to hold the button
local gui = Instance.new("ScreenGui")
gui.Name = "AshbornnHubGui"
gui.Parent = game.CoreGui

-- Create the button
local button = Instance.new("TextButton")
button.Name = "ToggleButton"
button.Text = "Open"
button.Size = UDim2.new(0, 80, 0, 30) -- Adjust the size as needed
button.Position = UDim2.new(0, 10, 0, 10) -- Position at top left with 10px offset
button.BackgroundColor3 = Color3.new(0, 0, 0) -- Black background
button.TextColor3 = Color3.new(1, 1, 1) -- White text
button.Parent = gui

-- Functionality for the button
button.MouseButton1Click:Connect(function()
    -- Call the toggle function in your AshbornnHub module
    R3TH:toggle()
end)

function sendnotification(notificationmessage)
    if WVryGeXr38ZZtdJWtrBtyeEKdm9Kkweaxm7tnUpuCcH835AQN2aLxV2NeG76kYZuWnCZz4yRr == true then
        StarterGui:SetCore("SendNotification", {
            Title = "R3TH PRIV";
            Text = notificationmessage;
            Duration = 5;
        })
    else
        Notification:Notify(
            {Title = "R3TH PRIV", Description = notificationmessage},
            {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "default"}
        )
    end
end

function loadesp()
    if loadespenabled ~= true then
        loadespenabled = true
        R3THESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/R3TH-PRIV/R3THPRIV/main/OtherScripts/ESP.lua"))()
        R3THESP.Box = false
        R3THESP.BoxOutline = false
        R3THESP.HealthBar = false
        R3THESP.Names = false
        R3THESP.NamesOutline = false
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

function setVec(vec)
    return vec * (newflyspeed / vec.Magnitude)
end

function CreateHighlight()
    for i, v in pairs(Players:GetChildren()) do
        if v ~= LocalPlayer and v.Character and not v.Character:FindFirstChild("Highlight") then
            Instance.new("Highlight", v.Character)
        end
    end
end

function UpdateHighlights()
    for _, v in pairs(Players:GetChildren()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Highlight") then
            Highlight = v.Character:FindFirstChild("Highlight")
            if v.Name == Sheriff and IsAlive(v) and sheriffchams == true then
                Highlight.FillColor = Color3.fromRGB(0, 0, 225)
            elseif v.Name == Murder and IsAlive(v) and murdchams == true then
                Highlight.FillColor = Color3.fromRGB(225, 0, 0)
            elseif v.Name == Hero and IsAlive(v) and not IsAlive(game.Players[Sheriff]) and sheriffchams == true then
                Highlight.FillColor = Color3.fromRGB(255, 250, 0)
            else
                Highlight.FillColor = Color3.fromRGB(0, 225, 0)
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

function refreshchams()
    for i,v in pairs (workspace:GetDescendants()) do
        if v.Name == "Highlight" then
            v:Destroy()
        end
    end
    roleupdaterfix()
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

function SprayPaintNotif()
    if doeshavespraypaint ~= true then
        sendnotification("You dont have Spray Paint, You will need it to be able to use this.")
    end
end

function findgun()
    GunHolderName = nil
    for i,v in pairs(game.Players:GetChildren()) do
        function findgunfix()
        if v.Name ~= LocalPlayer.Name then
            local player = Players:FindFirstChild(v.Name)
            Gun = player and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun"))
            if Gun ~= nil then
                print("GUN FOUND")
                GunHolderName = v.Name
                GunPath = player and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun"))
            end
        end
    end
    wait()
    pcall(findgunfix)
    end
end

function dropgun()
    N:SendKeyEvent(true,"Backspace",false,game)
end

--------------------------------------------------------------------------------------EXTRA----------------------------------------------------------------------------------------
local VirtualUser = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    if antiafk == true then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)
wait()

local flinglist = {}
local playerlist = {}
local playerlistfe = {}
local antijoinlist = {}

table.insert(flinglist,"All")
table.insert(playerlistfe,"All")
table.insert(playerlistfe,game.Players.LocalPlayer.Name)

for i,v in pairs(game.Players:GetPlayers())do
    if v ~= game.Players.LocalPlayer then
        table.insert(flinglist,v.Name)
        table.insert(playerlist,v.Name)
        table.insert(playerlistfe,v.Name)
    end
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(Player)
    if r3thtoggleui == true then
        toggleui()
    end
    if emotesondeath == true then
        SpawnEmotes()
    end
end)

workspace.ChildAdded:Connect(function(p)
    if r3thremovedecals == true then
        if p.Name == "Spray" then
            p:Destroy()
            wait()
        end
    end
    wait()
end)

game.Players.PlayerAdded:Connect(function(player)
    local name = player.Name
    table.insert(flinglist,name)
    table.insert(playerlist,name)
    table.insert(playerlistfe,name)
    if antijoinloop == true then
        table.insert(antijoinlist,name)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local name = player.Name
    for i,v in pairs(flinglist)do
        if v == name then  
            table.remove(flinglist,i)
        end
    end
    for i,v in pairs(playerlist)do
        if v == name then  
            table.remove(playerlist,i)
        end
    end
    for i,v in pairs(playerlistfe)do
        if v == name then  
            table.remove(playerlistfe,i)
        end
    end
    if antijoinloop == true then
        for i,v in pairs(antijoinlist)do
            if v == name then  
                table.remove(antijoinlist,i)
            end
        end
    end
end)

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

getgenv().SheriffAim = false;
getgenv().GunAccuracy = 25;

local GunHook
GunHook = hookmetamethod(game, "__namecall", function(self, ...) -------------copy code for shoot player
	local method = getnamecallmethod()
	local args = { ... }
	if not checkcaller() then
		if typeof(self) == "Instance" then
			if self.Name == "ShootGun" and method == "InvokeServer" then
				if getgenv().SheriffAim and getgenv().GunAccuracy then
					if Murderer then
						local Root = Players[tostring(Murder)].Character.PrimaryPart;
						local Veloc = Root.AssemblyLinearVelocity;
						local Pos = Root.Position + (Veloc * Vector3.new(getgenv().GunAccuracy / 200, 0, getgenv().GunAccuracy/ 200));
						args[2] = Pos;
					end;
				end;
			end;
		end;
	end;
	return GunHook(self, unpack(args));
end);

--------------------------------------------------------------------------------------UNIVERSAL----------------------------------------------------------------------------------------
if WVryGeXr38ZZtdJWtrBtyeEKdm9Kkweaxm7tnUpuCcH835AQN2aLxV2NeG76kYZuWnCZz4yRr == true then
    Player:addTextbox("Walkspeed", defualtwalkspeed, function(walkspeed, focusLost)
        newwalkspeed = tonumber(walkspeed)
    end)
else
    Player:addSlider("Walkspeed", defualtwalkspeed, 0, 200, function(walkspeed)
        newwalkspeed = tonumber(walkspeed)
    end)
end

if WVryGeXr38ZZtdJWtrBtyeEKdm9Kkweaxm7tnUpuCcH835AQN2aLxV2NeG76kYZuWnCZz4yRr == true then
    Player:addTextbox("Jumppower", defualtjumppower, function(jumppower, focusLost)
        newjumppower = tonumber(jumppower)
    end)
else
    Player:addSlider("Jumppower", defualtjumppower, 0, 500, function(jumppower)
        newjumppower = tonumber(jumppower)
    end)
end

Player:addToggle("Enable WalkSpeed", false, function(enablewalkspeed)
    loopwalkspeed = enablewalkspeed
    while loopwalkspeed do
        LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = (newwalkspeed)
        wait()
    end
    wait()
    LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = (defualtwalkspeed)
    wait()
end)

Player:addToggle("Enable JumpPower", false, function(enablejumppower)
    loopjumppower = enablejumppower
    while loopjumppower do
        LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = (newjumppower)
        wait()
    end
    wait()
    LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = (defualtjumppower)
    wait()
end)

if WVryGeXr38ZZtdJWtrBtyeEKdm9Kkweaxm7tnUpuCcH835AQN2aLxV2NeG76kYZuWnCZz4yRr == true then
    Player:addTextbox("Fly Speed", 50, function(flyspeed, focusLost)
        newflyspeed = tonumber(flyspeed)
    end)
else
    Player:addSlider("Fly Speed", 50, 0, 500, function(flyspeed)
        newflyspeed = tonumber(flyspeed)
    end)
end

Player:addToggle("Enable Fly", false, function(enablefly)
    if flyfirst ~= true then
        flyfirst = true
        game:GetService("UserInputService").InputBegan:connect(function (input, GPE) 
            if GPE then return end
            for i, e in pairs(buttons) do
                if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
                    buttons[i] = true
 
