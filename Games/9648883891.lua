loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisInstanceProtect.lua"))()
-- This loadstring lets me (little) use ProtectInstance(<instance>) (and UnProtectInstance) to make it so a game cant see that its actually there. (its in the genv btw)
-- Docs for it: https://api.irisapp.ca/Scripts/docs/IrisProtectInstance/
-- Yes I just ctrl-c, ctrl-v'd this from the no-scope script :)

if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 9648883891 then return end

local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

getgenv().lastTick = tick()

local localPlr = game:GetService("Players").LocalPlayer

local ourColor = Color3.fromRGB(153, 148, 148)

function CheckConfigFile()
    if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Keybind.ROGUEHUB"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color = ourColor,
    Keybind = CheckConfigFile()
}

getgenv().settings = {
    autoPurchase = false,
    autoCollect = false,
    atmESP = false,
    textSize = 16,
    showDistance = false,
    walkSpeed = 16,
    infJump = false,
    spamLoop = false,
    message = "Leading a new way to exploit - Rogue Hub"
}

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    makefolder("Rogue Hub/Configs")
end

if readfile and isfile and isfile("Rogue Hub/Configs/FestivalTycoon_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/FestivalTycoon_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/FestivalTycoon_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local function espCreate(object, guiText, guiColor)
    local billboard = Instance.new("BillboardGui", object)
    ProtectInstance(billboard)
    billboard.Name = game:GetService("HttpService"):GenerateGUID(false)
    billboard.Adornee = object
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0,6,0,6)

    local high = Instance.new("Highlight", object)
    ProtectInstance(high)
    high.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    high.Adornee = object
    high.Name = game:GetService("HttpService"):GenerateGUID(false)
    high.FillColor = Color3.fromRGB(255,0,0)
    high.OutlineColor = high.FillColor
    high.FillTransparency = 0.4
    
    local text = Instance.new("TextLabel", billboard)
    ProtectInstance(text)
    text.Name = game:GetService("HttpService"):GenerateGUID(false)
    text.Text = guiText
    text.Font = "Ubuntu"
    text.TextStrokeTransparency = 0
    text.TextColor3 = guiColor
    text.BackgroundTransparency = 1
    
    text.AnchorPoint = Vector2.new(0.5, 0.9)
    text.Size = UDim2.new(0,98,0,78)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if text ~= nil then
            text.TextSize = getgenv().settings.textSize or 16
            
            if getgenv().settings.showDistance then
                local distance = math.floor((object.Position - localPlr.Character.HumanoidRootPart.Position).magnitude)
                text.Text = "ATM Machine | " .. distance .. " studs away"
            else
                text.Text = "ATM Machine"
            end
        end
        
        wait()
    end)
end

local function espDelete(objectPath)
    for _,v in ipairs(objectPath:GetChildren()) do
        if v:IsA("BillboardGui") or v:IsA("Highlight") then
            UnProtectInstance(v)
            v:Destroy()
        end
    end
end

