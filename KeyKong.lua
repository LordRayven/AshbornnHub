-- Define URLs and user key
local userkey = game:HttpGet("https://pastebin.com/raw/Uag14ZfV")
local url = "https://link-target.net/480893/ashbornnhub-key-system"
local discordInvite = "https://discord.com/invite/AdYyzaTpXX"

-- Load external scripts for notifications
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/NotificationHolder.lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/Notification.lua"))()

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
textBox.PlaceholderText = "Enter Key"
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

getKeyButton.MouseButton1Click:Connect(function()
   setclipboard(url)
end)

discordButton.MouseButton1Click:Connect(function()
   setclipboard(discordInvite)
end)

local function loadSavedKey()
    local success, key = pcall(readfile, "AshbornnHub/saved_key.txt")
    if success and key then
        return key
    else
        return nil
    end
end

local function saveKey(key)
    pcall(writefile, "AshbornnHub/saved_key.txt", key)
end

local premiumKeys = {
    "RaizaR",
    "UmF5dmVu",
    userkey
}

local function CheckKey()
    _G.Key = textBox.Text

    local keyValid = false
    if _G.Key == "" then
        print("Key is empty")
    else
        for _, k in ipairs(premiumKeys) do
            if _G.Key == k then
                keyValid = true
                break
            end
        end
    end

    if keyValid then
        saveKey(_G.Key)
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/AshMain.lua", true))()
    else
        print("Key is invalid")
        Notification:Notify(
            {Title = "AshbornnHub GUI", Description = "Wrong Key"},
            {OutlineColor = Color3.fromRGB(97, 62, 167), Time = 7, Type = "default"}
        )
    end
end

checkKeyButton.MouseButton1Click:Connect(CheckKey)

local savedKey = loadSavedKey()
if savedKey then
    textBox.Text = savedKey
    CheckKey()
end
