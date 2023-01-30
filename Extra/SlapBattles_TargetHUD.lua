local TargetHUD = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Username = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local PlayerThumbnail = Instance.new("ImageLabel")
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
