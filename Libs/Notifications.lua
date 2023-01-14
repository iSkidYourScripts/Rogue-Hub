-- notification gui made by StoneNicolas93#0001

local notifLib = {}

function notifLib:Notification(notifText, duration)
    if game.CoreGui:FindFirstChild("RogueNotif") then
        repeat wait() until not game.CoreGui:FindFirstChild("RogueNotif")
    end
    
    local RogueNotif = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local ImageLabel = Instance.new("ImageLabel")
    local Frame_2 = Instance.new("Frame")
    local UIStroke = Instance.new("UIStroke")
    local TextLabel = Instance.new("TextLabel")
    local UIStroke_2 = Instance.new("UIStroke")
    
    if syn then
        syn.protect_gui(RogueNotif)
    end
    
    RogueNotif.Name = "RogueNotif"
    RogueNotif.Parent = game.CoreGui
    RogueNotif.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Frame.Parent = RogueNotif
    Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    Frame.Position = UDim2.new(0.822094083, 0, 0.919354856, 0)
    Frame.Size = UDim2.new(0.164596274, 0, 0.0544354841, 0)
    
    ImageLabel.Parent = Frame
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1.000
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.Image = "rbxassetid://2151741365"
    ImageLabel.ScaleType = Enum.ScaleType.Crop
    
    Frame_2.Parent = Frame
    Frame_2.BackgroundColor3 = Color3.fromRGB(255, 72, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0.964959264, 0, 0, 0)
    Frame_2.Size = UDim2.new(0.0350404307, 0, 1, 0)
    
    UIStroke.Parent = Frame
    UIStroke.Thickness = 2.000
    
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.0269541815, 0, 0.0476190448, 0)
    TextLabel.Size = UDim2.new(0.913746655, 0, 0.888888896, 0)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = notifText
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true
    
    UIStroke_2.Parent = TextLabel
    UIStroke_2.Color = Color3.fromRGB(29, 29, 29)

	Frame.Position = UDim2.new(1, 0, 0.919, 0)
	wait(0.2)
	Frame:TweenPosition(UDim2.new(0.822, 0, 0.919, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.3, false)
	wait(duration)
	Frame:TweenPosition(UDim2.new(1, 0, 0.919, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.5, false)
	wait(0.51)
	Frame.Parent:Destroy()
end

return notifLib
