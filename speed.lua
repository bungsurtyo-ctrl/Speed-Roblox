
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local SPEED = 50
local STEP = 5
local MIN_SPEED = 0
local MAX_SPEED = 100

local gui = Instance.new("ScreenGui")
gui.Name = "SpeedControl"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(230, 140)
frame.Position = UDim2.new(0.5, -115, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =
    UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "SPEED CONTROL"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = frame

local display = Instance.new("TextLabel")
display.Size = UDim2.new(1, 0, 0, 35)
display.Position = UDim2.fromOffset(0, 35)
display.BackgroundTransparency = 1
display.TextColor3 = Color3.fromRGB(0, 255, 150)
display.TextSize = 22
display.Font = Enum.Font.GothamBold
display.Parent = frame

local function updateSpeed()
    display.Text = "Speed: " .. SPEED

    local character = player.Character
    local humanoid = character and
        character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = SPEED
    end
end

local function makeButton(text, x, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(65, 40)
    button.Position = UDim2.fromOffset(x, 85)
    button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 22
    button.Font = Enum.Font.GothamBold
    button.Parent = frame

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 8)

    button.Activated:Connect(callback)
end

makeButton("-", 15, function()
    SPEED = math.max(MIN_SPEED, SPEED - STEP)
    updateSpeed()
end)

makeButton("+", 150, function()
    SPEED = math.min(MAX_SPEED, SPEED + STEP)
    updateSpeed()
end)

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = SPEED
    updateSpeed()
end)

updateSpeed()
