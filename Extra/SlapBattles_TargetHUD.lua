local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "TargetHUD"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0.429528087, 0, 0.748699009, 0)
Frame.Size = UDim2.new(0.140771642, 0, 0.0927643776, 0)
Frame.Visible = false

ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(-0.000536883308, 0, -0.00139160152, 0)
ImageLabel.Size = UDim2.new(0.277777791, 0, 0.75999999, 0)
ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.366666883, 0, 0, 0)
TextLabel.Size = UDim2.new(0.633333325, 0, 0.5, 0)
TextLabel.Font = Enum.Font.Unknown
TextLabel.Text = "Username"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 25.000
TextLabel.TextWrapped = true

UITextSizeConstraint.Parent = TextLabel
UITextSizeConstraint.MaxTextSize = 25

UIAspectRatioConstraint.Parent = ScreenGui
UIAspectRatioConstraint.AspectRatio = 1.779