localPlr.CharacterAdded:Connect(function()
    local humanoid = localPlr.Character:WaitForChild("Humanoid")
    
    humanoid.WalkSpeed = getgenv().settings.walkSpeed
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Libs/BracketV3.lua"))()
local notifLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Libs/Notifications.lua"))()

local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("Main")

-- Exploits

local exploitSec = mainTab:CreateSection("Exploits")

local purchaseAuto = exploitSec:CreateToggle("Auto Purchase", getgenv().settings.autoPurchase or false, function(bool)
    getgenv().settings.autoPurchase = bool
    saveSettings()
end)

purchaseAuto:AddToolTip("Automatically purchases upgrades for your tycoon")

local collectAuto = exploitSec:CreateToggle("Auto Collect", getgenv().settings.autoCollect or false, function(bool)
    getgenv().settings.autoCollect = bool
    saveSettings()
end)

collectAuto:AddToolTip("Automatically collects money that comes from ATM Machines.")

exploitSec:CreateTextBox("Get Specific Money", "Type in any amount of money", true, function(value)
	game:GetService("ReplicatedStorage").RemoteObjects.DanceGameCash:FireServer(value)
end)

exploitSec:CreateButton("Get Infinite Money", function()
    game:GetService("ReplicatedStorage").RemoteObjects.DanceGameCash:FireServer(math.huge)
end)

exploitSec:CreateTextBox("Lose Specific Money", "Type in any amount of money", true, function(value)
	game:GetService("ReplicatedStorage").RemoteObjects.DanceGameCash:FireServer(-value)
end)

exploitSec:CreateButton("Lose Infinite Money", function()
    game:GetService("ReplicatedStorage").RemoteObjects.DanceGameCash:FireServer(-math.huge)
end)

-- Visuals

local visualSec = mainTab:CreateSection("Visuals")

visualSec:CreateToggle("ATM Machine ESP", getgenv().settings.atmESP or false, function(bool)
    getgenv().settings.atmESP = bool
    saveSettings()
    
    if getgenv().settings.atmESP then
        for _, v in next, workspace:GetDescendants() do
            if string.find(v.Name, "Display") and string.find(v.Parent.Name, "Collector") then
                espCreate(v, "ATM Machine", Color3.fromRGB(255,255,0))
            end
        end
    else
        for _, v in next, workspace:GetDescendants() do
            if string.find(v.Name, "Display") and string.find(v.Parent.Name, "Collector") then
                espDelete(v)
            end
        end
    end
end)

visualSec:CreateToggle("Show Distance", getgenv().settings.showDistance or false, function(bool)
    getgenv().settings.showDistance = bool
    saveSettings()
end)

visualSec:CreateSlider("ESP Text Size", 16,100,getgenv().settings.textSize or 16,true, function(value)
	getgenv().settings.textSize = value
	saveSettings()
end)

-- Player

local playerSec = mainTab:CreateSection("Player")

playerSec:CreateToggle("Infinite Jump", getgenv().settings.infJump or false, function(bool)
    getgenv().settings.infJump = bool
    saveSettings()
end)

local spamChat = playerSec:CreateToggle("Chat Spam", getgenv().settings.spamLoop or false, function(bool)
    getgenv().settings.spamLoop = bool
    saveSettings()
end)

spamChat:AddToolTip("Spams a message in the chat.")

playerSec:CreateSlider("Walkspeed", 16,200,getgenv().settings.walkSpeed or 16,true, function(value)
	getgenv().settings.walkSpeed = value
	
	if localPlr.Character then
	    localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkSpeed
	end
	
	saveSettings()
end)

playerSec:CreateButton("Goto Speedboat", function()
    if localPlr.Character and workspace[localPlr.Name .. " Tycoon"]:FindFirstChild("Speedboat") ~= nil then
        localPlr.Character.PrimaryPart.CFrame = workspace[localPlr.Name .. " Tycoon"].Speedboat.Base.CFrame  
    end
end)

playerSec:CreateButton("Teleport to Tycoon", function()
	if workspace[localPlr.Name .. " Tycoon"] then
	    localPlr.Character.PrimaryPart.CFrame = workspace[localPlr.Name .. " Tycoon"].DefaultBuild.StartDocks.StartDockBoarding:FindFirstChildOfClass("MeshPart").CFrame * CFrame.new(0,5,0)
	end
end)

local chatBox = playerSec:CreateTextBox("Spam Message", "numbers and letters", false, function(text)
	getgenv().settings.message = text
	saveSettings()
end)

chatBox:SetValue(getgenv().settings.message or "Leading a new way to exploit - Rogue Hub")

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

-- Credits

local infoSec = infoTab:CreateSection("Credits")

local req = http_request or request or syn.request

infoSec:CreateButton("Founder of Rogue Hub: Kitzoon#7750", function()
    setclipboard("Kitzoon#7750")

    notifLib:Notification("Copied Kitzoon's discord username and tag to your clipboard.", 5)
end)

infoSec:CreateButton("Help with a lot: Kyron#6083", function()
    setclipboard("Kyron#6083")
    
    notifLib:Notification("Copied Kyron's discord username and tag to your clipboard.", 5)
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
        
        notifLib:Notification("Copied our discord server to your clipboard.", 5)
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
    if getgenv().settings.autoPurchase then
        for _,v in pairs(workspace.Buttons:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Head") ~= nil and v.Head.Transparency ~= 1 then
                game:GetService("ReplicatedStorage").RemoteObjects.RequestButtonPurchase:FireServer(v.Name) 
            end
        end
    end
    
    if getgenv().settings.autoCollect then
        game:GetService("ReplicatedStorage").RemoteObjects.CollectedMoney:FireServer()
    end
    
    if getgenv().settings.infJump and localPlr.Character and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
    
    if getgenv().settings.spamLoop then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv().settings.message or "Leading a new way to exploit - Rogue Hub", "All")
    end
    
    wait()
end)

sound:Destroy()
task.wait(5)

notifLib:Notification("Rogue Hub took " .. math.floor(tick() - getgenv().lastTick) .. " seconds to load!", 5)