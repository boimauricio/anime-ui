-- Anime Final Quest UI (Simples e Bonita)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local Toggle = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
Frame.BorderSizePixel = 0

Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "⚔️ ANIME FINAL QUEST"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundTransparency = 1
Title.TextScaled = true

FarmButton.Parent = Frame
FarmButton.Size = UDim2.new(0, 200, 0, 40)
FarmButton.Position = UDim2.new(0.5, -100, 0.5, -20)
FarmButton.Text = "ATIVAR FARM"
FarmButton.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
FarmButton.TextColor3 = Color3.new(1,1,1)

FarmButton.MouseButton1Click:Connect(function()
    print("Farm ativado (simulação)")
end)

Toggle.Parent = Frame
Toggle.Size = UDim2.new(0, 200, 0, 30)
Toggle.Position = UDim2.new(0.5, -100, 0.75, -15)
Toggle.Text = "Anti-AFK: ON"
Toggle.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
Toggle.TextColor3 = Color3.new(1,1,1)

local ativo = true

Toggle.MouseButton1Click:Connect(function()
    ativo = not ativo
    if ativo then
        Toggle.Text = "Anti-AFK: ON"
    else
        Toggle.Text = "Anti-AFK: OFF"
    end
end)
