if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 4543144283 then return end

local sound = Instance.new("Sound")
sound.Parent = game:GetService("Workspace")
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

getgenv().lastTick = tick()

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
    baconFarm = false,
    btBaconFarm = false,
    bestBaconTog = false,
    hugeBaconFarm = false,
    upgradeFarm = false,
    coinFarm = false,
    bombLoop = false,
    killAura = false,
    walkValue = 50,
    jumpValue = 50
}

local func
local attackFunc

if getgc then
    for _, v in next, getgc() do
	local exploitFunction = isexecutorclosure or is_synapse_function or is_exploit_function	
		
        if type(v) == "function" and not exploitFunction(v) and getinfo(v).name == "dropbomb" then
            func = v
        elseif type(v) == "function" and not exploitFunction(v) and getinfo(v).name == "attack" then
            attackFunc = v
        end

        if func and attackFunc then
            break
        end
    end
end

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    makefolder("Rogue Hub/Configs")
end

if readfile and isfile and isfile("Rogue Hub/Configs/MegaNoobSimulator_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/MegaNoobSimulator_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/MegaNoobSimulator_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local localPlr = game:GetService("Players").LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Extra/BracketV3.lua"))()
local notifLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Extra/Notifications.lua"))()

local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local mainTab = Window:CreateTab("Mega Noob Simulator")
local mainSec = mainTab:CreateSection("Farming")

localPlr.CharacterAdded:Connect(function()
    local humanoid = localPlr.Character:WaitForChild("Humanoid")
    
    localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkValue
    localPlr.Character.Humanoid.JumpPower = getgenv().settings.jumpValue
    
    if getgenv().settings.killAura and getgc then
        for _, v in next, localPlr.Character:GetChildren() do
            if v.Name == "Hitbox" and v:IsA("Part") then
                v.Touched:Connect(function(touchedPart)
                    if touchedPart.Name == "HumanoidRootPart" and getgenv().settings.killAura then
                        attackFunc()
                    end
                end)
            end
        end
    end
end)

local baconTog = mainSec:CreateToggle("Bacon Farm", getgenv().settings.baconFarm, function(bool)
    getgenv().settings.baconFarm = bool
    saveSettings()
end)

local btBaconTog = mainSec:CreateToggle("Better Bacon Farm", getgenv().settings.btBaconFarm, function(bool)
    getgenv().settings.btBaconFarm = bool
    saveSettings()
end)

local bestBaconTog = mainSec:CreateToggle("Best Bacon Farm", getgenv().settings.bestBaconTog, function(bool)
    getgenv().settings.bestBaconTog = bool
    saveSettings()
end)

local hugeBaconTog = mainSec:CreateToggle("Huge Bacon Farm", getgenv().settings.hugeBaconFarm, function(bool)
    getgenv().settings.hugeBaconFarm = bool
    saveSettings()
end)

local upgradeTog = mainSec:CreateToggle("Auto Buy Upgrades", getgenv().settings.upgradeFarm, function(bool)
    getgenv().settings.upgradeFarm = bool
    saveSettings()
end)

local coinTog = mainSec:CreateToggle("Coin Farm", getgenv().settings.coinFarm, function(bool)
    getgenv().settings.coinFarm = bool
    saveSettings()
    
    if getgenv().settings.coinFarm then
        for _, coin in next, game:GetService("Workspace").CoinStuff:GetDescendants() do
            if coin.Name == "CoinCollectible" and coin:IsA("MeshPart") then
                firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), coin, 0)
                firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), coin, 1)
            end
        end
    end
end)

-- Fun Section

local funSec = mainTab:CreateSection("Fun & Other")

if getgc then
    local bombBut = funSec:CreateButton("Bomb Drop (Not FE)", function()
        func()
    end)
    
    local bombTog = funSec:CreateToggle("Spam Bomb Drop", getgenv().settings.bombLoop, function(bool)
        getgenv().settings.bombLoop = bool
        saveSettings()
    end)
