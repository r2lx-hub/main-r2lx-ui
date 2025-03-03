local Notif = {}

local CoreGUI = game:GetService("CoreGui")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:FindFirstChild("PlayerGui") or CoreGUI

-- Tạo GUI thông báo
local screen_gui = Instance.new("ScreenGui")
screen_gui.Name = "NotifUI"
screen_gui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 1)
frame.BackgroundTransparency = 1
frame.Position = UDim2.new(0.5, 0, 1, -80)  -- Hạ thấp vị trí xuống gần mép dưới hơn
frame.Size = UDim2.new(0, 400, 0, 200)  -- Chỉnh rộng hơn và có nhiều không gian chứa thông báo
frame.Parent = screen_gui

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uilist_layout.Padding = UDim.new(0, 5) -- Khoảng cách giữa thông báo
uilist_layout.Parent = frame

function Notif.New(text, duration)
    local notifFrame = Instance.new("Frame")
    notifFrame.BackgroundTransparency = 0.2
    notifFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)  -- Đổi màu tối hơn
    notifFrame.Size = UDim2.new(0, 400, 0, 50)  -- Tăng chiều rộng và chiều cao
    notifFrame.Parent = frame

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 8)
    uicorner.Parent = notifFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 18  -- Tăng kích thước chữ
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, -50, 1, 0)
    textLabel.Position = UDim2.new(0, 15, 0, 0)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notifFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = Color3.fromRGB(255, 80, 80)  -- Đổi màu đỏ đậm hơn
    closeButton.Size = UDim2.new(0, 30, 0, 30)  -- Tăng kích thước nút đóng
    closeButton.Position = UDim2.new(1, -40, 0.5, -15)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = notifFrame

    -- Hiệu ứng mở thông báo
    notifFrame.Size = UDim2.new(0, 0, 0, 50)
    TS:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 400, 0, 50)}):Play()

    -- Xử lý đóng thông báo
    local function closeNotif()
        TS:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 0, 0, 50)}):Play()
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