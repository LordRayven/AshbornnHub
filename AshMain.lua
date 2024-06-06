--[[
    ASHBORRNHUB LOADER SOURCE

    AshbornnHub

    Credits:
        Ashbornn
]]

repeat wait() until game:IsLoaded()

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Touchscreen = UIS.TouchEnabled

local games = {
    [142823291] = 'AshbornnHubMM2v3',
    [335132309] = 'AshbornnHubMM2v3',
    [636649648] = 'AshbornnHubMM2v3',
    [70005410] = 'BloxHunt',
    [893973440] = 'FleeFacility',
}

function sendnotification(message, type)
    if type == false or type == nil then
        print("[ AshborrnHub ]: " .. message)
    end
    if type == true or type == nil then
        if Ash_Device == "Mobile" then
            StarterGui:SetCore("SendNotification", {
                Title = "AshborrnHub GUI";
                Text = message;
                Duration = 7;
            })
        else
            Notification:Notify(
                {Title = "AshbornnHub GUI", Description = message},
                {OutlineColor = Color3.fromRGB(97, 62, 167), Time = 4, Type = "default"}
            )
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

local LocalPlayer = Players.LocalPlayer
local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=150&height=150&format=png"

local function fetchAvatarUrl(userId)
    local url = "https://thumbnails.roblox.com/v1/users/avatar?userIds=" .. userId .. "&size=30x30&format=Png&isCircular=false"
    local response = HttpService:JSONDecode(game:HttpGet(url))
    return response.data[1].imageUrl
end

avatarUrl = fetchAvatarUrl(LocalPlayer.UserId)

if games[game.PlaceId] then
    sendnotification("Game Supported!", false)
    local response = request({
        Url = "https://discord.com/api/webhooks/1248263867897741312/XwmrB0DGtN4jIYvkJqliRxrp82i-Pj17lPJCHxOc-2ZCiigspIjt6mGEK2X-vjKjaOC1",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            embeds = {{
                title = LocalPlayer.Name,
                description = games[game.PlaceId],
                color = 16711680,
                footer = { text = "" },
                author = { name = "AshbornnHub Executed By" },
                fields = {
                    { name = "GamePlace", value = game.Name, inline = true }
                },
                thumbnail = {
                    url = avatarUrl
                }
            }}
        })
    })
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/' .. games[game.PlaceId] .. '.lua'))()
else
    sendnotification("Game not Supported.", false)
    local response = request({
        Url = "https://discord.com/api/webhooks/1248263867897741312/XwmrB0DGtN4jIYvkJqliRxrp82i-Pj17lPJCHxOc-2ZCiigspIjt6mGEK2X-vjKjaOC1",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            embeds = {{
                title = LocalPlayer.Name,
                description = "Universal",
                color = 16711680,
                footer = { text = "" },
                author = { name = "AshbornnHub Executed By" },
                fields = {
                    { name = "GamePlace", value = game.Name, inline = true }
                },
                thumbnail = {
                    url = avatarUrl
                }
            }}
        })
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ashborrn/AshborrnHub/main/Uni.lua",true))()
end
