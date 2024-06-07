local Nofitication = {}

local GUI = game:GetService("CoreGui"):FindFirstChild("STX_Nofitication")
if not GUI then
    GUI = Instance.new("ScreenGui")
    GUI.Name = "STX_Nofitication"
    GUI.Parent = game:GetService("CoreGui")
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type))
    local ambientShadow = Instance.new("ImageLabel")
    local Window = Instance.new("Frame")
    local Outline_A = Instance.new("Frame")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    
    ambientShadow.Name = "ambientShadow"
    ambientShadow.Parent = GUI
    ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    ambientShadow.BackgroundTransparency = 1.000
    ambientShadow.BorderSizePixel = 0
    ambientShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    ambientShadow.Size = UDim2.new(0, 0, 0, 0)
    ambientShadow.Image = "rbxassetid://1316045217"
    ambientShadow.ImageColor3 = Color3.fromRGB(20, 20, 20)
    ambientShadow.ImageTransparency = 0.300
    ambientShadow.ScaleType = Enum.ScaleType.Slice
    ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    
    Window.Name = "Window"
    Window.Parent = ambientShadow
    Window.BackgroundColor3 = Color3.fromRGB(128, 0, 128)  -- Purple color
    Window.BackgroundTransparency = 0.5  -- 50% transparent
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 5, 0, 5)
    Window.Size = UDim2.new(0, 230, 0, 80)
    Window.ZIndex = 2
    
    Outline_A.Name = "Outline_A"
    Outline_A.Parent = Window
    Outline_A.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Outline_A.BorderSizePixel = 0
    Outline_A.Position = UDim2.new(0, 0, 0, 25)
    Outline_A.Size = UDim2.new(0, 230, 0, 2)
    Outline_A.ZIndex = 5
    
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowTitle.BackgroundTransparency = 1.000
    WindowTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 8, 0, 2)
    WindowTitle.Size = UDim2.new(0, 222, 0, 22)
    WindowTitle.ZIndex = 4
    WindowTitle.Font = Enum.Font.GothamSemibold
    WindowTitle.Text = nofdebug.Title
    WindowTitle.TextColor3 = Color3.fromRGB(180, 180, 255)
    WindowTitle.TextSize = 12.000
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowDescription.BackgroundTransparency = 1.000
    WindowDescription.BorderColor3 = Color3.fromRGB(27, 42, 53)
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 8, 0, 34)
    WindowDescription.Size = UDim2.new(0, 216, 0, 40)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.GothamSemibold
    WindowDescription.Text = nofdebug.Description
    WindowDescription.TextColor3 = Color3.fromRGB(120, 120, 255)
    WindowDescription.TextSize = 12.000
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top

    local function destroyNotification()
        ambientShadow:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.2)
        wait(0.2)
        ambientShadow:Destroy()
    end

    if SelectedType == "default" then
        ambientShadow:TweenSize(UDim2.new(0, 240, 0, 90), "Out", "Linear", 0.2)
        Window.Size = UDim2.new(0, 230, 0, 80)
        Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", middledebug.Time)
        wait(middledebug.Time)
        destroyNotification()
    elseif SelectedType == "image" then
        ambientShadow:TweenSize(UDim2.new(0, 240, 0, 90), "Out", "Linear", 0.2)
        Window.Size = UDim2.new(0, 230, 0, 80)
        WindowTitle.Position = UDim2.new(0, 24, 0, 2)
        local ImageButton = Instance.new("ImageButton")
        ImageButton.Parent = Window
        ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ImageButton.BackgroundTransparency = 1.000
        ImageButton.BorderSizePixel = 0
        ImageButton.Position = UDim2.new(0, 4, 0, 4)
        ImageButton.Size = UDim2.new(0, 18, 0, 18)
        ImageButton.ZIndex = 5
        ImageButton.AutoButtonColor = false
        ImageButton.Image = all.Image
        ImageButton.ImageColor3 = all.ImageColor
        Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", middledebug.Time)
        wait(middledebug.Time)
        destroyNotification()
    elseif SelectedType == "option" then
        ambientShadow:TweenSize(UDim2.new(0, 240, 0, 110), "Out", "Linear", 0.2)
        Window.Size = UDim2.new(0, 230, 0, 100)
        local Uncheck = Instance.new("ImageButton")
        local Check = Instance.new("ImageButton")
        
        Uncheck.Name = "Uncheck"
        Uncheck.Parent = Window
        Uncheck.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Uncheck.BackgroundTransparency = 1.000
        Uncheck.BorderSizePixel = 0
        Uncheck.Position = UDim2.new(0, 7, 0, 76)
        Uncheck.Size = UDim2.new(0, 18, 0, 18)
        Uncheck.ZIndex = 5
        Uncheck.AutoButtonColor = false
        Uncheck.Image = "http://www.roblox.com/asset/?id=6031094678"
        Uncheck.ImageColor3 = Color3.fromRGB(255, 84, 84)
        
        Check.Name = "Check"
        Check.Parent = Window
        Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Check.BackgroundTransparency = 1.000
        Check.BorderSizePixel = 0
        Check.Position = UDim2.new(0, 28, 0, 76)
        Check.Size = UDim2.new(0, 18, 0, 18)
        Check.ZIndex = 5
        Check.AutoButtonColor = false
        Check.Image = "http://www.roblox.com/asset/?id=6031094667"
        Check.ImageColor3 = Color3.fromRGB(83, 230, 50)

        local function handleOption(callback)
            pcall(function()
                callback()
            end)
            destroyNotification()
        end

        Uncheck.MouseButton1Click:Connect(function()
            handleOption(function()
                all.Callback(false)
            end)
        end)
        
        Check.MouseButton1Click:Connect(function()
            handleOption(function()
                all.Callback(true)
            end)
        end)
        
        Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", middledebug.Time)
        wait(middledebug.Time)
        if ambientShadow and ambientShadow.Parent then
            destroyNotification()
        end
    end
end

return Nofitication
