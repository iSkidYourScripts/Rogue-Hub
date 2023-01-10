if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 6407649031 then return end

--#region Performance Functions.

if getgc then
    local Guns = {}

    for i,v in ipairs(getgc(true)) do
        -- The reason I only do "RecoilMult" and "Damage" is because its really the only things that need to be identified to tell whether its a Gun Properties table or not.
        if type(v) == "table" and rawget(v, "RecoilMult") and rawget(v, "Damage") then
            table.insert(Guns, v)
        end
    end
    
    function ModifyGuns(Mod, value)
        for i,v in ipairs(Guns) do
            v[Mod] = value
        end
    end
end

--#endregion

local cambobFunc

if getgc and hookfunction then
    for _, v in ipairs(getgc()) do
	    local exploitFunction = isexecutorclosure or is_synapse_function or is_exploit_function	
		
        if type(v) == "function" and not exploitFunction(v) and getinfo(v).name == "cambob" then
            cambobFunc = v
        end
    end
end

local sound = Instance.new("Sound")
sound.Parent = game:GetService("Workspace")
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

function CheckConfigFile()
    if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Keybind.ROGUEHUB"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color = Color3.fromRGB(153, 148, 148),
    Keybind = CheckConfigFile()
}

local localPlr = game:GetService("Players").LocalPlayer
local mouseDown = false
getgenv().isLoaded = false
local isKilling = false
local isTyping = false
local espColor

getgenv().settings = {
    infJump = false,
    bunnyHop = false,
    triggerBot = false,
    aimBotTog = false,
    aimbotPart = "Head",
    fovRadius = 150,
    showFOV = false,
    toxicAuto = false,
    playerESP = false,
    playerDistance = 0,
    espWeapon = false,
    distanceESP = false,
    clipInf = false,
    rangeInf = false,
    reloadInstantly = false,
    equipInstantly = false,
    rateFire = false,
    oneHit = false,
    noRecoil = false,
    noSpread = false,
    walkSpeed = 20,
    rainbowFOV = false,
    killSound = "Default",
    autoLock = false,
    textSize = 15,
    fovColor = Color3.fromRGB(255,255,255),
    espColor = Color3.new(1,0,0),
    espRainbow = false
}

-- typing detector
game:GetService("UserInputService").InputBegan:Connect(function(input, typing)
    isTyping = typing
end)

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    makefolder("Rogue Hub/Configs")
end

