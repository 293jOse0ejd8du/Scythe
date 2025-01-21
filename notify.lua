local TweenService = game:GetService("TweenService")
local AlertFrame = Instance.new("ScreenGui")
AlertFrame.Name = "AlertFrame"
AlertFrame.Parent = game.CoreGui
AlertFrame.ZIndexBehavior = Enum.ZIndexBehavior.Global

_G.Primary = Color3.fromRGB(100, 100, 100)
_G.Dark = Color3.fromRGB(22, 22, 26)

local function createRipple(parent, x, y)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.Parent = parent
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.Position = UDim2.new(0, x, 0, y)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Size = UDim2.new(0, 0, 0, 0)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = ripple

    local fadeOut = TweenService:Create(ripple, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    local expand = TweenService:Create(ripple, TweenInfo.new(0.5), {Size = UDim2.new(0, 100, 0, 100)})

    fadeOut:Play()
    expand:Play()

    game:GetService("Debris"):AddItem(ripple, 0.5)
end

local function notify(desc)
    if AlertFrame:FindFirstChild("OutlineFrame") then
        AlertFrame.OutlineFrame:Destroy()
    end

    local OutlineFrame = Instance.new("Frame")
    OutlineFrame.Name = "OutlineFrame"
    OutlineFrame.Parent = AlertFrame
    OutlineFrame.ClipsDescendants = true
    OutlineFrame.BackgroundColor3 = _G.Dark
    OutlineFrame.BackgroundTransparency = 0.4
    OutlineFrame.Position = UDim2.new(1, 0, 0, 0)
    OutlineFrame.Size = UDim2.new(0, 212, 0, 72)
    OutlineFrame.ZIndex = 10

    local Frame = Instance.new("Frame")
    Frame.Name = "Frame"
    Frame.Parent = OutlineFrame
    Frame.ClipsDescendants = true
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = _G.Dark
    Frame.BackgroundTransparency = 0.1
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.Size = UDim2.new(0, 200, 0, 60)
    Frame.ZIndex = 11

    local Image = Instance.new("ImageLabel")
    Image.Name = "Icon"
    Image.Parent = Frame
    Image.BackgroundTransparency = 1
    Image.Position = UDim2.new(0, 8, 0, 8)
    Image.Size = UDim2.new(0, 45, 0, 45)
    Image.Image = "rbxassetid://99176769837513"
    Image.ZIndex = 12

    local Title = Instance.new("TextLabel")
    Title.Parent = Frame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 55, 0, 14)
    Title.Size = UDim2.new(0, 140, 0, 20)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Scythe"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 12

    local Desc = Instance.new("TextLabel")
    Desc.Parent = Frame
    Desc.BackgroundTransparency = 1
    Desc.Position = UDim2.new(0, 55, 0, 33)
    Desc.Size = UDim2.new(0, 140, 0, 20)
    Desc.Font = Enum.Font.GothamSemibold
    Desc.TextTransparency = 0.3
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    Desc.TextSize = 12
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.ZIndex = 12

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = Frame
    UIStroke.Color = Color3.fromRGB(255, 0, 0)
    UIStroke.Thickness = 1.2

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)
    Instance.new("UICorner", OutlineFrame).CornerRadius = UDim.new(0, 12)

    local slideIn = TweenService:Create(OutlineFrame,
        TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -220, 0, 0)}
    )
    slideIn:Play()

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            createRipple(Frame, input.Position.X, input.Position.Y)
        end
    end)

    task.delay(2, function()
        if OutlineFrame and OutlineFrame.Parent then
            local slideOut = TweenService:Create(OutlineFrame,
                TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Position = UDim2.new(1, 0, 0, 0)}
            )
            slideOut:Play()
            slideOut.Completed:Wait()
            OutlineFrame:Destroy()
        end
    end)
end

return notify
