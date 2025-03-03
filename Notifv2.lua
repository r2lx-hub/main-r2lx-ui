local Notifv2 = {}

local CoreGUI = game:GetService("CoreGui")
local TS = game:GetService("TweenService")

local function Hide_UI(gui)
    if get_hidden_gui then
        gui.Parent = get_hidden_gui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(gui)
        gui.Parent = CoreGUI
    elseif CoreGUI:FindFirstChild('RobloxGui') then
        gui.Parent = CoreGUI.RobloxGui
    else
        gui.Parent = CoreGUI
    end
end

local screen_gui = Instance.new("ScreenGui")
Hide_UI(screen_gui)

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.95)
frame.BackgroundTransparency = 1
frame.Position = UDim2.new(0.5, 0, 0.95, 0)
frame.Size = UDim2.new(0, 100, 0, 100)
frame.Parent = screen_gui

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uilist_layout.Parent = frame

function Notifv2.New(text, duration)
    local notifFrame = Instance.new("Frame")
    notifFrame.BackgroundTransparency = 1
    notifFrame.Size = UDim2.new(0, 100, 0, 0)
    notifFrame.Parent = frame

    local mainFrame = Instance.new("Frame")
    mainFrame.AnchorPoint = Vector2.new(0.5, 1)
    mainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.Size = UDim2.new(0, 0, 0, 30)
    mainFrame.Position = UDim2.new(0.5, 0, 1, 60)
    mainFrame.Parent = notifFrame

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 6)
    uicorner.Parent = mainFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Font = Enum.Font.Gotham
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.TextSize = 14
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0, 0, 0, 24)
    textLabel.Parent = mainFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Text = "✖"
    closeButton.Font = Enum.Font.Gotham
    closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeButton.Size = UDim2.new(0, 24, 0, 24)
    closeButton.Position = UDim2.new(1, -28, 0, 3)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = mainFrame

    TS:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 200, 0, 30)}):Play()

    local function closeNotifv2()
        TS:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        notifFrame:Destroy()
    end

    closeButton.MouseButton1Click:Connect(closeNotifv2)
    task.delay(duration or 5, closeNotifv2)
end

function Notifv2.Error(text, duration)
    Notifv2.New("❌ ERROR: " .. text, duration)
end

function Notifv2.Success(text, duration)
    Notifv2.New("✅ SUCCESS: " .. text, duration)
end

function Notifv2.Warning(text, duration)
    Notifv2.New("⚠️ WARNING: " .. text, duration)
end

return Notifv2