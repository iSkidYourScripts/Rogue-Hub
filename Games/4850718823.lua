if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 4850718823 then return end

local sound = Instance.new("Sound")
sound.Parent = game:GetService("Workspace")
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

local ourColor = Color3.fromRGB(201,144,150)

function CheckConfigFile()
    if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Keybind.ROGUEHUB"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Skate Park",
    Color = ourColor,
    Keybind = CheckConfigFile()
}

getgenv().settings = {
    creditDistance = 1000,
    creditsESP = false,
    breakerTog = false,
    xpFarm = false,
    creditsTog = false
}

local localPlr = game:GetService("Players").LocalPlayer

local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("Skate Park")

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    makefolder("Rogue Hub/Configs")
end

if readfile and isfile and isfile("Rogue Hub/Configs/SkatePark_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/SkatePark_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/SkatePark_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local function hasSkateboard()
    for _, v in next, localPlr.Character:GetChildren() do
        if v.Name == "Skateboard2021" and v:IsA("Model") then
            return true
        end
    end
end

-- Farming

local farmSec = mainTab:CreateSection("Farming")

local badgesBut = farmSec:CreateButton("Get Badges", function()
    for _, v in next, game:GetService("Workspace").Map:GetDescendants() do
        if v.Name == "BadgeAwarder" and v:IsA("Model") and v:FindFirstChild("Platform") then
            firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v.Platform, 0)
            firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v.Platform, 1)
        end
    end
end)

local xpBut = farmSec:CreateToggle("XP Farm", getgenv().settings.xpFarm, function(bool)
    getgenv().settings.xpFarm = bool
    saveSettings()
end)

xpBut:AddToolTip("Spam's tricks for you to get XP")

local creditTog = farmSec:CreateToggle("Credits Farm", getgenv().settings.creditsTog, function(bool)
    getgenv().settings.creditsTog = bool
    saveSettings()
end)

creditTog:AddToolTip("Warning: collecting credits while this is enabled will break the farm")

-- Visuals

local visualSec = mainTab:CreateSection("Visuals")

local function esp(credit)
    local espText = Drawing.new("Text")
    espText.Visible = false
    espText.Center = true
    espText.Outline = true
    espText.Font = 3
    espText.Color = credit.Color
    espText.Size = 16
    
    credit.AncestryChanged:Connect(function(child, parent)
        if not child or not parent and getgenv().settings.creditsESP then
            espText:Remove()
            connection:Disconnect()
        end
    end)
    
    -- for optimization ig
    if getgenv().settings.creditsESP == false and espText and connection then
        espText.Visible = false
        espText:Remove()
        connection:Disconnect()
    end
    
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        local creditPos, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(credit.Position)

        if onScreen and getgenv().settings.creditsESP and localPlr:DistanceFromCharacter(credit.Position) < getgenv().settings.creditDistance and espText and connection then
            espText.Position = Vector2.new(creditPos.X, creditPos.Y)
            espText.Text = "Credit"
            espText.Visible = true
        else
            if espText then
                espText.Visible = false
            end
        end
    end)
end

local creditESPTog = visualSec:CreateToggle("Credits ESP", getgenv().settings.creditsESP, function(bool)
    getgenv().settings.creditsESP = bool
    saveSettings()
    
    if getgenv().settings.creditsESP then
        for _, credit in next, game:GetService("Workspace").Collectables.Storage:GetChildren() do
            if credit.Name == "Credit" and credit:IsA("Model") and credit:FindFirstChildOfClass("MeshPart") and getgenv().settings.creditsESP then
                esp(credit.Root)
            end
        end
    end
end)

-- if new credits are added
game:GetService("Workspace").Collectables.Storage.ChildAdded:Connect(function(credit)
    if credit.Name == "Credit" and credit:IsA("Model") and credit:FindFirstChildOfClass("MeshPart") and getgenv().settings.creditsESP then
        esp(credit.Root)
    end
end)

local distanceSlider = visualSec:CreateSlider("Distance Radius", 0,1000,getgenv().settings.creditDistance,true, function(value)
	getgenv().settings.creditDistance = value
    saveSettings()
end)

-- Teleports

local teleSec = mainTab:CreateSection("Teleporting")

