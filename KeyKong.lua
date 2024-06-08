local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/NotificationHolder.lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/Notification.lua"))()

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeySystemGUI"

-- Frame for UI elements
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.5, -125, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(97, 62, 167)
frame.BackgroundTransparency = 0.7  -- Set transparency to 70%
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Apply UICorner for rounded corners
local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 8)

local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Size = UDim2.new(0.85, 0, 0.2, 0) -- Adjusted size
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "AshbornnHub KeySystem"
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1  -- Fully transparent background for label
titleLabel.BorderSizePixel = 0

local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0) -- Adjusted position
closeButton.Text = "X"
closeButton.TextScaled = true
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundTransparency = 0.7  -- Set transparency to 70%
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.SourceSansBold

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.8, 0, 0.2, 0)
textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
textBox.PlaceholderText = "Enter Key"  -- Set the placeholder text
textBox.Text = ""  -- Ensure the TextBox is initially empty
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textBox.BackgroundTransparency = 0.7  -- Set transparency to 70%
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BorderSizePixel = 0
textBox.Font = Enum.Font.SourceSans

-- Optionally, add a function to clear any unexpected text assignments
local function clearUnexpectedText()
    if textBox.Text == "TextBox" then
        textBox.Text = ""
    end
end

-- Call the function to clear unexpected text
clearUnexpectedText()

local getKeyButton = Instance.new("TextButton", frame)
getKeyButton.Size = UDim2.new(0.35, 0, 0.2, 0)
getKeyButton.Position = UDim2.new(0.1, 0, 0.55, 0)
getKeyButton.Text = "Get Key"
getKeyButton.TextScaled = true
getKeyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
getKeyButton.BackgroundTransparency = 0.7  -- Set transparency to 70%
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.BorderSizePixel = 0
getKeyButton.Font = Enum.Font.SourceSansBold

local checkKeyButton = Instance.new("TextButton", frame)
checkKeyButton.Size = UDim2.new(0.35, 0, 0.2, 0)
checkKeyButton.Position = UDim2.new(0.55, 0, 0.55, 0)
checkKeyButton.Text = "Check Key"
checkKeyButton.TextScaled = true
checkKeyButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
checkKeyButton.BackgroundTransparency = 0.7  -- Set transparency to 70%
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.BorderSizePixel = 0
checkKeyButton.Font = Enum.Font.SourceSansBold

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Get Key button functionality
getKeyButton.MouseButton1Click:Connect(function()
   local url = "https://loot-link.com/s?ed7176e3c6a95569"
   setclipboard(url)
end)

-- Load saved key if available
local function loadSavedKey()
    local success, key = pcall(readfile, "AshbornnHub/saved_key.txt")
    if success and key then
        return key
    else
        return nil
    end
end

-- Save key to file
local function saveKey(key)
    pcall(writefile, "AshbornnHub/saved_key.txt", key)
end

local function CheckKey()
    _G.Key = textBox.Text
    local userkey = "https://pastebin.com/raw/aMp6mHAs"
    local key = game:HttpGet(userkey, true)
    local plr = game.Players.LocalPlayer

    -- Ensure exact match with key and handle multiple keys
    local keys = {}
    for k in key:gmatch("%S+") do
        table.insert(keys, k)
    end

    local keyValid = false
    for _, k in ipairs(keys) do
        if k == _G.Key then
            keyValid = true
            break
        end
    end

    if keyValid then
        saveKey(_G.Key) -- Save the key if it is correct
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/loader", true))()
    else
        print("Key is invalid")  -- Debugging print statement
        Notification:Notify(
            {Title = "AshbornnHub GUI", Description = "Wrong Key"},
            {OutlineColor = Color3.fromRGB(97, 62, 167), Time = 7, Type = "default"}
        )
    end
end

-- Check Key button functionality
checkKeyButton.MouseButton1Click:Connect(CheckKey)

-- Pre-fill the TextBox with the saved key if it exists and automatically check it
local savedKey = loadSavedKey()
if savedKey then
    textBox.Text = savedKey
    CheckKey()  -- Automatically check the key if it is loaded
end
