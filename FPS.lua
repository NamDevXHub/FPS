-- LocalScript (đặt trong StarterPlayerScripts hoặc StarterGui)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo GUI hiển thị FPS
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FPSDisplay"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 150, 0, 40)
textLabel.Position = UDim2.new(0, 10, 0, 10)
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabel.BackgroundTransparency = 0.5
textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
textLabel.TextSize = 20
textLabel.Font = Enum.Font.Code
textLabel.Text = "FPS: --"
textLabel.Parent = screenGui

-- Đếm FPS
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    local currentTime = tick()
    local elapsed = currentTime - lastTime
    
    if elapsed >= 1 then
        local fps = frames / elapsed
        textLabel.Text = string.format("FPS: %d", math.floor(fps + 0.5))
        frames = 0
        lastTime = currentTime
    end
end)