if readfile and isfile and isfile("Rogue Hub/Configs/NoScopeArcade_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/NoScopeArcade_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/NoScopeArcade_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local function getQuote()
    local userQuotes = game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Quotes.ROGUEHUB"))
    return userQuotes[math.random(#userQuotes)]
end

-- Gets The Gun Model Of A Player. Player must be the character not the Player object
local function getGun(player)
    if #game:GetService("Workspace").CurrentCamera:GetChildren() == 0 then return nil end

    for _, v in ipairs(player:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Fire") then
            return v
        end
    end
end

-- NO MIKEY ALLOWED THAT RETARDS A FUCKING SKID (also if you see this then cool you found the second easter egg)

local function esp(object, text, color)
    local espText = Drawing.new("Text")
    espText.Visible = false
    espText.Center = true
    espText.Outline = true
    espText.Font = 3
    espText.Color = color
    
    if getgenv().settings.playerESP == false and espText and connection then
        espText.Visible = false
        espText:Remove()
        connection:Disconnect()
    end
    
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if object.Parent ~= nil and getgenv().settings.playerESP and not object.Parent:FindFirstChild("Highlight") then
            local objectPos, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(object.Position)
            local targetDistance = (object.Position - game:GetService("Workspace").CurrentCamera.CFrame.Position).magnitude
            
            if onScreen and getgenv().settings.playerESP and targetDistance < getgenv().settings.playerDistance and espText and #game:GetService("Workspace").CurrentCamera:GetChildren() ~= 0 and not object.Parent:FindFirstChild("ForceField") then
                espText.Position = Vector2.new(objectPos.X, objectPos.Y + math.clamp(targetDistance / 10,10,30) -10)
                
                if getgenv().settings.espWeapon and getGun(object.Parent) ~= nil and not getgenv().settings.distanceESP then
                    espText.Text = text .. " | " .. getGun(object.Parent).Name
                elseif getgenv().settings.distanceESP and not getgenv().settings.espWeapon then
                    espText.Text = text .. " | " .. tostring(math.floor(targetDistance)) .. " meters"
                elseif getgenv().settings.espWeapon and getGun(object.Parent) ~= nil and getgenv().settings.distanceESP then
                    espText.Text = text .. " | " .. getGun(object.Parent).Name .. " | " .. tostring(math.floor(targetDistance)) .. " meters"
                else
                    espText.Text = text
                end
                
                if getgenv().settings.espRainbow then
                    espText.Color = espColor
                end
                
                espText.Visible = true
                espText.Size = getgenv().settings.textSize
            else
                if espText then
                    espText.Visible = false
                end
            end
        else
            espText.Visible = false
            espText:Remove()
            connection:Disconnect()
        end
    end)
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Extra/BracketV3.lua"))()
local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("No-Scope Arcade")

-- Player

local playerSec = mainTab:CreateSection("Player")

playerSec:CreateToggle("Infinite Jump", getgenv().settings.infJump or false, function(bool)
    getgenv().settings.infJump = bool
    saveSettings()
end)

local bHop = playerSec:CreateToggle("Bunny-Hop", getgenv().settings.bunnyHop or false, function(bool)
    getgenv().settings.bunnyHop = bool
    saveSettings()
end)

bHop:AddToolTip("hippity hop!")

local triggerTog = playerSec:CreateToggle("Trigger-Bot", getgenv().settings.triggerBot or false, function(bool)
    getgenv().settings.triggerBot = bool
    saveSettings()
end)

triggerTog:AddToolTip("automatically shoots when you aim at a player")

local toxicTog = playerSec:CreateToggle("Auto Toxic", getgenv().settings.toxicAuto or false, function(bool)
    getgenv().settings.toxicAuto = bool
    saveSettings()
    
    if getgenv().settings.toxicAuto then
        localPlr.leaderstats.Kills:GetPropertyChangedSignal("Value"):Connect(function()
            if not getgenv().settings.toxicAuto then return end
            
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getQuote(), "All")
        end)
    end
end)

toxicTog:AddToolTip("automatically says a toxic phrase when you earn a kill")

local kill = playerSec:CreateButton("Kill All (EXPERIMENTAL)", function()
    if localPlr.Status.Value == "Alive" and localPlr.Character:FindFirstChild("HumanoidRootPart") then
        for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= localPlr and v.Status.Value == "Alive" and localPlr.Character:FindFirstChild("HumanoidRootPart") then
                repeat task.wait(0.4)
                    isKilling = true
                    if v.Character and v.Character:FindFirstChild("Head") then
                        localPlr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,6,0)
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, v.Character.Head.Position)
                        
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(-100,-100))
                    end
                until v == nil or localPlr.Status.Value == "Dead" or v.Status.Value == "Dead" or not localPlr.Character:FindFirstChild("HumanoidRootPart") or v.Character:FindFirstChild("Head") == nil or v.Character == nil
                
                task.wait(1.5)
            end
        end
        
        isKilling = false
    end
end)

kill:AddToolTip("Shoot's everybody in your server. (you need to be alive for this to work)")

-- Visuals

local visualSec = mainTab:CreateSection("Visuals")

visualSec:CreateToggle("Space Skybox", getgenv().settings.spaceSkybox or false, function(bool)
    getgenv().settings.spaceSkybox = bool
    saveSettings()
    
    if getgenv().settings.spaceSkybox then
        local space = Instance.new("Sky")
        
        space.Name = "SpaceHD"
        space.Parent = game:GetService("Lighting")
        
        space.MoonTextureId = "rbxassetid://1075087760"
        space.SkyboxBk = "rbxassetid://1084529998"
        space.SkyboxDn = "rbxassetid://1084531389"
        space.SkyboxFt = "rbxassetid://1084530496"
        space.SkyboxLf = "rbxassetid://1084530280"
        space.SkyboxRt = "rbxassetid://1084529769"
        space.SkyboxUp = "rbxassetid://1084531033"
        space.SunTextureId = "rbxassetid://1084351190"
        space.StarCount = 500
        space.SunAngularSize = 12
        space.MoonAngularSize = 1.5
    else
        if game:GetService("Lighting"):FindFirstChild("SpaceHD") == nil then return end
        
        game:GetService("Lighting"):FindFirstChild("SpaceHD"):Destroy()
    end
end)

