-- Define URLs and user key
local userkey = game:HttpGet("https://pastebin.com/raw/Uag14ZfV")
local url = "https://link-center.net/480893/ashbornnhub-key-system1"
local discordInvite = "https://discord.com/invite/AdYyzaTpXX"

-- Load external scripts for notifications
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Create GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeySystemGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.5, -125, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(97, 62, 167)
frame.BackgroundTransparency = 0.7
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 8)

local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Size = UDim2.new(0.85, 0, 0.2, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "AshbornnHub KeySystem"
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.BorderSizePixel = 0

local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.Text = "X"
closeButton.TextScaled = true
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundTransparency = 0.7
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.SourceSansBold

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.8, 0, 0.2, 0)
textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
textBox.PlaceholderText = "Paste key here"
textBox.Text = ""
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textBox.BackgroundTransparency = 0.7
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BorderSizePixel = 0
textBox.Font = Enum.Font.SourceSans

local function clearUnexpectedText()
    if textBox.Text == "TextBox" then
        textBox.Text = ""
    end
end

clearUnexpectedText()

local getKeyButton = Instance.new("TextButton", frame)
getKeyButton.Size = UDim2.new(0.35, 0, 0.2, 0)
getKeyButton.Position = UDim2.new(0.1, 0, 0.55, 0)
getKeyButton.Text = "Get Key"
getKeyButton.TextScaled = true
getKeyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
getKeyButton.BackgroundTransparency = 0.7
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.BorderSizePixel = 0
getKeyButton.Font = Enum.Font.SourceSansBold

local checkKeyButton = Instance.new("TextButton", frame)
checkKeyButton.Size = UDim2.new(0.35, 0, 0.2, 0)
checkKeyButton.Position = UDim2.new(0.55, 0, 0.55, 0)
checkKeyButton.Text = "Check Key"
checkKeyButton.TextScaled = true
checkKeyButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
checkKeyButton.BackgroundTransparency = 0.7
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.BorderSizePixel = 0
checkKeyButton.Font = Enum.Font.SourceSansBold

local discordButton = Instance.new("TextButton", frame)
discordButton.Size = UDim2.new(0.35, 0, 0.2, 0)
discordButton.Position = UDim2.new(0.325, 0, 0.8, 0)
discordButton.Text = "Join Discord"
discordButton.TextScaled = true
discordButton.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
discordButton.BackgroundTransparency = 0.7
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.BorderSizePixel = 0
discordButton.Font = Enum.Font.SourceSansBold

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local function getCurrentTime()
    return os.time()
end

local function saveKey(key)
    pcall(writefile, "AshbornnHub/saved_key.txt", key)
    pcall(writefile, "AshbornnHub/key_time.txt", tostring(getCurrentTime()))
end

local function loadKey()
    local success, key = pcall(readfile, "AshbornnHub/saved_key.txt")
    local successTime, time = pcall(readfile, "AshbornnHub/key_time.txt")
    if success and key and successTime and time then
        return key, tonumber(time)
    else
        return nil, nil
    end
end

local function resetKey()
    pcall(writefile, "AshbornnHub/saved_key.txt", "")
    pcall(writefile, "AshbornnHub/key_time.txt", "")
end

local function isKeyValid(key, timestamp)
    if key == userkey and (getCurrentTime() - timestamp) < 86400 then
        return true
    else
        resetKey()
        return false
    end
end

local function CheckKey()
    _G.Key = textBox.Text

    if _G.Key == "" then
        print("Key is empty")
        Fluent:Notify({
            Title = "Key System Says:",
            Content = "Please enter a key",
            Duration = 3
        })
        return
    end

    local key, timestamp = loadKey()

    if _G.Key == userkey and isKeyValid(_G.Key, getCurrentTime()) then
        saveKey(_G.Key) -- Save key and current time
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/AshMain.lua", true))()
    else
        print("Key is invalid or expired")
        Fluent:Notify({
            Title = "Wrong Key or Expired",
            Content = "Get a new key",
            Duration = 8
        })
    end
end

getKeyButton.MouseButton1Click:Connect(function()
    setclipboard(url)
    Fluent:Notify({
        Title = "Key System Says:",
        Content = "Key link has been copied to clipboard",
        Duration = 3
    })
end)

checkKeyButton.MouseButton1Click:Connect(CheckKey)

discordButton.MouseButton1Click:Connect(function()
    setclipboard(discordInvite)
    Fluent:Notify({
        Title = "Key System Says:",
        Content = "Discord invite has been copied to clipboard",
        Duration = 3
    })
end)

local savedKey, savedTime = loadKey()
if savedKey and savedTime then
    if isKeyValid(savedKey, savedTime) then
        textBox.Text = savedKey
        CheckKey()
    else
        resetKey()
        Fluent:Notify({
            Title = "Key Expired",
            Content = "Please get a new key",
            Duration = 3
        })
    end
end
