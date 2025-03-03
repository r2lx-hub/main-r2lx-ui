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
frame.Position = UDim2.new(0.5, 0, 1, -100) -- Hiển thị dưới cùng
frame.Size = UDim2.new(0, 300, 0, 100)
frame.Parent = screen_gui

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uilist_layout.Parent = frame

function Notif.New(text, duration)
    local notifFrame = Instance.new("Frame")
    notifFrame.BackgroundTransparency = 0.2
    notifFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    notifFrame.Size = UDim2.new(0, 300, 0, 40)
    notifFrame.Parent = frame

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 8)
    uicorner.Parent = notifFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 16
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, -40, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notifFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Text = "✖"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0.5, -15)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = notifFrame

    -- Hiệu ứng mở thông báo
    notifFrame.Size = UDim2.new(0, 0, 0, 40)
    TS:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 300, 0, 40)}):Play()

    -- Xử lý đóng thông báo
    local function closeNotif()
        TS:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 0, 0, 40)}):Play()
        task.wait(0.3)
        notifFrame:Destroy()
    end

    closeButton.MouseButton1Click:Connect(closeNotif)
    task.delay(duration or 5, closeNotif)
end

return Notif