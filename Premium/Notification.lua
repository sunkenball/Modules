local notification = {}

function notification.new(texty: string, time: number, closeText: string): nil
    local notification = Instance.new("ScreenGui")
    notification.IgnoreGuiInset = true
    notification.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    notification.ResetOnSpawn = false
    notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    notification.Name = "notification"
    notification.Parent = nil

    if syn then
        syn.protect_gui(notification)
    elseif type(gethui) == "function" then
        gethui(notification)
    end

    notification.Parent = game:GetService("CoreGui")

    local back = Instance.new("Frame")
    back.BackgroundColor3 = Color3.new(0.0509804, 0.0588235, 0.0745098)
    back.BorderSizePixel = 0
    back.Position = UDim2.new(0.823529422, 0, 0.899999976, 0)
    back.Size = UDim2.new(0.167374149, 0, 0.0823529437, 0)
    back.Visible = true
    back.Name = "back"
    back.Parent = notification

    local timeline = Instance.new("Frame")
    timeline.BackgroundColor3 = Color3.new(0.109804, 0.454902, 0.996078)
    timeline.BorderSizePixel = 0
    timeline.Position = UDim2.new(0, 0, 0.989579558, 0)
    timeline.Size = UDim2.new(0, 0, 0.02, 0)
    timeline.Visible = true
    timeline.Name = "timeline"
    timeline.Parent = back

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 4)
    uicorner.Parent = timeline

    local dismiss = Instance.new("TextLabel")
    dismiss.Font = Enum.Font.GothamBold
    dismiss.Text = closeText
    dismiss.TextColor3 = Color3.new(0.109804, 0.454902, 0.996078)
    dismiss.TextScaled = true
    dismiss.TextSize = 14
    dismiss.TextWrapped = true
    dismiss.TextYAlignment = Enum.TextYAlignment.Top
    dismiss.BackgroundColor3 = Color3.new(1, 1, 1)
    dismiss.BackgroundTransparency = 1
    dismiss.BorderSizePixel = 0
    dismiss.Position = UDim2.new(0.699104548, 0, 0.678881884, 0)
    dismiss.Size = UDim2.new(0.299820602, 0, 0.298092335, 0)
    dismiss.Visible = true
    dismiss.Name = "dismiss"
    dismiss.Parent = back

    local uitext_size_constraint = Instance.new("UITextSizeConstraint")
    uitext_size_constraint.MaxTextSize = 12
    uitext_size_constraint.Parent = dismiss

    local button = Instance.new("TextButton")
    button.Font = Enum.Font.SourceSans
    button.Text = ""
    button.TextColor3 = Color3.new(0, 0, 0)
    button.TextScaled = true
    button.TextSize = 14
    button.TextWrapped = true
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Visible = true
    button.Name = "button"
    button.Parent = dismiss

    local uiaspect_ratio_constraint_2 = Instance.new("UIAspectRatioConstraint")
    uiaspect_ratio_constraint_2.AspectRatio = 3.96571683883667
    uiaspect_ratio_constraint_2.Parent = button

    local uitext_size_constraint_2 = Instance.new("UITextSizeConstraint")
    uitext_size_constraint_2.MaxTextSize = 20
    uitext_size_constraint_2.Parent = button

    local uiaspect_ratio_constraint_3 = Instance.new("UIAspectRatioConstraint")
    uiaspect_ratio_constraint_3.AspectRatio = 3.96571683883667
    uiaspect_ratio_constraint_3.Parent = dismiss

    local text = Instance.new("TextLabel")
    text.Font = Enum.Font.GothamMedium
    text.Text = texty
    text.TextColor3 = Color3.new(1, 1, 1)
    text.TextScaled = true
    text.TextSize = 14
    text.TextWrapped = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Bottom
    text.BackgroundColor3 = Color3.new(1, 1, 1)
    text.BackgroundTransparency = 1
    text.BorderSizePixel = 0
    text.Position = UDim2.new(0.0374130346, 0, -0.0068324497, 0)
    text.Size = UDim2.new(0.961512446, 0, 0.298092335, 0)
    text.Visible = true
    text.Name = "text"
    text.Parent = back

    local uitext_size_constraint_3 = Instance.new("UITextSizeConstraint")
    uitext_size_constraint_3.MaxTextSize = 12
    uitext_size_constraint_3.Parent = text

    local uiaspect_ratio_constraint_4 = Instance.new("UIAspectRatioConstraint")
    uiaspect_ratio_constraint_4.AspectRatio = 12.717891693115234
    uiaspect_ratio_constraint_4.Parent = text

    local uicorner_2 = Instance.new("UICorner")
    uicorner_2.CornerRadius = UDim.new(0, 4)
    uicorner_2.Parent = back

    local uiaspect_ratio_constraint_5 = Instance.new("UIAspectRatioConstraint")
    uiaspect_ratio_constraint_5.AspectRatio = 3.942856788635254
    uiaspect_ratio_constraint_5.Parent = back

    local Tween = game:GetService("TweenService"):Create(timeline, TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Size = timeline.Size + UDim2.new(1, 0, 0, 0)
    });

    task.spawn(function()
        button.MouseButton1Click:Connect(function()
            notification:Destroy()
        end)

        Tween.Completed:Connect(function()
            notification:Destroy()
        end)
    end)

    task.spawn(function()
        Tween:Play()
    end)
end

return notification
