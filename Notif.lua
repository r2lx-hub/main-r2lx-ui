local Notif = {}

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

function Notif.New(text, duration)
    local notifFrame = Instance.new("Frame")
    notifFrame.BackgroundTransparency = 1
    notifFrame.Size = UDim2.new(0, 100, 0, 0)
    notifFrame.Parent = frame

    local mainFrame = Instance.new("Frame")
    mainFrame.AnchorPoint = Vector2.new(0.5, 1)
    mainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.Size = UDim2.new(0, 100, 0, 30)
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
    textLabel.AutomaticSize = Enum.AutomaticSize.X
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

    TS:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 1, 0), Size = UDim2.new(0, 250, 0, 30)}):Play()

    local function closeNotif()
        TS:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        notifFrame:Destroy()
    end

    closeButton.MouseButton1Click:Connect(closeNotif)
    task.delay(duration or 5, closeNotif)
end

function Notif.Error(text, duration)
    Notif.New("❌ ERROR: " .. text, duration)
end

function Notif.Success(text, duration)
    Notif.New("✅ SUCCESS: " .. text, duration)
end

function Notif.Warning(text, duration)
    Notif.New("⚠️ WARNING: " .. text, duration)
end

return Notif