local fovButton = visualSec:CreateButton("High FOV", function()
    if not getgenv().fovDone then
        local camMod = require(game:GetService("ReplicatedStorage").GunSystem.GunClientAssets.Modules.Camera)
	    
	    camMod:ModifyFOV(120,120,120)
	    getgenv().fovDone = true
	else
	    game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Error",
            Text = "High FOV is already applied!",
            Duration = 5
        })
	end
end)

fovButton:AddToolTip("Set's your camera's FOV to 120")

if getgc and hookfunction then
    local shakeButton = visualSec:CreateButton("No Camera Shake", function()
        if not getgenv().cameraShakeDone then
            hookfunction(cambobFunc, function() return end)
            getgenv().cameraShakeDone = true
    	else
    	    game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Error",
                Text = "No Camera Shake is already applied!",
                Duration = 5
            })
    	end
    end)
    
    shakeButton:AddToolTip("Removes any camera shake (helps a lot when paired with Walk Speed.")
end

local soundKill = visualSec:CreateDropdown("Killsounds", {"Default","Bonk","Team Fortress 2","Rust","CSGO","Hitmarker"}, function(option)
    getgenv().settings.killSound = option
    saveSettings()
    
    if getgenv().settings.killSound == "Default" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 2121076754
    elseif getgenv().settings.killSound == "Bonk" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 5635027625
    elseif getgenv().settings.killSound == "Team Fortress 2" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 5650646664
    elseif getgenv().settings.killSound == "Rust" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 5043539486
    elseif getgenv().settings.killSound == "CSGO" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 8679627751
    elseif getgenv().settings.killSound == "Hitmarker" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 160432334
    end
end)

soundKill:SetOption(getgenv().settings.killSound or "Default")

local soundButton = visualSec:CreateButton("Preview Killsound", function()
	game:GetService("Workspace").Sounds.Kill:Play()
end)

soundButton:AddToolTip("Lets you play the killsound to see if its good for you.")

-- Player ESP

local espSec = mainTab:CreateSection("Player ESP")

espSec:CreateToggle("Enabled", getgenv().settings.playerESP or false, function(bool)
    getgenv().settings.playerESP = bool
    saveSettings()

    if getgenv().settings.playerESP and isLoaded then
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= localPlr and player.Character and getgenv().settings.playerESP then
                esp(player.Character:WaitForChild("Head"), player.Name, Color3.fromRGB(255,255,255))
                
                player.CharacterAdded:Connect(function(playerChar)
                    esp(playerChar:WaitForChild("Head"), player.Name, Color3.fromRGB(255,255,255))
                end)
            end
        end
    end
end)

game:GetService("Players").PlayerAdded:Connect(function(player)
	if player ~= localPlr and player.Character and getgenv().settings.playerESP then
	    esp(player.Character:WaitForChild("Head"), player.Name, Color3.fromRGB(255,255,255))
	elseif player ~= localPlr and getgenv().settings.playerESP then
        player.CharacterAdded:Connect(function(playerChar)
    	    esp(player.Character:WaitForChild("Head"), player.Name, Color3.fromRGB(255,255,255))
        end)
    end
end)

espSec:CreateToggle("Rainbow ESP", getgenv().settings.espRainbow or false, function(bool)
    getgenv().settings.espRainbow = bool
    saveSettings()
end)

espSec:CreateToggle("Show Player Weapon", getgenv().settings.espWeapon or false, function(bool)
    getgenv().settings.espWeapon = bool
    saveSettings()
end)

espSec:CreateToggle("Show Player Distance", getgenv().settings.distanceESP or false, function(bool)
    getgenv().settings.distanceESP = bool
    saveSettings()
end)

local colorESP = espSec:CreateColorpicker("ESP Color", function(color)
	getgenv().settings.espColor = color
	saveSettings()
end)

local distanceSlider = espSec:CreateSlider("ESP Distance Limit", 0,1000,getgenv().settings.playerDistance or 0,true, function(value)
    getgenv().settings.playerDistance = value
    saveSettings()
end)

local textSizeSlider = espSec:CreateSlider("ESP Text Size", 15,100,getgenv().settings.textSize or 15,true, function(value)
    getgenv().settings.textSize = value
    saveSettings()
end)

-- Aiming

local aimSec = mainTab:CreateSection("Aiming")

FOVCircle = Drawing.new("Circle")

FOVCircle.Visible = false
FOVCircle.Radius = getgenv().settings.fovRadius or 0
FOVCircle.Color = Color3.fromRGB(getgenv().settings.fovColor or 255,255,255)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Transparency = 1