end

if getgc then
    local hitboxTog = funSec:CreateToggle("Killaura", getgenv().settings.killAura, function(bool)
        getgenv().settings.killAura = bool
        saveSettings()
    
        if getgenv().settings.killAura and localPlr.Character then
            for _, v in next, localPlr.Character:GetChildren() do
                if v.Name == "Hitbox" and v:IsA("Part") then
                    v.Touched:Connect(function(touchedPart)
                        if touchedPart.Name == "HumanoidRootPart" and getgenv().settings.killAura then
                            attackFunc()
                        end
                    end)
                end
            end
        end
    end)
end

local walkSlider = funSec:CreateSlider("Walkspeed", localPlr.Character.Humanoid.WalkSpeed,200,getgenv().settings.walkValue,true, function(value)
	getgenv().settings.walkValue = value
	localPlr.Character:FindFirstChild("Humanoid").WalkSpeed = getgenv().settings.walkValue
    saveSettings()
end)

local jumpSlider = funSec:CreateSlider("Jump Power", localPlr.Character.Humanoid.JumpPower,200,getgenv().settings.jumpValue,true, function(value)
	getgenv().settings.jumpValue = value
	localPlr.Character:FindFirstChild("Humanoid").JumpPower = getgenv().settings.jumpValue
    saveSettings()
end)

-- Shops Section

local shopSec = mainTab:CreateSection("Shops")

local upgradeBut = shopSec:CreateButton("Buy Upgrades", function()
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.UpgradeShop.Enter, 0)
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.UpgradeShop.Enter, 1)
end)

local noobBut = shopSec:CreateButton("Heads to Coins", function()
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops["Noobs To Coins"].Enter, 0)
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops["Noobs To Coins"].Enter, 1)
end)

local marketBut = shopSec:CreateButton("Black Market", function()
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.BlackMarket.Hitbox, 0)
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.BlackMarket.Hitbox, 1)
end)

local salonBut = shopSec:CreateButton("Salon", function()
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.Salon.Hitbox, 0)
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.Salon.Hitbox, 1)
end)

local rebirthBut = shopSec:CreateButton("Rebirth Token & Pets", function()
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.RebirthShop.Enter, 0)
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.RebirthShop.Enter, 1)
end)

local crateBut = shopSec:CreateButton("Crates", function()
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.Crates.Hitbox, 0)
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").Shops.Crates.Hitbox, 1)
end)

local rewardBut = shopSec:CreateButton("Daily Reward", function()
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").DailyReward.Hitbox, 0)
    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").DailyReward.Hitbox, 1)
end)

-- Power Up Section

local powerSec = mainTab:CreateSection("Power Ups")

local defaultPower = powerSec:CreateButton("None/Default", function()
    localPlr.Data.Powerup.Value = "None"
end)

local laserPower = powerSec:CreateButton("Laser Sword", function()
    localPlr.Data.Powerup.Value = "Laser Sword"
end)

local candyCanePower = powerSec:CreateButton("Candy Cane Sword", function()
    localPlr.Data.Powerup.Value = "CandyCane Sword"
end)

local presentPower = powerSec:CreateButton("Present", function()
    localPlr.Data.Powerup.Value = "Present Powerup"
end)

local spikePower = powerSec:CreateButton("Spike Attack", function()
    localPlr.Data.Powerup.Value = "Spike Attack"
end)

-- Info

local infoTab = Window:CreateTab("Extra")
local uiSec = infoTab:CreateSection("UI Settings")

local uiColor = uiSec:CreateColorpicker("UI Color", function(color)
	Window:ChangeColor(color)
end)

uiColor:UpdateColor(Config.Color)

local uiTog = uiSec:CreateToggle("UI Toggle", nil, function(bool)
	Window:Toggle(bool)
end)