teleSec:CreateButton("Warehouse", function()
    if not hasSkateboard() then
        localPlr.Character.HumanoidRootPart.CFrame = CFrame.new(-1022.65997, 147.16539, 3028.60498, -0.875416875, -4.63443222e-08, 0.483368725, -8.29182554e-08, 1, -5.42933734e-08, -0.483368725, -8.7609429e-08, -0.875416875)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Error",
            Text = "For teleports to work you need to get off your skateboard.",
            Duration = 5
        })
    end
end)

teleSec:CreateButton("Indoor Skatepark", function()
    if not hasSkateboard() then
        localPlr.Character.HumanoidRootPart.CFrame = CFrame.new(-87.9039154, 130.067047, 3113.10254, -0.965112507, 2.99084384e-08, 0.261835486, 3.49577789e-08, 1, 1.46265586e-08, -0.261835486, 2.3269461e-08, -0.965112507)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Error",
            Text = "For teleports to work you need to get off your skateboard.",
            Duration = 5
        })
    end
end)

teleSec:CreateButton("Loop", function()
    if not hasSkateboard() then
        localPlr.Character.HumanoidRootPart.CFrame = CFrame.new(463.830078, 203.362656, 2913.56567, -0.105732545, -1.14461338e-08, 0.9943946, 8.2595335e-08, 1, 2.0292898e-08, -0.9943946, 8.42779713e-08, -0.105732545)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Error",
            Text = "For teleports to work you need to get off your skateboard.",
            Duration = 5
        })
    end
end)

teleSec:CreateButton("Mega Ramp", function()
    if not hasSkateboard() then
        localPlr.Character.HumanoidRootPart.CFrame = CFrame.new(-1035.90771, 318.391998, 1663.12561, -0.999331474, 2.4673513e-08, 0.0365597308, 2.1454829e-08, 1, -8.84313565e-08, -0.0365597308, -8.7587857e-08, -0.999331474)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Error",
            Text = "For teleports to work you need to get off your skateboard.",
            Duration = 5
        })
    end
end)

teleSec:CreateButton("Shops", function()
    if not hasSkateboard() then
        localPlr.Character.HumanoidRootPart.CFrame = CFrame.new(-30.3401909, 130.067047, 2032.8822, 0.999581039, 7.79592995e-08, 0.0289443526, -7.90784966e-08, 1, 3.75223799e-08, -0.0289443526, -3.9795534e-08, 0.999581039)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Error",
            Text = "For teleports to work you need to get off your skateboard.",
            Duration = 5
        })
    end
end)

-- Misc

local miscSec = mainTab:CreateSection("Misc")

local breakTog = miscSec:CreateToggle("Board Breaker", getgenv().settings.breakerTog, function(bool)
    getgenv().settings.breakerTog = bool
    saveSettings()
end)

breakTog:AddToolTip("Breaks the mechanics of your board on jump/ollie.")

-- Info

local infoTab = window:CreateTab("Extra")
local uiSec = infoTab:CreateSection("UI Settings")

local uiColor = uiSec:CreateColorpicker("UI Color", function(color)
	window:ChangeColor(color)
end)

uiColor:UpdateColor(Config.Color)

local uiTog = uiSec:CreateToggle("UI Toggle", nil, function(bool)
	window:Toggle(bool)
end)

uiTog:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else Config.Keybind = Enum.KeyCode[key]; writefile("/Rogue Hub/Configs/Keybind.ROGUEHUB", game:GetService("HttpService"):JSONEncode({Key = key})) end
end)

uiTog:SetState(true)

local uiRainbow = uiSec:CreateToggle("Rainbow UI", nil, function(bool)
	getgenv().rainbowUI = bool
	
	if getgenv().rainbowUI == false then
	    window:ChangeColor(Config.Color)
	end
    
    while getgenv().rainbowUI and task.wait() do
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
            
        window:ChangeColor(rainbow)
        uiColor:UpdateColor(rainbow)
    end
end)

local infoSec = infoTab:CreateSection("Credits")

local req = http_request or request or syn.request

infoSec:CreateButton("Founder of Rogue Hub: Kitzoon#7750", function()
    setclipboard("Kitzoon#7750")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Note",
        Text = "Copied Kitzoon's discord username and tag to your clipboard.",
        Duration = 5
    })
end)

