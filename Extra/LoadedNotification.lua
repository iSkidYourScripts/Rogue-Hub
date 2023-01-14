-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

--Properties:

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(-0.254999995, 0, 0.921999991, 0)
Frame.Size = UDim2.new(0.205607474, 0, 0.0585443042, 0)
Frame.Visible = false

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Size = UDim2.new(0.0492424257, 0, 1, 0)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.204397723, 0, 0, 0)
TextLabel.Size = UDim2.new(0.602272749, 0, 1, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "Rogue Hub took seconds to load!"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

UITextSizeConstraint.Parent = TextLabel
UITextSizeConstraint.MaxTextSize = 14

UIAspectRatioConstraint.Parent = ScreenGui
UIAspectRatioConstraint.AspectRatio = 2.032

TextLabel.Text = "Rogue Hub took " .. math.floor(getgenv().lastTick - tick()) .. " seconds to load!"
Frame.Visible = true
Frame:TweenPosition(UDim2.new(0.005,0,0.922,0),"Out","Quint",1,true)

wait(5)
Frame:TweenPosition(UDim2.new(-0.255,0,0.922,0),"Out","Quint",1,true)
