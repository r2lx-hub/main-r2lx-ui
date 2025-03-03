local Notif = {}

local CoreGUI = game:GetService("CoreGui")
local TS = game:GetService("TweenService")

local HIDEUI = get_hidden_gui or gethui
if syn and typeof(syn) == "table" and RenderWindow then syn.protect_gui = gethui; end
local function Hide_UI(gui)
    if HIDEUI then
        gui.Parent = HIDEUI()
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
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
frame.Position = UDim2.new(0.5, 0, 0.954999983, 0)
frame.Size = UDim2.new(0, 100, 0, 100)
frame.Visible = true
frame.Parent = screen_gui

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uilist_layout.Parent = frame

function Notif.New(text, timee)
    local frame_2 = Instance.new("Frame")
    frame_2.BackgroundTransparency = 1
    frame_2.Size = UDim2.new(0, 100, 0, 0)
    frame_2.Parent = frame

    local mainFrame = Instance.new("Frame")
    mainFrame.AnchorPoint = Vector2.new(0.5, 1)
    mainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.Size = UDim2.new(0, 0, 0, 30)
    mainFrame.Position = UDim2.new(0.5, 0, 1, 60)
    mainFrame.Parent = frame_2

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
    closeButton.Text = ""
    closeButton.Font = Enum.Font.SourceSans
    closeButton.Size = UDim2.new(0, 24, 0, 24)
    closeButton.Position = UDim2.new(1, -28, 0, 3)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = mainFrame

    local closeIcon = Instance.new("ImageButton")
    closeIcon.Image = "rbxassetid://3926305904"
    closeIcon.ImageColor3 = Color3.fromRGB(200, 50, 50)
    closeIcon.ImageRectOffset = Vector2.new(924, 724)
    closeIcon.ImageRectSize = Vector2.new(36, 36)
    closeIcon.Size = UDim2.new(0, 18, 0, 18)
    closeIcon.Parent = closeButton

    TS:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 250, 0, 30)}):Play()

    local function closeNotif()
        TS:Create(closeIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
        TS:Create(closeButton, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        TS:Create(textLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
        task.wait(0.17)
        TS:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        task.wait(0.05)
        TS:Create(frame_2, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 100, 0, 0)}):Play()
        task.wait(0.2)
        frame_2:Destroy()
    end

    closeButton.MouseEnter:Connect(function()
        TS:Create(closeButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.8}):Play()
        TS:Create(closeIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageColor3 = Color3.new(1, 0, 0)}):Play()
    end)

    closeButton.MouseLeave:Connect(function()
        TS:Create(closeButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        TS:Create(closeIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageColor3 = Color3.new(0.784314, 0.784314, 0.784314)}):Play()
    end)

    closeButton.MouseButton1Click:Connect(closeNotif)
    closeIcon.MouseButton1Click:Connect(closeNotif)
    task.delay(timee or 10, closeNotif)
end

return Notif