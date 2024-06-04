-- Roblox LocalScript

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- Function to load the appropriate script based on the game PlaceId and device type
local function loadScript(url, assetId)
    if assetId then
        loadstring(game:GetObjects(assetId)[1].Source)()
    else
        loadstring(game:HttpGet(url, true))()
    end
end

-- Function to determine the device type and load the corresponding script
local function determineDevice()
    local isMobile = UserInputService.TouchEnabled
    local placeId = game.PlaceId
    
    if isMobile then
        if placeId == 142823291 then
            loadScript("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/AshbornnHubMM2v3.lua")
        elseif placeId == 893973440 then
            loadScript("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/FleeFacility.lua")
        elseif placeId == 70005410 then
            loadScript("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/BloxHunt")
        else
            loadScript("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/Uni.lua")
        end
    else
        if placeId == 142823291 then
            loadScript(nil, "rbxassetid://17620017454")
        elseif placeId == 893973440 then
            loadScript(nil, "rbxassetid://17620276293")
        elseif placeId == 70005410 then
            loadScript("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/BloxHunt")
        else
            loadScript("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/Uni.lua")
        end
    end
end

-- Call the function when the script runs
determineDevice()

-- Optional: Connect the function to events if you need to re-check the device type later
UserInputService.TouchStarted:Connect(determineDevice)
UserInputService.InputBegan:Connect(determineDevice)
