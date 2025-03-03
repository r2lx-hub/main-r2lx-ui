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
frame.Position = UDim2.new(0.5, 0, 1, -60)  -- Vị trí thấp hơn một chút
frame.Size = UDim2.new(0, 250, 0, 100)  -- Kích thước nhỏ hơn, phù hợp với script gốc
frame.Parent = screen_gui

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uilist_layout.Padding = UDim.new(0, 4) -- Giảm khoảng cách giữa các thông báo
uilist_layout.Parent = frame

function Notif.New(text, duration)
    local notifFrame = Instance.new("Frame")
    notifFrame.BackgroundTransparency = 0.2
    notifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Giữ màu tối nhưng nhẹ hơn
    notifFrame.Size = UDim2.new(0, 250, 0, 35)  -- Kích thước nhỏ gọn hơn
    notifFrame.Parent = frame

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 6)
    uicorner.Parent = notifFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14  -- Kích thước chữ nhỏ hơn để phù hợp
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, -40, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notifFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Text = "✖"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = Color3.fromRGB(255, 80, 80)  -- Màu đỏ đậm hơn
    closeButton.Size = UDim2.new(0, 24, 0, 24)  -- Nút đóng nhỏ hơn
    closeButton.Position = UDim2.new(1, -30, 0.5, -12)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = notifFrame

    -- Hiệu ứng mở thông báo
    notifFrame.Size = UDim2.new(0, 0, 0, 35)
    TS:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 250, 0, 35)}):Play()

    -- Xử lý đóng thông báo
    local function closeNotif()
        TS:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 0, 0, 35)}):Play()
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