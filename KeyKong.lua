-- Utility function to convert a string to its ASCII representation
local function toAscii(str)
    local result = {}
    for i = 1, #str do
        table.insert(result, string.byte(str, i))
    end
    return table.concat(result, ",")
end

-- Utility function to convert ASCII representation back to a string
local function fromAscii(ascii)
    local result = {}
    for charCode in string.gmatch(ascii, "%d+") do
        table.insert(result, string.char(tonumber(charCode)))
    end
    return table.concat(result)
end

-- Define URLs and user key in ASCII
local userkey = game:HttpGet(fromAscii("104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,116,109,98,110,105,112,119,85"))
local url = fromAscii("104,116,116,112,115,58,47,47,108,105,110,107,45,116,97,114,103,101,116,46,110,101,116,47,52,56,48,56,57,51,47,97,115,104,98,111,114,110,110,104,117,98,45,107,101,121,45,115,121,115,116,101,109")
local discordInvite = fromAscii("104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,47,105,110,118,105,116,101,47,65,100,89,121,122,97,84,112,88,88")

-- Load external scripts for notifications
local NotificationHolder = loadstring(game:HttpGet(fromAscii("104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,76,111,114,100,82,97,121,118,101,110,47,65,115,104,98,111,114,110,110,72,117,98,47,109,97,105,110,47,78,111,116,105,102,105,99,97,116,105,111,110,72,111,108,100,101,114,46,108,117,97"))())
local Notification = loadstring(game:HttpGet(fromAscii("104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,76,111,114,100,82,97,121,118,101,110,47,65,115,104,98,111,114,110,110,72,117,98,47,109,97,105,110,47,78,111,116,105,102,105,99,97,116,105,111,110,46,108,117,97"))())

-- Create GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = fromAscii("75,101,121,83,121,115,116,101,109,71,85,73")

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
titleLabel.Text = fromAscii("65,115,104,98,111,114,110,110,72,117,98,32,75,101,121,83,121,115,116,101,109")
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.BorderSizePixel = 0

local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.Text = fromAscii("88")
closeButton.TextScaled = true
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundTransparency = 0.7
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.SourceSansBold

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.8, 0, 0.2, 0)
textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
textBox.PlaceholderText = fromAscii("69,110,116,101,114,32,75,101,121")
textBox.Text = ""
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textBox.BackgroundTransparency = 0.7
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BorderSizePixel = 0
textBox.Font = Enum.Font.SourceSans

local function clearUnexpectedText()
    if textBox.Text == fromAscii("84,101,120,116,66,111,120") then
        textBox.Text = ""
    end
end

clearUnexpectedText()

local getKeyButton = Instance.new("TextButton", frame)
getKeyButton.Size = UDim2.new(0.35, 0, 0.2, 0)
getKeyButton.Position = UDim2.new(0.1, 0, 0.55, 0)
getKeyButton.Text = fromAscii("71,101,116,32,75,101,121")
getKeyButton.TextScaled = true
getKeyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
getKeyButton.BackgroundTransparency = 0.7
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.BorderSizePixel = 0
getKeyButton.Font = Enum.Font.SourceSansBold

local checkKeyButton = Instance.new("TextButton", frame)
checkKeyButton.Size = UDim2.new(0.35, 0, 0.2, 0)
checkKeyButton.Position = UDim2.new(0.55, 0, 0.55, 0)
checkKeyButton.Text = fromAscii("67,104,101,99,107,32,75,101,121")
checkKeyButton.TextScaled = true
checkKeyButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
checkKeyButton.BackgroundTransparency = 0.7
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.BorderSizePixel = 0
checkKeyButton.Font = Enum.Font.SourceSansBold

local discordButton = Instance.new("TextButton", frame)
discordButton.Size = UDim2.new(0.35, 0, 0.2, 0)
discordButton.Position = UDim2.new(0.325, 0, 0.8, 0)
discordButton.Text = fromAscii("74,111,105,110,32,68,105,115,99,111,114,100")
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
    local success, key = pcall(readfile, fromAscii("65,115,104,98,111,114,110,110,72,117,98,47,115,97,118,101,100,95,107,101,121,46,116,120,116"))
    if success and key then
        return key
    else
        return nil
    end
end

local function saveKey(key)
    pcall(writefile, fromAscii("65,115,104,98,111,114,110,110,72,117,98,47,115,97,118,101,100,95,107,101,121,46,116,120,116"), key)
end

local premiumKeys = {
    fromAscii("82,97,105,122,97,82"),
    fromAscii("85,109,70,53,100,109,86,117"),
    userkey
}

local function CheckKey()
    _G.Key = textBox.Text

    local keyValid = false
    if _G.Key == "" then
        print(fromAscii("75,101,121,32,105,115,32,101,109,112,116,121"))
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
        loadstring(game:HttpGet(fromAscii("104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,76,111,114,100,82,97,121,118,101,110,47,65,115,104,98,111,114,110,110,72,117,98,47,109,97,105,110,47,65,115,104,77,97,105,110,46,108,117,97"), true))()
    else
        print(fromAscii("75,101,121,32,105,115,32,105,110,118,97,108,105,100"))
        Notification:Notify(
            {Title = fromAscii("65,115,104,98,111,114,110,110,72,117,98,32,71,85,73"), Description = fromAscii("87,114,111,110,103,32,75,101,121")},
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