local botTog = aimSec:CreateToggle("Aimbot", getgenv().settings.aimBotTog or false, function(bool)
	getgenv().settings.aimBotTog = bool
	saveSettings()
end)

aimSec:CreateToggle("Show FOV", getgenv().settings.showFOV or false, function(bool)
    getgenv().settings.showFOV = bool
    FOVCircle.Visible = getgenv().settings.showFOV
    saveSettings()
end)

aimSec:CreateToggle("Rainbow FOV", getgenv().settings.rainbowFOV or false, function(bool)
    getgenv().settings.rainbowFOV = bool
    saveSettings()
end)

local lock = aimSec:CreateToggle("Auto Lock", getgenv().settings.autoLock or false, function(bool)
    getgenv().settings.autoLock = bool
    saveSettings()
end)

lock:AddToolTip("Disables the need to have to Right Click for the aimbot to activate.")

aimSec:CreateSlider("FOV Radius", 0,500,getgenv().settings.fovRadius or 0,true, function(value)
	getgenv().settings.fovRadius = value
    FOVCircle.Radius = getgenv().settings.fovRadius
    saveSettings()
end)

local colorFOV = aimSec:CreateColorpicker("FOV Color", function(color)
	getgenv().settings.fovColor = color
	FOVCircle.Color = getgenv().settings.fovColor
	saveSettings()
end)

colorFOV:UpdateColor(getgenv().settings.fovColor or Color3.fromRGB(255,255,255))

local partDrop = aimSec:CreateDropdown("Aim Part", {"Head","Chest"}, function(option)
    if option == "Chest" then
        getgenv().settings.aimbotPart = "HumanoidRootPart"
        saveSettings()
    else
        getgenv().settings.aimbotPart = option
        saveSettings()
    end
end)

partDrop:SetOption(getgenv().settings.aimbotPart or "Head")

-- Gun Mods

if getgc then
    local gunMods = mainTab:CreateSection("Gun Mods")

    gunMods:CreateToggle("No Spread", getgenv().settings.noSpread or false, function(bool)
        if not isLoaded then return end
        getgenv().settings.noSpread = bool

        if getgenv().settings.noSpread then
            ModifyGuns("Spread", 0)
        else
            ModifyGuns("Spread", 5)
        end
        
        saveSettings()
    end)

    gunMods:CreateToggle("No Recoil", getgenv().settings.noRecoil or false, function(bool)
        if not isLoaded then return end
        getgenv().settings.noRecoil = bool

        if getgenv().settings.noRecoil then
            ModifyGuns("RecoilMult", 0)
        else
            ModifyGuns("RecoilMult", 4)
        end
        
        saveSettings()
    end)

    local oneHitTog = gunMods:CreateToggle("One Hit", getgenv().settings.oneHit or false, function(bool)
        if not isLoaded then return end
        getgenv().settings.oneHit = bool

        if getgenv().settings.oneHit then
            ModifyGuns("Damage", math.huge)
            ModifyGuns("HeadshotDmg", math.huge)
        else
            ModifyGuns("Damage", 65)
            ModifyGuns("HeadshotDmg", 90)
        end
        
        saveSettings()
    end)
    
    oneHitTog:AddToolTip("makes your weapon instantly kill players")

    local fireRateTog = gunMods:CreateToggle("No Fire-Rate", getgenv().settings.rateFire or false, function(bool)
        if not isLoaded then return end
        getgenv().settings.rateFire = bool

        if getgenv().settings.rateFire then
            ModifyGuns("FireRate", 0)
        else
            ModifyGuns("FireRate", 0.25)
        end
        
        saveSettings()
    end)
    
    fireRateTog:AddToolTip("the shooting delay of your weapon")

    gunMods:CreateToggle("Instant Equip", getgenv().settings.equipInstantly or false, function(bool)
        if not isLoaded then return end
        getgenv().settings.equipInstantly = bool

        if getgenv().settings.equipInstantly then
            ModifyGuns("EquipTime", 0)
        else
            ModifyGuns("EquipTime", 0.4)
        end
        
        saveSettings()
    end)

    gunMods:CreateToggle("Instant Reload", getgenv().settings.reloadInstantly or false, function(bool)
        if not isLoaded then return end
        getgenv().settings.reloadInstantly = bool

        if getgenv().settings.reloadInstantly then
            ModifyGuns("ReloadTime", 0)
        else
            ModifyGuns("ReloadTime", 0.28)
        end
        
        saveSettings()
    end)

    gunMods:CreateToggle("Infinite Clip Size", getgenv().settings.clipInf or false, function(bool)
        if not isLoaded then return end
        getgenv().settings.clipInf = bool

        if getgenv().settings.clipInf then
            ModifyGuns("ClipSize", math.huge)
        else
            ModifyGuns("ClipSize", 7)
        end
        
        saveSettings()
    end)

    local speedSlider = gunMods:CreateSlider("Walk Speed", 20,500,getgenv().settings.walkSpeed or 20,true, function(value)
        if not isLoaded then return end
        getgenv().settings.walkSpeed = value  

        ModifyGuns("WalkSpeed", getgenv().settings.walkSpeed)
        
        saveSettings()
    end)
    
    speedSlider:AddToolTip("Changes your speed, sometimes makes your viewmodel have a seizure (dont use if you suffer from epilepsy, im not kidding)")
