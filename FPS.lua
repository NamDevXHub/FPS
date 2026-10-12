-- LocalScript (đặt trong StarterPlayer > StarterPlayerScripts)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- ===== ScreenGui =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FPSDisplay"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- ===== Frame (nền đen, viền vàng) =====
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 130, 0, 40)
frame.Position = UDim2.new(0, 15, 0, 15)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)      -- Nền đen
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Viền vàng
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 215, 0)             -- Vàng gold
stroke.Thickness = 2
stroke.Parent = frame

-- ===== Label (chữ trắng) =====
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)       -- Chữ trắng
label.TextSize = 20
label.Font = Enum.Font.Code
label.Text = "FPS: --"
label.Parent = frame

-- ===== Đếm FPS =====
local frames = 0
local lastTime = os.clock()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    local now = os.clock()
    local elapsed = now - lastTime

    if elapsed >= 1 then
        local fps = math.floor(frames / elapsed + 0.5)
        label.Text = "FPS: " .. fps
        frames = 0
        lastTime = now
    end
end)
