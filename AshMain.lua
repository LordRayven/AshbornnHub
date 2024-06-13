repeat wait() until game:IsLoaded()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Touchscreen = UIS.TouchEnabled
local placeId = game.PlaceId
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local games = {
    [142823291] = 'AshborrnHubFluentUI',
    [335132309] = 'AshborrnHubFluentUI',
    [636649648] = 'AshborrnHubFluentUI',
    [70005410] = 'BloxHunt',
    [893973440] = 'FleeFacility',
}

local gamesPc = {
    [142823291] = 'AshborrnSolara',
    [335132309] = 'AshborrnSolara',
    [636649648] = 'AshborrnSolara',
    [70005410] = 'BloxHunt',
    [893973440] = 'FleeFacility',
}

local LocalPlayer = Players.LocalPlayer

function sendnotification(message, type)
    local title = "Welcome to AshborrnHub GUI (" .. LocalPlayer.Name .. ")"
    if type == false or type == nil then
        print("[ AshborrnHub ]: " .. message)
    end
    if type == true or type == nil then
        if Ash_Device == "Mobile" then
            StarterGui:SetCore("SendNotification", {
                Title = title;
                Text = message;
                Duration = 7;
            })
        else
            Fluent:Notify({
                    Title = title,
                    Content = message,
                    Duration = 3
                })
        end
    end
end

getgenv().AshExecuted = false
if getgenv().AshExecuted then
    sendnotification("Script already executed, if you're having any problems join discord.gg/pethicial for support.", nil)
    return
end
getgenv().AshExecuted = true

--------------------------------------------------------------------------------------LOADER----------------------------------------------------------------------------------------
getgenv().Ash_Device = Touchscreen and "Mobile" or "PC"
sendnotification(Ash_Device .. " detected.", false)

getgenv().Ash_Hook = (type(hookmetamethod) == "function" and type(getnamecallmethod) == "function") and "Supported" or "Unsupported"
sendnotification("Hook method is " .. Ash_Hook .. ".", false)

getgenv().Ash_Drawing = (type(Drawing.new) == "function") and "Supported" or "Unsupported"
sendnotification("Drawing.new is " .. Ash_Drawing .. ".", false)

sendnotification("Script loading, this may take a while depending on your device.", nil)

local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=150&height=150&format=png"

local function fetchAvatarUrl(userId)
    local url = "https://thumbnails.roblox.com/v1/users/avatar?userIds=" .. userId .. "&size=30x30&format=Png&isCircular=false"
    local response = HttpService:JSONDecode(game:HttpGet(url))
    return response.data[1].imageUrl
end

avatarUrl = fetchAvatarUrl(LocalPlayer.UserId)

-- Determine the correct table to use based on the device
local selectedGames = Ash_Device == "PC" and gamesPc or games

if selectedGames[game.PlaceId] then
    sendnotification("Game Supported!", false)
    local response = request({
        Url = "https://discord.com/api/webhooks/1248263867897741312/XwmrB0DGtN4jIYvkJqliRxrp82i-Pj17lPJCHxOc-2ZCiigspIjt6mGEK2X-vjKjaOC1",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            embeds = {{
                title = LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")",
                description = "Hi " .. LocalPlayer.Name .. " Executed Your Script in Roblox " .. Ash_Device,
                color = 16711935,
                footer = { text = "" },
                author = { name = "AshbornnHub Executed In " .. identifyexecutor() },
                fields = {
                    { name = "Game Place:", value = "Supported Game:\n" .. GameName .. " (" .. game.PlaceId .. ")", inline = true }
                },
                thumbnail = {
                    url = avatarUrl
                }
            }}
        })
    })
    loadstring(game:HttpGet('https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/' .. selectedGames[game.PlaceId] .. '.lua'))()
else
    sendnotification("Game not Supported.", false)
    local response = request({
        Url = "https://discord.com/api/webhooks/1248263867897741312/XwmrB0DGtN4jIYvkJqliRxrp82i-Pj17lPJCHxOc-2ZCiigspIjt6mGEK2X-vjKjaOC1",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            embeds = {{
                title = LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")",
                description = "Hi " .. LocalPlayer.Name .. " Executed Your Script in Roblox " .. Ash_Device,
                color = 16711680,
                footer = { text = "" },
                author = { name = "AshbornnHub Executed In " .. identifyexecutor() },
                fields = {
                    { name = "Game Place:", value = "Not Supported Game:\n" .. GameName .. " (" .. game.PlaceId .. ")", inline = true }
                },
                thumbnail = {
                    url = avatarUrl
                }
            }}
        })
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/UniversalAshbornn.lua", true))()
end