end

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

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and mouseDown == false then
        mouseDown = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and mouseDown then
        mouseDown = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(localPlr:GetMouse().X, localPlr:GetMouse().Y + 36)
    
    if getgenv().settings.rainbowFOV then
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
        
        FOVCircle.Color = rainbow
        colorFOV:UpdateColor(rainbow)    
    end
    
    -- skid moment!?!?!?! -little
    if getgenv().settings.espRainbow then
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
        
        colorESP:UpdateColor(rainbow)
        espColor = rainbow
    end

    if localPlr.Character and #game:GetService("Workspace").CurrentCamera:GetChildren() ~= 0 then
        if getgenv().settings.triggerBot and not isKilling and localPlr:GetMouse().Target and localPlr:GetMouse().Target.Parent:FindFirstChild("Humanoid") and not localPlr:GetMouse().Target.Parent:FindFirstChild("ForceField") and getGun(localPlr:GetMouse().Target.Parent) ~= nil or getgenv().settings.triggerBot and localPlr:GetMouse().Target and localPlr:GetMouse().Target.Parent.Parent:FindFirstChild("Humanoid") and not localPlr:GetMouse().Target.Parent.Parent:FindFirstChild("ForceField") and getGun(localPlr:GetMouse().Target.Parent.Parent) ~= nil then
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(-100,-100))
        end
        
        if not isTyping and getgenv().settings.infJump and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        if getgenv().settings.bunnyHop and localPlr.Character:WaitForChild("Humanoid") and localPlr.Character.Humanoid.FloorMaterial ~= Enum.Material.Air and localPlr.Character.Humanoid.MoveDirection ~= Vector3.new(0,0,0) then
            localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            task.wait(2)
        end

        if getgenv().settings.aimBotTog and not isKilling and mouseDown or getgenv().settings.aimBotTog and getgenv().settings.autoLock then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= localPlr and player.Character and player.Status.Value ~= "Dead" and not player.Character:FindFirstChild("ForceField") and player.Character:FindFirstChild(getgenv().settings.aimbotPart) then
                    local partPos, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(player.Character[getgenv().settings.aimbotPart].Position)
                    local obsParts = game:GetService("Workspace").CurrentCamera:GetPartsObscuringTarget({player.Character[getgenv().settings.aimbotPart].Position}, {game:GetService("Workspace").CurrentCamera, localPlr.Character, player.Character})

                    if onScreen and #obsParts == 0 then
                        local distance = math.huge
                        local mag = (Vector2.new(localPlr:GetMouse().X, localPlr:GetMouse().Y) - Vector2.new(partPos.X, partPos.Y)).magnitude
                        
                        if mag < distance and mag < getgenv().settings.fovRadius then
                            distance = mag
                            closestPlayer = player.Character
                            game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.Position, closestPlayer[getgenv().settings.aimbotPart].Position)
                        end
                    end
                end
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

if getgenv().settings.playerESP and isLoaded then
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= localPlr and player.Character and getgenv().settings.playerESP then
            esp(player.Character:WaitForChild("Head"), player.Name, Color3.fromRGB(255,255,255))
            
            player.CharacterAdded:Connect(function(playerChar)
                esp(playerChar:WaitForChild("Head"), player.Name, Color3.fromRGB(255,255,255))
            end)
        end
    end
end

task.wait(5)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Fact",
    Text = "Rogue hub has over 3500+ lines of code!",
    Duration = 10
})
