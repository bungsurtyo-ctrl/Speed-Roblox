
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local SPEED = 50
local STEP = 5
local MIN_SPEED = 0

-- Membuat GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedControl"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Membuat panel utama
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(230, 140)
frame.Position = UDim2.new(0.5, -115, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "SPEED CONTROL"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Active = true
title.Parent = frame

-- Tampilan kecepatan
local display = Instance.new("TextLabel")
display.Size = UDim2.new(1, 0, 0, 35)
display.Position = UDim2.fromOffset(0, 35)
display.BackgroundTransparency = 1
display.TextColor3 = Color3.fromRGB(0, 255, 150)
display.TextSize = 22
display.Font = Enum.Font.GothamBold
display.Parent = frame

-- Fungsi mengatur kecepatan
local function updateSpeed()
    display.Text = "Speed: " .. SPEED

    local character = player.Character
    local humanoid = character and
        character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = SPEED
    end
end

-- Membuat tombol
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

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button

    button.Activated:Connect(callback)
end

-- Tombol kurang
makeButton("-", 15, function()
    SPEED = math.max(MIN_SPEED, SPEED - STEP)
    updateSpeed()
end)

-- Tombol tambah
makeButton("+", 150, function()
    SPEED = SPEED + STEP
    updateSpeed()
end)

-- Fitur drag UI
local dragging = false
local dragStart
local startPosition
local dragInput

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = frame.Position

        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input == dragInput
    ) then

        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input == dragInput then

        dragging = false
        dragInput = nil
    end
end)

-- Saat karakter respawn
player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = SPEED
    updateSpeed()
end)

-- Jalankan pertama kali
updateSpeed()
