--[[
    Anime Final Quest - Auto Farm Script
    Funcionalidades:
    - Auto Attack (M1 automático)
    - Auto Replay (reinicia fase sozinho)
    - Anti-AFK verdadeiro
    - Interface bonita e simples
--]]

-- Variáveis principais
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local farming = false
local antiAFK = false
local farmLoop = nil

-- Criar Interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AFQ_UI"

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 350, 0, 280)
Frame.Position = UDim2.new(0.5, -175, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
Frame.BorderSizePixel = 0

-- Título
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "⚔️ ANIME FINAL QUEST ⚔️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true

-- Status
StatusLabel.Parent = Frame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 55)
StatusLabel.Text = "Status: 💤 Parado"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 14

-- Botão Farm
FarmButton.Parent = Frame
FarmButton.Size = UDim2.new(0, 280, 0, 45)
FarmButton.Position = UDim2.new(0.5, -140, 0.4, -10)
FarmButton.Text = "▶️ INICIAR FARM ▶️"
FarmButton.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
FarmButton.TextColor3 = Color3.new(1, 1, 1)
FarmButton.TextSize = 18
FarmButton.BorderSizePixel = 0

-- Botão Anti-AFK
ToggleButton.Parent = Frame
ToggleButton.Size = UDim2.new(0, 280, 0, 35)
ToggleButton.Position = UDim2.new(0.5, -140, 0.65, -5)
ToggleButton.Text = "🛡️ Anti-AFK: OFF 🛡️"
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 16
ToggleButton.BorderSizePixel = 0

-- Botão Fechar
CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(0, 60, 0, 30)
CloseButton.Position = UDim2.new(1, -70, 0, 5)
CloseButton.Text = "FECHAR"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 12

-- ========== FUNÇÕES ==========

-- Encontrar inimigo mais próximo
local function getClosestEnemy()
    local closest = nil
    local shortestDist = math.huge
    
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local playerPos = player.Character.HumanoidRootPart.Position
    
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name ~= player.Name and v:FindFirstChild("Humanoid") then
            local humanoid = v:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local hrp = v:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - playerPos).magnitude
                    if dist < shortestDist and dist < 50 then
                        shortestDist = dist
                        closest = v
                    end
                end
            end
        end
    end
    return closest, shortestDist
end

-- Atacar (simular clique M1)
local function attackEnemy(enemy)
    if not enemy or not enemy:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local hrp = enemy.HumanoidRootPart
    local oldPos = hrp.Position
    
    -- Mira no inimigo
    mouse.Target = hrp
    
    -- Clique M1
    mouse1click()
    
    return true
end

-- Verificar e clicar no botão de replay
local function checkAndReplay()
    -- Procura botão de replay/repeat/next no PlayerGui
    local playerGui = player.PlayerGui
    
    if not playerGui then
        return false
    end
    
    local foundButton = nil
    
    for _, v in ipairs(playerGui:GetDescendants()) do
        if v:IsA("TextButton") then
            local text = v.Text:lower()
            if text:find("replay") or text:find("repeat") or text:find("next") or text:find("again") then
                foundButton = v
                break
            end
        end
    end
    
    if foundButton then
        foundButton:Click()
        StatusLabel.Text = "Status: 🔄 Reiniciando fase..."
        task.wait(2)
        return true
    end
    
    return false
end

-- Loop principal de farm
local function farmLoopFunc()
    while farming do
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            task.wait(1)
            goto continue
        end
        
        local enemy, dist = getClosestEnemy()
        
        if enemy and dist < 40 then
            attackEnemy(enemy)
            StatusLabel.Text = "Status: ⚔️ Atacando... ⚔️"
            task.wait(0.15)
        else
            -- Se não achou inimigo, tenta reiniciar fase
            StatusLabel.Text = "Status: 🔍 Procurando inimigos..."
            task.wait(1)
            checkAndReplay()
        end
        
        ::continue::
        task.wait()
    end
end

-- Anti-AFK
local function startAntiAFK()
    local vu = game:GetService("VirtualUser")
    local connection
    
    connection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
        if antiAFK then
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
            StatusLabel.Text = "Status: 🛡️ Anti-AFK ativado 🛡️"
        end
    end)
    
    return connection
end

-- ========== BOTÕES ==========

-- Botão Farm
FarmButton.MouseButton1Click:Connect(function()
    if farming then
        -- Parar farm
        farming = false
        FarmButton.Text = "▶️ INICIAR FARM ▶️"
        FarmButton.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
        StatusLabel.Text = "Status: ⏹️ Parado"
    else
        -- Iniciar farm
        farming = true
        FarmButton.Text = "⏸️ PARAR FARM ⏸️"
        FarmButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        StatusLabel.Text = "Status: 🎯 Iniciando farm..."
        
        -- Inicia o loop em uma thread separada
        task.spawn(farmLoopFunc)
    end
end)

-- Botão Anti-AFK
ToggleButton.MouseButton1Click:Connect(function()
    antiAFK = not antiAFK
    if antiAFK then
        ToggleButton.Text = "🛡️ Anti-AFK: ON 🛡️"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        startAntiAFK()
    else
        ToggleButton.Text = "🛡️ Anti-AFK: OFF 🛡️"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
    end
end)

-- Botão Fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    farming = false
    print("Interface fechada. Farm parado.")
end)

-- Mensagem de sucesso
print("✅ Anime Final Quest - Script carregado com sucesso!")
print("📌 Use os botões na interface para controlar o farm.")
