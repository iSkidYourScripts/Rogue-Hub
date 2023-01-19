if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 9825515356 then return end

local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

local mouseDown = false
local localPlr = game:GetService("Players").LocalPlayer

local oldMode = localPlr.CameraMode
local oldFOV = workspace.CurrentCamera.FieldOfView

getgenv().isLoaded = false
getgenv().lastTick = tick()

function CheckConfigFile()
    if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Keybind.ROGUEHUB"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Hood Customs",
    Color = Color3.fromRGB(201,144,150),
    Keybind = CheckConfigFile()
}

getgenv().settings = {
    aimBot = false,
    autoLock = false,
    aimbotPart = "Head",
    wallCheck = false,
    fovCamera = 70,
    showPing = false,
    boxCheck = false,
    playerAnim = "Default Animations",
    usePred = false,
    pred = 0.125,
    targetHud = false,
    showUser = false,
    showHealth = false,
    showWins = false,
    showIcon = false,
    showDrop = false,
    showPVP = false,
    chatSpy = false,
    fullBright = false
}

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    
    makefolder("Rogue Hub/Configs")
    makefolder("Rogue Hub/Data")
end

if readfile and isfile and isfile("Rogue Hub/Configs/HoodCustoms_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/HoodCustoms_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/HoodCustoms_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local function getTool()
    return localPlr.Character:FindFirstChildOfClass("Tool")
end

localPlr.CharacterAdded:Connect(function()
	localPlr.Character:WaitForChild("Humanoid")
	
	if getgenv().settings.playerAnim == "No Animations" and localPlr.Character:FindFirstChild("Humanoid") and getgenv().isLoaded then
        localPlr.Character:WaitForChild("Animate")
	    task.wait(0.25)
	    
	    localPlr.Character.Animate.idle.Animation1.AnimationId = "None"
        localPlr.Character.Animate.idle.Animation2.AnimationId = "None"
        localPlr.Character.Animate.walk.WalkAnim.AnimationId = "None"
        localPlr.Character.Animate.run.RunAnim.AnimationId = "None"
        localPlr.Character.Animate.jump.JumpAnim.AnimationId = "None"
        localPlr.Character.Animate.climb.ClimbAnim.AnimationId = "None"
        localPlr.Character.Animate.fall.FallAnim.AnimationId = "None"
        
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	
	if getgenv().settings.playerAnim == "Tryhard Animations" and localPlr.Character:FindFirstChild("Humanoid") and getgenv().isLoaded then
	    localPlr.Character:WaitForChild("Animate")
	    task.wait(0.45)
	    
	    localPlr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
        localPlr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
        localPlr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
        localPlr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
        localPlr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=10921160088"
        localPlr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
        localPlr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
        
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	
	if getgenv().settings.playerAnim == "Barbie Animations" and localPlr.Character:FindFirstChild("Humanoid") and getgenv().isLoaded then
    	localPlr.Character:WaitForChild("Animate")
	    task.wait(0.45)
	    
	    localPlr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
        localPlr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
        localPlr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
        localPlr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
        localPlr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
        localPlr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=10921053544"
        localPlr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
        
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Libs/BracketV3.lua"))()
local notifLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Libs/Notifications.lua"))()

-- Target HUD
loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Extra/HoodCustoms_TargetHUD.lua"))()

local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("Hood Customs")

-- Aiming

local aimSec = mainTab:CreateSection("Aiming")

aimSec:CreateToggle("Aimbot", getgenv().settings.aimBot or false, function(bool)
    getgenv().settings.aimBot = bool
    saveSettings()
end)

local lock = aimSec:CreateToggle("Auto Lock", getgenv().settings.autoLock or false, function(bool)
    getgenv().settings.autoLock = bool
    saveSettings()
end)

lock:AddToolTip("Disables the need to have to Right Click for the aimbot to activate.")

local wall = aimSec:CreateToggle("Wall-Check", getgenv().settings.wallCheck or false, function(bool)
    getgenv().settings.wallCheck = bool
    saveSettings()
end)

wall:AddToolTip("Checks if a player is behind a wall before aimbotting.")

local box = aimSec:CreateToggle("In Round-Check", getgenv().settings.boxCheck or false, function(bool)
    getgenv().settings.boxCheck = bool
    saveSettings()
end)

box:AddToolTip("Checks if your inside a match before aimbotting, this is highly recommended to use.")

local pred = aimSec:CreateToggle("Use Prediction", getgenv().settings.usePred or false, function(bool)
    getgenv().settings.usePred = bool
    saveSettings()
end)

pred:AddToolTip("Use this if you want to get good accuracy.")

local predictionValue = aimSec:CreateTextBox("Prediction", "Enter your Prediction Value", false, function(value)
	getgenv().settings.pred = value
	saveSettings()
end)

predictionValue:AddToolTip("If you get around 60-80 ping, use 0.125, use something higher depending on your ping.")
predictionValue:SetValue(getgenv().settings.pred or 0.125)

local partDrop = aimSec:CreateDropdown("Aim Part", {"Head","HumanoidRootPart"}, function(option)
    if option == "HumanoidRootPart" then
        getgenv().settings.aimbotPart = "HumanoidRootPart"
        saveSettings()
    else
        getgenv().settings.aimbotPart = option
        saveSettings()
    end
end)

partDrop:AddToolTip("Select which body part you want the aimbot to aim at.")
partDrop:SetOption(getgenv().settings.aimbotPart or "HumanoidRootPart")

aimSec:CreateLabel("Aimbot does NOT WORK in 2v2s.")

-- Visuals

local visualSec = mainTab:CreateSection("Visuals")

textPing = Drawing.new("Text")

textPing.Text = "Ping: ???"
textPing.Size = 25
textPing.Outline = true
textPing.Font = 0
textPing.Color = Color3.fromRGB(255,255,255)
textPing.Visible = false

local pingTog = visualSec:CreateToggle("Show Ping", getgenv().settings.showPing or false, function(bool)
    getgenv().settings.showPing = bool
    
    textPing.Visible = getgenv().settings.showPing
    
    saveSettings()
end)

pingTog:AddToolTip("Shows text indicating your ping next to your cursor.")

-- credits to stefanuk12 on github
visualSec:CreateToggle("Chat Spy", getgenv().settings.chatSpy or false, function(bool)
    getgenv().settings.chatSpy = bool
    
    local chatFrame = localPlr.PlayerGui.Chat.Frame
    chatFrame.ChatChannelParentFrame.Visible = getgenv().settings.chatSpy
    chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)
    
    saveSettings()
end)

visualSec:CreateToggle("Fullbright", getgenv().settings.fullBright or false, function(bool)
    getgenv().settings.fullBright = bool
    
    if getgenv().settings.fullBright then
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
    else
        game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
    end
    
    saveSettings()
end)

local animDropdown = visualSec:CreateDropdown("Player Animations", {"Default Animations","No Animations","Tryhard Animations","Barbie Animations"}, function(stringValue)
	getgenv().settings.playerAnim = stringValue
	
	if getgenv().settings.playerAnim == "Default Animations" and localPlr.Character:FindFirstChild("Humanoid") and getgenv().isLoaded then
        localPlr.Character:WaitForChild("Animate")
	    task.wait(0.25)
	    
	    localPlr.Character.Animate.idle.Animation1.AnimationId = animBackup.idle1
        localPlr.Character.Animate.idle.Animation2.AnimationId = animBackup.idle2
        localPlr.Character.Animate.walk.WalkAnim.AnimationId = animBackup.walk
        localPlr.Character.Animate.run.RunAnim.AnimationId = animBackup.run
        localPlr.Character.Animate.jump.JumpAnim.AnimationId = animBackup.jump
        localPlr.Character.Animate.climb.ClimbAnim.AnimationId = animBackup.climb
        localPlr.Character.Animate.fall.FallAnim.AnimationId = animBackup.fall
        
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	
	if getgenv().settings.playerAnim == "No Animations" and localPlr.Character:FindFirstChild("Humanoid") and getgenv().isLoaded then
        localPlr.Character:WaitForChild("Animate")
	    task.wait(0.25)
	    
	    localPlr.Character.Animate.idle.Animation1.AnimationId = "None"
        localPlr.Character.Animate.idle.Animation2.AnimationId = "None"
        localPlr.Character.Animate.walk.WalkAnim.AnimationId = "None"
        localPlr.Character.Animate.run.RunAnim.AnimationId = "None"
        localPlr.Character.Animate.jump.JumpAnim.AnimationId = "None"
        localPlr.Character.Animate.climb.ClimbAnim.AnimationId = "None"
        localPlr.Character.Animate.fall.FallAnim.AnimationId = "None"
        
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	
	if getgenv().settings.playerAnim == "Tryhard Animations" and localPlr.Character:FindFirstChild("Humanoid") and getgenv().isLoaded then
	    localPlr.Character:WaitForChild("Animate")
	    task.wait(0.45)
	    
	    localPlr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
        localPlr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
        localPlr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
        localPlr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
        localPlr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=10921160088"
        localPlr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
        localPlr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
        
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	
	if getgenv().settings.playerAnim == "Barbie Animations" and localPlr.Character:FindFirstChild("Humanoid") and getgenv().isLoaded then
    	localPlr.Character:WaitForChild("Animate")
	    task.wait(0.45)
	    
	    localPlr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
        localPlr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
        localPlr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
        localPlr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
        localPlr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
        localPlr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=10921053544"
        localPlr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
        
        localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- Target HUD Section

local hudSec = mainTab:CreateSection("Target HUD")

hudSec:CreateToggle("Enabled", getgenv().settings.targetHud or false, function(bool)
    getgenv().settings.targetHud = bool
    saveSettings()
end)

hudSec:CreateToggle("Show Username", getgenv().settings.showUser or false, function(bool)
    getgenv().settings.showUser = bool
    game:GetService("CoreGui").TargetHUD.MainFrame.Username.Visible = getgenv().settings.showUser
    saveSettings()
end)

hudSec:CreateToggle("Show Health", getgenv().settings.showHealth or false, function(bool)
    getgenv().settings.showHealth = bool
    game:GetService("CoreGui").TargetHUD.MainFrame.Health.Visible = getgenv().settings.showHealth
    saveSettings()
end)

hudSec:CreateToggle("Show Wins & Losses", getgenv().settings.showWins or false, function(bool)
    getgenv().settings.showWins = bool
    game:GetService("CoreGui").TargetHUD.MainFrame.WinsLosses.Visible = getgenv().settings.showWins
    saveSettings()
end)

hudSec:CreateToggle("Show PVP Status", getgenv().settings.showPVP or false, function(bool)
    getgenv().settings.showPVP = bool
    game:GetService("CoreGui").TargetHUD.MainFrame.PVPStatus.Visible = getgenv().settings.showPVP
    saveSettings()
end)

hudSec:CreateToggle("Show Player Icon", getgenv().settings.showIcon or false, function(bool)
    getgenv().settings.showIcon = bool
    game:GetService("CoreGui").TargetHUD.MainFrame.PlayerThumbnail.Visible = getgenv().settings.showIcon
    saveSettings()
end)

hudSec:CreateToggle("Show Dropshadow", getgenv().settings.showDrop or false, function(bool)
    getgenv().settings.showDrop = bool
    saveSettings()
end)

animDropdown:AddToolTip("changes your player animations. (FE)")
animDropdown:SetOption("Default Animations")

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
    if getgenv().settings.showPing then
        textPing.Position = Vector2.new(localPlr:GetMouse().X, localPlr:GetMouse().Y + 55)
        
        local old = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local new = math.floor(tonumber(string.split(old, "(")[1]))
        
        textPing.Text = tostring("Ping: " .. new)
    end
    
    if getgenv().settings.aimBot and mouseDown or getgenv().settings.aimBot and getgenv().settings.autoLock then
        local aimAt
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= localPlr and player.Character and localPlr.Character and player.Character:FindFirstChild(getgenv().settings.aimbotPart) and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("BodyEffects") and not player.Character.BodyEffects.Dead.Value and not player.Character.BodyEffects["K.O"].Value then
                if getgenv().settings.boxCheck and not workspace.Players.InBox:FindFirstChild(localPlr.Name) then 
                    game:GetService("CoreGui").TargetHUD.MainFrame.Visible = false
                    game:GetService("CoreGui").TargetHUD.Dropshadow.Visible = false
                    
                    return
                end
                
                local partPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character[getgenv().settings.aimbotPart].Position)
                local obsParts = workspace.CurrentCamera:GetPartsObscuringTarget({player.Character[getgenv().settings.aimbotPart].Position}, {workspace.CurrentCamera, localPlr.Character, player.Character})
                
                if getgenv().settings.wallCheck and onScreen and #obsParts == 0 or getgenv().settings.wallCheck == false and onScreen then
                    local distance = math.huge
                    local mag = (Vector2.new(localPlr:GetMouse().X, localPlr:GetMouse().Y) - Vector2.new(partPos.X, partPos.Y)).magnitude
                    
                    if mag < distance then
                        distance = mag
                        aimAt = player.Character
                        
                        local aimingPlayer = game:GetService("Players")[aimAt.Name]
                        
                        if getgenv().settings.targetHud then
                            game:GetService("CoreGui").TargetHUD.MainFrame.Visible = true
                            
                            if getgenv().settings.showDrop then
                                game:GetService("CoreGui").TargetHUD.Dropshadow.Visible = true
                            end
                        end
                            game:GetService("CoreGui").TargetHUD.MainFrame.Username.Text = aimingPlayer.DisplayName or aimingPlayer.Name
                            game:GetService("CoreGui").TargetHUD.MainFrame.Health.Text = "Health: " .. tostring(math.floor(aimAt.Humanoid.Health))
                            game:GetService("CoreGui").TargetHUD.MainFrame.WinsLosses.Text = tostring(aimingPlayer.DataFolder.Information.Wins.Value) .. " - " .. tostring(aimingPlayer.DataFolder.Information.Losses.Value)
                            game:GetService("CoreGui").TargetHUD.MainFrame.PlayerThumbnail.Image = game:GetService("Players"):GetUserThumbnailAsync(aimingPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
                        
                        if aimAt.Humanoid.Health < localPlr.Character.Humanoid.Health then
                            game:GetService("CoreGui").TargetHUD.MainFrame.PVPStatus.Text = "Winning"
                        elseif aimAt.Humanoid.Health == localPlr.Character.Humanoid.Health then
                            game:GetService("CoreGui").TargetHUD.MainFrame.PVPStatus.Text = "Equal"
                        else
                            game:GetService("CoreGui").TargetHUD.MainFrame.PVPStatus.Text = "Losing"
                        end
                        
                        if aimAt and aimAt:FindFirstChild(getgenv().settings.aimbotPart) and aimAt:FindFirstChild("Humanoid") and not aimAt.BodyEffects.Dead.Value and not aimAt.BodyEffects["K.O"].Value then
                            if getgenv().settings.usePred then
                                workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, aimAt[getgenv().settings.aimbotPart].Position + aimAt[getgenv().settings.aimbotPart].Velocity * getgenv().settings.pred or 0.125)
                            else
                                workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, aimAt[getgenv().settings.aimbotPart].Position)
                            end
                        end
                    end
                end
            end
        end
    end
end)

sound:Destroy()
getgenv().isLoaded = true

notifLib:Notification("Rogue Hub took " .. math.floor(tick() - getgenv().lastTick) .. " seconds to load!", 5)