uiTog:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else Config.Keybind = Enum.KeyCode[key]; writefile("/Rogue Hub/Configs/Keybind.ROGUEHUB", game:GetService("HttpService"):JSONEncode({Key = key})) end
end)

uiTog:SetState(true)

local uiRainbow = uiSec:CreateToggle("Rainbow UI", nil, function(bool)
	getgenv().rainbowUI = bool
	
	if getgenv().rainbowUI == false then
	    Window:ChangeColor(Config.Color)
	end
    
    while getgenv().rainbowUI and task.wait() do
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
            
        Window:ChangeColor(rainbow)
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
    if getgenv().settings.baconFarm then
        for _, bacon in pairs(game:GetService("Workspace").BaconStuff.Bacons:GetChildren()) do
            if bacon.Name == "Bacon" and bacon:WaitForChild("Humanoid").Health ~= 0 and localPlr.Character:WaitForChild("Humanoid") then
                repeat
                    game:GetService("ReplicatedStorage").Remotes.Punch:FireServer(bacon)
                    wait()
                until bacon:WaitForChild("Humanoid").Health == 0 or getgenv().settings.baconFarm == false
            end
        end
    end
    
    if getgenv().settings.btBaconFarm then
        for _, bacon in pairs(game:GetService("Workspace").BaconStuff.BetterBacons:GetChildren()) do
            if bacon.Name == "BetterBacon" and bacon:WaitForChild("Humanoid").Health ~= 0 and localPlr.Character:WaitForChild("Humanoid") then
                repeat
                    game:GetService("ReplicatedStorage").Remotes.Punch:FireServer(bacon)
                    wait()
                until bacon:WaitForChild("Humanoid").Health == 0 or getgenv().settings.btBaconFarm == false
            end
        end
    end
    
    if getgenv().settings.bestBaconTog then
        for _, bacon in pairs(game:GetService("Workspace").BaconStuff.BestBacons:GetChildren()) do
            if bacon.Name == "BestBacon" and bacon:WaitForChild("Humanoid").Health ~= 0 and localPlr.Character:WaitForChild("Humanoid") then
                repeat
                    game:GetService("ReplicatedStorage").Remotes.Punch:FireServer(bacon)
                    wait()
                until bacon:WaitForChild("Humanoid").Health == 0 or getgenv().settings.bestBaconTog == false
            end
        end
    end
    
    if getgenv().settings.hugeBaconFarm then
        for _, bacon in pairs(game:GetService("Workspace").BaconStuff.HugeBacons:GetChildren()) do
             if bacon.Name == "HugeBacon" and bacon:WaitForChild("Humanoid").Health ~= 0 and localPlr.Character:WaitForChild("Humanoid") then
                repeat
                    game:GetService("ReplicatedStorage").Remotes.Punch:FireServer(bacon)
                    wait()
                until bacon:WaitForChild("Humanoid").Health == 0 or getgenv().settings.hugeBaconFarm == false
            end
        end
    end
    
    if getgc and getgenv().settings.bombLoop then
        func()
    end
    
    if getgenv().settings.upgradeFarm then
        task.spawn(function()
            task.wait(3)

            game:GetService("ReplicatedStorage").Remotes.Buy:FireServer("Weight " .. localPlr.Stats.UpgradesBought.Value, "Damage")
        end)
    end
    
    if getgenv().settings.coinFarm then
        task.spawn(function()
            task.wait(5)

            for _, coin in next, game:GetService("Workspace").CoinStuff:GetDescendants() do
                if coin.Name == "CoinCollectible" and coin:IsA("MeshPart") then
                    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), coin, 0)
                    firetouchinterest(localPlr.Character:WaitForChild("HumanoidRootPart"), coin, 1)
                end
            end
        end)
    end
end)

notifLib:Notification("Rogue Hub took " .. math.floor(getgenv().lastTick - tick()) .. " seconds to load!", 5)

sound:Destroy()
getgenv().isLoaded = true