infoSec:CreateButton("Help with a lot: Kyron#6083", function()
    setclipboard("Kyron#6083")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Note",
        Text = "Copied Kyron's discord username and tag to your clipboard.",
        Duration = 5
    })
end)

infoSec:CreateButton("Consider donating on PayPal!", function()
    setclipboard("https://paypal.me/RogueHub")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Note",
        Text = "Copied our PayPal donate page to your clipboard, donate any amount to it!",
        Duration = 5
    })
end)

infoSec:CreateButton("Consider donating on Bitcoin!", function()
    setclipboard("bc1qh8axzk8udu7apye7l384s5m6rt4d24rdwgkkcz")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Note",
        Text = "Copied our Bitcoin address to your clipboard, donate any amount to it!",
        Duration = 5
    })
end)

infoSec:CreateButton("Join us on discord!", function()
	if req then
        req({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            
            Headers = {
                ["Content-Type"] = "application/json",
                ["origin"] = "https://discord.com",
            },
                    
            Body = game:GetService("HttpService"):JSONEncode(
            {
                ["args"] = {
                ["code"] = "c4xWZ4G4bx",
                },
                        
                ["cmd"] = "INVITE_BROWSER",
                ["nonce"] = "."
            })
        })
    else
        setclipboard("https://discord.gg/c4xWZ4G4bx")
    
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Note",
            Text = "Copied our discord server to your clipboard.",
            Duration = 5
        })
    end
end)
-- Misc
local miscSec = infoTab:CreateSection("Miscellaneous")
local zoomBackup = localPlr.CameraMaxZoomDistance

local server = miscSec:CreateButton("Serverhop", function()
    -- credits to: inf yield for there serverhop
    local serverList = {}
    
    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
    	if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
    		serverList[#serverList + 1] = v.id
    	end
    end
    
    if #serverList > 0 then
    	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
    else
        error("No servers found")
    end
end)

server:AddToolTip("Joins a different server than the one you're currently in.")

local camZoom = miscSec:CreateToggle("Infinite Zoom", false, function(bool)
    if bool then
        localPlr.CameraMaxZoomDistance = math.huge
    else
        localPlr.CameraMaxZoomDistance = zoomBackup
    end
end)

camZoom:AddToolTip("Lets you infinitely change your camera's zoom.")

local asset = getcustomasset or syn and getsynasset

if asset and isfile and writefile then
    local soundsToggled = miscSec:CreateToggle("Toggle Sounds", false, function(bool)
        getgenv().settings.toggleSounds = bool
    end)
    
    soundsToggled:AddToolTip("plays a sound when enabling or disabling a feature.")
end

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().settings.breakerTog and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and localPlr.Character:FindFirstChild("Humanoid") then
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    if getgenv().settings.xpFarm then
        game:GetService("ReplicatedStorage").lib.Network.RidePacket:FireServer("ACTIVE_TRICK", "Boards", "Impossible")
        game:GetService("ReplicatedStorage").lib.Network.RidePacket:FireServer("ACTIVE_TRICK", "Boards", "VarialKick")
        game:GetService("ReplicatedStorage").lib.Network.RidePacket:FireServer("ACTIVE_TRICK", "Boards", "VarialHeel")
        game:GetService("ReplicatedStorage").lib.Network.RidePacket:FireServer("ACTIVE_TRICK", "Boards", "Hardflip")
        game:GetService("ReplicatedStorage").lib.Network.RidePacket:FireServer("ACTIVE_TRICK", "Boards", "Treflip")
    end

    if getgenv().settings.creditsTog then
        for _, v in next, game:GetService("Workspace").Collectables.Storage:GetChildren() do
            if v.Name == "Credit" and v:IsA("Model") and v:FindFirstChildOfClass("MeshPart") and getgenv().settings.creditsTog then
                firetouchinterest(localPlr.Character.HumanoidRootPart, v.Root, 0)
                firetouchinterest(localPlr.Character.HumanoidRootPart, v.Root, 1)
                
                v:Destroy()
                task.wait(1)
            end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Message",
    Text = "Sucessfully Loaded!",
    Duration = 5
})

sound:Destroy()
getgenv().isLoaded = true
task.wait(5)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Fact",
    Text = "Rogue hub has over 3500+ lines of code!",
    Duration = 10
})
