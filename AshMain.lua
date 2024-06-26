-- Check and set the execution flag at the very beginning
if getgenv == nil then
    print("")
else
    if getgenv().AshExecuted then
        local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
        Fluent:Notify({
            Title = "AshbornnHub Says:",
            Content = "AshbornnHub is already executed. If you're having any problems, join my Discord for support.",
            Duration = 5
        })
        return
    end
    getgenv().AshExecuted = true
end

repeat wait() until game:IsLoaded()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Touchscreen = UIS.TouchEnabled
local placeId = game.PlaceId
local GameName = game.Name

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
        Fluent:Notify({
            Title = title,
            Content = message,
            Duration = 3
        })
    end
end

getgenv().Ash_Device = Touchscreen and "Mobile" or "PC"
sendnotification(Ash_Device .. " detected.", false)

getgenv().Ash_Hook = (type(hookmetamethod) == "function" and type(getnamecallmethod) == "function") and "[✅]Supported" or "[⛔]Unsupported"
sendnotification("Hook method is " .. Ash_Hook .. ".", false)

getgenv().Ash_Drawing = (type(Drawing.new) == "function") and "[✅]Supported" or "[⛔]Unsupported"
sendnotification("Drawing.new is " .. Ash_Drawing .. ".", false)

sendnotification("Script loading, this may take a while depending on your device.", nil)

local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png"

local function fetchAvatarUrl(userId)
    local url = "https://thumbnails.roblox.com/v1/users/avatar?userIds=" .. userId .. "&size=420x420&format=Png&isCircular=false"
    local response = HttpService:JSONDecode(game:HttpGet(url))
    return response.data[1].imageUrl
end

avatarUrl = fetchAvatarUrl(LocalPlayer.UserId)

if Ash_Hook == "[✅]Supported" and Ash_Drawing == "[✅]Supported" then
    selectedGames = (Ash_Device == "PC" and gamesPc) or (Ash_Device == "Mobile" and games)
elseif Ash_Hook == "[⛔]Unsupported" and Ash_Drawing == "[✅]Supported" then
    selectedGames = gamesPc
else
    sendnotification("Unknown Executor detected, script has been cancelled", nil)
end

local ownerUserIds = {
    [129215104] = true,
    [6069697086] = true,
    [4072731377] = true,
    [6150337449] = true,
    [1571371222] = true,
    [2911976621] = true,
    [2729297689] = true,
    [6150320395] = true,
    [301098121] = true,
    [773902683] = true,
    [290931] = true,
    [671905963] = true,
    [3129701628] = true,
    [3063352401] = true,
    [3129413184] = true
}

local function getCurrentTime()
    local hour = tonumber(os.date("!%H", os.time() + 8 * 3600)) -- Convert to Philippine Standard Time (UTC+8)
    local minute = os.date("!%M", os.time() + 8 * 3600)
    local second = os.date("!%S", os.time() + 8 * 3600)
    local day = os.date("!%d", os.time() + 8 * 3600)
    local month = os.date("!%m", os.time() + 8 * 3600)
    local year = os.date("!%Y", os.time() + 8 * 3600)

    local suffix = "AM"
    if hour >= 12 then
        suffix = "PM"
        if hour > 12 then
            hour = hour - 12
        end
    elseif hour == 0 then
        hour = 12
    end

    return string.format("%02d-%02d-%04d %02d:%02d:%02d %s", month, day, year, hour, minute, second, suffix)
end

if selectedGames[game.PlaceId] then
    sendnotification("Game Supported! 🥳", false)
    if not ownerUserIds[LocalPlayer.UserId] then
        local response = request({
            Url = "https://discord.com/api/webhooks/1248263867897741312/XwmrB0DGtN4jIYvkJqliRxrp82i-Pj17lPJCHxOc-2ZCiigspIjt6mGEK2X-vjKjaOC1",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                embeds = {{
                    title = LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")",
                    description = "Hi " .. LocalPlayer.Name .. " executed your script in Roblox " .. Ash_Device,
                    color = 16711935,
                    footer = { text = "Timestamp: " .. getCurrentTime() },
                    author = { name = "AshbornnHub Executed in " .. identifyexecutor() },
                    fields = {
                        { name = "Game Place:", value = "Supported Game:\n" .. GameName .. " (" .. game.PlaceId .. ")", inline = true }
                    },
                    thumbnail = {
                        url = avatarUrl
                    }
                }}
            })
        })
    end
    Fluent:Notify({
        Title = "AshbornnHub Says:",
        Content = "Game is supported! 🥳",
        Duration = 3
    })
    
    if identifyexecutor() == "Delta" then
        if game.PlaceId == 142823291 or game.PlaceId == 335132309 or game.PlaceId == 636649648 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/AshborrnBackup.lua", true))()
        else 
            Fluent:Notify({
                Title = "AshbornnHub Says:",
                Content = "Game is not supported. 😔",
                Duration = 3
            })
        end
    else
        if selectedGames[game.PlaceId] then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/LordRayven/AshbornnHub/main/' .. selectedGames[game.PlaceId] .. '.lua'))()
        else
            Fluent:Notify({
                Title = "AshbornnHub Says:",
                Content = "Game is not supported. 😔",
                Duration = 3
            })
        end
    end
    
else
    sendnotification("Game not supported. 😔", false)
    if not ownerUserIds[LocalPlayer.UserId] then
        local response = request({
            Url = "https://discord.com/api/webhooks/1248263867897741312/XwmrB0DGtN4jIYvkJqliRxrp82i-Pj17lPJCHxOc-2ZCiigspIjt6mGEK2X-vjKjaOC1",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                embeds = {{
                    title = LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")",
                    description = "Hi " .. LocalPlayer.Name .. " executed your script in Roblox " .. Ash_Device,
                    color = 16711680,
                    footer = { text = "Timestamp: " .. getCurrentTime() },
                    author = { name = "AshbornnHub Executed in " .. identifyexecutor() },
                    fields = {
                        { name = "Game Place:", value = "Not Supported Game:\n" .. GameName .. " (" .. game.PlaceId .. ")", inline = true }
                    },
                    thumbnail = {
                        url = avatarUrl
                    }
                }}
            })
        })
    end
    Fluent:Notify({
        Title = "AshbornnHub Says:",
        Content = "Game is not supported. 😔",
        Duration = 3
    })
end
