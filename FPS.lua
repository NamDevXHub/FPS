-- LocalScript (đặt trong StarterPlayer > StarterPlayerScripts)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

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
frame.Position = UDim2.new(0, 10, 0, 80)          -- Ô trắng đã khoanh
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = screenGui

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Viền vàng
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 2
stroke.Parent = frame

-- ===== Label (chữ trắng) =====
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextSize = 20
label.Font = Enum.Font.Code
label.Text = "FPS: --"
label.Parent = frame

-- ===== Kéo thả mượt =====
local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

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
