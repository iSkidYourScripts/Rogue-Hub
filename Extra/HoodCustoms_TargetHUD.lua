local TargetHUD = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Username = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local PlayerThumbnail = Instance.new("ImageLabel")
local Health = Instance.new("TextLabel")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local PVPStatus = Instance.new("TextLabel")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
local WinsLosses = Instance.new("TextLabel")
local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
local Dropshadow = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

TargetHUD.Name = "TargetHUD"
TargetHUD.Parent = game.CoreGui
TargetHUD.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn then
    syn.protect_gui(TargetHUD)
end

MainFrame.Name = "MainFrame"
MainFrame.Parent = TargetHUD
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderColor3 = Color3.fromRGB(39, 61, 77)
MainFrame.Position = UDim2.new(0.417445481, 0, 0.721518934, 0)
MainFrame.Size = UDim2.new(0.164330199, 0, 0.0949367583, 0)
MainFrame.ZIndex = 5
MainFrame.Visible = false

UICorner.Parent = MainFrame

Username.Name = "Username"
Username.Parent = MainFrame
Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Username.BackgroundTransparency = 1.000
Username.Size = UDim2.new(1, 0, 0.316831678, 0)
Username.Font = Enum.Font.Nunito
Username.Text = "Username"
Username.TextColor3 = Color3.fromRGB(255, 255, 255)
Username.TextScaled = true
Username.TextSize = 20.000
Username.TextWrapped = true

UITextSizeConstraint.Parent = Username
UITextSizeConstraint.MaxTextSize = 20

PlayerThumbnail.Name = "PlayerThumbnail"
PlayerThumbnail.Parent = MainFrame
PlayerThumbnail.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerThumbnail.BackgroundTransparency = 1.000
PlayerThumbnail.Position = UDim2.new(0.0519480519, 0, 0.158415854, 0)
PlayerThumbnail.Size = UDim2.new(0.227272734, 0, 0.683168292, 0)
PlayerThumbnail.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

Health.Name = "Health"
Health.Parent = MainFrame
Health.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Health.BackgroundTransparency = 1.000
Health.Position = UDim2.new(0.27922079, 0, 0.316831678, 0)
Health.Size = UDim2.new(0.422077924, 0, 0.316831678, 0)
Health.Font = Enum.Font.Nunito
Health.Text = "Health: ???"
Health.TextColor3 = Color3.fromRGB(255, 255, 255)
Health.TextScaled = true
Health.TextSize = 20.000
Health.TextWrapped = true

UITextSizeConstraint_2.Parent = Health
UITextSizeConstraint_2.MaxTextSize = 20

PVPStatus.Name = "PVPStatus"
PVPStatus.Parent = MainFrame
PVPStatus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PVPStatus.BackgroundTransparency = 1.000
PVPStatus.Position = UDim2.new(0.597033262, 0, 0.316831797, 0)
PVPStatus.Size = UDim2.new(0.293962181, 0, 0.316831619, 0)
PVPStatus.Font = Enum.Font.Nunito
PVPStatus.Text = "???"
PVPStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
PVPStatus.TextScaled = true
PVPStatus.TextSize = 20.000
PVPStatus.TextWrapped = true

UITextSizeConstraint_3.Parent = PVPStatus
UITextSizeConstraint_3.MaxTextSize = 20

WinsLosses.Name = "WinsLosses"
WinsLosses.Parent = MainFrame
WinsLosses.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WinsLosses.BackgroundTransparency = 1.000
WinsLosses.Position = UDim2.new(0.279220849, 0, 0.633663774, 0)
WinsLosses.Size = UDim2.new(0.611999989, 0, 0.25, 0)
WinsLosses.Font = Enum.Font.Nunito
WinsLosses.Text = "??? - ???"
WinsLosses.TextColor3 = Color3.fromRGB(255, 255, 255)
WinsLosses.TextScaled = true
WinsLosses.TextSize = 20.000
WinsLosses.TextWrapped = true

UITextSizeConstraint_4.Parent = WinsLosses
UITextSizeConstraint_4.MaxTextSize = 20

Dropshadow.Name = "Dropshadow"
Dropshadow.Parent = TargetHUD
Dropshadow.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Dropshadow.BackgroundTransparency = 0.500
Dropshadow.BorderColor3 = Color3.fromRGB(39, 61, 77)
Dropshadow.Position = UDim2.new(0.417445421, 0, 0.721518934, 0)
Dropshadow.Size = UDim2.new(0.164330259, 0, 0.10598138, 0)
Dropshadow.Visible = false

UICorner_2.Parent = Dropshadow

UIAspectRatioConstraint.Parent = TargetHUD
UIAspectRatioConstraint.AspectRatio = 2.032
